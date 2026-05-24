Return-Path: <netdev+bounces-291178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DzECwD0Empq5gYAu9opvQ
	(envelope-from <netdev+bounces-291178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7E5C269F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD65D301327E
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAE3955E4;
	Sun, 24 May 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSqVxVzH"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EE395AC3
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626970; cv=fail; b=AsGm0Gl9W8B4mCbXzsYe4ttk+BMBwUKwGlZeT31SbQH+6egbk2BxsN/WBC1zLD+WEBjBITPrfw3DD+qe9opfBLWNJ0iUEDyjw4KTL8y38th0pRGNgUMiclSme5WTOm4KU9kpxobFzqQ6lOPy6gPEorAc5PWiaeIzetQlA9fmszM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626970; c=relaxed/simple;
	bh=6DZPb+jEyPTekneEmyNz37VvjE3AptXYoivN/SMSgx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U92vGe8l44hG5Y6WhwgxQYzwG4NL00aIOUJ7wSVCo1XG6v7qw9meHblmdztvorKbxXJCGSuhaUcdi7tbnOIWZWZDvkQxLqu53wWo3IZ2YcqWRpWeHPSzgY47t4BrXeVtJg6ZmSgaGVJOPpcRCqZnRhcn0oXVGji5gXL1hmQjzV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSqVxVzH; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4/RBfmJ+VKE9Lv0PBLKixj6y2VpFAl46kIZTf4Kixm8WlTLIuyFXXaTQLRXsMseS14EyahMrXx6XWHvd0+S0Zhn3lv3iA6YWfZzz7F4qBmWnI6eMZjhg7By77/pfiCAmPrE0LeO3SEJZ0XsUJmefQufdK7Yv88t7e2XQ0utPIbZ5J5B0emUlUx5hxydwGCObT4bRCcl3upPD3Dub10ybVWnIBsfaWVHg/L6dSKEdQbbgiWoBxhiTu2W0ijXRUJJee8Tc/Vf7xgOzbz2JZk6aMd0uHC7dALKa5FUkaJnOnuf80nOlrpjF5UTAz2/bP1mMeNYW9HKAzkDCLWgJoxlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYISHLKJpRbxAgvBR3ci99uwP9HVvBkxXLjRvGp6CGk=;
 b=TYSe9VshjjvvLcgYePk114oT4oDodcSOBV+GzwI41uBZ72LYVMH6mknZjBUBBWJ9yqv2lSWe3J5gc3Sp+OuYFuNDaoy8/DZJkIMKd6JSuHfb0H1NsqvShRZJsze9paoD1xWh27RhI6atekHlPb2QbsUaAjjNGzFkhEzVwI3EbkYz6Vi+JV+rpjAO2GlxYz2LXajDalWsDHYe4LDcJWaCjl5aXq3SbIeK0ds21FKRO9pPMA6FValm/0t3yQEI5aLcow330lVCzL3BUjHxM+ZNJIam+t+augbR7WVPqpQURNR17IN3vqUhKD/PVGrleDqceRicrNNBtD6vNm53s40XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYISHLKJpRbxAgvBR3ci99uwP9HVvBkxXLjRvGp6CGk=;
 b=nSqVxVzHY/vavhdcNS8Tg2SBLlnJIOlclxvVLYPHjSPSB+YaEegyhe/0LvNCzEbCpVggDkXZkTfslkViypDpNlptYzulIjjioETM1ugzDMDFUWYjaOIDKC1Tkt2X8nTFC36EG6Eof9bPPskRrNCIEu6CTRk6eLSW6c67CtAcPcXsbt790JERFbJNHEQuw3cbRTq4fRjhkKwykZ2qruRP2XObThkbi4SMiuS2vMyIYUO41Oi2M3qKqcShJVoAFBsAnvDmPsF97KCNtVrcReYOfj34Zanq9nOMhEDlnwqFn8njAkZw6c78fAqCoeS+dpoTX0uDEi1zhaKGl3ZurPtkOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:49:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:49:26 +0000
Date: Sun, 24 May 2026 15:49:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 09/11] bridge: provide lockless access to
 p->port_id
