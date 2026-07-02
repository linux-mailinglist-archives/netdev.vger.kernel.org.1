Return-Path: <netdev+bounces-303989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id laJ8KhcFRmraHwsAu9opvQ
	(envelope-from <netdev+bounces-303989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:28:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC46F3CFB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:28:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=WE2qNO7B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303989-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0718304D7D8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E3386C31;
	Thu,  2 Jul 2026 06:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BED363C51;
	Thu,  2 Jul 2026 06:24:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973458; cv=fail; b=teuldTYiroWbSlc59piOxJ+J0bYTVCjnDJozOQ4ORE1rypzxFcd7K2nghAcbIwQ7wcLUwChKGOgWf1E4L35fJTAKhVyCv8mk7tDmVA0eAl0AopO+OmRsJAquyTWBGqA4guqsHXLgik10Y3UOaQJ+AwQn0tJ0C7VTTDJsOIqyye8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973458; c=relaxed/simple;
	bh=oSQM7i113ZuE1wqdvlKp1zs3slcl9CgSPCuBzzHD5g4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igH0UCQa4XiIY4wv59j/zU3esiu/85ZuaN5iJvyIBi5bVmbaPDlHYykvX7Vpauj71z3xEPq7kInb/67wg8aHV7KoDA9LZKrYn+yg/dGIiD8Y1LEi0MBpDxdSBL1luZ+6n99VEGJ3Lblm1k1H0RG/JUjbJyVv999HTeVZaEi+Wbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WE2qNO7B; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAM0qofUmwfTgLL6UNXfAVVKkBM3MnrlvdwOfmbF7sZOa/V80wXOn9x7zE4GHefiUQH5jAmnLNR5rsg2wksQpnm8jY2qhun3fucfGdt51w0L382OEtUuu+kc+F5o3CA5QMIB4w1JThu2Gmj+txfyG0jfWTQka/wbLNH4k0GiL+2eme5o1O37WVX3/Qe3RMhr1NA7gttHhm3sNJxai4+QVGspnYV2p9uZXvaaD3ulYX7VWQNX4j3y0mNjk/E5Mvdi5voASLO29DsmMHgsjLqq5Lc1YSBakqrve51JGG6ckLCpDcMXi1ij/siOvC/Nk/KoFssviu7wikiibKA0XELoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2P55EZO9qWdrbWmXUYa0EeYRT4i2zbzoevwoCSa11g=;
 b=mgKPrpsvYPD/UfKf4oumqb+hgJXXyzmzwRSg6gOLwcw1/P7sz2MLpXAp893oqEPLhyoqEEsjwcpjAl0wTBqdhXXzymlSKyf42EmIRMVmHItWVGPNL5yvCX6ah/sTiG0/rM/JoL3O+Dva2d/4kVkskEAlvUbfUlXKb/wXd1S/B0k3sHM/K29Rpv4q1ZyAQw6cR7n9I4wpYMW7MLc2O36+CBQ9nI9ogD+g+viqGXx70LzxCmZbwnvW5Q6C1WjLcTQl9yhUT+1oJ28+rGAQM2cYAPdHbB3NeyEu6jAqapbS33l+iVTMBmQ4mKpLBaXaN2hbzC6zJGUo2t1CEH5BOkIQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2P55EZO9qWdrbWmXUYa0EeYRT4i2zbzoevwoCSa11g=;
 b=WE2qNO7BOtYQwhF9FCDNiTENJr4wSgvbdVwAemw4yE68Qa3GyTzUxiJfn9tlS3lXExOXKjQeyVTpBCOtEm8nFjEAC8lihR0OdtRv/MPiwHimHAwN/EG3X7kGCgv+jxkF3+poPpCE3EKlEy13KYRu3F6S1naXRDjYACmTVIJc8UYZjrmjZSBqSqEKZmNa7QfZ3nUEb5st/u0v/JJmG1l4B3gjI5IDxGgxu72fgLph9fqW4i0mGxa1jxmDEPkYOHqaak3A7TwzSBjkkDxOqeih086fZdk6+eHva7ToTE4sjAGR9LfeKhNArekLpsCyTSHNtMHkIf3qnm1mhU+i9wpcOg==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 06:24:10 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::ae) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 06:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 06:24:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 23:23:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 23:23:49 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Jul 2026 23:23:44 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>, Willem de Bruijn
	<willemb@google.com>, Wei Wang <weibunny@fb.com>, David Wei <dw@davidwei.uk>,
	Cosmin Ratiu <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next 0/2] selftests: drv-net: run XDP tests with both IP versions
