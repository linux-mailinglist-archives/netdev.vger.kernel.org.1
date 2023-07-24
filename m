Return-Path: <netdev+bounces-20284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C875EF16
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0A21C20916
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC66FDD;
	Mon, 24 Jul 2023 09:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B96FD0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:26:16 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910A122
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:26:12 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690190762tm8q600v
Received: from localhost.localdomain ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 17:26:00 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: RrZlkntZBfmNHGYSiNU1ffJfJ6PGtic3Fm7B6sBLjciq+QX4PRG8YkFMh637n
	n+MwkqT3kH6FUmf+4MWiBimsg24eAeKJ4o2ESvfZC1cmBxs/4ODWS3BT0aLdEMI1lr/2H0R
	al31g6PYUnrs0jjC1jkhvgB8cqgt+bcfKtWAzTnyM/UwUhVUKDZJNnwzYR/BwA6GiEgyXdQ
	ajeLe91WeL7hbi9pOINmbsaqz+loyCZC8oeB1TtDFv6OwUpGuduXzfAcSH3vcXk9y7z6Z1F
	g7sVhyxVzX6zopBtcEe5c5sMcYfCdnP6+HA+x8dOOsfIV9l/k8Yt0gpj7mOO5EtdknMRlIc
	FSbzIKPVWPtAYrh2wA3J7VCB8srE9D/WNYXOI161sPUoZeDzePl8FqRMJXeHp4wcadyRozQ
	UQmxHHpgM3g=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14770940883638647669
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for wangxun nics
Date: Mon, 24 Jul 2023 17:24:58 +0800
Message-ID: <6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092544.73531-1-mengyuanlou@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ncsi_enabled flag to struct netdev to indicate wangxun
nics which support NCSI.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 5 +++--
 include/linux/netdevice.h                     | 3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 1de88a33a698..1b932e66044e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -851,7 +851,7 @@ struct wx {
 	struct phy_device *phydev;
 
 	bool wol_hw_supported;
-	bool ncsi_enabled;
+	bool ncsi_hw_supported;
 	bool gpio_ctrl;
 	raw_spinlock_t gpio_lock;
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2b431db6085a..e42e4dd26700 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -63,8 +63,8 @@ static void ngbe_init_type_code(struct wx *wx)
 		       em_mac_type_mdi;
 
 	wx->wol_hw_supported = (wol_mask == NGBE_WOL_SUP) ? 1 : 0;
-	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
-			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
+	wx->ncsi_hw_supported = (ncsi_mask == NGBE_NCSI_MASK ||
+				 type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
 
 	switch (type_mask) {
 	case NGBE_SUBID_LY_YT8521S_SFP:
@@ -639,6 +639,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	netdev->wol_enabled = !!(wx->wol);
 	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
+	netdev->ncsi_enabled = wx->ncsi_hw_supported;
 
 	/* Save off EEPROM version number and Option Rom version which
 	 * together make a unique identify for the eeprom
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..dfa14e4c8e95 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2024,6 +2024,8 @@ enum netdev_ml_priv_type {
  *
  *	@wol_enabled:	Wake-on-LAN is enabled
  *
+ *	@ncsi_enabled:	NCSI is enabled.
+ *
  *	@threaded:	napi threaded mode is enabled
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2393,6 +2395,7 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	unsigned		wol_enabled:1;
+	unsigned		ncsi_enabled:1;
 	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
-- 
2.41.0


