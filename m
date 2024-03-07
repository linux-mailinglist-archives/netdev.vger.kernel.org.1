Return-Path: <netdev+bounces-78340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F83874BBC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3668C284DA6
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F738527A;
	Thu,  7 Mar 2024 09:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014085267
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805502; cv=none; b=BH2h0sqLyukiLGt3ncJV5Zqn9XZfhYtL9FClZ7YRXU4fqL6euqTr4X1bPyharU3GmIiGAuNKzIeGGJ9s8NsFqPyB/1bMfdOL+i8uMSCT3K1yQyepkyi1vpHwfnMR/YIo/p9EGrFm2vliDGjAURRjV8sUfLU9ooGhqbMQSkCBF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805502; c=relaxed/simple;
	bh=Qyh+h4jhi9Lhsya4hOv3cUPrixqn3zOUzE7Q/Rch0Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRbk/UfPUOX8PY+rB/wFKIDpRlAi8DSzQIlMyY//NqoGlVpvBBiGiV3sV1Ux6Eo3zOmonQnA/jZiYA2kgB7e5BigTgkz2SwGkAbwBezxuj/evnA/OokH8KHJ8O9NMs3XxZEqw7WeRS/Gf4S1i81+hHC0nYk8wX7uLkfx22X32OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1709805485t1afzgrf
X-QQ-Originating-IP: VSClAvOlVRVxC8vtvM0bAmz4z3qvGROgn+xEiBkrSI8=
Received: from localhost.localdomain ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 17:57:57 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: IcCSTr/hHjMoU0QmD2ljNxKpgqeYrbEP4XjV3Sx4zYNYeTVaJy4vlcRmhF+jQ
	v7raCrDEmSyABpk0MGrA+71VgnZlZ57Nv165gW7maLHWGUwZw6Vbz12o3nGdLAHzbqY4uTt
	O4CSngzq5p4vQZqle8I3p2lquDrIEusPZAgyiliJFvdRTbC5Ztx93t2uOmDq35GsA+w7lPq
	sOvPr/5OdxYuM3EvR4QV3BB4P7R3IQo1KPePJ5AbC6CRliYGwcXFIFJTo3sVLyWh0MF98zy
	4O6QDPzEcsGIjm3e3wkHmXJsChY2XhP81omjeo8JVoX2csnhe3AzGVhs3rudbG46AnxYVpY
	Y+Od4dWvOL7J04j4+sZZY9TiYqGQvJsVUrS5+C778bRGBR8W5psKOYnGASHqh90iW1TWSbi
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8886319570888759429
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 0/5] add sriov support for wangxun NICs
Date: Thu,  7 Mar 2024 17:54:55 +0800
Message-ID: <DA3033FE3CCBBB84+20240307095755.7130-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add wx_ping_vf for wx_pf to tell vfs about pf link change.

Mengyuan Lou (5):
  net: libwx: Add malibox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Add msg task api
  net: ngbe: add sriov ops support
  net: txgbe: add sriov ops support

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  312 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    6 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  149 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   |  190 +++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 1103 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   16 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  111 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   60 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   25 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   26 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |    4 +-
 16 files changed, 2078 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.43.2


