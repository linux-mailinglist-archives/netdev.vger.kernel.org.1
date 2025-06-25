Return-Path: <netdev+bounces-201062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207BAE7F09
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E103ABF04
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68E29A9E9;
	Wed, 25 Jun 2025 10:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50D27E059
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846936; cv=none; b=GOAy+plV5PC8GeRqNMl6eQqj9AZV+Qak32XxTsqfLukPbJnkgGFh2xWbSd6uDh4dJE7jzAdhKNZ4Xpop4sVy1/uaNyqEDhHt8v9eulZO3aCwVHW/t9qEIu6u3g+OiwbO0dpPBd4NWmtVbrJlyjLTiTutHYwE94f9UgKIFobZEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846936; c=relaxed/simple;
	bh=tpEvYauq17/bcS35tKh9YqbZZ/iSah4HdLna/oJ+pkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LSRsKbAhHxJwS8d8IC8WUst+kLLVFQBITdyxnBQfEU5keDQAmvW64O4zHaHkAYgvD7xbgpayj4M0ccqHLA0I1DzwyIsW+y8KEA9QaAvTjPD2XMVUTaufQ5n+LApxcprdd7CnLGMfBkBqwHGllbUCcO7H0GWq0BYfUlXNTXczmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846862tc97d63a3
X-QQ-Originating-IP: sG76JRzyh15veEtjm7BsU5Yq5TurDxUipTQb4qaqs+g=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:00 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5197918228553939446
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 00/12] Add vf drivers for wangxun virtual functions
Date: Wed, 25 Jun 2025 18:20:46 +0800
Message-Id: <20250625102058.19898-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M2VDrOlbJpuRy00/ZSzIUgcnGqLgjXB9OucmI+e+iGA4cgn9r/ijTl9l
	Rc14Pkhj6hWUX/kiesKsyVepfOmUgBBCAOcL9y/qlVQjjRUn2WdwCHEZUt4t3V20/SElxGo
	tvrhARFhnrPrH/Yz9yDAdtdAJ8/x4P0FDr+4WcpL9Jk302Y1PGDb7VNAZoM95LHnWH7SCZr
	om4wjcQon+MJHqumZGYKr4Pht0d5Le0tWSc5cKN8QJPRgLm2TU/D96u4u6pRUlQvn6Z+H4t
	ykqynvdRYVsfuQNU44aa263O1qu34Er5YDVZFXG+vQGOaJQ0N1LriPhPQPCVdqep3dY21tC
	qM/2fV9Mr1Mp2NArJdgy5iMAnQDq5rxMX5EQeklybrHTJA8hFRjcOTv1KurQbidOqPjR78J
	er7dqQOjjtJLm085cTfiOkUVvv06afM2GuNIRIJNy5zK4CsTP6RgVp06Vhhxs1EeQEFnbnm
	3X2w/blp6vpaCOycIjedl6FFzT6aZaoR/jQ5eRFVNys+8bijB9trSQ8Sq3akVTlJF3R8A37
	rfGM3TyO8KHc6u92WEM2UDkYfhrOfZcZ4UNvrtouPRAGPyaVYniT7CF/etyNXskaGxNTsDX
	FUpTPWnQoplc5VnZ/ka/yVPNWZbZjIMdybbrgI+ae2jRiRc2RoYMRoYvPqiCz+X4U7ZydhJ
	tLtfyV0Wo5satVE3dGpIJxMlr6mr0eEKGMwj6r6eyx53Ic5DLlkrHdEwwTWs+czCHcg/L1u
	yKkCuvE1g9C3lArs0oAqlJpBvxpXUcvOP00wj+sPbF4zADFUEPqsX73URQDkQH6968V5VaQ
	4BF7rDk4ZUubc/nFi2Eoe99jZ3YDqgFJwr0JgA1z87I2GG6zdTpUENlvWCp0uDcg4e5SJoo
	nAz67e8rwpUxwTCGeAQIDVAfkD0l01chUXZswrgTeUfRtjw1BmAfk8ZIWPUOfMq97p4VEyQ
	vJhUqBoLXnMr1SMFjljlWfDofqIG5e7vsdtWaTMnpcyL3S3ANzxHJ9ND4qHXigmsvCDvJ0V
	vDFKFpmq6W3rwBLL0OT6nEC8HGyKrWOutqw+dQxSh5S6YYcjRe35uugnpfv0e1z1Rp0tTpZ
	WqumHkWAShEum5WNtmXHzJIyd27A2DAraXpP4rcfXpjuWYRW+KYESuUAuT+BrsGuTxzTc6X
	JcAymC25e4XROdo=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

v2:
- Fix the compilation issues.
- Standardize the return format of the vf base API in patch2
- Use read_poll_timeout replace vf_bit_check in patch1.
v1: https://lore.kernel.org/netdev/20250611083559.14175-1-mengyuanlou@net-swift.com/

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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 243 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  22 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   9 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    | 594 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    | 127 ++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 366 +++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  29 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 280 +++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |  14 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile  |   9 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 308 +++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  29 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile |   9 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 399 ++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  26 +
 24 files changed, 2554 insertions(+), 5 deletions(-)
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


