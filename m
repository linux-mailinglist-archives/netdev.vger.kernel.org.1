Return-Path: <netdev+bounces-96514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5F8C64C8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF21C224A0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6F39855;
	Wed, 15 May 2024 10:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2575EE67
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767738; cv=none; b=DKOjUc87lxcNkTbCkgIVAt4LlwRAGKFa5Xfxq0Ybpq/COzRFbwwH4XizbragfaO04kVP0Nm894Ua594sWBzKi0xxCYvJio+tWnRT8W91ohAkH8ld0kvDkDvuFxu30bDiwWHMcitI2cQNleqtikHqCA8kkaq5ym5oR5zUYVsdlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767738; c=relaxed/simple;
	bh=Di9Kim94ygb02301djPn7hMJ8KvPpbwvRiFwX8Eb5xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu18G3mroRP3ugo/HTjSM1SlcPy9y8gmsa+5tTnyEb+TDVmHQaES5SaVWk+9V2GyDYEC6ym75cefxAjul4jLah8ao6G2LzwAAQt4DOcW/NuCxweGrnl1iyRtLBdCT21HxQ3zjFf+IZ5a3vHqtyG7oO+JxW9s5g5vUcfXvV035mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp80t1715767721tw9194m8
X-QQ-Originating-IP: xgmsRMiO+JeID2kETMK+72w/pl1iHnbPF23WLKPaGT8=
Received: from localhost.localdomain ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 May 2024 18:08:32 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: lD1qCo/DrEAUFgJp4e+urXIvlMvW1qKiIrysgCEGqI1mqqp5Lxyu4v3BxDvGR
	jRHGq0SZCh+2X0alI/mS7N8LGiN/15zkGrXeavdKynY4KCP2By+xaY52HpCj54ZIfUaXM22
	/gotVwx5blvepQTTyosRQbUNNI/plVLMg/WJRfMlq3N3ABDFIju4TlMG2hGGgza2Zp+c/A3
	1/hXFXeU8RU3lWc85GZzzgJNwcCJ29ZmHo/NiDwEcnU2qrTQNALfSOKR4nWaFuz5oX8hOhJ
	UfIJqIbXyCxXaOoQk3o4n1ve4fAA3HpRFUiApyDUUbHid/Ki7jja5GiTqlXayJPTpPXVrva
	8HrKKabwUATenJp3X33teHAqjnG2gpoVRtZjID6PxGoFUOuoQmKwhA04B9wJuxw7LyAQ1Kh
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6619159292630094861
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
Date: Wed, 15 May 2024 17:50:03 +0800
Message-ID: <A621A96B7D9B15C2+20240515100830.32920-1-mengyuanlou@net-swift.com>
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
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  310 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  146 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   |  191 +++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 1053 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   99 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   58 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   25 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   24 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |    8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |    4 +-
 16 files changed, 2007 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.43.2


