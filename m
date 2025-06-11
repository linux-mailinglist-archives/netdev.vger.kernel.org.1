Return-Path: <netdev+bounces-196455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3AAD4E89
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84633A797F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318723D290;
	Wed, 11 Jun 2025 08:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02C23ABAF
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631018; cv=none; b=smwIM8kl1NYmwpKs0piTwFzn17763VLlml4SCFF92pTnJO4obNE4iFGDc7H8tE4KyIX5VnkOPc3fFDaJS4vC8cWPZ8BF6CdLqMsrBLN+N3dmCBVoXH6ULtl375ElvID3wiMB2Gkf8in9FbWls506MmVIgbX3Q69PYUGzyKFfms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631018; c=relaxed/simple;
	bh=WdMG3YTulhETJo8lrVi6LUYMyS157pjwwWVdxbtGJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o6f9+EI1Qs0bWHeKqkVGgQlt75wGRfozuyQ3RsaHXRlxjIcFi5c/EesFMbx95QdJlDQlXDrP/pdjFzNoetQg3tHbePOM6o710UIjrTIq06Ic9RSr6ZqjZYH3za9mcUmuYDELAovFF0OaMExC5BvyufWyzWPlT4wJP0G4ujMwCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630964t9ed0d2cd
X-QQ-Originating-IP: EiWbPG4ekAurj/IT/29cOWgNAD4rBVuvVR3QPB+MrHg=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8937446712846460204
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 00/12] Add vf drivers for wangxun virtual functions
Date: Wed, 11 Jun 2025 16:35:47 +0800
Message-Id: <20250611083559.14175-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nj4WqUO07E8UwtDC0a+PD4l5qf1QEDeGbw/lGVqk1/5Q17vCBrtBzbZK
	116fCFE+p9wdkzdCBgChQOTPyaxqCFMNLbs6qBkTFqd6VAY+NGlnGE96mnPu3ibMbVUNIVN
	ohrREiL45smo7pP57Q/SAtd9vpQvpxWKWXzPNTZnGWvq3wt0GgQ8kMDN1MjJXYKli8jYXNl
	JYPGPYNPWW5rU/HJflr8l8uDY0U0pugeYWD25SjvHV3JmP0J05KxbJdA4ymcqo0TeOQ2PqD
	D8FZFYSXA61BlffotJJjdyCsgxyGKYUjgjEVv3GSzndGc6MpeGirJ+o0UPeifa2lSc86Wg6
	w2lG+GvAsHdi88sCtWopJREybfvHMYLtClnMs12W3jZW9/RpieKfjkKiNBskjC3B58KxlFO
	qTAUcpwX/w3wmh9dLcVNzdmN/Lghh7NpFFYD+xNUZlNQsOnNSg6rJknbQYsyewpGGqdR5/n
	jnfX9u71KSA4y+zjpaBdzmwBwDlIkd1QxzaAzu2hJnZtvGFb7KRddU3jEUT1fK7KZPz03/X
	Ta0FR4GIJ4amEaBTwmi1FzbJ+4SCpyAdKWfN/vWRtoNMt2dJiUNlbuI785FV+Mqhwcevf5i
	uQ/Q8BvWCx4d48KCzETdgPKBlFx7ich4uFdLOCzaN1oAOFjJ3anDVvhBsMQZeajsw6rypoh
	gOSdmzd90R+Vhej908OSksV25ojKccKJMpzccjfvfJQcdBb5SeHWDkHCazxdxr/y443iOWI
	gpPYNQ2GLWDa+o5D2Hno+40JMuHXr6eOY3iWX2ypTNBRLoWCZ3SrCvERfqp3/qTJ/QaMrKp
	ExjUmLJArx7V9cOMI/noBC0LhO1eGi7VsY1Ln2gytRY894UTyREa4Ghym5HqOSJyuC2KQeL
	tAXNYXJBW17wkSFJFU+nRum/6beHwYj9zOhcVMPcBuk83zlLZ/lYPQFHkVBZeC3E/QIAeUC
	fEv8e0rZbD1iQ5krVyyOxBxQommS5NVrP/HpxvaoHSUXk6aYzD3CC/Mmmf/wh5MVF82pOzK
	bCjtkOMst0y3IqYlFg0NswnZ7BssosOoku7+3vjJ7xra2C8PXPdZ7F/VSr387rl95HdBjaJ
	feXH865I1UOkXnYPi3oY/9nMf4bry8yIA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Introduces basic support for Wangxun’s virtual function (VF) network
drivers, specifically txgbevf and ngbevf. These drivers provide SR-IOV
VF functionality for Wangxun 10/25/40G network devices.
The first three patches add common APIs for Wangxun VF drivers, including
mailbox communication and shared initialization logic.These abstractions
are placed in libwx to reduce duplication across VF drivers.
Patches 4–8 introduce the txgbevf driver, including:
PCI device initialization, Hardware reset, Interrupt setup, Rx/Tx datapath
implementation and Basic phylink integration for link status checking.
Patches 9–12 implement the ngbevf driver, mirroring the functionality
added in txgbevf.

Mengyuan Lou (12):
  net: libwx: add mailbox api for wangxun vf drivers
  net: libwx: add base vf api for vf drivers
  net: libwx: add wangxun vf common api
  net: wangxun: add txgbevf build
  net: txgbevf: add sw init pci info and reset hardware
  net: txgbevf: init interrupts and request irqs
  net: txgbevf: Support Rx and Tx process path
  net: txgbevf: add phylink check flow
  net: wangxun: add ngbevf build
  net: ngbevf: add sw init pci info and reset hardware
  net: ngbevf: init interrupts and request irqs
  net: ngbevf: add phylink check flow

 .../device_drivers/ethernet/index.rst         |   2 +
 .../ethernet/wangxun/ngbevf.rst               |  16 +
 .../ethernet/wangxun/txgbevf.rst              |  16 +
 drivers/net/ethernet/wangxun/Kconfig          |  33 +
 drivers/net/ethernet/wangxun/Makefile         |   2 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  14 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  29 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 256 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  22 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   9 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    | 642 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    | 124 ++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 365 ++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  29 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 290 ++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |  14 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile  |   9 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 308 +++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  29 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile |   9 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 402 +++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  26 +
 24 files changed, 2639 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h

-- 
2.30.1


