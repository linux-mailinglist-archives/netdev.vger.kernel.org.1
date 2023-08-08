Return-Path: <netdev+bounces-25609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DE774EA1
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8D2819AD
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF01BB57;
	Tue,  8 Aug 2023 22:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FD1BB21
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:38 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825112C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5865afcb825so73829777b3.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=l0+YZUWT9MVORUoAKyZtIiSvH9yjrNYKYquI4h6G3Bw2EZqzd31uHqgRU63WUeJiTY
         CpJguIuWZtSwCxzXZL7m605eZS8Es5f38S3flkVmk3kM8LB0HvSqtkdI1c7Z2AyBkGtq
         5NfO/1zVNGQ5YGvx0dhjCckfQkOwM8SuFYDezhYuUQtB+xJ3JKUpKSCYccD2Z2qKxi22
         OO6RsTdtADjOReVX0UY1bUfshvROIJWuQWuJYZtqakkYY3FJ3grYtZbKyVjGMV37v+ur
         OCp34anb+2N2Kvfjr0/rniDTTRMNJAKTjeHOC8KCmX2XwY+Iinw733StNw48QbzrItoa
         QVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=TpWlpnuLy5Xfd8Oe48KNM/zhnYaiuwOIH5Qy4jxUjTraTZtOLqe9s5KMLD+mKZn64x
         dTXzbyDlrf9XIIQDcx8ji0YlBA/kwTHByPBMDIzU6KgBay3PZrKewWmK7/d62rvh6X8C
         h4DoSfbLZvlrDy3fhqCnTxcj04KTMjJ9JpYCl61Kpyod24pQeyTicoBdFnAzjYBJG2pi
         4bKZpN8eyEk+0IeQJDroWpXUSvy8UzfVIOPs1ncIjRNGPONh1I2AUCrNj+zpshCnUjz3
         8PQJikkIVrIKqZqA5+k7I0WFtHWXfLmRq62NhUQ1RKlw1oJZ+Xxjk6bG3Q/k7aFuVXzd
         ntKQ==
X-Gm-Message-State: AOJu0YxE7akiFgFz9KqkKRnO+vyAypDGiHpP2wj3l/+N+JzRbWFrqL7Z
	UF14xQLh8N9o7s6UYFH4HgDJYZE6+ip0aCs3wg==
X-Google-Smtp-Source: AGHT+IEZqIi+KfXakktMR77yvcqvv7E79OwhtWF6B0zRs21LhdiLRA3ymZOhLEcubECjKuLZCFe6Vy5Az1cpq5gVng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae05:0:b0:579:f832:74b with SMTP
 id m5-20020a81ae05000000b00579f832074bmr22779ywh.10.1691534916696; Tue, 08
 Aug 2023 15:48:36 -0700 (PDT)
Date: Tue, 08 Aug 2023 22:48:08 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=968;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ql8BKCTJsc3POKLEq/ADab6DF9AYOTL/azd4EamUBcI=; b=P3R80qBBGIzHAbifBNpGmUCEncCAPqmEwus6LSS+QDg9lMvg2IHe2edYrrt/QOZp2p4frMdd+
 ACoDi+vL9tDBW4ezE6keUa+9XyhIWr0M32IT7a0qKJXdIEfk7Y9a0tM
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-3-efbbe4ec60af@google.com>
Subject: [PATCH 3/7] netfilter: nf_tables: refactor deprecated strncpy
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer `strscpy` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note:
`strscpy` is generally preferred to `strncpy` for use on NUL-terminated
destination strings. In this case, however, it is hard for me to tell if
the dest buffer wants to be NUL-terminated or not. If NUL-termination is
not needed behavior here, let's use `strtomem`.
---
 net/netfilter/nft_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..f1a3692f2dbd 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -150,7 +150,7 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 		if (priv->flags & NFTA_FIB_F_PRESENT)
 			*dreg = !!dev;
 		else
-			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
+			strscpy(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.41.0.640.ga95def55d0-goog


