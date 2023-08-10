Return-Path: <netdev+bounces-26302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A827776C9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D861C2143A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEB1F947;
	Thu, 10 Aug 2023 11:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006B1DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:22:00 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE39268A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:21:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so7187125ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691666519; x=1692271319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+TRJFnQ+tXdcoeSoBSOj6w+gPYO080FZl/B9kOapV0=;
        b=St38pCFaqy1tM3pbMlW3XXtICIM4zyqBKebwOspRCUUiFoQZx2geuaziFLrzx1+d3w
         0fIqKiYHarpWZAuKvotiFzFrLbPjvwsLBn180GEhjLjlWq5RAcveKTwTJGJ3Su/O59/W
         F+JIndL3Wrjig9zb8AkJFbLeIkQUi7zErFlSkpdab/V6LAd3Imno2wVI/6FbYKJ7PqN7
         2IRSHVmAGR1cD0/rgZdCp+Yh7TXMADpLdncVPMiDZNN27QYsMkpIwAy30rD4rxcvw4+D
         otrSOR5TNVqoatH7mOTvK1NDdvQg9t6efQ95QE0ytDJKXGpVBWGRl8jEcgoYcyC8q7A0
         nDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666519; x=1692271319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+TRJFnQ+tXdcoeSoBSOj6w+gPYO080FZl/B9kOapV0=;
        b=BpuDy6nmiv2wAcdg0iKJXdr4L2mpiGiF9wunCh6RLX1ME4oC9tVoc52nW/E1T+NYbJ
         aWO2Ko5+X2Rc1PuJr5OXOlZ/eYyxvqnGRv9YGSft0FTOd/4Hp1U183UHtMwvpCntOJN8
         z8m/u3NUPbWk4y2PJy4g0uNB1GvF6nSocEX5CuPR+DfOwiYkY8p1IFAtX0sDTv7QjRu+
         5dA09zzgsTsn89gckZbM/XH/DNvaUJ6WO4c3VK8m/iwCxpdEvlR+GCZs4RvTp8B2Mbw+
         j2297WSSuDa/+Mdg+kqmwyQX+W1iccvc1L2j6s3VfFaByWNmwAe1BnlTjv29kZjz+5c/
         g5og==
X-Gm-Message-State: AOJu0YzYlyr4b0dGJ4UveDfB2yeq1i0C09Q46K4uLm89xiRGsaArRVN8
	s2u7KK3KrgeTzAAAGhs6G2sQs4KVUzquyQ==
X-Google-Smtp-Source: AGHT+IEHFj/Y6j4kP/8QaXVAfccHLBEbIwfpqdtUfTE7PIZwcjApkMr18gsdzvrZNQl1DsVtEW348Q==
X-Received: by 2002:a17:902:e5c5:b0:1b8:66f6:87a3 with SMTP id u5-20020a170902e5c500b001b866f687a3mr2477166plf.52.1691666519194;
        Thu, 10 Aug 2023 04:21:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89466a5f4sm1480701plx.105.2023.08.10.04.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:21:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: apetlund@simula.no,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net] net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
Date: Thu, 10 Aug 2023 19:21:48 +0800
Message-Id: <20230810112148.2032-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jason Xing <kernelxing@tencent.com>

In the real workload, I encountered an issue which could cause the RTO
timer to retransmit the skb per 1ms with linear option enabled. The amount
of lost-retransmitted skbs can go up to 1000+ instantly.

The root cause is that if the icsk_rto happens to be zero in the 6th round
(which is the TCP_THIN_LINEAR_RETRIES value), then it will alway be zero
due to the changed calculation method in tcp_retransmit_timer() as follows:

icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);

Above line could be converted to
icsk->icsk_rto = min(0 << 1, TCP_RTO_MAX) = 0

Therefore, the timer expires so quickly without any doubt.

I read through the RFC 6298 and found that the RTO value can be rounded
up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
regarded as the lower bound in this patch as suggested by Eric.

Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_timer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..b2b25861355c 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -599,7 +599,9 @@ void tcp_retransmit_timer(struct sock *sk)
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+					    tcp_rto_min(sk),
+					    TCP_RTO_MAX);
 	} else if (sk->sk_state != TCP_SYN_SENT ||
 		   icsk->icsk_backoff >
 		   READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
-- 
2.37.3


