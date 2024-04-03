Return-Path: <netdev+bounces-84340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C79896A7D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28B91C24E76
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621473164;
	Wed,  3 Apr 2024 09:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B01130A64
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136464; cv=none; b=fZiEyUAz0bPcFIOiUNnJiCfn+YvKvPJx8yskT5JBPC5EVkYrXZmA28xYvJH3+5EbxDsCOLmSOhVvG+3gyRSGn0BzpbSFYDvTKU+7W/08pqhxDXMqk2k1aFLTrkztjCzfrKUzm4/G4dMWXy0qmBWh8Gl3FRRyCj8u9BvtvzSQpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136464; c=relaxed/simple;
	bh=uec4ow18waH5M96ioU8VUfQCXlDums/zztG2E9HoQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X38ue89pJRbJwy3EfD+9f/2kkQ4HKhpa8om8FHTSNLO8Zb7g26Z9cfKp7VbLM9EEHJvhGA44Q2rwogmcphcz4fp5wgkoPM6tfiy2K/ERJN4Ylrm2ZLe3uYedXDpIAm9+kNqVs/u43wjBfbB1YURB2LCr13IECWUoXU8Wqrsuoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136447to25xxo
X-QQ-Originating-IP: v3mObkiEjAbS4yRONsAtMVFiN9t5G6rw1jBdvifScnw=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:17 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: qcKkmz/zJhyozaVVHuszywMoYIUOG8nvNjDAGVbTM0FVQALAIXLxFS/h5Ifyk
	dHkn0I+VRDcyphPAIfPgI4soypZUq6JxWtjtLFxLVJDwSPxY/ieP/Jn8NuFB8NAFAejgR+6
	KentiBmfxeMR8B5L0PwDLrluQtwquYjGZq6A6GEvA5589XA7SLZnmYoiMSK6WqrpXquhmwU
	t8BcHWa+19lzT4NYm1nCexvMUrqdK0U9Orx/rlqKk/Y6tza5NG85a2sjQt5KepQiZPytyt1
	v2PkmYFaCsCxj99OxqOo4FnasQXze4X4e2DfT6g92QUU8MzVhwfS3bJSeZThuzQE77yGOWV
	t1KKtHdt9Eo56D2skjG1u9F/6h1ikrVhAovebVOyS4Zc6Cx10BTtvNf6jmHkw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10791282922348215057
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 0/7] add sriov support for wangxun NICs
Date: Wed,  3 Apr 2024 17:09:57 +0800
Message-ID: <EF19E603F7CCA7B9+20240403092714.3027-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
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

changes v2:
- Simon Horman:
Fix some used uninitialised.
- Sunil:
Use poll + yield with delay instead of busy poll of 10 times
in mbx_lock obtain.
Split ndo_vf_xxx , msg_task and flow into separate patches.

Mengyuan Lou (7):
  net: libwx: Add malibox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Implement basic funcs for vf setting
  net: libwx: Redesign flow when sriov is enabled
  net: libwx: Add msg task func
  net: ngbe: add sriov function support
  net: txgbe: add sriov function support

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  289 +++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    3 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  146 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   |  191 +++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 1244 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  100 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   63 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   25 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   29 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |    4 +-
 16 files changed, 2192 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.43.2


