Return-Path: <netdev+bounces-271472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DaPBoapw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:23:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E843221AB
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4543305128C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21E351C05;
	Wed, 25 Mar 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FoU/RaA2"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1462350A1B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430093; cv=fail; b=jrDSbsF77+ZcXpbe4d89PILbm3muw2NjocZk1dHi+aQOs1+8vpgq/CGOdijS7PYgEBFIO2bv6QYtqea+TjMDdoUvVpcdi4a3Tnh8ipzDDZQCVxMVZ2oyhBYvt4ZlJPrYzU5lAqboFwK4lbsnMPnZVR889TU49yVb+EkmuaegoA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430093; c=relaxed/simple;
	bh=lFXZACsPw4HMcVBtJ1xUmRajRq5oKKCGucz8Y6s37II=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yv3DNcOSD+dejg+bSve0YVwRVF77KqDTBqc8nG/CYI1+ztm9fDLDn2c+roiNFzUmbSdhd6sOgSpGhUOxb9JV2aPjn04gpcTfMzHVl63sZUr/Auid4tCDXwXtLc7OznIbkuQa/8EytB3bOKwBvraAWFKHaE4ufPJXQqbSKmsb1as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FoU/RaA2; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEJW1alAlMbGDxni7Za/gT75BZbM/pAvsXQcfmxcDP2jmlPKd7T3nyMUkaKRTT9e9JliTjf2PC2KMcLwszxRzFKLdaEz8MD7zRcesHIn1P5ZofnbNDPh0vDe+pnt6+IItaiCBfqcUNbMWOSzSI9OH/aKjLQxeYp6fsaWUuUvODS3VIZP8nIukbadSaewgAbuhJjbLwqc/jFUAQ6PYrDzP8toEifu4lPIdDRWcgzcDMtLkPqmJqwu5ZD0OGnbJ1rKni/Aq96eB6+1BVXtja9YiqpJKLvVMajshaR0g2TbBMlxJDQ8F80+E7h2KJlv8Xb9voKBAZP0+ihjXnoUht/Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS0sDxxPWmOKH/gisJ6ypqXfC13SbKVnFfH4BFCY1ps=;
 b=cVNxbz0dKm4IDwI40o9cy7IW8ga0rN8UG7b/vvorA3SuFQIuZbibJhFY4M5Ie2UdzPAMjnGwrv7yKyFDrjEDzQX7uykNsH3ffLxBLXzfcV+SloUHxpBIPq/TuLzrzS2UXxoreiO/ggZRjuRywPuOhNjgYswMAUQvhfT6OJ6PFlnW4VA/sD0HmkrxgpVp0fF3lkc/EouhSB1X/wiFuLcxqvf3+oWxBhBnglIlrAQkzIfOJCvb2UJZVCMTuOw0VpMCS3AQaR2ez1k3kfI+OnY36S2ERsQ1jKmjgMlsUKF44LuCXGfKHW42zqI5LHxEOU7WjoSaXFvSvvAulsEMXanjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS0sDxxPWmOKH/gisJ6ypqXfC13SbKVnFfH4BFCY1ps=;
 b=FoU/RaA29rtiQiLJ9Q6mA0dTmsz1Zd+9WVPHGPG4/C8a+pnthsxPvI71IcRMY7I6J2NfqrYa0klf2d8itqvsoNPW0ywS7gLSdVmKIgjxiETvLbSQbi5GC76gzmJLpLzkj8WlbjcrGQgdo08FtE0eBx8zNV1qyPOpUbnPt/+6fW0=
