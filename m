Return-Path: <netdev+bounces-22309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E53767019
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F07F1C218AC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54F13FF7;
	Fri, 28 Jul 2023 15:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6614269
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:31 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9835AB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso2123088276.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556608; x=1691161408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmMYHb+PXkbgMFikc23mgRM1bgAaPw1kHXZmklZsAwQ=;
        b=Uj0VEf/UX1gpR23tQI3GFlv9+Dsgp7n33h2vBqj9MO4ON3y3Scqjmb09e4eBXCwvR6
         9ZWydL6S1UjLa2nvBX1p0MMGEpOJ7C37TJ3cGfC3KDysAOq8nue0rJo/NopsQWylSn9k
         Kk0mnMw1QCByvmpMMozDE/UD69yZXJaF8Bnn0jHL9gCM3rky3aZT4WeMGrAYi5WWFe26
         HMItzyGFrTrFzKkkaRIqEwL3kKJIHlq4dDjPY7xRQjNIZIPC2Pv7hDBD1Z33WLfmdZXS
         xZ36kpZTS3m/P5HVmvWnDLAnbCPOi21wxjWwgFwzIZ4N3ljYze6UWniPsgIzEo87e10j
         rSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556608; x=1691161408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmMYHb+PXkbgMFikc23mgRM1bgAaPw1kHXZmklZsAwQ=;
        b=R+fDEwpIUVSpKtdxWnxBHyAykl7pkfy7pG7OvhxiO8trmauCclNkNZNXmE6+9eK4ZX
         0JfyFsiUQX9BznGdRlGOhAi1yQ1w+pHX1Lu4utDx9go6/63doIGRgEW3Mmg5WrRtlaoi
         5zWVg36cjIjubtYc2z2IriPrqk0nhTpvtZyr3SvP8sO5LXuwqWImdMEqf8Bl1J53Dq9f
         cPMiytlgHZqKZ5LKwqP29hRsXQF+XCH3AswJOcRkvpS88osBnTd01aCsOE4rrjPAe473
         daM8Sav25qzcOqpg6E+adtx2Z5lFGXqOJ1Up5pcx/EOnfJF9tnFiMZZZiB4+U04WdApb
         bc1A==
X-Gm-Message-State: ABy/qLbZfQyePzNHz+C6IB3PYm3glHNZYH8ceiPAJ5UYS0uv29b2Bost
	wo1dc86dbaRt6ntxQ8KV8jXfj57FzIe8sQ==
X-Google-Smtp-Source: APBJJlHw9JFVLvDvbcb3DgT1FJaY3HEoHL6uFtrZcF0PXd8jiEVK3wiLTl7Exh/9AP4PtMLjKYyFKcn5L1Jpag==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:37d8:0:b0:c64:2bcd:a451 with SMTP id
 e207-20020a2537d8000000b00c642bcda451mr9216yba.7.1690556608441; Fri, 28 Jul
 2023 08:03:28 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:11 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-5-edumazet@google.com>
Subject: [PATCH net 04/11] net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_rcvlowat locklessly.

Fixes: eac66402d1c3 ("net: annotate sk->sk_rcvlowat lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fec18755f7727206a0b8c0d486b14bde2347296e..08e60500160571e46c798e6cd71d56234a516fd3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1730,7 +1730,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RCVLOWAT:
-		v.val = sk->sk_rcvlowat;
+		v.val = READ_ONCE(sk->sk_rcvlowat);
 		break;
 
 	case SO_SNDLOWAT:
-- 
2.41.0.585.gd2178a4bd4-goog


