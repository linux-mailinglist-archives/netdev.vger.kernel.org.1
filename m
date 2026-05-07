Return-Path: <netdev+bounces-285281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EK5CHd6/GkQQgAAu9opvQ
	(envelope-from <netdev+bounces-285281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7A4E79F9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC5683000B3C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6813C3C1C;
	Thu,  7 May 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jMa+i3Zc"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273513DC4C4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154099; cv=fail; b=Trg8z1fZdg/mkkvbI4Xk2X7oH2vtlp0kFMXycdJb+477aczynCmykQGSYNtCXu1JMiC2SUO8zLQav/5DpAhB2EgQKR29xvf5ESmNZqma3HhB0WKXvSYgavNhYiQKed/nVlRTF7HkteWUAAj3BYWlkq+O+ytFNd/WTw+JzHvD4h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154099; c=relaxed/simple;
	bh=pf1+XBvWLvQ8njbzMDDlN2YoTNAICJ1dB5kHKG6PDss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lwT4QlUzsYGVL+E2+yWi7JrbL+j1yT66i6+u5agpjUc0ryW6mGTBkAmg4TU7+wU6b2wC5RoZDj19CQXgSDEQ4MmIfqAFM8CVdMP5iQo0sDbh/aWZ+h8Ih290KLoPaKPq2+H44T9TH+/ThYq5sAp/ELw3hpaLeHYTK8f4Lrq/xvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jMa+i3Zc; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICdEFjenh3fgZVrmVsIDi3EMuiIbqPOFSZnrz0Dp4QcFlQ3/B2liz4AUkvhP0w1KZGkn++CMYK2gImlJ31JHm8cF+XznYGCRVhaFdyHpeeUOZb4KBVXI8Yv0Xjp5ER95CAC2UpUl+X2hqfqHS5LCXxNn4LrBpBU5Shr4I59y7sBGvBB3OO5vTagWv+W+AlwWFkhkKP2DEQHpPWiOY7DRqWRETpPg+1Qg2MNAqjA4rSLkL29gQcaG42dOzODpKQLcXko7utMPYzWdZ4ZK2hTUMNV58MK2nQCE0L/P4o39F/2wg1eZ8amI3G2X7nDYIumLY1FAEmTHZ570wjLTZyWJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMX3MSf1BeF9c2viV47fpKu7pHqNHNPNIG0MhCoSlmw=;
 b=KPYx/c/AGzqgyTN1/vl6R0oMMovIsar2bv8LXPAay+hUlRnfDUsvyy7oGusSqZ3iZE+HW0s0h5mw55bvxm45P2eKE9pzwtIFYYbmlRk4zWGU0Zw1ZrmMtsTHsVBQJSqSUl8UuiIohOW0QV6eHiVRgswUXfdf6HdYkTVMKDu+njxPd6IIAzks4vJL5N7lKuUoREuNNgG20fh0O8HU+CdbQh+3dKFe3UwB17ytC/l9S8ckZucaHnFZLr8QJRMBes70VfmYEg/A0Zy0/X5+Y9dMkDzm+anpMxdH0aQTa18zQKeK/mH8s01eF25ssqSi+sLwhjZc2oNarmTsMBs38d2FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMX3MSf1BeF9c2viV47fpKu7pHqNHNPNIG0MhCoSlmw=;
 b=jMa+i3ZccDKdPohQBYUmC2I73yGjeDsSyIlfIkiJw1M647cYJQLBwzl2OgFOYgegd8ORTfEEbC/PdnEVRzMAr8OCvoIBjVUNs5BpRmoRcOym6X5zUQQZcHq55MIdP6JQecgbCw2ARfUtGMRv2QZZDBeEHnAj1o69udWvJTqz+hHiBbbwvLIy6u3KpIbaNX7TS5gzGozXgRP3pOP0HUqEV390ZUijTOlDXqWyrS7EeBHlZlNyskaCVEQ+9x9FM0pdtlHsKgC/6Y7y1+X8scAghKfeM47m0rGZYiINEX1mINb4ci6EQf4zzUVLtt/ENhj2K/+dIPui9iDee3hYNo5TvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 11:41:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:41:33 +0000
Date: Thu, 7 May 2026 14:41:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 3/3] ipv4: Add __must_check to nexthop
 removal functions
