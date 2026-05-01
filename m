Return-Path: <netdev+bounces-283113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gImoFu9K9GlSAQIAu9opvQ
	(envelope-from <netdev+bounces-283113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D64AAB19
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 821CA303454A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26545365A0F;
	Fri,  1 May 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8GuMXUL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768736167B;
	Fri,  1 May 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617516; cv=none; b=jfK6TMTxPaYTnzoGNdPbsGgv/ygxEVCpZ3HIxTsSfuLoFXj+SSeabM5SnHJnffD4KO3+xCyeaNbc/8n/ayl2s4yme7s6pLnUkWmN+NUHXeKDBQU+VlZwDuojqgLG89FwoEICcn0Q5xQUi0QFlp+eiKSdCamWZOPMCbqW8rxZq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617516; c=relaxed/simple;
	bh=MQeFejbbiidxI9MeU5AD6rTFEXrZY96L6m7vWdpFxLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSJhbd9u9ojASEkPWjR50bFAgjKXxdgQbd9JGHnM8z47imBQhkmB0SHutAXsV65Jc1VH92Zjxd3XfhwM0cbZGrr9emeaICsrw1CHRAq8vr9hMw4SOSlpBVRSes/Rj/1s5Z+93Rvdh5yMFyBZq88nN4+iK66QOy+uNYs6e53fCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8GuMXUL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617515; x=1809153515;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MQeFejbbiidxI9MeU5AD6rTFEXrZY96L6m7vWdpFxLI=;
  b=C8GuMXUL9bdbnqoRt+sNM5rnzzMiPHicAYsscRymOQHsLRmLaVMtvBBY
   c83UrdGo/EhWiMPGv5Z/a0yf1yvB+/GqMdtT+e8G2FRsCP3llzDb4i1Ue
   UMOnqTG2Jj1CkDXgo8SSoOqzZhjEJmR6UnVDtoVWNS1cgOcSWi9vVohLC
   RnHkFC+a0YS7Ojcw7wV2PYRtOK3mTjQj5Ab7mtW+6MGZZg5vxSsUS/jKe
   lEnSsV/L9dT0QUMuZBYDtuKtK3Lcmz+WGi4sAIxaWGwAuHlWlyd0DYZEx
   x3j21br7nqRtN10bmK6+duLU1M/8OZ/W6Cw/A3UCJSyYjpZj6GtqoWK0j
   Q==;
X-CSE-ConnectionGUID: XaxF/Ta/QwqAtDHeRLxNBg==
X-CSE-MsgGUID: 7RusvAUvTq+SmwtOuV0Zzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271880"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271880"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: qvAXxiR2RaG1gA1zNFcW6g==
X-CSE-MsgGUID: SO51vtIGR+efTcW0+vsFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752848"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:15 -0700
Subject: [PATCH net-next 04/15] ixgbe: E610: update ACI command structs
 with EEE fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-4-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3625;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=xlP/+hUtsf9ohCh8KeWrPSIgij8iWN/pG/B9r5XKl08=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXskSO/qaBWuUCphDCqbuuVCZv9Y7ufNG4Hq7dt1vv
 yYv97TvKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCKihxj+GQlXzmw8aXXf79O8
 g0zW/X3V91OiA57Kf/6X73fsf57xNob/vlbz4g5vjbRgnBMkK3fvxYHv7/3mzDy8eX2C3O7vsf2
 y/AA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: A67D64AAB19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

There were recent changes in some of the ACI commands,
which have been extended with EEE related fields.
Set PHY Config, Get PHY Caps and Get Link Info have been
affected.

Align SW structs to the recent FW changes.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 16 +++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index cfaaf2fcf7ae..959cacecae49 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -323,10 +323,8 @@ struct ixgbe_aci_cmd_get_phy_caps_data {
 #define IXGBE_ACI_PHY_EEE_EN_100BASE_TX			BIT(0)
 #define IXGBE_ACI_PHY_EEE_EN_1000BASE_T			BIT(1)
 #define IXGBE_ACI_PHY_EEE_EN_10GBASE_T			BIT(2)
-#define IXGBE_ACI_PHY_EEE_EN_1000BASE_KX		BIT(3)
-#define IXGBE_ACI_PHY_EEE_EN_10GBASE_KR			BIT(4)
-#define IXGBE_ACI_PHY_EEE_EN_25GBASE_KR			BIT(5)
-#define IXGBE_ACI_PHY_EEE_EN_10BASE_T			BIT(11)
+#define IXGBE_ACI_PHY_EEE_EN_5GBASE_T			BIT(11)
+#define IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T			BIT(12)
 	__le16 eeer_value;
 	u8 phy_id_oui[4]; /* PHY/Module ID connected on the port */
 	u8 phy_fw_ver[8];
@@ -356,7 +354,9 @@ struct ixgbe_aci_cmd_get_phy_caps_data {
 #define IXGBE_ACI_MOD_TYPE_BYTE2_SFP_PLUS		0xA0
 #define IXGBE_ACI_MOD_TYPE_BYTE2_QSFP_PLUS		0x86
 	u8 qualified_module_count;
-	u8 rsvd2[7];	/* Bytes 47:41 reserved */
+	u8 rsvd2;
+	__le16 eee_entry_delay;
+	u8 rsvd3[4];
 #define IXGBE_ACI_QUAL_MOD_COUNT_MAX			16
 	struct {
 		u8 v_oui[3];
@@ -512,8 +512,9 @@ struct ixgbe_aci_cmd_get_link_status_data {
 #define IXGBE_ACI_LINK_SPEED_200GB		BIT(11)
 #define IXGBE_ACI_LINK_SPEED_UNKNOWN		BIT(15)
 	__le16 reserved3;
-	u8 ext_fec_status;
-#define IXGBE_ACI_LINK_RS_272_FEC_EN	BIT(0) /* RS 272 FEC enabled */
+	u8 eee_status;
+#define IXGBE_ACI_LINK_EEE_ENABLED		BIT(2)
+#define IXGBE_ACI_LINK_EEE_ACTIVE		BIT(3)
 	u8 reserved4;
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from ICE_PHY_TYPE_HIGH_* */
@@ -815,6 +816,7 @@ struct ixgbe_link_status {
 	 * of ixgbe_aci_get_phy_caps structure
 	 */
 	u8 module_type[IXGBE_ACI_MODULE_TYPE_TOTAL_BYTE];
+	u8 eee_status;
 };
 
 /* Common HW capabilities for SW use */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 2703207a9efa..a01d991ee2e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1076,6 +1076,7 @@ void ixgbe_copy_phy_caps_to_cfg(struct ixgbe_aci_cmd_get_phy_caps_data *caps,
 	cfg->link_fec_opt = caps->link_fec_options;
 	cfg->module_compliance_enforcement =
 		caps->module_compliance_enforcement;
+	cfg->eee_entry_delay = caps->eee_entry_delay;
 }
 
 /**
@@ -1404,6 +1405,7 @@ int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
 	li->topo_media_conflict = link_data.topo_media_conflict;
 	li->pacing = link_data.cfg & (IXGBE_ACI_CFG_PACING_M |
 				      IXGBE_ACI_CFG_PACING_TYPE_M);
+	li->eee_status = link_data.eee_status;
 
 	/* Update fc info. */
 	tx_pause = !!(link_data.an_info & IXGBE_ACI_LINK_PAUSE_TX);

-- 
2.54.0.rc2.531.gaf818d63126a


