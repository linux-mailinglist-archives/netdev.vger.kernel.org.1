Return-Path: <netdev+bounces-271277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JBuCUjxwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD431C36C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBFFE304AC61
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53932D0D4;
	Tue, 24 Mar 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uxe3BYd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7F3346A8
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382929; cv=none; b=uDztumf/eCGenMMig9kot6TDM+nPGVj5WVWaO7UDhrOMfCbWGqk63eWG4aYB4rs585QYplTbG6fKkUZ4witpuYRj3G0xw76A528D0PPdDgwMCsR+ETbn6CnK5wotVG5ph8xcMjO8WzdrN4WKu9X/lPm8ckndvwduQ2z8zV+v6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382929; c=relaxed/simple;
	bh=YgHXK1r8Kuu4hdlycdiAKz9rmaxhJCLyKthmxTAeCgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cumdcVZcwHONM6SVhRhT+Fl2WBbsKiXmcpp50v0NPDJfrkLUCeZEfA/sXuAnbO7C6XzdoIbTgzkpbT+lxW+LeholEKgw7GcWIQyR9sMK9SxKdfopovCdEmFCR3Sqy3uQRuCfsk8QHrdnohjL/VDSzO4ae85jJKeCgf+KnXTlxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uxe3BYd7; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79885f4a8ffso50168967b3.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382920; x=1774987720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0pxqPIoimf9AUc7i3YW9ZkJqir02c5rXU7JaMCQV1Q=;
        b=VKn0x93pe6cRLCZrtQwdljRSOmWTROCoViTapzjDLECOLM4HSFTy2Rz8/kuafOmmVm
         jC+/cUfsq2Vmu6CFdebK+QKjEwDYidDaOtKsJSIbS0DNOTCSoG/b5rEAuhWJQ3njm1zY
         SHvILbbUgaPAJRGFwzk7g2TlItctVHZxmiJYSKzJ3/kwjAlsbfCoObmFSpgM79eXDiQL
         gdq9gDLPL7UAkuggjDk6CNgDbqnQ7J+dtsdKSCZ/jslJGK3kmhFgKhbP5gcMU6NfDpW7
         TTPNxX9XcaYMXi1tlld6hCdQxhD4hSc1SHk0Hcwv8aJd4rDsfSgj4V6u+Fn3yVPH01iX
         jLlQ==
X-Gm-Message-State: AOJu0YwcyOPaOx81dw5oSZJxnxOlSJgJ72Dpa28zSQxq7lgo5+DXZs1l
	E2IMcyMSoPuWbPjRE8L9CKzSxlfKhoMvsF6e0kAESC4Hsd7PIfNKsT/YWidbZSCVs0t++xvnZ71
	TBs4x/23wcwzkhxvWgunzKnPIRB7hZqf7ezHxmm/7X0z9YWftORj24vOQFi3YNvejo207Ka0xfv
	pFWk9YTSo/RFofj2p4oeNwv0bQQZjzsHckOiJgQ0MzPw5L7kJ6OAVMIBQtonE2uqCxhgWLBc2dZ
	kEDYm/aQJIgFiF2SQ==
X-Gm-Gg: ATEYQzw6ChdDFtdHf5NWischs8YXkFfpr1u5YSVaWalCe0u0JN9PhC8yGcnuCZYGm63
	S7VbxUGkzxawsHVrPLI5PhFLKpGzPNqg67MfbdysXmfGTPqy5Mv2NGURabZaX2QuACR8gMLX5Ip
	fWb5AdxN1iL8a0hBgyjTlGfpWHPflJuFCfhdecMk7KFIR3GnMpfftz7fPMYDogSNiMHC/t00mkE
	ttbxgk8nFcUhVvwErmZKRQPjQdoqki2dJcx15yOsLSnafPJOff+OHrlo5dbunf8BNgnJUgaIQGk
	22qIxh1+uw4m7+QK+DaOaiQ6Rru7fN3n926nJC4jI3ShyzOQbb4+YIUBPBV2V3tdFqVwNTG6MO5
	L2cW2mWEApD9pHMW6QnhIXAUV5USlQFsotQRDnSLMDdYogfGISo+XjDXlNMHQxtOfVD9EFI7I+g
	tLs7yznxsN5rPIhm6dq0R/uy/cY6+mebOyWd+w71ZuGqAsP+4a4YLD/TkHtYjFK0TImA==
