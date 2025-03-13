Return-Path: <netdev+bounces-174758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AFA603A2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DBD1889BDB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895641F4C8A;
	Thu, 13 Mar 2025 21:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39961F4E56
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902464; cv=none; b=SceBl3nC63IPZ9rZMdGxyjcqoELeVjGC0kCTqA3aUwPQuo/lNhyTne5NSWasCGPkuIqvp+zHbzy/3XIybhydD62Fgtz+YzH+qzbClbtJi4EM4aUVI+8ypBQTyQd/Yc+KCWfPAIi4AOm6pFmyT2iLH6m5nL/23dFL/qNgq4eKbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902464; c=relaxed/simple;
	bh=kp09IXKP6RSmcsBiVvSJaSF/c+XcK3Zy7fFlpA4tCl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPgeXAK8cmisQbaDD7+4nehTiv4R5SKWqCmcJbX4ns541htSGmvS4RYjxfxp86jmUp80XD1cRXVeYtI9jjBh4Kg9ak+ld/Gwm6LXNlru9ZRp80f3S+p3cWKeOTNevANnfNbmqZV7mgsSH7r9m92Agq0J6Nq3fMD/X3t+eOgVcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpip2t1741902431t3s3m7n
X-QQ-Originating-IP: 9ChaAbwy19KHm5wWBAAQyTFmQwbAQ87FMm5PwcavXa8=
Received: from 192.168.1.21 ( [192.168.1.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 05:47:02 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 929398893330075278
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND,PATCH net-next v8 0/6] add sriov support for wangxun NICs
Date: Fri, 14 Mar 2025 05:46:53 +0800
Message-Id: <20250313214659.2785-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OatzRg8pHEjpvikTHI6LpBOK4VYJW6LLjbBNGy4vhdW1qb8u/68Hkvrm
	IoOY4Z6kHjmiWeeah3ztJQIYfPIZMdDWHzgUJwNX1aDiF6nlxMohW4MuzMhJIbybTjcBfpj
	F5fACihmVzsvOnMlhf9+CiBR4790w3WwXPS8PYUMy2SGzKpR5vQB8jRihW2s4iLIk5CwAwI
	PWVmG6SRd2EkvU0lq3OfkTuqUWgQ7wf7AXqDrt3rz9q0p43YpmOJpBdDzQlHniwez30ER/j
	F7KNOMeepHUqnHMoZXuzZQ11KAc27P7NYnyHnmy8yAAwT8GUAEk0nH7LGDnV/j6WFq1ZQom
	VXyy0PRR2QY+mgHLygjThuWPyXrTVu+CpvGS344IU02qUNd/gfer5inllnKUbAaKc2cVt0C
	ngNKPSR2QqPCG2WynwBCZdLaKHhC6cp/JHefWPTc0cKmAGyXWmsbl5vbXpRTwFzg/A9CTQ6
	dPQoaVyyL8JIerTOcEwppxjnFCaFXeKe0ZfKtn6YvCPDHoyKjL6nLGbgR4nlL9LifnRrDhp
	PA5NPNLHAkBeCfEKv8tZOzAhMDIta+RM+nP8/EUAixiUFeS6dyOoA6P37swXTD+rz9q4C3l
	ug9D12Rr4uz39zcuoFoVuL974JsrqI+UHg6qWq4S1PUqr4Mutmadl1CgK4J/i7HQsRPHmtE
	UOooGvwfF9Qn/rfqTc0p2yAxuzo8PNkG6iITUEIyOWnp/tDEpc/3YaJA8l5hLzGSlrxamYn
	bo+owSkkiLK7/4mr75XZknUMejZP5TfAd19QlE2xn3mGhE7sczJeb/P7BeIfANm5wdPi+sa
	Ur5PmLsJLp4xCMonBzhI8zAlLhrUx4HxrDt/KwI0Ro+R+XuXQTtS6/QFxQCgE7Z4jyZ7/hQ
	7OwLt+b5I50PobMfl0xqJvFTiTGUcjgyQY+7jVGHrRBRNvl8YyZTz+YuJwzggNvxRVqrsAr
	gQk0D4d09nZi1Q31OyWH3WY2Vh2Fy06Phm39wwl/o5dc34JvKCGi1XrdNHovZRx2/7fsWLD
	XrisSswg==
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


