Return-Path: <netdev+bounces-44736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E47D97B2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9053C1C20AAC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CBC1A5A3;
	Fri, 27 Oct 2023 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwHhpskL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41019BB8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:19:08 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51CCC0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:19:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32df66c691dso1288946f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698409145; x=1699013945; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EzbclxQ3u34ehr5EAcmOA1Z6rmxefKbVbR6r26szvQ=;
        b=XwHhpskL8IMdjxs09mtAzuwbK1DWk5NkdAaXMBzQfz44wgf9HBjsJiY78Xt7NfKjiv
         RKmGfJXZQU0mE75L3DjUvdN3djaXrhQh2YhqS74Zw9YKIvSbbyxBnhnLrXxd8S8kz8Hs
         Z86cF3ReCvLJxpcemdNVhuNuvvTtg1XRl0opkkwzpgKcHv2RzSoBhjUTXpX2+Yum829F
         3iat7ZN5EjG7Jgrj0skU83qs/cxnAIaFVxuifllOv7C4xdSGp7zo+fuTQy4Xtt0IH3hj
         CJnlHmui4fcMmqEFUptAkOP0e615x+oTY8o0EAcFF9r6orNu7S/6DRV6bVjxLrs1oxbk
         lrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409145; x=1699013945;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EzbclxQ3u34ehr5EAcmOA1Z6rmxefKbVbR6r26szvQ=;
        b=bWQ44tfHQk4akunrIYmSQzCQgWGoQ4a/Ffs8O4sGbf6/KMyOOCM3Ozl7refkMnl+1e
         mGbkB4vlDxQPMQ8EqnD/3/NBMahh/M/OzsNfT0aewAMyGLpuiNfkvKORcLi0ulMWOxUR
         lY5AZ1JWbJiKs9IX1O36fQt187zDyZ2vAsiEtksAMpXtXOdWqRJXh1toybAVAaYm95+j
         Gm8znYLdHaxxGnLFuCZ2WV/iR69m/zdhIXSm/Q8tqMPmHzWAQ+CESxiLZdhY5Vl5kSs9
         YS0XNRvjxvjkb7umSU15RKR68rMDbH6E+y7T37kEBc2C1Vxt8rcnLnI+fetNLXQ5UTJ1
         YbfA==
X-Gm-Message-State: AOJu0YzVGU1FTJG45ZTQWMjWhyb8ctFs0L7l9LvZ9zzZ3ABVhM4xjRmG
	p/xkjeEf7czO4QaKNNdi7Tg5hA==
X-Google-Smtp-Source: AGHT+IGaTuV20uSRVXSnwziXt58hhE17/CHwj+ungjmuHjw+I0pFjFq7hF25shZR6uJCilkIM/3gLA==
X-Received: by 2002:a5d:5002:0:b0:32d:88dc:b219 with SMTP id e2-20020a5d5002000000b0032d88dcb219mr2084219wrt.45.1698409144589;
        Fri, 27 Oct 2023 05:19:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4950000000b0032d81837433sm1658047wrs.30.2023.10.27.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:19:04 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:19:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	YueHaibing <yuehaibing@huawei.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] hsr: Prevent use after free in prp_create_tagged_frame()
Message-ID: <57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The prp_fill_rct() function can fail.  In that situation, it frees the
skb and returns NULL.  Meanwhile on the success path, it returns the
original skb.  So it's straight forward to fix bug by using the returned
value.

Fixes: 451d8123f897 ("net: prp: add packet handling support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/hsr/hsr_forward.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b71dab630a87..80cdc6f6b34c 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -342,9 +342,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 	skb = skb_copy_expand(frame->skb_std, 0,
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
-	prp_fill_rct(skb, frame, port);
-
-	return skb;
+	return prp_fill_rct(skb, frame, port);
 }
 
 static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
-- 
2.42.0


