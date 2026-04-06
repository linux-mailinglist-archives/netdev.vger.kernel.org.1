Return-Path: <netdev+bounces-275685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPKENOv102k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AB3A5FC3
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36253300C32F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F6391E74;
	Mon,  6 Apr 2026 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GKLvibLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71038F259
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498712; cv=none; b=C8FtPISbBOPfWA12q9zTcqm3oKqRXwMNOn9R9mKXMBGTpcg0H8Og7nORCrUyZ86OKjgBAEkXR43FM108K8MnsoX5prWAG5rwkq7Ow1Xfh3qucT0d0/yWJkrBkwWJQHOt8qakRBOy8HsDq7l0r7XISWCNPBKlNB0payKm3nPBV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498712; c=relaxed/simple;
	bh=1YMYvC44P5Ondjt3ZEh9r+RNXfKsJcSVJ8yUQ4H5lcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWaCOt1cFSv80u5zSDx8R+f5I7hR0L4JEfgwNWyPLakEBu7TKJYCUCoP5KI4ueHWVToxrXt4qMchyQbZH6J3CCEqMBXGwTc95RZFEJWoafrz/4JLwdkAK/p1e8eYa4AkHRADDHeTIiR1Ey1e7zukPzP5EZTMQRul8EcuWdxkv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GKLvibLC; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-4233e152457so1246993fac.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498709; x=1776103509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRvunP53aj9rJ5J81QoXbpLR+6WKMbaIUoLYHwhVYrc=;
        b=b8GZVyKRB7cTsRLIp7PT6L0g6EG3nSc15qtMqbkEcl82mwgS6g1JrFw3BBhTCWx41B
         eK1F+SNBGzBAv0OKwN1wB3Sa4RrgPEQtsSyFwkHA44y404KoDSDkzppNgfXCuc3itkXf
         Bcii30nPpNZOdQS2lRR/w5f2tGqFzUlhLJoeRxTdRWJbVTRlD5fhuR+3qJssnCf4XDuB
         zrGURS1SdmXXfHBXFkqy7beSIRmRMZ8JcoTSRBXgaIknzTI55dciTjrSebPpjR/hKitr
         VsNnEIdce/IAw5eVwfeF3T7tK3cgOjrdr8ijTsUNFZ4MjrL2xm0egL0F4hN4ZGDLVAAt
         lIsg==
X-Gm-Message-State: AOJu0YzAoSVtqPHScDGZFPJcfJP0H+MQR4WEbToSECKXZlT/RU0QBJdu
	bI0+slhMFitalQo3XVaLw0tYrHSCXyWwE9s6afRl8TNZF1wi1SfX9wHfbFVNer/w66k08cjd8+6
	SBKqHjUm5JGOIDGRnOoLA5CSATJ4lm064lK0PvmiA/m8EDo3MaSR+ZnCHJtaOHZKBNbwiRPenQx
	K7Ev6MEVBR1ZMEfDjFCR3X8qy3ujrFRxzq0E1kv1Srt1B3k6X1KNa1EwNQa0YkD1ZagS6fqsDFp
	time3xetbGWo4mzNw==
X-Gm-Gg: AeBDieu/kE2npa72V4o3euX946sflBFIs6QQwb/7q2BxDIwTAJbke0xMpEZZ1sllVkD
	2q5ubPnkOyE19gbJcU+jegExtgVDvF+M2JeOwW1zRWPcEcKA9ZfXuwKdus65hidcq58Ys3DLmF+
	AKMLHiWI+mHvAUDTxmbHJNDEdtU1x+gMyNUHeoM9OS0rGm30riq4zz2nzhEdF7le9YIiKuF4Sm2
	ZPcU6oMgcL+ospsMJvBzuPz1dhmOL0BkJpAu7MlvPfBvW93ThnXAzAxtSaYuatJbYhoziDNGxsB
	pFJBXkZ1UiK6JLp0P0h01svkryPNQc7XYa9fRNl4ZSo5aHQ51/JHEUMnxgXugiNHtztPz//0W2Y
	+J6h3t9XTKWJ/Snv6jtXnvOdEMJFAN34X8j0E/vq3LTMnH6BMFpgqzj2XN/tZQ99rvl3teimiRA
	pj/5LbEG6cYUeXS8tjGUo9WA8G7Xwn91hcSZ30tYdDZgngaISiSf1zlEwFs/rknKw=
X-Received: by 2002:a05:6870:f29d:b0:417:1ba0:7320 with SMTP id 586e51a60fabf-423101b2cedmr7735156fac.33.1775498709057;
        Mon, 06 Apr 2026 11:05:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-422eb299112sm1725732fac.10.2026.04.06.11.05.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b23af7d7e8so119829675ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498707; x=1776103507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRvunP53aj9rJ5J81QoXbpLR+6WKMbaIUoLYHwhVYrc=;
        b=GKLvibLCX5Er9+dIlyt38Og98ZCCgNEe3twh7MXCI1AvNjfC60W9nxSI2I2LJxfWtv
         dCB/ZX8NdRHTZFsbJB+IDqakhQRtEZUoIQE0NboDNuF1wva4c4dkv5sur/Z/bE3CP6Hi
         SPmAjkCRIV4suL063Q+r3LCHlBcFvvJP2jhwM=
