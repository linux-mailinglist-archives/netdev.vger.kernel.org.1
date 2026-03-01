Return-Path: <netdev+bounces-262411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCQcH3BhpGnIfAUAu9opvQ
	(envelope-from <netdev+bounces-262411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 16:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D891D07D3
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F89F3017C2B
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8730C602;
	Sun,  1 Mar 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ma3UHsPT"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAB274B4A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772380470; cv=fail; b=pDornRizG+G5vFwpjYqV6k00DpVmC09er1NFU12JD50IrvfLKPeBRchzrcx6C3SKhpQYQ6s672HBY0k8uhT2ZdFkT1HTDZNGmFp3lUwYZQSREGyFp0O7skNQ723QLXYELR42BwJvnCedyZN622IpaSgCSOHq/Eikwzz6jQr0t/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772380470; c=relaxed/simple;
	bh=f1ojdhbpadNAiOCRMwwBGS/P4GPqXcu/TDGeAp9/8OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ejn7vfcCzFsPw1TlfooawY5dxAzKqVETynC7ViExNMsMjRCpx48rSwPq9TLUaLtsQjQ7Yk8VNS1mTiG0QMQkGLPLIONIfsHHB7JfagbwXcT0qCdpQMsvUKdxCYARXRWrdAbKdZ3BYcom1fn1qPMFzWq8c10JKJdz+r52IO8+nQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ma3UHsPT; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP9vTW6qoqyuH49samPpxbAxFPU73EFQd+P/HtUHhXG33c+iTJXLAALvVgn6Y06CBgOAlOFjwvb95qtwhGSyxWDKKMRgtv4vUTZuBZBDKq6iUBycbz/vccFnXThwumUnJweeGGvkBkRW4HSSK1GY4igxLrAmalNDYp6p405S+AdbrFcgIw7Reo2rY252mSBp9tZTkqJOV9uZmB3MYL4efqOOmdnUHky6/sTzEqHKQpSpE/wvDHHOGxLg6C/IwVC2OpJSdx/dshBJGWKExvEtDNyIU6Or4AibfNWdvEhNolYFL3ZmdCHiwGsk7cJ5IgJC5vgUrdxPF0joA6aphlfLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhiyASVffHjg04GhHu49dcQpic3Loga2hkrC8+UxYXA=;
 b=KWmjdB0EBw4lKRmavDjcT8t7n4GzXG308IC06icEIolHYM3rGAfQ9iOtYtDgJYv61npieYqzftbdwAC1yO5KyVf+SxEzCTLx/0LO7rrwTNCmjLdr56ISIMQ6jAom1PYwE0FnrDn55demrM4ZoKLPNPCmb1U29sK6t4gT5blIroqziP/QLfazxSczwmj3/+O8BM04nron4ut+7GY8oe7NtNSui24F5JjO3P1RCCda4TKEOmEHp1afSDNKfTpaT/p1PjxYLFAlkgH/dheNJOMXdNnnzifG3iw2svMKJM247ciXEKG7ht6bx6DweE6kgkCcQY04rdrt/n6mbwwr7qCGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhiyASVffHjg04GhHu49dcQpic3Loga2hkrC8+UxYXA=;
 b=Ma3UHsPTV9gCtBrhoywVEf3mVVRA2ipOyKLmoLbcKxypCqEh40djGJY5Az95azKXddIVgdsGqhPVvl2UMpiVxSX0eTbGkAA7a4aNH/cjhtgr/Nrh0P4LZinzyUKb3FDijXNXeVhBAMd8eSEbhuDs4P7nx6AyaXHYAjsBx702ZClPi2TZJ8Q2eQLh7AyBfTyhiIk5JzrSgQuIt8NNBl02Oc2zjpDTKqRYNw8vWu+0uAetMB1Yr+UIZQ05RvGyrxUC36yPbCFzn/a0sDuaYTOHIb/5Jh7FoelPTgsvRZCYkkEnSOnffsJl9RGdds5JlJib9MCMSTPAB6mAPyVKHUPY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3SPRMB0009.namprd12.prod.outlook.com (2603:10b6:806:31a::8)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sun, 1 Mar
 2026 15:54:25 +0000
Received: from SA3SPRMB0009.namprd12.prod.outlook.com
 ([fe80::ff04:ba7f:5bdc:4f89]) by SA3SPRMB0009.namprd12.prod.outlook.com
 ([fe80::ff04:ba7f:5bdc:4f89%6]) with mapi id 15.20.9632.017; Sun, 1 Mar 2026
 15:54:22 +0000
Date: Sun, 1 Mar 2026 17:54:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, amwang@redhat.com, sdf@fomichev.me,
	petrm@nvidia.com, razor@blackwall.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net: vxlan: fix nd_tbl NULL dereference when IPv6 is
 disabled
Message-ID: <20260301155413.GA755501@shredder>
References: <20260227112701.3990-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227112701.3990-1-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To SA3SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:806:31a::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3SPRMB0009:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7e6cf4-79d0-4417-b6dd-08de77aace63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	BHqLyODF3IAkoxPjrbaE9Ad/zrHvZxj5jomX0Yy1YQ9tCdnlGAhks1ZfhKgOFpt1uzbAdSSOjqgXAaUHPhvrff7ZqcT2Zkv+6JYSWmXoMFNFnkGSDbgB755NS5pLGl1Zgd3XIYV0TmVDNqQSFpq8Aq7E7SeAafXeez80oT6mkBXG1i1BVsUDFDw+omWkYHTWTEeKOGMjzQOolhaBemZS0IbFbk8gts96YXSnxE02oCyt6keDgddgF2dmqtKGbFrcVsiwuT91L+L3y/G5hCralQN+Yufi2O5MUBEzOQHMPa9pTMfmCR4djxfa9SUkks3Vnb74Za35RD0PMFad+SOaatzEsZBS/pSdxgYzzySs3F0AFmkBP+tqF1bCwqYVnz5buXw65bewgjIpt9z1JyH1/UYCB6rCpZoIymrK6go4jINU8ZrJ3pvEUMpCID53Nl1Yy95xJXox2TOgyrDOLBxIDh9TGyKAeZWVGylQeAf+E6FVis4xIsRei+5DuJ0sChYCdqENZEJvcsTWYQU1tZoYFRV0rBFgfnbUyvwRBVdTFyZPReaZuN/K3XYPzbVGNOiJHVXbCCHC+naQy7zsxWNSuG1USj1eDtJdH3hzeU+dY6ho5f7FmTNWbAiCntHQL8+iAyEBJhzJreXKjEkYM/6uhNTbe2os/ocI9owjlu7Ski7cCfdg1a1+Tu81k/l6sL1VTHm84jVJCNbt8AhyCulQLC8LEHfPI+JFT9MHpskrZL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+AyfgiwoAplq6sXq32n4wg/HOVxnd74oEKtF52G2chtE2eHgAj7IkCLBdcad?=
 =?us-ascii?Q?NokK1i9Dk/8LgMrSluxp5NM6gl9SVB6A3Rud66aoiBr/ARqa3+D+qYVNE4bm?=
 =?us-ascii?Q?oG+96qyA/EyH+55IDrwXpeoJwXxvcmuPiiCpeRBY2MSZA5SvIbP5ym6+DUNp?=
 =?us-ascii?Q?YlJlZHVESOLJUNgD1NKrBWoOqGuQHxmtPTPRZQqQBdh1ln1ynofvCiUdbmXu?=
 =?us-ascii?Q?grHC9Q39uidb3hWFVTDONI8krq2tenooWUpKiyL/oYXqi0zc5Q/hpm075/H2?=
 =?us-ascii?Q?IN+EUoLUXW4u11Yj9caLuDXdfsRzcstezUa/hlYtqptzj3fz0UNo4N3vwy+X?=
 =?us-ascii?Q?ekc9qI2CkOQxKRehon+wppA+oOf2Df1f5ALBm9PqXvEalgxwukwkiioOWxOw?=
 =?us-ascii?Q?3M8VsL27NBSkQTN6muGt3WIqcH8XtlGVGx685mvfzHtHYn2ah3bEt6rghfrB?=
 =?us-ascii?Q?AjzgRAfaFJAWTHgQfuZxWBVj+RJnkE5kKpYbz0NT2zjIULYS1VXuzmJ2OTV5?=
 =?us-ascii?Q?7wB4GVQ223VqUHh8rojxWIpddyPPJtkXN+dtIzGDLnyM9QjRGOq3JHVYgTbr?=
 =?us-ascii?Q?tlYS6E7KuAwRscx+qj+BSGwFCb9dsgc+oZw/rgdR1LLzEmIK8HVn+3lzIgdj?=
 =?us-ascii?Q?65fWzWnFriAoegK4Yoe9o3GLulprTSINcdY/7wjL2WZcqAJIKjy5IV7YKlGj?=
 =?us-ascii?Q?rBCugkUV2VkizWFGFSQMzP1KpBNMPphXsCb+P85DT8bc+Ya/6RaTZbAkOlY0?=
 =?us-ascii?Q?1OsTHNedNHMgLaZVRjtRsra9NepZTehSGWtzW9P4swjtst9z3KjFq+Z4MYL7?=
 =?us-ascii?Q?vWm4IPMjIBs2YdQFAk3IEK0mdcEwSi6uyNOjMcH56tXX0eYGOUdzn6kYoAqQ?=
 =?us-ascii?Q?66i4ElicZ3y5/codGr6xBbPMaWUA/p42KFKmzuJxWiESofZr42cKglncDqLo?=
 =?us-ascii?Q?Rxm8WuXueSsQOBvZ9U7p6STNGI0yvfSneS+89t28qd7B31ipuL8wquAxzKvZ?=
 =?us-ascii?Q?C5cuCyDc5I2XlQXOO489K3gTLx9k7WtT11BuURzRJkH31nalVTPSaZwwkxQ9?=
 =?us-ascii?Q?UVDd4eCuRr+kR2nKu4dh9Co0+fNRIqYp0vbZvqNM0TH1Pg2xJRVyM6QUMv6h?=
 =?us-ascii?Q?7GJTZTHfgy0K/rv5OoJ2XFd7qK8sxzhmxVj6cceWl5oY/vLxwTZZTho6UNtC?=
 =?us-ascii?Q?EXvBlAN91KjZdEPfmtsVLs7OEVXp6YKKiuiiiYisZogl8ZJ1kqFcV76m9Mc3?=
 =?us-ascii?Q?l/w6uN8zwkv5t67qICo6J7JciX50jTuWpIuyzmaKJ8hViXaRXg+ua6WLEgh/?=
 =?us-ascii?Q?4YjOH/0nCuvYvyF+pyq+xhqoj9dipnNtwfkHMBHS4N7mSMfr4fnnq39MtrAW?=
 =?us-ascii?Q?eGZW9paJyXMSPKPYBSESBpwLTGVlQRmuym8JD8G49HgXIeSHTgnLuIComamY?=
 =?us-ascii?Q?1ZOOE/tLvLR4vx2+iHXqhsUuBBisz9hWTka3gUaaNI3Ev+bAGYQdsKVmemVp?=
 =?us-ascii?Q?mn7JfJrORgLz0rFORW7PCwnXkhH+O9KO+1it6DWsCDgnk8x2P0GJ1nblp9G2?=
 =?us-ascii?Q?F4YSiq7a1/2yyKvWf4CBnLfN+LCvlzLJqsa7jFpOxcG0AaxhcHI1pwRwLxXk?=
 =?us-ascii?Q?eHCrtO78h5srbgCwwNgSDWSha5P9aedtwRPtJCa+biOq2vucgttrjJgXLi7O?=
 =?us-ascii?Q?AFPfupbeQ0JukAj8vFLmu0qpv9Uqke8eR/vP9rhgWVdYX1xPfrv2K8fH5lzn?=
 =?us-ascii?Q?lV3gUE+n8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e6cf4-79d0-4417-b6dd-08de77aace63
X-MS-Exchange-CrossTenant-AuthSource: SA3SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 15:54:22.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGsp6hME0Rx5HzxMDu3AmL7c2b9jRTWbSg1Z2SYnP364BHuAzRYNX/Nc7lyXiwUGbRMxDIKJRdfpe+siRsBDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,suse.de:email]
X-Rspamd-Queue-Id: D8D891D07D3
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:27:01PM +0100, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. If an IPv6 packet is injected into the interface,
> route_shortcircuit() is called and a NULL pointer dereference happens on
> neigh_lookup().

[...]

> 
> Fix this by adding an early check on route_shortcircuit() when protocol
> is IPv6. If ipv6_stub->nd_tbl is NULL, return false.
> 
> Fixes: e15a00aafa4b ("vxlan: add ipv6 route short circuit support")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 05558b6afecd..cbb9d1a2d8f9 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2130,6 +2130,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>  	{
>  		struct ipv6hdr *pip6;
>  
> +		if (!ipv6_stub->nd_tbl)

I was wondering why neigh_reduce() doesn't need a similar fix, but then
I realized that's probably because of the __in6_dev_get() check earlier
in the function. Maybe do the same here for consistency and mention that
it relies on commit 804b09be09f8 ("vxlan: Add RCU read-side critical
sections in the Tx path")?

If you still prefer the current approach, then I would use
ipv6_mod_enabled() instead of the NULL check.

> +			return false;
>  		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
>  			return false;
>  		pip6 = ipv6_hdr(skb);
> -- 
> 2.53.0
> 

