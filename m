Return-Path: <netdev+bounces-291203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBWxMZgjE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE45C30C4
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690F03014952
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473E3A7F41;
	Sun, 24 May 2026 16:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57E39934B
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639146; cv=none; b=dKJAeaAr9W7lp8avWd1hvF9OV3SHr5zBITJMiXKzWeXFpBfL8dQf5/4oREgefUdu5/9cyFVGGnNl0g3k06nT8zo52DZrzOpigZwMcPRwMSvR6reyhMbAn5SpkPOPBX9oFfEyoC/bgr2djmC+Ivd4G8Cjo/MBvzeaFxRWotU7KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639146; c=relaxed/simple;
	bh=T9qIxgaheOEm+rMyCgkNcm0rzEL5ECu5Zl3Ffl94m/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzaeJyRPWhr0DMJB23TNDY2G5BxG7DPlNaenGqwUsascveLF6Kp2QnUni2qS8+i08XDKveBAUKZJ9R1Mj717V2d/qFO2f5ORqPreGSuKRJr2yTKJTZ89B6yM3A+pCkbkE+aVTBwWmOLI5KmtJlhODzsAS2/RhpYe+MHRjY5YFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de4be15125so8980557a34.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639144; x=1780243944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=movPS/nWqhcug4Zf5cEU9tpTwZ6Ry4Oer6dKVmnqmVw=;
        b=QHyiPLfjIaMhAKHGBDCggqaX+yHIZulSEnpX4JZlB7Mfqr2clBLAYOGrk8HfHsuGYf
         +TIT0LNL8IgS0Exc0uU+/OBLAYifiAuD9ul+paX0lWBRTN4+iXXJx8qTY/gZ03E+WP7O
         QfjTTts7691LpTmA/Bac6cmxHzXy8RUJTBMYatEbEYcIzV1AvI+WeLbMUfml0gaqQ5Fh
         aGbq3ez4Wz3yNmpareZ9QqqVlUE1UlP9lUYSw3z40eZrQXOKr1OFs5mmHpuP52DQQqQQ
         ue83k8xPiyKmATTuTM84zggDIPMsPdF/elgIrc3umKqdxnoSLRdm0tk80F2GFUtg0JYG
         3h6Q==
X-Gm-Message-State: AOJu0YxV7YwdjyvYHe8tUhVta51AvzjAYgfk4LvtXhzZl2pbvQb1YKn7
	w6OJAy5AoICSzo8p+H9T5DkMjQ+B/By1kSaHuPn2Ajk3Rql+FJYa5Q7m7JgaAABS
X-Gm-Gg: Acq92OHhfY2uxyDhTXtJTil7JJlWUiJSnk6VR6XBxXvUlqzU2ShsMD+e/8c8xBSVSry
	BpVg9QNgFrfOfV6XLANpty4Z2d3rdu5X6SPIjORTNB+v1v/mlXl2pDi74tVt1l0T9gTX5OhRL5l
	vjwqsABzMAzR1Bujy4ZTtVhBFryrPznFxHeKvCI6Xkh5dkW5oXkG3dgvPAs/XyTQWPLbnCAK6Db
	DW3uep9NskZjzJnNm9HEMoyE24CmUj/K6v8jJPVrk7UWCMfpOrKWPw6UEoq/vAGrP6ik0CrUJx/
	ZnvZuTgMdcrk841PdT6LM6ELJw96zNVYYYVqUXq7lFh6XHvLAFHX3wvq00/xXbzm8/wwOCqKbEL
	PNciKSeadPHD6zizgFL+O1jhwp/1SCf2L5LFmxqEcGI1OljabIwmPK5WA7Sl2t5qJhqQFph7MZy
	/DH43w5th8OjHT
X-Received: by 2002:a05:6830:3789:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7e5fed4ba10mr8019625a34.10.1779639143752;
        Sun, 24 May 2026 09:12:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60666ae5fsm5566542a34.24.2026.05.24.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:17 -0700