X-Received: by 2002:a17:903:32c2:b0:2b0:c106:a402 with SMTP id d9443c01a7336-2b28182c316mr140588685ad.3.1775498707036;
        Mon, 06 Apr 2026 11:05:07 -0700 (PDT)
X-Received: by 2002:a17:903:32c2:b0:2b0:c106:a402 with SMTP id d9443c01a7336-2b28182c316mr140587975ad.3.1775498706267;
        Mon, 06 Apr 2026 11:05:06 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:05 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v12 02/10] bng_en: query PHY capabilities and report link status
Date: Mon,  6 Apr 2026 23:34:12 +0530
Message-ID: <20260406180420.279470-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A5AB3A5FC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Query PHY capabilities and supported speeds from firmware,
retrieve current link state (speed, duplex, pause, FEC),
and log the information. Seed initial link state during probe.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   8 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 214 +++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   5 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 407 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    | 165 +++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  54 ++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 +
 8 files changed, 865 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index fa604ee20264..8e07cb307d21 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -11,4 +11,5 @@ bng_en-y := bnge_core.o \
 	    bnge_netdev.o \
 	    bnge_ethtool.o \
 	    bnge_auxr.o \
-	    bnge_txrx.o
+	    bnge_txrx.o \
+	    bnge_link.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index f376913aa321..eddc5a4a5148 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -94,6 +94,9 @@ struct bnge_queue_info {
 	u8      queue_profile;
 };
 
+#define BNGE_PHY_FLAGS2_SHIFT		8
+#define BNGE_PHY_FL_NO_FCS		PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -207,6 +210,11 @@ struct bnge_dev {
 
 	struct bnge_auxr_priv	*aux_priv;
 	struct bnge_auxr_dev	*auxr_dev;
+
+	struct bnge_link_info	link_info;
+
+	/* Copied from flags and flags2 in hwrm_port_phy_qcaps_output */
+	u32			phy_flags;
 };
 
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index c46da3413417..c2e47b1d7034 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -981,6 +981,220 @@ void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
 	vnic->fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
 }
 
