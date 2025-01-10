Return-Path: <netdev+bounces-157082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9BA08DF8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883D61689E1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB820B7E8;
	Fri, 10 Jan 2025 10:27:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3620B206
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504863; cv=none; b=V86NkE20z7ilYbEvhAV+INdlWvN+jQVOzU+Pqdyr4elGf+pV9jJIQvIDZ0yrQzCPLrCuXYpCgrzHfD6J1uokJEDRXSomhxVimUB44faA4quCPgrqDWhk5+iHryv3BzT+CsO4WtvewEWr5WPedKaJZDaqq4mcPgkX2/++tmUx2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504863; c=relaxed/simple;
	bh=HUBASi5qmpFMRJ5K4V3ZdmefUFV5IGgl5SgJKacRx+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCmQEHALfFvGSzruH45F9OIT9nnEnP4nN1EcjJ/XE1q91mXHz+b8KVCbBbv/ilrTKqX7gnb96BNFz5xy4WFa8Vxeso/35udX1K8Y0w8mke+qxhpdTbbExIDntWPi7Wl3gVp7gtBp9Lgfz+/lcIAG5l8F6uqznaBxKs9LE1NxvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp84t1736504839tf7fakw8
X-QQ-Originating-IP: bsg43/1tQqHTrpmYsGZWsUjjr3lmROGs4y7GslhFU3s=
Received: from localhost.localdomain ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 18:27:08 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15856102596575033888
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: helgaas@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 0/6] add sriov support for wangxun NICs
Date: Fri, 10 Jan 2025 18:26:59 +0800
Message-Id: <20250110102705.21846-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MfQnJH+7WKv6uiej8+8+ZZY/UsH0kzqOLCKD1Vf7nQs05Y2KRzT8eVcM
	AXlRFSE1M8c0HIrhvAhmyqX8SYuDp7bKhrZ4xYYB2URYDF6X05SeCbHGjnfBGKqhAF0TLe/
	UwZdmJQGdMZh4X+Iq6HOQmQlbxbPyRXtSLv6QX75hWgLSol22wwT1seasWS5Spnr8itlWW7
	gu6vxdXOtwPNVuF03JeTmz3ytWMUW17JDBSs2x5ZkO/MormcxZEOa6efsB/A2Nu4DU4kZqp
	VYxMky4h+MLViG5SdawsbGXSnO9BIOT+Z4o/MVn8FqIXFElMQiBO8j6Z2mDJNuUuZ+3459/
	kYRh/cYOM5G44uPlZgmvbK68lgiNJPyTs7vmB7rlAAM04i2RmJELUokT/KjK3CslvtpW1xc
	iguuFTrixoQU4OOyCFaVXaIkh9LGPWf3HoAMrP1OEGZjUb4+warM659WBjbCtG6k+v+XXGP
	FiD0mkIfVW8y4HiR+x5+uB9rcPmGVB2XsojoCpBLQnHR7aL0P2Owuc9nxOjrTDxqgFGc4h+
	EPQMnGLZ81OpCut6Klfju3bYPVQ+MrpDi9/w9Q2HM3mprzQyCfDllIm3t4an/qqcng7GDIU
	kvvNZ1QouHJ3N+XdXKMmf9mJa0A+JHu6ZPxVbk0yFJp2Yu5mXVLS17c7eWwHYJB5J2e0ydg
	hZ/HnlW0y50JNKhtcGldPKXP3xUylwi3NkV2RbjRWRIyPgivAg4VdnoNb1EESOLf6+Cz6Tr
	mG3auppeag0uXYcpCZWnbDmcUKo0wCp7sxyKYopJdV7zQ65G75vgG0jN5cIOzICtmD/NiSt
	ndVC0ydkB4zTsyoXUBfdJjoAcgY3ZEgg2kTw6dMob9HvQyeQg5IFThzfu5hG+8gdOdmA5lN
	aNyJtwXO9pQKVRHC6wOpvLg7FubKiFeCHXresY2/MsbvxUVAjrS/fhswXyD9Ru55txxVfK4
	RJfJMT4UWoRtzUzK3HMQ9vJFlNR1TzN48A5dnk/6mI1Vr4GVDfPU5b2x36rPyHV23kp5Cfb
	B9xtrHFg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.
Do not add uAPIs for in these patches, since the legacy APIs ndo_set_vf_*
callbacks are considered frozen. And new apis are being replanned.

v6: https://lore.kernel.org/netdev/598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com/
- Remove devlink allocation and PF/VF devlink port creation in these patches.
v5:
- Add devlink allocation which will be used to add uAPI.
- Remove unused EXPORT_SYMBOL.
- Unify some functions return styles in patch 1/4.
- Make the code line less than 80 columns.
v4: https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com/
- Move wx_ping_vf to patch 6.
- Modify return section format in Kernel docs.
v3: https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com/
- Do not accept any new implementations of the old SR-IOV API.
- So remove ndo_vf_xxx in these patches. Switch mode ops will be added
- in vf driver which will be submitted later.
v2: https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-mengyuanlou@net-swift.com/
- Fix some used uninitialised.
- Use poll + yield with delay instead of busy poll of 10 times in mbx_lock obtain.
- Split msg_task and flow into separate patches.
v1: https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-mengyuanlou@net-swift.com/

Mengyuan Lou (6):
  net: libwx: Add malibox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Redesign flow when sriov is enabled
  net: libwx: Add msg task func
  net: ngbe: add sriov function support
  net: txgbe: add sriov function support

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 301 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 128 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 176 ++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 955 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  91 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  58 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  23 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   5 +-
 16 files changed, 1855 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.30.1 (Apple Git-130)


