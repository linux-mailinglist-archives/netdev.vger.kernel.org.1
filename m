Return-Path: <netdev+bounces-16206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C596674BCCD
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B121C210D8
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5946A5;
	Sat,  8 Jul 2023 08:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030113FE0
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 08:30:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A11BE
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:30:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c4cda9d3823so2786289276.1
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688804999; x=1691396999;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMp6LjpQ2BtHpNvPtrU+jnFIt89P4bXivBvbsHIFf8Q=;
        b=ByDC+nbbL1/ZhsQyWjqCNB95SMqHkw+4iQ3IUc1kixpOywXYqLaFtcBKBQD/LKdhBN
         160V2IoOusOdS/NIfSwkwwApSKZmKdErE5ZZUdsayjqicjOf30dweRGFTW9nRne2uHIp
         BjJAkrviDajpr/K+d5HL2y4g2/dsLQnlsh3oPfBZ/wkzaABm8+FfsrMdcA9Zj0dt4ke8
         mfQqZl9jEkR340qUouiV5SdZR1rxgUFhTIaOBoxXOlB0RXJMG+kZe6jebL1Xg5TeSMhu
         5U/IBZDqTjSrZIRFWgAs7ZQ4eYOBHeUWlVRt3dLj20YiyODMhuCS0dYbz4eZz5EXlszO
         EDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688804999; x=1691396999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMp6LjpQ2BtHpNvPtrU+jnFIt89P4bXivBvbsHIFf8Q=;
        b=FjlO3Qrz+im3A4sD5uLay/LVMOjodue5pLnbNhiYPNEhrl9fREigFMBlK8z18KGuH0
         aRJ/WC6TztFwtObc0Po89cyQJOpLLlDAGg+5/Uhi6Akwjb261IOC3TSwZHM+fwecEC3l
         4MNU7iGZvsXwg13mbQtf0V1CzFbveB16Ts1CJvqLAdtQwqtjwzd1LVrP4DqHmtEVc+qD
         rHonCH9bzd7/Yfa9y2wHnouj15wCuyTbvAvREpmhohRfMpnDPcdIYlYjQag3ZEQCiWrD
         I9ZtVjbFKMvNGWQGSwdylwvNbcN0JbgizBcE6JY0DHqKX3CFm1HH1C5GJbIuoF4pXfq5
         aEkA==
X-Gm-Message-State: ABy/qLY5TxbJWkVF1Qz/ioRmlu9cVPE2AECG58+Rbxzom94WYpI5EVJW
	iSqlSIwwKNcmyKkqCtONxMG+/YCVyE0ZQQ==
X-Google-Smtp-Source: APBJJlF8JQsLpHsTVF4vwovAy8x8enCKBXM5Jwh3Lbr6+IRFPSmrjnGOIUwTUGYy4OzgFU8ozG/4JsTmvgIONQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:1987:0:b0:c5f:4b1d:fae4 with SMTP id
 129-20020a251987000000b00c5f4b1dfae4mr35697ybz.12.1688804999569; Sat, 08 Jul
 2023 01:29:59 -0700 (PDT)
Date: Sat,  8 Jul 2023 08:29:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230708082958.1597850-1-edumazet@google.com>
Subject: [PATCH net] udp6: fix udp6_ehashfn() typo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Amit Klein <aksecurity@gmail.com>, Willy Tarreau <w@1wt.eu>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Amit Klein reported that udp6_ehash_secret was initialized but never used.

Fixes: 1bbdceef1e53 ("inet: convert inet_ehash_secret and ipv6_hash_secret to net_get_random_once")
Reported-by: Amit Klein <aksecurity@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 net/ipv6/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 630d61a32c1df0bc222dfff2613585b2d416f839..b7c972aa09a75404e0edb33f0354c53702c991f8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -91,7 +91,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
-- 
2.41.0.255.g8b1d071c50-goog


