Return-Path: <netdev+bounces-252075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L1mH2JOcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:08:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6445E80A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B41405087DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA443DA43;
	Wed, 21 Jan 2026 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acN+OCLy"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BC43DA33
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033285; cv=fail; b=gW9CAInXy3APJWg2Pcv9twOkz0yc6q+gHat2OVU5tOB9PXg7Lll568MKTp/A2GG2jdqRQnRqXpi1y4DeINRRw9B7SJ82AKHkyIeyxxlx9fLk+4l+EAtatV3J1DuWbDCNQmuuTWltX5423hMsDdqE3GWwVxT1Uj0TxMfY7xZ5gro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033285; c=relaxed/simple;
	bh=h0f5YH/hR2cuN4GYsmmjrWL1wgZFiHU4akt/eQbuuY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TATJ3jv4p4JhGTSd5PxwtdHLhZ7NY2tGqGOlPuyAoRq6mqEiZJ4vdRDqGDdrrjd3zcnrit4LjBwps8QRBmjSScUAjShsw6EQYreT6oc35raIsdkE12HidBb3n/vxtiP3N34iDP0uaGyyXLeHDGPo5QZEc7Kmh17OnQFW+8pdNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acN+OCLy; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEfrEPeqUrZ0QWGFbQhjDR0T8qmG+6GJBXEeAcQvDtt+YsajFSgIzP31yICVuyYdj4vt6g1H9hg4eBX932FyJsCcbdlh2h4VwkEwbQpMNYRJBUrCPPiVreCJ7Gm1KcPl4ivaVp5xFKi5Qftbab82qV72JFiJvD1kksrd3S5h8LhlZamMbpiMWDu2IKJxgPtt5j0ixBJv0hd09J+9BGrgjXAzv2TF5ACoclHrVVhPJytpqBMScSrh+s9qyplHWbPSaEy9czmyIgIlWYjct3tw3WhRihBA5lO6hbGiUzbCD+4yzIoEw5sWHjaQrtItS4nO+C2cwaNRwA6mTUWilqiM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9kq5M04AcaMUozBCRs1AtHFBMsKaPnfEbpvvp/K5pk=;
 b=n/ZBwIQiyeivX5HK/MIiGImYvHxCbkKUj3aV3VpAMBiq03BbUACPaIfxC7Qn+fFcF1EjZMl3dH3Nm0YdmeL7vOqbV6bqelrWyhfAr5f1dTFjFh+asSPx3SnPDug77GAFG4YA5vnBe2srzGfC6+oSIi09l8SKyBY9F83/pzTZKfk9JSX8reBd86IUmtiDvt/FZ9YeBWO0uKhLVC3H7LMbiLkc9YO8qoEWr9qQJ+e6YxxqV8eIdZzKECQEM8PugGswYgvWREfOgNJs8K9nNk4Tuh2AGVH0FGorHRQAYBT06J2PiJREbbgIzItd+mpwsW+8/7kV/6oVBm9YDZxiLZuaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9kq5M04AcaMUozBCRs1AtHFBMsKaPnfEbpvvp/K5pk=;
 b=acN+OCLyHinhrGfRvDm/GzxiurO5XEsnpfU56Y0LJfrLlTRnBOv0wgaYTrSj6MqxXv+GVje7g5cPw+4vGaS0M1R2xmOZC/4rJkkUIlr9RO3VhbpRdWJuou43Kzvlay1nkEVYpoqvLSZpV7IN12NTrBrD1lpVrj5T5JYcPSw9rL0TqmOtBUbCiWbPcfV0Zt5UgaGS7CdvxOUl7pMeq4F3EG9RfCyH0ngIfd9B7SFsqmhAL9wxwAzuFeyAoL5RZCGT0IwCG9eNPlTSVQoIDY7BNpDOSjHeFWgFO+hBJgohcMNZcRYnrDo7vNKDwYO4ilWRQWxfg+hx2101UCxhqZYKuw==
