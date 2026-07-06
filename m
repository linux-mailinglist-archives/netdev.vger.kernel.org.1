Return-Path: <netdev+bounces-304837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fv3SDTZCS2pJOQEAu9opvQ
	(envelope-from <netdev+bounces-304837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37870CB44
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fWjpjQMi;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304837-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE28B300A7F8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2C3AFAED;
	Mon,  6 Jul 2026 05:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4038AC72
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 05:50:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317041; cv=fail; b=lAzO3PoZaccNpoNWKAkkMCBC2C0avOxbl3wQBG7jvIQiUID8j4sdZOtkRgoCMrOFQIc2Fei2lPNKLAFGQrgg10BXRewGufW4KBBnk9hwMkd+HwBkSMm9A3kqxLBZB5InwP3M8NJj3IMRV+ohogXHK6/a4jSxmcGK5b4BlGDHo/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317041; c=relaxed/simple;
	bh=0l6Tna2k6LIMrCuPU45VvdWOMEBnPfaU442vJHqguzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8XbgSe+gMB2R/1afIGwpVS//WFkryFwFcRsWbhnhPokyarwWCyyDjjcYFQ6o/CxOYqJq0HFvIyewaMOxsSsGY2tfWcPSYyv/nxss6NJreDBTtTvj1d5BIsThtSsx+iFs9hKw6RBaNIkEHc+tbj4jcPprz7CDSuVlHNWZVTf8oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWjpjQMi; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgol+jckKSx33cQt47OV/Qo9gPtAqWMw6OrqfRAYzXKHkg2UiY/a8uLELCp5xDM1Vd1+Q6OpU1hQwHVk3mCOJ8wVjV0NVZGCYJdkNyUc683fYjM5W9kFKXssuDqNqmTaVv1cyWKrqsrNZ/2kPioXStb/37mbTWxorARapOXN/4dEDzWbbFlAiCdZHq7WoGeKGL3y2LuM+Zfz17T33TdbRJEwJdr2J/BtD4Y/i0Ho6yhLvVPDHusCcIQl1ORV7YPMY1BJfx0JR/QeLQJ/twHLz9ZsacjeeeQUr8Wf4xXieGZapBNEhibHSj0QxSaLWK7ykn9zTTZcbKbX+OwlJdqtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfPRIs/6LY9MhQPAVESw9EsOEkjAaRL1Dd3enCc9q0c=;
 b=cbv/f9gWXX0l1rKFzcFQbiWh8xnaEZX1uAwGo2gLJH7snKsiJRduxsjoRYOXM3dP22/MgP5wy6cX52u2Kzhp9fS0OpP1XXjKbW60dzY1S3rWplXuRTVSi9MnkbraUTVPDbxPumWOruRXCikEZytuROFeAwGKEQK62X7L8urcAsLY2rT3gjxg3YQqtISW4f4sDkm/VsiYE2xkE/nQq5VF+KEGkD5DxtDYbY3PzisdxzMkUYr9lXSJpoimcsddAQPyDB3Rt9Fs0v/ykeNgTcnbRiUqtZKjS3WML5SYzTMILXh3IUPAI01lmly918plurohQJLsdA6d+35rRNTvmYDWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfPRIs/6LY9MhQPAVESw9EsOEkjAaRL1Dd3enCc9q0c=;
 b=fWjpjQMi0AykZCmRiZN4znfR3JZyRYRMew/VVX2B8iJC3GttuamRus9siB9IN3CKIXGQKHwIhB+Y0qUIPLKKI9rb8p0Kpvi6suzEvTGiBgHw0uSIh2sJAUMvsYihHjj1OhaTy0g5npQxC6fKhkpxqfiS7n5F4PlReffRpSxyOyjRU+X/bOzjC9NM7/X/t3/lNuTqab8678qVWZ9RBwWOhiv8MoPPVpPQ3jI5GOMRSpVDbc+gtxny3Epk3t9DVT3iL2QjkMEFSDoqxVN8S4Wrpjo7dicHvzmVb4TNJwgt8nesgYGf0ev+0fVMr5uDDd/+rWoY3L6LrmpFJOAtOYQrmA==
Received: from BL1PR13CA0088.namprd13.prod.outlook.com (2603:10b6:208:2b8::33)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 05:50:34 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::78) by BL1PR13CA0088.outlook.office365.com
 (2603:10b6:208:2b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 05:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 05:50:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:50:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:50:18 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 5 Jul
 2026 22:50:14 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net] ethtool: rss: Fix hfunc and input_xfrm parsing on big endian
