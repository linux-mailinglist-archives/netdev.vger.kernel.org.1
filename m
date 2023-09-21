Return-Path: <netdev+bounces-35370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB827A9137
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF78B2098A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A931FC5;
	Thu, 21 Sep 2023 03:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04B1C05
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:19:58 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1FF4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:19:56 -0700 (PDT)
X-QQ-mid: bizesmtp89t1695266339twm9ab1b
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Sep 2023 11:18:58 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3i6xiiU4p2dDyb2l7mk/3SQUESKav7+3uBUKW7Gm/lPkAfJpVzkE
	pP8tOnJdc+pZREWiocR/BeS4WXBDFOYsBYiVJcFV5qkJlWBiC9nHZP/KS1BXO/w5SFWgkBW
	cZ8O890xv5WAZkW6x2MbJ2O5ishBk6X60mY1e7KJ0l0BbI3CqKBk1E4Bh/rVojzOVuMco1t
	pM5CPR+hkf8WPa5coeX+FREdV5MRUl7MbrzqKmeHDeIli1MQmSytv74KKWXvabOourdLa/J
	2GqDM8PD/axw3pM7T9RckEGbAjg9PYU+2gVnucOXOyn+7RL/KFpkArYbf4E4bPOfLX/vyIH
	7ri03+BzdAgoPP3Sg99bo6tiUI2LNlXz6gDBp+NhXPlFMwoGUxcJbRNrY0He9JwkXtcu+sT
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17669601877561668245
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/3] net: ngbe: add ethtool stats support
Date: Thu, 21 Sep 2023 11:30:20 +0800
Message-Id: <20230921033020.853040-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230921033020.853040-1-jiawenwu@trustnetic.com>
References: <20230921033020.853040-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c      | 2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index ec0e869e9aac..1ab6efd993dc 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -49,6 +49,9 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_wol		= ngbe_get_wol,
 	.set_wol		= ngbe_set_wol,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
index 6562a2de9527..6459bc1d7c22 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
@@ -85,6 +85,8 @@ int ngbe_reset_hw(struct wx *wx)
 	}
 	ngbe_reset_misc(wx);
 
+	wx_clear_hw_cntrs(wx);
+
 	/* Store the permanent mac address */
 	wx_get_mac_addr(wx, wx->mac.perm_addr);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2b431db6085a..652e6576e36a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -332,6 +332,8 @@ static void ngbe_disable_device(struct wx *wx)
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
+
+	wx_update_stats(wx);
 }
 
 static void ngbe_down(struct wx *wx)
-- 
2.27.0


