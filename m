Return-Path: <netdev+bounces-305278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b6U0BKeWTGrKmgEAu9opvQ
	(envelope-from <netdev+bounces-305278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:03:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A9717BB4
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:03:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=A7gi6qZI;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305278-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305278-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3C6A3009821
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335138735D;
	Tue,  7 Jul 2026 06:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE9386C2C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:01:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404078; cv=fail; b=rnoyHhkI8+/qP81Xup+4LkOHLU5K/7mQfitN0ZoH3ptTT8CTqGyQJmMA0Swczq92SiBRJTXemkRMHQrVU+m5cCpTQ71asiwGCOcVolKhSGJd/8SAWjhoeBfq0IMZGWZZE6MiYZ2F6HI/Fk0/uL4YpvmSlHJZLqO/gmX1FQNPcvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404078; c=relaxed/simple;
	bh=bnV5fm3/nq3A6c4ILXQY3kruImKO5RqKDzbminxX6K4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRFllr4rF25ZUjxQTV0PBE6X7QwBAYviKYdRTPEKA+0lXK+nmBb9U+iA0q3Vrvh04/vEhYm95oTjf4Al0HDGo/7KgaxwkAgKsPI/d6dXRMaybNdxT8dXKbuZQoNhGr/52EfZlpU25Ei1TzBKDkzV1+n42FDOxjhrIAA1XKh56PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7gi6qZI; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz9FwcbMjpxwKmM8FIEdpPbK7WYnD10qnyzkgD7lPgxjIsz+Kqh5bWG84CQCNJr1gc9duuaMA1UAa778OjKFYxjMs5U596H7kk1RD9XBNu7IS8+m/dVl1hjVGUhadKrMngqAt0oKg6kIMy6S7xOok0I6FdjP2XqZq81PaAlLNdI/lqs2Hvc0L14FNjtf5IKyKcBXH8nDuMVLhjUMlvKpIr2u+WONOY/GHu1CIPorQHZFD+kro1RvM7Aw68B/xwIpKIwGgdevm4SXv2zbHk0WX8GFNCcYzh7KXZJtqpwfNl8UwyWi//2rZgzg2N0AXajAc6HRYGTUiG/luDMChLEzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76qAYbDjp1JM086i+nXSenYzl4dxI91YLuHhGu78sWM=;
 b=Dd4mcBrOXlBZbnQ7RUuGPqcf1OV3NuUj/fiPjE7gUXQFkDphCITQ1Ufg0NItpesYBgTrS5MCCldHsEM7IqjztmuTXH3wzG2F8Zhn2sV5Dqi5uMdO/AGEoODbLJhPXU7a8QAnY9/kLZNcErC/CB4izJYxVVF/3dk8iOf65093+rMPjQDp7bmnNJ4QAwaTuAHLf2U1SmedEJf3KQgOh1ZFOas++L3J15zVd1oF/yRKLzrrbatY5BxJNSIV91lC6fFgS27GIqblYKEMvcp5Dg3goQfHKGNj0bmdDDfiQE/5JccWZzXyLwDQaKvA7Q6l4TN9AuWoz/YA2bYSqwkXIgajEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76qAYbDjp1JM086i+nXSenYzl4dxI91YLuHhGu78sWM=;
 b=A7gi6qZIwzlHAvXAxK0S78zi9jkthdoWGRhsV0/467G5OXlcoyDsb3KBsy0U2RsomNGQ0k5blTX5s6+tW3CNmFk6wlkOPCC6X244oJh1uqmCnrOZpZdfm44vFbYeatII0tynfUDNr4rRuARAwIcTnAbItbFNt+EaVqkNxifV2r98ZukOiCmKO7uGyfEmYADUq5uzyWI5Ligz2qYIZot5gKKLmhsE/99tAnwMv9WDUx9y8tmVGAPoSEbLWWO15rueFxLVO8nhyyjx/ZhAvpmMpHC0S8Hiwts+6a1NtPpUInlRDZrwJ5PzZAYok/C3/lkyl5blWOpzXwPzeWxgmYd9Hw==
Received: from BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:01:11 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::8b) by BL1PR13CA0328.outlook.office365.com
 (2603:10b6:208:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 06:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 06:01:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 23:00:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 23:00:48 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 23:00:46 -0700
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH ethtool-next] netlink: rss: Add set support
Date: Tue, 7 Jul 2026 09:00:52 +0300
Message-ID: <20260707060052.3523136-1-gal@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: dd034d4b-cb5a-43d5-85d6-08dedbed2516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	K3C0DEso/kSQHlJZIM6jPoVA6hKiPx2LE2gyMDB0lw0sac8OxGZru1Cec3qsycIQqdyCTOZdbbLjCBCN3wusIGjLj+n3ojQznuInhFO2JDAqWt07U5tMB0UB1eJF4UroWeYQFgyA5wTsyKiEf21NxgKDrYN8d8Y2H1SgYrd2/SUXjOgo9bpssuNg95vnssPHk39pOCIQNuZGqrkDIJYSPNNJjXdr7XPHPUsSk+/BOl+BjaJ+OpWdu6f8rsqSN8MKEQUBueWEj2PZlIMF/23xQWGz2Y0Ka/K+PCN1rHj6tETyrd3kvOCGMB3sJMAjBYF9rfv9+E09NuxatLwfoBs2/3NhoHMz+2MxY7yF/es9i5m+8oKVH5Y80k6/MykpNrqFPv5O7l+kcign9510PK3q6er4AI2hLZAWTXZ1b0PS/mslAo8/VCe18Bx8R4silHcbNUQ+camlqAMDodEO7es0VVGo8HNUabeDddzO2YFwtOh39lc+mBEhd1YW2vsl53zhqGLEJz4+NzF5NfoqQ6BTbPT0zaWXgFW3OBiAeNMHQrdpsYmJlqC0SDG018+pe50v//eHWR8raiwKYRfo52XHhPH9e86g+SrhuPIncXqZ41JIUY6b3gR4pOhIolDB3cKfVkUQoVYUhGVTYuuJBuf4fJc5akFBZSaXtiLPPvPrg/PeZlewgGER8PeCCpOFwuO4oxL6IvUdmLUWLsyi9/tZpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s2QHthc9zguBdNliJJ9NAfjb44hP8SD3sXquNRuNrsVwejdzHh+W6sMzgGE27IQoE71uGhuSSSJEgb8DR8LxSVWpgwaJ/8VHIvzM+h8qAWpwnFJ8LwMHL9EkjLs1BtrizU3SmQaPiOEUhN6BJeZsueMEEES5HSI8lQA8Txi2HI0q8k0HptmpBgCbg95xrD5ffLCQ0MdZg6QgYwQuiqItei+TZFzibhNQeU/wNkw9e7mCaK7I7e3ltrkJCQFdUYxgy0/FjAOFhB6N1uSOcQIH4sJgQWO6UJ22TqZ/JCD2tyxzrVJ6JFSRWrImLQ5QZo/f4I8kPapoON+si81yuXm3aoNiKjecxqxb++2dj6X+lyOp4YB6lFamgWIJVvFXIW3QvY+hYj3YzqKEugeTXFY6VN+XUG3tIWHV0ObZw+bmtilG4zHynJ3plZt/q2Xrxfd/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:01:10.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd034d4b-cb5a-43d5-85d6-08dedbed2516
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-305278-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:kuba@kernel.org,m:gal@nvidia.com,m:noren@nvidia.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 072A9717BB4

