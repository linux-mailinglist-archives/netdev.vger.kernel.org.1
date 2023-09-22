Return-Path: <netdev+bounces-35914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552547ABB9A
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BE986282435
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8F47C79;
	Fri, 22 Sep 2023 22:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615A47C73
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:04:01 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F32A7
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c27703cc6so42552037b3.2
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695420239; x=1696025039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xwrzRT/KO5qSSYZzaO0x4OHrIsM4SmlR/wo1sXYCgU=;
        b=xnLUZTpLUD++NYbce7mM+EppAkxTXWqo3mDFz/6qFhIkH/uRk/LOkLFJDH5LUOUNwk
         Zu7j8O1SXAFychEs1MPBmFWrkv3IaiW+D7FNY6GemOIPbjnkYq7pRhZbzCsYG0kH9i5d
         WPnBFciDts+Y9n5f1f15wKZj03N/oL16p2axXpvktHK05nmSPbYO1A9dY7/hRqD56MUC
         gnILJ1ITp+1iU7rG06OSpquKvbyNmmthbdIwelG7V8ux2lGHddmwB4XtrxXovo3ge/NW
         x5NITrinD7OuiSxHVg8TR0iuocqOSht06bhdOvKc6QUQu+8x8mtj4BPVOrRbnSSXUVW1
         lZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420239; x=1696025039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xwrzRT/KO5qSSYZzaO0x4OHrIsM4SmlR/wo1sXYCgU=;
        b=wvMu/GHtzyEmcRD75Sur/4WnVLWrVpAR9czBpvw9CD3DqfhfjnTI2Pp3okjit3z5bb
         aNuaHZnQE5/JeMaptcM/YkD/r6kc9Fxn51kfL2T7oeE7wVRLYhmnBgwSQIuNytltq6Ex
         znbIAz5MSHii1LzGilE5Q2mS2i9N750ntpu3a3sk/YiXjRcTgqT/eFn5/N4jx8gQuOVE
         DZwAqMk5aXZDHT9dEj7EovpDLCAjNlvQYT/D4wlzw4dyW9jIKp3Ny4qtpLMHhRbFKbLe
         IdacjCPUDa+WfIeFVFuYbFFo7HklPv7JsQUXiEmBXqDZyEJpPvAy19eheukxE7ZXFD2v
         /owQ==
X-Gm-Message-State: AOJu0YwKegSZPburT7cXqHbxxcXEV22W1SvZX9CeL9hSXkBsezdcoP6N
	zPp9Xw0ii4+/QTCo/IjQFXWic1vbXL0zow==
X-Google-Smtp-Source: AGHT+IFwiN9/JQwcW/hVuD+bH3UtB/7vzpOg/hdeE6LAuyDeFoBCkYJVoukA28d7gF3vYgo5NkJmnZMIQjFlcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP
 id o5-20020a056902110500b00d816637b5b2mr7885ybu.0.1695420239463; Fri, 22 Sep
 2023 15:03:59 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:03:53 +0000
In-Reply-To: <20230922220356.3739090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922220356.3739090-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] tcp_metrics: add missing barriers on delete
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When removing an item from RCU protected list, we must prevent
store-tearing, using rcu_assign_pointer() or WRITE_ONCE().

Fixes: 04f721c671656 ("tcp_metrics: Rewrite tcp_metrics_flush_all")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index c196759f1d3bd8cb16479522e936bd95091f89b2..4bfa2fb27de5481ca3d1300d7e7b2c80d1577a31 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -908,7 +908,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->ns.count);
 			if (match) {
-				*pp = tm->tcpm_next;
+				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);
 			} else {
 				pp = &tm->tcpm_next;
@@ -949,7 +949,7 @@ static int tcp_metrics_nl_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		if (addr_same(&tm->tcpm_daddr, &daddr) &&
 		    (!src || addr_same(&tm->tcpm_saddr, &saddr)) &&
 		    net_eq(tm_net(tm), net)) {
-			*pp = tm->tcpm_next;
+			rcu_assign_pointer(*pp, tm->tcpm_next);
 			kfree_rcu(tm, rcu_head);
 			found = true;
 		} else {
-- 
2.42.0.515.g380fc7ccd1-goog


