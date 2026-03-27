Return-Path: <netdev+bounces-272673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ4NGeroxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:30:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262D34AFBC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 621C43015301
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890C3BED61;
	Fri, 27 Mar 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FzaWMYac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF563BED2A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642503; cv=none; b=Iej00ovYSk9hXkm++ezELj89XFLqBHj0/y8f2k3YFKLYV3zb8Ta16PUJ8t6lHhxZ421kBN1N9RiPRrqpDt4QdR8UyTWkkTJgksHsZdYsOQ/G4hqGt9c+fohGmriGNtn7MdO7/LW6fODB/nco6skMzrTdDCuJtMW9GzYm+fn7d2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642503; c=relaxed/simple;
	bh=82tDLYlRCFC3hucyMD7nomnm2kmivYBGq+C4YtlHKQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSn58l0fOiDSo4B4j6UJ2+37ogbWASfjmvQksyjjqQvsP90tyU30QJCmKZc7+UjlIHEoz5AbG9WunwunYsZfs3g0x/2iE7tm5q4VhPVZx3+6bu21UgzrGckEEbSdWKnOce6rFavYovi5QHaQZXHK4Jx5VwMN9EO31YYAovzDWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FzaWMYac; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56cc67e01deso2305418e0c.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642500; x=1775247300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjQ2eTe6U8E1f5bQ/2sJCU+psvAOj+STAWH7HfsJQow=;
        b=NRVc/DR2tlh+FP5BWFyQigXjY5Wtio2feb1SR+0XttLEaokwe8YpysN9IyGNYUimpy
         hi+3494HH9E7puN4z6xmvPIRvmo2sX6BXN3VX/OWFd3BfI7dXuUKV6GrqTCtseeKSxZH
         Lt9YbLuBa7DbIvJH7VRDYNqlXAeEePLsYIryoExaKRnPmbFvVUU/4TOQStW7vFXe8msF
         ueac4jJqPo/SoeWtDGoLqoaZa2yHYOazoDg5TO4GBBcKj+zAF/31p28Zps2/BBcPrZx+
         S1hm+rsOJp9u+9YHDPlCiWsudzxyxGJ8dQ78FvW+C+O4DHl72ox5rXFTBqoX5Er0h5HJ
         EWVQ==
X-Gm-Message-State: AOJu0YziAYcqXN4OZZR0W87khhF4GUqK0exSf9MN3PxMyLJmJT5msWnO
	98xHR91B1aM6DmmufvarrxYn3fIKcF7q3uWAbP7wIp/nLCKxkfoyoj9xGkBpFrvItIvIkud30Qc
	8b2s4pIRntqhpRZKcrri9Zb35CIqqi7kq/aRMUUXxOKLSAe/GZHL0RsL+OV0dPuTac4pkTYD7MZ
	V+Qn6t5jh2cYs51dmGQVqPXYcNybHZpMGy3kc+KGSPf9ziSgbuMfyvi/HkaUsixMweTp4xjXGWD
	R9TzwJM5Ild7+3ooM8u
X-Gm-Gg: ATEYQzwDH6FABhFNyfy+xMUwO7880aEKQkzy44Rd4ddyoAncBqg12Ih8DaFCD5Riw1r
	wTik7jX36I3MfBaawTdqGNVorS81A8JCIs9JxmDnu0NoAzayyT5QtFS6dg13bG7ZssKJ73qqx9P
	Squp98WeK7uedDkjkyVUVZ9ye9v5mEN5wAnA2xXpi28xLKBVvzQej/h56HbN8BrwDoqbt+030yr
	iMPalhAk238ykNLwS/dqltz63jkdm+bp12FfOQvaSxegqnVVwxnveUHGwgLB0dodgQu5WupVJzE
	C9Qhqhv9510cYED9J2Dq5WoDYsWyjAkrWxcEp423ckAdY1P5qEJXVyTBxGxn7C3rWCa/b5+Kcyc
	5DAL4UENeI80aMLRk0Y4MwsTRkATYw35q6XSvXXEwu1d1ElcTtYkg1Z2BtelBurb0S7XDUzztBB
	2USebMFd25fSBap116NO9Wm8euLnoeckd4D3JOzf278wuhWL6z5SHiN36Ow2ET6bs=
