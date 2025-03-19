Return-Path: <netdev+bounces-176016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182DDA685E5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42C43AD291
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83324EF8B;
	Wed, 19 Mar 2025 07:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DF212FA2
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369928; cv=none; b=O5CKck3YLPEJBaLaWgxvqzdk+/RHf+CnBjFuO2VYi3iMj1xgYYX0jcH/+1HYPNF/JL3dSscD/h8rfxhHzvqwY//dTeZ/booybJzoP0NCyWroEnpYGGfeWxPU5PbIgfl6sHpxqUVB6meULOWFK+8B+EwLzY3ObtmHvM8ULC8AmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369928; c=relaxed/simple;
	bh=8FtM7lP+j6gQd7aIjPgbtGn5xrc1Kc+d1g7XXL90hpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3BdTAyVWTYSq9u7vf5ZC3k4Pd8zC0TEimV6OoWy4VnJP//9hgmmCCwdUgUkBaXjLhHLduNtU/FG/EV+MzzssPwPJnYdNFWezcgI7k7A7RTQK04DnGsEFOfh0By5EVCSiOWPPbw/lLK/45IkCIwuVnEpyNaQN/SSylXTiSnB+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp88t1742369874tur1z4r9
X-QQ-Originating-IP: 5rBA7GVEKRRAtCxoEZvlhCQyCJPP7ARn99jvTMhCCXI=
Received: from localhost.localdomain ( [60.186.240.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Mar 2025 15:37:44 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12549923643067211279
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v9 0/6] add sriov support for wangxun NICs
Date: Wed, 19 Mar 2025 15:33:50 +0800
Message-ID: <203E2DE385ACD88C+20250319073356.55085-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OW3qjH3bC/TA4vjvexn26iPNYmYsaU90yWt3TKNAuAVG0OD7AIFm/O3d
	xBdw+ZNOzXxWfq/qQvnXmFzUaK8+GVhSY09lR9KFZm8Lx+NeEtB2K5q+jyMF/gENALeMri/
	+lcVUbyF1ZsUg3IqNM90oCV8c4V66dTapZVnPZ13EL4Fv8p9eOMIq0r94IfYOwmSNmCAYtb
	+/lDdHO4fZbB1qXn6ecqGfmVsUZZhk+OBtC/edNy3ey7yeqVSzbNcODMQP+H0RRHZpxXaMl
	zkKEsS6r7oFCuv4X6JO/K19bi9p50Lss4T/RlobBYaxg0/jo1LE/XdK3Qrgxj+GuJ08nRnK
	paDw5f0PlPUy1bSPRJnwRq9RgAHVQCxBj0e9zfQp2JF3v7JorbAOE8WDhzMGyGELpGnvNVE
	oD9wzMHPli3yeAZjCMeadDU3IihuzvRBotdkvflkbvxQCJMytbsAo62u8gtxi5tUGQIHzT4
	qkxqWp50oQf/3Sx8v8yrnCCx4jRefBqprfeMSxnlDfqTuJmcyvItH0Cdz3wGtH9E9dY5pqU
	Hzta91nu/3I8Mj1+Y+Rqd6BhiaJC0gjEg5SCIA4yYWFeniwVRxfRs47G8ddJpaWk2k4Em5M
	gvbJcrXlqwvAD9W24GyaKYWYjuSNfCg7OCFgVmHopaGO8YWMHGoVwEsWzf/VYxa20ZcHZTH
	t11VLj+vKtIN/GELlU2LT9HOC4Yj9vAAi/Mh0fWN9ssXMjRKSvBWLczA5+5NRzhmd6+h3qM
	0T3Q4kl3KhEuA2g5f/oMbRqLJWXIGXO7Cr29jm/rpUQb7U7uT2JTIl/2eSclXs4lr8atXyx
	wbEQPFDNTQsOuACZUVVlubz5X03SKmkr96lTKkr44U1MT1cCGoyZU/kbqzRV+cFD6QtDU6J
	UZBxgBMw7O18GmiwmE1B0k8v48fUNHVf1bAKdVCCx+kbroRQjUaSWu1Y8m5KlAdyeredDWP
	tLa0BDPyHe8cbqX51W/21BGa9BBInGpNEabBs6ypQOwJau+UkK9em0Je9nhl8H2ZD3BHwm4
	bYXqIAVw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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