Date: Thu, 2 Jul 2026 09:23:46 +0300
Message-ID: <20260702062348.2123960-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b220315-7178-4698-12eb-08ded80286a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|18002099003|13003099007|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	N+Li3xpjkCc1ia6kcII4Cj1mllY0SGx5zmwSrZQdps0jE8DvwhfM6W3jXjSzs6JWYqzbyx3PZBRZaqLdBEzPGjVWoWGhY5Uq6yf9yxxev7XYEC4eKFPVu20L2CPslsZu+W9XBETE2kJBpypZAS6bpBTj8EDwa/eLa6WQiNmswjuD19eZ1uxD70KgGdalDpo4f3wfHxN4sxpRw1DwHsUsM/iMsoxaKiIcL0nPwFFHtJafCBWi8jE3x3yw8kYa2NLYECJ+OtE1IIC3QZUOXGPglaTlWsV4rm1FjVODqfVvvAwcLLGoz94YC7zP2mfJzFus6ST5hfX9Kp7kTV5EV/jp1VLeVuFacQDkqmmvHsqUxjTt3n9fgBhELMbMGn4aOJ+X+YYTXUyy5bd7PHGAW5v5AWtm3uq3Mr7EohDAA3/tozTxfWpFRP+QaUJ1LN6zjAZYZSv9RQg2ePIfdx/5yx2OpxBBDp8UDfR03Edozd+lEtzHzA83lCu6T07Q8+bCburY17r/hSQZHT5Gqrk8OPAfv5ek6ZDfSSSZcFQ3Fr0DNhWfkQ7CMGlZYKu1WI2qwXiJ2mEZyNA1dEMDQFY7FQr251yiFkCokgKCMoToIg37Gddm1Kd0BgZ8R2LoWktNdmmmicIe1Dvq5yvE4uFALiviaULcXX/2QgWqkvbw2qv5WN1IUmHoJoMQoFU7y1vvjH5LSFkuXdKeURmqX2+0tsMvHw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(18002099003)(13003099007)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	znSRV2wVC4wrqvaXRA07PtDLRDJGFXN18KYVM+IxZS3HKJuC/Kv3XXngvgYhSHRaOdBaP8lQdqTkDObgYbFA+Z09DwcQRnHyzfDVUOfQkIXussxLFHHCutwG2iDtv5Tn1IRoJG1AjhIv2Iahtz6k6W8SCZployh40Q5HtQOP5VkoTn2UyPcMrneDJv/xd1ZfvKlnjqTXgp6Fyo8Oo6DoOMFp0ssvQOOevitUag5/1BsRmeNhbJ/bAWD0W3upTBU6fYvMHiAAv62WqB0mCscHvJCjVJelH1UYW4LfrMKU9mjwgND/zPGDpr8uqVIU5eFekmi5/YLoJ1FH0f9MfV09ZZN6XCt67zgUQCTzS3zyE64raDQIwLFz+f0Uc2BIlvRWBTyAIdUcLwcDKDHTT8nuykvrm2groL2puu2QpyuiAwkaelExUFWOQQakXeVrexxQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:24:09.2057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b220315-7178-4698-12eb-08ded80286a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bobbyeshleman@meta.com,m:willemb@google.com,m:weibunny@fb.com,m:dw@davidwei.uk,m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:noren@nvidia.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303989-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,google.com,fb.com,davidwei.uk,nvidia.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xdp.py:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04DC46F3CFB

The driver selftest environment picks a single address family for tests
which use the generic address fields. When both IPv4 and IPv6 are
available it prefers IPv6, which can leave IPv4 paths untested and hide
IPv4-only bugs.

This happened recently in the XDP selftest, where an IPv4 checksum bug
was missed when IPv6 was also configured. XDP traffic handling has
IP-version-specific code paths, and the follow-up discussion concluded
that the XDP tests should run against both IP versions [1].

This series changes NetDrvEpEnv from exposing only the initially selected
address family to allowing tests to switch the generic address fields
between IP versions. xdp.py uses this to run the XDP traffic cases over
both IPv4 and IPv6. Test variants whose required IP version is not
configured are skipped.

[1] https://lore.kernel.org/20260518143138.74839bf9@kernel.org/

Nimrod Oren (2):
  selftests: drv-net: allow switching env IP version
  selftests: drv-net: xdp: run with both IP versions

 .../selftests/drivers/net/lib/py/env.py       | 27 ++++--
 tools/testing/selftests/drivers/net/xdp.py    | 94 +++++++++++++++----
 2 files changed, 97 insertions(+), 24 deletions(-)

-- 
2.45.0


