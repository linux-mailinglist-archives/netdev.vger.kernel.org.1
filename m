Return-Path: <netdev+bounces-173319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C135A5856F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1691690A7
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC251DE880;
	Sun,  9 Mar 2025 15:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83661DE3B3
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535025; cv=none; b=BW92cRmyiNXQj8QTVrihyThIIHqJvlvPOG/SHLLhlBWGiHMRPymNqhedGH/vNMQutr3Xfi3J8tIFdwd1w0hnsdxuEep5KSAXBhnkHb0BSnqngKQI5O1M8qKAQGVJv57gucpLBvATiT53gEVK8+lUwGKpMNIKyUlSv8GKdGL+9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535025; c=relaxed/simple;
	bh=kp09IXKP6RSmcsBiVvSJaSF/c+XcK3Zy7fFlpA4tCl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltebMD85OkS6tXBZCzLobXIVGAINinE9RJEClKLtTldskJ83I0zZHBYmRUCElP93iyPxFbE5ZOUeelcEn14kJzP1rvx53ycROt/PQACe+Th0OSGt90NoEscVVDclMC6TLy9nIyKG7utI8jq+jJIfZhltnSJ4EZgHvFuO8lGMyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz5t1741534987tr4i4q3
X-QQ-Originating-IP: 8SdGorlmFm/VswIUuema0zZDdEAP6HdJP9fQ5/Kx/Sk=
Received: from localhost.localdomain ( [122.224.83.35])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Mar 2025 23:42:57 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16068213512109083209
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v8 0/6] add sriov support for wangxun NICs
Date: Sun,  9 Mar 2025 23:42:46 +0800
Message-Id: <20250309154252.79234-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NNCgUTg3ctKTFKqLH1pIebXg2ecxtKXvZz3iTqCfHTpALbCWEp2usfwi
	0PpMGasV5TyfMnGPX8rHa9Cie/MkSSQufz+eoMkbkFECvWZkJBAADb+WeJtY98UlXZb5tGm
	iJIEUrIND2QSQqyUvjcwRgrBBVpvLvK8WT50zBdNFmYtex2IvWEmtpLzlELlOrsrouBWU7I
	YeQVaPU86l6sBwRz+2rY8I96Ij+bqduM7uILmcDp2qwQ3eTX4hpLiyacqTjk1CxFMHF6noh
	MKZVgomCgtkQtz35Or23femTGdXOKXu2UdQiOBzs+a/3xd37vmLW7DsRnRVD63Sok53pml4
	psS8IHBj035RigKlxk4Sn7YO9gyaZLR+OAGnzwOa0dn4TIF9xWHT1dQ/t1y5lg6xMQn+1Px
	7bK3AI8cgxqAi3LS4VAtxd0hTQXMmKIyH9lr6SudAue5NbqmkOGqq5VNJRd4QJfOdB5RFX+
	GLQqKgCa8QMe2uau+9ifeZpbA0pFu8Ed+BKiXys3yOfqiAoijFmShkRkjfta+7M26ggSgER
	nI+eFBNEhTM6T07MDsw8ZQtMX9r/jYA8gqTWByCs54xxKGZg88TTxiKkMZfqG5a0pioAFW4
	WZGZI6IYKmPNlRxijiygShqKXdTitoaaEwvr4oh6HRBv7tb88tINo+9QARi3E9i7TxgH/jT
	yuSgjBgQKXs1lnCq1vOD/N5tCUjn7fPKacjyob/hB/ex00lvR5Hg/tD7b4rNJHriLPLtD5B
	IozKQndJ8cN+sOLSYtL7XoGkRnhCu15mz+D2WTTkdlj091BYI0n8j5Zm39sG/fX/O/3RHpg
	6IPjufI0a44p7ONiJOiNWJ0yKOQ2II3eftm0r+RGWEYoY99qydw3iA7ErRefZ7mKASPwbZR
	tcNw6yRMsHf/QEpu+jwImWzAQSJEKkzG7JjP+0v3Zfb40KELjCmSBG36FCIMbTrOFWVb80n
	8r8p6/FjjU6RycnKiO3QTTPH0HmNxiImEIZnY7EBBB5eXNeycnhj3OrK/jooffe/01mw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.
Do not add uAPIs for in these patches, since the legacy APIs ndo_set_vf_*
callbacks are considered frozen. And new apis are being replanned.

v8:
- Request a separate processing function when ngbe num_vfs is equal to 7.
- Add the comment explains why pf needs to reuse interrupt 0 when the ngbe
  num_vfs equals 7.
- Remove some useless api version checks because vf will not send commands
  higher than its own api version. 
- Fix some code syntax and logic errors.
v7: https://lore.kernel.org/netdev/20250206103750.36064-1-mengyuanlou@net-swift.com/
- Use pci_sriov_set_totalvfs instead of checking the limit manually.
v6: https://lore.kernel.org/netdev/20250110102705.21846-1-mengyuanlou@net-swift.com/
- Remove devlink allocation and PF/VF devlink port creation in these patches.
v5: https://lore.kernel.org/netdev/598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com/
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
  net: libwx: Add mailbox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Redesign flow when sriov is enabled
  net: libwx: Add msg task func
  net: ngbe: add sriov function support
  net: txgbe: add sriov function support

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 300 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 128 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 176 ++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  77 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 910 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  14 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  93 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  93 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  27 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
 16 files changed, 1832 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.30.1 (Apple Git-130)


