Return-Path: <netdev+bounces-25652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B056775026
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BC1C210C9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3C38F;
	Wed,  9 Aug 2023 01:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A32591
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:07:47 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9219AD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:07:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4db064e4e2so4356427276.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543265; x=1692148065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9SxK9VuBhH23JZNfwlmHxFJB2H3YTPscUMoMvn8rbc=;
        b=APutyrGHq0YTWRW12pm4MFQuMqAXqr+kMsiQqH/8WklaM3Xjxt0HiR27YbGJXqvEjY
         6eEjM3eABJspnPyTNt2jI/9l9gN7s6Apj1V2bXUTaQ9tTsvddYK9toOP4z76HqRLSZRt
         YGmlC9Xkgtbj7ra6sGK/3pWh9mFaoc2xFXx4337GwtDA5PKpGMb1+DX0ndI/f5JOPxAW
         HMPJIJzRPp5qesMCm+caWpzVA0W6/0vT9s9rwk6lxg1NsIvYmVYxdiqFK9rq1it2FYIe
         /pU54CocziwXtDHFJpS/JtamqtFWIYrqhcgDztGeQ4O9gGhnrH7m3upujJELrSf8X8L/
         U8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543265; x=1692148065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9SxK9VuBhH23JZNfwlmHxFJB2H3YTPscUMoMvn8rbc=;
        b=VC1DipguTmJydDPNpxdeNa0dm0PrEkNy603AEBaiwNLhzGp8cX1AfEXKyLcIKFlvkI
         WevWXJPTgCjScB9u/Hls2CTxqElYr2q63o0B1k38Ts6En4DDH2vMyGJMsJUdUXzNZUcM
         106a1jQzbQwcxj0sZOa85H5vqpTOH/pFog1p7oWVCyaFLr3E5e3wTRvCQwYBBDPm4JTi
         UP8TGrHk6efoCkFDLEgSstRGNcHUqAgbgUz7fQuEy4k5WVGksFU2CbRAW8/fAzoofimi
         waf+suF8xrtFB5Jc1+HM7AgkPyIW6+IZbZVVk4Nhiu6MiY1+//9CTYxRXFcFG3P35TSm
         YN/w==
X-Gm-Message-State: AOJu0YxFHnC/vETLgG/SDMR80nuMEdE95EybRy+TNYNK8b38gQSssvcG
	gJrmZEqNVUGzVHQ0kCJzLzJeidaPd493+WtOsw==
X-Google-Smtp-Source: AGHT+IEY4ztdjT7PWj1HLsFFH4GzdFYJKZG/8yNdDtgyLo6Kn1SWa4ceZv423UysbgranQwQ/B7QY6TfJ/WFPP5Njg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3288:0:b0:d44:585f:dfa8 with SMTP
 id y130-20020a253288000000b00d44585fdfa8mr25516yby.0.1691543265492; Tue, 08
 Aug 2023 18:07:45 -0700 (PDT)
Date: Wed, 09 Aug 2023 01:06:09 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1226;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MYwDvvyMzq/6Jbwjo4fUCw6xEkwFFEE6felLK1tQBvc=; b=WeXXNFVuxmL2/RZ5Dpc6W99h2eU2abWzCTXFBENisuaDRhmkxGJ3LkZOTBNdDDy6FyfR6PlS8
 bEW3jArRu3JAcBUw2APr+XvWRQsMcU+uQodYXJbL14BITjI/xUBTb+t
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-6-5847d707ec0a@google.com>
Subject: [PATCH v2 6/7] netfilter: x_tables: refactor deprecated strncpy
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
 net/netfilter/x_tables.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 470282cf3fae..21624d68314f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -768,7 +768,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 	m->u.user.match_size = msize;
 	strscpy(name, match->name, sizeof(name));
 	module_put(match->me);
-	strncpy(m->u.user.name, name, sizeof(m->u.user.name));
+	strscpy_pad(m->u.user.name, name, sizeof(m->u.user.name));
 
 	*size += off;
 	*dstptr += msize;
@@ -1148,7 +1148,7 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 	t->u.user.target_size = tsize;
 	strscpy(name, target->name, sizeof(name));
 	module_put(target->me);
-	strncpy(t->u.user.name, name, sizeof(t->u.user.name));
+	strscpy_pad(t->u.user.name, name, sizeof(t->u.user.name));
 
 	*size += off;
 	*dstptr += tsize;
@@ -2014,4 +2014,3 @@ static void __exit xt_fini(void)
 
 module_init(xt_init);
 module_exit(xt_fini);
-

-- 
2.41.0.640.ga95def55d0-goog


