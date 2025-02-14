Return-Path: <netdev+bounces-166337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA28A3596F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AF9188CDC3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCF227BB6;
	Fri, 14 Feb 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="b6vWO3SL"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530D227BB1;
	Fri, 14 Feb 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523258; cv=none; b=cAKA2jDXHc2TiuFMwW4yBLTv2Pc9M+PVYtnEjOC4jwSw0hR7xEKprxjYbF2P2hIRsZTLU7QSEhGmG5WZWYrFdRFROIwfdLFCfclzaxuh+qMY1l+LrKlEr+/Y2AjLHG9HI5nohTZ3H8J0412IsjlDwGcV8KSXvX2P2Suxm5O5xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523258; c=relaxed/simple;
	bh=O+/6ZX19078tHBx+mS1WFHmn72pUXN9yMAyFIwDf64k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aox47MShjYMXaqr91z2vFXvgLRfHy3yxcbdOimOp32WaGta7lQMt5hF2J4dOYxlKPXS+eDVUGHAYitPtn9uESUmRc6ugqzry+qKk1tiUg+XtmmzG/+qVBmOBT4f5ILxKS3AYZL5tqQLh1RHV8CnpgzrNqcYJhsT2QILOaEW9hSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=b6vWO3SL; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GFtBsDbwRsR/crt8cPI3NZAjnEiA9mCcWyHWPic5WA8=; b=b6vWO3SLLNU0mBJ2vYMXCIdTrZ
	CrJbjdlYfmP7QMPsgatNewRq35a9FHOM7zINju+WUE81lQNIR1r+JOF2L4Q6pWT8qb839pyvw5Uye
	LVVjCElVzI+WfEwjr+gJJum6L3GXAlno64hR1uWyVhCjqdYqyXj3Jb3Oh7qp6GoSqfxyGn1giyyoM
	Ks1yVjkb0j1TOlR879br4z4YBObK995tj5QTELeL/SmFthbTcR3qrlXL4BT+h+tE/lk8vcTCgoQYA
	VHgoKkqj6v8BT29IvKpcC5+z4BLpByfYVOYX3M2NLEDOCN84j6gopsizolNq+M8OS7Pts2LYZQPis
	nhmHbJ9Q==;
Received: from [122.175.9.182] (port=45524 helo=cypher.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.96.2)
	(envelope-from <parvathi@couthit.com>)
	id 1tirSd-00050J-2H;
	Fri, 14 Feb 2025 14:24:11 +0530
From: parvathi <parvathi@couthit.com>
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
	richardcochran@gmail.com,
	parvathi@couthit.com,
	basharath@couthit.com,
	schnelle@linux.ibm.com,
	diogo.ivo@siemens.com,
	m-karicheri2@ti.com,
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
Subject: [PATCH net-next v3 09/10] net: ti: prueth: Adds power management support for PRU-ICSS
Date: Fri, 14 Feb 2025 14:23:14 +0530
Message-Id: <20250214085315.1077108-10-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214054702.1073139-1-parvathi@couthit.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
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
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 62 ++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 5011dde6859f..dfceb8fddd33 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -2321,6 +2321,67 @@ static void icssm_prueth_remove(struct platform_device *pdev)
 		pru_rproc_put(prueth->pru0);
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
+	pruss_cfg_ocp_master_ports(prueth->pruss, 0);
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
+	pruss_cfg_ocp_master_ports(prueth->pruss, 1);
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
@@ -2346,6 +2407,7 @@ static struct platform_driver prueth_driver = {
 	.driver = {
 		.name = "prueth",
 		.of_match_table = prueth_dt_match,
+		.pm = &prueth_dev_pm_ops,
 	},
 };
 module_platform_driver(prueth_driver);
-- 
2.34.1