Date: Mon, 6 Jul 2026 08:50:17 +0300
Message-ID: <20260706055017.3355806-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3cab51-f220-43e7-b730-08dedb227ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	raROcA23K1pNaYfk0xQF1O2a1Fw7Mm5L5DYCdeIRPvuvKvkNFsHk49ktPjqAYC9B/Xcy76mw/oMbe3i6XUPjgI9MAkkfHrTcfcAgONQz0Hw98yOuh9GUajdAF+TsTjDORF0N5Bn4LX4KgCsQaNvyPlLR5ipjmyn5h/7m3qAqZbRoDpliY+udlfrrAtVLHWmiBUK1C4B/VRjJy9yNroctA3a1NzqYxzh8o6OzXQK5rrNHMoUjBS0bf3uhErVEvJGzZFAqMIOZARhS8AZrwOtLP06YUJm130gI8AAacI6VxCi7xh7KNTax3HAKCXRx0lpb85/+CgqqNGuHMSb2M96kaKdO63xKHfSDxNJpHfNfPqai4+JbCUh2WUIXdhb1YKDBqUOOIug/AM4161CS60oV3qJbiAGCx2aoHh6gfwknsl4lco5xiD70mAOcZoSqsF2a0DD06zA/aJNPHlYdNdrWjrvBLyDIZkOknjNqN4ha1tu+ipc17aUcyfrO8tfI604Jz0fgL8BrhRcYGnOaKCyhu4cp+9DfKHg0AZmFhhznfZL9+c0ExS3aCd6/YKTLMTi4nTNVx9B8+XwLK8fvC7x60saeEmDdX7q13rEum5FbQVgghfTC6nbcjEwkWKKY/bY28cXQuQCObI32y+NFystM3gljow6sFwAyyZgAKTGcYT8/HjJxMFF40VeAgoTaEvMDwJUxgT49z4hz5tIiHRTslA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Q46EWWbth1CKL8YiXOXawKDCBXZZ5MCOMtiJlcsi0Xnrd1LSl37P3R+aIHbs7BHaCybY+Difmp9oYFdKI3ULNOpAGuuSQjNNeOTAgDav97RGZCYpl5k8dVVCYLenI7qOirK0KZEfuDmUCcaQ4K0ogooOtVAYHMBKfxCxmxh0oTacFC/Igp5MEPjTLsrIXLQwPExPrzeSCXKfgp84q4a5AVNxa125U9Hbpmxv7P5A0+yag6ayJeN2rMKW4FMWmkIctf9LHvuiasQNdG4r6ojOShyiLEeFGgmRi4rSYdFg7C77vqhMag/XeElw0BYpzw006jCoPXnjKHQ0LfZK5k6YSB3l9Z2wHNBVCU3sD4WWp4fvwgaZO/UnvhO/gKWX8KPHZrQCmbzRJFd/NmJj1lhbIxzrGh096EoFyLf8xeq7Uavpem9gTDSxgIDgiO+BemE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:50:33.3688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3cab51-f220-43e7-b730-08dedb227ec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:horms@kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:noren@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304837-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C37870CB44

ETHTOOL_A_RSS_HFUNC and ETHTOOL_A_RSS_INPUT_XFRM are NLA_U32 attributes,
but ethnl_rss_set() and ethnl_rss_create_doit() parse them with
ethnl_update_u8(), which reads a single byte.

On little endian this happens to read the least significant byte and
works as long as the value fits in a byte. On big endian it reads the
most significant byte, so the requested value is parsed incorrectly.

The destination fields in struct ethtool_rxfh_param are u8, so the
attribute can't be read directly with ethnl_update_u32().
Cap the hfunc policy at U8_MAX so an out of range value is rejected
instead of being silently truncated into the u8 field, and add
ethnl_update_u8_u32() to read the full u32 and narrow it into the u8
destination.

