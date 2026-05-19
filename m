Return-Path: <netdev+bounces-289451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPqYB8haDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6D57EE5A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18BF330DF7F5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F96334692;
	Tue, 19 May 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2N5XF5X"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B202DC767
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194275; cv=fail; b=XtaojagDGwQvwG6E6yJSLCX4aPkjLXIWZkN+7ziv9qW8hkUYhhF8MXbqbzZTgW6EqoKEKxZnJbP9vjfsI3F6V9MGk4jWkxFZbr7XnWyaCU2kjs/buyj2BRK60FfuaSM9uYfv7OjP+0cV1cg1S5QnZ1uuCM9t9ZmM7/B+yvzmexc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194275; c=relaxed/simple;
	bh=6YSgIdhweZgZegHKcVkvpA6/CEoYej4PJ6V5FUFtdH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XllQ1Px2khUnhBrcW63IESD++cwP7rDzO45DQswk8UpLG0aHEM2cWPabg7cVFx2j3MXac6+IRASg/eXN6s9XU5hjYE5pFfO0MMiVzJMbIEpII06BVKKYZ/wECMUOMcgy/hA/rDlToIUfTteWvR/4ZfFA8CGqaBzfJaBHx6Wdhfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2N5XF5X; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2lwsM8Jyle80Vl6jRqWp05ueSQHH5iVBvBQeP2/J751idC0/RpV+HbFvhP6bwV6IpU1t5VGkMcFsI41Ij0NBbP+mck1JU2jk2K9ECVs/ewZySp9SFC56Rf3rwxtSYO7d5vZ5pBzUYc3xaCS0rBcijjqkdQRCV/6GBEK1+EuL7UqGgXFE550vYvlzvck6TIWD20gG47zJazkTSq0+HHaIZzFcACfd3ot0Ny6eIq9WLIR1nXDQNpozbCQR9c2+n25HXS5Kf+fytmCXzIIgZ6Jpdwmd2s/8YKMysvcxnrpBcB3/vFMzhu6biWvsoOc2KQTgkhS2hmldWbiy9iJScGfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9crrpO0aoJ5iKvxZhN7tgA8AAqz2Ao26Xp/sYStcVu4=;
 b=lSGX7Xp1xYQyfN+0fKc3sqgKo+MTem1Ne5kBIXCWSsW8+V1tI75Jf4V8r+TuDNtVBWFjVO6Y5Rnkt7td7bRZ1s9rJ12cGiroPYzxI4LfTZziAgs5tbd9eHNKiJpyWUaJaei3g8r+5lbVXhoqAI17qc4GdcCa5y9VbNQMdomYyHWABaLQJYdddNliax9n2E3k226QXCVzru4A5KGzvTEqrI1HpeR2obRn3k8D90lbw0i4Ge9yfDSSNdX4wiNa9wfV3kxIqELtP20QY/tflaR844tDBHlVrp36NhPiDrtukqXVgkz7rspeFsiYDw+IRgIv060hDijKyeOYMd4bL+fZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9crrpO0aoJ5iKvxZhN7tgA8AAqz2Ao26Xp/sYStcVu4=;
 b=k2N5XF5XONr/MOVBB0tZbibMQ2L0CkFQy38a+G9zHra8FE3wGSMLR3YxndNWATuqJnAGai829y0hcZpS/AHsVsOFUJ0NCy89+66AnA14hEV+yRJvzvJlwXe4QnDXmDEceiXFXTWoVHeiarBgFGIIWXqiAryeJRPoX0nf8vQzhZDL3lSIfu6eNtNLMkmolYF11PiE0FqZVQUg7m39E/vC0dbkqLTP3rYL1Cx5sQl8CD65mXRJn6nmnpRwJF1jGuOcvCylucVuQlm7h5x7qWkePH4A+TcnwdQ21Fw5g2ETG2e3989piSwOh3tDbE+qUtzPi49CZaPQpXLGtfUKmCCGNA==
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 12:37:45 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::fa) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 12:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:26 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:24 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 4/5] netlink: module-eeprom: Add 'hex on pages on' option for page-organized hex dump
Date: Tue, 19 May 2026 15:37:01 +0300
Message-ID: <ba9524bd1ddc05bdb659977f421871fda0768eb2.1779190777.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779190777.git.danieller@nvidia.com>
References: <cover.1779190777.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: fa75e3e3-990d-4413-86bd-08deb5a36cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003|11063799006|3023799003;
X-Microsoft-Antispam-Message-Info:
	DXj/jrTGq/smbH405F0LmaJ8lW0tPlnx5vrBtyICmSPc4W6sBgvh6HahsBdT0VtRT/5D2REQ/6Nvirz+tyeMxE3cwCcvQ5XUG/DsiZbumx8kzmK3bZYMfXN3wDpbWdb2/1g1ZWJ5zJC/SuN5b55nN3XlT2mGEr+oQ/CKVDVnPjcTZOIVvjw1UpgXsX2NecJwQYKVNKhq1HwGrq5JnSGQ9OR+wC6jC9htS1gF1y1FRCl9ixkEzpUT/Rdqas+r4Q20HmukOP5QcB3TJ0HwJWPMYUWI2sCcX8rmtTlqbWAQzWQAKX5CJBn7CTJCJbzukAVrgl4qyJLh0h9Df5y9aBDt9VNwPdlzFuMGwlvxpSboSQ8FdBukzELzs0XU5RbvM89OkZKRX1VJ47xzl/9bNYgexBJAZkAnhSCcm6NLuzDWnAXHEfaj4tDNodfFTXv9R7TgYLvjUMT2LcWIbYP4rG7NREPVk0Y9aAZtQuVCNaZb5UIX6/y4mtyEdRi6Wgi/0r741AFDenu/tS2bljkPU8dDNf7R79x2ajjKJw6Td66L2A/FC/EKPdqeJEEqqP7lvOBt46ZIB7Ua403GBBjZNER2mlDDlFeS+8sm2YCSQe+pzFMpx+OUKYRCy5NV3GDKfNqq02UgX0J4k47sdbXieKMG1dMxLYVeH9tOQYa39iuH1NB08+yIV2R+JVtQ+lmQzZmGXhNPlYubGVv7j39C/MJVFbGF+MeZJZVL9G1jhryfHb8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003)(11063799006)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/2ETY5SofJpwR9c9zAikVf7R5m0tuTrolr8iX5ofxHWCQtxEJx0iEalscjzOjWgZhjONsRvJGRkxOgB+dcuegOb5axKFMgvsUtW2Hyt74HDU6QL19cq4fyenTQqhnpAZwKytkF6lndxskREwppsk/j2Rj/dBkk2M+Xt2ser4y7jVv/nNzFz6acZVorPVgfIgumiDTX+/ty+JjbuQVVShWmXKbweZwHSBagwXd+dkggd5dhrce8KCsO9lAWEzyPrAm2NMmxqDPejqX1ge5/OZLcmq8Rz14WoEMBvLS+o1gapmhSqXljNZxyZN38sHH7Im0UUdxzrOiVhuS3705afLy1fxqUSykLWL/nYn1XDd35jb8iDYh+rCxm99CK2lIO1WwexcNVHw+Axol9u2fyqRxZ884llAR/LO+GlNA+c/sgDDlgYXBacXbQnPhrXFWXTq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:44.3750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa75e3e3-990d-4413-86bd-08deb5a36cec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289451-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,request.page:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 89B6D57EE5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add 'pages on|off' sub-option to 'hex on|off' for 'ethtool -m'.
