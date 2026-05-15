Return-Path: <netdev+bounces-288476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJNvDW6gB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA56558F6F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2233302BBAE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5653EFFD5;
	Fri, 15 May 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="XoA2xjno"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AF2010EE;
	Fri, 15 May 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884671; cv=fail; b=N0P953iqAqIIWqZIW8IiYqXx6kXhcDu4ZieUHIDQ5jWH3WfqTWMGHljUhhyfAOxUXadEhLcUylear6rwX+IyH03OgQink4L7EZAwIgSA3uBlR/u9QAtpuxP/UfmRNnA+QcOqpk2xD/0x5QBwfDklEz2Ypujs7NK2WzwDSK0JHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884671; c=relaxed/simple;
	bh=CHhLG7HLvdhIGbJq0mgqsZrfTxDKb4UMwk2sq8XmOcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoHFyZ+YL3Ow8T1WF5I1QwSGeSQMlf19zopWE/uJ4N0NDbWZX8+INH5nOO16BLHucR0NJKt5NpI7mQmVUKsSS6xDr1r7/xgFj5LDY8X/qdmPaKFvBrMbS840O2UgnW02BJSStBIKy7SD/Kb+SsJYNwqr4aIwhDg2D8x/LnugeuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=XoA2xjno; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLW8I+sT6twSm0oJYuwjKGus1Pz5AlgIChWYzet0IYJbz3+BpHdVvhsd4bRVnzJyAbaCoF8DCgDhRtDNwShD4yfwBtH0S2e+5JvL5OQQKStKWDs4mVUdfkC3NAJjHnrX3sKcg/4BdbqkMGl9abccB8YcQ3PUsCgKSohkgHEJkbyuoyLmshb3cZ7FJkx7rxIRzL+xkJglzMtZsfY9SrdjLkDryvaQKlQXoM2ezMoOwtAMNyecEYl5/EaunV5bpArkTpQmJxIrDoqClEJTNN8sgMcWoIdlcav/HI/9g/2g+UYG0l9wLMOHYnuv3AxFMYDxXKE+jp//jC4uQQXvu1c6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqQhvEh6J7HvhbPxMhGKvY1c+HTmrAWjO/MZ+5V6m7g=;
 b=jRMlPRY8W1RKzk++KnY7RbUHyHqvQQXYkHVNP/m2sykfZybZx+RwK05QQdihKWXWCM8+1tS4OxwUWJqU4kVek44y8cXA0WgQo8IVxCFleQ5eka13CQ7INbpctd6jaYu06G3yNqT3YoAJSAuLuKekW251NGPajVLiephuR1LxevJlMI8CNOUCRt+fM2avr0XBN65SCzOh9Q153VDfzvhNDtfwaC3pvyasqqcLCBhDphDCYFd0+D7PbcxYs2iXAfByevyODaByQyo8dSqv45IM+eC7nz/AeT635geUOEwjzPfwqJgwiEwjUbpG99GJvrzyN7x8EFC3FvK2TDyRT6ZktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqQhvEh6J7HvhbPxMhGKvY1c+HTmrAWjO/MZ+5V6m7g=;
 b=XoA2xjnobUNWvtsh3RFBUFFVQk/UUOlT9blub8MPhWEDIb2Ya9kh+f8yzMq0SL77s7Isdv2klVLAvvij0ATETG/5FrU4zD4dxfvrXO9JZXnO74XNHKSJZeY2WO9nf9Dd23gr1MUe8GPCs7Cz4bz0luef2ARU8PqDuBNiWv27xIKh7k3sAv9tiQ+WsKWsGTSJbUXMuOCZvvBmS3BPTYTkP9b0WF/Muu5m0NnkYoDYdh7iEGTWwrQp5irNlwfs4NleFqH396HpCk/TDyrrWfW7psCQcVhbOyJ5DaFTXwn+C0LZ4hfqgWQZImP/wn/ddxR5XG1ltBMiJ4lj8/x5HpxvIg==
Received: from DB8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:110::37)
 by DB9PR07MB7995.eurprd07.prod.outlook.com (2603:10a6:10:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Fri, 15 May
 2026 22:37:44 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::1c) by DB8PR04CA0027.outlook.office365.com
 (2603:10a6:10:110::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Fri,
 15 May 2026 22:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 22:37:42 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 16 May 2026 00:37:42 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id A3BB94020840;
	Sat, 16 May 2026 00:37:41 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 8BC9D1005D6A; Sat, 16 May 2026 00:37:41 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next 0/4] mv88e6xxx: Cache scratch config3 of 6352