The kernel has exposed ETHTOOL_MSG_RSS_SET, RSS_CREATE_ACT and
RSS_DELETE_ACT since v6.17, but ethtool's -X has remained ioctl only.
Add nl_srss() so the command goes through netlink by default, the ioctl
path remains as fallback for older kernels.

All CLI keywords accepted by the ioctl path are handled. nl_srss()
dispatches by parsed args:

  context new        -> ETHTOOL_MSG_RSS_CREATE_ACT
  context N delete   -> ETHTOOL_MSG_RSS_DELETE_ACT
  otherwise          -> ETHTOOL_MSG_RSS_SET

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c        |  10 +-
 internal.h       |   5 +
 netlink/extapi.h |   2 +
 netlink/rss.c    | 510 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 522 insertions(+), 5 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 3076c128bb34..c8b6a38c288d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1207,8 +1207,7 @@ err:
 	return 2;
 }
 
-static int parse_hkey(char **rss_hkey, u32 key_size,
-		      const char *rss_hkey_string)
+int parse_hkey(char **rss_hkey, u32 key_size, const char *rss_hkey_string)
 {
 	if (!key_size) {
 		fprintf(stderr,
@@ -4207,9 +4206,9 @@ out:
 	return 0;
 }
 
-static int fill_indir_table(u32 *indir_size, u32 *indir, int rxfhindir_default,
-			    int rxfhindir_start, int rxfhindir_equal,
-			    char **rxfhindir_weight, u32 num_weights)
+int fill_indir_table(u32 *indir_size, u32 *indir, int rxfhindir_default,
+		     int rxfhindir_start, int rxfhindir_equal,
+		     char **rxfhindir_weight, u32 num_weights)
 {
 	u32 i;
 
@@ -6215,6 +6214,7 @@ static const struct option args[] = {
 	{
 		.opts	= "-X|--set-rxfh-indir|--rxfh",
 		.func	= do_srxfh,
+		.nlfunc	= nl_srss,
 		.help	= "Set Rx flow hash indirection table and/or RSS hash key",
 		.xhelp	= "		[ context %d|new ]\n"
 			  "		[ equal N | weight W0 W1 ... | default ]\n"
diff --git a/internal.h b/internal.h
index 19fff417ab0f..50d43ccd844a 100644
--- a/internal.h
+++ b/internal.h
@@ -286,6 +286,11 @@ int test_fclose(FILE *fh);
 int ioctl_init(struct cmd_context *ctx, bool no_dev);
 int send_ioctl(struct cmd_context *ctx, void *cmd);
 
+int parse_hkey(char **rss_hkey, u32 key_size, const char *rss_hkey_string);
+int fill_indir_table(u32 *indir_size, u32 *indir, int rxfhindir_default,
+		     int rxfhindir_start, int rxfhindir_equal,
+		     char **rxfhindir_weight, u32 num_weights);
+
 void dump_hex(FILE *f, const u8 *data, int len, int offset);
 
 /* National Semiconductor DP83815, DP83816 */
diff --git a/netlink/extapi.h b/netlink/extapi.h
index b0e458804297..e10af6230bb3 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -50,6 +50,7 @@ int nl_smodule(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 int nl_getmodule(struct cmd_context *ctx);
 int nl_grss(struct cmd_context *ctx);
+int nl_srss(struct cmd_context *ctx);
 int nl_plca_get_cfg(struct cmd_context *ctx);
 int nl_plca_set_cfg(struct cmd_context *ctx);
 int nl_plca_get_status(struct cmd_context *ctx);
@@ -130,6 +131,7 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_gmodule		NULL
 #define nl_smodule		NULL
 #define nl_grss			NULL
+#define nl_srss			NULL
 #define nl_plca_get_cfg		NULL
 #define nl_plca_set_cfg		NULL
 #define nl_plca_get_status	NULL
diff --git a/netlink/rss.c b/netlink/rss.c
index 83cc50416dc7..c0fbba8bc2ac 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -4,7 +4,10 @@
  * Implementation of "ethtool -x <dev>"
  */
 
+#include <ctype.h>
 #include <errno.h>
+#include <stddef.h>
+#include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
 
@@ -246,3 +249,510 @@ int nl_grss(struct cmd_context *ctx)
 err:
 	return nlctx->exit_code ?: 1;
 }
+
+/* RSS_SET */
+enum {
+	SRSS_PARAM_EQUAL,
+	SRSS_PARAM_WEIGHT,
+	SRSS_PARAM_START,
+	SRSS_PARAM_DEFAULT,
+	SRSS_PARAM_HKEY,
+	SRSS_PARAM_HFUNC,
+	SRSS_PARAM_XFRM,
+	SRSS_PARAM_CONTEXT,
+	SRSS_PARAM_DELETE,
+};
+
+struct srss_cmd {
+	unsigned long	present;
+	u32		equal;
+	u32		start;
+	char		**weight;
+	u32		num_weights;
+	char		*hkey;
+	char		*hfunc;
+	u32		input_xfrm;
+	u32		context;
+};
+
+#define SRSS_HAS(cmd, p)	((cmd)->present & (1UL << (p)))
+
+struct rss_sizes {
+	u32	indir_size;
+	u32	key_size;
+};
+
+static int rss_sizes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_RSS_MAX + 1] = {};
+	struct rss_sizes *sizes = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return MNL_CB_ERROR;
+
+	if (tb[ETHTOOL_A_RSS_INDIR])
+		sizes->indir_size =
+			mnl_attr_get_payload_len(tb[ETHTOOL_A_RSS_INDIR]) /
+			sizeof(u32);
+
+	if (tb[ETHTOOL_A_RSS_HKEY])
+		sizes->key_size =
+			mnl_attr_get_payload_len(tb[ETHTOOL_A_RSS_HKEY]);
+
+	return MNL_CB_OK;
+}
+
+static int rss_get_sizes(struct nl_context *nlctx, u32 *indir_size,
+			 u32 *key_size)
+{
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	struct nl_msg_buff *msgbuff = &nlsk->msgbuff;
+	struct rss_sizes sizes = {};
+	int ret;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_RSS_GET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_RSS_HEADER,
+			       nlctx->devname, 0))
+		return -EMSGSIZE;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = nlsock_process_reply(nlsk, rss_sizes_reply_cb, &sizes);
+	if (ret < 0)
+		return ret;
+
+	*indir_size = sizes.indir_size;
+	*key_size = sizes.key_size;
+	return 0;
+}
+
+static int rss_resolve_hfunc(struct nl_context *nlctx, const char *name,
+			     u32 *hfunc)
+{
+	const struct stringset *hash_funcs;
+	unsigned int i, count;
+	int ret;
+
+	ret = netlink_init_ethnl2_socket(nlctx);
+	if (ret < 0) {
+		fprintf(stderr, "Cannot get hash function names\n");
+		return ret;
+	}
+
+	hash_funcs = global_stringset(ETH_SS_RSS_HASH_FUNCS,
+				      nlctx->ethnl2_socket);
+	if (!hash_funcs) {
+		fprintf(stderr, "Cannot get hash function names\n");
+		return -ENOENT;
+	}
+
+	count = get_count(hash_funcs);
+	for (i = 0; i < count; i++) {
+		if (!strcmp(get_string(hash_funcs, i), name)) {
+			*hfunc = (u32)1 << i;
+			return 0;
+		}
+	}
+
+	fprintf(stderr, "Unknown hash function: %s\n", name);
+	return -EINVAL;
+}
+
+static int rss_create_reply_cb(const struct nlmsghdr *nlhdr,
+			       void *data __maybe_unused)
+{
+	const struct nlattr *tb[ETHTOOL_A_RSS_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return MNL_CB_ERROR;
+
+	if (tb[ETHTOOL_A_RSS_CONTEXT])
+		printf("New RSS context is %u\n",
+		       mnl_attr_get_u32(tb[ETHTOOL_A_RSS_CONTEXT]));
+
+	return MNL_CB_OK;
+}
+
+static int srss_parse_weight(struct nl_context *nlctx,
+			     uint16_t type __maybe_unused,
+			     const void *data __maybe_unused,
+			     struct nl_msg_buff *msgbuff __maybe_unused,
+			     void *dest)
+{
+	struct srss_cmd *cmd = dest;
+
+	cmd->weight = nlctx->argp;
+	while (nlctx->argc > 0 &&
+	       isdigit((unsigned char)(*nlctx->argp)[0])) {
+		nlctx->argp++;
+		nlctx->argc--;
+		cmd->num_weights++;
+	}
+
+	if (cmd->num_weights == 0) {
+		fprintf(stderr, "'weight' requires at least one value\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct lookup_entry_u32 srss_xfrm_values[] = {
+	{ .arg = "none",             .val = 0 },
+	{ .arg = "symmetric-xor",    .val = RXH_XFRM_SYM_XOR },
+	{ .arg = "symmetric-or-xor", .val = RXH_XFRM_SYM_OR_XOR },
+	{}
+};
+
+static int srss_parse_context(struct nl_context *nlctx,
+			      uint16_t type __maybe_unused,
+			      const void *data __maybe_unused,
+			      struct nl_msg_buff *msgbuff __maybe_unused,
+			      void *dest)
+{
+	struct srss_cmd *cmd = dest;
+	const char *arg = *nlctx->argp;
+
+	nlctx->argp++;
+	nlctx->argc--;
+
+	if (!strcmp(arg, "new")) {
+		cmd->context = ETH_RXFH_CONTEXT_ALLOC;
+	} else {
+		u32 v;
+
+		if (parse_u32(arg, &v) ||
+		    v < 1 || v > ETH_RXFH_CONTEXT_ALLOC - 1) {
+			fprintf(stderr, "Invalid 'context' value\n");
+			return -EINVAL;
+		}
+		cmd->context = v;
+	}
+
+	return 0;
+}
+
+/* "default" and "delete" are flags with no extra arg, just being seen
+ * (recorded in cmd->present) is enough.
+ */
+static int srss_parse_flag(struct nl_context *nlctx __maybe_unused,
+			   uint16_t type __maybe_unused,
+			   const void *data __maybe_unused,
+			   struct nl_msg_buff *msgbuff __maybe_unused,
+			   void *dest __maybe_unused)
+{
+	return 0;
+}
+
+static const struct param_parser srss_params[] = {
+	[SRSS_PARAM_EQUAL] = {
+		.arg		= "equal",
+		.handler	= nl_parse_direct_u32,
+		.dest_offset	= offsetof(struct srss_cmd, equal),
+		.min_argc	= 1,
+		.alt_group	= 1,
+	},
+	[SRSS_PARAM_WEIGHT] = {
+		.arg		= "weight",
+		.handler	= srss_parse_weight,
+		.min_argc	= 1,
+		.alt_group	= 1,
+	},
+	[SRSS_PARAM_START] = {
+		.arg		= "start",
+		.handler	= nl_parse_direct_u32,
+		.dest_offset	= offsetof(struct srss_cmd, start),
+		.min_argc	= 1,
+	},
+	[SRSS_PARAM_DEFAULT] = {
+		.arg		= "default",
+		.handler	= srss_parse_flag,
+		.alt_group	= 1,
+	},
+	[SRSS_PARAM_HKEY] = {
+		.arg		= "hkey",
+		.handler	= nl_parse_string,
+		.dest_offset	= offsetof(struct srss_cmd, hkey),
+		.min_argc	= 1,
+	},
+	[SRSS_PARAM_HFUNC] = {
+		.arg		= "hfunc",
+		.handler	= nl_parse_string,
+		.dest_offset	= offsetof(struct srss_cmd, hfunc),
+		.min_argc	= 1,
+	},
+	[SRSS_PARAM_XFRM] = {
+		.arg		= "xfrm",
+		.handler	= nl_parse_lookup_u32,
+		.handler_data	= srss_xfrm_values,
+		.dest_offset	= offsetof(struct srss_cmd, input_xfrm),
+		.min_argc	= 1,
+	},
+	[SRSS_PARAM_CONTEXT] = {
+		.arg		= "context",
+		.handler	= srss_parse_context,
+		.min_argc	= 1,
+	},
+	[SRSS_PARAM_DELETE] = {
+		.arg		= "delete",
+		.handler	= srss_parse_flag,
+		.alt_group	= 1,
+	},
+	{}
+};
+
+static int srss_validate_cmd(const struct srss_cmd *cmd)
+{
+	if (SRSS_HAS(cmd, SRSS_PARAM_EQUAL) &&
+	    (cmd->equal < 1 || cmd->equal > INT_MAX)) {
+		fprintf(stderr, "Invalid 'equal' value\n");
+		return -EINVAL;
+	}
+
+	if (SRSS_HAS(cmd, SRSS_PARAM_START) && cmd->start > INT_MAX) {
+		fprintf(stderr, "Invalid 'start' value\n");
+		return -EINVAL;
+	}
+
+	if (SRSS_HAS(cmd, SRSS_PARAM_DELETE)) {
+		static const struct {
+			unsigned int	param;
+			const char	*name;
+		} delete_forbidden[] = {
+			{ SRSS_PARAM_HKEY,  "hkey"  },
+			{ SRSS_PARAM_HFUNC, "hfunc" },
+			{ SRSS_PARAM_XFRM,  "xfrm"  },
+			{ SRSS_PARAM_START, "start" },
+		};
+		unsigned int i;
+
+		if (!SRSS_HAS(cmd, SRSS_PARAM_CONTEXT)) {
+			fprintf(stderr,
+				"Delete option requires context option\n");
+			return -EINVAL;
+		}
+		if (cmd->context == ETH_RXFH_CONTEXT_ALLOC) {
+			fprintf(stderr,
+				"Delete and 'context new' are mutually exclusive\n");
+			return -EINVAL;
+		}
+		for (i = 0; i < ARRAY_SIZE(delete_forbidden); i++) {
+			if (SRSS_HAS(cmd, delete_forbidden[i].param)) {
+				fprintf(stderr,
+					"Delete and %s options are mutually exclusive\n",
+					delete_forbidden[i].name);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (SRSS_HAS(cmd, SRSS_PARAM_START) &&
+	    SRSS_HAS(cmd, SRSS_PARAM_DEFAULT)) {
+		fprintf(stderr,
+			"Start and default options are mutually exclusive\n");
+		return -EINVAL;
+	}
+
+	if (SRSS_HAS(cmd, SRSS_PARAM_START) &&
+	    !(SRSS_HAS(cmd, SRSS_PARAM_EQUAL) ||
+	      SRSS_HAS(cmd, SRSS_PARAM_WEIGHT))) {
+		fprintf(stderr,
+			"Start must be used with equal or weight options\n");
+		return -EINVAL;
+	}
+
+	if (SRSS_HAS(cmd, SRSS_PARAM_DEFAULT) &&
+	    SRSS_HAS(cmd, SRSS_PARAM_CONTEXT)) {
+		fprintf(stderr,
+			"Default and context options are mutually exclusive\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int nl_srss(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	u32 indir_size = 0, key_size = 0;
+	struct nl_msg_buff *msgbuff;
+	struct srss_cmd cmd = {};
+	struct nl_socket *nlsk;
+	unsigned int msg_type;
+	char *hkey = NULL;
+	u32 *indir = NULL;
+	u32 hfunc_val = 0;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_RSS_SET, false))
+		return -EOPNOTSUPP;
+
+	if (!ctx->argc) {
+		fprintf(stderr, "ethtool (-X): parameters missing\n");
+		ret = 1;
+		goto out;
+	}
+
+	nlctx->cmd = "-X";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = nl_parser(nlctx, srss_params, &cmd, PARSER_GROUP_NONE, NULL);
+	if (ret < 0)
+		goto out;
+
+	ret = srss_validate_cmd(&cmd);
+	if (ret)
+		goto out;
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_DELETE))
+		msg_type = ETHTOOL_MSG_RSS_DELETE_ACT;
+	else if (cmd.context == ETH_RXFH_CONTEXT_ALLOC)
+		msg_type = ETHTOOL_MSG_RSS_CREATE_ACT;
+	else
+		msg_type = ETHTOOL_MSG_RSS_SET;
+
+	if (msg_type != ETHTOOL_MSG_RSS_SET &&
+	    netlink_cmd_check(ctx, msg_type, false))
+		return -EOPNOTSUPP;
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_HKEY) ||
+	    SRSS_HAS(&cmd, SRSS_PARAM_EQUAL) ||
+	    SRSS_HAS(&cmd, SRSS_PARAM_WEIGHT) ||
+	    SRSS_HAS(&cmd, SRSS_PARAM_DEFAULT)) {
+		ret = rss_get_sizes(nlctx, &indir_size, &key_size);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (indir_size == 0 && (SRSS_HAS(&cmd, SRSS_PARAM_EQUAL) ||
+				SRSS_HAS(&cmd, SRSS_PARAM_WEIGHT) ||
+				SRSS_HAS(&cmd, SRSS_PARAM_DEFAULT))) {
+		fprintf(stderr,
+			"Device does not support RX indirection table\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = msg_init(nlctx, msgbuff, msg_type, NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		goto out;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_RSS_HEADER,
+			       ctx->devname, 0)) {
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
+	if (msg_type == ETHTOOL_MSG_RSS_DELETE_ACT) {
+		if (ethnla_put_u32(msgbuff, ETHTOOL_A_RSS_CONTEXT,
+				   cmd.context)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+		goto send;
+	}
+
+	/* For SET: include context id if targeting a non-default context.
+	 * For CREATE: omit context (kernel auto-allocates).
+	 */
+	if (msg_type == ETHTOOL_MSG_RSS_SET &&
+	    SRSS_HAS(&cmd, SRSS_PARAM_CONTEXT)) {
+		if (ethnla_put_u32(msgbuff, ETHTOOL_A_RSS_CONTEXT,
+				   cmd.context)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+	}
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_HKEY)) {
+		ret = parse_hkey(&hkey, key_size, cmd.hkey);
+		if (ret)
+			goto out;
+
+		if (ethnla_put(msgbuff, ETHTOOL_A_RSS_HKEY, key_size, hkey)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+	}
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_HFUNC)) {
+		ret = rss_resolve_hfunc(nlctx, cmd.hfunc, &hfunc_val);
+		if (ret < 0)
+			goto out;
+
+		if (ethnla_put_u32(msgbuff, ETHTOOL_A_RSS_HFUNC, hfunc_val)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+	}
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_XFRM)) {
+		if (ethnla_put_u32(msgbuff, ETHTOOL_A_RSS_INPUT_XFRM,
+				   cmd.input_xfrm)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+	}
+
+	if (SRSS_HAS(&cmd, SRSS_PARAM_EQUAL) ||
+	    SRSS_HAS(&cmd, SRSS_PARAM_WEIGHT) ||
+	    SRSS_HAS(&cmd, SRSS_PARAM_DEFAULT)) {
+		u32 table_size = indir_size;
+
+		indir = calloc(indir_size, sizeof(*indir));
+		if (!indir) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = fill_indir_table(
+			&table_size, indir, SRSS_HAS(&cmd, SRSS_PARAM_DEFAULT),
+			SRSS_HAS(&cmd, SRSS_PARAM_START) ? cmd.start : 0,
+			SRSS_HAS(&cmd, SRSS_PARAM_EQUAL) ? cmd.equal : 0,
+			SRSS_HAS(&cmd, SRSS_PARAM_WEIGHT) ? cmd.weight : NULL,
+			cmd.num_weights);
+		if (ret)
+			goto out;
+
+		/* fill_indir_table() sets table_size to 0 to signal "reset to
+		 * default" (sent as a zero-length INDIR attribute, which the
+		 * kernel only accepts on the default context).
+		 */
+		if (ethnla_put(msgbuff, ETHTOOL_A_RSS_INDIR,
+			       table_size * sizeof(*indir), indir)) {
+			ret = -EMSGSIZE;
+			goto out;
+		}
+	}
+
+send:
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		goto out;
+
+	if (msg_type == ETHTOOL_MSG_RSS_CREATE_ACT)
+		ret = nlsock_process_reply(nlsk, rss_create_reply_cb, nlctx);
+	else
+		ret = nlsock_process_reply(nlsk, nomsg_reply_cb, nlctx);
+
+out:
+	free(indir);
+	free(hkey);
+	return ret < 0 ? 1 : ret;
+}
-- 
2.54.0


