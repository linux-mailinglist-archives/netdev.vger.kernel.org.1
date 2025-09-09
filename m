Return-Path: <netdev+bounces-221186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99515B4E9A0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F76B3A38FC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A34321426;
	Tue,  9 Sep 2025 12:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835232236E0;
	Tue,  9 Sep 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419782; cv=none; b=kJ0xwrd41QpUMvjcbdSYuh8KMm5VcVfkoKp7U5reIIBeeDLMsI2S/1FrRrJsKFiuewB4APu+0eJDiEnowy37gpDCM9VgxzPBW917cOWf8JdAK9dbD6zJG+aJxybSKHK+y94gg8LR5DObkEB0/Zlymrd94YjRlBZ24IWTL+peEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419782; c=relaxed/simple;
	bh=kcSXoTKCztFHAZOS98Ex4lYqA9qYw1M7G1PGnOC6T94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfF0qJrV3Zc02BoDlS2FxQFzA10HN+8dXNKRn4zVbMjz13r9daxfLzo+TYUz10ZVXsRnCHtQZ+fLIejnT8fIhRLwRbWNKzezr+yNPPX0MtCE3fG99d3D9O0DiTs1476H5jfvfuuzIUxxA9I08mrvHdAbkYpYxss5pAbOHEuhcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1757419754te06b3484
X-QQ-Originating-IP: G+OJoRf/FUjzhkiqEgyYGZaVShJiHw6JsCi4DUgN1hE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 20:09:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16886291901814427301
EX-QQ-RecipientCnt: 28
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
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
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v11 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Tue,  9 Sep 2025 20:09:01 +0800
Message-Id: <20250909120906.1781444-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: Mskxv2Leo4L0Vsd4CKuRFrH4lA0dtmhkQrVAhTcWBLFXRwtByFUoI8nW
	OXwPF0+3cuebyOjqnqdA7DLwVQyF93/aF2U2wFNTJBSTa/IxEs6OgqQS7P16ZgD0llcFX23
	nWNi/aUYXFNhV1kwjQrKhwi6/9OGHn5K0Q5Cb97WsY2hnR30zkx/Ptn+NSbs8wxN8/Myg2j
	NKVCaDDv1R9uvfHj+NeYEO9cAJFEJz/fSwUSMDMAxx6ZMdx6vZiO3CvXnoDF5Hp6cpJT8HI
	xAJhG7g9sJEh6eBLdhPemN3Y+OqC/9ZP8BQ14ArqOkwQSyJ6MzWPIRMbzIjiXBsEWxpAeKc
	7E36h4yrHXYqK6PD2t85K15ItaF5gFb3Araiwg85csrWJFSIMyJgv+++Hof+/oLX921j0e5
	6NfeFEQVWk6bvNHjjL32svBx1e4yMmGvjMm7AnshJq2bUUDjpf8w2In+wNdaakln7c1K+AE
	pBkkYNTNVa6lAf7hlZY2hGqlK280W9MSh8Ux3HFwB6OKMhyqwhDqjLhMSriAHrgq62Sigjx
	M8CGhP8HeHFf/NfXDXPrMhuIJmk0P8awHQivgDtaewlNHlVvHkuR0yCb3u4YbVQG9ihLwhl
	fC/7QWJJYJJtaEtMVK/LxjrOwNIILTh8mjGIjVy+1G49LGkcUCc8JSlO+bhReErvDHK1Bc1
	G8hIYq53vMmBhB0SKIN6zKLqRX2qPE5JV+rTAAsGnF96dHlnA8tXQVkXQjaxaHPYnaIAxA0
	nZV9O6mHHhpMPGG3+1drirh3ghaNiV6CUTeSz6B+Mh+bucBh5Zdm4jgHN14mhknrHJ4fmey
	kPpurFG01tOFF0oQ4jDBmTN4SIPoCQGuEkGrmTXM11w5xXZJWSwh7TAsdbHGNNby+OdRlAX
	ZiG14et+ZI2IDYXgKNHru1V6MQCr/XIg7EPg0GK8Id4WJoyXl6nmVMCU8i82VKWNxDzAWbk
	0/k4wlmxIBpo5rjKnXghbLbMqywm680pdW57ueb2XZw7TvNcQ77AwRkX6y+JG+9LmX98nz9
	TylLAvPtJbs+IQir7H3DdPKIm/jdqRYzbhWgHwc7NZvCf+xmzacNoGLJyBwgI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds support for MUCSE RNPGBE 1Gbps PCIe Ethernet controllers
(N500/N210 series), including build infrastructure, hardware initialization,
mailbox (MBX) communication with firmware, and basic netdev registration
(Can show mac that is got from firmware, and tx/rx will be added later).

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
v10 -> v11:
  Check include files for all patch, update commit info.
  [patch 2/5]:
  1. Move mbx relative struct to patch3.
  [patch 3/5]:
  1. move mbx->lock to patch4.
  2. Use FIELD_GET, FIELD_PREP instead << >>.
  3. Add mucse_release_mbx_lock_pf.
  4. Rename function according to the function's functionality.
  5. Reorder function to make call relationships clearer.
  [patch 5/5]:
  1. Add commit for powerup and sync_fw.
  2. Rename function according to the function's functionality.

links:
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
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  82 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 155 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 310 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 426 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 249 ++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++
 16 files changed, 1465 insertions(+)
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