+static bool bnge_phy_qcaps_no_speed(struct hwrm_port_phy_qcaps_output *resp)
+{
+	return !resp->supported_speeds2_auto_mode &&
+	       !resp->supported_speeds2_force_mode;
+}
+
+int bnge_hwrm_phy_qcaps(struct bnge_dev *bd)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	struct hwrm_port_phy_qcaps_output *resp;
+	struct hwrm_port_phy_qcaps_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCAPS);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto hwrm_phy_qcaps_exit;
+
+	bd->phy_flags = resp->flags |
+		       (le16_to_cpu(resp->flags2) << BNGE_PHY_FLAGS2_SHIFT);
+
+	if (bnge_phy_qcaps_no_speed(resp)) {
+		link_info->phy_enabled = false;
+		netdev_warn(bd->netdev, "Ethernet link disabled\n");
+	} else if (!link_info->phy_enabled) {
+		link_info->phy_enabled = true;
+		netdev_info(bd->netdev, "Ethernet link enabled\n");
+		/* Phy re-enabled, reprobe the speeds */
+		link_info->support_auto_speeds2 = 0;
+	}
+
+	/* Firmware may report 0 for autoneg supported speeds when no
+	 * SFP module is present. Skip the update to preserve the
+	 * current supported speeds -- storing 0 would cause autoneg
+	 * default fallback to advertise nothing.
+	 */
+	if (resp->supported_speeds2_auto_mode)
+		link_info->support_auto_speeds2 =
+			le16_to_cpu(resp->supported_speeds2_auto_mode);
+
+	bd->port_count = resp->port_cnt;
+
+hwrm_phy_qcaps_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause)
+{
+	struct hwrm_port_phy_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
+	if (rc)
+		return rc;
+
+	if (set_pause)
+		bnge_hwrm_set_pause_common(bn, req);
+
+	bnge_hwrm_set_link_common(bn, req);
+
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		bn->eth_link_info.force_link_chng = false;
+
+	return rc;
+}
+
+int bnge_update_link(struct bnge_net *bn, bool chng_link_state)
+{
+	struct hwrm_port_phy_qcfg_output *resp;
+	struct hwrm_port_phy_qcfg_input *req;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	bool support_changed;
+	u8 link_state;
+	int rc;
+
+	link_info = &bd->link_info;
+	link_state = link_info->link_state;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCFG);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc) {
+		bnge_hwrm_req_drop(bd, req);
+		return rc;
+	}
+
+	memcpy(&link_info->phy_qcfg_resp, resp, sizeof(*resp));
+	link_info->phy_link_status = resp->link;
+	link_info->duplex = resp->duplex_state;
+	link_info->pause = resp->pause;
+	link_info->auto_mode = resp->auto_mode;
+	link_info->auto_pause_setting = resp->auto_pause;
+	link_info->lp_pause = resp->link_partner_adv_pause;
+	link_info->force_pause_setting = resp->force_pause;
+	link_info->duplex_setting = resp->duplex_cfg;
+	if (link_info->phy_link_status == BNGE_LINK_LINK) {
+		link_info->link_speed = le16_to_cpu(resp->link_speed);
+		link_info->active_lanes = resp->active_lanes;
+	} else {
+		link_info->link_speed = 0;
+		link_info->active_lanes = 0;
+	}
+	link_info->force_link_speed2 = le16_to_cpu(resp->force_link_speeds2);
+	link_info->support_speeds2 = le16_to_cpu(resp->support_speeds2);
+	link_info->auto_link_speeds2 = le16_to_cpu(resp->auto_link_speeds2);
+	link_info->lp_auto_link_speeds =
+		le16_to_cpu(resp->link_partner_adv_speeds);
+	link_info->media_type = resp->media_type;
+	link_info->phy_type = resp->phy_type;
+	link_info->phy_addr = resp->eee_config_phy_addr &
+			      PORT_PHY_QCFG_RESP_PHY_ADDR_MASK;
+	link_info->module_status = resp->module_status;
+
+	link_info->fec_cfg = le16_to_cpu(resp->fec_cfg);
+	link_info->active_fec_sig_mode = resp->active_fec_signal_mode;
+
+	if (chng_link_state) {
+		if (link_info->phy_link_status == BNGE_LINK_LINK)
+			link_info->link_state = BNGE_LINK_STATE_UP;
+		else
+			link_info->link_state = BNGE_LINK_STATE_DOWN;
+		if (link_state != link_info->link_state)
+			bnge_report_link(bd);
+	} else {
+		/* always link down if not required to update link state */
+		link_info->link_state = BNGE_LINK_STATE_DOWN;
+	}
+	bnge_hwrm_req_drop(bd, req);
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return 0;
+
+	support_changed = bnge_support_speed_dropped(bn);
+	if (support_changed && (bn->eth_link_info.autoneg & BNGE_AUTONEG_SPEED))
+		rc = bnge_hwrm_set_link_setting(bn, true);
+	return rc;
+}
+
+int bnge_hwrm_set_pause(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct hwrm_port_phy_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	bool pause_autoneg;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
+	if (rc)
+		return rc;
+
+	pause_autoneg = !!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL);
+
+	/* Prepare PHY pause-advertisement or forced-pause settings. */
+	bnge_hwrm_set_pause_common(bn, req);
+
+	/* Prepare speed/autoneg settings */
+	if (pause_autoneg || elink_info->force_link_chng)
+		bnge_hwrm_set_link_common(bn, req);
+
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc && !pause_autoneg) {
+		/* Since changing of pause setting, with pause autoneg off,
+		 * doesn't trigger any link change event, the driver needs to
+		 * update the current MAC pause upon successful return of the
+		 * phy_cfg command.
+		 */
+		bd->link_info.force_pause_setting =
+		bd->link_info.pause = elink_info->req_flow_ctrl;
+		bd->link_info.auto_pause_setting = 0;
+		if (!elink_info->force_link_chng)
+			bnge_report_link(bd);
+	}
+	if (!rc)
+		elink_info->force_link_chng = false;
+
+	return rc;
+}
+
+int bnge_hwrm_shutdown_link(struct bnge_dev *bd)
+{
+	struct hwrm_port_phy_cfg_input *req;
+	int rc;
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
+	if (rc)
+		return rc;
+
+	req->flags = cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_FORCE_LINK_DWN);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc) {
+		/* Device is not obliged to link down in certain scenarios,
+		 * even when forced. Setting the state unknown is consistent
+		 * with driver startup and will force link state to be
+		 * reported during subsequent open based on PORT_PHY_QCFG.
+		 */
+		bd->link_info.link_state = BNGE_LINK_STATE_UNKNOWN;
+	}
+	return rc;
+}
+
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn)
 {
 	struct hwrm_stat_ctx_free_input *req;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 38b046237feb..86ca3ac2244b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -57,4 +57,9 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx);
 int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 			   u32 tpa_flags);
