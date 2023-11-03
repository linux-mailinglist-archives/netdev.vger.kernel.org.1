Return-Path: <netdev+bounces-45863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADD7DFF3B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 07:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0D1C209B3
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A42D629;
	Fri,  3 Nov 2023 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSB1zsie"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F17E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 06:43:01 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B451AD
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 23:42:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so2914783a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698993775; x=1699598575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBU5oj0huelFR/2545WemOLhvSZlToyjTZBhGrpdm7g=;
        b=HSB1zsieAK8E/r7G1jqrAfN40ZT7ScdE1VZ/KI/4zPvMCuBjHT8g2Lr9iI5c3qgnqg
         Rw1ECGaf3BlfsuxaiRSiMI/ef6O9U2MNdFTd9CnLtaB9Va7xIQfACoiMmR9Bi7W5zXcf
         dxJYvVTvLG/yIqzOmiTRSyyszkN4J+5zT767M+w0xEdLlLxVf3apmccNF/z6lbC24XWb
         6tTs8oPFQKd4zAVFC6tYu4IHJE60ahksXoboC4HoNMy/66Vi2IuDP+8h/fE1OI2jxUQw
         8yBpbSbuzFnWZD1APhECQpVQJ9aiT8V8Od9BjGmxTl8OY4agKrqnnIiLNATss4jQi8pA
         na2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698993775; x=1699598575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBU5oj0huelFR/2545WemOLhvSZlToyjTZBhGrpdm7g=;
        b=uV9p6rHS/Q+lBf1WByIJLh6pR6etQ78NRGOsi65Z+xPDHkohN7oM7LLwdURGaLNJjD
         l0jIE637FRDrnW476eSWvtUqrY0YOhoUWIHPOELDJdn8sta8jbgAXfYG/PhQL1qk0+CC
         kLYYUqi4OBGcb62ACt+YrcqvhR5YWF21ajR44SoEvBbZky7UB+kNyrIHscekdeQs2Zdl
         0SyZ9TX1SS6Dj2uv66UdGMnIiUSTJ3uj6X9U07h0ljq1irHvn6PKInGt0Pql3Wp1asNt
         JZJFDF7L3K5mmEjVv78rB/HzCmyzLxSiFmQ6hewYlseMfFQhZSHbXJleMJILkH7ue/Dm
         g+qg==
X-Gm-Message-State: AOJu0YwyrX2zwTqvkv9fPhhG0prbNFklZLJT8QSuOdec+um/kp8/uBFu
	ThRI+UYVLA8cLmqjPWkzNx9s8g==
X-Google-Smtp-Source: AGHT+IH5nBIOHxrvCJDw3PRYNLp2qiHkbtIgQTHI09kZ6XQIhXnRVrl7NBfIPHU2s/bC0Cwww7SD0A==
X-Received: by 2002:a17:906:bc93:b0:9bd:bbc1:1c5f with SMTP id lv19-20020a170906bc9300b009bdbbc11c5fmr4766399ejb.35.1698993775211;
        Thu, 02 Nov 2023 23:42:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bw4-20020a170906c1c400b00992e94bcfabsm531429ejb.167.2023.11.02.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:42:54 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:42:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The problem is in nft_byteorder_eval() where we are iterating through a
loop and writing to dst[0], dst[1], dst[2] and so on...  On each
iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
element only has space for 4 bytes.  That means that every iteration
overwrites part of the previous element.

I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
issue.  I think that the reason we have not detected this bug in testing
is that most of time we only write one element.

Fixes: ce1e7989d989 ("netfilter: nft_byteorder: provide 64bit le/be conversion")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/net/netfilter/nf_tables.h | 4 ++--
 net/netfilter/nft_byteorder.c     | 5 +++--
 net/netfilter/nft_meta.c          | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3bbd13ab1ecf..b157c5cafd14 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -178,9 +178,9 @@ static inline __be32 nft_reg_load_be32(const u32 *sreg)
 	return *(__force __be32 *)sreg;
 }
 
-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-	put_unaligned(val, (u64 *)dreg);
+	put_unaligned(val, dreg);
 }
 
 static inline u64 nft_reg_load64(const u32 *sreg)
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index e596d1a842f7..f6e791a68101 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -38,13 +38,14 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst[i],
+				nft_reg_store64(&dst64[i],
 						be64_to_cpu((__force __be64)src64));
 			}
 			break;
@@ -52,7 +53,7 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = (__force __u64)
 					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst[i], src64);
+				nft_reg_store64(&dst64[i], src64);
 			}
 			break;
 		}
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index f7da7c43333b..ba0d3683a45d 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -63,7 +63,7 @@ nft_meta_get_eval_time(enum nft_meta_keys key,
 {
 	switch (key) {
 	case NFT_META_TIME_NS:
-		nft_reg_store64(dest, ktime_get_real_ns());
+		nft_reg_store64((u64 *)dest, ktime_get_real_ns());
 		break;
 	case NFT_META_TIME_DAY:
 		nft_reg_store8(dest, nft_meta_weekday());
-- 
2.42.0


