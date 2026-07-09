Return-Path: <netdev+bounces-306273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Tt1Aq+uT2rMmgIAu9opvQ
	(envelope-from <netdev+bounces-306273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:22:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D117322AE
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=etkiD6cz;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306273-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306273-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 046F53080B32
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3D328610;
	Thu,  9 Jul 2026 14:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F13242BE
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:09:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606157; cv=fail; b=DWvFjvq0VLe6p8VDJj3M/DENL6oqHaakLXGeYDZQO6ijsLN3VDwMcAwExsAzxM2fppfH7wFv/zkYo+CTle/zVG3OUd8DbplBdDddPX67R2PN1bUBq1GyJPvSV3ddL9fS4FIEJn62Msgr603ggWQmD41XS2SNmA0ECaIf9wcZhnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606157; c=relaxed/simple;
	bh=Q4zC2isylFatORufT4G2YVE2CEdvm5tRiuCCOhp1wNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZgoGQgMT8SUmRbttbBX/VqPmiXkPlr1R8urs6QqWubKbcTEbfu6Sz2whyxubgq9WBBDDCBP3SZgXrcBXUrcoiXuvPgwemdgTcAuHgTtdcRzvjC07CCnsbiFlaIXfkxjZNaZyCRvGtEJWwiEtWja6StLbr0N4Zq+cx0T5pa3UEz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=etkiD6cz; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZNz90l+EaOqkEGUEJ51Pd2uV21/r5kJ0FfAN9suj0I4I+gkTvTlhYVUeXKf+FBdzF5la7MV1l6/puV/NBo2NieMF1BM07yen+g7lEJCqgRBY/8+frrVXvSG65uGedhxhUE2x9retdGvpyRlG9ElX2U3Dl85uBge457tXKQwvVTj3oI5Dmw1rBV1Hg7YinDk+pw/bfhC1HPUo3aZHhF9gZyPhksXcJ1Et4+SxRMBZ6Dk5gIuovAM0sDRBK4Wbp82w7xc2RcgMOgVGIlbHMGi8b9k5UTMCTFygVCPrH+xQWSGgbjNavwv5a10LyjTb9YBsDW4WHqbsO+GAX5VU3lqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DEv0TLLK6zUKWxDsnMaVKqIBLIImPHl0nJUAcFxsRM=;
 b=g78uSQTv9UuHXqE1vAv6nhtpIRfjWuecsEA9Bkn2gJTTR/Hi1O9BGPh/Yk0Ccy6ds6eTzF0nb0n2Vxsj/Aj0k9N5GznAkB+3y4BbhN4DE85tyb+cAvKv0BQ8SlnJAiApn5v6CyNVRKQxvm/8sQmPTvXwnYcNOltuDqH13/jDYEUqsC6X3YmFbs8vG6qfX2fGqRpHJF7VziBRsjQ8/kwBIGCMQOJ8xNgcUxF7Rn5QzvP9Pgzvr9B/8wuneYnBQuiJ7Ividdvwoj+r1z8Onrm4qDfCL7LLlDqqdWbED174F/L2OwlRN1TWA6R77+reiZBkWLgEh6l7TmiJb8oi54rODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DEv0TLLK6zUKWxDsnMaVKqIBLIImPHl0nJUAcFxsRM=;
 b=etkiD6czlxMkWiF25OVwXFSWnDdGJpTQiWN+UE1S9vQvsAI2RBIo61y6eEF8+98v2LuR1fH5cDS1ExtjRxUslP5nt0racpW+ma18NkTnTb54E25x6BTIUNzMw526CZQ2rnthtmgF/pVbH/oUPSTlEPt7s+fK9JVcc3K18Hft46NJnf5R8CQPzkblBbCx7dOif5dlNhnzBCA512KjPKXjNlfGBD1YDinB9qk7b5+HeGHz6JZmorCw8CYCTJSo0WBYkXci/eTEq8Gzqmc5jw6CgIQ7n4nEo6W8eZJBC02nkrpHgnIVdr9arOb7LIsn3Dq5OL7/hSqYOnAy9AdNOTrOQQ==
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:09:04 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:09:04 +0000
Date: Thu, 9 Jul 2026 17:08:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, razor@blackwall.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] bridge: mcast: Fix a false positive
 lockdep splat
