Return-Path: <netdev+bounces-289541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HBxFTqbDGqUjwUAu9opvQ
	(envelope-from <netdev+bounces-289541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3275582EDD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 838B43091A28
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396E3ACA54;
	Tue, 19 May 2026 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFak3bWq"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0E30FC2E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210918; cv=fail; b=IwO5e4xNnyLPLjD7vb8hlIzywuBvkXjPD+Uhtnj5xwCs9lYxplGQ4uGd2jfR2D0Ojg+Cl5GjHLl5nntbiiraw920VWVi5CMhWk5LcBXeF3hY420c17rKRShAGhF2JxDzmfnqL7pGr6z0ABHc9u2okDYUsO8fRu+feNTLmnh2Xp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210918; c=relaxed/simple;
	bh=LpxT3cLdeCJ0BUysaWmhKXyvIyK7KsF9Ekfw6qVLIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M9Cc+Qh/ARhwHsnfBd6r2HxiCtKEvklcrVzq/VY0AiugmS5E14Xi45c1Pn7JLUT9IdLyE7s4LulmAyZV7XXrMOPSuEco3NRB26lzyFRhwMjQSfW1xa3GDPcOh6SN8dwb00aXr6btjJ8A5zxhSUqDirk8svzMRE57S/5ls7iY2HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFak3bWq; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTu8dXd8WfGx2FcB3uJaMMoMYS5DMBtT9tE7Tk08xAQ4efFE+z8hJ2ZuDr8JSzw16l31U/ibHms23kJxefsavPZuTeWGYUAfviX6lI1V8NILsW5c4X+MNUml/ahDK8ulTsA5oNBH2nN5iRP86iwZU/84VFsHXhRVdWJRxss1RiZgC45Z5mM2hxzME1TQ2Il4a1FWnKo3BsZQlfpMivds9DXFIJnCh1Mg7lCYeEeyE++EWU8G4m64Z6ra1d2ICM7UMyBCaPiOMKy58piAh7ScAVEQVa/ci+OsDpv7+X45RwlZe3FZDl+qQPwbWqfFGJ6pRcpqNmdiCGSZ+6IYntxZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlKby9SiA2H9j2O7x0lxAOpvJxVx822EORuUoE49+tY=;
 b=IN+MzqVGpUWRnPMRLeoVb0cGQifHkdSZe3nrqXdtmeKuAeBtW6rPfdvtDYwPkddSTO+znaIp2q1WyomGwxrVi0N1eM8IdXfIgsj5+oZyy06iZPv2rJzWx0Ntikdrr3emmsH2IEQ0jGReCJxTlaDISnjRQ9PgRjku6lDkHKx38/MwYqqn9EaDZA5V7R7y2tulgL4+301ziMiUL83ThgFdPwMGJ6R8rqNBCT7LbEA1qYhzQLgQG7aI4+EdTds9o3xEKLudGdfOSu/IQZoYdFwltS6+1ajMHcg6P/8lZvxwc1M4Ai+U/PEaPCo5d8eP55+PKAiJM7gsGFidaLd5uh689Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKby9SiA2H9j2O7x0lxAOpvJxVx822EORuUoE49+tY=;
 b=UFak3bWqpy4aoJcdt1fxsvT40JAokqOdmBX2JGL00DgxAWKZgRzjazJw/tBCH8iUJ/LjSt64wsmJu01g2nosln0G6FDdEwe5740gjnJWvqaCZpmD1NvIJWkLlqTBJJIwUC43hB4VlbL4WClmyeDOMh5C8inNnQG99dHlTR3nwDbQ84j3m5FQcS/gbqBgz5uopNKiY3NW2S7y9gG6e2SmsxZRKo+XI14kUgY3W3mHkScWtOftnPnuU9yjv9VqV1ca9c+J3/x8gnKHXYfKj2RFFSUQInd+zaeCx39paL0qAIFIZZPID9gSj8jIe5X1tAPwkqKKuL7xManM4RZuLu39pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 17:15:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:15:11 +0000
Date: Tue, 19 May 2026 20:15:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net] net: bridge: prevent too big nested attributes in
 br_fill_linkxstats()
