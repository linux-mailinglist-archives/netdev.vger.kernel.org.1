Return-Path: <netdev+bounces-254304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA7mKtshemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E526A31FF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C990304D269
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43053624D9;
	Wed, 28 Jan 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fXjnxNIT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA102741B6;
	Wed, 28 Jan 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611481; cv=fail; b=qP3BrdxMknJwLgiZSCa/ZFn1+18VOqjXd0IIKaZ/ixdntiUJh8b8CYYURk8Y/sSyjinpBEYi1Yo90v77mMzXK4Zb+NzoeoB3oq+adhVJPyYaxtY8KyIlv1h1VxjpXz6E3/g404/7AyiKC2TAey+PVCOTUGn7/T5nfu43KbvIuFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611481; c=relaxed/simple;
	bh=zeXJWV5ac2bS3SiVLb1A3fmFd0LZ5rh73dkyO5y0TXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHagepxRX2qQH5WvUEIBwfwAOvzjUOCfY8/J/ViMEEJlGR0VAx0dxaJ8ZGYoWSJOn/jAkbyBGIFGWOCMHMNOfzhpriAW82z1mCGoxSAFZFFMFxHKqVqnTOZ0hXMrnqxvyZhPIZJhODFXV3A3As+oKsVQ9T2qCyllrGqC9cznaCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fXjnxNIT; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVhuVhlprH5Su+pRqiLYXlUJLvGq5frAf+v9nf0SoaM5SxaIbilC1LqRK8gwNK2Acxk7DNhCJyspaVX8BtLvCBXeuEGiTNFEBozgOPACptgxaWC3jY2F4nliWtSDaFUd0NFstlnRIFUdDjWW8pMVLlNXi4PvGnl92zThlWDhP9SxgO7h4BCa3X/VHIug8QuvPrUFEj+OYj+e48v6PMOE6SxM0cRQDtg6SQcMCZMDjVRYhXb8SGY76wBuSx9rh/lXYHZ7BuPTnEcE+E7jiEPtMx05uXQq09gwfEWZG1kNn8SQwLLUXBmBQSwR8V8lL/qustIU5DHMzw223sy4dUdUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3raweNhp9S1cnVwn3QXn2trId+Mh2Gr9z0EhLGfa7oA=;
 b=aGUqgkdjHhtYer95vPk3H2g4LLFS+pW7q2HxomibU5FwaftgCIZwMlkSYXX+oDqg37osRocOYAYeTojkfjHHBIUpbUMBDS28XIdw052Bok22d0JxY5sG9T4YC7xFJFQBd4maMnP1H3us/ocGjrthPtpuEa/PcJjOqCBYzh4f/x3qu9BzV2YpLQoiEpyDcpkeBslzM8PC0iwZDi+s9tPs+taVjVTGpW3liXfwX+tr6aLNRaCBV2+WiVRrDJdKpU1jMqLVIQ+OeJGctUpJXkZyZiocMDZ/jyqh55/ZhiIRBbZqWMvE4+CI2GDWCoKh7KTOmTyWSYAVJYW2chK7eqQFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3raweNhp9S1cnVwn3QXn2trId+Mh2Gr9z0EhLGfa7oA=;
 b=fXjnxNITB8cj0+AqxbrKxFG4DUevYBXsW39+2rAMlLhvuk/brB42cuXlWJVMEIDS8iKVz5/2labAnDCMO7a80SGAMkzHdmO0gLCsRWCoPOceEUkWdE3DisJRPz6gGhxNEs5BIZlcYebsQrQeCC+8n+WSaVHGB0UNy9tuEvpW7D9T4zT+mpcFdIa30MZNJHdWL1zrGoN/9JZBM+ZUwRxkkeU7GJMOZ8M58Gu0mLyMqoOVGgbRLOSNOLRXyQoJroAZ4WoahQZB5tJJjLXn5IjYMEd3SRvaRU/V5Acqw7+G/3IelsbmHkOruSx7LZbrcWd+c8th8XgKhKR3j8VXOU4TjQ==