Received: from SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11)
 by DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Wed, 25 Mar 2026 09:14:49 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::cd) by SJ0PR03CA0156.outlook.office365.com
 (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 09:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:14:49 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 04:14:48 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 04:14:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 04:14:48 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62P9Ej8a016525;
	Wed, 25 Mar 2026 04:14:46 -0500
Message-ID: <39c8e4ff-240f-4bb4-b4d6-cb8aea930c53@ti.com>
Date: Wed, 25 Mar 2026 14:44:44 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
To: David Carlier <devnexen@gmail.com>, <danishanwar@ti.com>,
	<rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20260324211402.342474-1-devnexen@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260324211402.342474-1-devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DS7PR10MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d889af-8d8b-4279-9e00-08de8a4ef75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q/+T1//cDjU4HWbhMv3WL8J9vo+zagTmKFBPq6PVvLHnmsp/68d6b24oO8Nf6alEpBXQJnyH0tZphF8F9Iru8ocnm6ceu+Ra2U5/pLjE85i3j1zZOQJzpIZfPtbP5xl3KUoFcX2fau8kqL+HYN9yxz2R4XkmqnpfO012vWa5PZpqm6pL5d5R3yUjUhJ8zuPHWRCFa6/z6bKhxThxptT6USGovyTExPKKoiVQ+bJX3xRxQEhVF1C7baZB29ZUAaFXmXtAhgOVOtIDprG8sJT6bw8JgOAmH2z9ptNKrRcsAEdGNJ03+mGeg72MvVKzSvZgpwYyWRseuwbepi104QhZ8e2zsy//aoF5ijHXaFFDyQCypOJ8jh8wS4uSoig2d2TfWyoV/g7P4e2KLNKaq1OIdzHrug/bCwQEuRvbido0/BuogltTqO4BpA8+fq8+gzthmMjqO3SSRxvdIiJCKmHfif7axJaorUiXun727XUJ5fetbGTsLTcrS4VbvasKjKL00eBQCnHwn3NxxT1oyDXP+SZIqx1kqSgv5bPbL86wgTRnQXq3IUjNbuBKJu6Zt8h5gs2tkGUjNYumXM5dUJVTKfg+26d6Vs1v13RJjcGdXGNBu9c68UibrKZaqZff4O0c+KeWfAnxC6iYGmN8ct9tbd78gw0smQsoMcqRqC9cqYMHccH65amW+fm8qU8uVv5ABlkdvfmC/WNeK9pQ4yfym1HXAUfOXBzDYFWVdpAdY/DmPTp6kkgzjpCB9bRoEDRFDmiIVS+Nljjku6gsSjABdg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IihcwDvLMbJWTexF+32xELN47kC3Hd3kH/x5tHP39oAt39FfFSHFJ4NHrSMD8/RtgfapUT/cFWQuzTb1OtYxDSa7BB7ibtJgnojcKL9hiMonmcTA/h/nR8p4Ibw9LMGsnOz/Nl8b03st5T02rZkiPS301a2SGNV+joudLSxAl4BHNN6uQ9BA4qP3QOhk5Mn7b0+IJkmNR+Tw75Tsw9YDTz+Em1Pg1pFsYdiZV21PqhLR6HtAN9uu5hwWur8rjT2jkVb/3FSOoJkCneGNC4B9XrExqQyHYciWWlGNYoatxEplB5CYL9LbuySbE4NGfjlBZltq1k/QQryq3861nzvSY2TQRI3IstLSZzG5c5R/CH0WhL+zCmzezmy1/TTpNUKfB5OkUJi5zCqTI8//o6mdb3G055SUZ20XTjDyuGm/ZC5YHioaqwCznifC2qm9erwU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:14:49.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d889af-8d8b-4279-9e00-08de8a4ef75b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7129
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271472-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 74E843221AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On 3/25/26 02:44, David Carlier wrote:
> emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> never copies the packet data from the XDP buffer into it. The skb is
> passed up the stack containing uninitialized heap memory instead of
> the actual received packet, leaking kernel heap contents to userspace.
> 
> Add the missing memcpy from xdp->data into the skb data area.
> 
> Additionally, remove the skb_mark_for_recycle() call since the skb is
> backed by the NAPI page frag allocator, not page_pool. Marking a
> non-page_pool skb for recycle causes the free path to return pages to
> a page_pool that does not own them, corrupting page_pool state.
> 
> The non-ZC path (emac_rx_packet) does not have these issues because it
> uses napi_build_skb() to wrap the existing page_pool page directly,
> requiring no copy, and correctly marks for recycle since the page comes
> from page_pool_dev_alloc_pages().
> 

Thanks for the patch. I wonder how were you able to catch this bug?

> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index fd4e7622f123..9638a03bebb4 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -902,6 +902,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
>   
>   	skb_reserve(skb, headroom);
>   	skb_put(skb, pkt_len);
> +	memcpy(skb->data, xdp->data, pkt_len);

Why not use skb_copy_to_linear_data() ?

>   	skb->dev = ndev;
>   
>   	/* RX HW timestamp */
> @@ -912,7 +913,6 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
>   		skb->offload_fwd_mark = emac->offload_fwd_mark;
>   	skb->protocol = eth_type_trans(skb, ndev);
>   
> -	skb_mark_for_recycle(skb);
>   	napi_gro_receive(&emac->napi_rx, skb);
>   	ndev->stats.rx_bytes += pkt_len;
>   	ndev->stats.rx_packets++;


