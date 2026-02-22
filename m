Return-Path: <netdev+bounces-260019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG4SDoJJnGmODAQAu9opvQ
	(envelope-from <netdev+bounces-260019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:35:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B804A176263
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FDDE3029745
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163616F288;
	Mon, 23 Feb 2026 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="k3NrmdNr"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEF34C9A6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850112; cv=pass; b=C3ylpx7muPrkPedIplju1UR5hCBoIiQoDw1FeY7FqvWMiLgjPqNEGnpxqG/4RPEzQzgWC+XnI4FDB7MLKlWcZsIz0Sl1Bcj5paOXw5Dhvm+pqK4VdlMs6SNTVF+Kov79hDqJxtHqskWeZyqAf3ZkTagUp8MH4Odgtfren3evhdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850112; c=relaxed/simple;
	bh=atyHQL7+R6L+rEXdxrxFOCu09FXntoU32I7KmwE80sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS5IJXKDdE+VToPVpux6DBTpM21XWekwzCxYRpBBe461mqK1xBJ/IeLFsjAtYY969z7Vxx1Key+GAhTuMQoc2vfQ89Fc0RpXd23O5HRQboo5p/+X6CdoHo2n2Iz2COrz0IpfDsQ8cGDW5JSZuxMchl6JRp/ciWy9AKocGVF+DDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=k3NrmdNr; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771850079; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lo2a5TBLHYNSQ+bbrAKN9MrOxulsdZm8ilTVl0siSucn+/meykeGVttQbm/+LwNB+gnbrz3v/bahw0/E6657fUyyJP99U6sUk6oBUt/jeFRuX+keGqn4ZrBr/dlnCJ8+RuufMD2YVIVXBXf/O9l4W+ybXGEd5IwC9v30U1TTZDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771850079; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nr1Q5ECnVHSexN8+yrzAVcn6kkWk303obCvb6A7N9f8=; 
	b=HvxV8UrrOEXGbM9u/bRo14CCe7ub/OT4dEMgD9eCzKVV7wlhG1TQuSUgS5baeUoegkjPIeL3AFBV5fH7HVCyv9l6MC7ZS5XzNzX+VBfQTTPzY2TL8iyleQN68Vl0XiPQzIUx2idHnakzykZFau3aujsDbAPpgWYJ+Dje9mycd/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771850079;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nr1Q5ECnVHSexN8+yrzAVcn6kkWk303obCvb6A7N9f8=;
	b=k3NrmdNrmIwVAb3TZpwGGrdIJYNws/0q/XKyoGcZ/PsP5eg4KVbKZsnlIUfAOdFK
	huNIBpasNG51v11Frk5oPydAeqKTQ37MvG+hmsGxkJqGl14Y3QU9jY/q8mXsMBsqp2k
	P4nwVLgmLJn9cHmM7SOnPj3fQ4kAeaRUj3dRM12juUPsaMpeWVw6P8RYi7lA73qm1HI
	HTZyLNf3rMfwnrXgprggvWbJA95vFg3SFejIf5GdeTWsVVw7xa7bkq8Ndb2L5AtNke4
	Ib2TEA/AH+UKuoG35mV6dpPWWXj8vaj90YU1LlLK1f4CwThT3UFpa6BhCUbrs1K4AMK
	k4TXl8S34g==
Received: by mx.zohomail.com with SMTPS id 1771850077487108.68038413187787;
	Mon, 23 Feb 2026 04:34:37 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH v2 net-next 1/3] ptp_mock: Expose ptp_clock_info to external drivers
Date: Sun, 22 Feb 2026 10:41:08 +0100
Message-ID: <20260222094110.127927-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222094110.127927-1-maciek@machnikowski.net>
References: <20260222094110.127927-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260019-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[machnikowski.net];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B804A176263
X-Rspamd-Action: no action

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
Convert spinlocks to SLBH to allow gettime to be called from the netdevsim.
This is a prerequisite for implementing ptp support on netdevsim.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c   | 22 ++++++++++++++--------
 include/linux/ptp_mock.h |  5 +++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index bbd14ce24..84cfee4aa 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -54,10 +54,10 @@ static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
 	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
 
-	spin_lock(&phc->lock);
+	spin_lock_bh(&phc->lock);
 	timecounter_read(&phc->tc);
 	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
-	spin_unlock(&phc->lock);
+	spin_unlock_bh(&phc->lock);
 
 	return 0;
 }
@@ -66,9 +66,9 @@ static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 {
 	struct mock_phc *phc = info_to_phc(info);
 
-	spin_lock(&phc->lock);
+	spin_lock_bh(&phc->lock);
 	timecounter_adjtime(&phc->tc, delta);
-	spin_unlock(&phc->lock);
+	spin_unlock_bh(&phc->lock);
 
 	return 0;
 }
@@ -79,9 +79,9 @@ static int mock_phc_settime64(struct ptp_clock_info *info,
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns = timespec64_to_ns(ts);
 
-	spin_lock(&phc->lock);
+	spin_lock_bh(&phc->lock);
 	timecounter_init(&phc->tc, &phc->cc, ns);
-	spin_unlock(&phc->lock);
+	spin_unlock_bh(&phc->lock);
 
 	return 0;
 }
@@ -91,9 +91,9 @@ static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts
 	struct mock_phc *phc = info_to_phc(info);
 	u64 ns;
 
-	spin_lock(&phc->lock);
+	spin_lock_bh(&phc->lock);
 	ns = timecounter_read(&phc->tc);
-	spin_unlock(&phc->lock);
+	spin_unlock_bh(&phc->lock);
 
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


