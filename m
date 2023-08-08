Return-Path: <netdev+bounces-25608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D2774EA0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C607B2817B4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95BF168BF;
	Tue,  8 Aug 2023 22:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E21BB44
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:37 +0000 (UTC)
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A346109
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:36 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-39cdf9f9d10so9549012b6e.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534915; x=1692139715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+nft1J+ou/Hn4BoHtSydnM2Q6o7LrROT4GXzieyqk=;
        b=Z4tv8uuXCuHU3DyrL7CiwM7GRo//gKoN1gu49jVnkLDa77GxmOTvrZb6iVPtpovqAa
         y/YZP94ASRtbfUFGv2+k/+4bVka6Zb8iEhQgqrCavmKZqb5Vf3DMxM1GXr8d184OeWox
         Jkmar07CKdQd0GpGqnTygT2rhd0kL32dr73jAc1qnhLAgdE130ZeCZfffAKAkJ6p4g+3
         Dhu8FFeDILrfEK66hbM9G62Cn84pEjVIyl6RtRVPcwxUI4pmvlJGyT/b7ZFu6jTEPe4q
         d4n4ZEeUzxKpvL+rOyjg+0S0zqmMfzBzAsT4DyiSxbJFnPTWrd8jZrG0UVA3jQ81IpYK
         PMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534915; x=1692139715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+nft1J+ou/Hn4BoHtSydnM2Q6o7LrROT4GXzieyqk=;
        b=CvkFz5L7nwosTcsG4ubPQB1UpzA+wzxbP9ivMsmSiydtTwcUMn7TzxVuS20eEvufZy
         IIP+vAb0GlxYpqGL1hcu19QmYCCi4PsTGFMq0MtvBCNFYl4VE9i0fBmZQagjhXNIxsBg
         ZUmyhR9dBx4yLXpqsGBI9gauzhuXvnhA0tqbGjaFY64AYUefLpyx6AbXtN9rgHuKg//4
         6/IRMctaDYZM/RM0upR7kt9Gy48AOCVTXlURax9tIiZ+XzyMDfKs9AEPLNMP8q92a7HT
         Qt8PVEm063r6moK0Ur+rH2iE5vNDVrN+6aEgLacTxMn3GSuJVONKYz744dC7KI6cmPp0
         aBuQ==
X-Gm-Message-State: AOJu0YybrbY7/kSU/1Nq9hBiabpaikAUCREeer6/dQd3LKWZAFAIvNMU
	9uL6RS4al2YcaB6/7BeYX7oLjZhSKaFsyYOdHA==
X-Google-Smtp-Source: AGHT+IG33SMyJD9jmKUFIKwhFa1OIm3UDBC6wsCIb+3jj0vK9d47zhFOBFyzd3Ind1lxI6YX0YxchI++1WpiDqFOxQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:180f:b0:3a6:feb1:bb83 with
 SMTP id bh15-20020a056808180f00b003a6feb1bb83mr630290oib.3.1691534915476;
 Tue, 08 Aug 2023 15:48:35 -0700 (PDT)
Date: Tue, 08 Aug 2023 22:48:07 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1355;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=h9/FJ0Derc+kHy1+HyfJeM72Jn/xHxsLrarMyJSTkdI=; b=nCzazijk+LV8MhghKkMBl3+PR9A0KP6j7aeC8rKtHaGSgAXmI98rCZPOtIh3eqAsdnnK140X5
 2tW2f/G0EY9C+Xes0E05fHk1dEoFtF75/yOMaNAtBErqXMEO7z5CTOV
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-2-efbbe4ec60af@google.com>
Subject: [PATCH 2/7] netfilter: nf_tables: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer `strscpy` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note:
It is hard to tell if there was a bug here in the first place but it's better
to use a more robust and less ambiguous interface anyways.

`helper->name` has a size of 16 and the 3rd argument to `strncpy`
(NF_CT_HELPER_LEN) is also 16. This means that depending on where
`dest`'s offset is relative to `regs->data` which has a length of 20,
there may be a chance the dest buffer ends up non NUL-terminated. This
is probably fine though as the destination buffer in this case may be
fine being non NUL-terminated. If this is the case, we should probably
opt for `strtomem` instead of `strscpy`.
---
 net/netfilter/nft_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 38958e067aa8..10126559038b 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -108,7 +108,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		helper = rcu_dereference(help->helper);
 		if (helper == NULL)
 			goto err;
-		strncpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
+		strscpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
 		return;
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	case NFT_CT_LABELS: {

-- 
2.41.0.640.ga95def55d0-goog