Received: from AS4P189CA0024.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::14)
 by AM0PR07MB6354.eurprd07.prod.outlook.com (2603:10a6:20b:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:44:35 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::61) by AS4P189CA0024.outlook.office365.com
 (2603:10a6:20b:5db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:44:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B6A01203FE;
	Wed, 28 Jan 2026 16:44:33 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR flag when receiving GRO packet
Date: Wed, 28 Jan 2026 15:44:25 +0100
Message-Id: <20260128144426.15870-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|AM0PR07MB6354:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 61fb97fa-03ab-4ed4-781b-08de5e7bc176
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?e3Dpm3XFDDMwcqljoRG21UL8PdSmvJhIiqy/KauGD1Z0HVUmyv2sDBFIDjM7?=
 =?us-ascii?Q?rzVQIhnDvHVmvZhFllzbSx9SIcG0x70mwue8/TiANbDbPv+FqYb5CgSjoCxE?=
 =?us-ascii?Q?0u9sxSU0LexuGHM680TKMh+S3XScGjPiSrJXGSZSROeY0tcuohIYm0YDcK8O?=
 =?us-ascii?Q?cNzpACmzRYyI8GjQEIy/BgDnrT+ZW04+lAZIEb0so5wqxIzLyy1TrJVwNL3C?=
 =?us-ascii?Q?s9kdA7OzPjrHo0STwlH7W2x7bhhwOaKjDnqZc1cik2V4SBNPj3BYERTD6AsB?=
 =?us-ascii?Q?JZsV2F1lgUiY/1OfN5gmgcZ0yFwnDG4ZUvGzvZyAk8mzFrT8elQNrE+aKKBz?=
 =?us-ascii?Q?dNOYWRaIZXA9r7FFKTmU02ABj5mRfTgbvb00xZtOVH0xYM32VeXR4JilNyJ9?=
 =?us-ascii?Q?fwlEBGhMYvhCudCbjRkzJdOPK0X/SYfEknFsvdtTveKySB/b6IKQLVuEXY63?=
 =?us-ascii?Q?NBpS2kJePwIGMCdltQE3VPJnPdekkXUjcXeGJKuWncZnOBY0W9O3gwrzA60I?=
 =?us-ascii?Q?Hkk+MblfYPW9u0E3qb2WVn1mOVrxE3rbIliBcyERBtDf+g9yysqX3zQetZTS?=
 =?us-ascii?Q?f9HOf7dY8aEq9dT8GzqT6CIxlUWz3HI6JTo1Vzoo8WkSVCORlP2cwO4uROdA?=
 =?us-ascii?Q?YYmayngQ8J5PkZQSOt2qepM8QXAeYtL0o70d9Tgf5hI9Bri6KIDF7zBP83eZ?=
 =?us-ascii?Q?UGyWG+7Y49RKReqsnx5G0xfoJMt7B10NweBz2SAL3iwDJXu7Y8/hIdpLGB0m?=
 =?us-ascii?Q?77KJZw3xuvoq3/p/YObXvvRfR1y2EZtkzPCh3bLi0EIC0gfDFay6JD9RWD2J?=
 =?us-ascii?Q?BCJJAGnBOsrbK8YoKHt/Gpwc/ub94KAME0KpMcpdTHoDLkF3Y5kkv/E4tpr3?=
 =?us-ascii?Q?6LoSS7tBScnEDP77yUahtTUn3ijnXau5+beBUs4xW7DSTp7Nqxn9rciDz91P?=
 =?us-ascii?Q?4HvJUaxuxjB4WAWzRUwxV5atLemp5qXy8TIzLh8girtQzHCO/3VZHzNeJWuq?=
 =?us-ascii?Q?g4Dpvxru0cbgywTJGZ68Ne414PITnMqkISxI2GJCBbId0IoxhfC8pxn3Jp1p?=
 =?us-ascii?Q?i5k5mMXHrVEQ7DneRshE64L+yJv7kzWzzlbT4gzEeb2cDIKXRcPRIHNIOCUq?=
 =?us-ascii?Q?p0vsd/LnQ96Q3Fb3+VAZ6Rf3NEFCMnAHZOJlq11PxGeyVLGeoomFCGcuUK58?=
 =?us-ascii?Q?CaJeoG9Qf0sQfhZGEJmMQk/tPGqBaSteekP7TjDRDhpEZehmNeiYA3T4Owzc?=
 =?us-ascii?Q?/ji0tbQFPwcdWNaMSsttpDHpCD61DAKHwYrgJAgOgAfc0NgHivYQHkdgfTbX?=
 =?us-ascii?Q?QyJPEixJK8n5FD1+4uhwDIYAEomRMz0VWQiL7Je+5sk74g6LplJnPAWrfWM6?=
 =?us-ascii?Q?HEnMnoSfP7BeO4LzutzlIjUu7JzcvzXmDnJe8KI/bxKj4E5s3hb2xEwvF4Xa?=
 =?us-ascii?Q?a0/t5Y99NgSgNP93Y6yiRePgIoZB5r0xKHwpOzdQOJhOTf7vXqSdUHJ87VRp?=
 =?us-ascii?Q?LYGxG3IjBXbGE/9lS5NHRFe7aJjjPht3b9QhpmhJeqbCPnHatIUtqRL2G/Fz?=
 =?us-ascii?Q?YZac9lXVwXkQ8lXaXmIEzUrk/4786QDM5JTLkvOGb6CVNM+orWtVpWo5xk/V?=
 =?us-ascii?Q?/0Grq0LYCUIHZDIr6brnRcmBJDU82BY2qqobyrZx+qjwy6zoAvEcGJ2qUCsI?=
 =?us-ascii?Q?VEPY45IjVJwHoZnGj73sBP8OQCM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 kkYh/9uNnVPqyrKEkOAWURMIgOukRv2YOFD31BA0L6mP5GYE/pSunw8hl3FpVi8PzM5R0p0fvyeMJTi1a+6gx01ijxDcFMMNUSahD+bioo4JBA9602GR3sl2hjFZy0weJBX5SSqW+OR+13jynygNvhqFxdZHI60cotzMRra1SEaFZlIYIjt67KCs4dCnU+FiKE4iTIScm1WUib2L/kqcY432ST0sumu4KDiI4MbvIoOh3ZWJRAGo/4tvlqzJiVNERwiCKzP9H2vbLORUTEvSroxPymFQQUTEd0KzbOpjR0Yq5fKWnOKP0pIWqWKvxU7j6weZvFR/51CiIVn0dQGJ+UT+E3h24SXYfr+UVB3R2EW+PwKNqF8keB5sXAX/jhW030y+CV5WTNfv03Uz4B5xyt0hMkC5/StAx7mmPbCbt3i9KsANN303P3mm8yPP8g1F
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:44:35.2228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fb97fa-03ab-4ed4-781b-08de5e7bc176
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254304-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E526A31FF
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when new
CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not knowing
the ECN variant can result in header change that corrupts the ACE field.
The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or
NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR
flag somewhere.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a47464a22751..3a1cf4335477 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3897,7 +3897,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1fc3720d2201..d174f83478a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1311,7 +1311,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1332,7 +1332,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


