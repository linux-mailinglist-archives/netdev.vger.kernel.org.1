Return-Path: <netdev+bounces-285040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK5vG0az+2lJDgAAu9opvQ
	(envelope-from <netdev+bounces-285040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:31:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3484E09BF
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D99B30234E9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A53B27D3;
	Wed,  6 May 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C661re7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB92E0938
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103091; cv=none; b=SPThoO5ZkooJgYbtPLgDJvyu4NRdvrE1Hq5dOJffk9O7SrSwwULtPSKzZzFo++CTuiphhLRiSIKof8vLE7b9n667Zj0OulCIcQQOXUCJJf43emj4ydVpcJuKebZZJfTTmnCnM7JGIYf0088aQuG1U+L3s8RLWxIRiSgqKJeOsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103091; c=relaxed/simple;
	bh=rYOH6EfLpXoR6vuvFp1I7y9D5FmaLFa+lKH/uXPDwYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AT+HyOHsxh/6HSyT35E/P5UvrsZH43V1TucIveVcx5T9Ho+uTULUzsAzzRj4Ohq6V8BJUuFbDUNr7JcTEYInb5yeRbP3Mi6Ha0JjwsdPGA6XEeZwExijZnbfhucQH+WymL6mqJ3Fw9V/pIIKmDxi1CvSmgcionYtjsu79DNZF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C661re7f; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7d4be94eeacso208193a34.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778103089; x=1778707889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcUPbgWPYmkGz1ZnpTou7dfhZwbMgdLOUBy/sE6yX8A=;
        b=BuqnJkrtfjn7Jahzlaf1cWokU77relp7AIezolij92kEJOLvS2NT+aDSG6bcyf10HG
         lh407qB5Q6LUVksnn4GIwxP7FpP8Galb8PBg48cN3cZM0+SUrIZV4nbGsfAecUQ+xT7/
         d/2sHXSD+jOwQEK17ebjS9EagzuzrrAfYNL9kmGmpNEIUz6bzE8vJMTKKDTPGGLJilJc
         H+jIktC63HHvHvMQWgEboKScaEVw4QuxyMb8yCivT41lexyVoCMR0ATErXwyhxbfi1mQ
         w2orbRn90ssOk/x500c/WUgSWsEgpmphXUXmBB2hRsp26SQp1iTGdLCkz05UyzVwBhZ3
         9oBA==
X-Gm-Message-State: AOJu0YyL8rqdmXBcIPMIVGPP5GaTkYa2ZT0GzVa9HXTbvH1Fv/BCrycb
	F2NDfZAyqK90whs+WAvpOsiS+3h9WYD7WEaYi3gIoOm7JVXjSMg3oJZ8rijUctQnm8icTEioQjx
	+oOER/U5788UiskEXD1dMe75ekULGctPkbeiU2hj48VWk1iMjp4EXBB5hv0teiqP0s78Ap65xfO
	umukno9qH7JxGKdallw7cBGUy8zmc6BGAQMPMLmtrJeygkQObeUrkN6BLu39P6WDhH7XTMVDaP8
	qTFpkaHSg==
X-Gm-Gg: AeBDiethjUCN4740wjV7kH6RY7YcV0525Y7XXhetZZn2er3KLUmykZvVfkPqiCt7qhg
	jraT9sINUalWnuzltE2ECvhdbuzLcaem7thST3S3HV41sNZAjI87KIbhfNXFUTUNwjpqIak2CMR
	yIv+pasd6kXy3HEdeqwDrnxjJ2xXr/HwwY514mMyCFOGjujFSz7bUYHk2LNr3vvMjQqBzCg5dZA
	x9u5YIonLAJdgQspFHQVSL6uLzE9t/xLBniEDaKC0BdIBjj/eTojk4qu99DojZB+DlEnGg34h6b
	Htd2MZBMP32AX2BpyvjN8Af2mWe5sG879ieXP+z9RY8yzOnnXtGqtkAR8KnBh8+MUMcedstnPRY
	F1bdJJVJ7f0hM4Q8kkEigaZrdpoaHNLLU34yYmCQvpxdD9I84uU056EK++i84cL8rEnEEhjQ/3s
	Nclfn3P/hDfb+WE2KfLqyi9Elv
X-Received: by 2002:a05:6820:f02c:b0:696:1a85:586f with SMTP id 006d021491bc7-69998cbc3dcmr2873232eaf.18.1778103089339;
        Wed, 06 May 2026 14:31:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43454d2207bsm1565868fac.10.2026.05.06.14.31.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 14:31:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f525565b33so204046eec.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778103088; x=1778707888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcUPbgWPYmkGz1ZnpTou7dfhZwbMgdLOUBy/sE6yX8A=;
        b=C661re7f2AMnJseJofDS7GiETg2vz0qTMWsbqT1ZYqgWaUZKIvx1hyi6tzWZEHOmpj
         oEU2412SkxTghqaQybnhWu/4pcMnlnVBnZB5m60JSdE6QxP1FemLjjZjy8eWMLRpcpfh
         gXB2nT6D6eTCThHaFg7I8keB7gSlqoM6XwB74=
X-Received: by 2002:a05:7301:9f03:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-2f54dc8e8ebmr2549982eec.11.1778103087588;
        Wed, 06 May 2026 14:31:27 -0700 (PDT)
X-Received: by 2002:a05:7301:9f03:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-2f54dc8e8ebmr2549954eec.11.1778103086952;
        Wed, 06 May 2026 14:31:26 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd909e3sm5234089eec.20.2026.05.06.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:31:26 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] net: bcmasp: Keep phy link during WoL sleep cycle
