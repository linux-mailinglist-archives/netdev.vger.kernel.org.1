Return-Path: <netdev+bounces-275688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICxGGHn202k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:07:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839223A600D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAE193014917
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCD392C47;
	Mon,  6 Apr 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FheuBEKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB1394791
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498726; cv=none; b=tUa+W9QjoMY6kATYSn29gsbih5yCG0qpsR/+L+WBuUVfKZkmTc5Ejgss/z/RND063vDULspQDSCIPKAmeHpVlwfAt53fLTJSXMbZ0PsnHjr3c05jSBBva2JK9RN6L4YhW3ossYJava+L8V6POgZpZonesDpi9FDboGyWIEnpyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498726; c=relaxed/simple;
	bh=ewojHpmzFxni6D6QP9xFkN+FbY/hC76L2mK/haZljFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8dx0AAmXDVJbK8KrMzcsuMJ4BGbRcLcPqAuCRWWTBV0WBOXCVh4/upORl+bdw2mYnCTi4h2S7ffNclL9NZeBKdW2q5F53TcGz48IJRj6rWpOrpbRizfT/Az0k/AwPArPooAkC0gY+5AffcLf+5Sjgn12Ddl/oxwi04gw02fC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FheuBEKF; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so3968488a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498724; x=1776103524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwjn+Blt/xXWhxq2ChrdGDrK3xGKIT8Cemsi014Pi6o=;
        b=HP3YDU9zBNgiSeNIcWCaVJbO5gyJo+U12BMvOaZuVueJVMoGfbFY7IGg2OGfPrvXwY
         qTWINgoXC92yWLZArpN1YRQwgyiJe0/9OWdRgkUTSApRQGyNAwFWoSwY8IfSXMvOPocs
         R0bpDSZB6ZrCp0Mt+OJAiDvuhT42iMuVqBEGTqLYA6vz8tqGMz1Vos4z3WsLa9gGeNCW
         7rYkZAT2/C9iLgdJTMy/CwUBC5jhnLTmpsXkxCBdWjAhLaAWf7nK78D0G5v3K22+Epaj
         IEISEmmMgzzX0FTMYzNhPigIklk55BzlKJ9/PlV523chtyp6pbSBPWXhtTJjnOurEwdL
         GVEA==
X-Gm-Message-State: AOJu0YyXY4JIL1HHon23nTw3EUsnzrAPZsdrBC6umn5LIsGCSemqCMBZ
	GorrolE+/nhnVRro7qVqfONzY8jRAgLZl0iS/hZ55KRuTIrtYqt/PxqfieL4KL9tWJljggzLAuS
	Qfip5NePrHmzwRu2nPuCZVcQDuYVHl3NU2mA2zakQzHDxfgroE+Oe7uSEy8UoR419UIdMef6qYG
	CumrMZrQE3DsQBHgWgey4eAIqGrhBQgHHRmVtLx9FcdMizVQ4cXc2w5OHNjQIsQwZJ8m3Dlo1Sy
	ZN3DbuEyMCxUiolTQ==
X-Gm-Gg: AeBDievOCXAjh5yOUem4h81OuLaoh9glLooe7AmJES5uE56RmuH0Y65Jsj3oyrTB4kJ
	mY/MnkqtC1IBjBN559rixeqOCMFShcXL5S5njQ0qjBcQKMBeI8LNbkVM6AJ4Iew/8uXT33A6UFi
	ccX2QBqEKwQK9eBUl7poq7PxzRJTYLDRvk9DOw01+stjHw8MASm4n0VSEqtAJZwp5RC/9eoTqql
	AAwCdYT+SYbR50e5S60Nkvm2JcRD6zPVrqnz6eQlfhD5R3PFhaYM6bSWf4ciJ5WZm01XmaIcyXm
	HrlqbOYs+MX/BNKamt5bpp9bqkVAzz24kDCcTNw/+VrkEutCyTZkNOF4FdGQBzhK3q4frgb4UL+
	KQjl7Kz+qr1GJ3YCCigiHftaTKWLkYrnGFHKM/AY8AeWsoyYqv707cYqT2cpsAwpcQMOEwbh+wu
	ej8oAyn6j69rCsyTuf4qcfvPwJz12mSb5T1xkFgredwgPhMSaDOzLG3lwpCP7GoA0=
X-Received: by 2002:a17:90b:52c3:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-35de691b394mr13405486a91.24.1775498723694;
        Mon, 06 Apr 2026 11:05:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dbe42cd82sm1545588a91.0.2026.04.06.11.05.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2471321dcso121943765ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498722; x=1776103522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwjn+Blt/xXWhxq2ChrdGDrK3xGKIT8Cemsi014Pi6o=;
        b=FheuBEKFpNVqQlfzBT1svd7TTGN3sA9Au8RgfN+2XKYMHTOrDhedHDsLKfVFOVuKQ3
         9kAoQ4EHiv+Zy6LPgwHOQVnV7kND9/9fzhVATrA8NN08nmz0CCgwPqDbfRRtbTWrQZjZ
         YdjQwSSe3ngYRc9rLebxoR7nZIvjoHDtvYO7E=
X-Received: by 2002:a17:902:f64c:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b281936032mr153387895ad.37.1775498721813;
        Mon, 06 Apr 2026 11:05:21 -0700 (PDT)
X-Received: by 2002:a17:902:f64c:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b281936032mr153387585ad.37.1775498721401;
        Mon, 06 Apr 2026 11:05:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:20 -0700 (PDT)
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
Subject: [PATCH net-next v12 05/10] bng_en: add support for link async events
Date: Mon,  6 Apr 2026 23:34:15 +0530
Message-ID: <20260406180420.279470-6-bhargava.marreddy@broadcom.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275688-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 839223A600D
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
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 18 ++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 23 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++++++---
 5 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index c2e47b1d7034..83c0b16c3e81 100644
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
 	struct hwrm_func_drv_rgtr_output *resp;
 	struct hwrm_func_drv_rgtr_input *req;
+	u32 events[8];
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
index 2e2aaa764443..3b0dfcf27376 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -1112,3 +1112,21 @@ int bnge_set_link_ksettings(struct net_device *dev,
 set_setting_exit:
 	return rc;
 }
+
+void bnge_link_async_event_process(struct bnge_net *bn, u16 event_id)
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
index a0e6e62e03d8..ccaf343aa018 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -169,4 +169,5 @@ int bnge_set_link_ksettings(struct net_device *dev,
 int bnge_get_link_ksettings(struct net_device *dev,
 			    struct ethtool_link_ksettings *lk_ksettings);
 u32 bnge_get_link(struct net_device *dev);
+void bnge_link_async_event_process(struct bnge_net *bn, u16 event_id);
 #endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 185f5bfce1d5..90458b323120 100644
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
index a2616f037557..7d45e057f2e8 100644
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
+		bnge_link_async_event_process(bn, event_id);
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


