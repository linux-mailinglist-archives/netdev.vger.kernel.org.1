Return-Path: <netdev+bounces-283271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPerF3T39GklGQIAu9opvQ
	(envelope-from <netdev+bounces-283271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C374AEF80
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA800300C0CB
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0841C302;
	Fri,  1 May 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GlhCLXu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D141B34D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661801; cv=none; b=CbNFcKhq0CePfZf6cOFOFHYBzepVrDgUmDClLA3A+pHnxMOZQbQtc5Gc9aFI4qoSpKZnYBPxfeT7/FS3mdKDJ1WpIyMlgbM6JBi3+I9OTGgLYvJdYtFM79dfgw9GHOFKieFeVglLtrjZOtcMH26XlTm7aV0+sC+Ax2bhYP+NU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661801; c=relaxed/simple;
	bh=GAzQrzeZZ5f4rCf2beaB4/D/Xth15Z9jW88twsQtbSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q324tWbx8efs+nK5fEa6dr0mPLm5dOhjyo2Rdgr+nq5ukXuiA4OqjvVts9tMu2m97yd7DqsBEcjBFeVKq6gYVsiec8nLpAReRldZwY91n+NwEKGgxeDSTjsXrADcXpr4umPqQgRvpRNZEdkdvzGW6Rbt+9kD72N3pGcn13fNabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GlhCLXu3; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8e0a768331cso312848585a.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661799; x=1778266599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBJKm/9XoepoTMByLqn9rreVX/uyPzlVOzw2QKJ1xFs=;
        b=coP7RO1w/MAoG1+CXHGgg98nwsbzAfNmyrb3j66zU0uaVWlQxY8/fD330mXyB/ieXj
         a45R2tAio45zxQS0O205VGJTeLL1VKQ41ECtELenKow1BfQ6WIlHAsgPQhorbTYO5xJ7
         fNBGCoWr20jY7UyNEidXd7ZIOCm18UQZ/AsxcEYnBr/g9aYFhnmHUrIfvkF2Tz1Qy65U
         EvFYHM+2UO+3wTwgS0istSoS96daseKoRObeoikozuc1+8LWfBO/LexEa2QUHhRLze/j
         xpItFD7+7dMlfsgp8CoAOKR5NmW1dwDZtuPB4TLd1ZrXyNY6BqJgXhaLhfcYnLRc8WUx
         AgIA==
X-Gm-Message-State: AOJu0YxRWIwOPjC3bU6N+Ee/cIvNZZeVQ75mjxQta0V8blXST/ZRy8KT
	C4kzCzDFn4OuJCz+oiOsTM8T2gFFo28EEjTZHhMRGtlljJvy5xmDlUpSYSj65Rfls3SUCVxzvYP
	KmMDFGUnSoz8KarJuT9pq8LGRo7GOIpxOoS/d85rPulN/2d8Fl8xHlT9rGBkhErlerhoguwXN54
	XZhYflhoWcMvtuJ2xi3hLNURDnVyYsxMZWVk9tX5vfJNrlezdVRG0TrJO2Bm61X5jYgaM2kG6t8
	p1HT82COg==
X-Gm-Gg: AeBDieuonax6S72u56598jrvZKRj6gQ42PcZlFexg4TyiUdm6M+icRxy5zXyBK7GD64
	pAf4YCep4vEqGtfSpA+iUJBBGV6O+9QfGZgH+8ZVO6S8kKf0wIEUn0pkXEOAgwx8j1N0For3Szd
	+oPAHmAYnZCRHM+5BE/4fDL8ymq8yCi1JluhwSEzU5gPge/OGBLTwE4V7prKSUxTrePg8dJDgTQ
	rfPZmP5eNAZcrcqtTlHQJSj0Aai1Ct4xmktPPLk5dU+K9NpakpHUTKd0cxefBPoaeMQc4U0fqFc
	5cwxVHr/gzB7izT/z4NRFO2DmY4UXO/MWqKL80Z8Kc+9bR3bNeE/12La/oHkDIeUVUMjr7cLbBQ
	1bC33H+bNdnUJotghgMBFHSz9vbfYbO+M2KjmgYtlSJse+7AEsK9sPxVL3rl0u9CjILaVIlvkDd
	rldLx5Vp79LgMSMt3XDfR7m109LxKMHxmy/bMylmpIn8vyO4XdSGzKBOUWxlgL7jMFMw==
X-Received: by 2002:a05:620a:1a23:b0:8eb:605f:6cd3 with SMTP id af79cd13be357-8fabb8c3a65mr1041890685a.39.1777661798635;
        Fri, 01 May 2026 11:56:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53b918281sm2717626d6.19.2026.05.01.11.56.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 11:56:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eb9f8bbbb3so1037289385a.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777661797; x=1778266597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBJKm/9XoepoTMByLqn9rreVX/uyPzlVOzw2QKJ1xFs=;
        b=GlhCLXu3dn/cu346YbnWyrZxL+EMfW4A+p5yE7jFYoxb3G9kVttIQ/AW3TVxW7Gtcu
         dPTZ0gjNg6jNk3v0oAAl7o0oQbIeKNEr4hk8BelWDkkZunPrfZbCUS8mPONvVQTm1LpC
         fhBybxiVZJ5poJgGoWSHgSRyuxvG01quCyYlI=
X-Received: by 2002:a05:620a:44d4:b0:8c6:a103:496b with SMTP id af79cd13be357-8fabad17c06mr1069920185a.25.1777661797497;
        Fri, 01 May 2026 11:56:37 -0700 (PDT)
X-Received: by 2002:a05:620a:44d4:b0:8c6:a103:496b with SMTP id af79cd13be357-8fabad17c06mr1069916085a.25.1777661796964;
        Fri, 01 May 2026 11:56:36 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d20fsm238003185a.1.2026.05.01.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:56:36 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 2/2] net: bcmasp: Keep PHY link during WoL sleep cycle
