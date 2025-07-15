Return-Path: <netdev+bounces-207138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FCB05F50
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5341895040
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED6F26D4F2;
	Tue, 15 Jul 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cYNpNWbY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFC2ECEAB
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587185; cv=none; b=d+O/rygnZN/A9NUJjYRMQOZcHjggAPy+zfbv+q/YixRSjRBht0OiLsWP7O6PZvKhQurSFPn8cdaTtlZe6cN34v8SIsuww3tUXWXz0IGHADUemuwh/5VI7b7f9RrHPkzm5mRkFhCqCMfjI3N4bxgTEf/PMKMKHNOibhPQczO7t2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587185; c=relaxed/simple;
	bh=8dIVldAh6hyQxQjJbViplUyqI8Yi/pm1smKWNs7cITM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfM/P+PyKWZNzidd3ekaV/x1uGDM49h+3UkJ0EQyaHW9PcZvdqDCYGa3ZpoEZfXLHmIRzzLcd1lKzp58ABoV36Vi48u+c007iYhUUUCN14P2BuiI1tW4D6Bb9kHSjZIcXzdsy8/6/vDVmlGTN4lu154uPR9Sh7tKAzCrcEAOfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cYNpNWbY; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587119;
	bh=VbDjsaSgaoEPlFZ9K3vL7MSzjcmGihKEVnrA99JNOYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cYNpNWbYqKgbtSDrgMMfjJ2xkHgZRACyt6gucq3evEQo11N5w57rJeRzQ7B2fzh9e
	 Wvr4qxNetJdS4xTKmYCMM2vK+tntv0eZYCh5l36LjGooQUOks3svE9xekEGP1XEEL2
	 zPbk/ivgtwq0VZZgsVVizuezciF49dM5Ni64086s=
X-QQ-mid: zesmtpip2t1752587106t97bb4b6a
X-QQ-Originating-IP: fr1CmoslNJ1j99md0Ifh9EAzvQnNvfGQS6SMdf3j/kc=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:45:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4765109323548060574
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
Subject: [PATCH v2 5/8] wifi: brcmfmac: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:44:04 +0800
Message-ID: <F92035B0A9123150+20250715134407.540483-5-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MePS6OpXFRzsqn1o8qS2dUPDhMEswpCG1KClHf1FwvFwdAVd2sp7CN6v
	0PXA1LMFxzMkaX3JvOPk4NTFIUFVCn4MwRpRsl3U2/8WB7o6oh3L38Mo9tiJPDLlPxV9NFi
	xqy/yDEafmu/HkACmRuUQ4jGk/X55Rq1GwghGyoL7q3/QsrcaF6wNBZ8t3cVyLxznMwRZWl
	ATaYV5TAyCU9mx/dkjI/kf3U7HHP9GV+e6/Qg3JJIDjv0uRzp3dAHOdR7KaUpLH9RFvZEVF
	bD7UaW5YsznmwN2b70fzQxfIrQOBiW9zyYoaPiCWeV9C/BVezGR4zxq8hcKdo0Oe4KS7k21
	Pocmc/TN3HdgBazuXgqMDM2QY9zsk7UJEW4yxC3xkc7lpAo/hJot0cvb+tpdi7avinEi24s
	0wr76voeGD466BpX/jPe4hALBUV6zCifhAAQ6b7fz08FWpC9IfJSwppnYdaJCMFQ5cwT0Ho
	WPqVCnEWl/Vtc7gnOR5sGCwICZ/mRrrG1cPegFY5vyL31jVgXkIzI6iW8RXc5gzr+7S9WT2
	cMaw2G5t2nCUun/P4W9yTAR2fnw5QY6ruo6ei/2Cgs/FS+mzsNsA4QkjbvpRcoFec9UACxI
	jrTHC5PH65sothAcp/s5UuCg1YG341TvZQFbaO6t4MLpOqfRaCjpV0ftw3QhZ7MpsMkMj8j
	u287ZfoflaTCWi9KrG0vG+Mf3ZbGOusS3OgkWhVWS7o8mDjtHaAYeiqT2E7zCNDEyiDUO0L
	ZWioz2iy7eBH89lps6Y+37QF88gu2Y0BxE3QOdltmqW4BZdgF0krfx0OZcHvhAs/8XtGnbd
	rWrFHALIUDGeVRW83aCpcavdrcBN3koAj42q91kBZcu8bdMDI5DlTqNES0PRnUcuLHczDw2
	aUkQ1mIP4be7HeNfe/5DJKpOx4An8Ysp6REvUSJjQ/Kbu/radTf8+Ls7p/DUny9vsq/8Gsi
	seYgpMOcEshlfYCXMaWZ7nM5KY4wwCgdfHlVuplXEzNZj7phdp52/dQdRTzeq78vApBWAr/
	D132IaaNHOS8HOP9n0vxX4iJZmUWPX4GQHHADO8Whk/rHEfqBSEtzHdotqJD5hSW/msHYcO
	P9+GQKCAP6FLd8e509u7rufHWzM8QrcidrSrBRX/v+kkPZXrGmkf+r3i7IWWJjcRw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b94c3619526c..bcd56c7c4e42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8313,7 +8313,7 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
 	cfg->d11inf.io_type = (u8)io_type;
 	brcmu_d11_attach(&cfg->d11inf);
 
-	/* regulatory notifer below needs access to cfg so
+	/* regulatory notifier below needs access to cfg so
 	 * assign it now.
 	 */
 	drvr->config = cfg;
-- 
2.50.0


