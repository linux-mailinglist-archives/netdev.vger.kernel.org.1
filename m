Return-Path: <netdev+bounces-50009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E613F7F43E5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D381C20A14
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F6168AF;
	Wed, 22 Nov 2023 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88093
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:30:05 -0800 (PST)
X-QQ-mid: bizesmtp82t1700648811tllnrmbx
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 18:26:28 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: lP1Pu2Q8kTroYT+7n+oNNSVDiNb9MSPOnUwK+Yte7ch2EHt/FLQAFCFdIpcJh
	B5qNqZNrjMEvqdjOAW6wa3EfrarAHdB/919yL2oEicYuMg9xz8yUnqXkuprG4x9MXC0ZAN8
	iw4goptCPvCV0HjVym2mwpaPcgBqb6nChMWhXckB/a0/JubZOG2P+6gFNprc9mCCYV6YeP5
	8bJB+TVoa1A/tP/PllFc6TwqjYP/OZncoor6kX8JW7hqVHHAuaR33yseCtA08BTJHKxyWvy
	/2nKog/1lgMYoKNGbLHZtkE8T72MnMtMBumjHHKxhMQ8nOpiX/IZ0djl2ImaAtUmTW+VA1H
	r+k8AaZ5fpKaKMt5a5LmRc1BVpEL2MS6aPpMQ3Oy7lkUtZCou8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9208755753975401940
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/5] Implement more ethtool_ops for Wangxun
Date: Wed, 22 Nov 2023 18:22:21 +0800
Message-Id: <20231122102226.986265-1-jiawenwu@trustnetic.com>
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

Provide ethtool functions to operate pause param, ring param, coalesce
channel number and msglevel, for driver txgbe/ngbe.

This patch set needs to be applied base on commit 8ba2c459668c, which
was applied to upstream netdev/net.

Jiawen Wu (5):
  net: wangxun: add flow control support
  net: wangxun: add ethtool_ops for ring parameters
  net: wangxun: add coalesce options support
  net: wangxun: add ethtool_ops for channel number
  net: wangxun: add ethtool_ops for msglevel

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 200 +++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  18 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 280 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  99 ++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  75 ++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 101 +++++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  64 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  84 ++++++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  47 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   4 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   5 +
 15 files changed, 953 insertions(+), 34 deletions(-)

-- 
2.27.0