Message-ID: <20260519171501.GA520442@shredder>
References: <20260518130531.1015332-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518130531.1015332-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: f3686cbe-bc99-4fdf-7ec0-08deb5ca2f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info:
	yvsTEcVdHp1aZdqXsF/OIUtKoyqJP9o+RcdzMKdHSWbJXT6Ikz28h9gmrrt1su7AyFzdwKdI5nlhVRu6e37jpEo8UEfsngTOqg3qD/qbjqNwloaJtCfcfaNVoNarADIaj1vvdq4fZkLvhypbDfGaT/b/YiIAHDIjKgBctIdX7AHUJ3Rsp4dCsS9A+pL9uk8Es7VAH0u3FNXsMaz1UKBnjuthkKAg4GfP6rtg0cN2aBva27NLFDymjUIR6cPd++AkzwhLkLsZxr7/lmuc34bD7zdcBQCZJAInUd2MZJ0cfLQkIMyK1A/bEBRBwP+1GvxkNHfVgI9cOfoxz4qBG6n8QAUcszw9lpxCqgWtoN/suPa/aBibX/d3ja64GOOVqV19LGLztNts0N93jd758/QVLlTHCXDpLX/KGsBgO9wRnYmSBGJThHXpf4NAKlnvrRoChf+Ew2HDL6bygcQ49CBIUjC4n2dGGUay3AOiblbgxb0cpqNU0RWOWTwpJQptZAguZEOFRcY16OSU3trWDBXbrobr2/4b4EoU5+S3UbvhqHqcfU0MW0uTmlJjAOrEtGVuWZ1ySAId/fanLEvEmsquRIVH12nSKSS8E4NHV2Bxa+fTZdtPAgePByhJowv+Bwn1rLMgtPRLukwrdqkIgJrzBhkN5fADSPYVZcMT9FYB5Gk4Xh1faPQsSW0qLz2j7Brq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9mHaOmSXYcr3OgP0Rlj/8j0JFLFNTAT5mNET/C3Syh5L6ycIOVyH4DbAB+b?=
 =?us-ascii?Q?l3BIz3arJNINsB/YnzD1zsiW7APiBRhXChmzafho2eqhJPou1V20dkOF4qIO?=
 =?us-ascii?Q?/HntzwD+2NV2Xe9v2KFG7GV0vd1bnAST8B6sOh/bdApvPb80sGNRS5MH4o88?=
 =?us-ascii?Q?CGqTwWQyPBtSv6v6hwKGIrHmsus4VkLUrxI+VcbPsTtPz5oP/nsP2+XBdD9p?=
 =?us-ascii?Q?I4Wk1HL/lFmTI0VhcIUHJKVGjUJYijVfy56B72FYLieZSqhvoNU/N1P+XWEr?=
 =?us-ascii?Q?ym9HWKWT9xxEW/4vcF9dCGqy8TTzfg12XkqIdi59K+ycNIfUsmbTgNrq7dw1?=
 =?us-ascii?Q?zPvcPFf15te6PvaAbpif4NlfBYHG9Bcq9wCMcRM+HsmZ3AMf5cm8JJIgvNSJ?=
 =?us-ascii?Q?S8V8bI3BMe2ucNaTf3Squ7fuh/2BiIeRqq23+HsrDz7H4ZWnjfI/WrjrwHes?=
 =?us-ascii?Q?UApKo6QwhM7rcG0jIF3BPpibYJzvR0+Vp4gBbf/LR7oirUJPNZn99Kt6Saz0?=
 =?us-ascii?Q?wtLNhHGa/YoRtxgCw/AgsN70lpt8MhlNnIt3YcsVGge3rlYs+4qP4srZiLVt?=
 =?us-ascii?Q?0N7twAHVDyZJxBdK/7l35n07kEjZR0mnRqZDoFpl8lbVphEm8uj9hi0bi2ye?=
 =?us-ascii?Q?d+Vx17VK6BVg9iaR9jThr2zhhssyj5PwMDcrn2Y2LcWRrs1SgW8SG5Rmn0iR?=
 =?us-ascii?Q?oUy7NNwrZh66lqihrtBK4OFt254bY4KK3NKpEWF1XtgtvT/qjzFw9QhNk+3p?=
 =?us-ascii?Q?JQX8mYxN90QM+w12vLvtNii7/wmdxP5XeSsHL2V757OCBcyImRVNFxiSZh2n?=
 =?us-ascii?Q?Pk5k+vXRKmfNklo5KNx8xEDqr2Nwwlt2hgkzDuqnX3pSW/RR3/tB79/KGkIT?=
 =?us-ascii?Q?LlUP8u3PSeAzUIZ7lP1AlMlvQSY49fw1a55MnD2IK3oZBPH6QGWITbGffGTF?=
 =?us-ascii?Q?Ny7MiENmFKsmPGG9Nc2+rMlohwNdHgf4FXPX3e/5v+4g3zGqe4layQGdT5/F?=
 =?us-ascii?Q?bWqtT2hVzEQGIb9Prr2fH02aApGFhNWF5aSZmAoTRzR2rnDcWEiZxXKV+Wo1?=
 =?us-ascii?Q?lytjZ+ea2o5KN5IJKbKZEGFTd7Li7/tY5+4O+l7JevdkTUIiyRg7Xp+sS95H?=
 =?us-ascii?Q?Z0B1pUba0UuSP7e+TCJwB6klTTuj+oYlAfTkiGMJ56zHG76u6AVMIQb0QgDF?=
 =?us-ascii?Q?+aKdB4562dSr39QxBSIjI7sZt+HmuQ7uXGFJ6th5nUC/e2p3nMX8qxhYOZSH?=
 =?us-ascii?Q?ztmGnAKhJgPG6siGay+jW301jRBlocwyxP8Ya+9zGAtKy1IbOnclW0/3Fn5O?=
 =?us-ascii?Q?58r9cBNypdms8SAwmkXJFsyuK7YXlnYhHlunmkDHBuypOZq94K+bB4jYxU0O?=
 =?us-ascii?Q?ZEGevEVE8nmgnA8zVGiy2Rjq6oueRUU39xxfRgo8MRgoimqQUtYk2T9+1uzr?=
 =?us-ascii?Q?ehgt1xNkUyBcKA7wvoxfP2hbIkJtbMpm90HsRlTKMfK7NUretAEA1TumhJTg?=
 =?us-ascii?Q?syOLbRjt30j13DP4sqS/SUT0hEViF+joOxcuTkMCzvwQ0lCIzzrO6KhY6frp?=
 =?us-ascii?Q?GyG5yCJ3OBdFvehyYZfWut8n+3lnaH4mBP9ejba1Xq3i+UZnUjmdtzrUPBUC?=
 =?us-ascii?Q?FZtb4l64r7ZUYnQ/pWP8d8nNE90v6uZjqyGzBISu2SA4V6e85XuhUhWoDY/n?=
 =?us-ascii?Q?kEL3f//4D8tGrtqdGkfOffUJXqBCTbThNIFZKe7/4QvyniVi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3686cbe-bc99-4fdf-7ec0-08deb5ca2f2b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:15:11.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl3oaWikjUaUU1AbWaO4WBnPxJiSgqLxNycTtmGKqGjqQj1P3VVg68eHpEA/ocV54KJjdu6DprFHWmIieI+iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289541-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: C3275582EDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:05:31PM +0000, Eric Dumazet wrote:
