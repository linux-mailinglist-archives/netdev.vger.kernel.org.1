Return-Path: <netdev+bounces-302094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lEXYL5v4PWpf9ggAu9opvQ
	(envelope-from <netdev+bounces-302094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 05:57:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D386C9F9C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 05:57:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FhMRmz9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302094-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DFE303C639
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20028396565;
	Fri, 26 Jun 2026 03:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF962BD5A8;
	Fri, 26 Jun 2026 03:57:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782446232; cv=fail; b=k2kvBEgIdZzkY+hnSc3QR9MKT/8ZvU42+CPoURuhs1uA7995yySk3+23rC1fM/scRcPLB3VkPUPPAE8Zx2Tq2SuPOlp8U6YL5ssG2GuMfJR09TyFKxfRJkjldoEqVxyqvPDBJNqCR9/4ozAsZYShLZXODcr7Do88MhEff8l9VXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782446232; c=relaxed/simple;
	bh=IG9cWY7lE2rTB+RGWHYOVBSrxyp2d74NaejiZSLrYXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8J1zZrnwQSQmbtdDsP3cV746CTyJ/rH538P+Bsmxhl7GqXQwMFrfcKs8ax8mgeshaOs79EbVxMu7FbPp6if1y+yBwRKXfxlfeQNZMxtLUlRzlFL5B4W5j4qE5FLZ1MYfLy28hDDJS5aagnMbyKhB0ZTFgQ7dV3p+P7XS7QgfTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhMRmz9o; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfZrIx9x1sjfG6W7Orfy/mavWKVb8YHxRDTnWqTjxS9f5nM/IDe4Ov4L5y/lY+WmZcpxlkdqaTle57WciVeJl+WuTR7oLBQ0/N7Bnc9YeJR4+hg1HG7GIL5PQvCYSN4+1/rt5a4EkdyUN4TsBZ8zDt3KLnPlGg0yM2kxc5XfBkekoW35Ri3MgZcTBvs9gqnxCRlr3i7ZVwIOI8txcJwSs8FafFXvVQFhn3WKGbYmpCXfqv2yAAdd2GMz3NO3hHqRZUwanEKw4Ud7G02Js/eDRc6B7Hx7vOe6QYS8jZ2vp+OQc0xeoXvG/x8m6s0AGhgmAK/SZe4wCPyg2LBuca/l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMajQ2Y+KyWa5MU1ffqY9sbh19mayXfpYn2g8RzX9Xo=;
 b=mVtQkPMB+m9X/Oq30v5cxKrGNpCLc5PK5OHBDfUt9RZYMpJ/wSOx4USEDM5j6YY30VA8EUazDU+uzai54MAS1PuYf7FEhgL7M1NvcfihTrUodbJVdVSB/cRVjfbYgnZRtWtB+82Ck8Dz1kSSB+BbRO5j7Yd6YI9YvIsDAplZNjmJVharNFK4+A/pwu3wQA+x+oceitLuoyhgTxHhWWPZZUy4vrjpvrnQI7dh6uakGpI8UV41sm3ScyQNtl/SgYX+uPYGD8Ar+CUT08om4K4YIRCmxz7hkstxlotcQuqP/ZeEYKGN7+piJ9DpQNZ62wxW3k2kEjFe7FHeereQZPz9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMajQ2Y+KyWa5MU1ffqY9sbh19mayXfpYn2g8RzX9Xo=;
 b=FhMRmz9orVUimb1maSL62wrJAiXlBSqADSFcK2a+8AItON6R3bMHXKz2EjBGU3odY00fhpbM0bTKAGlwXFjInndAZzAf3VOmEjxRvGUWL2uXAl6TlntUTkelfS6iV3oglvOwdaLhb2J3spipw+mNXxRSYuFaiKBKfREOHGYsK4d/vzaq/FFmYrKanPrBGjSgn8Z3NQMqArRSQ0AJLy9+afyxpkJtrRskFYzqQCbayNGonBf7bxHe49o9A6HSdu1BpihX8quDH9N0LaY8pGvhjoUpyv10yHM6F3gih15c4IGE30MOrxPaNKg6YnPNltOqb9++RSstrIgscrxFHfXNHw==
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 03:57:05 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 03:57:05 +0000
Date: Fri, 26 Jun 2026 11:56:21 +0800
From: Richard Cheng <icheng@nvidia.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
	dan.j.williams@kernel.org, edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com, 
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v29 0/5] Type2 device basic support
Message-ID: <aj33zZ_19GzRcRTn@MWDK4CY14F>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 630c4124-55c7-4473-ed94-08ded336e73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	UfYghTp+y3VhVisyaefY5UV6UqAmFe8/5vJlaJEZJRoO7BW2qHr1FSfqER/Y+mERakFGAkvjfVkgC0fZ5agWdJozWEKJNZfatYoEC5pSZOuXCReukc/Low6SpzoaUrbaSqoqlLYPqjG7vmoOetAVY2gwiwiOqoWUzsk6B3282bYD4W01Fhbh/SgicWEomlyrhBxIRxg8bKxqYFSISb6XsVBF3y9Vg0Irpov6Y4iKq57CTeRb4vVEwUkB3AiZ4ss5V8sj6LrdP3FhpubyETxtUD1e2yWKTRX3Teo2UJAj+v0MIydr7f7m2f24ZxpuVPMY41+gMHWBRsZrl1gDfqt4Zef4f9KOuwOzXd1RBLj/Jn17eky2zxL0bAkLvG60CIt+O9DVYrhtCvq5CfGhly22CnsxvuIL66T40NhHteSVNmwMAowH3ozQP/JDwkuTp4Rb7aBkEZENYcnqlbdjCc5nKu+l0syuetxHhk8rkWxKIrqGL+6RO9yk+oCm8uW8M+xohqPnxlfkgAh9FxDnCSp3azfZQ5zNhtstNyuA2UlPS48lwHSfQjU8GjCNRA/DJjRJBsOejDEiTXlKyo6OSAcmEC4hEP8gZH3C77Dsgn7NvONycb2fKmD+Wunji7+QePW//ENgOuQ81FzmUxk0fHXae+2pbjxNw0fEDvTSTehY5Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9hyj4XnrRX8X7IApY3VjgLDELNm/xQ7l7GKEvI+i6jfmQLpQuqLJ1BJEmQ1?=
 =?us-ascii?Q?9bSCGnNjTvvKqIMDnbm2a/+VNMDHV/E2XECVT7wIlTwuRmOvevP0nZnZ1jSk?=
 =?us-ascii?Q?crfHSJ2Qo3BW8wTC4da7lJNgGzafwd/Lf3iTKhtnp8a0bfry4IjhwGciHJI9?=
 =?us-ascii?Q?jT/bqKjhsxGmp6igmX1y5KDnD8erqcVjjNCp0GHQiVeHipBV6WR8/i8n18BU?=
 =?us-ascii?Q?cA9wvjGTohVOS2U14Vy9lSL7Xfb0GbtC6OabDcFl030M5ALthTvLjmWrwcgC?=
 =?us-ascii?Q?3Q8B4O2RwERhsnDJ1oBk/FD92qPsxB7WJxnH7MbuxFI7hj4xr9V07Sqnn3Aa?=
 =?us-ascii?Q?o+tLzonJh23W1NKiwBvGk2RKc4DwjGLQpfJ7jQ9BITuuYYoMKCE+G4gIHl+G?=
 =?us-ascii?Q?r1A0lRZQwTQGrGl7fH9HM0zV+o0qcKicOOzm++XNrjqcLAMz0a3I9gbNfLmI?=
 =?us-ascii?Q?xX/ipFznqn5sFJ83VwKPZLtAMROLTukAN2aZ3MtJ2knlssRXoAjOkMONrV90?=
 =?us-ascii?Q?HkkMTTMB5dPO+dpnwXSTltGQuHnN/fr5oWBW2IZ4aDOJDNIRjRgSlqJqDTLv?=
 =?us-ascii?Q?iMBWc61onYr1EMs6qUVEyDtwnlnsE8piU3hMvlgGNoTF586Qke7WhjPIllRq?=
 =?us-ascii?Q?Jofv+cJDzjvZsj7QSpo5CkwR49a1km3qPBc+VqRBCmDWXwAfrtrfcPJd/JTZ?=
 =?us-ascii?Q?V3umFW+mk3nuJHCYEj2Ub/nEDV2ZeNKuA2bXd03TtGCW6aopJrsq1Ms81s7j?=
 =?us-ascii?Q?J0mSutZt8bHBX7ebUvGBb0QTb5NcRr9jiNrXC0JfC+7F7rEGKCigoZvC0JMl?=
 =?us-ascii?Q?8fJur55QX9JurRwI30ITwQuUprYO5ToFOxGQs1K7cf3HNbSTGLkI9YkNdF5E?=
 =?us-ascii?Q?2wPIMSYWBB/9NnVpLIIqRdZ8CG/mWvI94ga8SNwJepGMv87TrUehT+VEXcLB?=
 =?us-ascii?Q?ry339sru3foyZ/TReZXda9Ih56DauEFpj/LhLJuXfxnkit+8j9c0OxfV7yKu?=
 =?us-ascii?Q?I1czI/g+444Ji7yw81M2hfSxdbvHA6Efsakh1x4DoxoVIxPgTCYueog/WDD1?=
 =?us-ascii?Q?0jmhpir87Ec3pMF+tH7ZyWOnVqrjqi+a7c3F5hgZFW+ACf5YVzxI3Hd1rwIb?=
 =?us-ascii?Q?7JAVUaxeFSgFhad/TipdLhpR08OmkmIU21FlXJbAFzE0Zfm2nxKioz/2oE33?=
 =?us-ascii?Q?kAjJFjvbjeVOHcBaCEoj0q5jANM3cNQNRjPVpkfbtaz+3HiAQKYD0wEqQrC0?=
 =?us-ascii?Q?tpDgqgx25z1eEQFn3XvL0U6+rSdNLZ64sIewvc0lfyP6S1DwpZYiii/f/kYA?=
 =?us-ascii?Q?Z4l1i45EUcOokmm0M9LZYpSUs/qWGmyw5cVb0zeD+wQhdBg0vLCAfbFFRKpd?=
 =?us-ascii?Q?f/1n2UxN8N6DMk32fwQrbi6tOu07jFiZptLRjpIkhAJscPoo3x7koL8EWSES?=
 =?us-ascii?Q?MEZuNUUs1vthc53Kz2aO0+tK8uFl1NG81cGdI7K173HWb8PowCCXL/htgJpr?=
 =?us-ascii?Q?Hu4RF3t0eLVDo+yd2kgXYapeJ/jIu5q2ElwQHfq7sk8FUXG5meniPTXxCgIE?=
 =?us-ascii?Q?41akCq1+kmTsFQMfcuBTQuPKQpARnqU2d8CWneK7pVUPFOmgyLjIKSRi9LVr?=
 =?us-ascii?Q?NR+j84PtD7/uf43Ty4r3Qurbv6oa7YStfyc+03SPtrCCm5f/ZcorV6bfpAH/?=
 =?us-ascii?Q?jdAoKJqtZd/nm931V9Ge7tOOSFtUFSnf9J3qan/y1cVTK6G9V9Zjz7kGz07L?=
 =?us-ascii?Q?sAiOEM16ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630c4124-55c7-4473-ed94-08ded336e73b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 03:57:05.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NNhmicpqLo6v6/LUBoYbMfsnv4nit05tcZsfzK1L+oZln2Y8xMICFZnW9hvQmynL9IYLVzeJdhLat7qsu1GbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,amd.com:email,vger.kernel.org:from_smtp,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15D386C9F9C

