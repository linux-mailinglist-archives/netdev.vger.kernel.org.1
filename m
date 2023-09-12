Return-Path: <netdev+bounces-33254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E120279D37A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95900281E23
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8018B0F;
	Tue, 12 Sep 2023 14:22:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAF18AF6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372EE110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOI7lwDrsJnoMCRDjgdQTY3F6UFUYulLQi6PeLuHhfDKhho/u7Qj90m8Xuh+IZfdL0EsqavOTCspzo4pjig9iHZWNQbnXNDdXSpRtCSFg12wMblzQwe/W/jGW5r8wB+TYZCmPgOLCLVfpUBe0LPiwRImQ+ieefKYApTqDS0Mv7WL/ZXwzry/IoO52YjAubgGAvA8g190NEFiHUnmQXtqCohdxYUC5UNSCwN9VENm5JgUnh9KgaUI9ZFXLT2iqyvsvKRp1CaVSZbXvUH+wiPbTY96Fq1OxLOfCkdhdYyqq5ANloNawSiHXRMTi6Y71oar0C5o0Afpd3QEgixsVDB2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyQ0LQ+/SNivvskOlp1J2glz9ePHfisIbNz/6KIe+w0=;
 b=eE6Vkjq1s8t/i21MWWJv6AVAn+wFAijgQwn4e45YM+lDkoIC4cEbs6Q1Cxj0m0ypUmI7YO8lTJ3FCWf0WcuSBB/W4FGC1ueA4tdx8asFqwQaFadZKC4rXPZqEMseurpxAym1myhnG8wq+9S4MTNnZcIYGyJqB/BUv+5NSznuSgs8+YN+xVp7Iu/+MB+U2Z4xFqvTWVlOj0dZIFgCmfjY9XoEFItbgbV3wHoCHahiS2Nsya3pmR2qGQ06MuC/tcqV6iEaFRwfTodRHn6us5hhDkVw71U/tltycMPffqaBZ8Y5CjoLgB3UuTymfGlToe40MeDRDhy69cV6GUkUAWrgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=net-swift.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyQ0LQ+/SNivvskOlp1J2glz9ePHfisIbNz/6KIe+w0=;
 b=U54WW1YqGTiWZZegpN1EM+gNJgMRjzGSY438hyL3bvp5LLXpkqlvO5hN5jCm0II7Cka5uWR8qPj73Ify6ACexXHbKLKOepYezKuCNFPbauc3Ogw1B0kTFl4+RdqXoGoXls1rIwrcsSmEXQRQL1sTzpKMHJaNcZTxGV+Tzvh8ykE=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Tue, 12 Sep
 2023 14:22:24 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::5b) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 14:22:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 07:22:22 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:20 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <hkallweit1@gmail.com>, <nic_swsd@realtek.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
Subject: [RFC PATCH v3 net-next 1/7] net: move ethtool-related netdev state into its own struct
Date: Tue, 12 Sep 2023 15:21:36 +0100
Message-ID: <8b586b4d19b9473d0678dcd012c54bc1b87a5c3d.1694443665.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1694443665.git.ecree.xilinx@gmail.com>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7d6b83-d560-4512-c2da-08dbb39baef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/sU94DDpJJIaIICfbW/Y29Vn5g8NJu0BiUUjBnvIoPwv5lTaZNiBXly+GKfvE7PkuC+VcLqZpuXTDjC9lkQdQbrhvjqQcT3g9GFXzedvsnfMNgb95OTD04QGHBCauNT8GTao1M2uhGW9raUtjTfm/fxIDZbGu4tcpiOxYJWIuElSWkegq4QXYRThWQnJ4CtNzxh02B3UVEaDJZ7PMJF7fM/jUZ35EIYEUkFm80t/W+hzdqCKqhh78o133dqzumw1q0vd6pv8CmLTavAyy/NS1oTmh5vav6OdrliykxVZr4o79JsnewCpFN0OapQ/eFEUDtW7hBsgA+ymFdgmzkEFTJ7zZckH8Xyb/ImTQa5t/D8lZ3d1c/9tm339PzHzxKOffgBCp6B20aTA/c06bMcNGFRGTezM+filQQ6NtdCgpvl8n0pmkX1CQcCNgiavXc4IflPep1R+oIugJPab2DJTN0srROlYxMQL4phtkDDV+klBI4mujmRnPiV2AaVsXtxVQLpJs0AOvm48UxLQp5st+vTE3TM8f03gNX15Jda1tPTBQXMji2RROLKRBrL4p1gNcKLpti+2u1HKyX86C0ckLQg5FsuaFpHMcqO+n+lJrNYIL31VKsDy6c8OHO0hEUNAHX0JfVA8V7hmpvDxQ25x7OGlC95EF2IxTgwwk2pAoBpG/i4P5EeKKUys6NWU5TVsfg1jCDvnWYE3h1nwJVKXuqloRa/gVh0n+NHuAQgFylpEmK9YmrQNe00JlcgVZlsIBMtHfy7XthnuCnqc5EVTUrdkusFtkCdwaXIrSpHFcjk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(81166007)(6666004)(7416002)(55446002)(356005)(478600001)(47076005)(9686003)(36756003)(82740400003)(40460700003)(40480700001)(86362001)(336012)(26005)(426003)(2906002)(83380400001)(54906003)(2876002)(41300700001)(8936002)(70206006)(36860700001)(110136005)(5660300002)(4326008)(316002)(8676002)(70586007)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:23.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d6b83-d560-4512-c2da-08dbb39baef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

