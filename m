Return-Path: <netdev+bounces-265255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJDdMUFCrWkM0QEAu9opvQ
	(envelope-from <netdev+bounces-265255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:32:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986E22F354
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD478300C91B
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29535B650;
	Sun,  8 Mar 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uPJMd4l5"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E12D3ED2;
	Sun,  8 Mar 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772962327; cv=fail; b=YHL+nc6ya5RxOV9XWkcwx7Q1VedUASxwo/tomx6HvyC7BplUir1VTsZ2Xs/noRNP4CIzj9WAOZ4Lp0Zbu1AJwBIXGkFj1FV8Ok74JgIJFA2qtaB+6kxsoGuYm8gvWG/1hCwuXpM/YySWXssoEoSaBLvS3WOvbLDBBVBQVCmiYis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772962327; c=relaxed/simple;
	bh=mPD0M5Xy9DA5n2TfEanp9FQBbc8WQp0ZLLUyk+5buuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNqnx+JMokJqye06M36myacqmYQZVYbzmfMtxAShUWUXq/GrHPAF9e2OM0pTLlzTraDw4TaQrPKQMDDsXuot1wTY7fk1cqgUA3vNcxOGfSN7NsuuaLRDZcGcESic98pcnUCowFhdKWzDd+Ld9IRyG87X2T/xhGMVwKNX+4aj/uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uPJMd4l5; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkmCo4xQ05BfIKIOUp9oWPcZTXEZyQmdfP1XmaEGP/jjPjacnDHJPgq47pH11zXF45vFD9ZxPXNSNQxkTCnGiTeijYIefr8Ji4MOtkW0j6Z7YQXrsUz1RktG4gwG/UxwSOHsfuFilv1DJCt0hgHHs5K4mQcnqSKDSZyG76wPRPNw6GOjdBQcWRpB4aLHe5ixPsDVVoTQjbgCTT5Oe5aqfK/jMYeTctIycMFDGn0v7L1YLqboMXjlouR6hfWShChyGg+bxz+bjBDg6vQidUUwEPq3MWDYcd+7EwnEXxP6pTEd8e0o7Kjf0vwJsFkUa+LDVMoOOIj6aNgps3Dnat+J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQZ7GvZ3YSDloFfWmU+Wl7lcVNVVg498Swlr0jqv2GA=;
 b=GHY5hRXPfTmqRa1RqajiLIPQkml77dM5VSnHLLccbX3Lrb1rZ3T2Volwiyq357Qlt5XoyO8HnPXFLvdrl5fENX+OzqF+dz2pfL0y8AOeUshHD+DYjdlYonvoT6g+vRPOH7W/lxMxinMuRwo1stVa0oayI+Je0TIPGLqX4L5Oom9kKiTdjaLsZLGaUALmW49xzlz9EaYoNSJOdj9mMQU+EScCuUVGxjpc1FYXLIPg5kcx51BFS/AKYdSJLvqgjxKlC8So6PI1SSnelKZuDfm8Ty9uSCisADR+/YUiYr8vzCZ0/qZV0QpJ+ZP6de4IguoD8oMC7M599V+xvch0GU1ykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQZ7GvZ3YSDloFfWmU+Wl7lcVNVVg498Swlr0jqv2GA=;
 b=uPJMd4l5DxY4YtMp0kHElYv0ialo4mdeFAk4BHqxBhH0dQYFIlZ/XOIZKSZOWOUKxFvP1qbgjVmvRLOAm1pppqwd5Ak5/OGkN9nJFZ573/ZNMbe9j45F7PoJ6ZQHRJ/yMI1BQxa32DgedzUc5j76R130X+krn9wLv3SVXdaXPCY=
Received: from BL0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:207:3d::30)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Sun, 8 Mar
 2026 09:29:37 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::41) by BL0PR02CA0053.outlook.office365.com
 (2603:10b6:207:3d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 09:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 09:29:37 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Mar
 2026 04:29:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 2/2] amd-xgbe: add PCI power management for S0i3 support
