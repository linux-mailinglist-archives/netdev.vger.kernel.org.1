Return-Path: <netdev+bounces-25402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1E773DD9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC5280F7A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8E14294;
	Tue,  8 Aug 2023 16:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3713AF9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:23:00 +0000 (UTC)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A8B4F21
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:22:41 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-40ff238340fso54944281cf.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511739; x=1692116539;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/HtqSSo24ZSf94NQl8ByRHElK56950aw4c8N6JXUUo=;
        b=3tk2DsMD+RjTzlNELXCoNDEiK33BIBp4ZZekHPPuMft5RVkb4Ym6q+iBW5B+F/WyYo
         xubS6dYWNbL+wWDj3juiS1jJv+BZHH5F+jGu6uzX4EWNczX2/hNVoo3gxKeg8GEk3+Hs
         1p9EujkWuXblvw2dZ6N5jC/S91ginHhw/3qPrd7u89s8UGydnnbnsWpUgW3Xu0F9Dl4N
         KCHCc712ejHSZBfeK/FF1UGF1s3gmUelUQ27nuC334S5bssipMFLeeoCxZyq3UsK0ENH
         qrw8YiNp+Q7PkZ15XNeHT+PfEQsBany7Af3CnEnSQ5pW3BEnfRp3OHWwqxU9EFNJDmm5
         olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511739; x=1692116539;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/HtqSSo24ZSf94NQl8ByRHElK56950aw4c8N6JXUUo=;
        b=gcVtrV19HIVsvvlrkRygXUGtF54fLz3dBJxHyEnh78Nx7wAHtA4cnOg9SMohctdQtD
         Xni1lUsIZ1YfkY17gTccEI1eqY+ZdeBqh0UZ7wVhD/RLO9go3jneCemdCwRxHFmRN4Z9
         84G9+NL88dG+530ku3kS7sfckwI6VU1omD5CUiDBC0REG/tvTVp6vXVyJtSBss8ORfAD
         Fl72+dIpMaPv2X3s/jJ+x0g0NQXkHisYzB5X4GBem/a8sifLaH9n+SZKUdRbKxSlV3OS
         O79scBl1MtKh6InFZPQL+erbCcjnM8ShjmLljo66MC8cGkQRL4qsvqmuZ2Nx7f5sX6dm
         oBqg==
X-Gm-Message-State: AOJu0Ywds95SfVUwzodxTbtu+wzN3KIYjgw9dRPVyqBPHMWHA/cXOBtK
	ov5VyMHuWZuTqbrePsCUm98QHIsGaMq7GA==
X-Google-Smtp-Source: AGHT+IHudCzS86GVLQoZMAY5Vb3X73K+rWWtPFCQvAr3TG3Gv4/smSiPCjLplnDdEfEG7fkYSR85/HZXAZryDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:cc4d:0:b0:d0f:a0a6:8e87 with SMTP id
 l74-20020a25cc4d000000b00d0fa0a68e87mr68507ybf.2.1691484570168; Tue, 08 Aug
 2023 01:49:30 -0700 (PDT)
Date: Tue,  8 Aug 2023 08:49:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808084923.2239142-1-edumazet@google.com>
Subject: [PATCH net] tcp: add missing family to tcp_set_ca_state() tracepoint
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ping Gan <jacky_gam_2001@163.com>, 
	Manjusaka <me@manjusaka.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before this code is copied, add the missing family, as we did in
commit 3dd344ea84e1 ("net: tracepoint: exposing sk_family in all tcp:tracepoints")

Fixes: 15fcdf6ae116 ("tcp: Add tracepoint for tcp_set_ca_state")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ping Gan <jacky_gam_2001@163.com>
Cc: Manjusaka <me@manjusaka.me>
---
 include/trace/events/tcp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index bf06db8d2046c4a7f59070b724ce6fc7762f9d4b..7b1ddffa3dfc825f431bc575f4e86a3509dc9426 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -381,6 +381,7 @@ TRACE_EVENT(tcp_cong_state_set,
 		__field(const void *, skaddr)
 		__field(__u16, sport)
 		__field(__u16, dport)
+		__field(__u16, family)
 		__array(__u8, saddr, 4)
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
@@ -396,6 +397,7 @@ TRACE_EVENT(tcp_cong_state_set,
 
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
 
 		p32 = (__be32 *) __entry->saddr;
 		*p32 = inet->inet_saddr;
@@ -409,7 +411,8 @@ TRACE_EVENT(tcp_cong_state_set,
 		__entry->cong_state = ca_state;
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c cong_state=%u",
+	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c cong_state=%u",
+		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr,
 		  __entry->saddr_v6, __entry->daddr_v6,
-- 
2.41.0.640.ga95def55d0-goog