+int bnge_update_link(struct bnge_net *bn, bool chng_link_state);
+int bnge_hwrm_phy_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause);
+int bnge_hwrm_set_pause(struct bnge_net *bn);
+int bnge_hwrm_shutdown_link(struct bnge_dev *bd);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
new file mode 100644
index 000000000000..6eeb1c521535
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 Broadcom.
+
+#include <linux/linkmode.h>
+
+#include "bnge.h"
+#include "bnge_link.h"
+#include "bnge_hwrm_lib.h"
+
+static u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed)
+{
+	switch (fw_link_speed) {
+	case BNGE_LINK_SPEED_50GB:
+	case BNGE_LINK_SPEED_50GB_PAM4:
+		return SPEED_50000;
+	case BNGE_LINK_SPEED_100GB:
+	case BNGE_LINK_SPEED_100GB_PAM4:
+	case BNGE_LINK_SPEED_100GB_PAM4_112:
+		return SPEED_100000;
+	case BNGE_LINK_SPEED_200GB:
+	case BNGE_LINK_SPEED_200GB_PAM4:
+	case BNGE_LINK_SPEED_200GB_PAM4_112:
+		return SPEED_200000;
+	case BNGE_LINK_SPEED_400GB:
+	case BNGE_LINK_SPEED_400GB_PAM4:
+	case BNGE_LINK_SPEED_400GB_PAM4_112:
+		return SPEED_400000;
+	case BNGE_LINK_SPEED_800GB:
+	case BNGE_LINK_SPEED_800GB_PAM4_112:
+		return SPEED_800000;
+	default:
+		return SPEED_UNKNOWN;
+	}
+}
+
+static void bnge_set_auto_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info;
+
+	link_info = &bn->bd->link_info;
+	elink_info->advertising = link_info->auto_link_speeds2;
+}
+
+static void bnge_set_force_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info;
+
+	link_info = &bn->bd->link_info;
+	elink_info->req_link_speed = link_info->force_link_speed2;
+	switch (elink_info->req_link_speed) {
+	case BNGE_LINK_SPEED_50GB_PAM4:
+	case BNGE_LINK_SPEED_100GB_PAM4:
+	case BNGE_LINK_SPEED_200GB_PAM4:
+	case BNGE_LINK_SPEED_400GB_PAM4:
+		elink_info->req_signal_mode = BNGE_SIG_MODE_PAM4;
+		break;
+	case BNGE_LINK_SPEED_100GB_PAM4_112:
+	case BNGE_LINK_SPEED_200GB_PAM4_112:
+	case BNGE_LINK_SPEED_400GB_PAM4_112:
+	case BNGE_LINK_SPEED_800GB_PAM4_112:
+		elink_info->req_signal_mode = BNGE_SIG_MODE_PAM4_112;
+		break;
+	default:
+		elink_info->req_signal_mode = BNGE_SIG_MODE_NRZ;
+		break;
+	}
+}
+
+void bnge_init_ethtool_link_settings(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	link_info = &bd->link_info;
+
+	if (BNGE_AUTO_MODE(link_info->auto_mode)) {
+		elink_info->autoneg = BNGE_AUTONEG_SPEED;
+		if (link_info->auto_pause_setting &
+		    PORT_PHY_QCFG_RESP_AUTO_PAUSE_AUTONEG_PAUSE)
+			elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+		bnge_set_auto_speed(bn);
+	} else {
+		elink_info->autoneg = 0;
+		elink_info->advertising = 0;
+		bnge_set_force_speed(bn);
+		elink_info->req_duplex = link_info->duplex_setting;
+	}
+	if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+		elink_info->req_flow_ctrl =
+			link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH;
+	else
+		elink_info->req_flow_ctrl = link_info->force_pause_setting;
+}
+
+int bnge_probe_phy(struct bnge_net *bn, bool fw_dflt)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	bd->phy_flags = 0;
+	rc = bnge_hwrm_phy_qcaps(bd);
+	if (rc) {
+		netdev_err(bn->netdev,
+			   "Probe PHY can't get PHY qcaps (rc: %d)\n", rc);
+		return rc;
+	}
+	if (bd->phy_flags & BNGE_PHY_FL_NO_FCS)
+		bn->netdev->priv_flags |= IFF_SUPP_NOFCS;
+	else
+		bn->netdev->priv_flags &= ~IFF_SUPP_NOFCS;
+	if (!fw_dflt)
+		return 0;
+
+	rc = bnge_update_link(bn, false);
+	if (rc) {
+		netdev_err(bn->netdev, "Probe PHY can't update link (rc: %d)\n",
+			   rc);
+		return rc;
+	}
+	bnge_init_ethtool_link_settings(bn);
+
+	return 0;
+}
+
+void bnge_hwrm_set_link_common(struct bnge_net *bn,
+			       struct hwrm_port_phy_cfg_input *req)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+
+	if (elink_info->autoneg & BNGE_AUTONEG_SPEED) {
+		req->auto_mode |= PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK;
+		req->enables |= cpu_to_le32(BNGE_PHY_AUTO_SPEEDS2_MASK);
+		req->auto_link_speeds2_mask =
+			cpu_to_le16(elink_info->advertising);
+		req->enables |= cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_MODE);
+		req->flags |= cpu_to_le32(BNGE_PHY_FLAGS_RESTART_AUTO);
+	} else {
+		req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_FORCE);
+		req->force_link_speeds2 =
+			cpu_to_le16(elink_info->req_link_speed);
+		req->enables |=
+			cpu_to_le32(BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2);
+		netif_info(bn, link, bn->netdev,
+			   "Forcing FW speed2: %d\n",
+			   (u32)elink_info->req_link_speed);
+	}
+
+	/* tell FW that the setting takes effect immediately */
+	req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_RESET_PHY);
+}
+
+static bool bnge_auto_speed_updated(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bn->bd->link_info;
+
+	return elink_info->advertising != link_info->auto_link_speeds2;
+}
+
+void bnge_hwrm_set_pause_common(struct bnge_net *bn,
+				struct hwrm_port_phy_cfg_input *req)
+{
+	if (bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) {
+		req->auto_pause = PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_RX)
+			req->auto_pause |= PORT_PHY_CFG_REQ_AUTO_PAUSE_RX;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_TX)
+			req->auto_pause |= PORT_PHY_CFG_REQ_AUTO_PAUSE_TX;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_PAUSE);
+	} else {
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_RX)
+			req->force_pause |= PORT_PHY_CFG_REQ_FORCE_PAUSE_RX;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_TX)
+			req->force_pause |= PORT_PHY_CFG_REQ_FORCE_PAUSE_TX;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_FORCE_PAUSE);
+		req->auto_pause = req->force_pause;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_PAUSE);
+	}
+}
+
+static bool bnge_force_speed_updated(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bn->bd->link_info;
+
+	return elink_info->req_link_speed != link_info->force_link_speed2;
+}
+
+int bnge_update_phy_setting(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	bool update_pause = false;
+	bool update_link = false;
+	bool hw_pause_autoneg;
+	bool pause_autoneg;
+	int rc;
+
+	link_info = &bd->link_info;
+	elink_info = &bn->eth_link_info;
+	rc = bnge_update_link(bn, true);
+	if (rc) {
+		netdev_err(bn->netdev, "failed to update link (rc: %d)\n",
+			   rc);
+		return rc;
+	}
+
+	pause_autoneg = !!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL);
+	hw_pause_autoneg = !!(link_info->auto_pause_setting &
+			      PORT_PHY_QCFG_RESP_AUTO_PAUSE_AUTONEG_PAUSE);
+
+	/* Check if pause autonegotiation state has changed */
+	if (pause_autoneg != hw_pause_autoneg) {
+		update_pause = true;
+	} else if (pause_autoneg) {
+		/* If pause autoneg is enabled, check if the
+		 * requested RX/TX bits changed
+		 */
+		if ((link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
+		    elink_info->req_flow_ctrl)
+			update_pause = true;
+	} else {
+		/* If pause autoneg is disabled, check if the
+		 * forced RX/TX bits changed
+		 */
+		if (link_info->force_pause_setting != elink_info->req_flow_ctrl)
+			update_pause = true;
+	}
+
+	/* Force update if link change is requested */
+	if (elink_info->force_link_chng)
+		update_pause = true;
+
+	/* Check if link speed or duplex settings have changed */
+	if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
+		if (BNGE_AUTO_MODE(link_info->auto_mode) ||
+		    bnge_force_speed_updated(bn) ||
+		    elink_info->req_duplex != link_info->duplex_setting)
+			update_link = true;
+	} else {
+		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE ||
+		    bnge_auto_speed_updated(bn))
+			update_link = true;
+	}
+
+	/* The last close may have shut down the link, so need to call
+	 * PHY_CFG to bring it back up.
+	 */
+	if (!BNGE_LINK_IS_UP(bd))
+		update_link = true;
+
+	if (update_link)
+		rc = bnge_hwrm_set_link_setting(bn, update_pause);
+	else if (update_pause)
+		rc = bnge_hwrm_set_pause(bn);
+
+	if (rc) {
+		netdev_err(bn->netdev,
+			   "failed to update PHY setting (rc: %d)\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+void bnge_get_port_module_status(struct bnge_net *bn)
+{
+	struct hwrm_port_phy_qcfg_output *resp;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	u8 module_status;
+
+	link_info = &bd->link_info;
+	resp = &link_info->phy_qcfg_resp;
+
+	if (bnge_update_link(bn, true))
+		return;
+
+	module_status = link_info->module_status;
+	switch (module_status) {
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX:
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN:
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG:
+		netdev_warn(bn->netdev,
+			    "Unqualified SFP+ module detected on port %d\n",
+			    bd->pf.port_id);
+		netdev_warn(bn->netdev, "Module part number %.*s\n",
+			    (int)sizeof(resp->phy_vendor_partnumber),
+			    resp->phy_vendor_partnumber);
+		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX)
+			netdev_warn(bn->netdev, "TX is disabled\n");
+		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN)
+			netdev_warn(bn->netdev, "SFP+ module is shut down\n");
+		break;
+	}
+}
+
+static bool bnge_support_dropped(u16 advertising, u16 supported)
+{
+	return (advertising & ~supported) != 0;
+}
+
+bool bnge_support_speed_dropped(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bn->bd->link_info;
+
+	/* Check if any advertised speeds are no longer supported. The caller
+	 * holds the netdev instance lock, so we can modify link_info settings.
+	 */
+	if (bnge_support_dropped(elink_info->advertising,
+				 link_info->support_auto_speeds2)) {
+		elink_info->advertising = link_info->support_auto_speeds2;
+		return true;
+	}
+	return false;
+}
+
+static char *bnge_report_fec(struct bnge_link_info *link_info)
+{
+	u8 active_fec = link_info->active_fec_sig_mode &
+			PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK;
+
+	switch (active_fec) {
+	default:
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE:
+		return "None";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE74_ACTIVE:
+		return "Clause 74 BaseR";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE91_ACTIVE:
+		return "Clause 91 RS(528,514)";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_1XN_ACTIVE:
+		return "Clause 91 RS544_1XN";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_IEEE_ACTIVE:
+		return "Clause 91 RS(544,514)";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_1XN_ACTIVE:
+		return "Clause 91 RS272_1XN";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE:
+		return "Clause 91 RS(272,257)";
+	}
+}
+
+void bnge_report_link(struct bnge_dev *bd)
+{
+	if (BNGE_LINK_IS_UP(bd)) {
+		const char *signal = "";
+		const char *flow_ctrl;
+		const char *duplex;
+		u32 speed;
+		u16 fec;
+
+		netif_carrier_on(bd->netdev);
+		speed = bnge_fw_to_ethtool_speed(bd->link_info.link_speed);
+		if (speed == SPEED_UNKNOWN) {
+			netdev_info(bd->netdev,
+				    "NIC Link is Up, speed unknown\n");
+			return;
+		}
+		if (bd->link_info.duplex == BNGE_LINK_DUPLEX_FULL)
+			duplex = "full";
+		else
+			duplex = "half";
+		if (bd->link_info.pause == BNGE_LINK_PAUSE_BOTH)
+			flow_ctrl = "ON - receive & transmit";
+		else if (bd->link_info.pause == BNGE_LINK_PAUSE_TX)
+			flow_ctrl = "ON - transmit";
+		else if (bd->link_info.pause == BNGE_LINK_PAUSE_RX)
+			flow_ctrl = "ON - receive";
+		else
+			flow_ctrl = "none";
+		if (bd->link_info.phy_qcfg_resp.option_flags &
+		    PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN) {
+			u8 sig_mode = bd->link_info.active_fec_sig_mode &
+				      PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
+			switch (sig_mode) {
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ:
+				signal = "(NRZ) ";
+				break;
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
+				signal = "(PAM4 56Gbps) ";
+				break;
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
+				signal = "(PAM4 112Gbps) ";
+				break;
+			default:
+				break;
+			}
+		}
+		netdev_info(bd->netdev, "NIC Link is Up, %u Mbps %s%s duplex, Flow control: %s\n",
+			    speed, signal, duplex, flow_ctrl);
+		fec = bd->link_info.fec_cfg;
+		if (!(fec & PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED))
+			netdev_info(bd->netdev, "FEC autoneg %s encoding: %s\n",
+				    (fec & BNGE_FEC_AUTONEG) ? "on" : "off",
+				    bnge_report_fec(&bd->link_info));
+	} else {
+		netif_carrier_off(bd->netdev);
+		netdev_info(bd->netdev, "NIC Link is Down\n");
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
new file mode 100644
index 000000000000..68eaa229fffe
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Broadcom */
+
+#ifndef _BNGE_LINK_H_
+#define _BNGE_LINK_H_
+
+#define BNGE_PHY_CFG_ABLE(bd)		\
+	((bd)->link_info.phy_enabled)
+
+#define BNGE_PHY_AUTO_SPEEDS2_MASK	\
+	PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK
+#define BNGE_PHY_FLAGS_RESTART_AUTO	\
+	PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG
+#define BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2	\
+	PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2
+
+#define BNGE_LINK_LINK		PORT_PHY_QCFG_RESP_LINK_LINK
+
+enum bnge_link_state {
+	BNGE_LINK_STATE_UNKNOWN,
+	BNGE_LINK_STATE_DOWN,
+	BNGE_LINK_STATE_UP,
+};
+
+#define BNGE_LINK_IS_UP(bd)		\
+	((bd)->link_info.link_state == BNGE_LINK_STATE_UP)
+
+#define BNGE_LINK_DUPLEX_FULL	PORT_PHY_QCFG_RESP_DUPLEX_STATE_FULL
+
+#define BNGE_LINK_PAUSE_TX	PORT_PHY_QCFG_RESP_PAUSE_TX
+#define BNGE_LINK_PAUSE_RX	PORT_PHY_QCFG_RESP_PAUSE_RX
+#define BNGE_LINK_PAUSE_BOTH	(PORT_PHY_QCFG_RESP_PAUSE_RX | \
+				 PORT_PHY_QCFG_RESP_PAUSE_TX)
+
+#define BNGE_LINK_AUTO_NONE     PORT_PHY_QCFG_RESP_AUTO_MODE_NONE
+#define BNGE_LINK_AUTO_MSK	PORT_PHY_QCFG_RESP_AUTO_MODE_SPEED_MASK
+#define BNGE_AUTO_MODE(mode)	((mode) > BNGE_LINK_AUTO_NONE && \
+				 (mode) <= BNGE_LINK_AUTO_MSK)
+
+#define BNGE_LINK_SPEED_50GB	PORT_PHY_QCFG_RESP_LINK_SPEED_50GB
+#define BNGE_LINK_SPEED_100GB	PORT_PHY_QCFG_RESP_LINK_SPEED_100GB
+#define BNGE_LINK_SPEED_200GB	PORT_PHY_QCFG_RESP_LINK_SPEED_200GB
+#define BNGE_LINK_SPEED_400GB	PORT_PHY_QCFG_RESP_LINK_SPEED_400GB
+#define BNGE_LINK_SPEED_800GB	PORT_PHY_QCFG_RESP_LINK_SPEED_800GB
+
+#define BNGE_LINK_SPEEDS2_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB
+#define BNGE_LINK_SPEEDS2_MSK_100GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB
+#define BNGE_LINK_SPEEDS2_MSK_50GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_100GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_200GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_400GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_800GB_PAM4_112
+
+#define BNGE_LINK_SPEED_50GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB_PAM4_56
+#define BNGE_LINK_SPEED_100GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_56
+#define BNGE_LINK_SPEED_200GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_56
+#define BNGE_LINK_SPEED_400GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_56
+#define BNGE_LINK_SPEED_100GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112
+#define BNGE_LINK_SPEED_200GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112
+#define BNGE_LINK_SPEED_400GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112
+#define BNGE_LINK_SPEED_800GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+
+#define BNGE_FEC_NONE		PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED
+#define BNGE_FEC_AUTONEG	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_ENABLED
+#define BNGE_FEC_ENC_BASE_R_CAP	\
+	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_SUPPORTED
+#define BNGE_FEC_ENC_BASE_R	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_ENABLED
+#define BNGE_FEC_ENC_RS_CAP	\
+	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_SUPPORTED
+#define BNGE_FEC_ENC_LLRS_CAP	\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_SUPPORTED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_SUPPORTED)
+#define BNGE_FEC_ENC_RS		\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_1XN_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_IEEE_ENABLED)
+#define BNGE_FEC_ENC_LLRS	\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_ENABLED)
+
+struct bnge_link_info {
+	u8			phy_type;
+	u8			media_type;
+	u8			phy_addr;
+	u8			phy_link_status;
+	bool			phy_enabled;
+
+	u8			link_state;
+	u8			active_lanes;
+	u8			duplex;
+	u8			pause;
+	u8			lp_pause;
+	u8			auto_pause_setting;
+	u8			force_pause_setting;
+	u8			duplex_setting;
+	u8			auto_mode;
+	u16			link_speed;
+	u16			support_speeds2;
+	u16			auto_link_speeds2;
+	u16			support_auto_speeds2;
+	u16			lp_auto_link_speeds;
+	u16			force_link_speed2;
+
+	u8			module_status;
+	u8			active_fec_sig_mode;
+	u16			fec_cfg;
+
+	/* A copy of phy_qcfg output used to report link
+	 * info to VF
+	 */
+	struct hwrm_port_phy_qcfg_output phy_qcfg_resp;
+
+	bool			phy_retry;
+	unsigned long		phy_retry_expires;
+};
+
+#define BNGE_AUTONEG_SPEED		1
+#define BNGE_AUTONEG_FLOW_CTRL		2
+
+#define BNGE_SIG_MODE_NRZ	PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ
+#define BNGE_SIG_MODE_PAM4	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4
+#define BNGE_SIG_MODE_PAM4_112	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
+#define BNGE_SIG_MODE_MAX	(PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST + 1)
+
+struct bnge_ethtool_link_info {
+	/* copy of requested setting from ethtool cmd */
+	u8			autoneg;
+	u8			req_signal_mode;
+	u8			req_duplex;
+	u8			req_flow_ctrl;
+	u16			req_link_speed;
+	u16			advertising;	/* user adv setting */
+	bool			force_link_chng;
+};
+
+void bnge_hwrm_set_link_common(struct bnge_net *bn,
+			       struct hwrm_port_phy_cfg_input *req);
+void bnge_hwrm_set_pause_common(struct bnge_net *bn,
+				struct hwrm_port_phy_cfg_input *req);
+int bnge_update_phy_setting(struct bnge_net *bn);
+void bnge_get_port_module_status(struct bnge_net *bn);
+void bnge_report_link(struct bnge_dev *bd);
+bool bnge_support_speed_dropped(struct bnge_net *bn);
+void bnge_init_ethtool_link_settings(struct bnge_net *bn);
+int bnge_probe_phy(struct bnge_net *bn, bool fw_dflt);
+#endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 8d5d828e19a3..185f5bfce1d5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -101,6 +101,17 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+void __bnge_queue_sp_work(struct bnge_net *bn)
+{
+	queue_work(bn->bnge_pf_wq, &bn->sp_task);
+}
+
+static void bnge_queue_sp_work(struct bnge_net *bn, unsigned int event)
+{
+	set_bit(event, &bn->sp_event);
+	__bnge_queue_sp_work(bn);
+}
+
 static void bnge_timer(struct timer_list *t)
 {
 	struct bnge_net *bn = timer_container_of(bn, t, timer);
@@ -110,7 +121,14 @@ static void bnge_timer(struct timer_list *t)
 	    !test_bit(BNGE_STATE_OPEN, &bd->state))
 		return;
 
