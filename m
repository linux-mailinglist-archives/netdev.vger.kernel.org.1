Return-Path: <netdev+bounces-267054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AErCKs26smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:08:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F152724A8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02F3312C1D0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5795D38737C;
	Thu, 12 Mar 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="L7Fn6Usr"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B12DA759;
	Thu, 12 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320824; cv=none; b=Po+Ng28YjlYI/SI/PDieKJdBsd9m5MxVOix+i0ALDGQPLDtB0zKMzTr5jeVrZaXZ1EOZO8Q93Bi9Ghwo3czx5LjZp+GaF6rTl2Dkhwo9CMYsarWK4XFMNMIZN580PUo/olO/n9z9xKudJkKOITK5EcJNECGIDrMJJSCOyaQcM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320824; c=relaxed/simple;
	bh=i6EXM/dz88Cyoq8LtFGDSx5xkGpNbJe1oE+QY2KW7uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIdteaW01wp483ckPHMF65skwTqUzJIvXNHUmUr0T1iHqAAQ97HfyI4i/TdGzTkWBZdKYdj+zOioGu4RsO6u7+j42EB30TnVXoASAfWNypRbFASyz9WPDcLRMf+ynKsF3whOIkKIsYpoJCkKNWrl2lXGsb0Y65g7eEMedbCVlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=L7Fn6Usr; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773320812;
	bh=i6EXM/dz88Cyoq8LtFGDSx5xkGpNbJe1oE+QY2KW7uQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=L7Fn6Usr6CqpQSJg+sTfOg+35BhQICdFNJsUxwLeYojj09WsbqE+QES+PyTLa3XFu
	 FxS04Bhek6fbU8EeHr7JE5aXHsrDYgmS7DMPN3pylLsP+mmqheDPHhH+upjzAsxHlu
	 Hu27Gl+oOCiNAmlpvvsN7rxBct8aXBLITJeT4+sg=
Received: from simon-Latitude-5450.fritz.box ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62CD6mql014094
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:06:51 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v8 3/4] ptr_ring: move free-space check into separate helper
Date: Thu, 12 Mar 2026 14:06:38 +0100
Message-ID: <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267054-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:dkim,tu-dortmund.de:email,tu-dortmund.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32F152724A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch moves the check for available free space for a new entry into
a separate function. As a result, __ptr_ring_produce() remains logically
unchanged, while the new helper allows callers to determine in advance
whether subsequent __ptr_ring_produce() calls will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_peek() indicates that space is available again.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95..a5a3fa4916d3 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +111,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
-		return -ENOSPC;
+	int p = __ptr_ring_produce_peek(r);
+
+	if (p)
+		return p;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0


