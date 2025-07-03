Return-Path: <netdev+bounces-203581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68362AF677B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA804E2AF4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DED23BCF5;
	Thu,  3 Jul 2025 01:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDD23B607;
	Thu,  3 Jul 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507492; cv=none; b=aCumFWXeC+l0nJmE1yNXGTAvTQxpcHnva3QdLoghn6VMAxPzOHTgcaWUhiovPVxm23cj/6yCH9FAx/eKfqc4MsFB3KMlGtRXXalLznuSKRFoL8aqmxzprKiHQDn/9I5RoWMGO0x5g44vGof2miFBU7pJxkxk79qQhnns8sxQ+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507492; c=relaxed/simple;
	bh=CdvTNBCQ63H/jPCJ14qmfvoh+2uaJeXsPoVKo1okPMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rv2e8jkkkAVUmZJQAR4gPcMZTOwVS33Q2svvxx+u/yn2gDM6lbQJ3Xp2zrhcN9oFlnd444vQfn/k2KsgFoy7nEw7idlWpmYjYo4O9rJMdu1DEqkg9j9ZltBnkm9tV1dnr+CXdRJ/XiIID3ruojsNyIhSqj2fBaKQHNkCgK3Y+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507359ta7508a68
X-QQ-Originating-IP: qmxm4UfTpTPQm/7rBvisem6Kg9njnEV3saY2lFpPBSA=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9594193159864769327
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 00/15] Add driver for 1Gbe network chips from MUCSE
Date: Thu,  3 Jul 2025 09:48:44 +0800
Message-Id: <20250703014859.210110-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MuS8gGDVifkD4PKNwlHhWcMaHPGNrVquZsLjTZdT2JYzUf9zwfqLd0hI
	dnUWObDllghcBI+hUWTBf7nYp/Sx5gUsvNjx1a8RN4GOPb0RFdQccSyyvABKFHSLShJRU4W
	89xc/+QIEmQkawkdEVpkm8kGsyqrSaxNsFCD0sDF1ks2oISYPKKjO/807UJmWknQXSqlQ7A
	7wM90cfgHqYakewJsNnpwxkHa15ZVh4andAbst0cpzY4NZBQCmearY640QdvpYzM9ATJSYc
	84rbEb+KyNocRSVkWovlUQUpymW8GnHXQoO705j9FA5ciXoIhAWjCSIJuFis31xnUTWrKwf
	WaLiVICsz4gniym3wC7RWpeeGnWWL6cuYGTkZRU39Fpf0PTzrLmqJaF7DqeL6NgK0g89DlQ
	bP/g16jtXM4DeqK8A5D4rUTA3WOyzWBAcGss6c/ODw0o6mDu+iO1mr7WxV1xkNFsNv9Cki2
	dpzuNnuH6+kCXKcL73NZWqHZMH/5alMO1sTgOKoupWX1V9XiPAwBG6XMZIQPd6oxs2ODi28
	8I6/dUCSZ6fiqiLYb1dHkbgNcS2qzSD6gYctaWOo8NxatU0GwGNIy58eKWDoRnd/Rto4Uiy
	iKZ2rtuVCkP6jEllYhIT7WYhbHh0uLQpzUf26N9L3PNxX1FtttBvNRUdHhz9w5b1Z1Ft6SA
	RLKNiS17KszMV3qp3hPIa8zD/xMs5Xh6ifXE1cHZEPL0Y3h2rPxTOisBou9oNBbNTJwwGRy
	b2OArIrFXwvOFQPY2BOIQQvGK1NbwKqBKCUROuyD9ws00X4tHs2SI4b9w9po9ui55qncyK9
	QKuEe31DmbKyVOB0zOgeJdQWIF+wxNyBqcqQX/wk1VLO/XAL3lTAzGkxPnzeqB8s5zI7EzR
	aba+PFUmKQOb9KmcsGEpAiQLNT6yvfTiT6G9kfl54wIGZpDQKpfebCYwMwsPy+IZ5uRVR4N
	uC8dr4Q8GTfcQ5Wq3wBVxPD7aAG4loyINJLJjexII4HS4Aeu6vhxp6YYXb5uYGpPic+QTWZ
	pcIZs0BCOo2kMToTqN0+hLuH8OdU+V4jy4gXjzwQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series introduces support for MUCSE N500/N210 1Gbps Ethernet
controllers. Only basic tx/rx is included, more features can be added in
the future.

The driver has been tested on the following platform:
   - Kernel version: 6.16.0-rc3
   - Intel Xeon Processor

Changelog:
v1: Initial submission

Patch list:
  0001: net: rnpgbe: Add build support for rnpgbe
  0002: net: rnpgbe: Add n500/n210 chip support
  0003: net: rnpgbe: Add basic mbx ops support
  0004: net: rnpgbe: Add get_capability mbx_fw ops support
  0005: net: rnpgbe: Add download firmware for n210 chip
  0006: net: rnpgbe: Add some functions for hw->ops
  0007: net: rnpgbe: Add get mac from hw
  0008: net: rnpgbe: Add irq support
  0009: net: rnpgbe: Add netdev register and init tx/rx memory
  0010: net: rnpgbe: Add netdev irq in open
  0011: net: rnpgbe: Add setup hw ring-vector, true up/down hw
  0012: net: rnpgbe: Add link up handler
  0013: net: rnpgbe: Add base tx functions
  0014: net: rnpgbe: Add base rx function
  0015: net: rnpgbe: Add ITR for rx

Best regards,
Dong Yibo


Dong Yibo (15):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add get_capability mbx_fw ops support
  net: rnpgbe: Add download firmware for n210 chip
  net: rnpgbe: Add some functions for hw->ops
  net: rnpgbe: Add get mac from hw
  net: rnpgbe: Add irq support
  net: rnpgbe: Add netdev register and init tx/rx memory
  net: rnpgbe: Add netdev irq in open
  net: rnpgbe: Add setup hw ring-vector, true up/down hw
  net: rnpgbe: Add link up handler
  net: rnpgbe: Add base tx functions
  net: rnpgbe: Add base rx function
  net: rnpgbe: Add ITR for rx

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |   21 +
 MAINTAINERS                                   |   14 +-
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/mucse/Kconfig            |   35 +
 drivers/net/ethernet/mucse/Makefile           |    7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   13 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  738 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  515 ++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   66 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2245 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  143 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  936 +++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  622 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   49 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  650 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  651 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    |  236 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |   30 +
 20 files changed, 6969 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h

-- 
2.25.1


