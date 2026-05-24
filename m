Return-Path: <netdev+bounces-291207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBuzIa4jE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409125C30DB
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B80C300E257
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86203A9DAB;
	Sun, 24 May 2026 16:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C9E3A7D81
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639152; cv=none; b=V50NZRMaZNfN41fN4LgmrGLZrslWHrja4/bHZcjWpFkYWjTRW0bOZtMUHlnyn3z0LiviwQMHJAwLCwMeaPM1ffUClIIlRIenaNTXrqkCw7d1H9tDSJJXVo+wGM5JdoyXiYtbD+7VanCW/dmi5CWrCzm68+B7GNSejROGIDoiumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639152; c=relaxed/simple;
	bh=2+kUJ9MLWgAjyqEnqV6PmrQCVE8DwsUu4Xz4X+NXL/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3Jx4z1ALjVm/8onpu1nDneW+ayWW9hUDtD2NLrHY4K20lZZoqmdROli+sI4v+l+oaUu0ofqf2nh7ptQGioVAA2CPjfvQckUoXO3ABwXQQEyksdl2+yc4HJRMmXhJ+PlYh8CpMNUZukWwyEyurfi2h//Bg+h35RvBLou7Uy9ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47c7b282e21so3472866b6e.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639149; x=1780243949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKgkaHoit0BwRCJTQUnz/viZDI3hhr4+HERagrPW2J0=;
        b=Dr7gmAYDDt/HRDRxZUKJWQDSYXjKLufV8E+5ldg5bDjWWTBcY6T+5DStW4Mk1w+iDa
         pcz7QO6UFJNXhaibKKs1FKEqWb9+ug5Mj3LNm02T+AIAtPLPd6OdOu4ZdTw97+IwVqqG
         Lc+UVRb40hB1bW4CybrYKqAWswuy54DlFn+Y7BsY1tJUWnVhmEhZPYV/KPgFsAAle18z
         GRR38Oh9H96bu5MU3gQRHBJYa1re13ajsUJt1iQMpbCpo9+WmyltuGUqJ/Kl1F5Sb92I
         NgjT0/YOI+XspnHrDV7ufk7KjGAi6Vy9hvO5UaVuFqVC/2f+n+RAg/ZCaIQls+KJ4pkN
         fkcA==
X-Gm-Message-State: AOJu0Yxlcj+86bJ38vXh8mFjQrzDDqxpExRNp3UJO/sH6w/XI/eVca0o
	l3SDIaojpRRYg7N/nKqVBujwKYohqAmUpqYYgmDb9pl2ePpXx5GpxvTd6lpdSEVo
X-Gm-Gg: Acq92OH46KDo4fOn6LyORqIgvKloERTN/B0HWmYvxBYxXH9skQDLTqUlW1Z2qjG0i5D
	WFs3pc6F6PL19PXDlQHYVtZVHhJSMGkKcG0fycfM+WvFldHceE7Aujw/5V/QEualAqYMPJkVicC
	+7cARaU1/INfCZDEs4DO+Ns5J1RBJIYxtxEw1+sUZIsyWzB3XgMB+OOkIeSdhtLpRll2p+FnuP5
	Zp3yxgZTPUVZgvDGQ6Lx+iEu/F1AKG/08beb9ai6xnpOxuY4bpAp98vz/8YYJQd4BcnKDd6OaHU
	6Tny9EeU6rmRfB6bAze9EUPqB2u8pizul+4GX7sPeKDhqlT3uovFPUVEbRw8wkaHDe8Fe1dnGJa
	3mYwYVnWezJHi81f00iEGoYbkHfy8fF+wkLdUj5aW0zdLfx0UMLaitZN6wYfOqO3DSLIvxhaK1Q
	sV0t/YIRCV9mkOE/35Km8HEBV7
X-Received: by 2002:a05:6808:1455:b0:485:1173:f62a with SMTP id 5614622812f47-48549d8fb9fmr6366031b6e.1.1779639148953;
        Sun, 24 May 2026 09:12:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d1551sm7990476fac.5.2026.05.24.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:21 -0700
Subject: [PATCH 5/9] netconsole: move skb_pool_flush() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-5-909d1ab398b4@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321; i=leitao@debian.org;
 h=from:subject:message-id; bh=2+kUJ9MLWgAjyqEnqV6PmrQCVE8DwsUu4Xz4X+NXL/8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlWZOrmYcQhvL8Zz9oK7ZJzlc8K4A2EKmR7
 XyRlec+oAOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bSV6D/4v+pU1rFx8RcKdVfCwz9IpWpp0qlv/6RwmeOCKfR9IsDj4acmmjA9DPOEiBwKtxQ+Z00c
 AxXZMUiKxOyu1T+w51IYFhedw5K+VJsG8H1JomrLTnWKhu1fZjanVYd6CihGP4RLzh7aCynnLwk
 CLqf16BeadcOr3LF456e8d/+FCi5USBT/Ix/cLCW6MQJNWeg2i9z9+zN+CQeDc7dBfJcSncoUh6
 JXngMlJdGcLcd5N/Vv18SfGI/vVmrf3DlSZjMEZvH8k97vbbI+OaStWU5u3IeD4GQCA2D28FZtO
 R0p6BLzJT/MT9v4VYS9Q8FNd5o6Iy78MfbTESDIOCFoep/9fnXvbm7ZBXrqmxsYAybktSbQ90cf
 K1tN9ajtdbHd+8EpNTAJABnHKR6bwzAjbV2eryeBugrO1TKywOEMyfku36IzhY5aMqKmY0zFdOQ
 nwKBrbvk59TwxLV9BgQmuBdsYKQVamcqBdeHh6uQrGHByjJ4rWv48pUrnME2V6r3fWNsl15ScTa
 YWXhueqWTA0eG2Arcg4ttDxMvl7lrYR8ivJfjmWY4zC3v1HU91qeVv3LzSLtWnZb7OQzDdu7KJb
 XQ7WTm6690eYWfcNug4L9yPLHHZ6eIGAc3dXOMz0Ulb7NdjhPzpa7WSX1Fn7GZjR7qaK+eBAeC3
 x6QUVyI/9hklzlg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291207-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.761];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 409125C30DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_pool_flush() has no callers left in net/core/netpoll.c after
netconsole took over the pool lifecycle. Inline its body into
netconsole_skb_pool_flush() (the only caller) and drop the function
and its export from netpoll. The prototype goes from
<linux/netpoll.h>.

Pure code motion: cancel_work_sync() + skb_queue_purge_reason()
semantics are unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c |  5 ++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 10 ----------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 76a569d487db..a8ced60bef7a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -333,7 +333,10 @@ static void netconsole_skb_pool_init(struct netconsole_target *nt)
 
 static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 {
-	skb_pool_flush(&nt->np);
+	struct netpoll *np = &nt->np;
+
+	cancel_work_sync(&np->refill_wq);
+	skb_queue_purge_reason(&np->skb_pool, SKB_CONSUMED);
 }
 
 /* Attempts to resume logging to a deactivated target. */
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bc491f600a71..e4b8f1f91e54 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
-void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2fca74b4ea75..796aab90e26e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -327,16 +327,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void skb_pool_flush(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-
-	cancel_work_sync(&np->refill_wq);
-	skb_pool = &np->skb_pool;
-	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
-}
-EXPORT_SYMBOL_GPL(skb_pool_flush);
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;

-- 
2.54.0