Date: Fri,  1 May 2026 11:56:25 -0700
Message-Id: <20260501185625.422361-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501185625.422361-1-justin.chen@broadcom.com>
References: <20260501185625.422361-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 00C374AEF80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283271-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

We currently more or less restart all the HW on resume whatever WoL is
enabled or not. The PHY is powered when WoL is enabled which means we
have no reason to re-negotiate the link on resume. So instead of doing
a full restart in this case, we do a partial restart and keep the
negotiated link. That way we can resume network taffic with a much smaller
delay. In the non-WoL case, we do not want to keep the PHY powered, so we
follow the same flow.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
- In the resume case with a HW reset. We trigger a relink by setting the link
  to PHY_UP instead of calling phy_restart_aneg().

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index e2b51ec903af..9ffd0dfa5969 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -923,7 +923,7 @@ static void bcmasp_phy_hw_unprepare(struct bcmasp_intf *intf)
 		bcmasp_rgmii_mode_en_set(intf, false);
 }
 
-static void bcmasp_netif_deinit(struct net_device *dev)
+static void bcmasp_netif_deinit(struct net_device *dev, bool stop_phy)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
 	u32 reg, timeout = 1000;
@@ -946,7 +946,8 @@ static void bcmasp_netif_deinit(struct net_device *dev)
 
 	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
 
-	phy_stop(dev->phydev);
+	if (stop_phy)
+		phy_stop(dev->phydev);
 
 	umac_enable_set(intf, UMC_CMD_RX_EN, 0);
 
@@ -974,7 +975,7 @@ static int bcmasp_stop(struct net_device *dev)
 	/* Stop tx from updating HW */
 	netif_tx_disable(dev);
 
-	bcmasp_netif_deinit(dev);
+	bcmasp_netif_deinit(dev, true);
 
 	bcmasp_reclaim_free_buffers(intf);
 
@@ -1385,15 +1386,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 {
 	struct device *kdev = &intf->parent->pdev->dev;
 	struct net_device *dev = intf->ndev;
+	bool wake;
 
 	if (!netif_running(dev))
 		return 0;
 
 	netif_device_detach(dev);
 
-	bcmasp_netif_deinit(dev);
+	wake = device_may_wakeup(kdev) && intf->wolopts;
 
-	if (!intf->wolopts) {
+	bcmasp_netif_deinit(dev, !wake);
+
+	if (wake) {
+		bcmasp_suspend_to_wol(intf);
+	} else {
 		bcmasp_phy_hw_unprepare(intf);
 
 		/* If Wake-on-LAN is disabled, we can safely
@@ -1402,9 +1408,6 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 		bcmasp_core_clock_set_intf(intf, false);
 	}
 
-	if (device_may_wakeup(kdev) && intf->wolopts)
-		bcmasp_suspend_to_wol(intf);
-
 	clk_disable_unprepare(intf->parent->clk);
 
 	return 0;
@@ -1428,8 +1431,11 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 
 int bcmasp_interface_resume(struct bcmasp_intf *intf)
 {
+	struct device *kdev = &intf->parent->pdev->dev;
 	struct net_device *dev = intf->ndev;
+	bool wake;
 	int ret;
+	u32 reg;
 
 	if (!netif_running(dev))
 		return 0;
@@ -1438,17 +1444,34 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
 	if (ret)
 		return ret;
 
-	bcmasp_core_clock_set_intf(intf, true);
-
-	bcmasp_resume_from_wol(intf);
+	wake = device_may_wakeup(kdev) && intf->wolopts;
 
-	bcmasp_phy_hw_prepare(intf);
+	bcmasp_core_clock_set_intf(intf, true);
 
-	umac_reset_and_init(intf, dev->dev_addr);
+	/* The interface might be HW reset in some suspend modes, so we may
+	 * need to restore the UNIMAC/PHY if that is the case.
+	 */
+	reg = umac_rl(intf, UMC_CMD);
+	if (wake && (reg & UMC_CMD_RX_EN)) {
+		umac_enable_set(intf, UMC_CMD_TX_EN, 1);
+		bcmasp_resume_from_wol(intf);
+	} else {
+		bcmasp_phy_hw_prepare(intf);
+		umac_reset_and_init(intf, dev->dev_addr);
+	}
 
 	bcmasp_netif_init(dev);
 
-	phy_start(dev->phydev);
+	/* If HW was reset, we need to force a relink */
+	if (wake && !(reg & UMC_CMD_RX_EN)) {
+		mutex_lock(&dev->phydev->lock);
+		if (dev->phydev->state == PHY_RUNNING)
+			dev->phydev->state = PHY_UP;
+		mutex_unlock(&dev->phydev->lock);
+		phy_trigger_machine(dev->phydev);
+	} else if (!wake) {
+		phy_start(dev->phydev);
+	}
 
 	netif_device_attach(dev);
 
-- 
2.34.1


