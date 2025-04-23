Return-Path: <netdev+bounces-185039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96566A984FA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17FE176EDD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543925C829;
	Wed, 23 Apr 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="r8Vgui8j"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6D24467B;
	Wed, 23 Apr 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399269; cv=none; b=GyePNYnLY0rWNbIlP6gpBWanot57+TdYKHEmdYHO/8QUCaKzVcZSQIyUjQ4EexgN1YDkDaLUay5oI4K0R0cauIU82oBsW3FuFpuBhdVvZZDNZSGO82WtwatzDzljEjOUxeQqrqAiyIF+3CvN8xtS5ykChgJdBc9q+bM0fg7W+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399269; c=relaxed/simple;
	bh=fxCOWLF1GiODmuk8G2DVFyBG2vQu7uiK1k0pMSN6wio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fP/WUfeJd7wtl8E41SDR34RxKrx1p8IUBy201NFWkX51TCCc8nZukIdl+DDLEZ1iLc0qXLSeql0MfVwp+0u2n/ZNLehmWpUHEoZivUmL5sxVmYsNx0JuUHrx5YaUUB0JmCqtyZtdQAyLbodo7cGVfNx83Z2VFJbDA78GQqjiMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=r8Vgui8j; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HoKdFlJu6vKv+HOYvf7OLzTmLxpKaYtSq4DTHwjlric=; b=r8Vgui8j8JnI3PS0vSHmUDL9xz
	16pjSOwjIhG450fcqHu/qr+Fob+aLaNC0dWM2ebp4nGnQ6zMO6uzKm1KjP72+zBrJjv6DXbgNL3Wy
	WnCVGn573PgIAYJ7NfWVnK+1p76s/oTA+BMUXXly4E0EtTSaPEfiIgC2heWJs3Z0R9RJMP+fkXFdy
	tBobPK+Vx5r9VwFrBjsInScJ4+GPgsCOKjqmKs6CPa9eQOIKBAWPQ3qZ12vKR0S1IdXcWI+z8N1kI
	Hw9Sg4far77WDUpMVDEHoAY5lX40Ennzt+sVoZuczLkTSeljwSOlXaeLplnFrievjLdebUm7eJu2G
	qC+yPMXQ==;
Received: from [122.175.9.182] (port=30206 helo=cypher.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u7W4s-0000000077s-0Afm;
	Wed, 23 Apr 2025 14:37:34 +0530
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nm@ti.com,
	ssantosh@kernel.org,
	tony@atomide.com,
	richardcochran@gmail.com,
	glaroque@baylibre.com,
	schnelle@linux.ibm.com,
	m-karicheri2@ti.com,
	s.hauer@pengutronix.de,
	rdunlap@infradead.org,
	diogo.ivo@siemens.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com,
	afd@ti.com,
	s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v6 09/11] net: ti: prueth: Adds power management support for PRU-ICSS
Date: Wed, 23 Apr 2025 14:36:29 +0530
Message-Id: <20250423090631.326351-10-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423060707.145166-1-parvathi@couthit.com>
References: <20250423060707.145166-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

Changes for supporting the sleep/resume feature for PRU-ICSS.

PRU-ICSS will be kept in IDLE mode for optimal power consumption by Linux
power management subsystem and will be resumed when it is required.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 58 ++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 8c395d8eaf55..4c9e91caebf9 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -2303,6 +2303,63 @@ static void icssm_prueth_remove(struct platform_device *pdev)
 		pru_rproc_put(prueth->pru1);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int icssm_prueth_suspend(struct device *dev)
+{
+	struct prueth *prueth = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	int i, ret;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		ndev = prueth->registered_netdevs[i];
+
+		if (!ndev)
+			continue;
+
+		if (netif_running(ndev)) {
+			netif_device_detach(ndev);
+			ret = icssm_emac_ndo_stop(ndev);
+			if (ret < 0) {
+				netdev_err(ndev, "failed to stop: %d", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int icssm_prueth_resume(struct device *dev)
+{
+	struct prueth *prueth = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	int i, ret;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		ndev = prueth->registered_netdevs[i];
+
+		if (!ndev)
+			continue;
+
+		if (netif_running(ndev)) {
+			ret = icssm_emac_ndo_open(ndev);
+			if (ret < 0) {
+				netdev_err(ndev, "failed to start: %d", ret);
+				return ret;
+			}
+			netif_device_attach(ndev);
+		}
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops prueth_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(icssm_prueth_suspend, icssm_prueth_resume)
+};
+
 /* AM57xx SoC-specific firmware data */
 static struct prueth_private_data am57xx_prueth_pdata = {
 	.driver_data = PRUSS_AM57XX,
@@ -2328,6 +2385,7 @@ static struct platform_driver prueth_driver = {
 	.driver = {
 		.name = "prueth",
 		.of_match_table = prueth_dt_match,
+		.pm = &prueth_dev_pm_ops,
 	},
 };
 module_platform_driver(prueth_driver);
-- 
2.34.1


