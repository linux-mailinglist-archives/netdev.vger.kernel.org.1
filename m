Return-Path: <netdev+bounces-163481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7294A2A5F3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6F31684F9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DF22686F;
	Thu,  6 Feb 2025 10:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1609227564
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838329; cv=none; b=TIiA5sqeYZ47GdJAVPXv65O9dHs4frlZgoSd4H/nrIoHsBpR6IaMLnJsBwRkB2LTRx741O/pDVjnUugarwg2KJPDnD0l9KnuPNUTIaw5ZA+/nkSCtiGbjK3DiZLdyJyuVHRu0bvyrI+qP8zhFfyy0J3UMSQ8nIIvNUCDszYY5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838329; c=relaxed/simple;
	bh=59h5wNvqwviamIezb7wJOjfQ4cmQZNkm1n16qqncH+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lArx13+xSRY1/HJ60q+lW1j+DoG0qCWeQt5u+klVCFRXHGXAkrIXA4cC1gIXYmNy3fqa4pKGOxDJh6soWvAVv5JYfjCISOoAFpNkKFgVbn2rGh+rAv4sreS/BHNkZe7Df5PaliGxruuqX+/YjJAP5AKxbo0QjrErtm3YoA4z15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp78t1738838300tyhdgzcq
X-QQ-Originating-IP: MtgUZETw2DuNxPgrGjdLvHUOi7psYUyfCknyO64CTv0=
Received: from localhost.localdomain ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Feb 2025 18:38:11 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13025582969971203647
From: mengyuanlou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 0/6] add sriov support for wangxun NICs
Date: Thu,  6 Feb 2025 18:37:44 +0800
Message-Id: <20250206103750.36064-1-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: M/ESU50hZOEXfozV5Ep9gnde+oO3yPEMzlZrF0fJ3iD7vGdy1Fp6X0Xm
	Io3WaP+aeRdZLWp90mCSsymvwkpo+Gh5/ZIrIVXeJ9o3b38ioBmucJEVa0Mb4l2F8O7E2Fq
	o2wQchD9UEj5v65DsCZFT6Sjadi8aRmhecMFVDZcvDw5jS0gZOyARdJVydY4HFk5V1DHlu8
	esTAEYpIZCnIaTC6/TO5scIlesLpJL+khzSY3/pX4quTumtXmr4k9cGflZftCmf8+XLi1B7
	3wTojUg4oziOoZ3JH00KOPcaTxU9zgR4TTI/U5yP/PlHGyDsQKxTcef1qGFvqKfhlIRRJ3a
	jxV/b+VKiLcc06IqYR/MWlCXMpcKHJPhaHEgDHwST1rFmMPytqjPpAzWNtkMJKDJy5clOBJ
	UYpsvjmmh5YFV0pyqByPbG3UJTlvqXGPNt2FmXKBLyGEdUTqyMsq6KVnHFskosz0t7eeEeO
	+anEof4YbQoYXByCbp8vxeO30WROwJzSjFaguuKqZzBus9MP4R4oFFwk9FjpO5maCrQ4dqX
	Sqn+oovvyhSJwCVLXf63DFGNQ/K1fQpTF/0pCrm1ojKuaxVRTCP2TCPz8zsX07IF/0EW4yF
	PC11bqAr8+k/HXkdAlpGu8N1MS3SyrX5+PSjGRwFVSKcmP22UaZw6+d5c0megx83HKIZw9P
	qGNpxLt4GuLrC14CYlML5fN1ezM3QoA8kCbuOMpDyIrxK3ttIbYr8+1XcHKHLz41Yca6i+M
	LuRZsQPhQbxVjLKaLRBwTAnLwlDH5oCrGRJNBLBltxJAkxW2fz5nV6yABJxRFxarKZNoFDt
	O03CeEzXl+Nw42EYyirJIuusFoEsSvXpABVI+veYZ14WUyh/IfwDpYUWTsiEg67Crf55LeZ
	8xHpyz0B3Kk9pW2Nh0TOmjcYjUyn08ebGPAmYcgye69TbgpuuL9lfkKcybJwWwuYEsnlnRe
	257khL6W7fMh/7E7ZWWrxMZetKRt60NRXkOJDvlrNc7MGRkx9vCS4zDuIoqQ7XtxWn8TAEt
	rV079pA8f+7vW3R2RB
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

From: Mengyuan Lou <mengyuanlou@net-swift.com>

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.
Do not add uAPIs for in these patches, since the legacy APIs ndo_set_vf_*
callbacks are considered frozen. And new apis are being replanned.

v7: https://lore.kernel.org/netdev/20250110102705.21846-1-mengyuanlou@net-swift.com/
- Use pci_sriov_set_totalvfs instead of checking the limit manually.
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
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 940 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  91 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  62 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  28 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
 16 files changed, 1851 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.30.1 (Apple Git-130)


