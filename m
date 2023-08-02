Return-Path: <netdev+bounces-23641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB576CE25
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AD0281DC9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7A748D;
	Wed,  2 Aug 2023 13:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0B7475
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:07 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15132706
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d114bc2057fso7003343276.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982104; x=1691586904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvkZ3bgdVqzKhsFFgJrq0H3os6/TkUK6diCRzUkluyU=;
        b=pT4Iek4hP37dOTGUIiQbU8ShAvBMQyTz0QAanefG6eoNaO9DLJQaSxuqP4QUfCXKDo
         k4FTgmMcKxvkyy2oYT7jymwzKarEIdA0gEJGpF4khh8ArwgjyNU+waMbw5loxDMQ74hZ
         N9QYq7kseqvQKRzAQaSRD13ginQpvoDmV7PJhkee9u9OOK9to0MYp4nwxn6s38DxSzT0
         3mKt9RH7c47sSpBv4qqNcVkc0q8VXxXKhVyxCUOrroBCMWgaPsHXkfzEHGwIM55Ondhd
         IucJB4pqTuLy8rG5fDF2oxCgFLOijvjABV70KQUGRQ1kA3rKNr3O+tSw4n4CqvQ/SFE3
         58cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982104; x=1691586904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvkZ3bgdVqzKhsFFgJrq0H3os6/TkUK6diCRzUkluyU=;
        b=LTiT9tVAZ6trLQDHvbPd075nsvEOZhpB7hrLJac13ZCzisK++vsG9Ug8q/LTnpbkku
         SA1AxAa3BmsAHL7AEbAxWdduU6EK7s/22r0Re4K2woyQ1mFSNM7yaJFYC0bBaqNhOnzC
         C4YppAehkSEYW2eMmCw2xRNKPXw8HziAnJqRFX9Wpu0gxeU/c3LHWEcscVXLm+h0e9LX
         6xuwWE9ZsRRMUzli42+oGgF9tQG2HOaPQXnd6gmF3WeCNtcjlUjoAznVkDPF4YTLBhxx
         TMc+KiqS7Fd9I9NU8xqY6RjtpwNuTW9IfW90mNlztJedDyWpHedhH+nL45KadSY/EGjb
         4Gjg==
X-Gm-Message-State: ABy/qLade1vwCg7wJP+1OvfMfBL61Rw6oDHPcFoww6bj0W/NyoQ2c2N1
	JaURmofn40MpOAWbFReFjyanc9bNmSQAQw==
X-Google-Smtp-Source: APBJJlHhD89mmIpBoyBV1j4Dg68HzHRYAO3/mB6oNsWVm3l+vh+uaEd4P0m1rrmIwK+C82yC2h2ItbL6OiwiUg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c58a:0:b0:d07:9d79:881c with SMTP id
 v132-20020a25c58a000000b00d079d79881cmr99885ybe.11.1690982104428; Wed, 02 Aug
 2023 06:15:04 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:55 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-2-edumazet@google.com>
Subject: [PATCH net 1/6] tcp_metrics: fix addr_same() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because v4 and v6 families use separate inetpeer trees (respectively
net->ipv4.peers and net->ipv6.peers), inetpeer_addr_cmp(a, b) assumes
a & b share the same family.

tcp_metrics use a common hash table, where entries can have different
families.

We must therefore make sure to not call inetpeer_addr_cmp()
if the families do not match.

Fixes: d39d14ffa24c ("net: Add helper function to compare inetpeer addresses")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv4/tcp_metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 82f4575f9cd90049a5ad4c7329ad1ddc28fc1aa0..c4daf0aa2d4d9695e128b67df571d91d647a254d 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -78,7 +78,7 @@ static void tcp_metric_set(struct tcp_metrics_block *tm,
 static bool addr_same(const struct inetpeer_addr *a,
 		      const struct inetpeer_addr *b)
 {
-	return inetpeer_addr_cmp(a, b) == 0;
+	return (a->family == b->family) && !inetpeer_addr_cmp(a, b);
 }
 
 struct tcpm_hash_bucket {
-- 
2.41.0.640.ga95def55d0-goog


