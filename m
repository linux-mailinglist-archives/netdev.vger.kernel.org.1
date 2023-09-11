Return-Path: <netdev+bounces-32882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408A979AA6E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF466281201
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF9156D2;
	Mon, 11 Sep 2023 17:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A4156C6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:06:04 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B78CCD
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b50b45481so40097167b3.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451961; x=1695056761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMc1SrA9sdtPR5mLF/Tme9KoRwgcO3km2zNvZk7WqGU=;
        b=TL451cVEJ8kFzuPvs3fBWeARgBrlHLQPBlZlaeXt0CclaT2wij31Ynm4WstRLZveA3
         XDoKfqBSipUij2ZT15HYOzQBKEAMNz9QZurORbhn0t68JoZGHzVW94Z7+AqiwSsmliMS
         FMkdO6P6S1ZYb6tm8xRajZkkfZtt7EXCVj2BrB9blfEM5KjtMjh+K4AWIIpWy/89jyFl
         pl+3HMSh8ftoO93Tm8ag5xc52ewZDjNQPEeSw+3T8UqYjjtaTmPUJb1Su4FwMwn1r+3K
         eIrla2LthZ5iQI64G5vI3msARgQwKS+VDfNwzqgy+oF534H4ZO1oGhtvZ6ina8cIsgDR
         1RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451961; x=1695056761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMc1SrA9sdtPR5mLF/Tme9KoRwgcO3km2zNvZk7WqGU=;
        b=H8r22KdwxcnD6EZaqglS5D8dr/wfHwyubYkVhX6yNEYuyVdIfnkGz/eHAuU7e5sfZn
         heEB7Xv4Jb9EyPOnZdKy3ryIQZ+aT5AShB1GrtdrZCrFm+a5h+sRfXgle3DALxz+AuLo
         8owLlv4vc7eo83IpO6ZgE2ir9mmjAfIgIbFe0idjdyvIGOm9Jsm/vwxLr5n2PD9Ghvl2
         ff3BK2+lTcnJy4eCJa5OFy0R4J5lZkSXVDTEAqzyN83j5AnoqF870i2To8uOptzhLs1u
         tKea7gHmShcFl3Sb3X8Su/eSsf43kFA3pkQIgCq9m9SogQS3PPQER9ooDqW/CCevJpju
         cDDg==
X-Gm-Message-State: AOJu0Yy/ZDVxF3AvlgpPrYHhDlal7zaiQ9DZ64cOLiMPWh9eF172q8wu
	g5MwX4iaNPNtsUNqDHNLlCYH6AoTW/5+cQ==
X-Google-Smtp-Source: AGHT+IEvxh9q48HRd0K80M/H4hhkxUdbSZuqznewsut/6uWvXMNZj3RfIFhWnz1ALMs9UQYhZY8L71joC+/fTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a2c8:0:b0:d77:984e:c770 with SMTP id
 c8-20020a25a2c8000000b00d77984ec770mr236451ybn.5.1694451961408; Mon, 11 Sep
 2023 10:06:01 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:05:29 +0000
In-Reply-To: <20230911170531.828100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170531.828100-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170531.828100-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: sock_release_ownership() cleanup
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

sock_release_ownership() should only be called by user
owning the socket lock.

After prior commit, we can remove one condition.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b770261fbdaf59d4d1c0b30adb2592c56442e9e3..676146e9d18117e3a04fbbfb0a06e511a80d537c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1823,12 +1823,11 @@ static inline bool sock_owned_by_user_nocheck(const struct sock *sk)
 
 static inline void sock_release_ownership(struct sock *sk)
 {
-	if (sock_owned_by_user_nocheck(sk)) {
-		sk->sk_lock.owned = 0;
+	DEBUG_NET_WARN_ON_ONCE(!sock_owned_by_user_nocheck(sk));
+	sk->sk_lock.owned = 0;
 
-		/* The sk_lock has mutex_unlock() semantics: */
-		mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
-	}
+	/* The sk_lock has mutex_unlock() semantics: */
+	mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
 }
 
 /* no reclassification while locks are held */
-- 
2.42.0.283.g2d96d420d3-goog