-	/* Periodic work added by later patches */
+	if (READ_ONCE(bd->link_info.phy_retry)) {
+		if (time_after(jiffies, READ_ONCE(bd->link_info.phy_retry_expires))) {
+			WRITE_ONCE(bd->link_info.phy_retry, false);
+			netdev_warn(bn->netdev, "failed to update PHY settings after maximum retries.\n");
+		} else {
+			bnge_queue_sp_work(bn, BNGE_UPDATE_PHY_SP_EVENT);
+		}
+	}
 
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
@@ -126,7 +144,17 @@ static void bnge_sp_task(struct work_struct *work)
 		return;
 	}
 
-	/* Event handling work added by later patches */
+	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
+		int rc;
+
+		rc = bnge_update_phy_setting(bn);
+		if (rc) {
+			netdev_warn(bn->netdev, "update PHY settings retry failed\n");
+		} else {
+			WRITE_ONCE(bd->link_info.phy_retry, false);
+			netdev_info(bn->netdev, "update PHY settings retry succeeded\n");
+		}
+	}
 
 	netdev_unlock(bn->netdev);
 }
@@ -2496,6 +2524,8 @@ static void bnge_tx_enable(struct bnge_net *bn)
 	/* Make sure napi polls see @dev_state change */
 	synchronize_net();
 	netif_tx_wake_all_queues(bn->netdev);
