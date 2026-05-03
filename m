Return-Path: <netdev+bounces-283566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FxnAMv99mkabAIAu9opvQ
	(envelope-from <netdev+bounces-283566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D04B4D2C
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4256A3004203
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072833A901C;
	Sun,  3 May 2026 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="NXOqWzMo"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B33A8738
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794501; cv=pass; b=s3Re2ry/Zr7rM1SLDd4jhNFD6RINC+ndXE2T8dkTpz7OVEaAw449tA17WC6GhWx5m09BKzapAbU3U7XyYvcO9qks8sc5xonDUc3QS0Xt/Mo5noKQnNvJcEdu6umZBzwgciEHwicdv8/7AAyVmAca5M2PYqzsE1MsO3XJgnFQjtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794501; c=relaxed/simple;
	bh=Ccb8tQzoShPuL0hmj7Pis15UJCYtR7HB0Kb58MJZkQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go4P0Rdi/DexVCkgsk660l4iER6yXX8MPXz9DIUd774N//s8UHNEpSVxMvPg7Vl/YsvZVyiJBEdrmKVTJw4PhdvHYqk/JBS17QyEejmXykUIhrn2wh0jlnzxPqXCTPcL62XH0ch09Nnap6/WMg7LUMaXe1UO3xICTrnSpqviR7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=NXOqWzMo; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777794477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LE90OCye0mWgFKIFQbdFDaUC1f9o7Uw9sGIpUK8GK+zOSzUCNNlrazUh5Oh67JSZHJSjbzffapG6pHv4A/0l63hyDgxOuXDZwUiMD0uLlt60KEK/3/5TVP+cKPcI6D+QDR30PBCrOWA3p3ES5xhgNoOcIE4iWxF6IvmsLit4ivU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777794477; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VvozILmGFLoAF0L6Dx1RZ+/DiEr0O/5jxn30rAr7BGs=; 
	b=XGVfg3Qb1X86GSt1KzTI97eocU3tiN/jDGfWMVRW+UIQtfFDDOGQI/3qPGsruddb4uR2KNCnm5dBoTQRq96RbWArL7YyqVj3DtupW63eYprflbzQa9tSa5qgTrqO4TOzizvG6Fbrinkg/7HBp3QOYvXznlcz3xX8Kxd+4onL3kY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777794477;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VvozILmGFLoAF0L6Dx1RZ+/DiEr0O/5jxn30rAr7BGs=;
	b=NXOqWzMoa2pn9Sc9GOsVXKaH7Xf+0x/THwDmOqPEvGqJ5kS6WA99IvYwDFPFrbVF
	jOrG01ah7FNs+wh9rNFfz3BhRF4tN9Kly1sEnMPXeZTpkbmxRlihilwRyldZDtXqJCk
	huWlXwvfr3jloTh4T88g6RnvS4YtSgjQlAmWIDrH3n3jYhZRAx6eiQ+nZzdvqdgZDWr
	P3IzE08EIhL3bvwuFvZCwWQ3WpJDGgAmebci8q8UIKhoaK0ORK2524DGZtX9+fb2GzT
	ACb2Y3r+ewcG+fZlodYpfnwSDyVtaCOO55tdDGo/0kFoTGowG5XTbiADtYVwAfmUldF
	DUqC8Uxgkw==
Received: by mx.zohomail.com with SMTPS id 1777794476094189.29802151061642;
	Sun, 3 May 2026 00:47:56 -0700 (PDT)
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
Subject: [PATCH v5 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Sun,  3 May 2026 09:47:45 +0200
Message-ID: <20260503074747.1321-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503074747.1321-1-maciek@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 609D04B4D2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-283566-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:email,machnikowski.net:dkim,machnikowski.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


