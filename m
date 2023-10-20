Return-Path: <netdev+bounces-43016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC697D0FFF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BD3B2149F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA221A713;
	Fri, 20 Oct 2023 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MR9dz9hZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D841A70B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:57:56 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE108D52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a836d49eeaso10603037b3.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806672; x=1698411472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XPRWmyC7uRIMaPtxuf1nocd3dRXmBXuIJstIek5lcg=;
        b=MR9dz9hZVE1XZThStT2iL5p4p/wk4Pk7BRLbwyudXjjdJOxx5qjnAgOeXh1bw3bgfs
         9XI4vyqSNZjz/1WqgAp/N2ZdxRwHqXg/Wtr4DutE0Ny3ghfIhUVJ4hE9QATu11wku+Eo
         XE1Xa8LAtEuTsQnte3HRcceds9vbKWAoB3BS5NDhWTuNlKikYsgrQMvuU76KFES/Ki65
         LtnR8yGOjGU4iB+LE02ZJJkOVMUTaDsvXq7EDBsa7S31wJ7vOPgqGP5i5FhtBOH7A7NM
         OaxDlJpOC8ZuQCY/cInILXwZu8Qo9c1eDRUulrArDgQeLHRfgeKVmEV7847cOHnm2T+e
         HMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806672; x=1698411472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XPRWmyC7uRIMaPtxuf1nocd3dRXmBXuIJstIek5lcg=;
        b=EesbrifOdUTg2QJnpebFpUHT6lYBhCcCj60PKgukTp7h36yPUkz11656k+5bJUziCl
         gNQHeQ1u/0rsT/DraSJ0HFEiwV12hoq1/VerTwXJEtl2qhvP/T3Xw5LcKrecnAPOBlX8
         EqmP6RO2K79EUpacqFnS4lBb68EKE0QubNbqlKJCFZq24fyYRH5QAk5wTypUan/LKXuH
         EJdkMyKLaF6QTZprkuKlwDEp8gZqhMdc9o1NVf/ik75vYgN3PBwZMAFF3UQPaEKlPMLT
         ag1knTCC4bKqs0x0rQoi+24gRu8XH2QeqmmUMjQ5YLk/meF7GwEu307smgTSzQYYZups
         uWrw==
X-Gm-Message-State: AOJu0YyJ5xepz9kqiIr8eC0CBie5vlO8bMbk8csIIhp0xGLUy2jWYO5r
	16pv2Ckmk9EWw7ubBnDm6K0Hmk8X4VFzyQ==
X-Google-Smtp-Source: AGHT+IGX02mPrUbkQeP0Qxe8vcFuLIcvfLm6CTVtnbaOYYmVbiohV5bywm5nj9bD8SLQfzMptjwcUGIQJMtvVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d644:0:b0:5a7:f73d:e69 with SMTP id
 y65-20020a0dd644000000b005a7f73d0e69mr38225ywd.4.1697806671982; Fri, 20 Oct
 2023 05:57:51 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:36 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-2-edumazet@google.com>
Subject: [PATCH net-next 01/13] chtls: fix tp->rcv_tstamp initialization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Ayush Sawal <ayush.sawal@chelsio.com>
Content-Type: text/plain; charset="UTF-8"

tp->rcv_tstamp should be set to tcp_jiffies, not tcp_time_stamp().

Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 7750702900fa60b3405992e6c6c465b43abff116..6f6525983130e7701e9c6530afbecb9ae374d7ee 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -2259,7 +2259,7 @@ static void chtls_rx_ack(struct sock *sk, struct sk_buff *skb)
 
 		if (tp->snd_una != snd_una) {
 			tp->snd_una = snd_una;
-			tp->rcv_tstamp = tcp_time_stamp(tp);
+			tp->rcv_tstamp = tcp_jiffies32;
 			if (tp->snd_una == tp->snd_nxt &&
 			    !csk_flag_nochk(csk, CSK_TX_FAILOVER))
 				csk_reset_flag(csk, CSK_TX_WAIT_IDLE);
-- 
2.42.0.655.g421f12c284-goog