On Mon, Jun 22, 2026 at 01:40:05PM +0800, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> This series adds the last bits for allowing a CXL Type2 driver to obtain
> a CXL region linked to the device HDM decoders committed by the BIOS,
> with the driver being the sfc network driver.
> 
> Changes from v28:
> 
>  - patch 1: 
> 	fix doc (Ed Cree)
> 	fix error path (Sashiko)
> 
>  - patch 3:
> 	removing extra + char (sashiko)
> 
>  - path5:
> 	remove stray change (Ed Cree)
> 
> Changes from v27:
> 
>  - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
>  - patch 4: add unmapping if error after efx_cxl_init (Dave)
>  - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)
> 
> Tested in the cxl_for_7.3 branch.
>

Hi Alejandro,

The series looks fine to me with one small question in patch 4.
I don't have the required NIC to test it, and not enough knowledge to
give a deep enough review, I can just say it LGTM at this point.
I'll leave for other guru to give tags.

Thanks for this.

Best regards,
Richard Cheng.
 
> Alejandro Lucero (5):
>   sfc: add cxl support
>   cxl/sfc: Map cxl regs
>   cxl/sfc: Initialize dpa without a mailbox
>   sfc: obtain and map cxl range using devm_cxl_probe_mem
>   sfc: support pio mapping based on cxl
> 
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/mbox.c               |  51 +------------
>  drivers/cxl/core/memdev.c             |  67 ++++++++++++++++
>  drivers/cxl/core/pci.c                |   1 +
>  drivers/cxl/core/port.c               |   1 +
>  drivers/cxl/core/regs.c               |   1 +
>  drivers/cxl/cxlpci.h                  |  12 ---
>  drivers/cxl/pci.c                     |   1 +
>  drivers/net/ethernet/sfc/Kconfig      |   9 +++
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  41 ++++++++--
>  drivers/net/ethernet/sfc/efx.c        |  18 ++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 105 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  10 +++
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     |   2 +
>  include/cxl/pci.h                     |  22 ++++++
>  18 files changed, 309 insertions(+), 70 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
> -- 
> 2.34.1
> 
> 

