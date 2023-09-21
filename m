Return-Path: <netdev+bounces-35373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645657A9148
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FC31C20843
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8541C04;
	Thu, 21 Sep 2023 03:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3E17FC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:22:13 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B154F4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:21:54 -0700 (PDT)
X-QQ-mid: bizesmtp89t1695266329tme0njo5
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Sep 2023 11:18:37 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKZLgoN65m8albtJQQTDL8FW27siy5eI+WwnHigm96Duqs385/MBj
	tg63vj2zL06gOq3767K8Xqu08gIl2K8SAZ5rsmqw1BAqAUL4THhNPJB2l1lY/ok+doJ+iR7
	fsM4lfdnwKNJu6k84cUIcyfQj6Bihu/NCDlRzUBtyjHvTJBFNjoo+zoy8Z9CxksHXrmjPS6
	cEdczrlzj6pwopxRMUZT9GYRF26d/1+xUyORcif/UxvH6rT33uu40PEoyOJmMq5yLNkL7qV
	QIxFARO6qR9XeK8TlIxe+UYVBJYpsx+hGpJggYA6+d61pQjwSGMry6GsM5Cfzvdql/Gy1Ax
	gv4q2PHvqKGk0a6CDok7pcLDfuaYHv1tzOTm2xt
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16416101193234924796
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/3] Wangxun ethtool stats
Date: Thu, 21 Sep 2023 11:30:17 +0800
Message-Id: <20230921033020.853040-1-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool stats for txgbe/ngbe.

v1 -> v2:
- change struct wx_stats member types
- use ethtool_sprintf()

Jiawen Wu (3):
  net: libwx: support hardware statistics
  net: txgbe: add ethtool stats support
  net: ngbe: add ethtool stats support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 191 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 116 +++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  11 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  80 ++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c   |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   2 +
 12 files changed, 416 insertions(+), 2 deletions(-)

-- 
2.27.0