Message-ID: <20260709140846.GA1679019@shredder>
References: <20260708122820.1298718-1-idosch@nvidia.com>
 <20260708122820.1298718-2-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708122820.1298718-2-idosch@nvidia.com>
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: d144d8ec-feff-469e-3804-08deddc3a1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	vp3ldlOqzZ397w+/AdoutgOMaiaeupxBiX4edC2aBlbUOgsiQyjDtRvgX0xFiolHaXshIypoHoNwhaW1ZcXAGO22+nbYVBeM3dr3CMVYXRxu33fgSyc7c0NiQLyTMpN1ZYtFco5UAsNTHVGyP2p5O+PWcfxcEHlHFkV5Y90ZN5x7SVlATN3stvA92pj/6Rde6C6LAQzDFvnfLQg0BWF214u7p0B4/9gg4SMwRY10D6cDYF9G8Xs0hmsZInRsv4vRfHY36wv2Fqxv77tBJZrMo4nGFjhLzheKyHbh0+Xaj1xvFcVwafLkQ719emyWECK+uniBIaDTE6/x4Un5rzQnp7Ptyv8opWwYTqaf2uJ9QHVBhz3vn/KOzhffcn+QjOWTzaAGXWCx1q6xfnnCVIN3g8KP+7K7hiC3O4ZTe52h0uKqwu+sD+cju1rCAfBXBs6m1GtuvY9QcMHCHwP+PgIazptgCKOQv8SlhopljihPqrPnQD2OLl9K5qpOJt2s4ErioCcOu7gIbc0jjfhrX6EIBRaITeuscz4Pb8jgMpZaslR0EoUpZHNHQELcp+vLubShi3pB++bFR2A5g7z79OAp46AiwM7wh/UMD7VDoqvrRJ0zHNA1c0PZRzwI7/IABv2GJNYIuu9MDQsA+/WhN0H+2neZGy2KNO4I+q1qkIfQyS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lB2/Ngddcw1GbVCHnbgvP2jePNrUgS6PnbXKFhpYpHff+ZGRJKc9ueZXzpai?=
 =?us-ascii?Q?YPzVR3Cxlu9vXQqK0VnXqES8/4d6BYVwoMSYCXuWvRM8nW2oD+Emt6nmdr/u?=
 =?us-ascii?Q?3SJfRxM3xuM4oAtbwNf6X8veOoYXVvc6Cgc+Tg//KEjKbhMC1jkC4Wov78hH?=
 =?us-ascii?Q?sJg/rOfy7c+6nStwtuVJMtN4khPgvDEfa+YtE6TX0PCk67QLQgAp7vHtr1od?=
 =?us-ascii?Q?NEknWpmcZxB5T8KtTQpN9ZMKLLKkBt1VSS1jWhm/z0rl3iQC9vZwLBiqjUqa?=
 =?us-ascii?Q?r/IQH4S5jweJTnkbcVkS2mHpJXU3L8LSA3AE9oJLk7vydMkQelXcOsMnQcFb?=
 =?us-ascii?Q?fh4RaD7TmwyJo9dZKKYtEh11+2D4kd6XzpBCKFKgxUD+7EAmaH9jiccKN8Rw?=
 =?us-ascii?Q?X2zax9iU83wkfkRxoF+PJwzWxDvfItZj2B1qQuPgsS08pTBIxzvdSQAikXWV?=
 =?us-ascii?Q?+4CEtEllyVlQCHRwZxrFYZIsxG8az8iiWLLgo70gkG0QaBhIYUM3r23cTuUO?=
 =?us-ascii?Q?JirGpA5tMXVjDwm5YRbhI/Fm3QXpAnZWJghhqbe6W/x4NYhP1+EwqKfYOfos?=
 =?us-ascii?Q?gG9D0cerr79LDBfB1f8X+Glv76KMTw/G9I5E02OrT5XLGURWx45G59ko73gi?=
 =?us-ascii?Q?U04CFGRFh8dUsh8Cub5Oh53rqIw8iBrGpa149kDAIerK/uckS901tsIlRyrj?=
 =?us-ascii?Q?JUirZl/lXRMv9oYdQnWRi3+oWX6Cw+pKr3rrRk/YNPnY7nP3iA7bbN1TYS6U?=
 =?us-ascii?Q?3Ux4KC3Aa0Jchcy4Nk4HJDyVQrwTP+FyCK5vKOXScgkcKtGVJZWNCZXYaGcZ?=
 =?us-ascii?Q?8+epgpuljDY5RNK6EJEf0ZsEgaXpXtlBdj9AC/V2YvUcBXW8MnRN7koU+EOj?=
 =?us-ascii?Q?HLAsGcfbbZHGMWbLp7Bg85N06pP8yZ975sVZtr9zzQbWaFH8f3eo3mneKz3X?=
 =?us-ascii?Q?crAMV0A8l38J8y9UsgMMtf6e5QzN9jif3FgrpNezj2NfnwEQwPDq22THkCOd?=
 =?us-ascii?Q?cZiUkJFHoP6D3iJLEiGWQvHFxLWegU5XrmNJCpFNLMnrgkwE26m/mVRVnXAz?=
 =?us-ascii?Q?mgZ6g4osDCG6sunsESs66GhczskA8w3cM5DIg2aUkTRiYH3Um5qX4gm4+QYJ?=
 =?us-ascii?Q?p80ulRBByHr3k9TgGofRyVWWAN5S57s/nzwqSPYA0tb5CYd44tL/ZvRW/Dyn?=
 =?us-ascii?Q?pJ5+/E28oq4O6KoHY2c7TbCu0FMAM1ow45sAokPkUrP2yJSCDZP3Dk9aVzlW?=
 =?us-ascii?Q?MM8snTuPvPuJ38jswwZ2z1yKJf+SdlGSdIcMIaH+vn1OuHqGuydsQOSfh2Qu?=
 =?us-ascii?Q?/awKjWSdk11O1tleDLJaoUdtK+gd+71LJIq8yemQJw+hDNbqW/8ZEZZdg/qY?=
 =?us-ascii?Q?K3R8I+asdAyfIJ/YKWWp36b1ZHeit/4jm2JEaqCL9m6+NQ4cYPdIfQVXkU37?=
 =?us-ascii?Q?DUr9rBNu7HOnNVS11aT9uvCdXxQoqzy1kD3avVzq5ei5vIl0cKu9yU67GEQV?=
 =?us-ascii?Q?D4cm1efAHtuVDkv9hFNCRwXr6jg639SniyYVhmuuQCkRoyxfxtSM0hi6uuL9?=
 =?us-ascii?Q?ryTTh+gYE7QWwR0IcwM71IYavtz+7yMVaSQfy3E1U2JOHih6Zs/tn192C/Hd?=
 =?us-ascii?Q?rfos880JgF9N624FHUGipHNz5JaGwPPqZDQIfCepMeKEdAWoK/mk5IjOqJVP?=
 =?us-ascii?Q?NzK2QE4M9WV5+3acscTnZCC7eqsTyt1Rj1SLdVdIGiZLSLlJ3UTv4CS2xdC0?=
 =?us-ascii?Q?p6oHKZa/Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d144d8ec-feff-469e-3804-08deddc3a1ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:09:04.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7eWY5D8odhuDN/ajsVUjq+JeXmwlvD6zMGu/fC5eziyGTrTRBqBvuh5wXIbwpmNjn7KZMzDU0eFTdPp4u0T4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:razor@blackwall.org,m:petrm@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64D117322AE

