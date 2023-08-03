Return-Path: <netdev+bounces-24143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAD76EF71
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41CB282259
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80425158;
	Thu,  3 Aug 2023 16:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3372417E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:27:56 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8F3A97
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:27:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so11683325e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080071; x=1691684871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jMt6L2FmSlltwvcyjEZqwtyL1aI3zkjJCogSbPktKs=;
        b=x0w/rjxJnVBmVbgGNo/kxrqp7ZOR0vgZhvYU2UJJOzYBlcQGR58n2VVhLQb1K0yB49
         pm/cch1ViXDza5o26swt637wlroTwytiU4vZsvrtD4N4QrskCpCJcKJYzNNh/EMCdcur
         QbmzHTXGBWJQbik0AOw8wlQG6i33+Yl6Ks8r3xIYvkztFZ9j8RwzQWbJhmMpzxyXXq5N
         8WjQ2UazZUdY6yeCTHtT2qTqkJtGRG1NWHHSK1DM4VCTJCsDH/NW1D7GJE4iprznbHje
         KxnDw56bOj+CgdrUF/EyxzZ38++JMGqfND2F9pVsww5zRFWwpZItSbmA8+5CZDGtacPv
         yebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080071; x=1691684871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jMt6L2FmSlltwvcyjEZqwtyL1aI3zkjJCogSbPktKs=;
        b=FMUucXfpnRvKSX83Fo+LYqasW92YnUbYRll9wAGlaMfWOF2EZedt3xRcmmsWAKXZf1
         xYGz77pMcPAEiqErwhz7Zd4x5gi729GzStWx3O+5C9izV8zYoDf+4mhURsemFKbO0cwj
         gmOraI6Yxp9DaCnIGs7nfxJJoEIAbr9+alasaW+8mwlzkK+KQ8nx+06VqI+myeRlK3C6
         cRb86wNxoqSuLZjVD7wbSUi2e4ydxLw7B4yB8NAwl9nEOso25afKd8wFeut4BSFT/xVw
         YGeIXi5lrx4Pd0c4p5obs4ZXxx1rdvGPuqQIr5EhWdeCF+B6fCkr+kXHA7DjOo7KNapq
         VhcQ==
X-Gm-Message-State: ABy/qLb6vBPgxPwkzi5JZhI4RjuDopGDV9qEUHPMOXXkC+JjfPajCUo6
	xh/nSmWcLIdvGJr/cpjw9zIV/w==
X-Google-Smtp-Source: APBJJlHJZ4UCOk+6iZM6+xLDrngDmJxvytq/L41ApOb6PacLvDsqnNnt8VDvbd3bh55Hg7s1g7YWFw==
X-Received: by 2002:adf:f043:0:b0:316:f5b1:98c with SMTP id t3-20020adff043000000b00316f5b1098cmr8589836wro.24.1691080071150;
        Thu, 03 Aug 2023 09:27:51 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:50 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 03 Aug 2023 18:27:29 +0200
Subject: [PATCH net 3/4] mptcp: avoid bogus reset on fallback close
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-3-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=12biSrwGtkvk41jCEN65DKfb20xXbhM8fYcweZf3BtY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WC2uO13GQR6Uk7tHPxbxR21T6sS+xXFI1Ro
 sRXVF4BsYuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c4ReEADACIInPdd6u/8/kcSsZZjsF9iI9yoY4f3fm2Tqi0Mh8my2rGacspC4c9R82DuvfjYh0ut
 /eEoqGDMDcaF8Eqcza+IndPBviG6zze6q4Krt8FNtbHI9hcuXBbmbxb4v9Y215My8XR+EptGxb8
 8/mSixbPVGYKiDLgyXkeztjhdU7vGshwMD5BxundrqsbIkmn2sRqlxm2uKILaT2bmfQZb2FJgLB
 s/ZK7hLFgGt9Wmm6Pqnb3D/UAMjWERlcEoifd84BJGjYNCNYvth9yHoUbMhknrrlLSPPUspZl+y
 /r8jfYLIALWVrxSm0zStmBRHASnnonref+rmeDjPwSrQK0EcYVbRaXD+dhkLLoi+EC+YwzhjuBo
 l01qmS90KBB+qdVlSsUHai6Qs6O0/puZulr7hXAlj531qM3iteSONNVpiGZWlv5PwQOjj9F2/+8
 EUJleiTZ4MOAjYPBszY+eu7u9Duidnx9NMLQmnw1b5dYyx0g/zeQeD0np405cv7OeTuNzNNTVbU
 ClCZ4UNjgmyhj+GkRZqUDf5o8c2PkRrVs2bVZm1unsWt1yzRTJkBIc2txHfetivunfzKm7m08Rv
 kqZ50sPA7PjH8o6NUxQ18bowaHZVnLHUmlQNmDa4VGdCN9HAawzhBvgfomCVbH0NwWcYRdC1cAi
 9y4SsYEABb1WMUA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

Since the blamed commit, the MPTCP protocol unconditionally sends
TCP resets on all the subflows on disconnect().

That fits full-blown MPTCP sockets - to implement the fastclose
mechanism - but causes unexpected corruption of the data stream,
caught as sporadic self-tests failures.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/419
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3317d1cca156..ac7c11a5cbe5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2335,7 +2335,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if (flags & MPTCP_CF_FASTCLOSE) {
+	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
 		/* be sure to force the tcp_disconnect() path,
 		 * to generate the egress reset
 		 */

-- 
2.40.1


