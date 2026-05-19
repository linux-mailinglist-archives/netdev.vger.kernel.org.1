Return-Path: <netdev+bounces-289450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJkNFmJbDGrMgAUAu9opvQ
	(envelope-from <netdev+bounces-289450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D757EF40
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC9C30B063D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7D4DC528;
	Tue, 19 May 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9J0B+PF"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE52628D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194268; cv=fail; b=cEXzuz1kTkijCBnqRsvY1oeLT3KCdNjx6GouHQ6NOUa6+O79udDRzOoC+BpWXxXT0T7EvmVi0tDLtPLgoWmUlCgHfwjRcdhbFsx42xrGWBtEP2NgUeAgfqdb8vC02J8WYFRCLHtdG41Z0jj5lG+97MaH3d7jiKcGOYAFCMjvp08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194268; c=relaxed/simple;
	bh=Rz7lLLoFnzZER9cCWhuOoJ1hZdbiNFjbC0cUNuYUe0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d82nTPjPzYof0Wp97ohKLYjd3eDORJ3gTpQ3VZRZkh97aVzn+dzPDOTYQgDI/m8FgzOemo8H1LAZNoafzEJ7zkJzXRdsXVedPlpHsr7BO+A6GawEFe/KclsUoCZK7iWQi+E8w1NiDCMTVX2I8mOVBawaxcdJ8K6DpQrLKi3ur/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9J0B+PF; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzWtJjW9R2btlwvyvs6XKG3/2mMo8y8Gg66hXCWdp3SivWgfnwXiIknXqwraAN6nHzjvL3KWNMWgMgn5rMGcLMRuv11V/RiJ1YcyQTpcyWneR8AxcsTnAipjAcjSjPHPFoJOnOIxNihf1247TcwxHqDD7qvwcSlE3rthS0p56kY9Zu194LZeLWHAUOVkOtqBtsT4DJTLTEd9ZKr64N1g80vUIV0sTbpAwb0pUNjyom86UcMlbSGbPsjFFQVc9XpeBMjxaPlxon4gM/jsjZyh6VGDAMILbsdMfK4ClxH2Ide+jgpL7/GHoZLipENQw2FEv04CQRfskUlMuFzOWAAQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLD3QS6UFLHJj0RTuaJmZnufbr8UK66br0CNPi6oOUY=;
 b=eSdy9jJCnAveXilySbVXcElY41QCTtoaXYZW//UwST2PxuB7vM/Wb6R6WnmeZRir3A7oZOYxMIuemNkvz6VvCYCjRvg4I5u+p3+8uvgyx2XJdUgmvpuOreE3z74e5KIDXvA03fkfjPdRZKcoRwZGMnrcav8nMHrgbPLpmIXTrxwUM5GbNMa57wwzXRBrvyi9hwjuDBontrLzLojAWzingugI6tXtn8X8Kn3/2iJAo//Jo0qs1y9KAhbd2MYbDPCTrS4Gdqw6qiRhzLLH/DQHo2zu2MKaOSCJyH/400WRmPDobd3opoDksqq/DRKcXL//eOPGaHGW695lU/Yi+89AQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLD3QS6UFLHJj0RTuaJmZnufbr8UK66br0CNPi6oOUY=;
 b=E9J0B+PFbqWigiQ5M9dMZLwB94ikIaG665LoUeSuh6QVFaG/WwHax5kv1s9tvRY79ytcHelsqL113hxr+VJ8sFUp53vI6EvLkHsZziOCpzluxVUvnaG6OEFIW26Lf94S1NbdGqBplqdhYFN2zydCoVnP7dsvdSnIIDerY7XGKQNLk73u6dxIB/OJIjcgWMwXh2Bu7VEm6JOa+mGn2kdVC65AYSvdPHD6DXfmhjGX91zJlRHbf2EHn6MQI5PZ/rTePmM7goqxGeuA+8EO1obgAFsJ71X6anA+kcpqaU/j742iXkU/0U6JnLlVRjbpHKKCH7OZovoiUaTFFe0aMrpg6Q==
Received: from BY5PR17CA0012.namprd17.prod.outlook.com (2603:10b6:a03:1b8::25)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 12:37:39 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::49) by BY5PR17CA0012.outlook.office365.com
 (2603:10b6:a03:1b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 12:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:20 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:17 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 1/5] module-common: Add module_dump_eeprom_hex() helper
