Return-Path: <netdev+bounces-176988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF401A6D2E6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3B9188D447
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91B8828;
	Mon, 24 Mar 2025 02:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4B15D1
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742781674; cv=none; b=iM671vzMor29V/auFezPZucmsKXje7UO+7urI46xJeLMAs44fvVoOBHbNaCkdshWhdPrAYRGs0pb8kKzO9i27XhqQOC74pR30df9v2SwJ32/pZnDt32dXQg1QsAECghdIilKrHy8VUsxE/v6VtVMyZeGKN8QN3lkvj03weSrVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742781674; c=relaxed/simple;
	bh=8FtM7lP+j6gQd7aIjPgbtGn5xrc1Kc+d1g7XXL90hpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saC0pYipN1JMU5VXq+LvqcCFrc2k+duN7sFzKu6OLP2goXg5ZxY34D43MF6daZAAFG4Z288J4vdBxtbygU1qlN5QZQWTCABpYAF1+bnnyeD84EdOVr+/OuOEuLsSHL9Jnd3JwvBBFKxHu39rjBiYjx2GHGjncH3Yy6uKpvncZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz6t1742781643tmjhido
X-QQ-Originating-IP: SsRN3rcQD+fiRLiW0JThHzNlZOs0qU1hMmTrmGto73E=
Received: from localhost.localdomain ( [60.186.241.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Mar 2025 10:00:37 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3669850783899959956
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND,PATCH net-next v9 0/6] add sriov support for wangxun NICs
Date: Mon, 24 Mar 2025 10:00:27 +0800
Message-ID: <7D5E5877DB2D7506+20250324020033.36225-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N7bzzhFwp0G29rZvwwlnETgrBpEeSna81Ma+dLJrnH1YoT1MRoKzgpXF
	9x/APzIBrlRIDtB5BcZirzJY/QDDHaE4MZ4qKNu8y7J0C4dHlXOE+47Fu/1No/E1Cw5wkm8
	nDvFaOHbGZrxgujQdDcC4venzdSoFl4SRCaDtfrGrEBJ4UQ6RH052fc/I+781bmPJV5cYOH
	pY3W0C9ZopkYZsxrUCS054QZk4CFXnoBHfIc387J0kuTqJJMxQ8ypPUQ3xAKQkwgLxG/4ow
	ZPO0oOvMlfC6V/c9DS//ILXRA2dpcb8hayDfjI57q13zlDW1h3bq4hoN9A3jEtIBNFhOSqU
	2CLGIwtj+JNn59WLZ68aHOQEk+iVM4DbC5R0OAa1riOxVnoSvTMW+Zg4CNLUtgcf8o4dOjY
	wmqgz+qP1Jabecz31UGz8oUoHGi8xShgwB+/ckkQCKpcbKLk0DMBtwBZqK6+qqHmCFgoVUi
	oLmJtk4m8588Yr2Khx4yFi57OWeCf4cHzK7avhESXHCIj7iSuXaXPCQt8Ehj/77upf2Oc6J
	D5a45QcvXu8kLR7U7UdkGPsltkebwEziPLc4grN2mJBmFaG0/1kJFX+SP4P3fgq+tMs9Es3
	FmEYyifjXUm3EpnLkbHQCe/nQ1A7A1wwPDzeiQ/OffDLfBvkCodzMuLC+HGFFgYbEuVn5XM
	ZLIG6Vn4oKQvWz30PiSzmDSs+GQ6guR/bYdZS1WdPlQtPqExPSADlUeZNcFRvrcAIqNQN8u
	yzIhfxXvtDjC9OdhEDlw98G62rRZxiO7wogNj4gCxp1eGsQaQpdWDt/rKE9UHEe+fw1BK2e
	o3Pr7YwbqLRItArFxU2NOyyjA1mFyD/muGwLj1vXP45KtKB4wA8gf7jClZ4TCo/5QMFDx9e
	cwghdHAtrOlHVF5UtYRn74M7hUp7rkilb2clCcLiCB/pkVapYqSz7M9fL5LL3fgWU75WKNx
	voWjaDDwgr6YIlRQITsB7F+Gp9YiybOKuW/aeMZbGc/H2jANR6U5teg2FM9cJSuo6qpcE3J
	xwW+AvUg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.
Do not add uAPIs for in these patches, since the legacy APIs ndo_set_vf_*
callbacks are considered frozen. And new apis are being replanned.

v9:
- Using FIELD_{GET,PREP} macros makes the code more readable.
- Add support for the new mac_type aml in the configuration flow.
v8: https://lore.kernel.org/netdev/20250309154252.79234-1-mengyuanlou@net-swift.com/
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
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 302 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 128 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 176 ++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  77 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 909 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  18 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  93 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  93 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  27 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
 16 files changed, 1837 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.48.1