+	if (BNGE_LINK_IS_UP(bn->bd))
+		netif_carrier_on(bn->netdev);
 }
 
 static int bnge_open_core(struct bnge_net *bn)
@@ -2532,6 +2562,16 @@ static int bnge_open_core(struct bnge_net *bn)
 
 	bnge_enable_napi(bn);
 
+	rc = bnge_update_phy_setting(bn);
+	if (rc) {
+		netdev_warn(bn->netdev, "failed to update PHY settings (rc: %d)\n",
+			    rc);
+		WRITE_ONCE(bd->link_info.phy_retry_expires, jiffies + 5 * HZ);
+		WRITE_ONCE(bd->link_info.phy_retry, true);
+	} else {
+		WRITE_ONCE(bd->link_info.phy_retry, false);
+	}
+
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 
 	bnge_enable_int(bn);
@@ -2540,6 +2580,9 @@ static int bnge_open_core(struct bnge_net *bn)
 
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 
+	/* Poll link status and check for SFP+ module status */
+	bnge_get_port_module_status(bn);
+
 	return 0;
 
 err_free_irq:
@@ -2591,6 +2634,8 @@ static int bnge_close(struct net_device *dev)
 	struct bnge_net *bn = netdev_priv(dev);
 
 	bnge_close_core(bn);