Message-ID: <20260524124916.GI74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-10-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-10-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 354b922d-4666-48eb-3b07-08deb992e32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nEBv2Zap/R9uvO5DC/OqhVzGrg2Z8G0TAyMvI8bbLpLbzf3eY73zj7qCk+8QkvWcxRDwtqwO0XwQHcUTAgcZ4k9kqvCa1PYfi9uFRCkCqzC8O+8HyfB1C25PJ4LbGsd59KUmEBzrhIHobj3yJed+DLTq11hLxpOjfl+n5HJLzq6piecUv47kL4//YWE7619Dvi4zUT3NHm4/Q5zZuNKkI2kfh4My+6mkUkNbupkTWonKHl8x+H0C7PKrkAv+MKg1+ih5XS4KBYKlrDALAsH94g9sQw7KCdO03g6Sfz4l8yu+7V9gADzryl1fLwQie+4CLLCTrXZ0tF5peMqLFfwLv+Wtbx3gwGwMz9PGtiwT81ByjXaoHBY6o9psqi54jVGgDyb1eP3nUInL0sDA40mqzjTqVV3gIuAen3LS2VEOReTeFXI7Seyzjw8Ibxlrz5QLtq1IxhA89YmBLHXqdlGC218cw+WNow9GDAeAfwqnmSoSzCGCkXVhJVj/Je6gPWOAhd+mdM0AZdnjBocPtkHCqGcqiORa2DoE2rhFngNzD5Ya7EaHVjh4vZziINsh/0MrlEit2j7BkgoMMVxNdGSfHwuxbujbbQ4RXT4Zj1mHYcu7G0SN1mx68RABTFhU5unRRUbAZwbawjPx41xVnPBDnJTdZmOmrypeC80fBp4ygPYdC1azzP+HAMkvtSuf5QXs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHvZxAsmtlKeBBCHj3EXUX/JLiVXJu4E0wkpbbiD9EFOaji6X3aLcugt9G6e?=
 =?us-ascii?Q?aPpSjYWz41vYyTgZV/Wpujw+o/0T3xGUIR7eKyJrHJeYCKfCO6YW0EMPSSWD?=
 =?us-ascii?Q?J7A4A4tGUrPMFNQioNdnduiESKzaaJTZNt7+SrCjg++HbE88rEH4NY2gp9dn?=
 =?us-ascii?Q?v/SDnbl00YeA6gLb/8aNVk92U9j8IQYGLGzTiiGamxxrnBvwp68lE5wSH1or?=
 =?us-ascii?Q?AcT+WES4QvDKZEZNQqWY10C0IZP37EPFJ+MLcXqftoUDXtXf550585z6+FGL?=
 =?us-ascii?Q?eoGwHiZUP7BqYnrVPr8d56peZi4scV45Ej960Yc/nbxc4lNLwQtX6px36tB+?=
 =?us-ascii?Q?AUcGhs6M4MRJfvCebVqe3nnJrxDzKpmowt7NrlUKzbXxebOl9prvjWGJoC+v?=
 =?us-ascii?Q?nspn1wrcSkQA43ztIYCFAav+v3qhQERZZgYySuPrAPXRFZA4Ar/7e+ulUIqs?=
 =?us-ascii?Q?kPAiPTIlWlzDmLOE4DY55YKOVUjoVxImVkJute8/uA6lC3Npv9cOYRwI8GeK?=
 =?us-ascii?Q?EsrObPjIg8HLoFUfE/tCfZBF543LzC6fhrbM/QHUAZ6xSvRU9eeBYXYIZz4a?=
 =?us-ascii?Q?NRu0LKc/HVQn/B2kuwZS1uzTngrJFsQ2eGG48Cpx8wuxNfUMeIsMebNnVk0n?=
 =?us-ascii?Q?Q6YeSicW8KzwhJK1eCgP3oYVpHEPbukemeS+KjAZwKzml9euUkT5b/qV6zbz?=
 =?us-ascii?Q?WFwabQgqQQR0jOuE9P9Jl7+e5cwxAc0FSEd4GhROLWUP3ePFttn2ObSoQrWj?=
 =?us-ascii?Q?w11ojQErhCr6SJpEjC6NNXh8HwKur2YO5B90DS11rZCmSFOcMF7cZWNOypui?=
 =?us-ascii?Q?zatYZTKQ/k/ok0/rs7Blx2Sn2kgMAX/uYnO4m+LwAEuFId5whHVmDNzsOfNF?=
 =?us-ascii?Q?RovD6Leb6NBUdSx7+3LcuTLPx2J2TVPNfBcnGRUmJQMtTxepm2ucZsr39+7T?=
 =?us-ascii?Q?z1Y4slUefneagvcMPY63fm3t/O/YbKo/kI+wK0Dx1Tyk34G5VAcb3/R/uhOd?=
 =?us-ascii?Q?4M+QpCwZ7km4usMEwjGS3Uyi89pnwNsPWuJyzd2it50DWTcncVKa+z2QibnB?=
 =?us-ascii?Q?aV2M6FP+7hGmPJvANkNbVfzzF78KZYKpTjVyfsaYEc0EOz8x9nwMXU/dO8eJ?=
 =?us-ascii?Q?KSeC8gE1L9xmDMQ+eIIzb/EPJ2L0gyPZFDz0aYjGpSLhn5FlSmCshJZu3rwV?=
 =?us-ascii?Q?0zxVDqEcMMYnaeBO07krz1l4pScSDLevX5jBDuJb2BgIYr46KJo4CGw2AwN1?=
 =?us-ascii?Q?Ra+JPCLEo1YTGN+3CsgjBRwYHguN5xWCHUMgik/EQ0c+KgYRUlAn1z/xkTKp?=
 =?us-ascii?Q?nwu+v8/Ki67DFCj6vVRuzSk3/aEw2B8EEaJd4XEPZ1Qp8UwTKkDQ8od2uG0C?=
 =?us-ascii?Q?OIRkGTbY7KAcQYSWCcmkcnqr7BZdRXYmFJ2cyHQd8WKaxnkkVpclIqwBAbhc?=
 =?us-ascii?Q?wn9aqbhgH5lbUzlF5OC/+8Gtq2XkSTrKOTnliTWm1jHooJKMW/oIWEd3jOJu?=
 =?us-ascii?Q?fSldg0L3H3JJTxckyCZe3bbo27iQsECmwcsicLSq6cTOIlov1GPwvWTvbkRr?=
 =?us-ascii?Q?CGAKgWrs9f4TiLLc0nlmWxkzHzEEAJ5pY8zFUaGk/V1GQZOgTo/d3POfhrOf?=
 =?us-ascii?Q?iyGKInTGopToiGemoW8Q96FiNlNRaEqWe4Cz5zEF4lZoKfILmadjTYQ8fzVh?=
 =?us-ascii?Q?reNIcO+Oe9sh+s/4ec6QOkpYOuHNtnM6Ma3Lr1qGdUNdYPMS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b922d-4666-48eb-3b07-08deb992e32e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:49:26.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4CdRQyxl5HRcTNVz51sJ0uW+UnpcHO52MMYLbC3VB9Mt4yiX8Qk8UaZsv6n/qml3UCOveWc6A/mifjWnjiCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291178-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 81C7E5C269F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:14PM +0000, Eric Dumazet wrote:
> sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.
> 
> This will be needed for upcoming RTNL avoidance in "ip link"
> dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