Date: Sat, 16 May 2026 00:37:03 +0200
Message-ID: <20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|DB9PR07MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcc02bf-b9d5-4174-beb6-08deb2d29400
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	HBfjA4D4b99NvO3mHVS5jk5j7h0SVanY+zbjCAt44HSo1OLrHTIb9QpMzjIQWsgnp3lle7dKnnJF8u7ZGSuUK5klrKBF6fpB9ag+mCL5w4dRWY9rWbjxPksbpDzJ7/D5gdZNhSTdZiBdZV2TSlQ7q4KZmXy6u67lMUEX9r6o+c0kDrk4nGYzs0y8jnTp+a2SbIeFtnbKyzNQ/ghVsyk0SmWqtjRBpsmCDfPyIzgUM1WkdoEyliJKWj8DlbiW1yeMllnnrbzOkEkfG8I31kTOkXpyPfbdvhuxvQVJtfIPDnDHi3XcUG3QgN3zwdXCITwZwFwtBz+LD7jY0c0QHknJDM/ibCagXBrSwIPAkuVFnA7FdxSoEEdaPuzpVrzvymcD8wn6JRfeWE6fEfmTv984au3o8i0u2ryw1kgOY0oifV7+YpI/jlbetXIhBfe1xM6r+wyMViDxZjZeTdFwfPDkbAEt/OIyOr7wemLRi3dKChRKcQvbXlwxLTSy+ci4h7/K8+MX5Z7It2teGnV2tChw4BM6qjPtIkDT7MHvyH5ttC1zEsPT6uOCS6QrVOGlh1IaxqkOwDzZl/Z4oB4M7mABTHO0wGrrvC4v0+t3qJxpKL4yR54zaeOE/VMF8IjcenKwa57/YAfVVJGKewQF+D2m9JV5EpLyNhuuGzdDh0L0d/3qQHr1o7FZJi2iFUM11HM1
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DCcf3IfIIPMcBilvfgSzUk4PLCuDUO8YBm/wg3fyfAcPZr30nF7gFG+P4Zb10ta39Scd9BfpVH96wCp/c8IsLpJ8QmUcnckyRFy35IQvcYPC2AKatJWYFmcBJLOHzgfc/BPIetgqqP0m0lH+XZhIUDCkb8uxMnxicT9D3VMr4tkr5buQ1GtJH7H48W6XpF9/yv5+7h5lvFnY3Gamg/5wWt6FY3rtt+U35/dmf5w7SEo9HMRmRtkF+fwElsYhBJraL3SzIbq9EhtLu4UTJ2/AA6BdEWko0fhM6CvGMZQHNJXdmzSUaEjOmcfegaciO48sXP6OnWRmqQCNDRrkF+P6U3syQlYwqWlrnMIYdxzYR+b+h3DGdu+yk88cUOPKcaoX7o8PpgjiBKkc467d7t+Hdl0COl6EeNeoTh8NI0lIvzQplWPo7r31sm6U/nmumQDh
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:37:42.8341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc02bf-b9d5-4174-beb6-08deb2d29400
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7995
X-Rspamd-Queue-Id: 8EA56558F6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-288476-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	DKIM_TRACE(0.00)[ericsson.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

In mv88e6352 scratch register in Global Control 2 set of registers
returns which port is attached to SERDES. This value is a pin
strapping value and is set after the switch is released from reset.
Thus, it can be cached during chip setup instead of reading the
register everytime when SERDES check is needed.

The series consist of 4 parts:
1. Add new mv88e6352_reset function as ops->reset
2. Cache the register value in this reset function
3. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
value.
4. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.

---
RFC link:
https://lore.kernel.org/netdev/20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com/

Changes after RFC:
  - Separate the patch into 4 different patches
  - Move caching step into chip->info->ops->reset function
as suggested by Andrew.

---
Fidan Aliyeva (4):
  mv88e6xxx: Add mv88e6352_reset for 6352 family
  mv88e6xxx: Cache scratch config3 of 6352
  mv88e6xxx: Use cached config3 in 6352 has_serdes
  mv88e6xxx: Remove locks for 6352's has_serdes

 drivers/net/dsa/mv88e6xxx/chip.c            | 25 ++++++++++----
 drivers/net/dsa/mv88e6xxx/chip.h            |  3 ++
 drivers/net/dsa/mv88e6xxx/global2.h         |  1 +
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 37 ++++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/pcs-6352.c        |  2 --
 drivers/net/dsa/mv88e6xxx/serdes.c          |  2 --
 6 files changed, 50 insertions(+), 20 deletions(-)

--
2.36.0


