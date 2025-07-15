Return-Path: <netdev+bounces-207136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6269BB05F3C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB131C26E9C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A82EE969;
	Tue, 15 Jul 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OZuPSAzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6D2ECD2C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587148; cv=none; b=mdlUJ47lCYWiJjy5ZpA2CmcK1ZcoTW0F4wKp36GtUc+p9+tkeqSMIRVREhh7wckWjM5Goc94nKny8mdcYMkMSX+4v+b80Q5RF6ziX63lXR8WxXmAxpPvPOVIjiCAdwK89jQRyDxBI80uu5Dh30JioEDDNHBlvuQgqyWqphxxP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587148; c=relaxed/simple;
	bh=TZJTn2E5BL5VAE49e7YaK4SCRoFGgemXPDOntw9si8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzAJlGkPr1YttYgML8484bvAWkUhgiYIbSNwtEQAOwIv9pV5Wkv8DAe9ZP0ebA1Ro6cSFtTB7Pm+POAH7oqiBkhJTrShFZK1xPdLWhsVYRrhBjVxH3DDUtSswhwTn7gBjyr7hsFFQNlmiBqWp1RH7RoM6Ros86Itl4XJLSuvM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OZuPSAzw; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587073;
	bh=IjnQY0kPhK20QaffYXVWEq0vHT5rpi7BYCx3cV6Q92A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OZuPSAzw/znlblyI0bHmsoUFw9GT59ynhGDp3kiqGRyqyteMccLtaWi/wwp2jFIR5
	 m/P4hflxCxhj27DnNbJn7/ubi0zOoS9+uzS78H2Xeq90eLwEXyxKlBYGNU1fkvSXcF
	 BefoPOtGk8GZLHtZRLOp09AR5FKixg0KyATgNVjY=
X-QQ-mid: zesmtpip2t1752587060t139a5737
X-QQ-Originating-IP: /8D94xQN+8JOFpNiEQb4FTVnmmcArlmhUzeqfbRCotE=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:44:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6857427455089537098
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
Subject: [PATCH v2 1/8] KVM: x86: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:44:00 +0800
Message-ID: <2EBE0C87C4CF3E11+20250715134407.540483-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: Nb87VresGnpCS23k1MxyRtnKmMkGU+gL4g1ixvHfnuRgrzRXsFWvDaFp
	sIbwA6daA2icdlVoomQ/He0dfkxddeLwDvl56DI+c/OmHHu2omJLOAa7u49mROafSRsQg/W
	msHdPq08io+okJZf63jW5IGQjEtwlmXW8onx4Emvmh07N1pW/MdpxTGlTzf0Q6yxHIpU4oM
	+yxkvUDj8AOb+jAv8/wXHC0I7LMh/eMNh5z0FXVpcE+Vd5JXf5OpDQtNKnd3zCiONy8FWsG
	S2dWqrHtqNVRfa0zGjVJaRsICFi8ptRWb5OYxhDNy7q18hwyWj4tI4I8TWdJJhDOU/bi0u8
	stBtOKPNlT7MmQjYbYTZtcpKm2SM4eGB7O9FzcN4kSUL+7tTIe1XnZ669jLARVFpEYf+Xzk
	Esuox1ZFpNKWWvYpNFXVsrIA8QHv0nY1QP5Z9QWMoNMwU1BdhPmtTxWET01R89+S2pLD9YT
	hWQ26JBd1hr+zG8GDEcbMspxjaf1paLow8RfABxdCYrSqW+GZqw1HYL6FMe7RYVVrLCRSeh
	t8gFr6KsvbSAO1M2n6WnH6RwJcrOq9rtHOVYpgiUo5B3Wrx6iUWb8kj8tTb7MpWNWmXZAsr
	XTgLm1BrcbiiNHYJ2se4V9BfbUgnHXk/ky9YX/4znsdjhEGCQF7r5ZzE4no25uPrU0B/avS
	DJoZRwkJRvtrPvMFmLUMCxr9nhB5QKiMgofXy9QYvfFimrXfGFdRQDZYOdAdPLBNCa7N9wB
	uVDgEMMvz5I1t7M2aUVrA383QdiDSMOCnkgz37OjjPquN62Uqyh//G3AOah32lXLOcAqZH/
	XPI/UWb+73YCjp9fd+OXRfFS59mquPjrvWqDi/wJIKzXKpDXd8De/8BZrk5PJdnNjDf7vfB
	DzKxb7yPkJ6QsUPHXJrCKByVley93YIfHiHLpa1Jw/fxdixspqf81V54MUeMEL18xkNwFGr
	ufm4EnkeS5fX+xsMRfh/hEESIcKNaqarBN4PeHP1XL69mEf0PzdmXp8Eh9lx1/p30Z8/2hm
	uZptMNajBE+epsdJ+d7uvIyzCODo1hPhGsikcitFi++UWX2zXe8wPkDi/HVXi8n/tz8+QPt
	+TBK1uLLAvg
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'notifer' which should be 'notifier'.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
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


