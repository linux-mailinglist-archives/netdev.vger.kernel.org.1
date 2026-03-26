Return-Path: <netdev+bounces-272214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKJrBfCJxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE933AF7D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E31D301CFE2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC13A5E63;
	Thu, 26 Mar 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJPX6yiz"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98391399373
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553320; cv=fail; b=M0vCMPLAj/zZzChrcGEhdwKnZWL6vhAJ2eUg89zDaa7katIG8WdNpfqEVM/kWpMmObWylO2Yu3g40AME6RpRip+QvmAAhkLFXVCMPgomvhxZPiq2MABq7v5dT3sVps07+jbcLCPsGIyPQeNnaSFkxrEpS9fPuwIJ5UnGRZgXzCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553320; c=relaxed/simple;
	bh=1lR811IPDOICQxWZsU9c5LOMvdB8gKHk5mKPu2Y/1WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hbf9ZbPckpvnT1sw+Y+jzk9xf/+FflbbWFonM+YJo4HQGWZ3X8jmBPs6X860Qx78vl6FMd2EYI+1YW5MdNLWb5bM6JIAh+LIv7FAXoLOQLLSU190iMc0XqQ9+fhwCM9nulD90zluHq4id2wcj28EA2Li8o9gWH/mh7oM08ZHCHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJPX6yiz; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6fGXFgN9lrZ7eiHB1h9yXGUGv00DD6mqLnSRwHpq6tJv6/47O2LykmpVGyVc85HpZbHp0LtzcI1p+tG8/K8ICMUohFSpKP6Bv2QZZ4mdKb1VFaREWPHrN5pF0tChsTT0jPsHTTUL9sS13VF0LvWb0xR/Zby8vULapZCQ1XtznK/yKBObT6E/z0ovELu8TFnReIcGAgdm2O+3iDSHGDPqNUWV0HCOMYLGlVuDirRY3oi0/T6TB3O4aTLmMs6ByMBlzpMZoER3wAzdiBHW910ydDKIf0MsMCCCPcsGR4lBLcYUJu3WGWb6uCEuHdEdhbJdoDwPDGSeYNB5pzkz3KsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZEScwT0UdD+Z/OoGhX2rjUao7PXpe0yw3KPWvz2Z6Y=;
 b=GKfZprI8bEnw2E3SE7jtT83LwqL4+DM3Z0RQ2NvY0k5iiJv5p2QfYYREO+iOUCB0aCi82YYB8cAMYO4jPIde+JTLn+vusRwjsOLKOWTZEfHCMg4Aj5MOZgPE1ZhZ+xOyXdV0h8mZfgNAXakSCMTEathY4bmGhF0gOW0ol/Ht04JJK3h6ig31dXJr2+BnZXZ0PD+WqjZQXZc6w/fSoT5iliLnWn7zRSKVPHXGuZocxMe/oLM0GhL2pghkHF/Qy7cg9+KFUFtTvfQJEcMh27PL1VAxPoLYPiFZRXCrxPcqJir4DBmMrZ/l9oNKaYQ1YwGlE9BfdtaDyJhDIQ+nSiViTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZEScwT0UdD+Z/OoGhX2rjUao7PXpe0yw3KPWvz2Z6Y=;
 b=pJPX6yizceeQWACEmXaxkf+Oly6A4RRE8AE0hfHYFsR5gNI0sFsTba21UEVmim/Kib7+rnLaomiXWHooQYslY5mrgkKCu7ulQlJ/QZCYOIZ0S/8PB+lkHzMwPfEz3OsdBUp/XF2I+RmP2TOXc9OMno1hcTqLtod16/A8Jl9k8vAe4p4/1O12wJQMrohLj/BF85n59e2V03LnRhKawUyn/FQnYbpxeWM73rG4Ph2iczGoW7OudofjrK3fdrWxOM49iDvPmOqoab3GL/G/SJlTZP5UskQE9JHeK1dogrJj3f/hLUTGChfBI2l/25jLCq2wKkvPp4KMsPqj8iSRnQRcLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 19:28:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 19:28:28 +0000
