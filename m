Return-Path: <netdev+bounces-18642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC17581E2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C046B281123
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E6134D8;
	Tue, 18 Jul 2023 16:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D2125D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:16:23 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E668E0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:16:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso43522997b3.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689696982; x=1692288982;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvDgLSgySurE9S7gtxbI7Jh9l1V++d75HrpOOI5f9Vs=;
        b=Lm4qkw8i4t/g5D6StoGtMaDn8ARTr0u5ZijjaxEQZec4L6TlhmCky27TFlF0LXYbAZ
         DZ71tuAZTw67GLRF9A2dvuXKVo1GrvjgtiCXslno0VxyYxQYQdxTiMzGTHcyly5aWX2y
         25nW5wAqKEmX9W1nNg1sYN9/NdfJ8H/h00C20vk+6kkzTZr1dy2sNikwBqGafDeI7u7u
         6QS1LQdBNtBeJ+lT2lt2sYJTzlXSl+HZjvLJTxotxqndctg+olrqGcvBzb6yKjPKRXVZ
         YK8/w+xtVPESutGfvuuT1n0gXzzREZWfGdmcPkAoCOv58fYAGpYL1OOMJrq2ELMYiJSY
         2cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696982; x=1692288982;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvDgLSgySurE9S7gtxbI7Jh9l1V++d75HrpOOI5f9Vs=;
        b=juhxIYS+COoXMsAVAfgaur0gYENCFejB/cUa/l8S/EGCZ1ptiK9qwGfCeQ7/yBc+KM
         4qG7JmqgJ9vWY6IO43R3RAlNaB+iBMTKZ6Sivcr1bHSkDeSiun9dVyRLdAjXlHprI/bh
         JWZL/VVm9yc2sb4Io2FHIMOUIw3jYzjT83jMmn7IKChond5xT57LfAhp2LeE/IfIQ5o6
         6kSmaXE1+LVEbtyBuC7PyBlcRtQUBZGKikxisLcCNfRtE9eFiyQSX+4JYszV7GUuy0ER
         rFuVyQrEZRSCVNp0mHiJuHKOx2aUAlXV7iJKfDg7WiQgHo3bsi8Ne8SdgVDNijagAyyr
         dzJw==
X-Gm-Message-State: ABy/qLYMXUcTYynFA32uai/U8gM2sZnSmeYuY5w9rN8YiFOVepjx+Gfz
	YsTj/+9yS/q9fvL2PtR6YOigl9eHwLzxoA==
X-Google-Smtp-Source: APBJJlHnnp0QLoWdnGkl7lO7Yat6aivZU93oJEReHNTKpisTnZNacsTU2ibi6wyfUELqHUV4iE9mpMtjozsuLA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b2c4:0:b0:570:7d9b:9b16 with SMTP id
 q187-20020a81b2c4000000b005707d9b9b16mr159559ywh.2.1689696981935; Tue, 18 Jul
 2023 09:16:21 -0700 (PDT)
Date: Tue, 18 Jul 2023 16:16:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718161620.1391951-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: remove tcp_send_partial()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This function does not exist.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 226bce6d1e8c30185260baadec449b67323db91c..0a3b0ba6ae50799fdb114768a06937dc429f0417 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -606,7 +606,6 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 		 unsigned int mss_now, gfp_t gfp);
 
 void tcp_send_probe0(struct sock *);
-void tcp_send_partial(struct sock *);
 int tcp_write_wakeup(struct sock *, int mib);
 void tcp_send_fin(struct sock *sk);
 void tcp_send_active_reset(struct sock *sk, gfp_t priority);
-- 
2.41.0.255.g8b1d071c50-goog


