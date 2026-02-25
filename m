Return-Path: <netdev+bounces-261017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNf4LuEan2kzZAQAu9opvQ
	(envelope-from <netdev+bounces-261017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EE19A04E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C55B30B56E9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA823D6696;
	Wed, 25 Feb 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="R9LlEgKc"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FF3D647B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033974; cv=pass; b=J6Y5JDKkXSRYNHq6ZuFGpGzv/NMUujX6E9oHOn4BjawWl5CvVa7esZ64kKqTwb4J/95cR/zbxhSMCjqGPW0+3A6M5BLvmyeO9uS8omeM8l/pACFrZ3pwnLA1eA4eBGtsd09v6+d4s5BkCZMBVdHhg+NEP/Oy9aSsn5zA6JhXT24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033974; c=relaxed/simple;
	bh=KkHP/WmYHoyABJ7Pp2I09IdvqS82CPd2q7adPJHUveM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufv6MLT8t4wDsHXiGdDct+sxu+8m4DdKsFzbEkgG9Sv+8B99oys98qMCUR6PsI2oJgFv8M3wH/xHwHjZxahNz+I+v9EF7mxtrS0WkN5A0MMX+DdVfxXtOLqEFEYMsiH8+0SWo5dB+w9jTNX/Wj14W7XQZZgbdFWaeQg3/68DpYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=R9LlEgKc; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772033947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U2FQKLPI6FY5xuuQ7BFZ1/4K5Yscllme41oNVRfjW5+jpJ+o7flmtFqZkAHlf1K0+9Pb0p08SBjNBMpFZmOSsa/BHDxNa8D6rAHEJHGNxHpJQG4Qvn9lIQyOu+LSmBxu6EIgrMnfWEZS5TLKHU+wdo8czmFHazRnLLB0dTEjRbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772033947; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qxyz+e5WgH2PE5lvaornaU1Ho88TCch6blCD75qrlPo=; 
	b=SmCK1MSoGuYMWVGiVnRfzsPdZ+cWMAWYLMNeDFkDcgwqkOC3oxmYkTt5bMDSTzfPXbt5Do8X2tuM6nmxTW22FYGJibxgXrCGSVe62Ir7XBCn1T+l3TW5qVToY0FydrU2qVIU3Rr0mEKBLNffAYzYSR7W7xu+vR/MZPMfcTIHvuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772033947;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qxyz+e5WgH2PE5lvaornaU1Ho88TCch6blCD75qrlPo=;
	b=R9LlEgKcNW38ezEyHdzhjDDv20Lz/xsuPQj7LJ50ruY6gKF6ciNYVCu8T09V6qc7
	+/WDGdv6/CU/lyw1I4OyGclGj0/1fS8YptsOq50sTyM6K8W6V7NXjmd/wz4/1iWUpcY
	qOjyJ18J55X1T32UGgR/cwhKAm+Vs/9xW32aUXcIoarIAZRQ8s0ash/FVSbtSo69+JW
	o5pQrAU+TvV74EmdTfCgVtubhJSBnWYloIQVEOBIa86btvewFLNSBvbGXN9MM2a70gv
	wWEY354S/Tr4gkZJLsJkb1ulACu60T0J6znfgWJ+J2ln03V4f/8UJsUkKm6kNAKuoZW
	WsEFocwzFA==
Received: by mx.zohomail.com with SMTPS id 1772033946043145.560522665166;
	Wed, 25 Feb 2026 07:39:06 -0800 (PST)
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
Subject: [PATCH v3 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Wed, 25 Feb 2026 16:38:56 +0100
Message-ID: <20260225153858.29486-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225153858.29486-1-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-261017-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,intel.com:email]
X-Rspamd-Queue-Id: 7E3EE19A04E
X-Rspamd-Action: no action

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
Convert spinlocks to SLIS to allow gettime to be called from the netdevsim.
This is a prerequisite for implementing ptp support on netdevsim.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c   | 22 ++++++++++++++--------
 include/linux/ptp_mock.h |  5 +++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index bbd14ce24..8e48317b1 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -54,10 +54,10 @@ static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
 	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock);
 	timecounter_read(&phc->tc);
 	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
-	spin_unlock(&phc->lock);
+	spin_unlock_irqsave(&phc->lock);
 
 	return 0;
 }
@@ -66,9 +66,9 @@ static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 {
 	struct mock_phc *phc = info_to_phc(info);
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock);
 	timecounter_adjtime(&phc->tc, delta);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqsave(&phc->lock);
 
 	return 0;
 }
@@ -79,9 +79,9 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns = timespec64_to_ns(ts);
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock);
 	timecounter_init(&phc->tc, &phc->cc, ns);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqsave(&phc->lock);
 
 	return 0;
 }
@@ -91,9 +91,9 @@ static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns;
 
-	spin_lock(&phc->lock);
+	spin_lock_irqsave(&phc->lock);
 	ns = timecounter_read(&phc->tc);
-	spin_unlock(&phc->lock);
+	spin_unlock_irqsave(&phc->lock);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -171,5 +171,11 @@ void mock_phc_destroy(struct mock_phc *phc)
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
index 72eb40103..e33188dec 100644
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


