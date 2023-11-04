Return-Path: <netdev+bounces-46030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5A7E0F71
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D75B215E4
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547A1A58F;
	Sat,  4 Nov 2023 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yy3Uh94e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC018B02
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:43:56 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420501BF
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 05:43:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507973f3b65so3867554e87.3
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101833; x=1699706633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbrVElpE/LRcXL9QrTPOXjtUB0U3i3Et1aitWER/TV4=;
        b=yy3Uh94eo9ISIt7N3igeFW2Yn93KkptUPRKaRqm3tc95Hckgfob3SSvrYpMf9QyCGR
         /ae+NOo9o1uiKrgwVONTOQBO72lMiC6bN7n66oLerfIJ2I/pwJf4PL+f1sF4ft/CzB0q
         /vGTbxUE/lgnK+bCgP8P6nnnbRAfQ5vUMmbvxEbiwk7Ufef3G2Y2cwbrKgDi7uFTXeWq
         Tl+YJTVcdLA0SJ1cmeyRz6t7l71Mut7g0W2F1R1BkYG3Mh5t6LJAOHYgL7vq+UbZzA6B
         RIpTv+c4wD/6J1i/g0A9G0YrT01GB6ZUz5UeMOex12P0p0QTCWR2HYVXuPqifCHvn7NV
         Cm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101833; x=1699706633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbrVElpE/LRcXL9QrTPOXjtUB0U3i3Et1aitWER/TV4=;
        b=c0XB7fH53eGjhSDSfTAXueJupMOTV9bkUD59GINKOBA+WgMZJo1nw3aOMPum5dUnM1
         t5rDxJvIf9AQieZmyNaMEE/V6E9AdKcUIqeZ7fNTRt+dwSsUUtvHIlOn7+hgdAgpxWNu
         mG89LV3micc88h2rdqKPzgZlHbs1hwi2TDUp1KbjQFg8u6Mz+ZkpmKw4pZI703Ae0/zG
         qVF4TjZcct9g6ywtSYl/jkpqOV6K/nM6CyWzkBviV9Wzop4Kl2pc0cImlVhYsXY+Z0N8
         pNL2WbdxsxMOmrsWMhJ9QgpHuqpW9mX3CtemnsB2G6PiOiICjkLPxGVon8OQQ/oqessZ
         teug==
X-Gm-Message-State: AOJu0Yw3tS0dGZRhXM/5XBTk8s/hfW9vPQ/fly9WdsH9u9+nECwXivrt
	qb6E7LBRF9b1r4+Sf4zpkQc+6A==
X-Google-Smtp-Source: AGHT+IEOvtUSGS8gPMNB3spqJXMI2GzAA6fdOtLX2o73ozW/2re2ZnkjNq0X0bY0Zzh1Cl/kg6zB/Q==
X-Received: by 2002:a05:6512:b93:b0:4fe:347d:7c4b with SMTP id b19-20020a0565120b9300b004fe347d7c4bmr23951283lfv.7.1699101833426;
        Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:52 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 04 Nov 2023 13:43:50 +0100
Subject: [PATCH net 3/4] net: ethernet: cortina: Protect against oversized
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The max size of a transfer no matter the MTU is 64KB-1 so immediately
bail out if the skb exceeds that.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index fd08f098850b..23723c9c0f93 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1156,6 +1156,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		mtu = MTU_SIZE_BIT_MASK;
 	}
 
+	if (skb->len > 65535) {
+		/* The field for length is only 16 bits */
+		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
+		return -EINVAL;
+	}
+
 	word1 = skb->len;
 	word3 = SOF_BIT;
 

-- 
2.34.1


