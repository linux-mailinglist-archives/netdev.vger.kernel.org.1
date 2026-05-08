Return-Path: <netdev+bounces-285894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF92OVn9/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE44F8685
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B7C2306C107
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4B3FCB15;
	Fri,  8 May 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="HF8Mdl6B"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3003FA5E5;
	Fri,  8 May 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253077; cv=none; b=ItNwBluEOGHiD570wJ9zHdz8+hA/bEj30PZ9rWXv+mSF4pePbAaBV7vBeP8vS1Ej4la2uluxdCxw+wJuntQ61E0TjdVS7dEq/GyiI1FEmSuMLUv5Lqq9xdDUqOiwFBWSMH5ZcWhDyN6rdfH6j6qjocAaCnlvXV5nY18jGuU3EWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253077; c=relaxed/simple;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sku3fqjXJP9zlxsKJ30q7qz+9RYdXDdAKdiFm3HCUX8N95clEw+eQpNvq5hDFs6NDoXxhbMfBtqGZXGKopgmGqoek30Zw6aRg3FnXlA/5K830JtXUjomUviRRklk11d2/bmknKNKEyztUT7rNcWCVPXH41L13DIto7yED7tpvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=HF8Mdl6B; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778253064;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=HF8Mdl6BuAbowRtZ95aqKLr6ndy2tKUUdrFnUDaeMNQg3CnjB6vuN5DNlMxjRI4s1
	 talmPy2JbzcsxEn8lB+SPg1i1FC418LySzOdyG392OCJFweYDIVeJEyiW90qyGVaw8
	 WJKjQSSPmyz1Us7vncklUUdzWaX1t7M9F0/9/K68=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.131])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 648FB270013311
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 May 2026 17:11:04 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v11 3/4] ptr_ring: move free-space check into separate helper
Date: Fri,  8 May 2026 17:10:47 +0200
Message-ID: <20260508151048.183125-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FDE44F8685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285894-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch moves the check for available free space for a new entry into
a separate function. Existing callers that only check for a non-zero
return value are unaffected; __ptr_ring_produce() now returns -EINVAL
for a zero-size ring and -ENOSPC when full, whereas before both cases
returned -ENOSPC. The new helper allows callers to determine in advance
whether subsequent __ptr_ring_produce() calls will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_check_produce() indicates that space is available again.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index d2c3629bbe45..c95e891903f0 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,20 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax(). Callers must hold producer_lock.
+ */
+static inline int __ptr_ring_check_produce(struct ptr_ring *r)
+{
+	if (unlikely(!r->size))
+		return -EINVAL;
+
+	if (data_race(r->queue[r->producer]))
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +117,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
-		return -ENOSPC;
+	int p = __ptr_ring_check_produce(r);
+
+	if (p)
+		return p;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0


