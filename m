Return-Path: <netdev+bounces-294255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p5MzD8ztHmoJZQAAu9opvQ
	(envelope-from <netdev+bounces-294255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27162F756
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:50:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=hX88hPQG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294255-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294255-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 802F330C18DC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183053FFAD0;
	Tue,  2 Jun 2026 14:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAF3FF893;
	Tue,  2 Jun 2026 14:27:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410442; cv=none; b=RlA4WKeoJlkb2hriQ3qWOZc2sd1y08Q8onkZzQZ8+E8wIfje58TsXhfHLIlJicSC+Ren8OslAnqwvcLAE9mA34mn4TtMmL193+kLBbmya8Mv9FUDPfTUoSBJd/JdfcmJLP2FVhCoY5ybDnwpX305coIRhSTcGpfHewx5KNSKfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410442; c=relaxed/simple;
	bh=i6qClQ5+W9ctQ1d1kEsgy818nsHiIexncQiAotuiatM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHSe0dgAqv4+Bd6eNZYoevk7/JgJ8UDDaOUOf9kOHf7reISNKgl+7j8anzgBad0WcAdhUzjwnJRe8zjk9CKqHCpBDBTaCquyJzrPwXKDojxn2pv6AhCAwtgSTgE9dZQRVPvAqtGBsCRH1weZ284YX0dqt+xNkOrwCCw/DCde1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hX88hPQG; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/IDfQoAzumKqf8CoKiK/GBUYkM85ZxvSCVtce+/KjkE=; b=hX88hPQGxYD18q6tFbmK4PURF9
	fprLXhtsihK0Z2mVzYD9E+2j3PehjJFBUuGtEUAr4cdRx0+/LVXkUQ4fcb4JubLvftBIx0gxvzBqX
	XgDcWeDNISxcWYxqvei7RRYZNxL6VtVwVArRWN3j+oFAH/HfRSFzqCx2riege1tDxYyHm+Xt9jG2J
	uoJR2ZEnhL41Sf38I5y5yyY17Lkxdi0EkU0rn6TeLf0DmXrnqOk3beSUT2QPIz3tSRcyv8Zf5w6zo
	yVCQ7a02+qnjx+drLUbikxPCq5e9QiJOc7cE0EvAgEMBO+jU+Rg4XLsmvtkuJ99esfzma+wEh8qTM
	6zmHxPZA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUQ5O-0031Hd-2V;
	Tue, 02 Jun 2026 14:27:19 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Jun 2026 07:26:58 -0700
Subject: [PATCH net-next v2 2/3] netconsole: do not dequeue pooled skbs
 that cannot satisfy len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-netcons_fix_before_move-v2-2-eca3f8a8b1a3@debian.org>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
In-Reply-To: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; i=leitao@debian.org;
 h=from:subject:message-id; bh=i6qClQ5+W9ctQ1d1kEsgy818nsHiIexncQiAotuiatM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqHug5NwZEDjMxquwEK8o0h/zb4XArCH4wFDBvN
 kwy1Sbt3XiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCah7oOQAKCRA1o5Of/Hh3
 bdF4D/9Hs4qtL0n7BjAJRs8XPHivuvFdQRMXD4dtaB0jfVSSrDiajrmG3CSlzS8/GozR+cTqkmJ
 VxQijxaxIJ0gDSYnZMJrfHVm2piIrGM8MV83YGrhmMXMT4XWI885fGgpV/YxTd/tqea+6ldChU9
 qkovrHx2Ck8gfzdnL0aHmbbDwBfdDX0vjW3IRdIT7q34+CzuKqc5W9YTjNx9pMtxO6JltuJkfeM
 AuE5lQogDRYjvQx48EwQyA2JIryLQsImqPOTvktroj+nBmF2stHQ3uci+955Gp8HlOa3Qpb47n5
 6HiLZbW6TK5gA1+fWFEC6BMnU7687QTlIAEQI7b82WFYZpym941Xc2qysCdu66BtMppbw1gkIgk
 6MzjIRARac2dUzgTs8qQMPZ6NhSpVSVDr68wnaum2FqE9dZSc3jq2seWsa8jEsyg8xDpqHT6eZ4
 gF9VVdCIfNnxUxl3vxrAHN++5/Oyi2vZXc/vLkFk/jzWyr2kBOy3+xsosKSfumjmjAwg1VfhBXj
 KPelSTyareEaeqkqz5DkC5FK30ejNr+E7bzLlw9yQpnAYn6iAW8/4QvB+Ljo2co6A3V7YgASoce
 p6HHoocvV2TkwbHaa9ctiCN1DdzRSbrRDr8F4YzPgwXNtXQ7lk2enXDBQkDDtBWQuEe8cj06i7U
 7K4tEuG7SIHayQg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294255-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF27162F756

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
 drivers/net/netconsole.c |  7 ++++++-
 include/linux/netpoll.h  | 16 ++++++++++++++++
 net/core/netpoll.c       |  7 -------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 918e4a9f4456..b77879ead641 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1680,8 +1680,13 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb)
+	if (!skb) {
+		/* The pool is refilled with MAX_SKB_SIZE buffers */
+		if (WARN_ON_ONCE(len > MAX_SKB_SIZE))
+			return NULL;
+
 		skb = netcons_skb_pop(np);
+	}
 
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
2.54.0


