Return-Path: <netdev+bounces-276000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEbDI7YM1WlQzwcAu9opvQ
	(envelope-from <netdev+bounces-276000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0303AF8B3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD15E3095BF7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AF3B388D;
	Tue,  7 Apr 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsRsNjcc"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B938F631;
	Tue,  7 Apr 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569484; cv=fail; b=oLnBlMifOF2HY4jKjos21EoGOBqE9ZroMjdq47lgIm7EONJMwaNuC+GxKV1ThjCuW5CuOLXLcLq6aym830c9BG9wSSErF3FyJ6bSRl8FqKybtxleJFh2XJzj7NlKdEoX4Wqyv9IoKOE33dM38zIMsXHA9yEqjLQ7DhI14ya11R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569484; c=relaxed/simple;
	bh=ZS1H+Mh48dZLzXBlbyDnILLCw4HoLGtUqf8IdxqTlUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ugjrsig9bNxZEq/cuk1mAP2L+3ZfqGk/kNHG6jUXgq7zfR7zWKsrBvDYJj++aPeNv4HO97JLyg5Y9dnRY2UVcd1DFx2NR+O8czAbsaHJpi3yd86ElHe4alM4Q2HIJmIGnXLsPe3FFt99GJt5pxlJFTGvC7IG29aOh+TRKixgmcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AsRsNjcc; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlgx9L6aHIIyZqLfHEsI6+roQltD8MKeJFyGzKg4MsuTg88p19R+tDABMUN8sRSJApw58tJJBkpAAg1DmF1lMhNRNQPURM0eRJv5UIQ3sskOlx6pftGhZYYnlOHNWHWsfvmERhr9t2SmVYYrtaYYArYBBvvHHc7UfoVV0sIeGiv5iZBi/ltJI3D3mwLxSQzX9hYWLbw7ku4oT8JxntfU2R9C5hV+b3JCynEE6W9YiTqzMG8hLOTsxIbj/DMgarWv31GtSDPI2gkSEV+I9xW7c1+Lr/Shs15Fo1H14U9WQDUMlyVdFVZPIBbkwyGVoxvdYxV97g1RWD+JpuGW1TxyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O26GDhH3XruuwdfHiddiEvi07mcpi9KpOLvGfUVWVEA=;
 b=SsBshV827E6ZxLFR/EiJEAa6rZNpeAQw7HPr82zD35A0s71uIMN+UPYV+K5RGBAUbSqz0605ugrhU74PHx1ZFYROix1YOMRlgtSGYyr94DLNlixr8317WWGJGMFYt4TmBSeNTpUkAy7tc8dcEsufUfW6a1CSxzeMObzvAraEZAo4AIAOJOd5EFTjX1xP6F8vRTRfX0/dyb4uI4WcKzXE/T44k4WUMRz0x4SLYZDPnDBbNAKJg8brlyr1xGBUeOYSXfiYKSc+pK77Hbh4ZXTTdk30xztxZmRDRORJrrZlzJmGcDVUftHD/lNymypIS3EYZ8HBUUOfiTBhPahTfkNbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26GDhH3XruuwdfHiddiEvi07mcpi9KpOLvGfUVWVEA=;
 b=AsRsNjccAMjj47hyklxveQqO5kmHw+sM9Nig/WaMKcoFP7gtXkA2QiFODY4q3INqO5EuGXVwXRz7IR65BROXw+nniuPE94fpHyJLv0j7rZYdv9ti9fATF31vI+mnp7WUaLbiCR7kxi0sBxaRgMTmwGCtwIpPXddDNvl3GyqpXNVgwKoiMgt6ESur+DrLLmuX3FeNFEjeiOwsFCcsPAlBlq6EYsvu7/W4yJrPWQoVOVGJbFobDxVRW0nmh9XFoMIdk3pwhz9t2hB8/Eovtl04dBJk16BzyDT+i6dVDulTBbWcrh5XqnOuQlSXLirUjJ72a1ozz2mOFIhS6ZcoO9KAoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 13:44:40 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:44:40 +0000
Date: Tue, 7 Apr 2026 16:44:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] ipv6: mld: rename mldv2_mrc() and add
 mldv2_qqi()
