Return-Path: <netdev+bounces-294278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bGCkAJD7HmqnbgAAu9opvQ
	(envelope-from <netdev+bounces-294278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DEA62FF51
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:49:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Q/VzEoUv";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294278-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA2C13029D26
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E53EC2FF;
	Tue,  2 Jun 2026 15:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E336215E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:45:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415139; cv=fail; b=Y51v2LPPb8i27F5Dim/FfxKkDNAEccyapdZ68wT4yWlwAphLWrxYH8K82i2p/fisxjqe1KzMMmBq89lLF3Kz2UuzDBwoXIePUKpG2UyirqSnlVUyQTyaK0eU6PXiuEulAaybYERU+U94ZRFNrEvM/33E8X1IvdgY+xMO66qpG8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415139; c=relaxed/simple;
	bh=vdkcMVG/TbkbsGnUiRMFp85prga/UoGlrNR/pPwoqM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KPCW20byu2HldSF5YJdvZv0wLSneo7EYAWdcncHylnpnquzoGmjfJjcAjZ3apz5MVGmz3LE1RkOxrDQ6i4/GbkFmFsy9mZUpmxCr/5CDGQnT0a3RPSESeLddC54yjd4MwUiVYb1UctGL/p5P/IKIW4vFQ9lw4yX3uJ2ZnDBZnjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/VzEoUv; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/l+vc/l37wIJRQ44+fkr7IZZBVxzM8P1Xi8dIzAjqa+UVZ3VkVtNrv8oWcqaLSFxGFH4thL3NfLVo0ckKw7mjWIqdOeCneqbeTyWZuC/julGVB5N8EUdMVqFThvrpaHvWRyCgvG3B4L/OfONd9mH0spRINP7quLbFxryU6tQrShxRpHLKIhWqEG7VFHZHGbS8K4Sz3VJkbGKPp3hAqDq50nlBhaRCcLBD4+IB+zA/8ujlvi1aHi5Qioo1TIroahEghhFG1O5WphfnPZ0h4Vj5rcy2WvS7YUKOewVPXxb0SSqHRhdRqaYMIQTwxNn4m49B2HToWPjoy1qG3BogmUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6V5kjNCRVdqRV1XkjoO1Lc8lVVQ/CnV7XFEbiHatYA=;
 b=OFwpDfqw2z0hd85U8IU8lgE/ueBr7ycFNgE6EfqHQSsFFcSSbTzudxzYiqFcnXKUatlXWtplaLoC6ZQxOI1prBP7khB+ctJiNYFK6abR32WlNcU/9RlLXw3b+183thhC9uSCj/L6CjNxzHnCECOpAtBCfdZ85OYLkC54W5q00vVDs1gg6x2/mHbRL7BznkiKq/aTO0rtX8d4lQc1Rw43VYvdGNOqHMdMuScSjKZUGwIqUfo0FjodNRYAJg2+2SkgamTSCoRTVIAKAokYuFgjS8yhxzXYMlpqCanj80hiXQV7jNGSplg7hDM05R/O0aIDIekx9UBU376hYo4OSzFwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6V5kjNCRVdqRV1XkjoO1Lc8lVVQ/CnV7XFEbiHatYA=;
 b=Q/VzEoUv6nzfkZuG1GC71njHRNCJ5YbkBsLsDoQy/IZWm8iuPQnJjuNnJFeB37pX49LqHD3LoO+An84LXe8RvhmUzsrA5jyM9HfUXhpIJPStFE6EweQ1O1ki4MA1t5d0Yak6rwT9lqPfShLjyr04bL/D0dkmg7Va61osDldNCzCMrV0vVulMv2CHRSUjfWZku/wu/3SM4dMpny2bL+V3FX1qH8NRvo03noD1Qm00fpLajI/9l+NqmKdbRhXXUvwiubpmo1r1cSmznN1VavezQNd5tqn2UMw6AjsSgtH7zpyKpzIEY4ahHtm49o6m+zD47CrMNtEYrug0osUiVEO/Rw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 15:45:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 15:45:33 +0000
Date: Tue, 2 Jun 2026 18:45:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	andrew+netdev@lunn.ch, kuniyu@google.com, jlayton@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <20260602154523.GA537996@shredder>
References: <ahveCu-zzFlpeVut@v4bel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahveCu-zzFlpeVut@v4bel>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f90a543-bbc0-4f5d-4a4e-08dec0bdfb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	N5IPHkdYiTI7VdbjCQb7D+pCgeC8IbEvu0Ch1hLk59OoBkZyrnZ0pu+07vveqw9EqDKg9jsn6IYen5/cwHXYmqWARrYd6yiQvXt9gV/FGuZ+LvpL3gNBW/LIw8/tQJ/WZcf3pVgTEa3qYycLPHLR0dpNAS2tropSMrDlAJLV9+xFLwFs4XCMLdxNUCcff8lzHtwSKU6P7BO1+LdxBbn4W+rj7CIDAMvsuV1JOmcDQPRn+udjIrizX3cQL6T3gTuKcZG7FseLBzBTxc5q+FRyJV13b5ARP3PNiJylqkqMiXWiYHotXZ5I3Rgx60b0wa2vh3nQwryJv2hQhyiEDWK8qVxb2liOJmmFBU2SWLTTK6ib5oZc7zPQEAVqMiwTF44ruPQCj9Tl64eoUcjnTY9/CeJr+SeZ2EB5gKLYnzcAT/lU72hZyJBPdCaZbfaj8a3uD4SBNUkFPgCmsmQ4GtyJWaIRZeP212wl7YogHGHKCNr0XMnh3v+moBDqqcx9mf9MUDD7Y6paI899O2elIZiyzmDVqxPz2w7hvYvAwifWDjwjcjBmX9Z1NYnWkuVpeptl2B/hlaUKJjyoH+7rTSuPTjBAAuJjlJ1GmJKPezsVp7Uu3qT8KlEDmZ7ZjQVx0t/6kQfh/tVNdb6gl274wKytEpJrsIYIHpoxxzOAd6PqblXGaYC/Yq2XyY2VCckBxSd9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qnr+ATE8NfePrEaDOFyYB6K3PnTZy4MJLBpzD9kPeS/RyIizXDQs58Sf7lXB?=
 =?us-ascii?Q?K5QlEHh/eRQJrqJenlER4qCndeav6BDxDUdZzNkw0kgkhd4D+YQJt1GY2p54?=
 =?us-ascii?Q?RQRjch8THZYYUsQC8/qkvpzNe9PRv0YnjxTbD51yIeM8HOrVpv956Gg58Vuu?=
 =?us-ascii?Q?XJhZgTATra55sQhxEC9fNlhXwVycc9Z6yDGbBEAwdkiFQsw2/oFHrEEWVa2G?=
 =?us-ascii?Q?lBSZ+/jjoKIhQnQJmhBZF+N7VbHNSF858lpfliorbU5O7pIrr9SeIBG9odwe?=
 =?us-ascii?Q?v3mqZLCskJ069GFbjP56tMI2yHtDkRms9RCSyotrZK5ntMcrW+hRW+7x0Cgt?=
 =?us-ascii?Q?nMOwdgaSVEWbnugYk8/9jtJhO/9qwNjiIQ2L1SVx4tAT+TyOFVtBe5jI72yS?=
 =?us-ascii?Q?OJ09Pa6m5inmXpahiSaS3kustM/PXIkQWGPf7sm8d9Zxcmd0jBUP0SXH/obc?=
 =?us-ascii?Q?WtUXZB/5gLRFKiIuqhKSnoisIKh0ntUsQ6Lf6MKzj/mJgFs/3Wgn1T8UtV23?=
 =?us-ascii?Q?C38O4TFIFDt2WLFSWeTpjLVFFOkw93kZZ8TtS79i+g+rD5DwYWkfSQ9Q6BE/?=
 =?us-ascii?Q?TjDlBtQpU3yDhmUde5JTkMeT5xXEqM/9ndKB4Yx2uoZIzt21xF5Ps1TvUwR2?=
 =?us-ascii?Q?QIZhM1ByzTjlsZYmQ9BkBNJzyJbZpJ9f+Z8lL1yKT5pkxa/YdHSJ3sHyuE+8?=
 =?us-ascii?Q?Nu4id4p3USp3HCfreDsUCk+c+09CN5snefJrXufafRYE2Px5DRohmPeiR+0D?=
 =?us-ascii?Q?ksAOjaHIqCC1tVQ23eLIcoQx1pwQCJzqXRG154VGBdLdVNnjOAxLtvzJbgFC?=
 =?us-ascii?Q?tsXchHLJGHmQJU7j8otya1skqqp0DrrjXrJlbA8GZQDa8c6FrkPopvnMM/mm?=
 =?us-ascii?Q?FHAQSqD6KbqpGgFsiya3YgN8QNSpqMWSLkTUEm4lc/hAqVid2KtcFIM32cmj?=
 =?us-ascii?Q?m24N30kNkUHp1QrAfospEMNYfFwB/kUpPh2rrQPcSSRVwPhKuvJSHVXDRXBl?=
 =?us-ascii?Q?QT0BTjPsb/ku/C9NHE8uF6jbDttOU0VLXkFK7PLi8zt9MNPvsH7FedKlWrE4?=
 =?us-ascii?Q?2uAS8MSr1ao4/KXr1L4N8qlZkRRcSFGjU9+r+ZhsIPP/p2maWOxtEDYmo0fg?=
 =?us-ascii?Q?v3j7AHpzbORh8CPmrt16fiPTHubWmtTK/V05MJfiToTJzM+vbPi64eh55isU?=
 =?us-ascii?Q?JlX4RUP+e6SN0MjzTgbctk0iIXaG8Ghp51cTK2V/tXCOhz8yGd06dDjG7/Av?=
 =?us-ascii?Q?7hMkyuXPTS3v4zydSrmyKQEii/LIy688LN1C+X8I9Y/ADipQW/EYTFQpG9+g?=
 =?us-ascii?Q?Z2PrVfDSXt5MrgzHwf6EnAh4T5PmEwx8j8eh1XPsu5rVXQIlFmYsNZMQNViR?=
 =?us-ascii?Q?yfd6exmYmeelHTGPIIWyJoQ/VpwboXDhzZWqBybwFhF25anGScwN/E+PzqiL?=
 =?us-ascii?Q?Dn5tv/9vFYxM4TKBZLYDW+KGoepX45F1XSAUnj+faX/13+pU5eH8EiJCOWqf?=
 =?us-ascii?Q?KxEHhmlNV4K1PT4TcjLvRvixhuHtqUkESAjuIlkm6cXq+mRXbwodQohP4vv5?=
 =?us-ascii?Q?6Y2unCoBb7pXv4TmqN7t0RyFxIMbZCIbdfJ8RMPtozvw3TJ6DYcjiNxklP5C?=
 =?us-ascii?Q?1BNu/gDuMjaRUKyg3YWTIb5VMmtTVRwCZqjh5JGQDFn8vXupqX3fpel6kGui?=
 =?us-ascii?Q?uRnOi8h0cLWQJaIZ6UaAo0mCHzJMUnDfUk12if55hT8ZvkH1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f90a543-bbc0-4f5d-4a4e-08dec0bdfb1d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 15:45:32.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBuWA8OuwDChpto518jPHtUGs7LZo0y5kocmiRJUUhtXH6zKgAvIJOfSlpkpq7FFRzXlJ8UQqaVRrC4Vlz4TCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294278-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6DEA62FF51

On Sun, May 31, 2026 at 04:06:50PM +0900, Hyunwoo Kim wrote:
>  drivers/net/vrf.c       | 16 +++++++++++-----
>  net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
>  net/ipv4/raw.c          |  4 +++-
>  net/ipv4/xfrm4_output.c | 13 +++++++++----
>  net/xfrm/xfrm_output.c  |  4 +++-
>  5 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 46209917ae4d..e9a1dd961805 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -833,17 +833,23 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
>  
>  static int vrf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -	struct net_device *dev = skb_dst(skb)->dev;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	dev = skb_dst_dev_rcu(skb);
>  
>  	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
>  
>  	skb->dev = dev;
>  	skb->protocol = htons(ETH_P_IP);
>  
> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> -			    net, sk, skb, NULL, dev,
> -			    vrf_finish_output,
> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +			   net, sk, skb, NULL, dev,
> +			   vrf_finish_output,
> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	rcu_read_unlock();
> +	return ret;
>  }

Patch LGTM, thanks, but what about the IPv6 counterpart (vrf_output6())
and the other similar existing issues that Sashiko is flagging?

