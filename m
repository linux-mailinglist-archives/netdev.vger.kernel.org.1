Return-Path: <netdev+bounces-25649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC7775020
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BE3281A40
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A232632;
	Wed,  9 Aug 2023 01:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3450812
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:07:43 +0000 (UTC)
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31E19BC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:07:42 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3a5a7e981ddso11704486b6e.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543262; x=1692148062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVz1ojRkhYeSRtVo9H/tM0do8XQLIQHE9IgccPkP+yI=;
        b=YM0EF08LMQ5WvMrXeAp8gjjtszwUk2pUWzHCMZ0zn+G2isYfsms0AEcAOJHR+FzqoJ
         5gGzXyXgO1s6N6jbssTgI6zymokr1AXoo+FhWaVJg4ihaxML7ucWHHuIxbr5HzCvt2MG
         Tt3yOmk7P8lv4yKQX63qFntp01EHrSBjsYSJq/s2dMp7zCD1Je4SxOgsOQ9tGtmEzCoe
         SpySLAiirdXb9RHkLdoS1GVfBe+V+nm33FdHqqxIkhu9U007DhL2rTOQ0/2K+sDSPX6C
         uGWsZ8A2DtO3QHV8XEPMcKLOS6G2USuAt/czHn56zM0QWZ4AQUFXQcNZZzbRLXv8blyO
         iMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543262; x=1692148062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVz1ojRkhYeSRtVo9H/tM0do8XQLIQHE9IgccPkP+yI=;
        b=LzengGcVPf7dib6H7cbKUj+PJoWgUHf+C2CiDZW0Z36B5SLHvAHC6UrHXptM3v8+UP
         /zjou6yB+8AD5N6Ib9NYKiei1zHVKBkYxehLbKm0rVmmPcwnMX3TqbyFlE+AkTAoQCUh
         7ifrMJHZx2YU2yRPtXFHHuN2u8ZPcRykrdX6Wp65v5FCuUzp8ipn4trMrE9zCFuNul18
         derIGahsLNvrI3wJlXpPJugpPVP0nSxks3+gi4rt+vP7l+6MAfyav7DQJYokGyMdwl7t
         tR7asKCrT8oJj0wrW2+WR1TQNrjDWY+hN8t+dq295l8y9IYPoydVhnN7rwfPOMw0pReG
         UYJg==
X-Gm-Message-State: AOJu0YyhP+LxnM00P5eJhAYbHp9KdpnsyfoVmCZXC9vUc3LZYZlzPDEi
	BzSpMnAFYAywG0u51wUPbtg5ESOy2hOoe1ZLmw==
X-Google-Smtp-Source: AGHT+IEKxVs1OlcWwiqA53GB6oh49zRgHksKsF0BWd5xdJypQdb1s8ZOL6iCRc3UIvJ02CL7Fj3KY4dzDtnnYJ2MCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:1594:b0:3a4:18d1:1686 with
 SMTP id t20-20020a056808159400b003a418d11686mr793268oiw.10.1691543262146;
 Tue, 08 Aug 2023 18:07:42 -0700 (PDT)
Date: Wed, 09 Aug 2023 01:06:06 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=692;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Rb7knhgVRoO1cFP5KZBOoghV8KJqLMcT0yWjrGm/ENU=; b=SGRqAQLRAvrm1QwRllI6+LYWlBGAQP3OWJJwRohe3cZ2RB+HyT7yASIlpFuvkLVwAhf0uTtpO
 XHh1FrAHIHoC+nIE6P/23cWFGuKLtpQSj4dwTByKp1fsGBUz1TyiFoX
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-3-5847d707ec0a@google.com>
Subject: [PATCH v2 3/7] netfilter: nf_tables: refactor deprecated strncpy
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

Prefer `strscpy_pad` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/nft_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..8c250a47a3b4 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -150,7 +150,7 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 		if (priv->flags & NFTA_FIB_F_PRESENT)
 			*dreg = !!dev;
 		else
-			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
+			strscpy_pad(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.41.0.640.ga95def55d0-goog


