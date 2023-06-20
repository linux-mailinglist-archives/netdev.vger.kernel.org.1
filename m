Return-Path: <netdev+bounces-12417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23397376AF
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 23:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E191C20DA0
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D53182C7;
	Tue, 20 Jun 2023 21:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A3182C1
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 21:34:33 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE5170D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 14:34:32 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57338656a8aso23703567b3.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687296871; x=1689888871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=gZBb68RBa+Lw4Vx1sRWxdNSG0Cl4qMFSjL9ecW5msVKLTUuwnR2Jh4Quu09tP5JMgO
         2uxXSFlCs3uQEZ7CTNQYOGfspt9nsKTqF0G7aLuK7S0xiO+rKCIM3LdKQlqBHcm0qkKO
         k8vLBBdKJO4GUetTy+gW9HkG97sP3YquLGk/Z4//GP4p/Mgj6aaADGB4k6olB29WwgkI
         +LnGkA3eMH8LYepWjbimHNNnz4iEJE9f58B6ki8dWlb/MrfzJ9dwvL+ltDytIMhiPn0E
         AnZ4skJbqRaGEvpjgA4CAoXEWtvpsNg9hM2QSC5Y+Hwjs0LQKYJUHhMyPGDz+iLyQeJ/
         PNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296871; x=1689888871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=Q4q2PF5Kgzaelc+Q60UAtF3IsvD9Wqruzfd63nDrVlGJwJ+Ps/+E/ip3+dhgcYqagX
         1ahFmzMCT8VIYLHUR/9etE2TwP6Qr69YYra6C+tJZ/13s8QqcWAHc1l56l4Jgn4tXK1n
         t3toLQW/Y8PJkHTXM9bDyuvkL1he0Aq8Q13PVCqkR506AuN1IRiQhpN/vUPKCok7XxT0
         hSud/OoGb56ZxLPBCP/k3d5y4Az88xU+gzu+V+PRjqjlfwIHD2/Q0BFxSB2cjTRMlgl6
         mc0KLd2tEy0B949Yr2Je8V+QerplPYwfX9lAPdpOAaS2k1SwZY3mk8lQBcrt6VJYQSaK
         +TTg==
X-Gm-Message-State: AC+VfDy3pEXq2UWm1FpuAPZ0ujDyNwu1+QmP1ofu0s0L2x9C9y1g8MWM
	SV12vzggwC+nbfUSVyyUD55OscxDW0uJTQ==
X-Google-Smtp-Source: ACHHUZ6sFSBhg4FjkHdhobwKDdhRZPZoNPXE2ct0Lu6K7w0ASs3vBEfBU38DcUInG7gYsadbd1kMOw==
X-Received: by 2002:a0d:cad1:0:b0:56d:325c:442 with SMTP id m200-20020a0dcad1000000b0056d325c0442mr10570785ywd.31.1687296871408;
        Tue, 20 Jun 2023 14:34:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eae5:6acd:8444:936b])
        by smtp.gmail.com with ESMTPSA id s131-20020a815e89000000b0057068c6924esm389521ywb.75.2023.06.20.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:34:31 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters for egress.
Date: Tue, 20 Jun 2023 14:32:26 -0700
Message-Id: <20230620213227.180421-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620213227.180421-1-kuifeng@meta.com>
References: <20230620213227.180421-1-kuifeng@meta.com>
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

Always call BPF filters if CGROUP BPF is enabled for EGRESS without
checking skb->sk against sk.

The filters were called only if skb is owned by the sock that the
skb is sent out through.  In another words, skb->sk should point to
the sock that it is sending through its egress.  However, the filters would
miss SYNACK skbs that they are owned by a request_sock but sent through
the listening sock, that is the socket listening incoming connections.
This is an unnecessary restrict.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..e656da531f9f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
+	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
 		if (sk_fullsock(__sk) &&				       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
-- 
2.34.1


