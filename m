Return-Path: <netdev+bounces-276001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHf1BfQL1WlQzwcAu9opvQ
	(envelope-from <netdev+bounces-276001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384A3AF7BE
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09F5E306B400
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602D3B6352;
	Tue,  7 Apr 2026 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvZnT6kQ"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FD3B388D;
	Tue,  7 Apr 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569501; cv=fail; b=atyWD85uqtiGc8agAhfwDC3Sovi3sXqcqKNRqrXnMyzLMR/AW542ugcQ9Cj/QTyXUj4T9l+WCf3l4VlTrKxAk+70cbUTmNNSbzM5SSkuwYUt5ShN6ubAk00IHpc7NQIilbXBTPfpf9poaYL8ktOzUvclEk1tT/xSYMhGnnUDmwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569501; c=relaxed/simple;
	bh=ojVjGZ+oIh/reVKYq8y0Y/bFZlQ+U60xtI1JLOBz+D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srdBpbQYDr+oB0DmtqSGFmauu/k04s55XtV6SXdO6weNndo8oOttF2xi7WAX2PnQlfBvrPABxtaYo19qOrO/Wshgjk3yFpALj0JlWk65vyIT7W9z5ev6QSwYtQF3a8GSE7Mxp2GEMahMVNlo4kmCw+NTYs3raZWkLG+ELtKhaOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvZnT6kQ; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBxQ2FtCjYsiXEegsr2lO2T1ndbrYJ+/G/FLSinA7xhNOV+vJfX0GrnSMg/a5I8+jqO4aBFgfyHz6q44pPwBPJbqc+ZsQ2qYfO1ZsEeFeaxQQKToVsCXYSYCgyFc2MDOco6VysNXBuGWngMHJhUef+6ww3wnJ5rPZEv/8JE5K6dG/QSdiFoiQNlvi0MQpNP6uyfloO4YgrWgdI4IaXbwIrAysGEoIsjkpY0i9GvBIdccsMSHIe4S8pyfGOkPgVeV5UzYq0/IPQvjh8kvImRTF6ebWlRpdrDxtkOAhHpdKpjZyYTjWEIJ81RQeChXlDznGeqIA2HCT1j6UQjHWkyipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEiotq34xGaN3fLif8tp4MNKQQWlzpXi0jbDAIsteUA=;
 b=A3LKO61kW7mA3szp5NN+Ygfd1F5Oxmm4wrVRQlV1T23MQGmAKQnBPj4ospRaFVFNPTO0+1LdMrpPQvGqJpRbNqQbKvx3VpIsAHzJu0kfR+iYM/ZneLW8AM5dzS4jaP+t920Ss6QfHhi+4HiJPHeMgTBe0Y+0BtdG7lsLtOrUbS/vqtRj1F9aFiAH1fvz5MhAZsQwpwlN7+44HpnLXm57TFZrfgI5Qt+s2dASyXUo+y1uXok9D/ZqLu/MYIPkZ8KyhT+cSi2v570+JB8pU/eyVpjrl6vQJwAd9kzvRqfyClJqGJ23N4qqmq1os8Fmm/r9lKIUFyR8YXA61so07cErtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEiotq34xGaN3fLif8tp4MNKQQWlzpXi0jbDAIsteUA=;
 b=CvZnT6kQMn+FULQuuRpV6VIj3EVOBmVnoRO400HRg49UJsDgrhSrrqh03Qy2jNmTvZZNPUKCudl6fgZ7T/uyN2PaZEWP8Mb5bgK6fy6N38T51JLim+vC9O4bohyqr3ehOyKFHqcfRGLokMYRPc4616R5fgIe73e/rOAbgo3UnL0sFysy/BK2HHlyVdKd0hhbolRXcRpZ2mPffDhi3Vtw2bqD+nj3Xlo7pjxRqveSRRX1M/4IpT4KhpLV2yZ8eLwuf7vSElVSmZRKmAL4TgPEnm261E6CERnhcTkPtPpOrTbJ1bn+H0U5+Wda7oy59jND1NEm09hS/89obu69Krsckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 13:44:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:44:56 +0000
Date: Tue, 7 Apr 2026 16:44:46 +0300
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
Subject: Re: [PATCH net-next v3 3/5] ipv4: igmp: encode multicast exponential
 fields
Message-ID: <20260407134446.GC849209@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-4-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403150050.1235-4-royujjal@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b11dba0-cd12-4608-ffff-08de94abdac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rs44qL/eQM0ZTLlcrPTXATrxpJzesoOrd2CmIZPlviRT1vwdCGNSQZYQ8ADmsgOTEqHgGJCWA1/KwVLIaRUlQCUvdOgMLz1QAwK9Fh+gNmSIiypvMBW53i9exh2buQKLnzqVl0gYCu4Ip7zEfO6pC84mg6V/xAN1bP0dINMno4XhHS2r3By3C8yh8fezcKd8t9NCvelv2ANqbY2083Ss9qCNemmhcuPz2B3A+rHYf1e6FUR1XJNPD/f0sFa/Kf1y4cF+FPbvKkRxRuTHc5E2NuXzYZ67uJN995Z8i3NZfigW3Y4XlHZzOt9Iq5qBNE4BNInHXyVz98r9NS6Nv+tkGoTY4igOBq8rBJd9VghTRIdr53lZVlJbxYq552XdWlzU3JfwNGQGhupHQzhblf5w8WvkW3jiTRntba0XN/syUHEWfaorOyKx+OabIDcByVyzoY2KL+PIDBbrRHD2+C+mUP9+NDBW/zF1kycn5i11CzpOCDjffTMyEiHPVccZkyoIpz8tqW4Jp1FMszhrVpl8fRY8v1+W/ahmclvhc1GN0lMEVrQmW7caz+NC75YTXl6ORQ+E0TAMrULWZhg5tGmMfrlnqXx3GfvgnHahtEO3HhgYSY7rZsMrNGt9+DbzewBCNnaJCcQzGwwZmnCTLBYP/NEC5m3gp4jQTcb/Nsi/gWyaILJhQedUDQkYGX28KROssf8ircSfGQnxdtgCCVKSRbesGl5757iaceqnDodpRx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6FdL34+IZiqs80UQcGNYnEZU6miGj1rkO09dLZ05NOWQ9U2dQleM/sH4jryb?=
 =?us-ascii?Q?wjMbP2Xrwc4i3VYOu345QYYIxzE62o+YbjKOD3kHWb0eX8fjP/rBGYorn289?=
 =?us-ascii?Q?VxqSJagC0cMyTSH9lNmX0/ZSvHTuodsl/djNtyPU+D/eYDREAs5/s84FvbNz?=
 =?us-ascii?Q?RSMAmc7RXT3u4jAgbqZ38RvpFSzqw3PEg6ysvETaSOjvzfoZkGGNOAX2dx0Z?=
 =?us-ascii?Q?gTkaYdl6nt+La43fyH8RhfYmgRom9l1HdSdQYXh53cJ4RgJxTFSFccl/pvP7?=
 =?us-ascii?Q?DitXc2pAzqR7uWlXRkhqoWuNtoVRlUHJcmJaO0k7xJZZDZRn47TpzVNuehCO?=
 =?us-ascii?Q?sFDFWUmRAo4WJ+zYrfTbRCNjKqKeRKv5osxAlFpgsVuWhA04pKmzL9f3yggW?=
 =?us-ascii?Q?Kb90FlZ1AtHwVFLjyFyy43K9jyuFKY2V5Cq2Ls4zXmqK8A2HNp4a24L+0YXm?=
 =?us-ascii?Q?bQy4M72KGZj/vG8Mo+DabibNRbBbo09Ln4PCbyPAJNyFeSNejtUuU5Fbortr?=
 =?us-ascii?Q?88uLv25iIUwEpgXrEAk4uD4W3WNq4RAbwW81s6pxDqySMg2N2PmWEq6cXybC?=
 =?us-ascii?Q?pejfh7t7dVDtULtBpK0BbHMYaLpS7V8voOsoATKDMRqZTaP9xYWMsIY/Jg0T?=
 =?us-ascii?Q?R4I75yQRX+H6oR8kAUirpladBzs/hfy8mdPX9zqzpNaenJD043qNTnpQLW4p?=
 =?us-ascii?Q?F163rVWiNyDNclAJA1Vfic6zYGs2YdPHrB/2l7CqUSF0IRLUc3+GgHiW6TRi?=
 =?us-ascii?Q?ai/HO+zC+jMRZ+CetoNcpNygH/vl/ZF9ysD8zPyQQSFgHM20gjmtBUY3D+a0?=
 =?us-ascii?Q?SP41xPItrKN5VNASWARN+lliuHFx/fFT2Nvlx+3NlG7kk4EQF8J5CVAi376u?=
 =?us-ascii?Q?aP9IkyJ0wUw/EnbIo/MnKSTIWRYmCjMi0eW9UdAE/IGIhvdaBZO26EeeN4ux?=
 =?us-ascii?Q?gwPtDpR7bLGC6n+1TLD8qcSIombRTsI00oCM2CGAWiDj/eVzd2amZYA1BzHo?=
 =?us-ascii?Q?VHDDl8irQL15BvOfVs0iD9VPSTPtpwlQOSPrqUiq5xlQ5+U0/zRPY7uWqaB3?=
 =?us-ascii?Q?90F/NSOcIcYLPwJt191tmAKwGNvvL247xbJqUcmo4OUsX8lwbvoOtv777+Bq?=
 =?us-ascii?Q?maq0f3jyn5PJCBi1ecIW85wjmFipCoS1sG/ipnk5IxKrzGqSWdgYzmLFM98J?=
 =?us-ascii?Q?C2bZu7og34QD4lKkhORZCuSkHRz9/kXT99NEBZxqJjlYswO42QRHAEa1Sn5u?=
 =?us-ascii?Q?hN/AFXV9sz+Hvct3UkSvudHp3H1yhaxGyS1A6r6HBclDKJUIV/gyKV/+woBO?=
 =?us-ascii?Q?K6qll0sZ5NghQBtW9XFImy8w/gBxuNpYk0adOYvsZpFQT+5NajsmfODizv/2?=
 =?us-ascii?Q?aikUbKfBOehh3bncG52LxP+/zR9tqBxaAPniq2yYZEy60rOv1pNCYQ+CGYic?=
 =?us-ascii?Q?gWLkLiamDnvGgzVoM2X0rPHq3D4cWj9MBM4I2gqU29SuJ0xBrDbZkgV3ajYu?=
 =?us-ascii?Q?McxOn9BR0jc+PYHdP2yLpmqgIs7hl8UkA/Cvs4d+j8WeuZcksKk7sQl0Fg0u?=
 =?us-ascii?Q?/YatyXpNQU7H9ayHt2yCCAA/3AbGsPCAOrYkwCmhr1jgNfYURmFm+/7x9eIZ?=
 =?us-ascii?Q?sbcZfFDmYav8hPPuVWyi+goC1wc5hN2rshDeIt36MXSd+8OuHpGILJ73lstM?=
 =?us-ascii?Q?SJLqoPcmy0e9hgNtVDQFBteL77MKVYOEVWjGpLvix8UoFZTLWtx+7Xbx5ttp?=
 =?us-ascii?Q?IjlVD7t8Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b11dba0-cd12-4608-ffff-08de94abdac7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:44:56.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ1lRfqdc5LRv40sJgRAV9fR/b9zep1ca64GAykOMEuLWTifoBrL1WMuDimtCNXDLObKNAkzrzLeCw47U0iuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276001-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8384A3AF7BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:00:48PM +0000, Ujjal Roy wrote:
> In IGMP, QQIC and MRC fields are not correctly encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any value that exceeds the linear
> threshold is incorrectly parsed as an exponential value,
> leading to an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC and MRC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for QQI/MRT).
> 
> RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
> a floating-point value as follows:
>      0 1 2 3 4 5 6 7
>     +-+-+-+-+-+-+-+-+
>     |1| exp | mant  |
>     +-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Same comments as on the previous patches, but otherwise LGTM

