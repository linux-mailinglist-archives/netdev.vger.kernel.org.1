Return-Path: <netdev+bounces-291180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OcRFTL0Empq5gYAu9opvQ
	(envelope-from <netdev+bounces-291180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF765C26AE
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B569300D86D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB71395AE3;
	Sun, 24 May 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcPpJGBr"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACD3932F6
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627036; cv=fail; b=KcSizlpCE1e4JgTqz3+orkP9jPFuU2Q/VzPgjC0FeI2ukAx9Xq1GCRxc6rEbAjC4y2C5UZRlcWPmJC5gKdYqnoOj7RdF3rF3qJWhPV1yUccS8UMogn48+bv4FxTrn6gj1B7/Dn9e97TkFllOFvIkb3PGUnugVZzHkDgBlUrPS3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627036; c=relaxed/simple;
	bh=N0IDuYUP+nzgDQefMxLDz2OCDxhvGA4ILuiqITF1s9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWBTdF3wSlNrftHHMRwD2Ib0vBBtFhtWqROiIPN6XYhwAVQjco5mTGLm30HIiDhTCi1eH3CAD2p3FjTfUFJgmpzh1qYlHYoag8oAWEWxQ6ijMSOaM5zG/QVM8OVmNffrEMeIgdhOZL/3LiUHvc3Jp2+bm7HNZ6jy0yMsNr+BfL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcPpJGBr; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkMVpMsw8WjB/AZ+DO0M+l/v5p47FR/nO0DQzT1zmg49DEkXQJeme8Q50jU/VT0PdKdb3ove/u3sIZctR+Z2dCbqAr55iTJNi+fnZXs3aVBcADGc3llY135UXX+REMToYmrunfLoiKhK0DFFljEp38HobWV+m4/AYWfm/PXvDOW1zoB7hoaUirZoYLRJjiTSC6Bk7avXresFYuhAjJ2TlSmWqZQLyoFscW16qXxUbhiF+8mAnFOAdtU1UydDP2l4dPU56usVf8ssi/54b+C4LW1NLFPxbrfb3LbHtr70XkIgp+YDnhWRXg4TusBvq0JYisgizNh2eNeWYVKLMAuUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqh2YumgRjtO5dE+aeWpc0rauAn2EfMmskPDso4liiA=;
 b=IDCe/UEo9G84hQ4NdS7TTfn1pk6h4PISToH1A3QdcPp31PdI8k8NAvc0fkQvbAsnDN470nNWXyynCKr5ZxAKHDkifRqY7pDJzeaIDv8fggv2f6nPMLZbSYNgjO9c/QZnDGGJwOHD14kjRCdA2Df0J0iK/vhAsSsdDwmjgDMsGADBmDBYwCkKjc3LKnFw7Eefi6F3mNuAL5IiqatGdreYfkrYNxSrH1c/IXUxXasMeTNhRVTydEh2KspV8lLFUNVC5smN2NWTIkcMlUBapZTyNsiAkJyYGzFMgtWbkoFBR5eLTPEjlNpwlZiXtnfNQ+k4/qv13jqQqXAEHLC9c61RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqh2YumgRjtO5dE+aeWpc0rauAn2EfMmskPDso4liiA=;
 b=gcPpJGBr5QaKUn90FaLCWvxsv6ZGApDMIAnzjd43EsrZKeJ8Gh3wqhJz5CIIwldcpGZM5OGtUrYgufekrHv9lrg87T5PvwB/oz5GPkNn7sa3pPPXVKsevbqAJWxdyrCSFP23eOdjsSjDdegYDQpzRTEhHJTrPCoAst0gvi+TFJ7qkLfXnY92VBiyNRWlGTIiSosNClkZKwdC87XnA9i2fich1vTmf2tDgAUSyy4B8bCU6zlYRDrZfFjZLh9sim83w2WEijHE8v9vXUBT4aryBQuTgMu3tszZfo1D1gWyJHAIta2iyXuv4Mdjd7y81pK6UGVFwgnYbacw2ugGY1ZrQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:49:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:49:39 +0000
Date: Sun, 24 May 2026 15:49:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 10/11] bridge: provide lockless access to
 p->config_pending
