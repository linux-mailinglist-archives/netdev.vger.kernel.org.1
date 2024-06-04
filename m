Return-Path: <netdev+bounces-100663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27678FB83D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0E287F16
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B46143C57;
	Tue,  4 Jun 2024 15:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4C3236
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516775; cv=none; b=Xb13pWIC0TWk++G9GrgkXwp9ivVSGlurCnoF7E8CIKhIkguqkVGdKwA5UWc2lyPg99XMqLxU1kVS59Bfip1iVf1JWnHKVoCpjfvYr/4kpHZjLIlpoKiAm1Vg9HUvAY/QbJVKtvCYuG7FWVCPeq2exyqhP55gqvY9k3aq0PWS2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516775; c=relaxed/simple;
	bh=JmkKluK2nPyggOtikScNuEu/x1ZYYg+uIz8F6RWR+wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKWQKEVFlD6tFvOwmBStDgx4Hpc3SHezZVZmRjXRX/4g+3Efc+/MRYEH3iOQDueZvwOW51E/By+QaqzXm6i5SR9oaMATwK1IOlfsrmpPCfl+zO69uGwM40vBCBAczTGk5BMVbob31Zhbn4uS+8cen4ERqzyZgQ9JOWJ6pbxelcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz11t1717516744te3drf
X-QQ-Originating-IP: yq/OgEuEtxlWwez9srdBEq6KKI76DxE7PyUwVqeYR04=
Received: from localhost.localdomain ( [183.159.105.13])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Jun 2024 23:59:02 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: +WrvfoOeDZFCp9frH3FvyccD2jnPxPw/khgfUtYUGBX8E3PJy+OJPchEkQSfC
	drKw/kD27ev0wPwIe49drkA3gM0PX1tjHPrlGlirlXMBEmqv20onaVt6A4muwavufPNgqpp
	0HmLbOZICxeVyYHdx8cKcGeIKDKmAk3H3HlW/Ae2Cq0130P9vfZbyiOjiBDRIlLz1u92C7y
	UVmXuzTMtIF+vk/TTFnB2rCofl2NsQ3gX8IEOzTd0AZ6IxIUOHkvJEp9ixaZGGPKZMC93V1
	fo0MDmvmO6Jl21rFttaEZmrwcgFohQ6Ruwg5EDEAGoQEJbhbb0JN2XfVEeRk0TYq6OQkoPG
	/RM0lyftNyXGh5thK/VjqSUdLoUNiSVHFj6b6I4E/hr6Yg/hioXsFzBSyyo1pzRSksmd6Fx
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17214444337160681332
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4 0/6] add sriov support for wangxun NICs
Date: Tue,  4 Jun 2024 23:57:29 +0800
Message-ID: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.

changes v4:
- Simon Horman
Move wx_ping_vf to patch 6.
Modify return section format in Kernel docs.
changes v3:
- Jakub Kicinski
Do not accept any new implementations of the old SR-IOV API.
So remove ndo_vf_xxx in these patches. Switch mode ops will be added
in vf driver which will be submitted later.
changes v2:
- Simon Horman:
Fix some used uninitialised.
- Sunil:
Use poll + yield with delay instead of busy poll of 10 times
in mbx_lock obtain.
Split ndo_vf_xxx , msg_task and flow into separate patches.

Mengyuan Lou (6):
  net: libwx: Add malibox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Redesign flow when sriov is enabled
  net: libwx: Add msg task func
  net: ngbe: add sriov function support
  net: txgbe: add sriov function support

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  303 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  129 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   |  189 +++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 1019 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  100 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   58 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   25 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   23 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |    4 +-
 16 files changed, 1947 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.44.0