On Wed, Jul 08, 2026 at 03:28:19PM +0300, Ido Schimmel wrote:
> @@ -1783,6 +1841,7 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  				      u8 sflag,
>  				      bool *need_rexmit)
>  {
> +	struct sk_buff_head *queue;
>  	bool over_lmqt = !!sflag;
>  	struct sk_buff *skb;
>  	u8 igmp_type;
> @@ -1791,7 +1850,12 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  	    !br_multicast_ctx_matches_vlan_snooping(brmctx))
>  		return;
>  
> +	queue = pmctx ? &pmctx->query_queue : &brmctx->query_queue;
> +
>  again_under_lmqt:
> +	if (skb_queue_len_lockless(queue) >= BR_MULTICAST_QUERY_QUEUE_LEN_MAX)
> +		return;
> +
>  	skb = br_multicast_alloc_query(brmctx, pmctx, pg, ip_dst, group,
>  				       with_srcs, over_lmqt, sflag, &igmp_type,
>  				       need_rexmit);
> @@ -1800,11 +1864,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  
>  	if (pmctx) {
>  		skb->dev = pmctx->port->dev;
> -		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
> -				   BR_MCAST_DIR_TX);
> -		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
> -			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
> -			br_dev_queue_push_xmit);
> +		skb_queue_tail(queue, skb);
> +		queue_work(system_highpri_wq, &pmctx->query_queue_work);

The issue reported by sashiko-gemini [1] is addressed in patch #2.

[1]
"This isn't a bug, but it looks like the local variable igmp_type is no
longer used in __br_multicast_send_query.

Since br_multicast_count() was moved out of this function and into the
workqueue processing, the value returned via the &igmp_type parameter
from br_multicast_alloc_query() is no longer read. Could we clean this
up and remove the local variable entirely?"

