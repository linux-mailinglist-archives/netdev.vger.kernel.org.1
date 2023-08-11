Return-Path: <netdev+bounces-26610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3E778588
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF01C2102E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF46A3D;
	Fri, 11 Aug 2023 02:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4A36F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:38:02 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D128ED
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:38:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6873a30d02eso1162572b3a.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721481; x=1692326281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOOHC4imo/n0I4HMS5eU80prCZwAXPq4qp8aKaxGqOs=;
        b=ErIg1a2LUPZP9EwmU/pVf5X0ekTinvkJQ5jLuOnngsxCJX/eCjsuAtPMHPQbwO8Og8
         EF2XpzGurvL1XHKNN7loRN5iuVPGgDCUBQmf9cn/V4uR6mM5q+ozLoGhxI6arG3RqeI5
         9x2My20bjZDtjzWF/vYH912FCoBxXsbs++eReZ/pxmxv9jOG6OsuZrr9GhbABAmhRLeo
         MOuTMGWEnB+7TSqQxUsTF+gSdbok8KQQOs787LIpHWero4QsKtdWCfJcLwPJIh9IkH+m
         uRS6mfALNPE9yw7pOsdS5iYVsR8zIK1U0/WmS5m4meq415X/amlddovpop8YGOnsdj6i
         omJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721481; x=1692326281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOOHC4imo/n0I4HMS5eU80prCZwAXPq4qp8aKaxGqOs=;
        b=Xu33PJo2RvrCuWscEjp1OOVxXpF606X+m7471tbofmtEnq30X64WX7rWXTiplWb4YR
         PY1ub2demf8fC89fY5OYcxpI03v9lD8kpGfKNvbM7Q/HUaHYpGvO9losg+MUlSI79SLN
         cktJ+9HuePc8pv3a/rFnlxksH7ua7QCB3JU6Uc+85H5CmgXwuSXY+0kBkd8ghBE1o4yS
         sfKZcvE+fQfQQul/8GQ4imAgri4rrK+aURya68hdWoGCDP45r0zdhpKvWphqkORDM3R9
         giy4Y0lvl05dDYz8/ceJJmQkTW23aRGeMLPXy7xkwXbqvk5aR9fn3I/a4w/Mp0tObBXK
         G2pw==
X-Gm-Message-State: AOJu0YwrRx7wjELEoBCfM3TwZ8SbWt6lIwcVNVvYvySyGQDlH9pYBnzq
	VaZn5BpeZwuFawwulLlaBqw=
X-Google-Smtp-Source: AGHT+IEngl9ANf6n4VXLc0KV+oGS880vaYCxtCnut1ssiL9152spl6ZqnQoDT561Gfcqv57XCmrevg==
X-Received: by 2002:a05:6a00:14d2:b0:686:6fa8:2b0d with SMTP id w18-20020a056a0014d200b006866fa82b0dmr646857pfu.4.1691721480719;
        Thu, 10 Aug 2023 19:38:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([103.7.29.6])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b00682ad3613eesm2199062pff.51.2023.08.10.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:38:00 -0700 (PDT)
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
Subject: [PATCH v2 net] net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
Date: Fri, 11 Aug 2023 10:37:47 +0800
Message-Id: <20230811023747.12065-1-kerneljasonxing@gmail.com>
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
(which is the TCP_THIN_LINEAR_RETRIES value), then it will always be zero
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
v2:
1) nit: alway->always and the indentation style suggested by Simon.
---
 net/ipv4/tcp_timer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..69795b273419 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -599,7 +599,9 @@ void tcp_retransmit_timer(struct sock *sk)
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+				       tcp_rto_min(sk),
+				       TCP_RTO_MAX);
 	} else if (sk->sk_state != TCP_SYN_SENT ||
 		   icsk->icsk_backoff >
 		   READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
-- 
2.37.3