Received: from MN0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:208:530::28)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:07:57 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::3b) by MN0PR02CA0024.outlook.office365.com
 (2603:10b6:208:530::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:07:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:32 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:31 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:30 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 21 Jan 2026 16:06:40 -0600
Message-ID: <20260121220652.894364-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 839e9c5d-2be5-426a-1835-08de593988a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNvVsDr4pjl6uenTZeFDnbpgr9fsNgPIq0k+uD/Hfpot0eAJCN76VfhPbIyN?=
 =?us-ascii?Q?VRC3Vie5Y5pKNgkwO0Qi24RtdYh1K7hWrgKCyPh5bzQWYTli8LtqbxC5/RgN?=
 =?us-ascii?Q?+oLkroJfk2xkb0zUy5N3RGbB1Hg5uEk5p4/kq7Wz3x5IzYQQneuSIO84ppHl?=
 =?us-ascii?Q?wXcjwDAH/1uA52x3GAXuV1lygLvz6kws1pJOXxwhZWTqxRAXunYWgm8X/iH6?=
 =?us-ascii?Q?cBZjoAKIkFMe56RibW9REju3OYlZrI24SHBgdqRU1GY6zVR1vu2yUt7qW0gA?=
 =?us-ascii?Q?jFBE9ShXJPBKwyj6dGjjNrsLAyxnNeAc+YeAajKrSxQeKwd1ePWkeBEuDphm?=
 =?us-ascii?Q?89EwdeauS55gxXKjGMLU1PdJwtJndBySInUnhNtE3BkMOTkWUyWPj//beRT5?=
 =?us-ascii?Q?goNBq0F5th6sSMjSKNNcrsEUT32CZHRrIkYM553/DAIzvmTiPuQCvjvjSZ0w?=
 =?us-ascii?Q?4X6XPrVFBJqeuH4BFOcgE6DCwVR2QL/ZumaFvdkZe3TjUT/zSVPqCGEkuk6t?=
 =?us-ascii?Q?nQFwUOQ11jbZUYEleaQKjl26SkvSjCIAlsEI+AmHYtES4Y+PjJrcTHMu5WnQ?=
 =?us-ascii?Q?/zDaTxnROv465QHM1ksk16nwjDS0ajd2ur7HyCNBt6UBRj82ET7hGfEf3pYK?=
 =?us-ascii?Q?1ks+N45RrqXioJ5oxYKulSg8wJR87Ww+xJj1AGYd58oWvj128nivzIc0RCan?=
 =?us-ascii?Q?AKjZ0NW7cZNovNqXAo9xzTj/8Unnh6gkZPrCy5fLZvOF3uTgiN0GyMGy2u8i?=
 =?us-ascii?Q?HCj//e5FWAfDkdPkExNQdLVmCzrz1zbOYqhFqpyuYF0zPtXhLJ4MUa2coW+z?=
 =?us-ascii?Q?FO3BGgARt+nscfgEPSc2gJOsz/vhtObn1CTD7uIZh+kvn1XfwQOPglanOrfw?=
 =?us-ascii?Q?ZbiHPANWwmElElw5YDrKrq7vhooFnKmxnlPxwSb6W3JRhvrK+k+5dyYXJA3/?=
 =?us-ascii?Q?uyiPWC2GCcT4XZOT0WTlsw05bNo/yCFesQI3Sh5qVx0Yg3BqBcbp8XtBmnS4?=
 =?us-ascii?Q?GskMtT6hQ8II7YbN89xdHQHR3VE2kplKasBaYAOwsDFTmqY9SGVnmtL5YD1T?=
 =?us-ascii?Q?wiB+M9WCtxHzO5yjeY8+IKXa5S5pcIBMvC10WhBwA4lCsPbxc0eLqs6yOqwH?=
 =?us-ascii?Q?j8IKA+qNm1osFTyegh8dUpVzJyXAqBeRPdv4n+Yz61NUgVD/A0x/GFaJLaR1?=
 =?us-ascii?Q?K9QE9n+eqiiG+VA3fi0I2QCM5bA0YZSrF8+vQwumO/h3NLmntMG8mamHTH1z?=
 =?us-ascii?Q?zHYPVBuzLQzJEnuDUxfU7+dNbQAA/WormFbXuiWbhbAUF2GNljkQ2dDlSs05?=
 =?us-ascii?Q?1Jxc6C25rSJuEmhh2BUZB8jzgfjK5a1LZeM1rBIW7hLs5jWePRUvDpiVBZTN?=
 =?us-ascii?Q?jg3T3hqTsoSShpNAPfU9FGmr0z1r0BCEgDcVnqDEKzC/h5GLp/pqpbBRcpSe?=
 =?us-ascii?Q?7FIc5G7zN67jvadlXXs/2oDZKSTgeb0DaV+3oX8BYg73ZC76Pj9CkN+9i93k?=
 =?us-ascii?Q?GK4NeVloQ5aZnJJ26lqrTAtEVJisNAJsbpHXjEQsVh3mmP1xPuWImXuvz3Xw?=
 =?us-ascii?Q?wqeP/gr9CrjxhdWB8H+SOmODDBdF9YwqCUP4Cogowz7euuSP+pG2O0BfPMzv?=
 =?us-ascii?Q?FkD1onft9acZ2JGo+tQFp49kBNsq5RElJDUk2cxqCZaqc/3mZGIbA42RCWc6?=
 =?us-ascii?Q?aPWHaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:07:57.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839e9c5d-2be5-426a-1835-08de593988a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252075-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:mid];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0C6445E80A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with support