X-Received: by 2002:a05:6122:30e6:b0:567:433b:e903 with SMTP id 71dfb90a1353d-56d4a51f190mr2000328e0c.6.1774642500249;
        Fri, 27 Mar 2026 13:15:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56d58a02550sm804e0c.7.2026.03.27.13.15.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:15:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79895ffb315so55343327b3.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642499; x=1775247299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjQ2eTe6U8E1f5bQ/2sJCU+psvAOj+STAWH7HfsJQow=;
        b=FzaWMYac+vSm4sZBcxRfz1JUJ6SU4+eMxZtW7dabTY7clRo8PIfABd6QejuolVCadd
         YDhbudrvy/mXaY+oxrO9QVhHUT9O6M9Mph9w+PeTZin/Q5jLf+6nrs4e+KVotOTTLnOw
         rsUVXpy/r9GAbli1a4rLjU8RGViGd4P6q8noU=
X-Received: by 2002:a05:690c:e092:b0:79b:d56a:a7c2 with SMTP id 00721157ae682-79bde06b035mr41167017b3.48.1774642499568;
        Fri, 27 Mar 2026 13:14:59 -0700 (PDT)
X-Received: by 2002:a05:690c:e092:b0:79b:d56a:a7c2 with SMTP id 00721157ae682-79bde06b035mr41166627b3.48.1774642499129;
        Fri, 27 Mar 2026 13:14:59 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:14:58 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v10 04/10] bng_en: implement ethtool pauseparam operations
Date: Sat, 28 Mar 2026 01:43:37 +0530
Message-ID: <20260327201343.16146-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272673-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8262D34AFBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 63 +++++++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  6 +-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 45 +++++++++----
 3 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 6bb74a84ea03..424bf2d6721c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -46,6 +46,67 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static void bnge_get_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE) {
+		epause->autoneg = 0;
+		epause->rx_pause = 0;
+		epause->tx_pause = 0;
+		return;
+	}
+
+	epause->autoneg = !!(bn->eth_link_info.autoneg &
+			     BNGE_AUTONEG_FLOW_CTRL);
+	epause->rx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_RX);
+	epause->tx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_TX);
+}
+
+static int bnge_set_pauseparam(struct net_device *dev,
+			       struct ethtool_pauseparam *epause)
+{
+	struct bnge_ethtool_link_info old_elink_info, *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+	old_elink_info = *elink_info;
+
+	if (epause->autoneg) {
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED))
+			return -EINVAL;
+
+		elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+	} else {
+		if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+			elink_info->force_link_chng = true;
+		elink_info->autoneg &= ~BNGE_AUTONEG_FLOW_CTRL;
+	}
+
+	elink_info->req_flow_ctrl = 0;
+	if (epause->rx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_RX;
+	if (epause->tx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_TX;
+
+	if (netif_running(dev)) {
+		rc = bnge_hwrm_set_pause(bn);
+		if (rc)
+			*elink_info = old_elink_info;
+	}
+
+	return rc;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -53,6 +114,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 1cc62883d3c7..42fa08103df5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1054,7 +1054,11 @@ int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause)
 
 	bnge_hwrm_set_link_common(bn, req);
 
-	return bnge_hwrm_req_send(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		bn->eth_link_info.force_link_chng = false;
+
+	return rc;
 }
 
 int bnge_update_link(struct bnge_net *bn, bool chng_link_state)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index af2f4466a199..aef06c13f335 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -302,6 +302,8 @@ int bnge_update_phy_setting(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	bool update_pause = false;
 	bool update_link = false;
+	bool hw_pause_autoneg;
+	bool pause_autoneg;
 	int rc;
 
 	link_info = &bd->link_info;
@@ -313,24 +315,41 @@ int bnge_update_phy_setting(struct bnge_net *bn)
 		return rc;
 	}
 
-	if ((elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
-	    (link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
-	    elink_info->req_flow_ctrl)
+	pause_autoneg = !!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL);
+	hw_pause_autoneg = !!(link_info->auto_pause_setting &
+			      PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE);
+
+	/* Check if pause autonegotiation state has changed */
+	if (pause_autoneg != hw_pause_autoneg) {
 		update_pause = true;
-	if (!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
-	    link_info->force_pause_setting != elink_info->req_flow_ctrl)
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
 		update_pause = true;
+
+	/* Check if link speed or duplex settings have changed */
 	if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
-		if (BNGE_AUTO_MODE(link_info->auto_mode))
-			update_link = true;
-		if (bnge_force_speed_updated(bn))
-			update_link = true;
-		if (elink_info->req_duplex != link_info->duplex_setting)
+		if (BNGE_AUTO_MODE(link_info->auto_mode) ||
+		    bnge_force_speed_updated(bn) ||
+		    elink_info->req_duplex != link_info->duplex_setting)
 			update_link = true;
 	} else {
-		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE)
-			update_link = true;
-		if (bnge_auto_speed_updated(bn))
+		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE ||
+		    bnge_auto_speed_updated(bn))
 			update_link = true;
 	}
 
-- 
2.47.3


