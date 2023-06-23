Return-Path: <netdev+bounces-13403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631173B78C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943F4281B41
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E29191;
	Fri, 23 Jun 2023 12:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E02106
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:40:07 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C91FE9
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:40:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-987341238aeso62730966b.3
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687524004; x=1690116004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ygtiRfvSF3SfLr6xp1AMiMqehIoIPTyUafU5lHGyA4=;
        b=djST0kbCqt5apyv1YM26lJqNdMcAYJizldt1+WFgm21Qtwy7V3R4NIwqw8T1+n1aWN
         Xr5yS1Clq5SxI1U0Xve13zAjuLpWI8O9mhBmvK2EC3uNw0csZtd59WAdsmntuTqs6LJT
         SaV+icNqVmEWqHarBWFjdpzG9sT/m2SN3svVahQ/bQu+j17tPXjGgmDu0MJisZEVLb9h
         SDLtFPL7kn6BqSrEYM+B0fu2vASYvzQphJYisgMw9yb3SgBwpps246OCsHUK4FZdUO4I
         XCjq8gpLOCPIyybUaSC0Nv3a5LrE/uwjrYSnoLH6VxfidyIJgo4KB3PRH5MqayBxv9ul
         2PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524004; x=1690116004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ygtiRfvSF3SfLr6xp1AMiMqehIoIPTyUafU5lHGyA4=;
        b=NXFZsfxsGrsdGTBkLtLHn9GetlYzwCWjT0v/O8Nva86bSRZPDbzy6bnrsJ6PkaSYwM
         Tj0wHSIkJ9RHoAgM6+2I72Jac9VSDVeU8aTUuFjyiGa6j4Zd8qd8Pb/ZeyoWV5S5vUUY
         zyPYAAbeTyImTwzbXC9dXqc9pSAIKmA3MTWS91XknRjDyKN1CwVDDekLiUNANL+2P3MD
         Mslp1Y5JYr4kecqXYKmtgfNALWa85FAO0MrX20f6LD9AGptpJNa71/ggTcr5ZHWe5IG/
         mYzVPn/nRu8XOygQrbzLLgPB483vAWNK5+x25DEdFaPKSR2QyVMwNgmF3hfE2TNkFj9I
         ZY0w==
X-Gm-Message-State: AC+VfDxH/5+lMiSHzmxFZFIRqg285g5d1cmEMNkqWdQHJPxHv+Dtk8G9
	rRt2sOojp5TwWmjBzMbmoiKzrWf264Y=
X-Google-Smtp-Source: ACHHUZ6b0zO058S+lKxZbTq2YwbwQ5RngSN/GCIaChq7YZcZ/9w+/a65ttvf43eeYe4Wg6aG7JT82Q==
X-Received: by 2002:a17:907:928a:b0:988:c3f9:3ad6 with SMTP id bw10-20020a170907928a00b00988c3f93ad6mr11952826ejc.42.1687524003859;
        Fri, 23 Jun 2023 05:40:03 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::2:7d95])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709061b0100b00982a60f2c0asm5965137ejg.74.2023.06.23.05.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:40:03 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v2] net/tcp: optimise locking for blocking splice
Date: Fri, 23 Jun 2023 13:38:55 +0100
Message-Id: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Even when tcp_splice_read() reads all it was asked for, for blocking
sockets it'll release and immediately regrab the socket lock, loop
around and break on the while check.

Check tss.len right after we adjust it, and return if we're done.
That saves us one release_sock(); lock_sock(); pair per successful
blocking splice read.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: go with Paolo's suggestion
    aggressively shrink the patch

 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71b42eef9dbf..d56edc2c885f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -839,7 +839,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		tss.len -= ret;
 		spliced += ret;
 
-		if (!timeo)
+		if (!tss.len || !timeo)
 			break;
 		release_sock(sk);
 		lock_sock(sk);
-- 
2.40.0


