Return-Path: <netdev+bounces-208811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35622B0D3A7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5756325A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0B2D9EF4;
	Tue, 22 Jul 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hh9mf8Mc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B228DEE4
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169841; cv=none; b=jpbXGCog+tVT3NmbJhK+qwdPYnGZe6/CvfjSfU3W9OoiYVvIScxpC1IkbIcTsEho0h6s4PcDlv4Rt4+67LBx+nctIdvlKcUrRpwFZ6yZ9hjT0+P5cqBUDzXypGYR/8FWmpkKo8LnPidoJvCyz6Ndr/PCcXHiWb96/vtJTfDHScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169841; c=relaxed/simple;
	bh=TJadM9LJS2tCelUETqRvuerhKGeMiYlqvJ5GxFuV5tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxogWbwC/6MnRsmNZufBuRaT+T4bVPzimU8GAl3r3AcOhK9E7dvx4n6t+Bw2pa6vF7IhLR8cMiMg/VVF8g+iBRle1Erq/GWwuJhV6kyH1TuC05m4FYpaUxy6eJpkloal9LS/cXVhe3za27Tt0+r3vmKSfFFx7iYHn4ln6LF/F+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hh9mf8Mc; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169773;
	bh=+qa2f3QEhHEuh4QOwcxSpKUWx1Ey8PdHAyuKdLKK9Qg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hh9mf8Mc39i+ypXzkOsf4eXv2b0nYXHjypO6K51HtClWMOgoe8WiUCUOKgNrC7lSO
	 kswBdHwDqCHODQZxZ6qIfnz8LZ4/eguAmnzJfkAWwhxgggEZRer794/zfwygBOEXsy
	 Bh700+3qb0A6kf23H6xbSevPD5NtzbaKY2SbGXGs=
X-QQ-mid: zesmtpip2t1753169713ta05aff85
X-QQ-Originating-IP: 65xfAki0jxPR9TUF1QvLcfebtVmeg84+TUXILAN6dYc=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:35:09 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13454134674662907572
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
Subject: [PATCH v3 5/8] wifi: brcmfmac: Fix typo "notifer"
Date: Tue, 22 Jul 2025 15:34:28 +0800
Message-ID: <6CA31F0821E6687F+20250722073431.21983-5-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: M/0PeaSZFgmfDRY2PH2bScTqkyV/iy+V6VADbsPJ8tC2z1DZyfJx9xoL
	SKRjJk6SU3TQ54qgg6gYDknA43ANygYmoNRRk5wBFTay5Yx5tD7hnzsoocxTpZ6IR4FHeq3
	fftvaFKMtl2h7opf+ZrA8pnzutlM0AKlTAE3dxbC5UGmTSFz/nCBZU0YyULVFIhlV/hFATJ
	WBqQen4PKI1sDevqrBn3u4l5p7/D4788THQGfMBkX2B94KXinRQislG19bv7TrlmEXSf4y1
	Z/mSFbss76cCTnMemB/gqTrgiblOi3sJmnRDElG60w7IXSNVImh5laRiOK3DB929hDDKfiM
	8Lf8TMW96cj754g8ix0pmBVGI2tJ3BjhuQTrJFvLSPvEedq5fe9qlxvD7xG2TqxCmOtOYnE
	no3SmYxivhEWCa9D4jSjo4bbbJ2cm3RDHiDG9me7z5My+WF7B9bR48z+k6hqVG5DAlhCZca
	ogdjPrUSk6FGl3Hc/efIA+Gh0AsSc8vwwukjkW7KTczTJvA0OS76CqImZqwhv+t+5bhKIk0
	h19+QI26pb2KkxzWsE+tqSkrdameOQoDllGEEhwRUzIJFBh9Q/Ljg0PyCb9lskndmYgMUv0
	7Qxu7DTmr9zpMAJxGS3RDIuo0E+dN/pLaCXMl5PZUlxzEBzcn7w2+v4GKrXF4SJLPYa0Ge9
	IWORIABItuyHkqiWR93lfFJQ4WojL+0p0rz6XZgN+1qSnqjUKssIZSnaf8MLD2GEitPyZRq
	QDJjaMkKPOHcEzt8oOeRb2UnMFqSeawVIEHh+u7A29CJhxSkglfN/CNMPzf0E+WDvTggpQk
	i0HNvwZkJKExqMUz6ftC71ud6CLY11IQgZ+JFmaJyvtnrHd8SGHp3ZvRMhGWZD6sDAPk+7S
	qkORI1RshF9/i15fE4uZbEG3f8+iaLEpQJEW8ulk+6d9Z1V/cBgXWRbgb8euZPwYqsyCBKR
	H7wU/pvi4HQhwWtKRw7zU9pr6wQ+9oH5MB9ZGQAwb19dMTFu/gqTep+cX3FLlMaOYfvJbUI
	QvcZcrOuAEPCiL0XZjrc0365mD1yaMoOq64op5/y9Zx9Ei5qZN6sjhEshtWy37ij/YZ2Ghr
	dA02JSpFcPeVQAdOUeAYBS73VLL7EnFpDhyQqsQhpSGQa9ytZU+sDI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
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