Message-ID: <20260507114123.GC908463@shredder>
References: <20260507075606.322405-1-cratiu@nvidia.com>
 <20260507075606.322405-4-cratiu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507075606.322405-4-cratiu@nvidia.com>
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 154cfd02-d3fe-4cb8-3597-08deac2d96bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q06xHq4XQYn/zhHWuA8zjvkhOWiFuV7F26U7a377Nv8zr6wEXRmnU/CFw7AuvDz7pMhVDZw17LkyNgRMPAiG68iTsFE/wkiClOkhmEG4aUvYPcaAFp2iuMSWEvs8C92qSMO7PirBvPbcRZQxW1HNaLLx8fdEtfdk2BJlOhq7L+36f0eq2hyMLjdtacnqOnEd7WbhZ3GKk/1nW1RENx86cnxlq35n4s7CIXn9GBARgBzkbjS06FsO7ADXfQNBXVBo9gA7daefJUGW3o/eNHmpsEo3szOb9EaGCmD38iBRA053dxOx6WKL+/GmPcA9oI21+uj4n5u4OMnryhJHGK/i03LJgmPxxfxfkPQUlcZ8/nuXTjKZ/2vbLyKMTpxUCL7Rfqco4EwtR7zT7duy2orTQkZVVR2xtSz4/Qwb9ITNLoDhEvLsu+2fmBI6xqSX5DKB5Dv6Xf3qAAQYkpn/4pln9RiQpo2rDHolqAtVWJJeEhsAClmRaHhfjC8oBYTWCcAKGDjaTtbEYv5zh8cSLldVKft+W5bitQrcxPcaSNfDGazsYonfOt5V17cK/WU//qIbkcWzRUaxpR/AG4jQFhJYmlUKRan9FvphD0OMEq8eJeD/dPU1+pXr/ZCTV7sT+CrhZ06Piaje70F2kPoqSL2RLQXj7isNdM6Ewty6kcek8HYJFecu6QERqIuvbb8FVtTI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhyCggQOdQU7RaN2MSPvkywktuf8dQ/x9fYmZFk9Z4D7nLRAwm3TB8W/YyTC?=
 =?us-ascii?Q?1UU9TVgHSlbEXW6SGRxDsArXeKLJI3aWB5wjjMmOQ8JHMnGJG/518GW8bgUr?=
 =?us-ascii?Q?14d8FOVNlktRR6rCeiZXahNQLt7h6ODD4jvFF8EIWVnY5ddTXpD7+n90X9bg?=
 =?us-ascii?Q?OvNIUN0QMqeajBnJFeetXNncMWLui07PvVQPVTIa3eFaDEshCl8Wq827t4uX?=
 =?us-ascii?Q?hc6M9sD2HZaa6O8p76tu4rbjQ8e5d2nzl2VxkrYBLI2yFNpOw+EpNHQEA9AO?=
 =?us-ascii?Q?eoJarh4I6tw9Nn6gvn+359SdtOaHP0dB1PpY4p2vixl5tpG4P/JIMNqADwR2?=
 =?us-ascii?Q?x3TntYBxdTD5t2T8upVzQ3YOX73iZF5yeNkInKXZCmrTDb2rrBi09HXho2SC?=
 =?us-ascii?Q?tiUe8oKn5CCTTTb6i+UtQnUqOo6joSDQk34c+RHCF+6x2KolPRP7U1TFjw+P?=
 =?us-ascii?Q?NIuhuYXv23ZWlAbDuZsWsENAcT58OrUYCTAh0OcNSYHY47WhZHoh1uGb4qFK?=
 =?us-ascii?Q?1+Qu86lawqxZ/9je7eoIHr8J9RaLRSrgkUr+AcELtjI/L+vasMP1A/y8abW1?=
 =?us-ascii?Q?gupjGz5nssLrGhwY5pDn51K55ms2rRJ+hGWmZeeqndTvL3S0NacmD1YruqYu?=
 =?us-ascii?Q?Q60OxDFwjKUfRE+IHUCFN42ZwUbtuaNfnev9SyUDOftxYrGHSXi12LBV39iZ?=
 =?us-ascii?Q?zHSeA3t58KxVJu5ycJM01nPspaJW4vvofV1os8XYe8rE6s11nE21TqUGh/6w?=
 =?us-ascii?Q?oXmdN92sDQ7PH4PLHMHb3618JfEFH4GRhvkh6JO3dQOpYs1dBowhl0nACmOj?=
 =?us-ascii?Q?PpLL0Z5TinnYfgX3RsM2FiwjPNTNL52v2ZkqBbOd2bU8yTAD2LPRNDdZAdMm?=
 =?us-ascii?Q?8n/grPgjFPmH+xrYUdiUAclsrdECAk4B7xofDR3IO28e/mCw+6XD1QmU7kYN?=
 =?us-ascii?Q?8PwbKduOKiDExXK6VYqJYCy+57erM5UCdksvWcOEP2WwzQLshry3+CfRzn7Q?=
 =?us-ascii?Q?TOcZ9sVm1TpxiRx51WIvowe3/Vs044Jye5evqNRc/bSSj6xWOBux/+b+EWtx?=
 =?us-ascii?Q?S+w0EOe4McUJX/aJykFzg2PuFTjFMLVqFx5NS3MuaE+k3CT72yRFjkMeY6AZ?=
 =?us-ascii?Q?/hgSv1Y0NSxr0FNVsfOj3GQhOyinXpeswodJvIuys54jQkyBbSs/YiFDwpUC?=
 =?us-ascii?Q?HEnvnSZ++t9HLoGHHe2GMoH6o3Xccm/W421gZVDeejAtGQ4EBpyHmYSgjTGf?=
 =?us-ascii?Q?16Q1YTmc5YMKnxFhleh1raKvS+lcAFl5BWbt4C6ax8Jiug+ZBYuDz7w+WUgm?=
 =?us-ascii?Q?a4DZa6tS1JOM/Pg/OvR+9BN5aVoWlisWFQoolhahDqQbEacTmwF8G9JkUrAP?=
 =?us-ascii?Q?2AJyW/3Mn3kWOUIQPgeeHLhAxAKbF9WyYtSLGXm8SLn9f86dgUX4nYBD/shw?=
 =?us-ascii?Q?90HNfvREQtpgbKOQiCQ9nl7TG+6l0qkkcAQ64pcUN060SQpb2n9RWTyTnKS3?=
 =?us-ascii?Q?uqjVFZRLDL/AQ9BIvwtqC2Dl7EmlFFqyRjE1QAGqLzx1rrwK5kg4MuiUjHRh?=
 =?us-ascii?Q?L0ji75c8eNqUQ3LY4CF1nsEDTUQRnLZBwVyjU7HRJoCTcz4kpyetJ3LYZcVW?=
 =?us-ascii?Q?ayOcGSgdwRRQV6k26GliRK/NsPKuAD7GRt7O0bV72L9ZEpEKuHuNjSBvX8Tr?=
 =?us-ascii?Q?YCm2395pW4AA5GGHgZ/z5RL+Zo91IFmXgWbcbe0ZIqRkGL27tlmp+T938Jag?=
 =?us-ascii?Q?A0g77v18Jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154cfd02-d3fe-4cb8-3597-08deac2d96bd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:41:33.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v+ngGLSNzIlmkzNywQkFzZEFk0mKnG4tsf0apW1qux1/QebxrOX5Dr7sQvVo8kP9hAxzluk7C0M37yvg/wZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Rspamd-Queue-Id: B4F7A4E79F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285281-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:56:06AM +0300, Cosmin Ratiu wrote:
> These functions return a signal whether FIB flushing is required which
> must not be ignored. Use the compiler to help with enforcing this
> requirement in the future.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