Message-ID: <20260407134429.GB849209@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-3-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403150050.1235-3-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: e31a0334-88e2-4a44-9f9f-08de94abd10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RLoKCcnhB2w0o1ehcjWpFCkZ27EXyxmvh5C48Q0K1Db0v/BXV4d/+eY5Xb15KOiOj75/UqIwXN7t/ZmGnT4Wr7KSLVbBHKSSm5fzCJbSssG9MJmRFLZJyJZXQ/3HkU9kpI6s/5aTZaTiQ8zv2ura1qWZ3QCnA9rNP9+NfMYUwWzGbeUxobTuBz1Zx8WWZlwMZdtu7SKImtdMM6GwZQtKQ9qr+8V9wNkHmGdBLaOcLKNVMN3fgBo98GxNePTbyY1GIywIqrJml4lBr4/JCE1WRjiVl9/htwXUM7vvhp21GUFkpsrjcaiWkagRHjM+0Ind99oPHeHK409Uyx+rx4a+63VSE57azeHLlLVLbp2irbF7UWv2c7GO3jHo4h5Ohv1WYJCOLxj/HCNla9UTdrGvte/5KGSG05TqjH1UWNYOxspo6uG4u42+YNqOq0Rd9bL0XWbpzq0AhJL4MIefwu6lqT2LrTww/Zklo2qlM2MZI2/y/QmP3AG6uR9kwB2UFg3+A2dg6F8N3WE5YvyxSERdevFAs2ME7ETdX/A43NViAzFRNNF2Zfn+r8xrO8nEbrqxKcHdnXoLvEbblyD8yMsD0QZUzpgkxKQrH5DZil9R1NiufTvR/5o2ASPcJFAu+fd21URtVMg0S8o6AWdLSuXST7jWjZDhD8C2p6MDWnBmRhQSDY+gj8n2cjBD7d5+KPcpy6hEZ9yyNu7FTay2J9w/v7YZlSKv7xbmxDNi7EdMJY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMrKhZX+9tk72+2AqnXWw+ut/mdPGsepK7MkANH6u9lD6s3OZBP/bQFitZ4H?=
 =?us-ascii?Q?I++/3capvIvjCbRdUlk1p/Bj5zmEB35Rew2b46ZpBFMQHi7f7NRKeXe558R0?=
 =?us-ascii?Q?HJ06PqvC+hB1DH4xg3qLuktos+wIaaisHskqv4yWC2Usu3FvdDKAEPzkfQrT?=
 =?us-ascii?Q?qqdE+Bqzemn7O0y9jlor64OBW+okdPfHXawHiZ2YI0G66DmHT2MZ4GtPGnL2?=
 =?us-ascii?Q?+Nu7KT8lfMBQqYaW+jtdITVr7AW8aF4Lmq9fmtrZQVRahbHv2YCn9p4eSibo?=
 =?us-ascii?Q?FJQlz9FFjdbJl2Ej675s0nJTGkfizeCNxPrMynKN1kcJRgj/10ENX/7RZ3GU?=
 =?us-ascii?Q?wUNEsbkFMs0jY48uAaoRPaWWWvHNWc1cXEpDV9g3M1+83L6Ws/nbOEjz9BmC?=
 =?us-ascii?Q?1oda64cfELuE7IQZ8NRm5RHa+WWA68QiHUyVhh0y5OU4benKwREFRxrk2Mjt?=
 =?us-ascii?Q?CsrSkrfmcGBKKNySlSriuF7SHVutER7Ujy4UR8a+CZ8P+Si4IAQa+DWEk0q6?=
 =?us-ascii?Q?LKuMl2xtZIDRuqoos4zf33MxnabjzbqPqt1dh2NRXxknL9ZgrpPTJ4pOmirt?=
 =?us-ascii?Q?cMKOAAsw2gk9g+A6wRo4zwyuf+UGbR2nJ2bIEN7wvMzI82djV0L9mBn9Am8w?=
 =?us-ascii?Q?BesK/3GMyvpMrgHfoc+EggjCzge0ssu/RJGLSjp5Fz6J6LG6g5KXZVXdN6sb?=
 =?us-ascii?Q?GkMQig5n4eOt7EpZ0GJsoZXB60EuJoLlgbI6JnR3aBsHUia1YjCHLMulpfUu?=
 =?us-ascii?Q?ghbmpTDG0Gq5HhcDGTgGjGbxDawJAmBXEu9THYC7fHrdDGwWNVou36Dt93Bp?=
 =?us-ascii?Q?C5e92kB/LY8M9V6IXtnnfsuOCxUcSrd22RMr+HIO/RFAeem89NGRGV/5F2OW?=
 =?us-ascii?Q?HlGPALAVGfnZ4qFyF1JnPl/vho+YO8Dd1eLR6Y5ghPnOzq2D/GDf7IL9pLMj?=
 =?us-ascii?Q?X5Ae7tsfkEDvOcpWA9rg68h/nZzsnospf5Ih4S8SE2UB1XsHPUrpdTL2uC/i?=
 =?us-ascii?Q?S5QzfBRdM8XIwrpBFmOefZkGRsEJmAC6wG5kMCJ15NmqvnhV7rgQod5RVykI?=
 =?us-ascii?Q?3R/ckOppzeBoXRMXe+VDcS8xAc4Mm9i3f0UEC/hL2Fa3LKKts66D/Lp5oRa7?=
 =?us-ascii?Q?hvXJWj5W2OMyIAdunOxSdPMhfaYmAtn8s0MMOpO+YY1xOFsZy9w6SWdvwKSZ?=
 =?us-ascii?Q?hgiPn7XtoJmUooePwQFWq1RTqbKDH6Oqx4X+mW0Yy3/92O6hbo9F/Q87gRIG?=
 =?us-ascii?Q?koBSGw9gd9Hb8STUy/VNxX/GynFDLxf0ASs+KU0Q7zjMNh7ec4UNbctbjZbI?=
 =?us-ascii?Q?io+RcJD+yrK0RGIrJV+pwB1BZ9ZmsccMLcqrOc+I8Yk+TbvjuQtN0ZQnELXO?=
 =?us-ascii?Q?FXgOiglbnw4KVDKEkVa5RnyCwzHMZ1wbNXmPuElhT9i8iDxHRBSZKptfAP6W?=
 =?us-ascii?Q?NUmx6tCFjsTMiYdpBRHc8iN6RohtySOWJBolZes7XLAVTBNzR7EVuD6y6uRN?=
 =?us-ascii?Q?4IgCV9pjDTYTFINzQBzABleenjPtGQJMuz8G3hQZeMJmjdAKPC/55ZZCBkP6?=
 =?us-ascii?Q?tIXwWYjRQYGxNkmMJYzDPdWzhWqLe0sgxbOjeV/zZyjbbat2uSFVzb4MUZ/d?=
 =?us-ascii?Q?Tvp9++nizPks2Cy2NUCTsCqqpO8NMnOQC6Ew11w+gJHfB69ZDeVGyaF0/KDY?=
 =?us-ascii?Q?Fh4qUkh+Gwblulq4y82VH/o5wvUK70Q72Jtb9Drtyev+oo+4WKn9IKGx2pyW?=
 =?us-ascii?Q?ZRJPwxParA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31a0334-88e2-4a44-9f9f-08de94abd10a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:44:40.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGpAs6jJClShYOd0XPzl2Z+YCVsD6rDL8c1atTN9CUW4zLAIo2EV/kVy2R/q/0NuMqJMeLv+/OtM+YydpUN9Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276000-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB0303AF8B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:00:47PM +0000, Ujjal Roy wrote:
> Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
> the Maximum Response Delay from the Maximum Response Code.
> 
> Introduce a new API mldv2_qqi() to define the existing
> calculation logic of QQI from QQIC. This also organizes
> the existing mld_update_qi() API.
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>  include/net/mld.h         | 70 +++++++++++++++++++++++++++++++++------
>  net/bridge/br_multicast.c |  2 +-
>  net/ipv6/mcast.c          | 19 ++---------
>  3 files changed, 64 insertions(+), 27 deletions(-)

Again, code looks fine, but same comments from the previous patch apply
here

