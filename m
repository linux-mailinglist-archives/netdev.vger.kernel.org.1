Return-Path: <netdev+bounces-261535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICNiHkaSoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:34:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA81ADBB6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED0303086A2E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE0426ED8;
	Thu, 26 Feb 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NuE5huPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67643D34BC
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130163; cv=none; b=r9gfkXjwp4sH3pNFXPzorZR+/a99ZMyEAlz6dopWqkS3CLICgp91gwZn6Sl10f7xOZ6q15jzSiJ7fgA3FfJ1UrhL0dOuLd3k/amWErqHJopDg+uFxiNZ3gaW3qSLdwj0LWt8SmQDsqvsAdR2VfzKi2NJMep5KLzNQyzTMBPTSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130163; c=relaxed/simple;
	bh=cV2ROgnTpsnGLu+3zcIV9/eG/QYifZuI+RX8hraKNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5ks7DvzhW/d+I/Yit7pfsAOB/wJ4PAKFFgoTyz4B23z3JfPtIeKNZ3b5QmEpHlRnoioN/UM5E8g1UsOZNwjo2PMAK4uS2RlltvzL2SmhkiITU8AUj631ua+ZFx8PGtrH1qDR0CsN/E6h03hdnFI73chRpyMajIll6uvaw7f7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NuE5huPK; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso8428875ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130161; x=1772734961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsFXNLVi8biehzm02nHBgM2Y+8KMGDGeY0mSl4IbDLc=;
        b=RLMRaoYZtt6JNMPzO3qe6bW+UObTKNsH/lqJtO3HqI5MzKJsCNOdwb5SKXCzlAd+ap
         Yl9J0/R/T9bI8WKTQzPR8Ew1stgSl8k/Ne2+yg0QUWeh4TcyYZWSpeoDcFdl7eMlw1zF
         JSqV7HFI6o+A3gF11qQxClj8qnRP+Y0Lzklmbp//exu6DgaDHPVEuu6viTxuYaYPhdHB
         B3TIk/ZwALJzYfTlLU7/kPgE4MMqYXzLFc3/O3z+42wG2tlEHFtY+X18vwSzsezwgigy
         R0WhFaIoDySYT0YO5JKsTKaU7mUmSGpHpYBt1qpqgZzakxXhnyHDkmHFzeFoGOp3o8Pc
         mG4w==
X-Gm-Message-State: AOJu0Yz0sjQTT1lutNAlYNEe7Xhp7b8eLrUD/wlTGcb6jkJV5cNbP45U
	cMUPGLqMroomsrsES9VD1KnjCeIoGry/np03EzwKMUi/pZ2IJ/20SolweK5MB6I1uSuQwGbjwZj
	DiTeGr3y6cNiHQdr9eKA3btAKmdbUEOnieBOXObJJ3GmySyWlnC2ZgHnOihPolFLllvLgK6eBtI
	PG1ksWolMmxWxCJY/lE82brfB9CKfGwT4X9zm0VFt/i1+v0X7cQzmnMcTAPehdEzbsQeT+2fvoi
	MC0xDzA4it7ICUfww==
X-Gm-Gg: ATEYQzyRg0rqGuzg/6fS/OvQWwBfLIS9v24g7qKl9OZQk9YNpguSF+Kd2hMnFgO3ytm
	MwaBmD4pwLkMN84IpvkZdnnjNSiycjNO7goUwbsiD5UK/mJMa38YCBZ6nkkbt3iQVw1fCJuBKxD
	6emFrJqKA9LHMg4E5WKIkXJTmvP4RUFR3PPKAEEka+8MT3CBpXiEjWtH6fFp8dnIDalGuID6A7h
	fqHU+NPWoz+ELyTwytU1cRH3bC+88qul23vGBpEBK3RJQ3HHGgtJyB/OThzgQD7lJi038K8Dn+I
	6kQ1GZp4x+tyz4wkOz0kvySOqn662NkJmPVrquIZ5czB51rAmuh2gbdyhc5qVQg5fSxeofVUoBO
	h8kku0f4gA2VlV5nbCR3mh5hMqIotijg3cIsVI1bYT7K2/P4J04Y+81/9xch/R7cQaat4rHL/qM
	zqCa3nKa6zhRvt5vz8p9Gb/VK7+Z/yy4K/6CvgbNnguCftMYw9a/WLU9RdeYrPopGkUg==
X-Received: by 2002:a17:903:2f04:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2ade99a6871mr42700615ad.23.1772130160863;
        Thu, 26 Feb 2026 10:22:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5dbabbsm3355495ad.26.2026.02.26.10.22.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so11475385ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130159; x=1772734959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsFXNLVi8biehzm02nHBgM2Y+8KMGDGeY0mSl4IbDLc=;
        b=NuE5huPKbvvO+EYC2hYMHW6kHFK4PUiPEp3NCwS0yLuLo8J1A10k/rmc14+l6oT4E8
         pTWEEZM130aYcR8HRsbv+3/srN5D79cZ3uy6mmO3eAkmBPwtfCFyUWUm8C6YZCFWidYo
         dzhBEeMgaHXMLgLg4jJA9kuUPDtY4B8WppOj8=
X-Received: by 2002:a17:903:2c47:b0:2ad:6e0c:6210 with SMTP id d9443c01a7336-2ade9a871f5mr41824035ad.56.1772130159088;
        Thu, 26 Feb 2026 10:22:39 -0800 (PST)
X-Received: by 2002:a17:903:2c47:b0:2ad:6e0c:6210 with SMTP id d9443c01a7336-2ade9a871f5mr41823765ad.56.1772130158297;
        Thu, 26 Feb 2026 10:22:38 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:37 -0800 (PST)
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
Subject: [PATCH net-next v2 5/8] bng_en: add support for link async events
Date: Thu, 26 Feb 2026 23:51:30 +0530
Message-ID: <20260226182133.1566714-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261535-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DFA81ADBB6
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
index 836f28b64b4..d18eda40d60 100644
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
index 474001993cd..7baede20c45 100644
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
@@ -1256,3 +1271,35 @@ int bnge_set_link_ksettings(struct net_device *dev,
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
index d549274e703..22d6b3e03fc 100644
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