Date: Tue, 19 May 2026 15:36:58 +0300
Message-ID: <931f2708e3d4b8bb86f41856f6f460117a1f0a1d.1779190777.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 89211e73-ef48-4743-c6fb-08deb5a369c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WBIzG8Tsu3ZjzykOgPRJf+HYFTJxwCMx+w6TJ3NGBXLIoWFG+khJ7wB3gNIj22QNNy1eDUNBbfEU1sg9py7gyWqpH5Z1l4rwI0/7PdzDnPONj4UhNHHqu5QdbXzD11wOJxh0YcpjLR/YUq13UoX75yxohWGf+wFup+7w5FVPKV4KmuKf+ssipyt7ryfvuIub5ufJ+KgUB4gq8c3/0wHouWP0HMFSdCkCfkJXTeJdvIVbw0d0dlhOCeClZhk3O3qIUhBkxu/6vyYZG6eZ7KIpMKM5/P6H3aUKLoreFG47J392SkD6qfGPV2PLhQ1Y5Ib5c5GqAcSrrfn8Ul8PfJ2/HDEKjtaEwD/1JFBoU6LE8PnUd8Ewvkkbx/9f0zlhG1pMUpEaqFfAfSbXIqxh8cG/OtOV+8vIarW14MVbF45TrRMhWLpnj31aRGwgT336kUYdf909ONszo1yIfRW43pR/1pUcxYN2/HEdLknc2SOA2mQGgO6aC7U6DVa54tY6OSUIbvlIlvooy+SSucvo+ZLKEVQrHXhbSsdmXOswTck60JVWVvM1vP6QC4fNLcgsTxvhDIeZAwf0oKL/ycOQzTocaodAvCNURk+Js8zP8B2qIfg555JokCBztWw1FBg2kJg+9jAreBCELoF6+6+XdrD89ICYQcQogPSeeDoGnlin61eCUZS39b/xJP6DiZQq25tnN+lqqpn0JXbK/vNM4X1FSZHwdN4Aty1epM1mE2Swi50=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xGXvCsjUVstLuQmZJbp/DVykTIqcOeZrn2s7gpm5kPlnE+Rdzs/P2TIP0pptTNfK5jJ5240BlWLEAdNVY5cGHP9VK3P1DDqPtuUJr89vKSR7r1rZityj8u5j6F3ITk/wM+lPKTZfGwE+SoKHL+jqNbPFfhgyFgiRyOBYg+yLwR0Tm3X2Z9/uYreC3CNuNkWiQFXarPJrlFMhBaayR42CmNEPErelpX58qMneK/g0ApogXSssiaHVXht9BS2WgYTHOBsrbuJjYai8C98TPtlio2Up787xbrgvndshQ0m4Au28dNIQrwc///WlIPGrJep8ONxVCJCqyvppwok1mk53bUBmACv09jHTTKSMvEEasJ8smtCJTy9k4fiDSqnvf3rSFkcsCERQnMvjkgug2XCNea9R6ZM7QDmCPdxKY1saEsoNNpZTmwfUe4eyR3oy9Ntq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:39.0926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89211e73-ef48-4743-c6fb-08deb5a369c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289450-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CD8D757EF40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add module_dump_eeprom_hex() as the shared building block for the
per-type EEPROM page hex dump functions added in the next patch. It
prints a per-page header followed by a hex dump; the header format is
selected by print_i2c / print_bank flags in struct module_eeprom_dump.

In JSON context, the flags are ignored and all metadata fields are
emitted as one object inside the enclosing "pages" array.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 module-common.c | 38 ++++++++++++++++++++++++++++++++++++++
 module-common.h | 12 ++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/module-common.c b/module-common.c
index 4e9a0a7..1cfe243 100644
--- a/module-common.c
+++ b/module-common.c
@@ -656,3 +656,41 @@ void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 	PRINT_VCC_ALL("Module voltage", "module_voltage_measurement",
 		      sd->sfp_voltage[MCURR]);
 }
+
+/* Print one EEPROM memory block with a descriptive header followed by hex
+ * dump. The header is selected by the dump->print_i2c and dump->print_bank
+ * flags: "Page: 0xN" is always printed, an I2C-addressed block prints
+ * "I2C Address: 0xN" and a banked page prints "Bank: 0xN".
+ *
+ * In JSON context, all fields (bank, page, offset, length, i2c_address) are
+ * emitted unconditionally as a JSON object inside the enclosing "pages"
+ * array.
+ */
+void module_dump_eeprom_hex(const struct module_eeprom_dump *dump)
+{
+	u32 i;
+
+	if (is_json_context()) {
+		open_json_object(NULL);
+		print_uint(PRINT_JSON, "bank", "%u", dump->bank);
+		print_uint(PRINT_JSON, "page", "%u", dump->page);
+		print_uint(PRINT_JSON, "offset", "%u", dump->offset);
+		print_uint(PRINT_JSON, "length", "%u", dump->length);
+		print_uint(PRINT_JSON, "i2c_address", "%u", dump->i2c_address);
+		open_json_array("data", "");
+		for (i = 0; i < dump->length; i++)
+			print_hex(PRINT_JSON, NULL, "%02x", dump->data[i]);
+		close_json_array("");
+		close_json_object();
+		return;
+	}
+
+	if (dump->print_i2c)
+		printf("I2C Address: 0x%02x\n", dump->i2c_address);
+	if (dump->print_bank)
+		printf("Bank: 0x%x\n", dump->bank);
+	printf("Page: 0x%x\n\n", dump->page);
+
+	dump_hex(stdout, dump->data, dump->length, dump->offset);
+	printf("\n");
+}
diff --git a/module-common.h b/module-common.h
index 985b518..4063448 100644
--- a/module-common.h
+++ b/module-common.h
@@ -261,6 +261,17 @@ struct module_aw_chan {
 	__u8 adver_value;	/* Supported if (offset & value) != 0. */
 };
 
+struct module_eeprom_dump {
+	u32 offset;
+	u32 length;
+	u8 page;
+	u8 bank;
+	u8 i2c_address;
+	bool print_bank;
+	bool print_i2c;
+	const u8 *data;
+};
+
 extern const struct module_aw_mod module_aw_mod_flags[];
 extern const struct module_aw_chan module_aw_chan_flags[];
 
@@ -283,5 +294,6 @@ void module_show_identifier(const __u8 *id, int id_offset);
 void module_show_connector(const __u8 *id, int ctor_offset);
 void module_show_mit_compliance(u16 value);
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd);
+void module_dump_eeprom_hex(const struct module_eeprom_dump *dump);
 
 #endif /* MODULE_COMMON_H__ */
-- 
2.51.0