When 'hex on pages on' is specified, eeprom_parse() dispatches to the
appropriate per-type function with dump_pages=true, producing a hex dump
of all relevant EEPROM pages with a per-page header showing the page
number and optional bank number.

eeprom_parse() is extended with a bool dump_pages parameter to select
between pretty-print and hex dump output, avoiding duplication of the
module-type dispatch logic.

Unlike plain 'hex on', 'hex on pages on' does not fall back to the ioctl
path, as page selection is handled internally by the per-type functions.

Unknown module types fall back to dumping the lower 128 bytes.

'pages' and 'hex' are both parsed as independent flat options, since the
parameter parser does not support context-dependent argument recognition.
The requirement for 'hex on' when using 'pages on' is enforced by an
explicit validation check.

SFF-8636 Output example (values zeroed to omit vendor-specific
identifiers):

$ ethtool -m swp61 hex on pages on
Page: 0x0

Offset          Values
------          ------
0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Page: 0x0

Offset          Values
------          ------
0x0080:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0090:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note: 'Page: 0x0' appears twice in the output. The first block is the
lower memory (bytes 0x00-0x7f), which is always accessible. The second
block is upper memory page 00h (bytes 0x80-0xff). Both carry the same
page label but are distinguished by their offset range in the hex dump.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c               |  1 +
 netlink/module-eeprom.c | 43 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 2444d85..8869c06 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6165,6 +6165,7 @@ static const struct option args[] = {
 		.help	= "Query/Decode Module EEPROM information and optical diagnostics if available",
 		.xhelp	= "		[ raw on|off ]\n"
 			  "		[ hex on|off ]\n"
+			  "		[ pages on|off ]\n"
 			  "		[ offset N ]\n"
 			  "		[ length N ]\n"
 			  "		[ page N ]\n"
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 7e4e6ac..ce88475 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -25,6 +25,7 @@ struct cmd_params {
 	unsigned long present;
 	u8 dump_hex;
 	u8 dump_raw;
+	u8 dump_pages;
 	u32 offset;
 	u32 length;
 	u32 page;
@@ -83,6 +84,12 @@ static const struct param_parser getmodule_params[] = {
 		.dest_offset	= offsetof(struct cmd_params, i2c_address),
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "pages",
+		.handler	= nl_parse_u8bool,
+		.dest_offset	= offsetof(struct cmd_params, dump_pages),
+		.min_argc	= 1,
+	},
 	{}
 };
 
@@ -207,7 +214,7 @@ static int eeprom_dump_hex(struct cmd_context *ctx)
 	return 0;
 }
 