Fixes: 82ae67cbc423 ("ethtool: rss: support setting hfunc via Netlink")
Fixes: d3e2c7bab124 ("ethtool: rss: support setting input-xfrm via Netlink")
Fixes: a166ab7816c5 ("ethtool: rss: support creating contexts via Netlink")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/netlink.h | 28 ++++++++++++++++++++++++++++
 net/ethtool/rss.c     | 14 ++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index fd2198e45d2b..733fb3c3a63a 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -115,6 +115,34 @@ static inline void ethnl_update_u8(u8 *dst, const struct nlattr *attr,
 	*mod = true;
 }
 
+/**
+ * ethnl_update_u8_u32() - update u8 value from an NLA_U32 attribute
+ * @dst:  value to update
+ * @attr: netlink attribute with new value or null
+ * @mod:  pointer to bool for modification tracking
+ *
+ * Some attributes are NLA_U32 on the wire but are stored in a u8. Read the
+ * full 32-bit value from NLA_U32 netlink attribute @attr and narrow it into
+ * the u8 pointed to by @dst; do nothing if @attr is null.
+ * Bool pointed to by @mod is set to true if this function changed the value
+ * of *dst, otherwise it is left as is.
+ */
+static inline void ethnl_update_u8_u32(u8 *dst, const struct nlattr *attr,
+				       bool *mod)
+{
+	u32 val;
+
+	if (!attr)
+		return;
+	val = nla_get_u32(attr);
+	DEBUG_NET_WARN_ON_ONCE(val > U8_MAX);
+	if (*dst == val)
+		return;
+
+	*dst = val;
+	*mod = true;
+}
+
 /**
  * ethnl_update_bool32() - update u32 used as bool from NLA_U8 attribute
  * @dst:  value to update
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 53792f53f922..ca6ed152c2be 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -574,7 +574,7 @@ static const struct nla_policy ethnl_rss_flows_policy[] = {
 const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1] = {
 	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
-	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_RANGE(NLA_U32, 1, U8_MAX),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
 	[ETHTOOL_A_RSS_HKEY] = NLA_POLICY_MIN(NLA_BINARY, 1),
 	[ETHTOOL_A_RSS_INPUT_XFRM] =
@@ -855,7 +855,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
 
 	rxfh.hfunc = data.hfunc;
-	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
+	ethnl_update_u8_u32(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
 	if (rxfh.hfunc == data.hfunc)
 		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
 
@@ -864,7 +864,8 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 		goto exit_free_indir;
 
 	rxfh.input_xfrm = data.input_xfrm;
-	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
+	ethnl_update_u8_u32(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM],
+			    &mod);
 	xfrm_sym = rxfh.input_xfrm || data.input_xfrm;
 	if (rxfh.input_xfrm == data.input_xfrm)
 		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
@@ -938,7 +939,7 @@ const struct ethnl_request_ops ethnl_rss_request_ops = {
 const struct nla_policy ethnl_rss_create_policy[ETHTOOL_A_RSS_INPUT_XFRM + 1] = {
 	[ETHTOOL_A_RSS_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT]	= NLA_POLICY_MIN(NLA_U32, 1),
-	[ETHTOOL_A_RSS_HFUNC]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RSS_HFUNC]	= NLA_POLICY_RANGE(NLA_U32, 1, U8_MAX),
 	[ETHTOOL_A_RSS_INDIR]	= NLA_POLICY_MIN(NLA_BINARY, 1),
 	[ETHTOOL_A_RSS_HKEY]	= NLA_POLICY_MIN(NLA_BINARY, 1),
 	[ETHTOOL_A_RSS_INPUT_XFRM] =
@@ -1054,14 +1055,15 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto exit_clean_data;
 	indir_user_size = ret;
 
-	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
+	ethnl_update_u8_u32(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
 
 	ret = rss_set_prep_hkey(dev, info, &data, &rxfh, &mod);
 	if (ret)
 		goto exit_free_indir;
 
 	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
-	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
+	ethnl_update_u8_u32(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM],
+			    &mod);
 
 	ctx = ethtool_rxfh_ctx_alloc(ops, data.indir_size, data.hkey_size);
 	if (!ctx) {
-- 
2.54.0


