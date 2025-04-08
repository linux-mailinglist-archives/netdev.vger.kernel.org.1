Return-Path: <netdev+bounces-180098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A723A7F930
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC39516E0B3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D0264A77;
	Tue,  8 Apr 2025 09:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EB264634
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103835; cv=none; b=e7cO2Fg2Ib+vuqX53+QfyLGZOUCTObSekkDvjmk1kccoxTNNOutGvHumYYBSuPZySQin9uNRuGQk+tc+cZ3N26kwIQWNDKMdRegHIODzf37uGYZk9RcXRXr5wYyzBQVsLE2lc4SF5n9BB33pZ03RulDXs/klfO7t3+m2uxOUDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103835; c=relaxed/simple;
	bh=u2x+V+tPb4xDFZ7lkdGNS63PzEUZk98CNHeAjjEgmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKzBfJzr4jlJWp1+2XZR/tOeBcYW4gNTYQ7VmMahfgOeG00zfeK4JJHCQXU+41GjCmkypHE+oDswg0QECPi4myoSgwyHwYGdoiHUI2ctLPx7D9RS0jYVvsg2G+PKCiIa1B0yJsD3L3vDBikVCxlIr0xll2mRFnduAF7aHg7/lgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz3t1744103791tdac832
X-QQ-Originating-IP: MZ7Yog1ZCeopAavtt9NtFT5WKz+EnMA87pBdBzh6lwU=
Received: from localhost.localdomain ( [183.159.168.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Apr 2025 17:16:25 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14428587978993665036
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v10 0/6] add sriov support for wangxun NICs
Date: Tue,  8 Apr 2025 17:15:50 +0800
Message-ID: <341CBF68787F2620+20250408091556.9640-1-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: OLsBWtCIHsg65JgQPeTenK5s3neg4gxe0aFTumUikPbT5recDoc+DLn0
	igYcGNd1EX+OgQGiinMJHnp7T89JSyZVtx24RUYtaO/vyGyw3p4RBqKh4wS75hFq2jlRAyX
	BFXyXSavPK7ofKYN3zM+GqlA2wotsf+6lkJfAxofbSDIxwKrhOVU8WnmHITNIGAt4OfWSGD
	oBRoDXHYq2MYZbEphynF66bDW9gZCSAQHrQmgp6q6O2k1+T/TeO/jy+WnXlrtK8GKerDrB9
	e4JEvrgr1iUoAdSC1yXE7WbojPK3Ic6LmFWcpo4/Um6mLJ5rjXLd0HNKsub2j2ih0oTRKqT
	96K85cjvwT4alLRldrYBQHrkyVWS646c/n3u2Co4uYFPNUOykfi94dsOHCTxZ+KBKPasBRN
	ZhSvvXJK/OqLa8k/TV1DP28CftOfcs2IlAs3o47e2b4WmvCL9/gYsIFqXwhhRY6LH1QqckU
	P28UX7oUmr+QGgEIICTmm57IZuTrV4pDeCPMlsafj82uWJDLdWqaUebHQAyymzHQmlHS+gA
	yO9Cwu4d5aif7GiZlIg/ImrNjax8NlfPIyXbQnKGMNKriJ/ayO5or76Kvnd+eoiQ+GskoCm
	OlWFZTc4VXT7z69q/9TNKewXcJkmT2YdYY80i37oyvIrMPEBh5u9kAlhG+JxlhtuuXAyPod
	QazGBhKx721dl/1GHHp9xnRVG/rS8sHqsef8ykGt4fItlFpHHlboYZ9QFz+3+4jhd43ZwZY
	TViRHFyPbM+Vi5LcnIyymeb9sXqYvpl6KomPvK4RUfOHQoa1ETiOQ0V9Rbu7NCrDBmDSoJF
	Tb7i41ZBEw2wyUIXU3qAfr4eojm3Ic9+xEpaxNQqoT92xYsaRdWCjC7tpbtR1N227Xx57IE
	basBA5KIEagaXNdD1SX5j7zi2jpBjDuZLNyDGcC9eH4iRXlbya6By8sNskc5NJ963RNUhJO
	EFgxvDuVVzbkV9WVD1Na7pUw7VbQ9XT/6LfM/mehuAvHMr5gWGfg7snnpGP6shs91FPVujD
	xKoeDZXYu4XlduLGMasJyTO8RLpDDDTE421BvmXw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

v10:
- Rename the function name for handling ngbe interrupts to make it more readable.
v9: https://lore.kernel.org/netdev/203E2DE385ACD88C+20250319073356.55085-1-mengyuanlou@net-swift.com/
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