+	bnge_hwrm_shutdown_link(bn->bd);
+	bn->sp_event = 0;
 
 	return 0;
 }
@@ -2832,6 +2877,10 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_init_l2_fltr_tbl(bn);
 	bnge_init_mac_addr(bd);
 
+	rc = bnge_probe_phy(bn, true);
+	if (rc)
+		goto err_free_workq;
+
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
@@ -2859,6 +2908,7 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
+	bn->sp_event = 0;
 	destroy_workqueue(bn->bnge_pf_wq);
 
 	free_netdev(netdev);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d2ccee725454..5636eb371e24 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -9,6 +9,7 @@
 #include <linux/refcount.h>
 #include "bnge_db.h"
 #include "bnge_hw_def.h"
+#include "bnge_link.h"
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
@@ -230,6 +231,13 @@ enum bnge_net_state {
 
 #define BNGE_TIMER_INTERVAL	HZ
 
+enum bnge_sp_event {
+	BNGE_LINK_CHNG_SP_EVENT,
+	BNGE_LINK_SPEED_CHNG_SP_EVENT,
+	BNGE_LINK_CFG_CHANGE_SP_EVENT,
+	BNGE_UPDATE_PHY_SP_EVENT,
+};
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -298,6 +306,9 @@ struct bnge_net {
 	struct timer_list	timer;
 	struct workqueue_struct *bnge_pf_wq;
 	struct work_struct	sp_task;
+	unsigned long		sp_event;
+
+	struct bnge_ethtool_link_info	eth_link_info;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -576,4 +587,5 @@ u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
 			 struct bnge_rx_ring_info *rxr, gfp_t gfp);
 int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 			 u16 prod, gfp_t gfp);
+void __bnge_queue_sp_work(struct bnge_net *bn);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


