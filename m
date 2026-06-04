Return-Path: <netdev+bounces-295469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Io/+LEgCImo3RgEAu9opvQ
	(envelope-from <netdev+bounces-295469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:55:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA1643E07
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:55:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=iBzDf7G6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295469-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 059993013885
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8B30C629;
	Thu,  4 Jun 2026 22:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B6285C84
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:54:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613700; cv=fail; b=HFpUiXW4ronKPrr+Gkz+joq2H3yvm185nozSAzmc7MIS385+o1ufc+eQliR1A9mvSoq8zOQJFZt8c5DMzmv0UbBX7GU/x5U2av0/FOZsW+G/kf/hqLS6SQz2rzG338IQFCgGg1BlMlkNPOzj9Nad2oTY0+h4amd6DEce9qrSslk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613700; c=relaxed/simple;
	bh=NmrrqCzVnvnIPMmyyPf2YSbti0a6F18y3zbypeUglmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5ggC8BXE9ZQrQ4bXOPZhPhsY8bSyJNf0F5VLR1JttdluQLfi43l2Hqa8e7JZn8QuvF29DxZyEb/kxXfB8F0YHoqMzFAY1pZ+0hCwla8nduKKrudkw7Xq0wuyhGni+ZWPx6wEOepbVz2mEHVzsmaGdJ7Vfw54rHcDHdImER22eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBzDf7G6; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osk2cjt9b2HnE/3529pJR2e3To+uFRm2pk2IJb++ybHRIvhvTkmL1UPaU2iy0bDk0uZu0yXkoaMtF6HJfLiwRw5eGaEtzGJZCgPHkeXOF7xLfJLVWcst8CLtRG+ZVWaPm8cXjvoiNNCxgrHJLUk1+lFy7iy0d+idt33bFJeqLvedquDLSEnWKbQCnQ0idqMTUC3fDb6SzkvaPQ0AgJTTgPOzmksfX7dYtFIcu6nkPHKtb0fNBmDHKo6Nifo2t6yG2NQK7iBuOx0QVocg36YbVEVy8LGyHpjP3tp7zSZudv7rentpDpKd5dPlQagkE3OHBBbg7cc+3PVF09UD8zAi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ds/t8E1KRNju+1ieDQiM2M9Z+ucR7QMIGU7xNN4Us4=;
 b=s9fER5srRvp9ffX+ZMgRIDQ5TZKSMFtkcgUDPWk9+LfsOTaXJcxdO3Dgb34bE5giITG2pM3dFWsKYZ42scOfRrmvBOhTrFqEmlWrbu0P3dP9S/VMSw6qY8xNundZw4a7mA103JYQ0lr9hYLnNmd5466LTZGzlFp65QqAlreEDOv7wGuWo8E8cnEi+Dju4a1xZvGjApf1k4+o9VSfT9plQ6hzRtvyO3RrvPh1Sm9c8NqNv8RR66azZLutck8ATx3WoOljysSwriKr60Z9E5Pl2V0++UfGb+t7ahHiRh1ER/4Kh/g/8hahULbmzvLQvYc+heEdv6rzxmszwIUZ9ilraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ds/t8E1KRNju+1ieDQiM2M9Z+ucR7QMIGU7xNN4Us4=;
 b=iBzDf7G685OrhWwOmUv/UYvF8f7Bp5P1pxUW2so0Wj+nUDj9BJTdYOy1L7+IVXv7bJ9JLDPg5CK1bJyQX4b8jDlcRygRNq997ppo3F4tCxf/DSn5YR3f8K9Td9Z85JFPXYPEURCLw2pJnkR3LMIFKIbmrWZrPSMb7HVkAkFcSns=
Received: from PH8PR05CA0010.namprd05.prod.outlook.com (2603:10b6:510:2cc::15)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 22:54:55 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::7) by PH8PR05CA0010.outlook.office365.com
 (2603:10b6:510:2cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 22:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 22:54:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 17:54:53 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net] ethtool: Set histogram ranges to NULL before querying FEC data
