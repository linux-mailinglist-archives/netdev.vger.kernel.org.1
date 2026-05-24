Return-Path: <netdev+bounces-291206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAgfHaYjE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E604D5C30D3
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 195A73013893
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AA3A9870;
	Sun, 24 May 2026 16:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A23A8749
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639151; cv=none; b=W+JjLij+c5TPx0530TVtdxZevmA0iiXDesPljQQHH04vhFnbNomjiZlQhrhkrQOLWpqXAaMRKR2c4/Y6jyh281/BzMhfAmLzkvtwq0owLzfjXZI6gPzbapy/jaPzVhzeoHX8/IcixeIp1kT1VGW6NeQAu111rKvv1r3sDzfmI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639151; c=relaxed/simple;
	bh=DfAMocgapgQ/LI/qEUqGA8jdlKm8WnUDdcQZ9Oss0SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKyGqp3L5aaTSz5qLSbg9T+ItvHJNAOHDRQnYFotxIwW3M50QSIvPLCjdxiMpfYbUMkPMifgEUjQXgQbxCuoQTp2vSKQqz5OaqHGUK6/ZU01DMZnsFXsOQO7LNXfqoDvd//M6aLmnQTrnGMmV2zg1Q0WCuMDZgByIQGAgWfYQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47c918c62b4so5879544b6e.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639147; x=1780243947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWDratKSJZdKmxRQRRe5Ewa5FMIG09hb/oexxLbLqXs=;
        b=TAUgxoyekuciFTsR7XHKZQxvgDLAk7eDmw8Yo0Y8LKuoOcUsqpL33oO+sKaELw79Kr
         YUV8yfPOpVbyF1jgtYs0HVWQdZy24SqTVdbwM/7RPg8lD1rsi3Z+7cD9tgcXRcCdzfHz
         0eFdoK5jJdsxfa8CPqgIEuLFe1/42oVOgBBuEaJFcUmX2/4hIJGVI7OCqRrZS6HVSPND
         5L0xCdURANar8Z6TEUKZMrZaPU7B/5f3zcnkal9FbO8bX36Dh6eQJsDoaYVK+olz5Tdu
         o4Hj8YTSBAPDUpHcAnNlrUVH59Dipupb45JoxQh5Zz1J7HaeOldg6s3QEMdJySySBdgx
         Wabw==
X-Gm-Message-State: AOJu0YwyDIRvHSxM+ZbgTsiF5NR7mo9yH3MJ33c8xLTz8O0fi0Yq+uI3
	6R8u3hJEkkRI0cLoh46kG0Azlbqye7dL2UuASx7FuvWTzpaSs7gH9o/Y9gJGHVcO
X-Gm-Gg: Acq92OFsfXYrxrrvqIQQZk6vHZsPk4vJ9KCUvMhDPpjYb6Ct5MZyuZciQ3H/WdY517i
	OF91TtUNYo3FuhFbkZlh4ermAuBeNt/4MozqgNnTZpkh13eDJj+Q1nta4lw3nhDSl+p6CDMCv7R
	wzq/2N3VX5J4qkNK4DEVSp79iKSYZcTSVNv2yBzzAiq8RMTJsrWOgSCkMTnol6EzRna/DBWZN9p
	+BWw8zmgYafgrcz2hyEsx1oo6AJsBQGQnEutu0I8P+cQNKAaeYi7yUkGgAFGPsLMoxAmlV4PJwE
	WJIHHOldpETvkhM4MUrncw1jXj+vTWsbhQFXY7toRA+K3NRTOFgGtMFb46I02M1MV78CMKES80w
	vO8vrxmDD7Apg96qTJRNpztddrAeIyO+8BuJbExCk5Lr4vPmysUMEG4qhUwMuZkgMjBF5zKTNMJ
	rIXRUS5KrQJiRb9g==
X-Received: by 2002:a05:6808:448d:b0:482:7a59:47a with SMTP id 5614622812f47-4854a505287mr6934995b6e.46.1779639147456;
        Sun, 24 May 2026 09:12:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606482b65sm5482001a34.10.2026.05.24.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:20 -0700
