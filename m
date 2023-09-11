Return-Path: <netdev+bounces-32857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2679A9E1
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D971C2083F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD201173F;
	Mon, 11 Sep 2023 15:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D892FBE6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:42:16 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C270FB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 08:42:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b6a51f360so28370257b3.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694446935; x=1695051735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vxv9qCiBDdaz18BBwgf7/xe/GHeAWJxF6E4VjWi49o=;
        b=hLCxEne7np34rZa0jVtSxs2LddCr9L+cDynXS0fZyAgzS+JCqWoCsehl5b8c+3FANk
         /J2k1AGAFdvxlGRprL7DejgVdAEWwQDWneWGvC93qNEqv09g7EkpCpp5vgjfiw0ektap
         NzzX2FRiCjqu8DI83FZzOHptNXKykSLnR+RAFJF/ceczMArYMaBKgyR7Kgb38sX/vf2C
         Tpsrs/mxGRSWFe3nCCjE6+T8AkkUvN4vm+U8otJ0riu8D6oCnje6DduYD2acIpiuE0oK
         ZjI/fqLqzqB6hiv/PTkPFHG3/Yg5xcP1zQwal8E6FyFa5te/pP3i7BAj2goD8Aiv1FPx
         fFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694446935; x=1695051735;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vxv9qCiBDdaz18BBwgf7/xe/GHeAWJxF6E4VjWi49o=;
        b=Dh7zIVAOCy7kdUG+SdDiOTiYcMuuTazatUHurXHbntq3noleRXBPKaAMxTbWIKFDwY
         1gbbhb2MBlOauKV3ygfgeOuBaKjrNAc8m7vUd0h0Eyg76Sdvg2ANlvwOyNzsKF9b0WQL
         dRGjmXReX08wDXwrU0HmRRS0QGqUAjXiZ6r40kvaUBDpntIopXYw7i/NI8MZc74QNuI1
         Fz6KneWNHN1tweLEHnp0nCBjFH6wwdVty6zta7QWogAAM5lyOaNYKEoJwNt/8Lgot31x
         nTuyGFvBX42VzDDGPjXUT1EZAGozFlHNW6pXl0+F/9mD+MM3Cxt980ohJQW1I6AFZTUc
         IySQ==
X-Gm-Message-State: AOJu0YyzP/OZ7+m9AYOlTOxiuEsW37Onx6d6Ga4RXUhO5XF2Dxa8nhX0
	pKw/+y0g8P+MZdIReOoP3vRZwnATyhKcIQ==
X-Google-Smtp-Source: AGHT+IGuRan1QSMFIS0suu2RNYYvCaSf3PSirm4sqYkdPxDGUK0XjywhPdJ8d90V6kbofwqfeZj3g4BNTMnrXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:fc19:0:b0:d63:8364:328 with SMTP id
 v25-20020a25fc19000000b00d6383640328mr205097ybd.5.1694446934779; Mon, 11 Sep
 2023 08:42:14 -0700 (PDT)
Date: Mon, 11 Sep 2023 15:42:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911154213.713941-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix ip6_sock_set_addr_preferences() typo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ip6_sock_set_addr_preferences() second argument should be an integer.

SUNRPC attempts to set IPV6_PREFER_SRC_PUBLIC were
translated to IPV6_PREFER_SRC_TMP

Fixes: 18d5ad623275 ("ipv6: add ip6_sock_set_addr_preferences")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0675be0f3fa0efc55575bb5b2569dc8a1dbb9f24..fe274c122a563ce3a11b03e49ee71780b3dbda96 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1360,7 +1360,7 @@ static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
 	return 0;
 }
 
-static inline int ip6_sock_set_addr_preferences(struct sock *sk, bool val)
+static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
 {
 	int ret;
 
-- 
2.42.0.283.g2d96d420d3-goog


