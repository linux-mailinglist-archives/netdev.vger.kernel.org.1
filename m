Return-Path: <netdev+bounces-283114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jUIqNINK9GlSAQIAu9opvQ
	(envelope-from <netdev+bounces-283114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:38:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E24AAAD0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B719302254D
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C5366DB5;
	Fri,  1 May 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRdL+WSN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FE3612F1;
	Fri,  1 May 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617516; cv=none; b=Pn9Qt+ijLOfoSqWhtkwngwNO74vTgT/va2GEpIRbnXHtE7ejr1PRySmdLcovukWt3P3HaghfUyrfmmXBYqH3N7MoJQN9Enjnrk6KwRfUrLWoima06i9E+hzcQWQxPfacfitoefBKm0vYxRfHSydqqxRO+eccIrma9BZQ9BfBu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617516; c=relaxed/simple;
	bh=VZrH32U0me70wCuW0aSeD+4luIpGSmfYjmRUJK+pNpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7eyb/aup9Yv8FK/NzNFSH78wzHLW52iJD6At1Yn/oREws9RlvNPOH774SFvDgVPXs9b2gEoHBjpq1fbRqEAslxmpENTAlcknL3CKfoUEQi7zPBSVEJzdMZxJSCvLfBpq5hm6vyLBoSPzaNey5IIRqm8LyXkbvJ4I5o982vwPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRdL+WSN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617515; x=1809153515;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VZrH32U0me70wCuW0aSeD+4luIpGSmfYjmRUJK+pNpk=;
  b=CRdL+WSNtyj2Ag+6KOwsu5yZ9qqIjBjOfQgr2xScBJhKHODYRnYOoCZx
   q991JG7TZ63Iu3sZOJmSd/aQmTC08fDUzSpvP0c3ESmdGTV6HCl3jlIiy
   5waKB9+lrVWuKLMLXje53XC5Dv7rrBCliudlr3xs72PFEduZ2vSEHTmIr
   Po3nHSkGq+RofT5g7XTUTOLZhB3fqO0wLDlR2CW1zql1kQDAddC2wHXDe
   nAWtWBrhhMdDNs/3CsT3eE1jk1hbJc0x3+oyBuPWkjibfoHP7VAXQ+Ekg
   4OzCYSgrN9m2zu29HsHqvIonShy3kiyAMIDUgmULlB1f3aGpyf0R+F5ge
   A==;
X-CSE-ConnectionGUID: B2kaaGaWTZeeYaw/4Pme0Q==
X-CSE-MsgGUID: b98gFR7+SM2CinkS6VoZYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271871"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: BOgQoVRPRmW7uUcUo9HtBg==
X-CSE-MsgGUID: AkbmK7AFTB20KGgmlSQC7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752845"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:14 -0700
Subject: [PATCH net-next 03/15] ixgbe: E610: use new version of 0x601 ACI
 command buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-3-6f27ae1cd073@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=eT9FxPmW9pvzrJeiT+itWKYrV3DwGwVXyQO9Di1PaE4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXskFvCf4X+53dODK7JquN1lQqstl14Ga6onfoytUL
 t84rfa2o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlkHWL4Kzgz2+W/E3+67o2I
 46m/n2+bw3Ar+Bf3p1XRn2/E2nSaxjP8z/1wSf7R5fX7RCt69l0Ibot82bZT69KsAAmWDOUfDsX
 rOQE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 724E24AAAD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Since FW version 1.40, buffer size of the 0x601 cmd has been increased
by 2B - from 24 to 26B. Buffer has been extended with new field
which can be used to configure EEE entry delay.

Pre-1.40 FW versions still expect 24B buffer and throws error when
receipts 26B buffer. To keep compatibility, check whether EEE
device capability flag is set and basing on it use appropriate
size of the command buffer.

Additionally place Set PHY Config capabilities defines out of
structs definitions.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 15 +++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 34f62a416eaa..cfaaf2fcf7ae 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -382,6 +382,15 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 	__le64 phy_type_low; /* Use values from IXGBE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from IXGBE_PHY_TYPE_HIGH_* */
 	u8 caps;
+	u8 low_power_ctrl_an;
+	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
+	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 module_compliance_enforcement;
+	__le16  eee_entry_delay;
+} __packed;
+
+/* Set PHY config capabilities (@caps) defines */
 #define IXGBE_ACI_PHY_ENA_VALID_MASK		0xef
 #define IXGBE_ACI_PHY_ENA_TX_PAUSE_ABILITY	BIT(0)
 #define IXGBE_ACI_PHY_ENA_RX_PAUSE_ABILITY	BIT(1)
@@ -390,12 +399,6 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 #define IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT	BIT(5)
 #define IXGBE_ACI_PHY_ENA_LESM			BIT(6)
 #define IXGBE_ACI_PHY_ENA_AUTO_FEC		BIT(7)
-	u8 low_power_ctrl_an;
-	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
-	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 module_compliance_enforcement;
-};
 
 /* Restart AN command data structure (direct 0x0605)
  * Also used for response, with only the lport_num field present.
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 097a3e1c67aa..2703207a9efa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1096,11 +1096,16 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 {
 	struct ixgbe_aci_cmd_set_phy_cfg *cmd;
 	struct libie_aq_desc desc;
+	bool use_buff_eee_field;
+	u16 buf_size;
 	int err;
 
 	if (!cfg)
 		return -EINVAL;
 
+	/* If FW supports EEE, we have to use buffer with EEE field. */
+	use_buff_eee_field = hw->dev_caps.common_cap.eee_support;
+
 	cmd = libie_aq_raw(&desc);
 	/* Ensure that only valid bits of cfg->caps can be turned on. */
 	cfg->caps &= IXGBE_ACI_PHY_ENA_VALID_MASK;
@@ -1109,7 +1114,17 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 	cmd->lport_num = hw->bus.func;
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 
-	err = ixgbe_aci_send_cmd(hw, &desc, cfg, sizeof(*cfg));
+	if (use_buff_eee_field)
+		buf_size = sizeof(*cfg);
+	else
+		/* Buffer w/o eee_entry_delay field is 2B smaller. */
+		buf_size = sizeof(*cfg) - sizeof(u16);
+
+	err = ixgbe_aci_send_cmd(hw, &desc, cfg, buf_size);
+
+	/* 1.40 config format is compatible with pre-1.40, just extends
+	 * it at the end.
+	 */
 	if (!err)
 		hw->phy.curr_user_phy_cfg = *cfg;
 

-- 
2.54.0.rc2.531.gaf818d63126a


