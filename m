Return-Path: <netdev+bounces-25650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE78775022
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5122819F9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4692A38B;
	Wed,  9 Aug 2023 01:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B964ECE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:07:45 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED811BCF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:07:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586c59cd582so48846877b3.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543263; x=1692148063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6nqOI6OhZk9uVMuCMDveLdue/VtxmtzrsTXPIDYRI=;
        b=ZoQqX5UIeq1jO5/Y5J5W2a7PzzXsb8d0S2K9nNc0sxvuHfEUau2nSLFvWWx5TabJYG
         9AjCKoQscaQ3FibFIL636z6Qkx9MWiHi+jZzcS09eay2ZGG8ou0eqWAgykq7xE935CdT
         Y/BBWwHMbzudYeSVdUcGcDGZAbpW2ULHrvSazCEcoWFyxdgAZRZLgJVtM3QvN5w995cD
         4gKNjSaX2/YVLXjoYMhH6jmDrKOeTQd47uGISSSDdR/wLa+Fr8lRe9HTNHcg+y0+ZlpS
         kC53/iPBs+RI23nXLKLuKb3pyVovbV5P1iJTe8dt2Rr+HJB4qllUtIoJ/lAhndvVoFC4
         KPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543263; x=1692148063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6nqOI6OhZk9uVMuCMDveLdue/VtxmtzrsTXPIDYRI=;
        b=PD6rIOxVuU1uStTaEPRVt4MrPfk4SDWdxNFxhRfjKq68VAGbwkrsvP4yxJu+7aEIW4
         BptvmwvW3NyfSZT/XdDumks/xN0rl92B0RbX3wZttprsBcj8j8fcmrQeMwL2hV7S9Uc2
         t3i4gduKIUbQXs8FVAWyv6Hh5C7wIUNILIw37cAcEgT4n3dcjkkG/txGDGRBQM8fTRRY
         vZBzLZlpbWs3QmjaqTHhyP5PrBHGSYWJfJPUf1TZTwdeOAFnFQIC7UgehnpTSb7YKYH2
         M+lci9kYNttRFmU2u9c7dnFvkhHUbmik5sw1fI14uZk6XBP8gFvnfe0RN+db+e0BaWAq
         epdA==
X-Gm-Message-State: AOJu0Ywm3Heu+/QLFxcZT+m1b0/WiewvXuJyoQgjR0d0nUOtgqNBHjOF
	Dw8Q+5+Do/876OmVy7neEclJ7/g3bCeqhhjOIw==
X-Google-Smtp-Source: AGHT+IH5kjZOtu7DJJU2kcy5MUvh/1RM5TDPejbuQtilClG6fsAJ6QcOKvf1F+QzpdoZcY4Uz8jB2YjF0tOQbZPbdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ab62:0:b0:d4c:f456:d54f with SMTP
 id u89-20020a25ab62000000b00d4cf456d54fmr22714ybi.8.1691543263329; Tue, 08
 Aug 2023 18:07:43 -0700 (PDT)
Date: Wed, 09 Aug 2023 01:06:07 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1342;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=7ETYnKTeQUVzYvHKo3dCw3Fgg8Ju8JACIFGAct1WkOg=; b=vu0OZUT90qel7Bct4/ripVcEolXMpugmp7bRnKPUqOl8EyTjsFcrN5q5j/s4LBuhdPWIHYjOi
 wh7kSdYgds5BsJcyjEsLKuA3/gws5T6+wjRr5B/LR0IzcPd3PBc/Kf/
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-4-5847d707ec0a@google.com>
Subject: [PATCH v2 4/7] netfilter: nft_meta: refactor deprecated strncpy
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/nft_meta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 8fdc7318c03c..f7da7c43333b 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -185,12 +185,12 @@ static noinline bool nft_meta_get_eval_kind(enum nft_meta_keys key,
 	case NFT_META_IIFKIND:
 		if (!in || !in->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy_pad((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	case NFT_META_OIFKIND:
 		if (!out || !out->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy_pad((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	default:
 		return false;
@@ -206,7 +206,7 @@ static void nft_meta_store_ifindex(u32 *dest, const struct net_device *dev)
 
 static void nft_meta_store_ifname(u32 *dest, const struct net_device *dev)
 {
-	strncpy((char *)dest, dev ? dev->name : "", IFNAMSIZ);
+	strscpy_pad((char *)dest, dev ? dev->name : "", IFNAMSIZ);
 }
 
 static bool nft_meta_store_iftype(u32 *dest, const struct net_device *dev)

-- 
2.41.0.640.ga95def55d0-goog


