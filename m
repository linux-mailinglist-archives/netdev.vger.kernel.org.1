Return-Path: <netdev+bounces-208905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09CB0D856
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836457A1BAC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A92E49A4;
	Tue, 22 Jul 2025 11:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6C22D785;
	Tue, 22 Jul 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184223; cv=none; b=XxxPOyjGKw8i2ZWBDGq9S8f0TKgwtvGz3LADW7OE0jwf75QEX7cF/uUm0vndZlHISt8djnUm7T86PfJP9mvCE1BgHYsauZwOKVw+vXc+xd6wAlpLWNf3RlW06X7RPCaoUFiW7J3g8WaLS/8c8hHb0DG/bL6Qzz8uZAdBDScaxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184223; c=relaxed/simple;
	bh=TutmRf7PRvoKREEcIUUFk8BWwUfQUx3DrBW6pjmWn2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfecgbXoV1iRB2ZL0U0noXWXsX32DKHDR/KZrvUnW6HZcQt6veLr83AL7oGS/Q+hhfID+iQjPn+HD4wXWbW/ZfNjqs3jQvJ/dn0h8PKfZQxF3sErytP+hVoxjBEfrSCHcB4HRDI6hSLPsfT/IvcLctHd0NX9jofD6xyxWBA52XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1753184144t1f8fdf7d
X-QQ-Originating-IP: KVJj6lsYqr7FQs6PH3TtIfw1/RHylvVAcTptgkbtrUs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 19:35:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18378057600828906183
Date: Tue, 22 Jul 2025 19:35:41 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
Message-ID: <49D59FF93211A147+20250722113541.GA126730@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MbSuBwOrED9vqnGG2pMcqPoQdDSXzvGHY5MtSKudTE9DHEa99Btoqz5v
	l+1yqYQCaez5yjo1Hn5NYzEQMlS4tfV5JjrloWb8vTz4OFQwn2QJxsBOmcvpgRCLQjZOK3q
	vi1oC/8PeSz1dK9cmaDZ3eFGK2PO7kuzBSQao6pjV2yYIJLaqoAAxdcj+G8e9LA+HU1WkA9
	BpeTV2sA8EVj3JqDj+6hEH3AQn7RM630H+YlquJ6/Fkd28KDdSQUraFc63pAlcVUQPIybSo
	QTIP9v5b5PQkGldJmY5RGqZy1rtx50XTp65VL9tKesH/ldYNaM1Ru4PESM9EQJjOLxMjX5Y
	+K3iuQmRdYeAFim4FQAc/OjNFm/ZlFaJRZdRKyQ+5e5JojVAbaYzvy0Yyw1zoheo+MJX8dA
	lCOHRzi92SzbNDGoaZqaDJy6GV3bHGSCX3s7BzAtoGIOdVc9fjWgyqxH0+pQaibpwhECbTm
	fC4K4vYT/E93ESaeq/EVou5jCfevvfEZZlAHQLJjRLiZvlVmB87zbqQt0Zl2sSb61fA1QpS
	2ycZn4OAStX2x07YDfZX2R3ufhc0TdRwoY7xrI9W1h309S/g/oRTDbiTkYISwGPFYjm7xW2
	5xsrf+l+WHKe1r9i+2CTDFFxE0MYjqfM2m7uLNpmc/HSsrjUB/XAS54TP89m+ZHt+8oZ+HS
	9++1XLg0e985SR+MyQBRCio2saVqtk1zUg6xWNTTE6FI1/o7Y/bBDHVjaoVGs+BqfFyCZxS
	xjXEmUJHGSqsSpoxHPIlPhmxo9tv52CynqIOJwr+FXAXK6FPDPwgR7yWQ65w0EHONeI4O5C
	bmN3Mulos9JP7tmUHuzq2xMf1EWLeJ6CTn63m+Qyerbywis53r8mwkm08o1o4hxe/Yi4QR5
	9Du7eLh2Uq16irbEJ0mxtMsInkmdzAWcpIFvcLKPIrMABZ/h/yb3+GXflSdPl27uS4jVmtO
	aSDd/8Nx54/XbQQ6OnsGT4bKOoCpUFvj7yXaAoCBzXYyrmq2XC+SP3le8YdO3fJZ5ejsqNc
	2cw02tEM69AvCXhUAkOvjaSjvdDi2Lbj+3QIyvvZFP/dSU2LA9WXPdQDrZQwUqfYjtEw78V
	A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 04:50:48PM +0530, MD Danish Anwar wrote:
> Hi Dong,
> 
> On 21/07/25 5:02 pm, Dong Yibo wrote:
> > Hi maintainers,
> > 
> > This patch series introduces support for MUCSE N500/N210 1Gbps Ethernet
> > controllers. Only basic tx/rx is included, more features can be added in
> > the future.
> > 
> > The driver has been tested on the following platform:
> >    - Kernel version: 6.16.0-rc3
> >    - Intel Xeon Processor
> > 
> > Changelog:
> > v1 -> v2: 
> >   [patch 01/15]:
> >   1. Fix changed section in MAINTAINERs file by mistake.
> >   2. Fix odd indentaition in 'drivers/net/ethernet/mucse/Kconfig'.
> >   3. Drop pointless driver version.
> >   4. Remove pr_info prints.
> >   5. Remove no need 'memset' for priv after alloc_etherdev_mq.
> >   6. Fix __ function names.
> >   7. Fix description errors from 'kdoc summry'.
> >   [patch 02/15]:
> >   1. Fix define by using the BIT() macro.
> >   2. Remove wrong 'void *' cast.
> >   3. Fix 'reverse Christmas tree' format for local variables.
> >   4. Fix description errors from 'kdoc summry'.
> >   [patch 03/15]:
> >   1. Remove inline functions in C files.
> >   2. Remove use s32, use int.
> >   3. Use iopoll to instead rolling own.
> >   4. Fix description errors from 'kdoc summry'.
> >   [patch 04/15]:
> >   1. Using __le32/__le16 in little endian define.
> >   2. Remove all defensive code.
> >   3. Remove pcie hotplug relative code.
> >   4. Fix 'replace one error code with another' error.
> >   5. Turn 'fw error code' to 'linux/POSIX error code'.
> >   6. Fix description errors from 'kdoc summry'.
> >   [patch 05/15]:
> >   1. Use iopoll to instead rolling own.
> >   2. Use 'linux/POSIX error code'.
> >   3. Use devlink to download flash.
> >   4. Fix description errors from 'kdoc summry'.
> >   [patch 06/15] - [patch 15/15]:
> >   1. Check errors similar to the patches [1-5].
> >   2. Fix description errors from 'kdoc summry'.
> > 
> > v1: Initial submission
> >   https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/T/#t
> > 
> > 
> > Dong Yibo (15):
> >   net: rnpgbe: Add build support for rnpgbe
> >   net: rnpgbe: Add n500/n210 chip support
> >   net: rnpgbe: Add basic mbx ops support
> >   net: rnpgbe: Add get_capability mbx_fw ops support
> >   net: rnpgbe: Add download firmware for n210 chip
> >   net: rnpgbe: Add some functions for hw->ops
> >   net: rnpgbe: Add get mac from hw
> >   net: rnpgbe: Add irq support
> >   net: rnpgbe: Add netdev register and init tx/rx memory
> >   net: rnpgbe: Add netdev irq in open
> >   net: rnpgbe: Add setup hw ring-vector, true up/down hw
> >   net: rnpgbe: Add link up handler
> >   net: rnpgbe: Add base tx functions
> >   net: rnpgbe: Add base rx function
> >   net: rnpgbe: Add ITR for rx
> > 
> 
> This series has lots of checkpatch errors / warnings.
> 
> Before posting the series please try to run checkpatch on all patches.
> 
> 	./scripts/checkpatch.pl --strict --codespell <PATH_TO_PATCHES>
> 
> For patches within net subsystem, for declaring variables, please follow
> https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
> You can use https://github.com/ecree-solarflare/xmastree to verify
> locally before posting.
> 
> The series also has kdoc warnings, please run below script on all the
> files that the series is modifying.
> 	./scripts/kernel-doc -none -Wall
> 

Great, I really need this. Thank you!

> >  .../device_drivers/ethernet/index.rst         |    1 +
> >  .../device_drivers/ethernet/mucse/rnpgbe.rst  |   21 +
> >  MAINTAINERS                                   |    8 +
> >  drivers/net/ethernet/Kconfig                  |    1 +
> >  drivers/net/ethernet/Makefile                 |    1 +
> >  drivers/net/ethernet/mucse/Kconfig            |   35 +
> >  drivers/net/ethernet/mucse/Makefile           |    7 +
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   13 +
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  733 ++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  593 +++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   66 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2320 +++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  175 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  901 +++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  623 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   49 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  753 ++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  695 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    |  476 ++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |   30 +
> >  20 files changed, 7501 insertions(+)
> 
> 7.5K Lines of change is a too much for a series. It becomes very
> difficult for maintainers to review a series like this.
> 
> Please try to split this into multiple series if possible.
> 

A series patches can be accepted without achieving the basic tx/rx
functions for a network card? If so, I can split this.

> >  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >  create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >  create mode 100644 drivers/net/ethernet/mucse/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h
> > 
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 

Thanks for your feedback.


