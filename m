Return-Path: <netdev+bounces-36419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442087AFA9B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B165CB20954
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179215493;
	Wed, 27 Sep 2023 06:04:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661014294
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:04:43 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2914DE
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 23:04:40 -0700 (PDT)
X-QQ-mid: bizesmtp62t1695794620tda1fshl
Received: from wxdbg.localdomain.com ( [115.200.229.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 14:03:27 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2idI2DhiV5YDRLGF8Y1Yur29kk0twS+NJbfnhuEBKTutdeIVEiXSR
	KM3mbZbpZ7YYzbZ/sVJGWd/Emxjd5TZKPPASpAjqPJzBdEgic6q/Ey1U7zj2UV1yzZnhLwn
	FpJTKtDLNX+qRo39cB0zXPWmNN21W4kDA7fllPzcYLo87K2GB7/jyiwGw0aQozMtSvU3m95
	PMcF/79gTOYEg52ZVZXKJFAUUXhcTvk8KlIIe9jIUSslQjdehWXH6+lM/GINCgAx5C9Fzlh
	Jx6SDbkz4OSQWhE7HdoF6FTx693/GQE+jQFqgReyjFZd7tb+JliEVy6D9WBbM4+BdPWNSKo
	BvbqPd6SxYff+X3OEFIkZM1X7zaHOlp9aiUTJIRsKMltnCSXjg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9870957617687234272
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RESEND PATCH net-next v2 0/3] Wangxun ethtool stats
Date: Wed, 27 Sep 2023 14:14:54 +0800
Message-Id: <20230927061457.993277-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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