X-Received: by 2002:a05:690c:4a07:b0:798:bbc8:bca9 with SMTP id 00721157ae682-79acf614c6dmr12752517b3.31.1774382920240;
        Tue, 24 Mar 2026 13:08:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79acc583684sm933727b3.17.2026.03.24.13.08.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c741f038f7cso3569992a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382918; x=1774987718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0pxqPIoimf9AUc7i3YW9ZkJqir02c5rXU7JaMCQV1Q=;
        b=Uxe3BYd7Y3LnMTMvcbJ1hdCoAzVzJXAjBhmHwJU8EBg1cFO/3iRU7HeuFA14Wj/aXF
         D/kX8D79dQS0yRVBWb555Qze+4C/hAreCtkR8ugSnlbPk1nEatUf5RkDj8XyCe9F8l1H
         xnXSxxFTQvfN4KRe6y7mHsF+KYrsR6dD/H/IA=
X-Received: by 2002:a05:6a20:394d:b0:39b:f750:a6f5 with SMTP id adf61e73a8af0-39c4ae68b70mr962603637.51.1774382916734;
        Tue, 24 Mar 2026 13:08:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:394d:b0:39b:f750:a6f5 with SMTP id adf61e73a8af0-39c4ae68b70mr962565637.51.1774382916040;
        Tue, 24 Mar 2026 13:08:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:35 -0700 (PDT)
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
Subject: [PATCH net-next v9 05/10] bng_en: add support for link async events
Date: Wed, 25 Mar 2026 01:37:35 +0530
Message-ID: <20260324200740.346029-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 29DD431C36C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register for firmware asynchronous events, including link-status,
link-speed, and PHY configuration changes. Upon event reception,
re-query the PHY and update ethtool settings accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 19 +++++++++-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 19 ++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  4 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 23 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++++++---
 5 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 1cc62883d3c7..523b8963b6dc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -15,6 +15,13 @@
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
 
+static const u16 bnge_async_events_arr[] = {
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE,
+};
+
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
 {
 	u32 dev_caps_cfg, hwrm_ver, hwrm_spec_code;
@@ -166,10 +173,12 @@ int bnge_hwrm_fw_set_time(struct bnge_dev *bd)
 
 int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 {
+	DECLARE_BITMAP(async_events_bmap, 256);
+	u32 events[8];
 	struct hwrm_func_drv_rgtr_output *resp;
 	struct hwrm_func_drv_rgtr_input *req;
 	u32 flags;
-	int rc;
+	int rc, i;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
 	if (rc)
@@ -190,6 +199,14 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 	req->ver_min = cpu_to_le16(DRV_VER_MIN);
 	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
 
+	memset(async_events_bmap, 0, sizeof(async_events_bmap));
+	for (i = 0; i < ARRAY_SIZE(bnge_async_events_arr); i++)
+		__set_bit(bnge_async_events_arr[i], async_events_bmap);
+
+	bitmap_to_arr32(events, async_events_bmap, 256);
+	for (i = 0; i < ARRAY_SIZE(req->async_event_fwd); i++)
+		req->async_event_fwd[i] |= cpu_to_le32(events[i]);
+
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
 	if (!rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index f924184f715e..3444dd694519 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -1264,3 +1264,22 @@ int bnge_set_link_ksettings(struct net_device *dev,
 set_setting_exit:
 	return rc;
 }
+
+void bnge_link_async_event_process(struct bnge_net *bn,
+				   u16 event_id, u32 evt_data)
+{
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
+		set_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+		set_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT, &bn->sp_event);
+		break;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		set_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index 70d0901b9a32..cadc26cfbcf5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -197,4 +197,8 @@ int bnge_set_link_ksettings(struct net_device *dev,
 int bnge_get_link_ksettings(struct net_device *dev,
 			    struct ethtool_link_ksettings *lk_ksettings);
 u32 bnge_get_link(struct net_device *dev);
+#define BNGE_SPEED_CFG_CHANGE_SP_NOT_SUPP	BIT(17)
+
+void bnge_link_async_event_process(struct bnge_net *bn,
+				   u16 event_id, u32 evt_data);
 #endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 25f1ba64d026..4ad08a5a933b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -136,6 +136,7 @@ static void bnge_timer(struct timer_list *t)
 static void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
+	bool speed_chng, cfg_chng, link_chng;
 	struct bnge_dev *bd = bn->bd;
 
 	netdev_lock(bn->netdev);
@@ -156,6 +157,28 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	speed_chng = test_and_clear_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT,
+					&bn->sp_event);
+	cfg_chng = test_and_clear_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT,
+				      &bn->sp_event);
+	link_chng = test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT,
+				       &bn->sp_event);
+
+	if (speed_chng || cfg_chng || link_chng) {
+		int rc;
+
+		if (speed_chng)
+			bnge_hwrm_phy_qcaps(bd);
+
+		rc = bnge_update_link(bn, true);
+		if (rc)
+			netdev_err(bn->netdev, "SP task cannot update link (rc: %d)\n",
+				   rc);
+
+		if (speed_chng || cfg_chng)
+			bnge_init_ethtool_link_settings(bn);
+	}
+
 	netdev_unlock(bn->netdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a2616f037557..88f9cf1db308 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1128,6 +1128,29 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 	}
 }
 