Subject: [PATCH 1/9] netpoll: export refill_skbs(),
 refill_skbs_work_handler(), skb_pool_flush()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-1-909d1ab398b4@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=leitao@debian.org;
 h=from:subject:message-id; bh=T9qIxgaheOEm+rMyCgkNcm0rzEL5ECu5Zl3Ffl94m/w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlhqHigKt/B4HA1tPvLMeXNVsZ5gVhxBN+9
 Ybr7Zmaw3CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bVWZEACRAQ1Mga9O7ihpelGl2ZqjGLT6b9tCB2RtvtZ+1WcwPMMAF2i+z93SQr7aCJu4JukJC8X
 ha8cJAm/zQ1sM4m5wGsQR0686akwAynFbEbQLXkNzs3QDHMoZxiTTuA3ZYBemOPFpjG/040tkQ0
 fXmJ+sDvcQPYEry5vp15bGwBJqG5ezkyx7PauFnm02FScy/9ytU3HnfGtmA6VGuGECH09V/y3Nb
 rYXjhtWz0CLMTjiWJzPWweQGkQLzg3Ft10GHUkhFKp7QfMYZEstAnipATnpC9zBHEDtL0HwEfh1
 r3nDkkrJi6ueaU1l6ZOaNqxFoFISyit8xyl7alVh2CXhPuBahM/5NUznNOXdSg75pbfaCkrj+8+
 fKaKglGBOrbm9XnWbvFzaI8EIP+Ox0pb4IUkacM/Luy69qYwNega80FciWabzDkgpNoTBrQkb2O
 VldQstss2VmkVmTkVcUADdXijeYk5rUaFP2jIyTNxmMaODKNduIrHYRfbYmFxuaW3hXI6dfPXfL
 E2OhcC43FLo9zdRfhOwaO9p8HBGdxO8xbu9YHP1qQ8vGIhCGwe8NZiPGU0DjLnXstrfMmhsVaxP
 Z6G6+tP8nUB2ZEsOb43VDKWt7nEEsDFSsWYQxa8jm6lDMy3rLCU6wqOJvnTcsWbQgng0xDTkA4l
 mGq4dPvo17+8u/w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291203-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.790];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BEE45C30C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These three helpers manage the per-netpoll fallback skb pool. They
are file-static today because all of their callers live in
net/core/netpoll.c. Subsequent patches relocate the pool's owner
from struct netpoll to the only consumer that actually uses it
(netconsole), and that work needs netconsole to drive the helpers
directly while the function bodies still live here.

Drop static, add prototypes in <linux/netpoll.h>, and
EXPORT_SYMBOL_GPL() each. No behaviour change.

The exports are transitional. Each helper is moved into
drivers/net/netconsole.c later in this series, and at that point
its EXPORT_SYMBOL_GPL() and prototype are dropped. By the end of
the series no symbol introduced here remains exported.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 3 +++
 net/core/netpoll.c      | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e4b8f1f91e54..9fa4deed0bff 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,6 +74,9 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
+void refill_skbs(struct netpoll *np);
+void refill_skbs_work_handler(struct work_struct *work);
+void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 33ab3d827a42..84cbfa85028a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -220,7 +220,7 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-static void refill_skbs(struct netpoll *np)
+void refill_skbs(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
@@ -235,6 +235,7 @@ static void refill_skbs(struct netpoll *np)
 		skb_queue_tail(skb_pool, skb);
 	}
 }
+EXPORT_SYMBOL_GPL(refill_skbs);
 
 void netpoll_zap_completion_queue(void)
 {
@@ -356,7 +357,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void skb_pool_flush(struct netpoll *np)
+void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 
@@ -364,14 +365,16 @@ static void skb_pool_flush(struct netpoll *np)
 	skb_pool = &np->skb_pool;
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
 }
+EXPORT_SYMBOL_GPL(skb_pool_flush);
 
-static void refill_skbs_work_handler(struct work_struct *work)
+void refill_skbs_work_handler(struct work_struct *work)
 {
 	struct netpoll *np =
 		container_of(work, struct netpoll, refill_wq);
 
 	refill_skbs(np);
 }
+EXPORT_SYMBOL_GPL(refill_skbs_work_handler);
 
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {

-- 
2.54.0


