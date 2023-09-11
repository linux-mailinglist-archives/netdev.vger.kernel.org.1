Return-Path: <netdev+bounces-32883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E062879AA6F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3C1C2040D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3F156DE;
	Mon, 11 Sep 2023 17:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF9156C6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:06:05 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FA127
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8027f9dfefso2961109276.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451963; x=1695056763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RpvnQSaCTE/6zaLHNRQ0bZmi3mDkmnmHp6VTSl/j4=;
        b=Kq52n7rjQ3CGJ2ynRC2k3m/jNnKai/3e88dCT8hSzHLjeBcPFGCWiL2BgQ24QgBMBx
         9IRAcoCcISq8skCxPdefmDLzXwkkunq8iljwcRe9mkm+4CM6TasbVJFhJKZPXf58nxuT
         pNMnXze9kJ5rPxBTzG0xJxFgmCSXMxFqptWYwV2Oz9BnWgFsgvSXw+QVayUAuh3RQkhJ
         vqvLJz9GVrfpFb3ShRkRF+deLAI0dNsov2cCCHKf8iZc3jP7OK+pEhWhSBYfmLtd4hM4
         C0AiI6i7R47TDhPL8eVk38vOUsnjCZPjM/TqhvaLrMlwEiadg1CFcokD4AYTavSUDpoU
         qv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451963; x=1695056763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RpvnQSaCTE/6zaLHNRQ0bZmi3mDkmnmHp6VTSl/j4=;
        b=qlCFecxlchT6e7ACeanXrm4mTDsSpRsFd+fGoZCSfnRGXIF5Ix8bMZDEeYZxuSpOV/
         nGf6xy0lHDCX7jtlWe6+w99q0TFRntKjWcRLiVG9eyG2sRSGr1VJkXtNP9BoDA6++B4Y
         nADHCT3PVJ8zYfp5nGt5fUolHdB0Xq8Ua0k/BTB8w9XRtankY8+BHZd7ub97SDJXzwB3
         bBz6PDo1ONo7/frb9htDUBtE5lE/T/aDe2G3RugjqZX4rxcM1zAV2UcspFz5ZUL6zYG+
         JjSsCJ1OhYFVDiJIlEH/E/I+TJ1wWs2a4qCVkzXCo28hJpf/kaQv5SsBAK6IFRwu3OUs
         7/wg==
X-Gm-Message-State: AOJu0Yxx/qmQwcEr1rylc2wemUc8ZKqO0QsApa4o+KQZmyIVjWBQWiG4
	C7Bf5OUpDXAuWW1Nb9pI5ZPULZZVfK7XqQ==
X-Google-Smtp-Source: AGHT+IFghmYjTEkEzlTNbIwO82AVix9RTUutjXJC0Bdi/Gd+I/POjDobi1R4Izf7EMNY5Ct7XkVDrebcwGQNJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d386:0:b0:cf9:3564:33cc with SMTP id
 e128-20020a25d386000000b00cf9356433ccmr235435ybf.13.1694451963196; Mon, 11
 Sep 2023 10:06:03 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:05:30 +0000
In-Reply-To: <20230911170531.828100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170531.828100-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170531.828100-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net: call prot->release_cb() when processing backlog
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

__sk_flush_backlog() / sk_flush_backlog() are used
when TCP recvmsg()/sendmsg() process large chunks,
to not let packets in the backlog too long.

It makes sense to call tcp_release_cb() to also
process actions held in sk->sk_tsq_flags for smoother
scheduling.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 21610e3845a5042f7c648ccb3e0d90126df20a0b..bb89b88bc1e8a042c4ee40b3c8345dc58cb1b369 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3001,6 +3001,9 @@ void __sk_flush_backlog(struct sock *sk)
 {
 	spin_lock_bh(&sk->sk_lock.slock);
 	__release_sock(sk);
+
+	if (sk->sk_prot->release_cb)
+		sk->sk_prot->release_cb(sk);
 	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL_GPL(__sk_flush_backlog);
-- 
2.42.0.283.g2d96d420d3-goog


