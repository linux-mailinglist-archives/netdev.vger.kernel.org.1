Return-Path: <netdev+bounces-290253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOTCOoisDmqqBAYAu9opvQ
	(envelope-from <netdev+bounces-290253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:56:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2E59FC1D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C9FA301C658
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA74384CF6;
	Thu, 21 May 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kl7wdhS6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4Q5vU07"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C3385D78;
	Thu, 21 May 2026 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346566; cv=none; b=OV+KHotrdghIL0ZYetZAQwGcV7Bi8Nf4SsJpmxfIFGjvQOYYFJduFnYjBNs+G/sEEwvWUc8ibag/bmnhqdEdHFZSk9tZ7ywFzVTHHWRoKcdfeYPZGhx7KA7J6yXKIGVwmbiCt4JuwQe73TAo9MOPS31rr7UmN6kvu96P0aEhQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346566; c=relaxed/simple;
	bh=DYp7kJ6y/G+GQSUqvEG5cS3d3XsBWuJ57f+jIRRbr/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bzYrDU8KAhBcIkAmL4vHZ4dKen9O4z+CPnNsfzx270E5DUq+pjv8sCpARyCVOyH8Q4s/8meljc9VQrW5lL3MR2Rp8ddxIb01zsIw36JLhWm1iu3VCRMRMyf3MDt4wHG/tBmHy1PugWNrK8aZwg2dkzflIoToaU/jN1v3D+8ucyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kl7wdhS6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4Q5vU07; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779346563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GZ6CpHA8DCv1EO0Bfml/WPMS5eybBvYChyGfRu9Jp9E=;
	b=Kl7wdhS6Cq4F9VhTaGtppzYoYmhLKd2smgm5qhVCuMAPZy2191H3ebbOy0VxP+62Bj+TWz
	RrGSMfaq6mRiL3HVJq32aVojNyEOxIayznOlzqBAx2pJUeOu2gRlndYUPBUhrcJ+0OJEaj
	ZaT9EBtPyXqO/7CHXY5K2/tMRFqwJpPMzIBo2C1XEeIECZ3fNRyssI8zx90+FKaOJyzGpq
	pgwdN1Njh6/6x0axKAY/1QbYqcOZUtLIZ/PXr4yIvck1OlB57CX1s1To2B9aI67XL0R1QH
	Xz7y9IOO3rE8wFEa3qLKlr+5BhUoriuqPXbQXCu5zdd+01c6Zp08xqDuGC3YSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779346563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GZ6CpHA8DCv1EO0Bfml/WPMS5eybBvYChyGfRu9Jp9E=;
	b=s4Q5vU07x+aYnyw1eNTsNh5NVMjVc+eZwObfcQEraQ0uzD4vUOaEwsUw2a+Tkb/NZK+eGY
	I4FI/dikVpAFCOCw==
Date: Thu, 21 May 2026 08:55:47 +0200
Subject: [PATCH RFC net] ptp: vclock: Switch from RCU to SRCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-vclock_rcu-v1-1-9c345c18bd72@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHKsDmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3bLknPzk7Pii5FLdVCPLZMtkQwPzZOMkJaCGgqLUtMwKsGHRSkF
 uzgp5qSVKsRCJ4tKkrNTkEpBRSrW1AEJ3mh53AAAA
X-Change-ID: 20260521-vclock_rcu-e29c9c107c3b
To: Richard Cochran <richardcochran@gmail.com>, 
 Yangbo Lu <yangbo.lu@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?q?=C3=8D=C3=B1igo_Huguet?= <ihuguet@redhat.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>, 
 "Christopher S. Hall" <christopher.s.hall@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Florian Zeitz <florian.zeitz@schettke.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=DYp7kJ6y/G+GQSUqvEG5cS3d3XsBWuJ57f+jIRRbr/k=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqDqyDVsRtgZXldID3s4y01VmpzWr8W7G3J2CaP
 eae6IfOwo2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCag6sgwAKCRDBk9HyqkZz
 gsNzD/9fXEOcpEJeQxmngXGoqtI/VkmC+k2rJfeWqiPfdFMOnE7Mg+2gmgsYMwAvkWjV578jFjl
 cc1MfxrXiGQt4UWCnDWVkkmdJPsX30JRbABbd1E8S2/aBnINt7dhRqjfarRgw5ISDbYT+1RL0z3
 E4HdjpIw/qmC5Wl1p5En4Y6qcA5w7gV5Vdj0sFyGlN+G6tvV1k2iBcoamzdW+IkJA42sisCZewx
 64Za2TvRhCk2B/5tx8CkFn0HNaOYAQKl/31yx0wtOWMkWrHKGpMvpPdQivupk7zszX65GLW+/Gi
 4EJrHVJaSXb0Sh4GpCaNesDdvK/dkNdy0lRDJK66E4r8M93m4jthqIbyeLZErWrpMAnz79G4YxA
 2lSMxWyEYVFMBWYnn5OIzDuA8u/6XJsDYEWOgiTVzajplPp6mp9sJLCo68mP4SW/pBr1BFUPBhw
 gTk9xpoQRNUkwuPWmvBjrqYH2xl6ZHyMGBabshFTlZUFWT319AB69NzU5qZSzm04cO2rlMUJ17m
 GrA4XC5vaB3jHGfa7mRxRF4IvmFuBkra5sKI7XmtxM4JCFFdV/HsUiAewxr4FKbUz1MBZC2/Ve/
 Na2CGy6uLWLLbtDRV2GmdW/ltXQPiwPz+IfQf19MhAGbj7oeShmowu5gt00VftqikYopaqoNv57
 AZbdA6GeKo3DW8Q==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290253-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 94B2E59FC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The usage of PTP vClocks leads immediately to the following issues with
ptp4l with LOCKDEP and DEBUG_ATOMIC_SLEEP enabled: "BUG: sleeping function
called from invalid context".

ptp_convert_timestamp() acquires a mutex_t within a RCU read section.  This
is illegal, because acquiring a mutex_t can result in voluntary scheduling
request which is not allowed within a RCU read section.

Replace the RCU usage with SRCU where sleeping is allowed.

Reported-by: Florian Zeitz <florian.zeitz@schettke.com>
Closes: https://lore.kernel.org/all/00a8cce8-410e-4038-98af-49be6d93d7bd@schettke.com/
Fixes: 67d93ffc0f3c ("ptp: vclock: use mutex to fix "sleep on atomic" bug")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
RFC. Maybe there is a better solution than using SRCU?
---
 drivers/ptp/ptp_vclock.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 915a4f6defc9..84cb527f59cc 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -19,6 +19,8 @@ static DEFINE_SPINLOCK(vclock_hash_lock);
 
 static DEFINE_READ_MOSTLY_HASHTABLE(vclock_hash, 8);
 
+DEFINE_STATIC_SRCU(vclock_srcu);
+
 static void ptp_vclock_hash_add(struct ptp_vclock *vclock)
 {
 	spin_lock(&vclock_hash_lock);
@@ -37,7 +39,7 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
 
 	spin_unlock(&vclock_hash_lock);
 
-	synchronize_rcu();
+	synchronize_srcu(&vclock_srcu);
 }
 
 static int ptp_vclock_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
@@ -276,14 +278,16 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 {
 	unsigned int hash = vclock_index % HASH_SIZE(vclock_hash);
 	struct ptp_vclock *vclock;
-	u64 ns;
 	u64 vclock_ns = 0;
+	int srcu_idx;
+	u64 ns;
 
 	ns = ktime_to_ns(*hwtstamp);
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&vclock_srcu);
 
-	hlist_for_each_entry_rcu(vclock, &vclock_hash[hash], vclock_hash_node) {
+	hlist_for_each_entry_srcu(vclock, &vclock_hash[hash], vclock_hash_node,
+				  srcu_read_lock_held(&vclock_srcu)) {
 		if (vclock->clock->index != vclock_index)
 			continue;
 
@@ -294,7 +298,7 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 		break;
 	}
 
-	rcu_read_unlock();
+	srcu_read_unlock(&vclock_srcu, srcu_idx);
 
 	return ns_to_ktime(vclock_ns);
 }

---
base-commit: 830d8771ae3c7bc90a62dde76a6556e612529fbc
change-id: 20260521-vclock_rcu-e29c9c107c3b

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>


