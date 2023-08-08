Return-Path: <netdev+bounces-25606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7E774E8E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B469928197E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE08171A0;
	Tue,  8 Aug 2023 22:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034B156F8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:36 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1D106
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586bd766310so35963647b3.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534914; x=1692139714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmxbnIjb/GqnmOwdg1rDIRZFSHSZsVM8YSAQMHLnbME=;
        b=aIe42t0D+ftKfG+ClAKmcOJv9mfebYDaQmvdUgboDYiuG7ilotz/5nbttvtF9fDi1O
         rDs+7df7Cjn2shLvTm3qNsiEBm8OAhAGyBYA8+AW/pofGiv6RHPapbcws6nbEk9HrPGS
         jdpUQ2BCppjQpV6sMqGiCLG4WGKm2D7YKRlPEGM+eVzHKsUpnoDU0g025UZnAtmR5xKS
         69kyYON2cNSaE9f11a+LbFMqSZNt4tUq/usnE638ystMj35JNiukiKDpxLr0+iFW4Iwk
         J0bUrgboDjs3jAOSnOJyEJ65ZJ5Jx29Wa8GeSwiRYeXVg8OBaqUv/tSju9f+CoMdqa+d
         o0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534914; x=1692139714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmxbnIjb/GqnmOwdg1rDIRZFSHSZsVM8YSAQMHLnbME=;
        b=MiXHlc4ireMbKYfEx8D/F9TUSsurfx9X2ra1qKKbJa4j8ttY+1vqzCoFFrCDK+OQCH
         2/yQAs338mpMBfh3psHqJXv+rVLZ7OnqG8XPsdvapEO6U1k+5NxSbvGpRHQodcNnAAy6
         B9OWUndKWSoi4O9Dahj5zg2k64l5rCkdt7bIrJwK6SZ4pbkypeXXuv0mqMBQi3H4X/JF
         UQRhD5ltagL76i/Io0RqoItMP7XPbgziqlHk7jja3VEZPoW0J8sgwSrkl0yltYZIRHi9
         guhC7Uofsl2Wco7fyDP5CeC3AOXA0vb8TEW0ROA8uZF5UQEkTMVjiH69Y6tlnsHNMJik
         DrgQ==
X-Gm-Message-State: AOJu0YwCArKioPMGewQhj2KPeoEQQRahfFJZHGnG9SwvFKYdSmj/IMEr
	BvvL8L5luNfvQCwuSvNWcNkg4LGkS2wvlxma0w==
X-Google-Smtp-Source: AGHT+IH1R6MtPcgGGYPgM2RykK/TeOvNqFtYstVlX2iypy2EipYIxRKnBXKcog/LYd4QF5rzW3sffHKNadArPUWkLg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:440f:0:b0:576:9519:7085 with SMTP
 id r15-20020a81440f000000b0057695197085mr21593ywa.7.1691534914271; Tue, 08
 Aug 2023 15:48:34 -0700 (PDT)
Date: Tue, 08 Aug 2023 22:48:06 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=2289;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DmlnBBnHsP5QeIGI++tEAn9BIzXi+bfjHimTMSaz/pg=; b=620tlRlsF6w/UUZG5WGZx2U4Mf2LH5YYLrf8rikieAPOtoORP/uUHedtmuqLWAwhLMG5oiohV
 aRW3uUVCq+7BzN6wbjpH81lJbtdkmWqFFVPVtC/eGuYqCKR1vIDbvcj
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
Subject: [PATCH 1/7] netfilter: ipset: refactor deprecated strncpy
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

Fixes several buffer overread bugs present in `ip_set_core.c` by using
`strscpy` over `strncpy`.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
There exists several potential buffer overread bugs here. These bugs
exist due to the fact that the destination and source strings may have
the same length which is equal to the max length `IPSET_MAXNAMELEN`.

Here's an example:
|  #define MAXLEN 5
|  char dest[MAXLEN];
|  const char *src = "hello";
|  strncpy(dest, src, MAXLEN); // -> should use strscpy()
|  // dest is now not NUL-terminated

Note:
This patch means that truncation now happens silently (which is better
than a silent bug) but perhaps we should have some assertions that
fail when a truncation is imminent. Thoughts?
---
 net/netfilter/ipset/ip_set_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0b68e2e2824e..fc77080d41a2 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -872,7 +872,7 @@ ip_set_name_byindex(struct net *net, ip_set_id_t index, char *name)
 	BUG_ON(!set);
 
 	read_lock_bh(&ip_set_ref_lock);
-	strncpy(name, set->name, IPSET_MAXNAMELEN);
+	strscpy(name, set->name, IPSET_MAXNAMELEN);
 	read_unlock_bh(&ip_set_ref_lock);
 }
 EXPORT_SYMBOL_GPL(ip_set_name_byindex);
@@ -1326,7 +1326,7 @@ static int ip_set_rename(struct sk_buff *skb, const struct nfnl_info *info,
 			goto out;
 		}
 	}
-	strncpy(set->name, name2, IPSET_MAXNAMELEN);
+	strscpy(set->name, name2, IPSET_MAXNAMELEN);
 
 out:
 	write_unlock_bh(&ip_set_ref_lock);
@@ -1380,9 +1380,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EBUSY;
 	}
 
-	strncpy(from_name, from->name, IPSET_MAXNAMELEN);
-	strncpy(from->name, to->name, IPSET_MAXNAMELEN);
-	strncpy(to->name, from_name, IPSET_MAXNAMELEN);
+	strscpy(from_name, from->name, IPSET_MAXNAMELEN);
+	strscpy(from->name, to->name, IPSET_MAXNAMELEN);
+	strscpy(to->name, from_name, IPSET_MAXNAMELEN);
 
 	swap(from->ref, to->ref);
 	ip_set(inst, from_id) = to;

-- 
2.41.0.640.ga95def55d0-goog


