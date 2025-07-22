Return-Path: <netdev+bounces-208810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE894B0D3A5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5390156281F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289542E11D6;
	Tue, 22 Jul 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iSi/eWuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDD2E3AFF
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169825; cv=none; b=hQeAnPw++X6FSZTGbITe8z8MtUuUdpnXIqKYO526WfuwNyPdjSvJWGWmX/evvoK4sC8pqxey9o0Bz1OUpIj8diFIfZNwC5Oqek9WXgzvGuCpXHj4e+lxIPVb6slVJmBgRdCrrKrofUD8y/zfrjU4+oN2iWuwg2lltHjGrh0YH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169825; c=relaxed/simple;
	bh=XoTSReRIWl23BljKqA2YUSyIT3NJWPVLgQNbiD9Lm4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXW7GkfdO+M6E8B8fqlLA7lR4l+TkeQeYcS4tJ8wHLnJ7zk+lqAZfAEASYXfFrdBmcrKtuHqDOu99x73dyV4HMYE2xQJKRrJoiedxd/4vU8EiOMmUGTO+r4Xq8gjB3vz6ZHcPTRUJHJMgIp2AH5XcQkBzf7g5jWbOIKSjTQqkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iSi/eWuq; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169746;
	bh=1DFykB4IGMZc95pr0nP6WV8K6S5/SNh6P26mZWnTYNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iSi/eWuqri2aE/KeHOMA4MRHdoWkRYYQwalQht4ELhrq3ORP7LSlCPnBsE75bthE8
	 6mQKY+VT7g4mvlxYm4hhce2FAp01CCqw5r18ibyNvS4w3/Welf2dNvgSgMf8UUmREd
	 yEyyUmvLnhfSqLwqvoy7rZ5ha/vWIv8R9x34PEWQ=
X-QQ-mid: zesmtpip2t1753169680t1d8848d9
X-QQ-Originating-IP: /2Vqiv1DKGDiDTOeHrTcoDDvJdzpiY2SWG31K/OjoKo=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:34:34 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12305455310709652104
EX-QQ-RecipientCnt: 64
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
	wangyuli@deepin.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v3 1/8] KVM: x86: Fix typo "notifer"
Date: Tue, 22 Jul 2025 15:34:24 +0800
Message-ID: <7F05778C3A1A9F8B+20250722073431.21983-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
References: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgaJKxROpQTjpj1dawfBAp5BSKyrzx32+b+lvgiwlIqmeOnmN6gaJuqT
	kpPq0Tcw7FjvzfD1y4yMicxRTECnWGhe243OBCOx8JWCkHjVmCV0lj2Xz2WhGCyxSL75MqN
	juLqDstsXTzc33gWmclCnZb/vwt5cxfXDIncp4wEzQ0NDhaCyTxsEsqGWRbWTX2slZ1z2Yy
	RFOy8avkO3moq6N4JCG7enVElGkKifijhIwEp8EP9n40czRfGtDLVkijXF7pLHhw7daaybO
	0afXA4YR8+5A8ZSvooyf8jDET6QdgtuUl8cxmKADIkNQbLV0s20ruREzEgTs8+SLFjixcFs
	xQDw39cadCJQ6k/Gh8uM5ahHYKHmoLPwX9SLZkn5ojEZC6ZVyF6cTBGIiYVe2sSmUtTeQAO
	nfUfUrrpTtBM9i96G48SJiObIHL6F57CroFxye9WSPXvEkvuF/nG7AAo2Xze+B0zs15UFdD
	4B501bEOL39ZdD5b2C3JU8Dcm4usU5q/LInKoUfk4x9eSnueX8jrSnhNi4nWLOrIYw/jR/m
	jY67P/6CkRlYZ0dqzJPWibJKRQ0Y7rh+gGuBVRPAfef7OHAfXYuyKv6acBFbpq18C38U5cn
	z9Zd5/JFd7hta74MCQrcrLTKiDhouCxVWUN9BHvqyCX4I2bizlLwS94O2tjJYrl1PmmsvgK
	uxvPWOH7FLeFiVDM7YUZWzIMenAsK21hn644n39QmyQh91BNxBQDsz4UbWK37qoQK3+JT2d
	MduKFEFT1DDJpNB2HMyMAtNO7UCToLbn/3+T0+mZ84bB0Q405t22J5LmddoskZn/HT2M0Q9
	EcetZVVDyOOM+3gNrh3TZpXPVrIjZHHX/q+fe1SWLtwlqauJEmSbTZkLHqEPZOooUOgxBUa
	mdSEyATRlytmE6+ppkWvxz2KZeGHjBCSp7NuP3/0m8fI7AU2f7hnp/mv9NNrzLXRoAzu/SM
	SyF5icDmtTMGyMcEQqUThYyQspC9RIHWIBmUIo61NAhmXRZqlf/2BKrIKPB4mNOyEFYN68G
	EyQCIp+FRUY9qAleIOnpCT+0W7BctHf4f5j6fzmgb5uqp5jCMhTTaUbQGfrBltB+wJJgwaO
	n5De1kXZg+J1GTPt5CtLvs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'notifer' which should be 'notifier'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/x86/kvm/i8254.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 739aa6c0d0c3..9ff55112900a 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -641,7 +641,7 @@ static void kvm_pit_reset(struct kvm_pit *pit)
 	kvm_pit_reset_reinject(pit);
 }
 
-static void pit_mask_notifer(struct kvm_irq_mask_notifier *kimn, bool mask)
+static void pit_mask_notifier(struct kvm_irq_mask_notifier *kimn, bool mask)
 {
 	struct kvm_pit *pit = container_of(kimn, struct kvm_pit, mask_notifier);
 
@@ -694,7 +694,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 
 	pit_state->irq_ack_notifier.gsi = 0;
 	pit_state->irq_ack_notifier.irq_acked = kvm_pit_ack_irq;
-	pit->mask_notifier.func = pit_mask_notifer;
+	pit->mask_notifier.func = pit_mask_notifier;
 
 	kvm_pit_reset(pit);
 
-- 
2.50.0


