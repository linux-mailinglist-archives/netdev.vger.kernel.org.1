Return-Path: <netdev+bounces-281411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAfpJluT72ktDAEAu9opvQ
	(envelope-from <netdev+bounces-281411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F5476A62
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6445A300383A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE63D9052;
	Mon, 27 Apr 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="fgu8boPx"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920A3D9057
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308499; cv=pass; b=Ybb3+YTDxuAA7i8ldixUNzIooOQSUB7S7I9g3FTfXwrIKvkfWREqGQC2tt/U9vhukOeC3bVXydi6he/+OGN1RfelGhl2SXHYYf9pNxLftST9jR+sss1QPXzAP9he7oxA6RgOlyrv+BbnSU8MGvwEROLnZlBJ+QT++BUmYzl9uX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308499; c=relaxed/simple;
	bh=Ccb8tQzoShPuL0hmj7Pis15UJCYtR7HB0Kb58MJZkQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+9enQ6B5fDk8Dx8dewsK32bFAIrnCjtsRRmSYOIaxt6+EY+kzSuRft+jwUAcJYee8EJ23r9v5ZNHNIaFmSjrNDNUAAveOLu6JVARdlCPgQPeu+icMVPCS/8L8BJ4TMsmsFefc9tMvC5+QG9tipGBfndgwOI25GILlhca5plIo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=fgu8boPx; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777308456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nkrRzhNi47O7H67YA7mBQyI6ciMh831BNSSTgUCyMPO8xhfDBP+ZrEp4iUIX/yuKHRtF7NZDlto1HJ1GkZSXakxN3NicXlSqqLEFlrwruBrCT6aCjXLx+A/nMd87ieLkhJRUAaY6xLk4G2jPuF35KrIQcnbutBrU/3YlrMesMWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777308456; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VvozILmGFLoAF0L6Dx1RZ+/DiEr0O/5jxn30rAr7BGs=; 
	b=D3o7fmmiLsAyb7fHFIMxNAmhg9wL6/ukJW4icAZWphKFJuxlIXCnKC/0WZ8vmMKRzelRjr3EbP/pO2gHHpYE1SfGEGWiKbB3AkwyxxOcpvMzMcLsKKSP0Otfv8pUD/Nx+WV5aR7GMF1sxIumuNVCL6QlK8Q91hi0Y6qJE6E1v04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777308456;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VvozILmGFLoAF0L6Dx1RZ+/DiEr0O/5jxn30rAr7BGs=;
	b=fgu8boPx65zaJqFfBKU/wMDyKDSQiNCsehANajlpqUubADQEP+Mvbdez+B6a5PI5
	NYnyIlQ5ZVD28aM6Gl0rJlF+O4UZIEWXiy/SYsW4YsdclfchTlPyzZ0/y4Z/sCq4APv
	7ac/i0r8D3z5LXaQjSPiOgmVXTYMKqqgfDVkNkkJbiOe1GZGKRWoclnaxAYH/YTxTHp
	S570kCTojXibjTS02b3V8qgULf+Ictj+2WXvwaLkQiCON0zyhotdgeTuaB2EAGT2zFZ
	TaXzPDteFf/TgqNanMqH/66khn7rPOmFxYtpx1912zoplbCXob0f95976id2/xXs1kc
	F4e3M4zg/Q==
Received: by mx.zohomail.com with SMTPS id 1777308453461195.63604722562798;
	Mon, 27 Apr 2026 09:47:33 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v4 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Mon, 27 Apr 2026 18:47:25 +0200
Message-ID: <20260427164727.15418-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427164727.15418-1-maciek@machnikowski.net>
References: <20260427164727.15418-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: A59F5476A62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-281411-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,machnikowski.net:email,machnikowski.net:dkim,machnikowski.net:mid]

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
Convert spinlocks to SLIS to allow gettime to be called from the netdevsim.
This is a prerequisite for implementing ptp support on netdevsim.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c   | 26 ++++++++++++++++++--------
 include/linux/ptp_mock.h |  5 +++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index 4d66b6147121..7a4e5f3274a6 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -49,15 +49,16 @@ static u64 mock_phc_cc_read(struct cyclecounter *cc)
 static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 	s64 adj;
 
 	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
 	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_read(&phc->tc);
 	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -65,10 +66,11 @@ static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_adjtime(&phc->tc, delta);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -78,10 +80,11 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 {
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	timecounter_init(&phc->tc, &phc->cc, ns);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	return 0;
 }
@@ -89,11 +92,12 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts)
 {
 	struct mock_phc *phc = info_to_phc(info);
+	unsigned long flags;
 	u64 ns;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock, flags);
 	ns = timecounter_read(&phc->tc);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqrestore(&phc->lock, flags);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -171,5 +175,11 @@ void mock_phc_destroy(struct mock_phc *phc)
 }
 EXPORT_SYMBOL_GPL(mock_phc_destroy);
 
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return &phc->info;
+}
+EXPORT_SYMBOL_GPL(mock_phc_get_ptp_info);
+
 MODULE_DESCRIPTION("Mock-up PTP Hardware Clock driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
index 72eb401034d9..e33188dec2b7 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -16,6 +16,7 @@ struct mock_phc;
 struct mock_phc *mock_phc_create(struct device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc);
 
 #else
 
@@ -33,6 +34,10 @@ static inline int mock_phc_index(struct mock_phc *phc)
 	return -1;
 }
 
+static inline struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _PTP_MOCK_H_ */
-- 
2.53.0


