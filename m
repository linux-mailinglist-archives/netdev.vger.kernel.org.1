Return-Path: <netdev+bounces-294254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EEOcDDPrHmpaZAAAu9opvQ
	(envelope-from <netdev+bounces-294254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:39:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB762F5B3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=DvcLN2EA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294254-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294254-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99676318F6A0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FED3FE66C;
	Tue,  2 Jun 2026 14:27:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B643EC2DB;
	Tue,  2 Jun 2026 14:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410439; cv=none; b=ehPv5DIb1WSbcLOI9TdyQLMXfZqP8cUvvBeQSS9yfFCPnmbm6WM2fakkEjYWqsw2ijyVUwFnrxBkpOKjvYrzqDzM7zM6L7RCoJWrQZHrHNjP5XcrFFH/p4WGbo/0k2vAmPoZom8ytcK5fgL7DUTq7aNixSo1NR+VxZSv5reK418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410439; c=relaxed/simple;
	bh=562SU7/TNbjHOgAtvDMVmgp/nQboEt+IDWOIwdfiJR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epRLXe03JVMmyUWxwqdSH8JEBE0STU8dL7At/OHD4H4aPKqCjaLuI2n7cLA1vE2F4kHV4sM60Yh3+11Cf6KNqU7woKI0LoIQk1s4n22R52RDQ8t0OMxm6C1nfeGNx/+/3CayABu6OfLvlKUFhYI8esl3InhW4j+0fP98noTF4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DvcLN2EA; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=kvZFlmg6J6t7QSkGa69BUEUC0wXFqPsgx0WjeD9nEAo=; b=DvcLN2EAltnXeNyxckCoB0PGeW
	7yhBjb+HJa7u/sD9wcrO+QGufxbHlY4iuyN8eQH6v9/a4vT89dG1gYAlp83DN2PxnfktKfHtvrxWx
	oeG47y9XCzoNT4sPvfw9+J+Fy1IM7IfxwgKJm0GCQ+VUuSV5Q65+9TeKkjh6pEMCczsUm1Jws91Ks
	RSxZtgdCSsoh5dbGENtW+MEMPGzOjcIQT6QcVYC/enX9AKQsVtySVlrVu6ziquycH90o1g7iEQq3A
	AUK/eq8DOdf90o/StKfG5uLCKC7I4nIGl5fqx8lucQ9K8zfodA7oN0+WPA9nxObfn3ZJ2qXRh3tnG
	SLCPXtOg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUQ5K-0031HX-34;
	Tue, 02 Jun 2026 14:27:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Jun 2026 07:26:57 -0700
Subject: [PATCH net-next v2 1/3] netconsole: do not schedule skb pool
 refill from NMI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-netcons_fix_before_move-v2-1-eca3f8a8b1a3@debian.org>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
In-Reply-To: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=leitao@debian.org;
 h=from:subject:message-id; bh=562SU7/TNbjHOgAtvDMVmgp/nQboEt+IDWOIwdfiJR4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqHug5tXausjsedjk9abbvX6vKOpLnjorOfwfKs
 FheSI4HQgSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCah7oOQAKCRA1o5Of/Hh3
 bQXCD/0V+bqhWEEW5PrUPoAYXnFz6FMWyhCCCJvmZ+yooJGmNP9V2xizZoFldb2D4pP28PGWIvf
 bzd8AjAy6/+vt6Ypx38h3GAZohriD10m032rTF0kdyCUWx+hLX++QpHuIG5bGCmVF5ZBjvWtPdv
 zMfM7QIc1RvrEvI/uNIABtlRWf+R8k91wZ078plr3R6/haa37JOUZHvp7pVoWuzC7OkEaD3IpIn
 wK3nCbLnRyJwng9Txn+FViwXl+JtrgOXlhzk+l2eB/9FQ+i3BsLQ/2o1FxdMq1B55PzU02yaWT+
 80Wd1zchN4u8z1dHs6wRZAyx+2p53+6ujmEOLlrIxUgQ/RzntyvGwP5BM5HeuLNe5cLB7oxVs8K
 GRCxKIjfZdZtlUcaLb0/bnRxC4YF5hOGybzglPxod/5lZyUhMF0MjYhVF83DS4PT9GR9Tlz2HCW
 4ofSGJdMPM251zogNHNkjQS2k9YwJUmRXe8fHPq4NEsUuwDxTv1EH95M/WCRGxf2YhBvoquj11x
 THhTSTSTxArqP+TYuzWyLR95rb1pJ/qN868rnlcNyNkDHRlx/s0ldht3+LT+34yXtF3VImRY0g7
 A8q2ch/jUEPdEAifz7iHJaW2eXqF0dZvs8n+JHp2Iph0MaA2QzJf0Yiju7PWFpu402i+xcUV9c2
 y0hgTAmBGlfHOiw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294254-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87FB762F5B3

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
called from NMI context; the pool is best-effort, and the next non-NMI
invocation of find_skb() will refill it. This keeps the fast path
untouched, the panic path NMI-safe, and the locking rules around the
fallback pool documented in one place.

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
2.54.0


