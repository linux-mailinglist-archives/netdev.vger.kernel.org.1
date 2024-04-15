Return-Path: <netdev+bounces-87869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262208A4D38
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C1D286106
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01F5F54D;
	Mon, 15 Apr 2024 11:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7C5D468
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178978; cv=none; b=jBast199c005cW85tp+RJ1aC9bj/YQn/spcsSnOAeinr8FlTAANuIMQZJ5kQq1dimkse88PrpqxdY7JszbQKKwhiwZ3DcYf8vg0I43Wh5J91jgaX1m/EAKkO1WhEq1MseTWF9pynYi1PZI9ZATyDwp2dFlyk0BUCfWJWkvTygbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178978; c=relaxed/simple;
	bh=fY4EIJfgGvDNcjeGN/7+X9oM9hFei2Hdzdm7C6hXxgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxlUrbK7sdJEHpwdzWXhsakycPuHQrTpyXZecPf9QbVQmWRQt5BgKUVDvESVPilgRci6vlEKYO9/DoFYAOmIwh2teafK8mwyf8mivNPLdhYEKvoGHPaP9QMDhe+ya3OP3r7aKd4wgfFpjmZvbj+FcNS83g4ST2RB005MedyEQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1713178956tkfpy52g
X-QQ-Originating-IP: e53xHj6S/Dyv5AT+Xj26+zVWDVVWZNWoo07Xttr0RwQ=
Received: from localhost.localdomain ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Apr 2024 19:02:28 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: U7OmrCiPqqBDz/1N1026Fce1Ufo3jhAE1G2bGDtDWQHQhzX1DhLvtl/w+auRZ
	AGYXG/YjeowMNnZ7rey6/brQpytAafXsB5N6LFS3nzqSZxiT05OhfB3Lh28j3bogrF98Fjn
	SWBSdVIAWpWh+aXhGOQidjkTlHWhYmnkeLf9QI2XgsLmWsl834RhXRzr11eSAvIsT5Vg1+8
	Bpdw/lyY8NUiDPx+ytS1JjKbEJ8w8f/yaCxgtFQt/XAGAoSkEZ/BvkC6kJjz68GThclAUJZ
	lhqiuxKbEHyMlmN84//7VUy4N1tY5jBj5iZ89DGQfWVK3D98Y32KidxCfC/wg8XE+f8s6yX
	3t5dLB27oB/lyiWg+L6OzfVeWmLLN86KlltzAu5/aZSdXuCqrv/NTxjoo/TmCkqJRHNoFUL
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13657347810442050165
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
Date: Mon, 15 Apr 2024 18:54:27 +0800
Message-ID: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
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
Add ping_vf for wx_pf to tell vfs about pf link change.

changes v3:
- Jakub Kicinski
Do not accept any new implementations of the old SR-IOV API.
So remove ndo_vf_xxx in these patches.
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
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  310 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  146 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   |  191 +++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 1052 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   99 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   58 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   25 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   24 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |    4 +-
 16 files changed, 2006 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.43.2