From: Edward Cree <ecree.xilinx@gmail.com>

net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
 currently contains only the wol_enabled field.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
RealTek and WangXun maintainers, I only CCed you on this patch rather than
 the whole series, to avoid spamming you with a discussion that's likely
 not to be relevant to you.  Hope that's okay.

 drivers/net/ethernet/realtek/r8169_main.c        | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 +-
 drivers/net/phy/phy.c                            | 2 +-
 drivers/net/phy/phy_device.c                     | 5 +++--
 drivers/net/phy/phylink.c                        | 2 +-
 include/linux/ethtool.h                          | 8 ++++++++
 include/linux/netdevice.h                        | 7 ++++---
 net/core/dev.c                                   | 4 ++++
 net/ethtool/ioctl.c                              | 2 +-
 net/ethtool/wol.c                                | 2 +-
 11 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..fe69416f2a93 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1455,7 +1455,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	if (tp->dash_type == RTL_DASH_NONE) {
 		rtl_set_d3_pll_down(tp, !wolopts);
-		tp->dev->wol_enabled = wolopts ? 1 : 0;
+		tp->dev->ethtool->wol_enabled = wolopts ? 1 : 0;
 	}
 }
 
@@ -5321,7 +5321,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
-		dev->wol_enabled = 1;
+		dev->ethtool->wol_enabled = 1;
 	}
 
 	jumbo_max = rtl_jumbo_max(tp);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index ec0e869e9aac..091ee3d3e74d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -34,9 +34,9 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2b431db6085a..6752f8d04d9c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -636,7 +636,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	if (wx->wol_hw_supported)
 		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
 
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index df54c137c5f5..6eeec338dfbf 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1283,7 +1283,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 		if (netdev) {
 			struct device *parent = netdev->dev.parent;
 
-			if (netdev->wol_enabled)
+			if (netdev->ethtool->wol_enabled)
 				pm_system_wakeup();
 			else if (device_may_wakeup(&netdev->dev))
 				pm_wakeup_dev_event(&netdev->dev, 0, true);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..62afc0424fbd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -285,7 +285,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!netdev)
 		goto out;
 
-	if (netdev->wol_enabled)
+	if (netdev->ethtool->wol_enabled)
 		return false;
 
 	/* As long as not all affected network drivers support the
@@ -1859,7 +1859,8 @@ int phy_suspend(struct phy_device *phydev)
 		return 0;
 
 	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = wol.wolopts ||
+			      (netdev && netdev->ethtool->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..b808ba1197c3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2172,7 +2172,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 {
 	ASSERT_RTNL();
 
-	if (mac_wol && (!pl->netdev || pl->netdev->wol_enabled)) {
+	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..8aeefc0b4e10 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -935,6 +935,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 				       const struct ethtool_link_ksettings *cmd,
 				       u32 *dev_speed, u8 *dev_duplex);
 
+/**
+ * struct ethtool_netdev_state - per-netdevice state for ethtool features
+ * @wol_enabled:	Wake-on-LAN is enabled
+ */
+struct ethtool_netdev_state {
+	unsigned		wol_enabled:1;
+};
+
 struct phy_device;
 struct phy_tdr_config;
 struct phy_plca_cfg;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..efedfac436ad 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,7 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct ethtool_netdev_state;
 
 typedef u32 xdp_features_t;
 
@@ -2011,8 +2012,6 @@ enum netdev_ml_priv_type {
  *			switch driver and used to set the phys state of the
  *			switch port.
  *
- *	@wol_enabled:	Wake-on-LAN is enabled
- *
  *	@threaded:	napi threaded mode is enabled
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2024,6 +2023,7 @@ enum netdev_ml_priv_type {
  *	@udp_tunnel_nic_info:	static structure describing the UDP tunnel
  *				offload capabilities of the device
  *	@udp_tunnel_nic:	UDP tunnel offload state
+ *	@ethtool:	ethtool related state
  *	@xdp_state:		stores info on attached XDP BPF programs
  *
  *	@nested_level:	Used as a parameter of spin_lock_nested() of
@@ -2383,7 +2383,6 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
@@ -2395,6 +2394,8 @@ struct net_device {
 	const struct udp_tunnel_nic_info	*udp_tunnel_nic_info;
 	struct udp_tunnel_nic	*udp_tunnel_nic;
 
+	struct ethtool_netdev_state *ethtool;
+
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..bb3841371349 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10747,6 +10747,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
+	if (!dev->ethtool)
+		goto free_all;
 
 	strcpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
@@ -10797,6 +10800,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..de78b24fffc9 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1461,7 +1461,7 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	if (ret)
 		return ret;
 
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF, NULL);
 
 	return 0;
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index 0ed56c9ac1bc..a39d8000d808 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -137,7 +137,7 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 	ret = dev->ethtool_ops->set_wol(dev, &wol);
 	if (ret)
 		return ret;
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	return 1;
 }
 

