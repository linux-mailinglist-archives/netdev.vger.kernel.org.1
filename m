Return-Path: <netdev+bounces-293171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JLQIJPTGWodzQgAu9opvQ
	(envelope-from <netdev+bounces-293171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9BA606EB2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5D6305E289
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41FE37BE7C;
	Fri, 29 May 2026 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjOYjnfC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ar345ICT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014137AA9E;
	Fri, 29 May 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074711; cv=none; b=DfIhAHHP2QUPb1YgtByfA0rX+xyat3aFWniHxkGiYfzK/Ql568ize0RYmnccH6exsB+SaY417HsQPm2p4lftUdPzhwRETjl43SSMdGPKygyIoOpK3oAY8+axVRF2OqCLIZQiga/y7NXUH9brxdIauwL9jfSYx2IJqki6og2ZnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074711; c=relaxed/simple;
	bh=pjjuZGuuJXmsUWl7MVLNzeOQFxPgEMleEtB5P7MyQAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iSCfJaqytauS1odz5b7dM0VTyeirkf/SdE29FY3i9QUuEE9f2gmprPcZ2ZniWJdveRv+f+nQgvgTjlWvpMcg996yAcUyneVDm/gNLnuB5mY9jwHytE+1lqCoDhV7q25Uy58hrwkGy6VI+cpOEbLHXxzWI35SqLxZ62DYV0qogxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjOYjnfC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ar345ICT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780074708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GPdv3BzuzelntFIDcB2WQfKo5PqptnQiWyMY07m9XWk=;
	b=SjOYjnfC+QLfw0JVWuCGIj29BMCZH2zVXCsvQoVrdZ5op5CE565zFezjHyckURa29ITYaZ
	lW5nlXHcYgVRAWrrevyP130qVGBZYOaLYKLkN6bBcBXaP6tYISSuvr5rzRLoFVKAt0TS5r
	G4cFlDafKUnFCEIqf3T1atGCAjSrKDXmj2Yq7mhI1xFlqCPTMifKmt0mlTDd7hfUl4hRVn
	eAYECS8UL6ornem6VsW6OShe8Lx3xoEu9VcrCjlNIVCp1u24eU9rIyd7WWUEh8c/Att19A
	lkHxJ2apqH5r2GEZAWzMBthsE1G9hOenQMu0f/GSpG6wDACMWK0QK5NQkbj2rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780074708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GPdv3BzuzelntFIDcB2WQfKo5PqptnQiWyMY07m9XWk=;
	b=Ar345ICTycnij4lKbRjSZu77PFumKANmsOOumPd0v2jRixFBAA96PUXuuWGPOhz33VlK7z
	/tpLThIXWkFLT/AQ==
Date: Fri, 29 May 2026 19:11:47 +0200
Subject: [PATCH net v2] ptp: vclock: Switch from RCU to SRCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-vclock_rcu-v2-1-02a5531fab92@linutronix.de>
X-B4-Tracking: v=1; b=H4sIANLIGWoC/22NwQ6CMBBEf4Xs2Zq2iAgn/8MQI9tVVklr2tJgC
 P8u4NXjTN68mSCQZwpQZxN4ShzY2SXoXQbY3eyDBJslg5b6KAutRMLe4evqcRCkK6xQyRLzFpb
 B29Odx012AUsRml8ZhvZJGFfNinUcovOf7TKpDf5nT0ooUWF+KFCdWlPqc892iN5ZHveGoJnn+
 QvyJNlVvwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2672; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=pjjuZGuuJXmsUWl7MVLNzeOQFxPgEMleEtB5P7MyQAQ=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqGcjTjO261o3esWkVi5KltpPWYajUOHmk5UerS
 kcqCD7qj+GJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCahnI0wAKCRDBk9HyqkZz
 gt24EACWp2FBlKzYClPjROOseFsklKPkyZoJ0/aKJrbOYLyKVAocLzLjShz84NiBtDDa0xg3fy7
 uGXZjAYfolOoweO5+efg2BMllwsKxM12HoPNgZH3rqiIc+Qxtl+h7cCLfS66ezhdY+C/1wN2Lm3
 IDWEg2mwTHguwl8UeMfXnw0KUpUwvonIFmud9fJb9bbBRBFYtqc+x+fYSokhwrZB+Z8Oll8GY3g
 KCoq4d/yBMQ5vbWnsAVIU4hbjmP4vxfJFF1i5GCNXyJ0vYzmjo0eZOUCkOf/faPaZFV8vpQlShN
 fiXztRi5pvbGkmyOyALGeA+swyFVUMOKFj/VxEH+GOIHIJslsr4I89SFzaWo8yfDBh981WPcUvN
 O78GP4+F4gCjOiVOgVqSQPse56yfQ32pGu82k8bqxdFosRNFx1JUUNCwtiVZ3ETMBJb1lxXZ4Ru
 XM09Y99Ce+z8hUvqxox5s2v5Uy2b/obiGHJeBR0SHnmByi1yKCGxdiNLRvKF/EGJDT4tVBAWr4e
 Gi8KccVfs9j5KkbcO8OduGpUptxWVziT55RX0nY/edC/jl8e+j9WycYjmwr/tcoYVeex1vuuu+9
 sK5U4dbKuqQdj1Kv3XjSAl5wPQrnWSV7LeHEL+8Hx4yLUSD3KiIFG62HaQKgauJKe6r0pMPt/4W
 EosnXSrgK08Wy/w==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293171-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,schettke.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB9BA606EB2
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
Changes in v2:
- Remove RFC. No comments.
- Link to v1: https://patch.msgid.link/20260521-vclock_rcu-v1-1-9c345c18bd72@linutronix.de
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
base-commit: 422b5233b607476ac7176bfa2a101b9a103d7653
change-id: 20260521-vclock_rcu-e29c9c107c3b

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>