+static void bnge_async_event_process(struct bnge_net *bn,
+				     struct hwrm_async_event_cmpl *cmpl)
+{
+	u16 event_id = le16_to_cpu(cmpl->event_id);
+	u32 data1 = le32_to_cpu(cmpl->event_data1);
+	u32 data2 = le32_to_cpu(cmpl->event_data2);
+
+	netdev_dbg(bn->netdev, "hwrm event 0x%x {0x%x, 0x%x}\n",
+		   event_id, data1, data2);
+
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		bnge_link_async_event_process(bn, event_id, data1);
+		break;
+	default:
+		return;
+	}
+	__bnge_queue_sp_work(bn);
+}
+
 static void
 bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
 		       enum bnge_hwrm_wait_state state)
@@ -1146,7 +1169,7 @@ bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
 	dev_err(bd->dev, "Invalid hwrm seq id %d\n", seq_id);
 }
 
-static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
+static int bnge_hwrm_handler(struct bnge_net *bn, struct tx_cmp *txcmp)
 {
 	struct hwrm_cmpl *h_cmpl = (struct hwrm_cmpl *)txcmp;
 	u16 cmpl_type = TX_CMP_TYPE(txcmp), seq_id;
@@ -1154,10 +1177,14 @@ static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
 	switch (cmpl_type) {
 	case CMPL_BASE_TYPE_HWRM_DONE:
 		seq_id = le16_to_cpu(h_cmpl->sequence_id);
-		bnge_hwrm_update_token(bd, seq_id, BNGE_HWRM_COMPLETE);
+		bnge_hwrm_update_token(bn->bd, seq_id, BNGE_HWRM_COMPLETE);
 		break;
 
 	case CMPL_BASE_TYPE_HWRM_ASYNC_EVENT:
+		bnge_async_event_process(bn,
+					 (struct hwrm_async_event_cmpl *)txcmp);
+		break;
+
 	default:
 		break;
 	}
@@ -1235,7 +1262,7 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
 				    cmp_type == CMPL_BA_TY_HWRM_ASY_EVT)) {
-			bnge_hwrm_handler(bn->bd, txcmp);
+			bnge_hwrm_handler(bn, txcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
@@ -1355,7 +1382,7 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 						      budget - work_done);
 			nqr->has_more_work |= cpr->has_more_work;
 		} else {
-			bnge_hwrm_handler(bn->bd, (struct tx_cmp *)nqcmp);
+			bnge_hwrm_handler(bn, (struct tx_cmp *)nqcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-- 
2.47.3