> After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
> syzbot found that br_fill_linkxstats() can send corrupted netlink packets.
> 
> Make sure the nested attribute size is bounded.
> 
> Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_netlink.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 6fd5386a1d646542c184702e13cc2e6c8ee1820d..e15a08a34aeab2429b6c49c5a0ecab9b47582f06 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1827,6 +1827,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>  	struct nlattr *nla __maybe_unused;
>  	struct net_bridge_port *p = NULL;
>  	struct net_bridge_vlan_group *vg;
> +	unsigned int limit = U16_MAX;
>  	struct net_bridge_vlan *v;
>  	struct net_bridge *br;
>  	struct nlattr *nest;
> @@ -1841,6 +1842,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>  		p = br_port_get_rtnl(dev);
>  		if (!p)
>  			return 0;
> +		limit -= nla_total_size_64bit(sizeof(p->stp_xstats));
>  		br = p->br;
>  		vg = nbp_vlan_group(p);
>  		break;
> @@ -1855,6 +1857,9 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>  	if (vg) {
>  		u16 pvid;
>  
> +		limit -= nla_total_size(sizeof(struct br_mcast_stats)) +
> +			 nla_total_size_64bit(sizeof(struct br_mcast_stats));
> +
>  		pvid = br_get_pvid(vg);
>  		list_for_each_entry(v, &vg->vlan_list, vlist) {
>  			struct bridge_vlan_xstats vxi;
> @@ -1862,6 +1867,10 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>  
>  			if (++vl_idx < *prividx)
>  				continue;
> +
> +			if (skb_tail_pointer(skb) - (unsigned char *)nest >= limit)
> +				goto nla_put_failure;
> +
>  			memset(&vxi, 0, sizeof(vxi));
>  			vxi.vid = v->vid;
>  			vxi.flags = v->flags;

Thanks for the patch. A few things:

1. I used [1] to reproduce the issue. I can confirm that without the
patch (but with ff205bf8c554) the warning is triggered.

2. After applying the fix we get a different warning [2] due to
EMSGSIZE. I believe the WARN_ON() in rtnl_stats_get() should be removed.

3. I am aware that the double accounting of the multicast stats makes
the patch correct, but it looks like a mistake. I find something like
[3] clearer (on top of your patch). 

[1]
ip link add name br1 up type bridge vlan_filtering 1 vlan_default_pvid 0
ip link add name dummy1 up master br1 type dummy
for i in {1..4094}; do bridge vlan add vid $i dev dummy1; done
ip stats show dev dummy1

[2]
WARNING: net/core/rtnetlink.c:6332 at rtnl_stats_get+0x294/0x2c0, CPU#4: ip/4404

[3]
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e15a08a34aea..eb1292d67f4d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1842,7 +1842,6 @@ static int br_fill_linkxstats(struct sk_buff *skb,
                p = br_port_get_rtnl(dev);
                if (!p)
                        return 0;
-               limit -= nla_total_size_64bit(sizeof(p->stp_xstats));
                br = p->br;
                vg = nbp_vlan_group(p);
                break;
@@ -1850,6 +1849,16 @@ static int br_fill_linkxstats(struct sk_buff *skb,
                return -EINVAL;
        }
 
+       /* Limit the amount of VLAN stats we put in a message so that both the
+        * inner nest (LINK_XSTATS_TYPE_BRIDGE) and the outer nest
+        * (IFLA_STATS_LINK_XSTATS{,_SLAVE}) will not overflow.
+        */
+       limit -= nla_total_size(0) + /* IFLA_STATS_LINK_XSTATS{,_SLAVE} */
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+                nla_total_size_64bit(sizeof(struct br_mcast_stats)) +
+#endif
+                (p ? nla_total_size_64bit(sizeof(p->stp_xstats)) : 0);
+
        nest = nla_nest_start_noflag(skb, LINK_XSTATS_TYPE_BRIDGE);
        if (!nest)
                return -EMSGSIZE;
@@ -1857,9 +1866,6 @@ static int br_fill_linkxstats(struct sk_buff *skb,
        if (vg) {
                u16 pvid;
 
-               limit -= nla_total_size(sizeof(struct br_mcast_stats)) +
-                        nla_total_size_64bit(sizeof(struct br_mcast_stats));
-
                pvid = br_get_pvid(vg);
                list_for_each_entry(v, &vg->vlan_list, vlist) {
                        struct bridge_vlan_xstats vxi;
@@ -1868,7 +1874,8 @@ static int br_fill_linkxstats(struct sk_buff *skb,
                        if (++vl_idx < *prividx)
                                continue;
 
-                       if (skb_tail_pointer(skb) - (unsigned char *)nest >= limit)
+                       if (skb_tail_pointer(skb) - (unsigned char *)nest +
+                           nla_total_size(sizeof(vxi)) >= limit)
                                goto nla_put_failure;
 
                        memset(&vxi, 0, sizeof(vxi));

