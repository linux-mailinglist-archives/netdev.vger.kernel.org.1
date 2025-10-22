Return-Path: <netdev+bounces-231582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974EBFAD57
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFCE7505022
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6371308F1A;
	Wed, 22 Oct 2025 08:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3A305042;
	Wed, 22 Oct 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120885; cv=none; b=XpBRrG9Bp3vFsa5TYhmqpZXAtozn14YrDfs9uZosZ8yCmrDGOIlbii2/NkT/804tSxYigrlZ0Z/vB1UBKB6+vOydaAyv15iKvVJ4BCtgmu8cbkPg/1+d6ImW20xfgvgWpw6AznXDzdLjt0AAx7UxVa0iDtkK/HTT3PpxlVb5Ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120885; c=relaxed/simple;
	bh=b36wYOjJ2NVSblw2KZ8xxhz0+0vzuCsjKCG9NssxFQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLXCSuDjgarWzAfAPv4DSFW1+TzSujNVnaQ4JVXpKKip+f6H10cALfi0Qqxs8zZePjTf/3RoeZb51snT3vR4VAXmD43Hry+PzQo9sFFr8dOD28ZEELWm12dingeJH2OMij8bhwCKdCHbTUbwCclfP+AN718TUYy/eAOXgfG7arI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1761120842t2697ff47
X-QQ-Originating-IP: Cq9pKaxe2mYYcVPGK7BeBruY0310SjNRsfC7P7X0EXE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 16:13:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6820737812960025571
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v15 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed, 22 Oct 2025 16:13:46 +0800
Message-Id: <20251022081351.99446-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NYKBs1ZFv2UbGQUxhlWy5Uy9rFBJgDjf+6soQlMezoPz0UaENVRsmHPf
	voGB97AO5ETQu9fr8YlSn8Ox7uZdJ6pDvRCR6Wuz5xsNeP7nROFUCkHbsc5tlABBJpnJzMf
	qImFfs24tGbBk9hXMnlavx7zEWffTu0gwSJ1KOEYgThGE7JT1t/8ai16iG2ZU2cDG3fxuHP
	p67UI0SjTZ4NvvqRTDQM3sZP/Dr+jtPgz2xWl4UiFlDxayn38fl3f/ghfJUy02hG6S/Vw6k
	Z/rnMqbf6e3yA9ci3rJMJKCqjWwRPdcAD2Lxx8nWIkOwqnu6yC75LujDXg8b3a1x+Ks7llU
	JNDjKq2x5cmOWYEm/l4DKcDgm3sx7rBxBHI80RW17h1URMFLHDiyH9jvUajyjBLTaZlXeLq
	ZMx5dPyyrjEVIw2jNDREIjDgdApxE2UtjBkI5RpV8kqDq0rCMswBSrc6kGDdWbIzpmijEBs
	kLgVkkANWUqbExzFV+T82u8wZ8H87qUBW9ZtHl3n4XCpIIDDcZ9F0yrKM98w+ALChfsC2fC
	KgitBu2qFUUcys2LzELFml35atCu4JkgCqRcHdqk3b3AjXGxe4Jy4NLbKgDOwBBbRsD/e5T
	RSwmsUiPJvt8/KaQ4SCL9mc7SdhqRR4ijIXZnn9bf2T19qSSd/vhc4+dPbgudpqwwnUV/8R
	7n7LBaai5vhbBMyPCzxLli/xy1rpJYtDCsccIVCxW6J4ZLw6tu2FhXdNLGvuUV6TBvjjFNw
	GkFDisD0GpIjAnc4trew3T1kEfVunDYhw6/82yAipztRksj7SOKWznt2B63pAi5uwRQsC6N
	70RGtykDrbw5vvY+WJyyHHDxDJ16zo5H1ZldifP+dZyMX52f/9GUd1wR5YzkoehU90+sV1h
	AxhsxnaIOmj3BTY4NcS79fP1HLMA4lWPiM/vJZ3yH6SCZbWWr1CudW8yGpxjsZjml7C/sR2
	vVzWyi+tFGvOq78yKSryehHxYsYRuHuPMFiEst//unwtfuSU10CUpLq1CdCFsNtv9moEWs0
	AYDEOn+vatZ/DoKElu5lmLaaWWjuE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds support for MUCSE RNPGBE 1Gbps PCIe Ethernet controllers
(N500/N210 series), including build infrastructure, hardware initialization,
mailbox (MBX) communication with firmware, and basic netdev registration
(Can show mac witch is got from firmware, and tx/rx will be added later).

Series breakdown (5 patches):
 01/05: net: ethernet/mucse: Add build support for rnpgbe
       - Kconfig/Makefile for MUCSE vendor, basic PCI probe (no netdev)
 02/05: net: ethernet/mucse: Add N500/N210 chip support
       - netdev allocation, BAR mapping
 03/05: net: ethernet/mucse: Add basic MBX ops for PF-FW communication
       - base read/write, write with poll ack, poll and read data
 04/05: net: ethernet/mucse: Add FW commands (sync, reset, MAC query)
       - FW sync retry logic, MAC address retrieval, reset hw with
         base mbx ops in patch4
 05/05: net: ethernet/mucse: Complete netdev registration
       - HW reset, MAC setup, netdev_ops registration

Changelog:
v14 -> v15:
  [patch 3/5]:
  1. Remove 'struct mucse_mbx_stats'. (Jakub Kicinski)
  [patch 4/5]:
  1. Remove 'mucse_hw_info_update_host_endian'. (Jakub Kicinski)

links:
v14: https://lore.kernel.org/netdev/20251014072711.13448-1-dong100@mucse.com/
v13: https://lore.kernel.org/netdev/20250922014111.225155-1-dong100@mucse.com/
v12: https://lore.kernel.org/netdev/20250916112952.26032-1-dong100@mucse.com/
v11: https://lore.kernel.org/netdev/20250909120906.1781444-1-dong100@mucse.com/
v10: https://lore.kernel.org/netdev/20250903025430.864836-1-dong100@mucse.com/
v9 : https://lore.kernel.org/netdev/20250828025547.568563-1-dong100@mucse.com/
v8 : https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
v7 : https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
v6 : https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
v5 : https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
v4 : https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
v3 : https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
v2 : https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
v1 : https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/



Dong Yibo (5):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add basic mbx_fw support
  net: rnpgbe: Add register_netdev

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  17 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  33 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  73 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 143 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 318 ++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 406 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 194 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  88 ++++
 16 files changed, 1338 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

-- 
2.25.1


