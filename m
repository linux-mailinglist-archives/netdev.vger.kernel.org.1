Return-Path: <netdev+bounces-295327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4exvBPOlIWpgKgEAu9opvQ
	(envelope-from <netdev+bounces-295327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2E641C98
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=TBmcyn0g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295327-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295327-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3513730EBFE8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971E47A0C4;
	Thu,  4 Jun 2026 16:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E137450901;
	Thu,  4 Jun 2026 16:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589449; cv=none; b=atxgdTcA7vBGdL2xSeKd+2J2Iq55QaGC3nM17DWUU0HoTzEnW2E5xGjSjI/l7Z1a1benrY2+FkGKz3VOsEIOBfsyFoETx5zMwURrvJl5Pn9C8f1ireliU0dUPEEGN7Yn/xE8M5abLtYEC/Nri1XrtL2nnt+lhTnypYWqUdkvmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589449; c=relaxed/simple;
	bh=/vLl1l/78vt9RDMFfCeneM4B3TUnzwwDxj8qXrfEy5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHdtPPXGh3cVfrWiHvLPzUbP5EdECKVRiOYQ1m8ETmDvCavdR7J1km0+CXEC4dvePFkbIrm1gIZuMqs6oM+nPjHcoU/tAPXnVZ5crn1TL45XsCBsl6Hjq4+XYm+IqVYlMeZ6CEkf8e3YPXeeBpMUMd2is5l1F/XyDWXjLmgVr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TBmcyn0g; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ET3CzSCmgSIUdz/BKdumXFHL1EW3b0uAXYHBuoVwoeE=; b=TBmcyn0gLBsQwxStK6Uu6ihvUD
	KoMBC41PjML85/a1FgXEvF5iKOThZSTZrza8ZsqkN2N/ATUhU541IJ0kVCjhvcpzW7zb8lzn/6euA
	mkUQLo7s3qg14JgpK0IznEK8+YB5ga0mHtg9MCvGDkWhDTS5ibeiasPRdplHkjeAoZTNLb6t1VIlj
	8dYVj3VsKs6kI/ipuqJX87Vxx+F6pZfC+5d8wu3NRZqLg7PgONeusdP/g7Ydcg5bkfK1KEB+3xWs7
	8gPMLcdEe13vNoMLqN9aIj4FgjbGeBqlSwWAoTAs6nSgRLXjXXoJH12Lw7onn8euAn4tDOLQH1cGW
	3Y0N2dHg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAeY-004dO3-11;
	Thu, 04 Jun 2026 16:10:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Jun 2026 09:10:11 -0700
Subject: [PATCH net-next v3 2/5] netconsole: do not dequeue pooled skbs
 that cannot satisfy len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-netcons_fix_before_move-v3-2-ab055b3a6aa5@debian.org>
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5657; i=leitao@debian.org;
 h=from:subject:message-id; bh=/vLl1l/78vt9RDMFfCeneM4B3TUnzwwDxj8qXrfEy5U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1P+qdhNl0Ya7azFUnK0SHDd/LeiiTxc/0B
 YV59va/2LKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bUIHD/91dHQgTTBKPZ1H5IbFTNEGYVOYVTVyUvdw2si04vRhKlkhmupnaP+cVMgFIwzPDC+yqFS
 /WYIa40nvj2fHcTE95P/6KU6FJNfxLJlg/rZkb++Yqyv2wL52jweY8CALM4UK1Ej8EG+jqqGfbc
 eUiy0Gv7fIP6GECGGh7QbwNcZLNvzNl4DlfGaiu9dCR3Z0zq9Rtq0cgFlpHyfdY0iCrJrsA5LtZ
 D1i9lbJrvf0uK7vO9StiS9C0mQurEIuUGaI5S6IltSuV8VlksMc2vxIEBuDhyXWyCxKlaodZRex
 jSCaH9IJ4DBOdC9kqad716ZXiTpJDjMG21HXySSmkFkwZFM/N08sZE+f1eeCk1Ji9C5H0wogij8
 dtn4AIwDWpd5kftAWU9iQDpuZtRMuh1in4wPQS709QPlgMkqhQGQ2JEEoddxGUdA7YA960Q4V0E
 xZwGIEGmzCZkB9WRV77nd/Sp4+myLzISkSLVUph/FewkrpCV/dteh+bStKw17PTZlN0AU0IrhDP
 WCSeuCN5fxK6IKQrRWAIU5+LvaavqKlYajoPtSSilGFDnhjUqFeIl59LMcuIcJTXVuo4o1zzDYz
 ivFP9MaSP7jFiIMi763VlLOY7SHCrcZSjMK08QnocHZuf5VW6uVFfU3IoV0qxqohJ53Apb280Jw
 BaLzy6RwCMdyXtg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295327-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99F2E641C98

find_skb() falls back to np->skb_pool when the GFP_ATOMIC alloc_skb()
fails. The pool is refilled by refill_skbs(), which always allocates
buffers of MAX_SKB_SIZE (ethhdr + iphdr + udphdr + MAX_UDP_CHUNK ==
1502 bytes).

netconsole, however, computes the requested length dynamically as

        total_len + np->dev->needed_tailroom

If the egress device declares a non-zero needed_tailroom (e.g. some
tunnel or hardware accelerator devices), the required length can exceed
MAX_SKB_SIZE. The pooled skb is then handed back to the caller, which
immediately performs skb_put(skb, len), trips the tail > end check, and
triggers skb_over_panic().

Leave the normal alloc_skb(len, GFP_ATOMIC) path untouched -- the slab
allocator can still satisfy oversized requests when memory is available,
so senders to devices with non-zero needed_tailroom keep working in the
common case. Only the pool fallback is gated: when alloc_skb() failed
and len exceeds the pool buffer size, skip the skb_dequeue() instead of
burning a pre-allocated skb on a request that would later trip
skb_over_panic(). Reserving pool entries for requests they can actually
satisfy also keeps the panic path, which depends on the pool being
primed, intact.

When that drop happens, emit a rate-limited net_warn() so the user
notices that netconsole is unable to push messages on the egress device.
The warn is skipped under in_nmi() for the same reason schedule_work()
is: printk machinery taken by net_warn_ratelimited() is not NMI-safe and
would risk recursing into the same nbcon console we are servicing.

MAX_SKB_SIZE / MAX_UDP_CHUNK were private to net/core/netpoll.c. Move
them to include/linux/netpoll.h so netconsole can reference the same
definition that refill_skbs() uses, keeping the two in sync by
construction. The header now pulls in <linux/ip.h> and <linux/udp.h>
explicitly so MAX_SKB_SIZE remains self-contained for any future user.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 ++++++++++++++++++++--
 include/linux/netpoll.h  | 16 ++++++++++++++++
 net/core/netpoll.c       |  7 -------
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 918e4a9f4456..58250e648f8b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1655,15 +1655,33 @@ static struct notifier_block netconsole_netdev_notifier = {
 };
 
 /* Pop a pre-allocated skb from the pool and request a refill.
+ *
+ * The pool is refilled with MAX_SKB_SIZE buffers, so a pooled skb cannot
+ * satisfy a larger request. Return NULL in that case rather than handing
+ * back a too-small skb that would later trip skb_over_panic() in skb_put();
+ * the caller still polls and retries, and alloc_skb() itself can satisfy the
+ * oversized request once memory frees up.
  *
  * The refill is requested via schedule_work(), which takes the workqueue
  * pool locks and is therefore not NMI-safe. Skip the refill when called
  * from NMI context; the next non-NMI caller will top the pool back up.
  */
-static struct sk_buff *netcons_skb_pop(struct netpoll *np)
+static struct sk_buff *netcons_skb_pop(struct netpoll *np, int len)
 {
 	struct sk_buff *skb;
 
+	if (len > MAX_SKB_SIZE) {
+		/* net_warn_ratelimited() pulls in printk machinery that is not
+		 * NMI-safe and could recurse into the nbcon console we are
+		 * servicing, so only warn outside NMI.
+		 */
+		if (!in_nmi())
+			net_warn_ratelimited("netconsole: dropping message, requested skb len %d exceeds pool buffer size %zu on %s\n",
+					     len, (size_t)MAX_SKB_SIZE,
+					     np->dev->name);
+		return NULL;
+	}
+
 	skb = skb_dequeue(&np->skb_pool);
 	if (!in_nmi())
 		schedule_work(&np->refill_wq);
@@ -1681,7 +1699,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
-		skb = netcons_skb_pop(np);
+		skb = netcons_skb_pop(np, len);
 
 	if (!skb) {
 		if (++count < 10) {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e4b8f1f91e54..88f7daa8560e 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -13,12 +13,28 @@
 #include <linux/rcupdate.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
 
 union inet_addr {
 	__be32		ip;
 	struct in6_addr	in6;
 };
 
+/*
+ * Maximum payload netpoll's preallocated skb pool can carry. Keep this in
+ * sync with the buffer size used by refill_skbs() in net/core/netpoll.c;
+ * callers (e.g. netconsole) use it to detect requests the pool can never
+ * satisfy and avoid dequeuing a pooled skb that would later trip
+ * skb_over_panic() in skb_put().
+ */
+#define MAX_UDP_CHUNK	1460
+#define MAX_SKB_SIZE						\
+	(sizeof(struct ethhdr) +				\
+	 sizeof(struct iphdr) +					\
+	 sizeof(struct udphdr) +				\
+	 MAX_UDP_CHUNK)
+
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b3fe59445f2d..229dde818ab3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -41,16 +41,9 @@
  * message gets out even in extreme OOM situations.
  */
 
-#define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
 #define USEC_PER_POLL	50
 
-#define MAX_SKB_SIZE							\
-	(sizeof(struct ethhdr) +					\
-	 sizeof(struct iphdr) +						\
-	 sizeof(struct udphdr) +					\
-	 MAX_UDP_CHUNK)
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 

-- 
2.53.0-Meta