Message-ID: <20260524124930.GJ74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-11-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-11-edumazet@google.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2b52a2-f429-4d9b-afe2-08deb992eb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1kRg/cTiVCOXE0FTuSwt3fs0bzWBfc6qKT+Uh4LElq/nbnSJnBraSOQciueTMneyizLbUGvfRuAqKhqKRgKqeY+4K8jn2etCx7+bhNI3qBQYAVVZMFi/FcuhEK5morcE8NT8Xg/xmE3QnTSrryLoyoI16riMCm4XK52vglCqn+06qkpLre3uim4IJrL4Rj6d8nQeDWPOnx+8HYyrhLwHlQr1hBXsUucofB1zJnsgi811JeCXMcILJWferYlmnll5yU/JrzDlkj+K15fzNKZlWWS6nJb7E8VCScOHr8WlhGjdE/0MP8VLZ58CjSX+Z8O4Gp5Lohji7kZY73lLj/wDEfVg9G4QCXSxME0JiYTwvyBNFciEjcjFdIad6TvV8BXsp3VZJWE+EI6rA9YO1QjR4mTUZ+xZSSw/cRdYHFEkeBXQo3ldpZZg0fpOVMmfRK795MfKgNWTnbj9yuMDXBCELAZyx9xvHBH9IDfGvgQ+qnDVA2Ek1SyHD9aomwFD5V6JgujKmPKbG4nnhiUnjytlfIiGN/jUp784dO/i4UwZ4mwnZjtowf7kYU2/MvIokzwrhKlGYqsJgEsZV1h5IT0bZedOSgT0eAfbCtbR2eqInsUtJlABgMSYOWLphn9invcqkjcVOcQS66iytefQe/5LUPpjcTr7cHbZp9TKVTOD09gaVyL8ZH8VAC0/lPeUpRYQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFO+juPv1HGPOOv6zuwB6NhhOn8VYsgT1En7HmQIerul+6d9bbtCkZ0oA3YC?=
 =?us-ascii?Q?V5q1vOTOrDQQmwQyHrHMRZPfpUBrqHY3g2NL89pO1Q7WKZQBQnwWdx8SbEzx?=
 =?us-ascii?Q?3VNcE522kbAANDvj4N3ud0rSHHrja8KX/MDmWni2lv26SCyjCAeZKoXJbUaK?=
 =?us-ascii?Q?GQ9/ds2obV1+DvgL93ugWbTh9CoK/FnhqJxwl8DY8IL2SVPoVLI7f40PDjZX?=
 =?us-ascii?Q?xvd5Jxip5fu8SU6HlnHB2k3mzFEl0LV/hAzMYaVEwN3k/rthk+A9Iz6lYk4D?=
 =?us-ascii?Q?JdPtEam/6+yLl24duOldZAjFXGYhniceuTmK5AC1ABc7aA3gtQl2eT5PyuJw?=
 =?us-ascii?Q?a1tO1ZtlJEWZsrQ+7htvIqkCZzh3o1fqY8bbgGp1qNjg0hWTzLe7EAC1SgV8?=
 =?us-ascii?Q?HlX5svcIQk5UKlEVEvb8V8H+EUxqtssSjjRmSsQ3uxG6cl0Kp1KvcMtNrZUA?=
 =?us-ascii?Q?sxaxx3osl7Z3Z7cB9elNaCpwGlV81A/IA3gNoekRGDz2PYabkjGaEzGMHIhp?=
 =?us-ascii?Q?+qzyHf3lN17NhYNFiDYhAqMeuuNuhxMZjEwZqSgz7Qu8HaXhRl8YdQCvjVYl?=
 =?us-ascii?Q?y5OFCoilM7v+WCfKEdPb3yu1cRcpYLQwFqdiGbsmrWqi+71hQF/YFvJh4IDV?=
 =?us-ascii?Q?vC4BFWKpGOq04UKrfawpVREv/ObM9Xnc+cJiivkkoMqvcgEo7DLiF8XLRBSC?=
 =?us-ascii?Q?kdCQthQgkMUMapQclJnH6oDwQlbyt0u0TVt5drV3ksMinGnlNy6AJXdsiZsq?=
 =?us-ascii?Q?Xq9AsYOQpZ89hTNONgngDYBsfNV48tcg9aykXDw519ug8Y1uLTjl9IguiN2L?=
 =?us-ascii?Q?EV2r6fxc/EBvGcupZFMhsMNyEb+21lmHsdaHYoK5rEDYHRAcUDhHt5OzzoIp?=
 =?us-ascii?Q?pN4dcjIGE3g8WzP6XmJmTruuXvnsGfhEaKMsFQs+zBQhN2YWN5LV2pE9ddIP?=
 =?us-ascii?Q?I9YiK5t3+zBLdQswGl6XiZlaOm0pv+9B1hTjIbLk2P9CVOwOHRyo7wcVuvWB?=
 =?us-ascii?Q?bns4qYu15qvVZvBIBuRKVQwziOx+48Zt3j8e2njs18BstQ3be3CL1oiRWMwI?=
 =?us-ascii?Q?wPjhM50XRyJvwAvYMnE8t0PhvuqEw8UJc3Mf66k+OtURBvrHvcQGwe/Xl66/?=
 =?us-ascii?Q?QpP8gjnOfA21NnNndlyRwmHBynaDK0z3Qjrridbp4zWPfNNjQ5Awb/CvzUaT?=
 =?us-ascii?Q?eFE4Vd2jMAMXAOUfgZc4ymLSiT7Ycr825K4A7ZaSMmY4tLSLc44FDhPrwZyh?=
 =?us-ascii?Q?I5ETvH3tt4UQGiYpALjpILCWl2Uc5vMW4oh9PYkQNhJAAthmR7ECYsQaoktQ?=
 =?us-ascii?Q?H1Y4ahS7iY3GhozqkwYV7go+2FKA4cx9Rp0mh9BRl2I3OJZHrpVHgdJSOUn+?=
 =?us-ascii?Q?+MPKO5WifO36BismUkRt1kfjz1RGRWGj/3RyniL8d3wuFFcoUnZex4/v0sXf?=
 =?us-ascii?Q?lM0pcqwsEDmjRBsKedFcUf+7UHd3T9BCebUTVncvluvHaJ/U7r7Vdp5DvEQm?=
 =?us-ascii?Q?/QynO9XZyrLRTEST3OJsfdFvDjgENzO5ZKD1K+YV+TWj5FBvkZspFHj3IGnn?=
 =?us-ascii?Q?rJBN2j53lYoEF0bOLAKpiFh13DsQucDYOXOl42Sdx8fYR1B4d6d8D7ZTD0f+?=
 =?us-ascii?Q?jtWUKKTUJZHJtlGC8xYWuOzefFFUf2oiBgYl+GppD37D4T5M01gN9Cmk4pwL?=
 =?us-ascii?Q?dQDXmS82OeGa/jod9j4n/AnzjtEJeUt1o8nTS69CuvYg+38i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2b52a2-f429-4d9b-afe2-08deb992eb2a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:49:39.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhYR/daTN9YUc7h8oxRBFiZx7r9G2JCck7dWP9z8rBcxwq29J/nS+4ko9fai7jmDSK+I7qkWlHEEWlWVsH/nPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291180-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAF765C26AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:15PM +0000, Eric Dumazet wrote:
> Needed for sysfs show_config_pending(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