Date: Sun, 8 Mar 2026 14:58:51 +0530
Message-ID: <20260308092851.1510214-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
References: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 0225eca4-e104-4264-a2c5-08de7cf53790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	AW/HgYNM36PtSaQjRXigPxLFbiZIUW+Xl3DEAb8ucIdBjSUyfLv2LRe9wKaD8kk1Tp7C6TlI1A3Jkrc2I0TjwNneOpTduDb3zV64mNTRAnNBuneBqubSzMbKdANgcX54XN7UwttZt+EMhZjyXT2VcXj/paZ/lSYxQ3/7RAo5m6f2XQTD143ZSjrNMLjD+vZ1HllYe7jE7UTgIWUY9b0tVHDIi/LTZ35SyBIhkDdVdS5vgByosReQMP1gAi6oipVRzEhlXoZvYCWcoz7ohZHTsWfgST6uc/E/JiieXpl6KDgjJ509PIFQgDE44MHnhgiaHLnC03VvMrP2649q+vcmM0N4w/RUgAwpJh67FrfuBvsybfcS29EqK9jGAKM8ObIr6kQyBF+hmyPlSpC+CTPOY0K8s9BCVsU3IA0S1YiLGXctPfpldC9T0kguaFlqQjrrXK2DoTVmEiSDnrTa/40delo+0U/eKVRYouPWRK3jp+vP+YEb99IZXXvEnxZ/nEnNMB0P8JYUEuTlDS/GE0FxvtWU+KvUO8dVOJc+ySN4PntVo32bsHZ3VjSaU74Ils7x8M2MpvZzbh9zufXXNqblmOroBYxmJp9Mg4oFJcN6kq7sM6Ij8o59fMDupeyPCUKLX/7q2l+mdyHqP9ssdUXzX/HsuqzLLviHUCzcf3hhmLKIq2HW+v1DUZ1Nr88PF3Co7EXeLkyrys47T1Plq6P1tQwEzjfAAf92pbS5Rjt8P743CQHOLNQy47940swOps55wL5AdVZyjYcGEAHeNK5+7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nx9XXMny6POmdDAgIToKS6QJXEzW3BJNPrqXTLown8viLz0LTwHkY6La5dR11CdMlmqGX/1IYXEsWgWwGs+OY5TZNJ5K+ZdRM8ECVmr9M4cmTpOGgJpUnqdC7+7PbFOOl2VRigmbR7sp1AyMzRB55lRLhSdouxWYAlqYbSzzGWdDeUrPbQWZkpvciCfmHrvaaOy2ZBhZFsB+H/Xeg2zMf73ofg6KqVPJl+pMLFkabA2ejNDB7OonuKG05e9p2Qux2tq+Dbt3ka4IBWcScwvtdPkm8wdTfIyo9CmZspJRRAeMw0jLZ4QMuiU8LwUHGON94KzjKkJqllCk9KQHDOcAeew8higuCiYXEAdPfR5nI0U9lDENNfHNqkc3SNGiTX+t7+kmiBLyGE9jeKBLJYD+r2rAYuHo1kMBhUMpJPpwZ6RQ8gLx25brGJZrmi2xqO8O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 09:29:37.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0225eca4-e104-4264-a2c5-08de7cf53790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
X-Rspamd-Queue-Id: 2986E22F354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265255-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The current suspend/resume implementation does not correctly handle PCI
device power state transitions, which prevents AMD platforms from
reaching the deepest suspend state (S0i3) when the amd-xgbe driver is
enabled.

In particular, the amd_pmc driver reports:

  "Last suspend didn't reach deepest state"

when this device is present.

Implement proper PCI power management operations following the standard
PCI PM model so that the device can be cleanly powered down and resumed.

Suspend path:
- Power down the network interface
- Put the PHY into low-power mode
- Disable bus mastering to prevent DMA activity
- Save PCI configuration space
- Disable the PCI device
- Disable wake from D3 (S0i3 does not require Wake-on-LAN)
- Set the device to D3hot

Resume path:
- Restore the PCI power state to D0
- Restore PCI configuration space
- Enable the PCI device
- Re-enable bus mastering
- Re-enable device interrupts
- Clear the PHY low-power mode
- Power up the network interface

This allows systems using amd-xgbe to reach the deepest suspend state
when entering modern standby (S0i3).

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - Added a new helper function xgbe_pci_synchronize_irqs() that
   synchronizes all registered IRQs to ensure that no pending IRQs are
   left when the device is suspended.

 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 9e09b269cb1d..dbdd791380a4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -360,19 +360,67 @@ static void xgbe_pci_remove(struct pci_dev *pdev)
 	xgbe_free_pdata(pdata);
 }
 
+static void xgbe_pci_synchronize_irqs(struct xgbe_prv_data *pdata)
+{
+	unsigned int i;
+
+	/* Synchronize main device interrupt */
+	synchronize_irq(pdata->dev_irq);
+
+	/* Synchronize ECC interrupt if separate from main device interrupt */
+	if (pdata->vdata->ecc_support && pdata->dev_irq != pdata->ecc_irq)
+		synchronize_irq(pdata->ecc_irq);
+
+	/* Synchronize I2C interrupt if separate from main device interrupt */
+	if (pdata->vdata->i2c_support && pdata->dev_irq != pdata->i2c_irq)
+		synchronize_irq(pdata->i2c_irq);
+
+	/* Synchronize AN interrupt if separate from main device interrupt */
+	if (pdata->dev_irq != pdata->an_irq)
+		synchronize_irq(pdata->an_irq);
+
+	/* Synchronize per-channel DMA interrupts */
+	if (pdata->per_channel_irq) {
+		for (i = 0; i < pdata->channel_count; i++)
+			synchronize_irq(pdata->channel[i]->dma_irq);
+	}
+}
+
 static int xgbe_pci_suspend(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
 	if (netif_running(netdev))
 		ret = xgbe_powerdown(netdev);
 
+	/* Disable all device interrupts to prevent spurious wakeups */
+	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
+
+	/* Ensure no IRQ handlers are still executing before powering down.
+	 * This prevents race conditions where an IRQ handler could access
+	 * invalid register state after the device is disabled.
+	 */
+	xgbe_pci_synchronize_irqs(pdata);
+
+	/* Set PHY to low-power mode */
 	pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
 	pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
+	/* Disable bus mastering to prevent DMA activity */
+	pci_clear_master(pdev);
+
+	/* Save PCI configuration state and disable device */
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+
+	/* Disable wake from D3 - required for S0i3 deep sleep */
+	pci_wake_from_d3(pdev, false);
+	pci_set_power_state(pdev, PCI_D3hot);
+
 	return ret;
 }
 
@@ -380,10 +428,29 @@ static int xgbe_pci_resume(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
+	/* Restore PCI power state */
+	pci_set_power_state(pdev, PCI_D0);
+
+	/* Restore PCI configuration state */
+	pci_restore_state(pdev);
+
+	/* Enable PCI device */
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "pci_enable_device failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Re-enable bus mastering */
+	pci_set_master(pdev);
+
+	/* Re-enable all device interrupts */
 	XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
 
+	/* Clear PHY low-power mode */
 	pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
-- 
2.34.1


