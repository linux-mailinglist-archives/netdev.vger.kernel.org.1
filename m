Return-Path: <netdev+bounces-23645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27976CE33
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F2281DE4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E037481;
	Wed,  2 Aug 2023 13:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C58476
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:14 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38226AF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a89cccf6so62589597b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982110; x=1691586910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMgGdJKViHFeVN6E9gnfazEY0qBvN43LXWSxl2YVMjI=;
        b=U9upOlGPTfi/Fb8jvCm8y1aFeSdSldsHDEr9r7aR5dJunV4OvDO8JY+xq5dKN6L4v7
         rLEaDgVxknVtdsukAUGUx0GCOAyysJ+hgIzfHrEGzznUo6nsmLnqyATTM2AdtYtMYbGZ
         bAZlayyH3Wu19XCppLNoPZqDxZ94E0/+9HljIl3XGeWIKeOIYUcfJXddczHJ/wr6ehxm
         TKpbCUs114yM9Pd96zoJM/A+ty5rvHc1oh7Ee6CnOnUa3seJ9tqpeuaL9fPdCHHxL5US
         ENBXfKHyP6SHJZYoIiz9JsI9GBqHNwgyj7HdJEcIVRn0Q4QQ5clprcB16Juq5rhQkXR8
         tICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982110; x=1691586910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMgGdJKViHFeVN6E9gnfazEY0qBvN43LXWSxl2YVMjI=;
        b=jTdeM9v5oc8G42mzGswMgY2ZL5ZPFKBhA6HusCRVYPGyg/qHhhxOsZ0jTmpEIQO39G
         N6vN7CuKwprRdQUeg7oAxoyXtpNCzl2xMCvoOe+cOdYSgyhPXgPB3yIFgDZ0KIdNi1hd
         9Sv8kswVBgw29iY/FPKpeZqUH2ea5Ck1vnz3A2EROIZ2Mw1x1WU7B9mlJTQWxmhU7XKD
         o5CIpnfUTu2xeaOFBoyCXR4mWhAtujHCvW/fR/r7oPzK2D7ZUPUClKpDar96l3NfZUpA
         LBcL5496SH/SgwjYwDl1nqlByhPvEu4sVRf+l1V5WYQ9sw6pp0j9h0ulo6okEcMYpeCe
         tTGw==
X-Gm-Message-State: ABy/qLbmCs5ASuz5eTPxdzriDtFEqzLYa7SLT7TRIqVbDwjs0U3FF4pt
	UNXKHP+3DUxUR6dIrB9ngiSzw2UrpgxKhg==
X-Google-Smtp-Source: APBJJlEYTnVkHeQz/acj0ih6h1CpdlAKiFVBGV7OuB34OUB/wu7pxL4zPVyczqRKj0b38gv6vxWb+KJ054n/iA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4518:0:b0:583:4f6c:e03b with SMTP id
 s24-20020a814518000000b005834f6ce03bmr122573ywa.2.1690982110819; Wed, 02 Aug
 2023 06:15:10 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:59 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-6-edumazet@google.com>
Subject: [PATCH net 5/6] tcp_metrics: annotate data-races around tm->tcpm_net
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

tm->tcpm_net can be read or written locklessly.

Instead of changing write_pnet() and read_pnet() and potentially
hurt performance, add the needed READ_ONCE()/WRITE_ONCE()
in tm_net() and tcpm_new().

Fixes: 849e8a0ca8d5 ("tcp_metrics: Add a field tcpm_net and verify it matches on lookup")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index fd4ab7a51cef210005146dfbc3235a2db717a44f..4fd274836a48f73d0b1206adfa14c17c3b28bc30 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -40,7 +40,7 @@ struct tcp_fastopen_metrics {
 
 struct tcp_metrics_block {
 	struct tcp_metrics_block __rcu	*tcpm_next;
-	possible_net_t			tcpm_net;
+	struct net			*tcpm_net;
 	struct inetpeer_addr		tcpm_saddr;
 	struct inetpeer_addr		tcpm_daddr;
 	unsigned long			tcpm_stamp;
@@ -51,9 +51,10 @@ struct tcp_metrics_block {
 	struct rcu_head			rcu_head;
 };
 
-static inline struct net *tm_net(struct tcp_metrics_block *tm)
+static inline struct net *tm_net(const struct tcp_metrics_block *tm)
 {
-	return read_pnet(&tm->tcpm_net);
+	/* Paired with the WRITE_ONCE() in tcpm_new() */
+	return READ_ONCE(tm->tcpm_net);
 }
 
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
@@ -197,7 +198,9 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		if (!tm)
 			goto out_unlock;
 	}
-	write_pnet(&tm->tcpm_net, net);
+	/* Paired with the READ_ONCE() in tm_net() */
+	WRITE_ONCE(tm->tcpm_net, net);
+
 	tm->tcpm_saddr = *saddr;
 	tm->tcpm_daddr = *daddr;
 
-- 
2.41.0.640.ga95def55d0-goog