Date: Thu, 4 Jun 2026 15:54:40 -0700
Message-ID: <20260604225440.11083-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b8115e-3461-4ba2-9036-08dec28c4b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wEkjQIbEvVg5sZFU0lOZ8uXfxEDmpVcBikPBJQlDXjsZLtXDDfuAs6RA7CV2dzNXkguGBrUVrP+IQFJhKvV6eAOuv5lebbLky20iLPH/sxg5ayX7mI4SAuXYf07ILQLi0eOaadk9cfqTdg6UTspaUtv/AaV/ROARJXIZ3LGWIgvm8bwqDsiH1BLiNKGcaKdJ+KQ7UCtcHZrWA4fLAA6Xhhf9//VfxE8CKsicKkiDuThbg1hjwdzQQDhc5qtScssMmDo5kyCwL6SqeUiAyaozyrSA+JhtIDvf2+IYCU/IzV83UZP6kfTrqjbtnZdDFzRUcqVi5Qo0Cs7uVBeOC2aCL8PpHTHzPCPb+Asp2E7Ak3YXHddZr3GGGUMqhJf9dcdQ/dzNnPhrkRUALgdUKJJcBwtRk7mCqw9hZ7wZzp7CrHeMDXBO+jtyQqmpaK5bzrshgv6L9uoEF2FnC0nlR4RyN/BXMIvG7PEvhM3rVqFoHZToOLKBKfm/C/GCbPnmjz9ybIniv56xHYE2KEwJ1a86Sf2+Zr5e69VL1riwlItkqzC8FrZdS028C3bjZqWiZxw1WS1lPZ1Ufekg0EII8ty5WLQEKM6Jv6yLwR6PUmaO+DyN16lC9JmmHpu6qE9Cna55gGaPju/SQ8mDCjgquOIzgXErlqVjozqHjeRcDrqvlJoiPMCaSdqHX2Say3XPCCyKm8OCSB7OUOrteU06v0Ho1BMaaeUvIk3AIGkqu9Sp59I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aKw6jSylZ2kx1YCXA9bG+hg5jo+GZmCk/5Hxl0L22bdzC4ZImkDj/DpjwxuPPFrqt2H1JWmpf4xhwm+018AR6xujEEK10wzfYCX9OhG5CBSNreGb9FJWpp4bpehsNY6gpG3ZFaEYFbsu4FOwNBPhm88idj2xD8svB8Dfsx86sesCLJclDqc3s1B1tCxe+S6FdDk2TKuyI5fQH9W6u2RGsEkFkqHWnzvfROWowZy2WuJUK1mH1DItvP9WcK3+EzL54B5oAkc5yj/8tyQ04RaYapFNQ0+lNH+OmFEcTx+HqXP9KKxtcxFV2xsuP7cNB+lGIT0mfLJv28Q4+VuElfAHL30eST89892Vhue1n0sJrMmwf0sSQXaHzktGhBWCrLXWKh+G9HmPdMtUwWEBK+OvR6/xFUUE/vK0Ji6YzjNXsNY6OgClqAoxm65wjVldNX7I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 22:54:54.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b8115e-3461-4ba2-9036-08dec28c4b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295469-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25AA1643E07

If this field isn't set to NULL, then drivers that set the non-histogram
FEC statistics and don't support/modify the histogram fields will
trigger a WARN_ON() in fec_put_hist(). Drivers shouldn't be forced to
set this field to NULL if they don't have a need to touch FEC histogram
reporting, so set this field before the driver gets the data structure.

Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 net/ethtool/fec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index e2d539271060..640d7f264919 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -116,6 +116,7 @@ static int fec_prepare_data(const struct ethnl_req_info *req_base,
 		ethtool_stats_init((u64 *)&stats, sizeof(stats) / 8);
 		ethtool_stats_init((u64 *)data->fec_stat_hist.values,
 				   sizeof(data->fec_stat_hist.values) / 8);
+		data->fec_stat_hist.ranges = NULL;
 		dev->ethtool_ops->get_fec_stats(dev, &stats,
 						&data->fec_stat_hist);
 

base-commit: b6197b386677ae5268d4702e23849d9ad53051ad
-- 
2.17.1


