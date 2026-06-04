Return-Path: <netdev+bounces-295325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YDRFE6oIWr6KgEAu9opvQ
	(envelope-from <netdev+bounces-295325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707D641DA4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=cwbmEcFX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295325-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 856CE3068BC6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD633E0C78;
	Thu,  4 Jun 2026 16:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47723F44EF;
	Thu,  4 Jun 2026 16:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589446; cv=none; b=OhWwzHhE+xg63X2+OJg/KqB5e36odkSAqiE3dMvqPrSvLGq0WSIx8I70HRRmazwZmvQPx8pfgJFCeTvYMtlpb6rNgkZ/RWKuMJXIpbiJ2KDq6lCurKeR5ZSuZtBP7ruH7umlgwcR7iZ2E2Sa/8x6G5V+Tfe7LmMK4OYzQUX0FGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589446; c=relaxed/simple;
	bh=/Zn3vEz3PvXrX6NlCleQ6n7gHQC61l3pzu24aOFFGl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMeAsujPjQOlD+kJsAnSupjZ07rSwsTqOr1QXos9YDIeccsqJxlL55EQ7KSQnucSdSapfKQHUBWSwKFT+tHbakDYmHhXi/kIXULjVZcGyNVURHw7Y6PbIaWUc4R1coxYtXwtzlbTrfu4YViqDNPw5sIuGjhHE2DX7emBHa3yrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cwbmEcFX; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=9S5daKe6q1OH/iTEY5c0ti/UepSQSFPvr+OxewRVe+M=; b=cwbmEcFXVwg3j70JN7MfgZK5Tz
	0aMf6xDn/8iVoPucD46mu3jAM4nRPkpuPCiac0YJC9xere9X41pm6bxXnTj8gFdO10G1+MpN/SdF5
	jDflNA7WlveB5IgeNSw4w2CnluQjeEfqYP8vD9h9Bw2nYlkngri8A6CiMw/BCZoliAiDM+UPYsfix
	9HjfDs56VbO+hnbsTpWAieyNsdixQnm5bjo0kqMgA2jl+iiWxsEJMLk8kjs1MFcQcAP8resUKJ8V1
	rsh1D7KPxSE5d5aVB/im4UI3KNVG4rqmoQY2DxRks2GeycjYyxHKS5Gh7z0xCLoyKidI8yMJTn3JL
	AH3jKHag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAeU-004dNv-1W;
	Thu, 04 Jun 2026 16:10:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Jun 2026 09:10:10 -0700
Subject: [PATCH net-next v3 1/5] netconsole: do not schedule skb pool
 refill from NMI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-netcons_fix_before_move-v3-1-ab055b3a6aa5@debian.org>
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=leitao@debian.org;
 h=from:subject:message-id; bh=/Zn3vEz3PvXrX6NlCleQ6n7gHQC61l3pzu24aOFFGl8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1VoOb0Sw8uhoCa6qx8sCFDf2NKwSbNPtN7
 vVju+2YYJuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bbgNEACAMEsSRxUjbVWRXP/wGCp1kZCtu5SPR5g2cnrHmXSbd9ABZB+5zd//hvtS26043Swq892
 5jPllJhVWX9mOr8MWqhVDagHbN4zx/Uu/kbUV03nxxOrBc+4fkFAcIf2JUHib8Onev/3dpRt4wP
 1ZcWTctfb/ifPl5/ZiOUn+beGuA5FhhjfYmsbYiUC7Qd9nTKEj8E38pRzz5RhosZITCEDW0JUeA
 zDwIvtnPJtMsYM3tJrdefXtZTYO77+x4sioAohdFuUcouZY5d5UCAkbj5bK2oIDBj0pce8xNhN8
 H+VXHzlVyZAhOgBgVZvL4Q+2WUuSMHfi0gPqT1mZqf94S7mXKxY7mr30GERGvbYZiPxa2W2Ornj
 7Jg5rcaeRfykCClwubwaI4gNak7ejs1FSGHtb0BS1hLnzmiv2Nbpm+7q3AR4dTsOPfgojObs+sP
 kvBL70ciLNOF5slpsnyKsQo6IVvYPiqNTfz9qAVYFkHZGbjFQ/C3phBafUx8r6HcnUizBMubEeL
 NXprHirUv8qbGWTkEx7+FkXN/ve5gOoqNWpKbkwS///qw0UZL8WpOM6+EFLqED4jEWDAtR8o5x2
 9i/ol666WyhQlIhjFeBidgFlFZphCLeyBZFaQvG9jJLhY703MugTrVVElGuNPFHBUGT4Xy1Okaj
 W7U/wWD0Z6J1xpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7707D641DA4

When alloc_skb() fails in find_skb(), the fallback path dequeues an skb
from np->skb_pool and unconditionally calls schedule_work() to top the
pool back up. schedule_work() ends up taking the workqueue pool locks,
which are not NMI-safe.

netconsole_write() is registered as the nbcon write_atomic callback and
is explicitly marked CON_NBCON_ATOMIC_UNSAFE, meaning it is invoked from
emergency/panic contexts including NMIs. If the NMI interrupts a thread
already holding the workqueue pool lock, calling schedule_work()
self-deadlocks and the panic message that was being printed is lost.

Introduce netcons_skb_pop() to fold the pool dequeue and the refill
request into a single helper. The helper skips schedule_work() when
called from NMI context; the pool is best-effort, so the refill is simply
deferred to the next non-NMI find_skb() call that exhausts alloc_skb()
and hits the fallback again. This keeps the fast path untouched and the
locking rules around the fallback pool documented in one place.

Note this only removes the schedule_work() hazard from the NMI path. The
allocation itself is still not fully NMI-safe: the alloc_skb(GFP_ATOMIC)
attempted first may take slab locks, and the skb_dequeue() fallback takes
np->skb_pool.lock, so either can deadlock if the NMI interrupts a holder
of those locks. Closing those windows requires an NMI-safe (lockless) skb
pool and is left to a follow-up; this patch addresses the schedule_work()
deadlock, which is both the most likely and the easiest to trigger.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8ecc2c71c699..918e4a9f4456 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1654,6 +1654,23 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+/* Pop a pre-allocated skb from the pool and request a refill.
+ *
+ * The refill is requested via schedule_work(), which takes the workqueue
+ * pool locks and is therefore not NMI-safe. Skip the refill when called
+ * from NMI context; the next non-NMI caller will top the pool back up.
+ */
+static struct sk_buff *netcons_skb_pop(struct netpoll *np)
+{
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&np->skb_pool);
+	if (!in_nmi())
+		schedule_work(&np->refill_wq);
+
+	return skb;
+}
+
 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
@@ -1663,10 +1680,8 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
+	if (!skb)
+		skb = netcons_skb_pop(np);
 
 	if (!skb) {
 		if (++count < 10) {

-- 
2.53.0-Meta


