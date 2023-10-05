Return-Path: <netdev+bounces-38220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442C7B9CC9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DFF7D281BF2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8C134AC;
	Thu,  5 Oct 2023 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+tJP8Pk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD33134A7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:45:14 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055952570B
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 04:45:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8134ec00so11479747b3.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696506310; x=1697111110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/I0IzC1Ae94yUk95vMQBrmVGBQ8Yi3meGqQpSrssY0=;
        b=R+tJP8Pk/zWLeZ8XtAHA2TqWVJcEQbbCcVbvrjRMD2FPMm/gos6ar9RX7Hg8DKX78p
         2M9Sccjl+e2fpIAq3as71wmfeVFK5bgamoWzr8aE/moToiM4afDiA+Z3tLhNJWmUaO8M
         8wqIKfHFQ4AMBo0k+4l8AWktDcqcJPoOTn7gVDoFP6ASQIXV2ptsOcTMNZwI0TnuqqzF
         jdz52Z8K3l5lG/9ygAqrAsc7cnv7ncCL2Jy12HMszQBXTVANKmylrwyZKV0ujrBihn4V
         9phEABuM5EE3GHg3crHEaUI+UMx/EtteGLIFd5/7C4FC3PagW9vR43q0/bWK8JI/gYrC
         Gc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696506310; x=1697111110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/I0IzC1Ae94yUk95vMQBrmVGBQ8Yi3meGqQpSrssY0=;
        b=KBxCxmks8yl8MM+KV32QEdIl0uqvjLIqjbc3Y2ZyLX3E7PSvsWjsYwf36xR3uVWjgW
         y0LM38FMMxFzl01rogAToL97WCKmTXyJHKKqNx1nyuXFRUIhAeC4WQxewQ2oU6sQgxPI
         5TpMUfu4bpcGP9ycyRWNGT+Qtlta1wd7PVkP2IkirpgAoRr7CXHLWegk4jvgHXPiJ1wv
         2cfShlEeV/kRQUVcx13e9Y0bnJyfpQwfb4r3K0juIvwjUn/s196cXMMTJTac0U+x2h8q
         N8B6b7uHI6ZTPpnd0IcR74CEWQizm+BPOoOcIqBPcK1jrfSn+mzopat1zldI4R9J0Lm2
         x7tA==
X-Gm-Message-State: AOJu0Yzqb/zyZDgLPe8Jg/D6zQw8osI2WQLMfEhYcjo+4jUmDFHP4Ku8
	PKmwwc2zca8Ql5wjbK5fAbLJEq4oJlRofA==
X-Google-Smtp-Source: AGHT+IF2BLeiic94DjzgH7ZK8urOmUi8Dtlo7XtXuK+bqfn3s9EancMspIx+84j4KbwfC8ZSrW8Jo0XxO8DQFA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c84a:0:b0:5a1:d0cf:b65d with SMTP id
 k10-20020a81c84a000000b005a1d0cfb65dmr91149ywl.5.1696506310269; Thu, 05 Oct
 2023 04:45:10 -0700 (PDT)
Date: Thu,  5 Oct 2023 11:45:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231005114504.642589-1-edumazet@google.com>
Subject: [PATCH net-next] net: sock_dequeue_err_skb() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Exit early if the list is empty.

Some applications using TCP zerocopy are calling
recvmsg( ... MSG_ERRQUEUE) and hit this case quite often,
probably because busy polling only deals with sk_receive_queue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index da3f96bdd6f66cbea2f8e17513bff05a036a48ac..0401f40973a584ba4a89509b02510c8352bd6fb5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5162,6 +5162,9 @@ struct sk_buff *sock_dequeue_err_skb(struct sock *sk)
 	bool icmp_next = false;
 	unsigned long flags;
 
+	if (skb_queue_empty_lockless(q))
+		return NULL;
+
 	spin_lock_irqsave(&q->lock, flags);
 	skb = __skb_dequeue(q);
 	if (skb && (skb_next = skb_peek(q))) {
-- 
2.42.0.582.g8ccd20d70d-goog


