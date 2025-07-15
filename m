Return-Path: <netdev+bounces-207137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B70B05F2A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC93C16A21A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609A2EE994;
	Tue, 15 Jul 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UkkdV/Vg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FB2D6402
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587182; cv=none; b=gxG6X8v8nEnCKlW0SIa7AqxcpX2JIaDk2/UDKUReHEp4Zf5ANJ1VcjK2AlIe0V4ivOdCaU9m5P2kOdwEBFWUZlPpwQ7RsLY5eBxD3vPPbwcHCN9IqUa92IKo+1Xkl3GFgsM3ABshiH20Bj57lrcWMQHiL4oU+my3pcnlfimK1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587182; c=relaxed/simple;
	bh=D2pCaySHFq2pdMF2MaFrTGbBn8HmE7zZtjbdOo8bZ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9UFUeWsu5xIDWrRYvRwi6M9fpudISyvQwnoiU37muQlq5EYl4BPqqQpJwJ7JYpkb+LN36KjEn5kbXfyok8iEczzuecicsOPBKrLHvDSImaf0UvCMN8FLsGhFJduZiwJU7ZaMI/XxX2WoYsWnw0F12n2GXEtYN6RcsxxWSe3DAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UkkdV/Vg; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587083;
	bh=qr7vnn7eeOCjc+CY7+06nVMi7mZA3SUUNFXvLriFWI8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UkkdV/VgT9YKpmv2p5vCzhYaVpPNMkTX8GU0fdtGh183IOIzn9iWaPL4becCONlyR
	 s43uF9oXmg3YjsPvDlW779xjH/LG+PEAabjEnezN416RkwzZ4pju1PcysZQhGIv5FT
	 G0kyMpntx5Z3tdclegBhwT/HL+rWuCKp+/xojhh0=
X-QQ-mid: zesmtpip2t1752587071t6eb91e5d
X-QQ-Originating-IP: F1q5g6EsDf65gITeUTv/PWZUZ0Adu/pQEt6UQ7FSUXk=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:44:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5398797519423429951
EX-QQ-RecipientCnt: 63
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: airlied@gmail.com,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	andrew+netdev@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	arend.vanspriel@broadcom.com,
	bp@alien8.de,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	davem@davemloft.net,
	dri-devel@lists.freedesktop.org,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	ira.weiny@intel.com,
	j@jannau.net,
	jeff.johnson@oss.qualcomm.com,
	jgross@suse.com,
	jirislaby@kernel.org,
	johannes.berg@intel.com,
	jonathan.cameron@huawei.com,
	kuba@kernel.org,
	kvalo@kernel.org,
	kvm@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux@treblig.org,
	lucas.demarchi@intel.com,
	marcin.s.wojtas@gmail.com,
	ming.li@zohomail.com,
	mingo@kernel.org,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	niecheng1@uniontech.com,
	oleksandr_tyshchenko@epam.com,
	pabeni@redhat.com,
	pbonzini@redhat.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	rodrigo.vivi@intel.com,
	seanjc@google.com,
	shenlichuan@vivo.com,
	simona@ffwll.ch,
	sstabellini@kernel.org,
	tglx@linutronix.de,
	thomas.hellstrom@linux.intel.com,
	vishal.l.verma@intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2 2/8] cxl: mce: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:44:01 +0800
Message-ID: <65FC7B96ECBDB052+20250715134407.540483-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MIBXG9KNq+3G+djvcRq04GJo/lJ7QTExcLR0Jcs1NbhGlUExLnX/34EF
	XsDDRP7wWvyqRJi9XqI8USbBSJ7hPYq4WTgeyfISwFTmTapkAgmIYCsnePFCP1Mr+6rI5YX
	RYRizYwqSFM9iIM66mYG4kFQbcpw4eBPZpe0su+8wsH56irm247n8MWwXKGB6TijyT+vORP
	UxsU3H7VPTN48vIu3WNLog67Zm1OnSf3sQs+mC7LD+AlIQYsUSJ/5OJHDJj9MQK+xcFs+7Y
	PuZcWMMt5aJxcVUtsqGCTR5k+9Pbrqb+h5FXAbUG82fPiZC9UZbY8pTNP0RtQLV+mzrJPNq
	s+Nbu7pE2wUaV3n/e1DFBesPMJfLrGKqEnWPpEPq2kv5lTd1JPPXgvRLcpedIPHNGpacHaw
	noTscF9mEgjwLVd0kdA/VX2VwfdM9lPTU5waGvQXN6oa/SBL+63iLwuz3OzagD+76e5qiaZ
	3dMLfB/ypTdtFJaR74rJY89TSk0jypkxFpeD2ixA7kLiUMnEKWIU1G4QvQQavNgr6WHuaZt
	lVMoGAxnt8ZT/PiIM1NDpfX5/SxIq1XAFfTujVWQcOTabvdxh1jCTADRq7R1onovZ30rU35
	n62UI4R70vwqOlv9LROU50O3tdtbV3RKFMaSNEd2AZvjzb0XyF0vO69dUlaxnGXhEJIB1fb
	EAcAKNmnlCiTS1L88cuKarZvNU1zTA0yAx6zV9WukzOHWa89kEgcpFjhrIRuhlAUUTrx2lv
	LdUv1hay11mrQTt4LN9Yusus4B5K5D5uMKw6AnZs5nsStuyiLzCHgVBHNbVKDpU7pm8Lx9M
	7888vRd/FN3J7nFRxCBjfO+/JGkm1wg5pzSy6aPVcz+PJVKdfeTRnfeXDB/UL+hzo1MYJ3h
	AAOkJPUBWH3QwpV4shEtaBKTVs1JswVAcRkV4zW5mRBv39ILJBIaLT4B4gf/u+MFGGTbMv2
	mpWCz7FVLL1xzMZOXlaocoW66erhFerg3x78SjJfR1KosOYyaium0VMFA+GGr5UoE2ONfDN
	NRjygy2223PoNTayTuOIvwp2MsQQmSF96bbwiM58lPf7e+6I8Ra4PcMmLHaumHb54C1LuYd
	4HiuhsY1NPqzZdPYTUbHDnV/9ONJer2djN1WMF6968dxIJDlSfSngE=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

According to the context, "mce_notifer" should be "mce_notifier".

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/cxl/core/mce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mce.h b/drivers/cxl/core/mce.h
index ace73424eeb6..ca272e8db6c7 100644
--- a/drivers/cxl/core/mce.h
+++ b/drivers/cxl/core/mce.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_CXL_MCE
 int devm_cxl_register_mce_notifier(struct device *dev,
-				   struct notifier_block *mce_notifer);
+				   struct notifier_block *mce_notifier);
 #else
 static inline int
 devm_cxl_register_mce_notifier(struct device *dev,
-- 
2.50.0


