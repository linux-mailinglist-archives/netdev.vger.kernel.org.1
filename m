Return-Path: <netdev+bounces-264531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCRZN3bhqWnDGwEAu9opvQ
	(envelope-from <netdev+bounces-264531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:03:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD0217EDE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 353FC300F106
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348C41160B;
	Thu,  5 Mar 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S9FrZjME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64A411634
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740889; cv=none; b=ie1jwLWOXR/0wL+H884YNkNXTUWXTqC+jXJ1LTzf8XCXpz4nvNNmRQtsWXcl3RaPMPoO3up19+wHqMKBniM79tH/kHdLBd21C3WVLT19e03jAl2cb9NsPY/fblWdtDr7vAwnRL4q5CEvDmNy4noYWcf57dpKmj6NBtOV8vPYW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740889; c=relaxed/simple;
	bh=F/91X4VZ+ga6gzdEz0qYSU+3guoo3ch024HLxRgaIz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/0FAHehjosHmTImiHgcboOkKYK7UL1kBL/5wUqxe3tGSN/jbjiuVJYvxl6O504/dwUkb5MCN2e/CruD7JuBe9vDXGHk794A+e+aSUBECUOfW8sc5Zy3KZob2ZlE8+/yAh5Xrpz1uDShWslHtksuuKqHei8YGTgqVvSKmRWs6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S9FrZjME; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so4984074a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740888; x=1773345688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq0rYdeXQuQxZhsFVTUCSXDy8nEGhlJbd6WgsX3VS+0=;
        b=tI5PL6vMaEbAlKFDdJH4kQIsJ5jLYNuUjqg9DVH/UxhtT3KkZnebAgD4ubGbozW/CQ
         DewVpAVBMLl87qzI6Etz/WYMBYdJXeD5FIAPURrTkHiNSRIrGfmgv6F29h/iQOpXBjzn
         1gLddQlCtlK16N4+sxUIh6C8yAJGRfNn98dmnpPgzd72oqTjr5m5EubY3mPOBfHpISMR
         xEV4/7tPpswaABcprcGirWEhj/f2t+LuDnd7K4IlspKcuiCaneGErmQNljW7MH0JGluV
         rPjqzIXgwirxdPuwBvagQVX2VoOAUCstKNq28fqLlwYcHlXslq29jxnSwqX/qPPDgL/z
         YByw==
X-Gm-Message-State: AOJu0YzP1kS+jzTcqQRuEEAhRLk0c8gwT0ApZWUWpxkDLXFsqQaZEN3j
	OR31hGh4kjcpQWGMhtTB4VJ3zouILJgpvWY7P8xIiMJgUKGJi0BKh9LpuTJFijEswBWH27bwU86
	/tMfhM/wCraw7VVhJgviD+YN5X7cnl/LlqKqqF5fBkNrmCeDrpC7cWekUCTXGhd1/xbuAwsTIcC
	wIi7SIMxB/kqv1cfYWBaFKbvBKRFBwVb8Xq7qANWMgYBpQs4VUTg9JmhwiRdP7XwyUC8b2r2vGS
	tsZjg63dgy9SaXxFQ==
X-Gm-Gg: ATEYQzwTBtM2ZDuT4HqXK5hiuJZAWS6uK9C8W71J5nacJmJA/y2V+mLmqJnSrofz8qr
	Kmoq6EW8oeeevgntthZVOqMxE6Z01XQKKY6FcoRljg1R2weJvKwM09pVNSKbIKI0egH4jm6unTb
	Gq4DiRGlNS45RUSMJi25qt64PVYyFltp4pusBqsy23CBQCjSWiJ2pd7YkINzv6Kwch2vN/7iSgo
	FQLuqe/C1i/HdKKv9sbcrPQ3WtbOWQMzB8rQSB7cc+GI9f4CK5HSNQ3IbjMuEsrMC3s5Q3KXBm5
	1tgcpNv+z1M79S2cBPqetpOziyqENfKkFXykg++7KH63en+DGG1bGLCfMdN2G1Ac5EtnCeKlMqU
	FOn7T3TdM9CB6fJzMuhzRMx8+Ecd0zpl/xsM95zUXomdYJeX+CQS0zbDtL1P2tgb/nWgs5rEY6g
	b+7nNUhm87chyITlRkJV0G6vPFQr0gCDviF+3mX6fzxJqLTm6Gui2RmKmaqpYxB76oEA==
X-Received: by 2002:a17:90b:3d07:b0:356:3ba2:122c with SMTP id 98e67ed59e1d1-359a69c2243mr6644793a91.9.1772740887512;
        Thu, 05 Mar 2026 12:01:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359b2d3cbd0sm341358a91.2.2026.03.05.12.01.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae42659a39so336687715ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740885; x=1773345685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq0rYdeXQuQxZhsFVTUCSXDy8nEGhlJbd6WgsX3VS+0=;
        b=S9FrZjMERKK4cPNRGUic5mEPejFAgNvSYWuvnktYPL87i1Y4ZJdZ0YTh/7ZP5tdBpF
         BuxZdaY5+BiHtZOIBfMLVrNNUnVENS7igkmsR9a6ObRLPLIt71Td6CWheoOk8TzmGKiG
         HrjEArqIVpq1hkYcXMsHkoYkDfQtlTWD86Ll0=
X-Received: by 2002:a17:903:2f8b:b0:2ae:6192:8d8b with SMTP id d9443c01a7336-2ae6a9ed255mr63153475ad.4.1772740885219;
        Thu, 05 Mar 2026 12:01:25 -0800 (PST)
X-Received: by 2002:a17:903:2f8b:b0:2ae:6192:8d8b with SMTP id d9443c01a7336-2ae6a9ed255mr63153045ad.4.1772740884571;
        Thu, 05 Mar 2026 12:01:24 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:24 -0800 (PST)
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
Subject: [PATCH net-next v4 05/10] bng_en: add support for link async events
Date: Fri,  6 Mar 2026 01:30:12 +0530
Message-ID: <20260305200018.111728-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 86FD0217EDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264531-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Action: no action

Register for firmware asynchronous events, including link-status,
link-speed, and PHY configuration changes. Upon event reception,
re-query the PHY and update ethtool settings accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 17 ++++++-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 47 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  4 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 ++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++--
 5 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index f7570eb89b8..040b73ee409 100644
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
+	u32 *events = (u32 *)async_events_bmap;
 	struct hwrm_func_drv_rgtr_output *resp;
 	struct hwrm_func_drv_rgtr_input *req;
 	u32 flags;
-	int rc;
+	int rc, i;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
 	if (rc)
@@ -190,6 +199,12 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 	req->ver_min = cpu_to_le16(DRV_VER_MIN);
 	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
 
+	memset(async_events_bmap, 0, sizeof(async_events_bmap));
+	for (i = 0; i < ARRAY_SIZE(bnge_async_events_arr); i++)
+		__set_bit(bnge_async_events_arr[i], async_events_bmap);
+	for (i = 0; i < ARRAY_SIZE(req->async_event_fwd); i++)
+		req->async_event_fwd[i] |= cpu_to_le32(events[i]);
+
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
 	if (!rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index 09eaece1806..dcdce594b03 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -94,6 +94,21 @@ static void bnge_set_auto_speed(struct bnge_net *bn)
 	elink_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
 }
 
+static u16 bnge_get_force_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2)
+		return link_info->force_link_speed2;
+	if (elink_info->req_signal_mode == BNGE_SIG_MODE_PAM4)
+		return link_info->force_pam4_link_speed;
+	return link_info->force_link_speed;
+}
+
 static void bnge_set_force_speed(struct bnge_net *bn)
 {
 	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
@@ -1251,3 +1266,35 @@ int bnge_set_link_ksettings(struct net_device *dev,
 set_setting_exit:
 	return rc;
 }
+
+void bnge_link_async_event_process(struct bnge_net *bn,
+				   u16 event_id, u32 evt_data)
+{
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE: {
+		struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED) &&
+		    (evt_data & BNGE_SPEED_CFG_CHANGE_SP_NOT_SUPP)) {
+			u16 fw_speed = bnge_get_force_speed(bn);
+			u32 speed = bnge_fw_to_ethtool_speed(fw_speed);
+
+			if (speed != SPEED_UNKNOWN)
+				netdev_warn(bn->netdev, "Link speed %d no longer supported\n",
+					    speed);
+		}
+		set_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT, &bn->sp_event);
+		fallthrough;
+	}
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+		set_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT, &bn->sp_event);
+		fallthrough;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		set_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index 12be5cab579..bdcb75a941c 100644
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
index 1c36f7dd02f..e02c0ef03e4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -160,6 +160,25 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	if (test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event)) {
+		int rc;
+
+		netdev_lock(bn->netdev);
+		if (test_and_clear_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT,
+				       &bn->sp_event))
+			bnge_hwrm_phy_qcaps(bd);
+
+		rc = bnge_update_link(bn, true);
+		if (rc)
+			netdev_err(bn->netdev, "SP task cannot update link (rc: %d)\n",
+				   rc);
+
+		if (test_and_clear_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT,
+				       &bn->sp_event))
+			bnge_init_ethtool_link_settings(bn);
+		netdev_unlock(bn->netdev);
+	}
+
 	/* Ensure all sp_task work is done before clearing the state */
 	smp_mb__before_atomic();
 	clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a2616f03755..88f9cf1db30 100644
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


