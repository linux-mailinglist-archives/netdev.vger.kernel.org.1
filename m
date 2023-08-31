Return-Path: <netdev+bounces-31589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321C78EEFF
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F11C20AD3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E299511C85;
	Thu, 31 Aug 2023 13:52:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BC11718
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:19 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803EEE4C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77bd411d7eso702141276.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489937; x=1694094737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3SxYXj+bHSVoxK9iIo7sgdtFV536QNw85kXbHs3R4Y=;
        b=EZo4b9m1CiYUQqJueyZWUKLkFlcu6NePsAfStYzYC9V51J4jxKNfKAgubi+5eYErup
         YBoRHqL2shiWnbiwQOMaMCM5pHNTJ8I7Cty056c5wZcUeqzViPggBUAYSHhUteacOyX5
         0h6htk3ze7nWiVGuWXlueaRYZCHev2PdHzREmhGyqjhB5VZWgimV2d500plBoSvWocBx
         SewszS1l11neqReBNw+LOIrjvbBRDqc0K62XpScZbf20dgliW2D36kZlEWx8winC/f6V
         x1BbBrx/2wN25n8jdHoAraWOQV3uH44GIpWVbG7iRJglqUlW8vElh4nbGg7dFcDGxcr8
         1GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489937; x=1694094737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3SxYXj+bHSVoxK9iIo7sgdtFV536QNw85kXbHs3R4Y=;
        b=K2G8g4v76NK+7G6s0oEYc3DGGo3NrKMlXzs5ZwB4eSj97b2GNPTs7iMa3WAcwc1Jk4
         hPp+UDy31Zqtzsew0MxZDwUupY7Gi3ekEgaOoPULByxxWYX5qk8v/6gxLFmDyZLsgSvF
         tsSwTP0jBohFB/+AmRRKZAPXflXn21IVlpL6WZ7EV/z5gOsBZphkQADAybvwGGFTuEi9
         LvvjkNxwJDmIeAss8Ey4nZc1O2qo+VKqxpB55FzeWp2j4+Ep43yWp5Eeb1W89KIq1ED/
         BvlyQ7D3djMg1UpqgNzaJPt4P0cjGgrDCudXs0DW6iD/WDKNpAU79QgSpGgs4wubwTNP
         xFeA==
X-Gm-Message-State: AOJu0Yw8QiKJ9LlAF7XBE4ARsm90Oux7Zpq1eSEDQMvdJVnQ1YdnYIna
	JA6bjK/9vRtgpqSAJ47ai2acYzq5vm8KDg==
X-Google-Smtp-Source: AGHT+IGD4k+dB7XyOuYzuW2PwpNWXRXTIb2LtydSVEk08fojL1MFo4MGoatBuU5qhNDDuOTdl2uOkH1qktWwvA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:158c:b0:d77:ff06:b58b with SMTP
 id k12-20020a056902158c00b00d77ff06b58bmr153610ybu.10.1693489937746; Thu, 31
 Aug 2023 06:52:17 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:08 +0000
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230831135212.2615985-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-2-edumazet@google.com>
Subject: [PATCH net 1/5] net: use sk_forward_alloc_get() in sk_get_meminfo()
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

inet_sk_diag_fill() has been changed to use sk_forward_alloc_get(),
but sk_get_meminfo() was forgotten.

Fixes: 292e6077b040 ("net: introduce sk_forward_alloc_get()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b0dd501dabd6a86aeda148007faf35c3c50a2bba..a61ec97098add711e0e5bc587733b0579aab77b7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3743,7 +3743,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem)
 	mem[SK_MEMINFO_RCVBUF] = READ_ONCE(sk->sk_rcvbuf);
 	mem[SK_MEMINFO_WMEM_ALLOC] = sk_wmem_alloc_get(sk);
 	mem[SK_MEMINFO_SNDBUF] = READ_ONCE(sk->sk_sndbuf);
-	mem[SK_MEMINFO_FWD_ALLOC] = sk->sk_forward_alloc;
+	mem[SK_MEMINFO_FWD_ALLOC] = sk_forward_alloc_get(sk);
 	mem[SK_MEMINFO_WMEM_QUEUED] = READ_ONCE(sk->sk_wmem_queued);
 	mem[SK_MEMINFO_OPTMEM] = atomic_read(&sk->sk_omem_alloc);
 	mem[SK_MEMINFO_BACKLOG] = READ_ONCE(sk->sk_backlog.len);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