Date: Wed,  6 May 2026 14:31:14 -0700
Message-Id: <20260506213114.2002886-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506213114.2002886-1-justin.chen@broadcom.com>
References: <20260506213114.2002886-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: DB3484E09BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285040-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

We currently more or less restart all the HW on resume. Since we also
stop the PHY, it takes a while for the PHY link to be re-negotiated on
resume. Instead of doing a full restart, we keep the HW state and the
PHY link, that way we can resume network traffic with a much smaller
delay.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v3
- Reworked how we managed the phy state machine while suspended. We make sure
  the state machine is not running to avoid races and restore the link
  appropriately when the HW is reset.

v2
- In the resume case with a HW reset. We trigger a relink by setting the link
  to PHY_UP instead of calling phy_restart_aneg().

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 62 ++++++++++++++-----
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index e2b51ec903af..ed0977832ce4 100644
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
 
@@ -1385,15 +1386,26 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
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
+		/* Disable phy status updates while suspending */
+		mutex_lock(&dev->phydev->lock);
+		dev->phydev->state = PHY_READY;
+		mutex_unlock(&dev->phydev->lock);
+		cancel_delayed_work_sync(&dev->phydev->state_queue);
+
+		bcmasp_suspend_to_wol(intf);
+	} else {
 		bcmasp_phy_hw_unprepare(intf);
 
 		/* If Wake-on-LAN is disabled, we can safely
@@ -1402,9 +1414,6 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 		bcmasp_core_clock_set_intf(intf, false);
 	}
 
-	if (device_may_wakeup(kdev) && intf->wolopts)
-		bcmasp_suspend_to_wol(intf);
-
 	clk_disable_unprepare(intf->parent->clk);
 
 	return 0;
@@ -1428,8 +1437,11 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 
 int bcmasp_interface_resume(struct bcmasp_intf *intf)
 {
+	struct device *kdev = &intf->parent->pdev->dev;
 	struct net_device *dev = intf->ndev;
+	bool wake;
 	int ret;
+	u32 reg;
 
 	if (!netif_running(dev))
 		return 0;
@@ -1438,17 +1450,39 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
 	if (ret)
 		return ret;
 
-	bcmasp_core_clock_set_intf(intf, true);
+	wake = device_may_wakeup(kdev) && intf->wolopts;
 
-	bcmasp_resume_from_wol(intf);
-
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
+	if (wake) {
+		/* If HW was reset, reprogram the unimac/PHY before resuming
+		 * link status tracking to avoid racing the state machine.
+		 */
+		if (!(reg & UMC_CMD_RX_EN))
+			bcmasp_adj_link(dev);
+
+		/* Resume link status tracking */
+		mutex_lock(&dev->phydev->lock);
+		dev->phydev->state = dev->phydev->link ? PHY_RUNNING : PHY_NOLINK;
+		mutex_unlock(&dev->phydev->lock);
+		phy_trigger_machine(dev->phydev);
+	} else {
+		phy_start(dev->phydev);
+	}
 
 	netif_device_attach(dev);
 
-- 
2.34.1