Subject: [PATCH 4/9] netconsole: move refill_skbs() and skb-pool sizing
 macros from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-4-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3932; i=leitao@debian.org;
 h=from:subject:message-id; bh=DfAMocgapgQ/LI/qEUqGA8jdlKm8WnUDdcQZ9Oss0SE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlWNw3ugj9wFA7OW9WQeZKy2mrxbjA/GyBl
 trQ/M08IaeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bd1IEACQFC685++1K0n3zuhL/63bxnY+H7TPcbfOIONCF9TvdoAISacN9gqyK8KCzPa6Lj4NBZz
 vaHNTRqDjDNGBzox3OGq9/Pv5/Bus5lO69TJhtTn5zKwX1uMdmNJpxj6tkhABg9p8BUZUZQVGrq
 gJ+148ge2a7ufXNFwvB+FUIjRaK+kJDu12wOr+JNcG9u5GRaC+yUFeKIXMYdfvLDCFmvGh3mE1s
 ja9GIPTdidlXhOKV1pa8/bKTC4P8b1ccdSiZqRBJ16RilpxBGsiNhxVHD9QYOIFC6qXbDTRFHaX
 WYVyaWU7sVeVFp7EOlsiYedroPK7/wqjaI5UaA/ykWoJksbqvWMlpLpNBh241pI4hQrp5LuGC1h
 7/g/6iNLjSo8XE0G+ZHooimmgC2E+YWW5kM+ihiYvk2I1PifJO7jibQCxk/tl76Zl3OL+x2B31c
 CJBtSqOHRWvjoPpBLV8Q5/oi/kjtDwD+IK/WROAFeYtiE0JoRCkHPY1noD8KDe3wlC8gg7qhvyk
 xVnzDhEEgqzeH9HWT88EC3Y8A6AkU+DAbCi9lo9Mp7vbj4cpmKokBQhnUblVN1HnMdKNgKaXHDb
 2vi4a2KTzWjruTL/5zHp9bV84Gc9rE9mXw/oixRinLzcTLEaBR13xQECxdDjLhkDYTp8gBXYy9e
 z4DLe6Ed2hPBuBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291206-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.764];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E604D5C30D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

refill_skbs() is now only called from netconsole (directly via
netconsole_skb_pool_init() and indirectly via the just-moved
refill_skbs_work_handler()), and the MAX_UDP_CHUNK / MAX_SKBS /
MAX_SKB_SIZE macros are private to it. Move them all into
drivers/net/netconsole.c.

Drop EXPORT_SYMBOL_GPL(refill_skbs) and remove its prototype from
<linux/netpoll.h>; the macros only ever lived as file-static defines
in netpoll.c. Pure code motion: bodies and pool sizing semantics are
unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 29 +++++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 30 ------------------------------
 3 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3d7d17c59902..76a569d487db 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -61,6 +61,19 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 #define MAX_USERDATA_ITEMS		256
 #define MAX_PRINT_CHUNK			1000
 
+/*
+ * Sizing for the per-target fallback skb pool consulted by find_skb()
+ * when its GFP_ATOMIC allocation fails so messages still get out under
+ * memory pressure.
+ */
+#define MAX_UDP_CHUNK			1460
+#define MAX_SKBS			32
+#define MAX_SKB_SIZE							\
+	(sizeof(struct ethhdr) +					\
+	 sizeof(struct iphdr) +						\
+	 sizeof(struct udphdr) +					\
+	 MAX_UDP_CHUNK)
+
 static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
@@ -283,6 +296,22 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
 }
 
+static void refill_skbs(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+	struct sk_buff *skb;
+
+	skb_pool = &np->skb_pool;
+
+	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
+		if (!skb)
+			break;
+
+		skb_queue_tail(skb_pool, skb);
+	}
+}
+
 static void refill_skbs_work_handler(struct work_struct *work)
 {
 	struct netpoll *np =
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1a497d12f336..bc491f600a71 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
-void refill_skbs(struct netpoll *np);
 void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4111d6ee8d4b..2fca74b4ea75 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -36,21 +36,8 @@
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
-/*
- * We maintain a small pool of fully-sized skbs, to make sure the
- * message gets out even in extreme OOM situations.
- */
-
-#define MAX_UDP_CHUNK 1460
-#define MAX_SKBS 32
 #define USEC_PER_POLL	50
 
-#define MAX_SKB_SIZE							\
-	(sizeof(struct ethhdr) +					\
-	 sizeof(struct iphdr) +						\
-	 sizeof(struct udphdr) +					\
-	 MAX_UDP_CHUNK)
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -220,23 +207,6 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-void refill_skbs(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-	struct sk_buff *skb;
-
-	skb_pool = &np->skb_pool;
-
-	while (READ_ONCE(skb_pool->qlen) < MAX_SKBS) {
-		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
-		if (!skb)
-			break;
-
-		skb_queue_tail(skb_pool, skb);
-	}
-}
-EXPORT_SYMBOL_GPL(refill_skbs);
-
 void netpoll_zap_completion_queue(void)
 {
 	unsigned long flags;

-- 
2.54.0


