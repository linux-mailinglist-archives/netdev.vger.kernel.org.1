Return-Path: <netdev+bounces-20359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC275F27F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBFA2814F9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42679F1;
	Mon, 24 Jul 2023 10:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23279C2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:15:47 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF47DAF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:15:32 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193667tszm7na8
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:16 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: rZJGTgY0+YOdRcfEfIzdLCTOZgYrOe725GMQZwyyC5tlZzzf0UsA012cgwYc6
	1A4nsu6w7aB4B2775DYUYg/Qe3cP4o8rwPrp0omNAMyBRsXNeGKEq559PFkJxRsj/veGYEl
	epLN+Y5F/mgNDE1lp0Xs0VbdcXjES/B73Gh5M6svzScFt1X/onkcmMs4XLquopxnio9aSSa
	an/YTTJraMix/OVB8/cIBlpmpnXQKNcv3Cf1pHuHM3jfvaqt6SVq2W4HyUed4wocssLXFoh
	WUWVB6xbhnc0SSP2o3sms+YDm76aEW7ZOZfRKkwR+h5g7pdSSxtrGfY4WxTPd9nZgUDsOmD
	ZgmUaLed+jvDI9fRcqDgSOH388Zt8KOlfahAiUbHyNMvWK8QWc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9923941857596505948
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/7] support more link mode for TXGBE
Date: Mon, 24 Jul 2023 18:23:34 +0800
Message-Id: <20230724102341.10401-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are three new interface mode support for Wangxun 10Gb NICs:
1000BASE-X, SGMII and XAUI.

Specific configurations are added to XPCS. And external PHY attaching
is added for copper NICs. 

Jiawen Wu (7):
  net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
  net: pcs: xpcs: support to switch mode for Wangxun NICs
  net: pcs: xpcs: add 1000BASE-X AN interrupt support
  net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
  net: txgbe: support switching mode to 1000BASE-X and SGMII
  net: txgbe: support copper NIC with external PHY
  net: ngbe: move mdio access registers to wxlib

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  28 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  84 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 --
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   9 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  41 +++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  83 ++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 191 +++++++++++++++++-
 drivers/net/pcs/Makefile                      |   2 +-
 drivers/net/pcs/pcs-xpcs-wx.c                 | 190 +++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  85 +++++++-
 drivers/net/pcs/pcs-xpcs.h                    |  16 ++
 include/linux/pcs/pcs-xpcs.h                  |   3 +
 15 files changed, 662 insertions(+), 93 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-wx.c

-- 
2.27.0


