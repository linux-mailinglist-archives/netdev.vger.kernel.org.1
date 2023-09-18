Return-Path: <netdev+bounces-34665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F97A524E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E73A1C20B5B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B326E0A;
	Mon, 18 Sep 2023 18:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213520B02
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:46:44 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA8FC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:46:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c4194f7635so30055515ad.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695062802; x=1695667602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E89Q4xIcaPhNYK1IxEacI2MQhYUEya9nr7PdumjkbZo=;
        b=nCKuhl3K2wI1dluKfmxhloOlXfhbv2sx/naGW80RNapE+C1N0lpJR+b0aMBKwgVt4S
         JzYifkpnuVkyAhyFcf/aVscCSXJ+rxhdYFVykzAkYmE6qbIj2xVQaFp85g250g4+aSaY
         hveAqaCDw2vodrNlvOrtMuWA3HtGckhIY8N+U4y7pobsoFJHCeBnhmz1KP1wlNX+aOFb
         dbW1jyja3oaRIRbUfW9DesFQwgDv35GZK5dlsMqJM0Xl+4ZDGLpi0Achp/qHi0nF74yO
         BG4JWIfzXEg7HJJse6aFQpGwe6J13AasN5xGdHfeMPd3N8tWtUUa/qo5Lzm+x3h+OOUM
         V6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062802; x=1695667602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E89Q4xIcaPhNYK1IxEacI2MQhYUEya9nr7PdumjkbZo=;
        b=S8GKRCHdETjK63JxW/Piy+rcN4ZWQF35tRSOgU2mQHtsF2n0kRqDs6U1E1BR6me/Vq
         94cC9cV7BztRjpv568FdC0RwTiTRrTSYFWQYcEYZLJv7pY2SMqNifjYBrGjCo4Orxmbe
         c7ErzUpG3v1JkYAH3XmdUaDbo1/oNjpd9Fiq/zCumdlvEpg21vNzcXvm7nnhQpVG1rDO
         AYXpSRAlMb8ty2IClHluTLHdV7haDjx3d3MdwW4HU/f25aPuOC0VvLf0qNZQ1t7ebpmE
         tlEMJ98F6EPlSrvmWoMOXdIJfwVLll8s1VkZhg3WTOlPzIS8VtiD9Yjq2RCY1qNhRv47
         AFYw==
X-Gm-Message-State: AOJu0Yz93agbxHvRkP1qRDl7nTO98ytFvvbnEG3xMurD4EkJBM6b+HjV
	Onjb8vJkC1NqnAkquSNMiQgDhmdEInv0f7utuzT4NQ==
X-Google-Smtp-Source: AGHT+IGlxyKNgMgw4gPqdsM6sCdt8a29vV2ra6U+MTiFcgWggAt6F1F4Xo/APqT9ORyPK9fYbq9slw==
X-Received: by 2002:a17:902:cec7:b0:1c3:76c4:7242 with SMTP id d7-20020a170902cec700b001c376c47242mr536196plg.22.1695062802658;
        Mon, 18 Sep 2023 11:46:42 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001bbfa86ca3bsm4488052plh.78.2023.09.18.11.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:46:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/2] ila: fix potential snprintf buffer overflow
Date: Mon, 18 Sep 2023 11:46:31 -0700
Message-Id: <20230918184631.16228-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918184631.16228-1-stephen@networkplumber.org>
References: <20230918184631.16228-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The code to print 64 bit address has a theoretical overflow
of snprintf buffer found by CodeQL scan.
Address by checking result.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipila.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipila.c b/ip/ipila.c
index 4f6d578f24ae..23b19a108862 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -60,6 +60,8 @@ static void print_addr64(__u64 addr, char *buff, size_t len)
 			sep = "";
 
 		ret = snprintf(&buff[written], len - written, "%x%s", v, sep);
+		if (ret < 0 || ret >= len - written)
+			break;
 		written += ret;
 	}
 }
-- 
2.39.2


