Return-Path: <netdev+bounces-35295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154177A8AA3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF2281680
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49C1A5A9;
	Wed, 20 Sep 2023 17:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E51A5BE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:29:54 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1EFDE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c27703cc6so806467b3.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695230990; x=1695835790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3so/04zPo+i1Iq0FPj7kTegGn9MfPPloXlJKexlKqI=;
        b=qWhxkMwcHF8C4wkkkThfnWuorzxIvKNA+/tEnFGP/wgqnnaUDZJ389XGdn656Ryp7s
         Fnt+zHuyyJxyAwHBetm5Tp6ZRmCClKoPIszlRj2b9ZwO8ae8nPOwReTznFg//K6b2MDA
         93SVtQ1UipRKsQR0YXOCvxFOZ5iMvBtuDbwWSNlIfWyscKZrvBbfDKNskbqhltjDcsLL
         N2vvKvptHSW42Ud2dfaDDa80AiMc/wmbsahL6xdCPWRf+nRhlvLTWccOozWppZtk200X
         ZFXW+U8NEDaEFyVsz351dxWtp/TVyNF1N/RBT7wlpY9/jOBeVRRDIAPCwxvWLjC6h5Rq
         Xd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230990; x=1695835790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3so/04zPo+i1Iq0FPj7kTegGn9MfPPloXlJKexlKqI=;
        b=RpTBwrPv2iJ9NK2C1H+ah7hZxewHh4frGGNNowbmQGL0Jl00r5SgkukaH13BhfZD5W
         CNuzz/zJwFHzzWsREe06fMsgE5WPbaICY6mYVTg2uYpVty2Avi+dpLK5jkr302bjo9FO
         AfZhdkl+xU0hTX7WiSK7eMVliU/pJP7Hw4OSunSOb90LgSf8lxXFNlfepYW6rx8M++is
         gi97X1g6n7+bS8+6Qn7qaJRjIpZ9fFvAnpyy2rTk7VifqMFe6hsAv44wuJbw1O9sQP7k
         +BBJxBXtgLv6SFWn2kuawst+WFdHPXb+E1EdWOLFrR8feAFjkSicfmyAPtjP/xvwi7pn
         Ilgw==
X-Gm-Message-State: AOJu0Yxm5IiAuDDgtKBbtI7et/As/K0dGbt6QtV5lAwFTjhAtJiuNwtO
	1FRwmSD0MvIDE5xQni14+LnWKv7RX5bR1A==
X-Google-Smtp-Source: AGHT+IGckiUQW1nSi5KCoLd4g4mPooKMicPhDMPFQD41B3ALENCR64OotN+4d5xCy+k94ChUXSznGVf0XnSj4w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:cecf:0:b0:d85:aa2f:5715 with SMTP id
 x198-20020a25cecf000000b00d85aa2f5715mr37188ybe.10.1695230990252; Wed, 20 Sep
 2023 10:29:50 -0700 (PDT)
Date: Wed, 20 Sep 2023 17:29:41 +0000
In-Reply-To: <20230920172943.4135513-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920172943.4135513-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: constify sk_dst_get() and __sk_dst_get() argument
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Both helpers only read fields from their socket argument.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 56ac1abadea59e6734396a7ef2e22518a0ba80a1..2800d587b08ddc93d7d190ea71dd96a1a3591c1a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2141,14 +2141,14 @@ static inline bool sk_rethink_txhash(struct sock *sk)
 }
 
 static inline struct dst_entry *
-__sk_dst_get(struct sock *sk)
+__sk_dst_get(const struct sock *sk)
 {
 	return rcu_dereference_check(sk->sk_dst_cache,
 				     lockdep_sock_is_held(sk));
 }
 
 static inline struct dst_entry *
-sk_dst_get(struct sock *sk)
+sk_dst_get(const struct sock *sk)
 {
 	struct dst_entry *dst;
 
-- 
2.42.0.459.ge4e396fd5e-goog


