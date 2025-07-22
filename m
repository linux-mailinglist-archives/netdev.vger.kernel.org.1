Return-Path: <netdev+bounces-208806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE5B0D315
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABEE1884CE8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C002D46A1;
	Tue, 22 Jul 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iSOav6Ln"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE723FC52
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169397; cv=none; b=Tl/UmQOHNS37HJYw8m1kS0U7UQRhDzZOPUP2egNOf/KQoWc23KeBnZ3g8gQXp7f1czTYdP5QVvcF5BtzfsLhN/4TOcfed6z9u5H3Ic6AKm+ApsHI3KxhXVPobRMGOTYq+SN07rqmwPZZh5AXEhrgYijeWEIqXNn5DOx8C1zAQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169397; c=relaxed/simple;
	bh=BZK13xTTjt/5UmV5jMd6YK/1RBHQ5TbhsdLSTIR7ksA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1UdraRrfA/yKOXrBlYmtNLyEhyJqFqeuxnRZVnn0QySUVpKtijQBtRgujlt048a/lOisXx882r0KnsJfDyV0xEtwi4DsyTQwKsXQ6k9AZMNwzoeYSwsdDFpAbkblnrUxMBJ4N+UbsLdhE4qUyxRecIQplcetaRGBhRS1Eie8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iSOav6Ln; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169326;
	bh=x+S0lLyonKMBOYVe3hwfq+3jtrctPFlVfJ/rovDXpoI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iSOav6Lng8FvoeHsQ5EaVq6WcOa5VBdkUBs1J0knzzqJJoZedNzoi3UQP/bUqJgVD
	 qDSakpFzr8gZoLZolGbS+MhAHK9kIin0sv/jrsFd46jFgViG1OjMYp419ZWG52kfaE
	 7IToGnzVtYGu2GIHC99N4FKROLGkdjW+xjWoh/Rw=
X-QQ-mid: zesmtpip3t1753169263t53df68e6
X-QQ-Originating-IP: rTOvj0yplF8v1TzV+LE7s5Wipo1URwqutr9CN7Z1bPc=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:27:37 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4379188185935626122
EX-QQ-RecipientCnt: 64
From: WangYuli <wangyuli@uniontech.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arend.vanspriel@broadcom.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	jeff.johnson@oss.qualcomm.com,
	mingo@kernel.org,
	j@jannau.net,
	linux@treblig.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	shenlichuan@vivo.com,
	yujiaoliang@vivo.com,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	wangyuli@deepin.org
Subject: [PATCH v3 0/8] treewide: Fix typo "notifer"
Date: Tue, 22 Jul 2025 15:27:34 +0800
Message-ID: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MTbLGNmJundR9k3L4hhUbJN8ObUlVPA7XbHV14TgBBAfxrpD5Ypbo40l
	nZrsDOgyPnf+NL/d6EzXUG1uHE8kpUFk4fTguLEcOua3KIz0fHzkWIXjeg75SiRUq8fQJZb
	4AXg4eHkptFUHnf8Cl/aG11dJbDqlLM/nD0TyKENAY5EOl1zEXtVdQ6Az1SAxKfKubcjCPJ
	siUzVVUy6TrmUKgn1UZFv4oFu8Ogf9P/pyUjL1iGIu30Q5a+x5QBj49MkkhDpG3Jf5uN0VE
	90Lks4XTwRf+sTGUF3tL0Mrjr8aKesaBEeYO8K57eFxWJzgaFMtabjmM8tUeQ+rwxDoGPZS
	BUh9+KumoBYbofbWlmPrTaw2JNxyNGc+kQIPnmgG2xhdrFzaqja82U6LNKT6lNJgSPa6QKi
	sbYd7aOz/ZlcElDchI/1DCX7p7QYoUjsR41qAmK+VdTBj3WOL/bT5EQKFmTC2m6fnqtnpUc
	Crir85ke2PU382sIy0bWV0TStHdF5gAzXSZcUxS4niYJO+KLX3PMqF0tlEvyP83ZAI7SjfL
	OJcrpbnacSYRRca1Nr9e8nWLrRs8jUoMozvDCUgvJAaBkRtf4k3DQtJLg9MVvSt6HPTLyeH
	ULP30KOejksCzSLDHPstq7KS9yorLr0ZquQbfDBtt1KH+HfQB8PFuyRrZ3jvCOmmGlLptOb
	KjQqoVTd99fUNDs+l02nUMVdT8d7Zd23pTZNBk9egvtJvC//zLYkts3W3q9ZIAX8y/fi5s7
	0v7PoTJvQrdx8QOi0vMIHQJJrDoPEdEqt/wppDubBk8Xnp5C8MvwNS1909ey2kyl/B77Tt5
	BT8Juo/RxdrMmcjtSoPfqG1FKfybX8QKotz/VeDAv8e7DMFd1zxLDJeF20SLfqsTMGuZUoC
	6kVwp0yq+7AbXGAiBgthExtXAlhuPc3P1Am0ZXGQE5JxN7cY87bn3If/xUI7jUiT1ebVuD3
	ov5V7roqN4vsj+XCo0PJWXkl/P5VXarQqAcDB2wjyHB2+oPMoBjhqeWRbFw9ptZJqxaLe2N
	JKDsDdu9AAiPtyVjqh44MjyRxEWJw3YNqVzsftpUANgDBrM39OVskcHdfgkWuWS5b/9TOB9
	988tzCECp7Ls0QbVknq43QriqCApGGmhw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'notifer' in comments which
should be 'notifier'.

Fix them and add it to scripts/spelling.txt.

WangYuli (8):
  KVM: x86: Fix typo "notifer"
  cxl: mce: Fix typo "notifer"
  drm/xe: Fix typo "notifer"
  net: mvneta: Fix typo "notifer"
  wifi: brcmfmac: Fix typo "notifer"
  serial: 8250_dw: Fix typo "notifer"
  xen/xenbus: Fix typo "notifer"
  scripts/spelling.txt: Add notifer||notifier to spelling.txt

 arch/x86/kvm/i8254.c                                        | 4 ++--
 drivers/cxl/core/mce.h                                      | 2 +-
 drivers/gpu/drm/xe/xe_vm_types.h                            | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                       | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/tty/serial/8250/8250_dw.c                           | 2 +-
 include/xen/xenbus.h                                        | 2 +-
 scripts/spelling.txt                                        | 1 +
 8 files changed, 9 insertions(+), 8 deletions(-)
---
Changelog:
 *v1->v2: Break patch v1 up into one-patch-per-subsystem.
  v2->v3: Remove links to my patch v1 and add some "Reviewed-by" tags.

-- 
2.50.0