-static int eeprom_parse(struct cmd_context *ctx)
+static int eeprom_parse(struct cmd_context *ctx, bool dump_pages)
 {
 	struct ethtool_module_eeprom request = {
 		.length = 1,
@@ -228,18 +235,18 @@ static int eeprom_parse(struct cmd_context *ctx)
 	case MODULE_ID_GBIC:
 	case MODULE_ID_SOLDERED_MODULE:
 	case MODULE_ID_SFP:
-		return sff8079_show_all_nl(ctx, false);
+		return sff8079_show_all_nl(ctx, dump_pages);
 	case MODULE_ID_QSFP:
 	case MODULE_ID_QSFP28:
 	case MODULE_ID_QSFP_PLUS:
-		return sff8636_show_all_nl(ctx, false);
+		return sff8636_show_all_nl(ctx, dump_pages);
 	case MODULE_ID_QSFP_DD:
 	case MODULE_ID_OSFP:
 	case MODULE_ID_DSFP:
 	case MODULE_ID_QSFP_PLUS_CMIS:
 	case MODULE_ID_SFP_DD_CMIS:
 	case MODULE_ID_SFP_PLUS_CMIS:
-		return cmis_show_all_nl(ctx, false);
+		return cmis_show_all_nl(ctx, dump_pages);
 #endif
 	default:
 		/* If we cannot recognize the memory map, default to dumping
@@ -272,10 +279,28 @@ int nl_getmodule(struct cmd_context *ctx)
 		return -EINVAL;
 	}
 
+	if (getmodule_cmd_params.dump_pages && !getmodule_cmd_params.dump_hex) {
+		fprintf(stderr, "Pages dump requires hex on\n");
+		return -EINVAL;
+	}
+
+	if (getmodule_cmd_params.dump_pages &&
+	    (getmodule_cmd_params.present & (1 << PARAM_PAGE |
+					     1 << PARAM_BANK |
+					     1 << PARAM_OFFSET |
+					     1 << PARAM_LENGTH |
+					     1 << PARAM_I2C))) {
+		fprintf(stderr,
+			"Pages dump cannot be combined with offset, length, page, bank or i2c\n");
+		return -EINVAL;
+	}
+
 	/* When complete hex/raw dump of the EEPROM is requested, fallback to
-	 * ioctl. Netlink can only request specific pages.
+	 * ioctl. Netlink can only request specific pages. Skip fallback when
+	 * pages dump is requested, as it handles page selection internally.
 	 */
 	if ((getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) &&
+	    !getmodule_cmd_params.dump_pages &&
 	    !(getmodule_cmd_params.present & (1 << PARAM_PAGE |
 					      1 << PARAM_BANK |
 					      1 << PARAM_I2C))) {
@@ -300,7 +325,11 @@ int nl_getmodule(struct cmd_context *ctx)
 	if (request.page && !request.offset)
 		request.offset = 128;
 
-	if (getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) {
+	if (getmodule_cmd_params.dump_pages) {
+		ret = eeprom_parse(ctx, true);
+		if (ret < 0)
+			goto cleanup;
+	} else if (getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) {
 		ret = nl_get_eeprom_page(ctx, &request);
 		if (ret < 0)
 			goto cleanup;
@@ -311,7 +340,7 @@ int nl_getmodule(struct cmd_context *ctx)
 			dump_hex(stdout, request.data, request.length,
 				 request.offset);
 	} else {
-		ret = eeprom_parse(ctx);
+		ret = eeprom_parse(ctx, false);
 		if (ret < 0)
 			goto cleanup;
 	}
-- 
2.51.0