for:

- Layer 2 (Ethernet) flow rules
- IPv4 and IPv6 flow rules  
- TCP and UDP flow rules (both IPv4 and IPv6)
- Rule querying and management operations

Setting, deleting and viewing flow filters, -1 action is drop, positive
integers steer to that RQ:

$ ethtool -u ens9
4 RX rings available
Total 0 rules

$ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
Added rule with ID 0
$ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
Added rule with ID 1
$ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
Added rule with ID 2
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
Added rule with ID 3
$ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
Added rule with ID 4
$ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
Added rule with ID 5
$ ethtool -U ens9 delete 4
$ ethtool -u ens9
4 RX rings available
Total 5 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 3

Filter: 2
        Rule Type: TCP over IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 2

Filter: 3
        Rule Type: Raw IPv4
        Src IP addr: 192.168.51.101 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Direct to queue 1

Filter: 5
        Rule Type: Raw IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Drop

---
v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
  - Added admin_ops to virtio_device kdoc.

v4:
  - Fixed double free bug inserting flows
  - Fixed incorrect protocol field check parsing ip4 headers.
  - (u8 *) changed to (void *)
  - Added kdoc comments to UAPI changes.
  - No longer split up virtio_net.c
  - Added config op to execute admin commands.
      - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
  - Moved admin command API to new core file virtio_admin_commands.c

v5: 
  - Fixed compile error
  - Fixed static analysis warning on () after macro
  - Added missing fields to kdoc comments
  - Aligned parameter name between prototype and kdoc

v6:
  - Fix sparse warning "array of flexible structures" Jakub K/Simon H
  - Use new variable and validate ff_mask_size before set_cap. MST

v7:
  - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
  - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
  - Move for (int i removal hung back a patch. Paolo Abini

v8
  - Removed unused num_classifiers. Jason Wang
  - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
  - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H

v10:
  - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
    Jason Wang/Paolo Abeni

v11:
  - Return -EINVAL if any resource limit is 0. Simon Horman
  - Ensure we don't overrun alloced space of ff->ff_mask by moving the
    real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12: Many comments by MST, thanks Michael. Only the most significant
     listed here:
  - Fixed leak of key in build_and_insert.
  - Fixed setting ethhdr proto for IPv6.
  - Added 2 byte pad to struct virtio_net_ff_cap_data.
  - Use and set rule_cnt when querying all flows.
  - Cleanup and reinit in freeze/restore path.

v13:
  - Add private comment for reserved field in kdoc. Jakub
  - Serveral comments from MST details in patches. Most significant:
	- Fixed bug in ip4, check l3_mask vs mask when setting addrs.
	- Changed ff_mask cap checking to not break on expanded
	  selector types
	- Changed virtio_admin_obj_destroy to return void.
	- Check tos field for ip4.
	- Don't accept tclass field for ip6.
	- If ip6 only flow check that l4_proto isn't set.

v14:
  - Handle virtio_ff_init errors in freeze/restore. MST
  - Don't set proto in parse_ip4/6. The casted struct may not have that
    field, and the proto field was set explicitly anyway. Simon H/AI.

v15:
  - In virtnet_restore_up only call virtnet_close in err path if
    netif_running. AI

v16:
  - Return 0 from virtnet_restore_up if virtnet_init_ff return not
    supported. AI
  - Rebased over removing series to remove delayed refill.


Daniel Jurgens (12):
  virtio_pci: Remove supported_cap size build assert
  virtio: Add config_op for admin commands
  virtio: Expose generic device capability operations
  virtio: Expose object create and destroy API
  virtio_net: Query and set flow filter caps
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

 drivers/net/virtio_net.c               | 1222 +++++++++++++++++++++++-
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  171 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  155 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1682 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