Date: Thu, 26 Mar 2026 21:28:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Oskar Kjos <oskar.kjos@hotmail.com>
Subject: Re: [PATCH v2 net] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
Message-ID: <20260326192819.GA1103736@shredder>
References: <20260326155138.2429480-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326155138.2429480-1-edumazet@google.com>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 93efa0fe-8fe3-436f-6015-08de8b6ddb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UOf1fIZgtJ1/cknykL2t+lmnBInXrbKxrtSEPTlDBLriWMt8tT0BOdFPkIbpmXFO4esIFuQRlQD7hK9YWv1f2mNes/s6eKzGtdsoFr4wv/3G1mqtBrX5dLiuuQ/AHyR074Un8TFiJQiWwxWILGsgPTUui454cVYF3cxjNcVOj8Xyxhn6vgLE6eYlGPSHBMvRbOcD+Sd7t0Win6A2LI5nN76TOcgcxWqGvZ/zXFGmte1ByJKDwOO7JnQY7ANx2a5Cz/07sUZFqMc9cvA/9O6fKDEV64HcpWSVlJnl0el6RpW+wOmI3id4tK6DlFJipweN67aXJt875Cuc1caJvx1SvNQ4Xum3HHXmFur48a9SvWzANyQ43Qng6xhvlCWzzOyNa5IG4Fd4cBSGdXfiyW4+4fBziU2YL/OiJwR6IRGnYT40BW3hGvUSWh/k8pk5qNgv22+0OqXlj4q5otn6SPIfQEs/hGuu7onoE2pDjJKZTAnpJiLgMkVauPmc6MEpB4zQyxqbrViJqDbFd6uYF3ar+OIf84/gu9Ij6basVF8PMrDg4JM4HjVQSEMuBXfjCudX6zdJzxGgoBSnPsiST8inuDZGjwgeWdXkY9mJgoc9oQgevEKSvOQ5ZlnxT6lLa179Fj1IzxfG5TasMnRA5mXaOsQUg1UdjXrkQ8e94UZqxq+FM6y1pWsAfRqMh0kRYc5+3YF4MewcJ3PGCJcaCxXKfq9rORXGgWKtMNciZho64jA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2k+IfwXNU5FoBbH/Kc0pQFUmAd0chbY0CYf9tDb68FACSrrm9vxWZ2GBkKOC?=
 =?us-ascii?Q?Ft5DhxiHvR+s9W2NOIm4+hAH/nXOJtEOiM7rT/pLAdDvrJfKmPfpCDcmuUgG?=
 =?us-ascii?Q?CemU2w7Mv99QGF5w3eZjFOvxagxVPSSOPWz/AyjhfcLrBkBnbOXjNRI/3BAW?=
 =?us-ascii?Q?NVD4rrckSKOvG52yaf1SFIjke+xi7ghTHct3KAHaxxZByjPrO66dUm88rAu6?=
 =?us-ascii?Q?UyvdBw0vpzhxfkR2GVcKzZwON2sIcc7dRfL90Skx3jkaLUqIdk/RAOE7uYJ6?=
 =?us-ascii?Q?GfW0WwaMS1LieH2OB+jWyMBti0ibUoAvm64K5U0+DHFZYGg3hO9sL8YI1Wu9?=
 =?us-ascii?Q?7KmA6tcR3231GSwpMBQONpFlkGvqza4EGSy5XqmbZzcYxVymuAVnUaQNyHmT?=
 =?us-ascii?Q?VVL8ciaax8F0OPAD2QlJZE9m0jtrp6CdG5hnmqFQRfAQIwPmWid4YdnohNMv?=
 =?us-ascii?Q?PKsz7j91Ct1297m0TjZY19wlPAYjtSG8aKDGUKsrFAVS9kO48LwwJjAUvb8n?=
 =?us-ascii?Q?Kl6RN0czI7O9Eq8NI2NNYFS4t658+tZ9v0Zp0E1/9MX1W1guRxGwPwLnqjgY?=
 =?us-ascii?Q?oG8SaQvhKy7JJP3RTvrr6btonpK9pw9iASO4wERXxXXUNfemkxJZ9I3SpRyb?=
 =?us-ascii?Q?3iigNL7jJX9kfFGNPoN2saaITfbqsfRTTIdi3CKJ4rYon6ivTBo8+/jL4Zg4?=
 =?us-ascii?Q?xnuObVs5NKcjtwpOmOsFnyz0VEiFkSgVvkTVBPju+d9v1l8kw10JZRiwT+Ij?=
 =?us-ascii?Q?7Q/+2kA0EL3fqLuJbnybVfoCatZiKHCmdrVJ7BISVFGtW84GqWGL9AIo7leN?=
 =?us-ascii?Q?s9iZliSK6mPSDzl5/Zk0/8rMF+f0EZ1253106Hr/x5CsPhUPDYEZ+15sansW?=
 =?us-ascii?Q?HW7bcRWVHLOl+65eT9RwFl9egmHTCcx1wRHAC01UghALif86r7sejSzkmSCA?=
 =?us-ascii?Q?WcNNxjz5t2PheIcMb8kF+Qpm0av12e7lYuwDv73Jd5n9WlmLn766J9gm6GHD?=
 =?us-ascii?Q?Lwd+OEiyfQK/2Qr8cUL62Pt8sJob8Kpl1x+sooPOTmzlUOqmL7/8VQyi2t+T?=
 =?us-ascii?Q?/3HjXkCKdnU+ad+GHwG+M+QbrNEogETk3tVxLSaczIUUUTkCo5ztEvYXXlnS?=
 =?us-ascii?Q?jSGzSsKY6k1mytdTxmG8Uz3xRwV0KFv6uHyoSJ8DWTuOHJDj6WSJ7wXyeGWG?=
 =?us-ascii?Q?yU0Y0HIENXkBB/zFfAUnPEZG+kiwjJDa/YRzg0ExBSxgXe/5kGkUFIyjF7sU?=
 =?us-ascii?Q?bicY4gzhMcA/gPAKaCHFYUuVEgKBPcKbTo2gOs5nT138wtwI/32pSkGL1Chf?=
 =?us-ascii?Q?YIxmjlhcm26S3e0UvTtO4mvATU9rLZjbsRWsE+tzYRrEz+KU65RBHmfdYpHt?=
 =?us-ascii?Q?dI4VVd/Hn1aeu3SA7L2HfT93YABx+e4CekMGZ62ymsM+TjJVq2CkECw30MXM?=
 =?us-ascii?Q?bB3E2CDi1ze2uvrhPh+QNH7ipzkivl44nfU4t1cuZnunDQ9iVeKXP8KVxr8R?=
 =?us-ascii?Q?6nKWzxJ9M878ST2QcQsjSZSsYyaCGZx6oH3GnPQgQcMjUiRo+V9EcL7Zqgrc?=
 =?us-ascii?Q?AfjX4C80dn3DxAMe4GgSjD3ricu2YCyPhrMcMA2gvGMwTfp3HkQKv0Vcm2EP?=
 =?us-ascii?Q?qaDXeQclLxEUf3SIJFUXiQ24RfjIw4dn/Njo+MaGqjepjplBXfE5IFlYjBf5?=
 =?us-ascii?Q?nBpcrsu5HzIppLT2O+v8e/tSrBBZ+uxnpib6bZE/lDYRjMeT3o9lvyPTi4Jo?=
 =?us-ascii?Q?qZmT9OGLvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93efa0fe-8fe3-436f-6015-08de8b6ddb8e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:28:28.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItJnuz6GtQ6QEbXxRaCXvwIGAmJqdeZ5cBP/Qn+b5xt0Wfw3qT7kMgsBcOR4siPPcR0loMnl7NMD7Wv1EFvFzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272214-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7FEE933AF7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:51:38PM +0000, Eric Dumazet wrote:
> Oskar Kjos reported the following problem.
> 
> ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
> by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
> IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
> as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
> at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
> value. __ip_options_echo() then reads optlen from attacker-controlled
> packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
> a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).
> 
> To fix this we clear skb2->cb[], as suggested by Oskar Kjos.
> 
> Also add minimal IPv4 header validation (version == 4, ihl >= 5).
> 
> Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tunnel.")
> Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

FWIW, I agree with the AI review [1] that we have a similar problem in
ip6_err_gen_icmpv6_unreach(): icmp6_send() being called with an IPv4
control block.

[1] https://sashiko.dev/#/patchset/20260326155138.2429480-1-edumazet%40google.com

