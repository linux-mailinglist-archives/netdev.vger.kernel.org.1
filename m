Return-Path: <netdev+bounces-25613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA832774EA9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5487280C3F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18C1CA0C;
	Tue,  8 Aug 2023 22:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB41C9F7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:42 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E7E4A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586b0ef17daso6531827b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534921; x=1692139721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9OF2QFsiP3MkrzN4gKJO5o0WhLZ6LzcN9E8K6dc8dQ=;
        b=Tk5sym5cRDFSry8K+vc1HytKkY3IbV6iZulQcdqzajiE0IVk3xAlVvRndUZmAf1bym
         qmBA/CUFS/PGUXiFjGhkccdVwoX3zHUdcOMoLvXMMUMjR8yufvUM3BMxdbZVUZUBohHJ
         XDd0dKfCAqHUdAGRMbnyrr4FGDyVDAC1FubuFJd7iCMUjnLDpsu9n3DTiB9Phq8Qvf0E
         q8U2keEGG0MEUAozFw72uG4Zvu2LbBhukIi5JUVz+Vr+B72eM5IBoS4QlmZ4vDb1Wq63
         DfyTE1Qq1a9iFWqR253R9wuYjfP9rEWY7oXwiicHyPCLs7WfdwbOq9mI2Yx1daOUKLxs
         Jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534921; x=1692139721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9OF2QFsiP3MkrzN4gKJO5o0WhLZ6LzcN9E8K6dc8dQ=;
        b=DxbLNLehnYBwPzLhYsZxZIT+LSUJY5ugWBLNaHz6AsqtoTfbf80OLsQzAyXauPtx66
         ViptGRXR7MVy0QcoGs9sVq9D0l0uHZSb1sXEXA/ZiQAxJrY1B7pg8MGxgFgdrd1m7aYM
         8vXGfHNMAfXTvCjAZxr6JYGzTVOZuXxaUzZDN8TYQz26hJTpbrP9LBZ/aQJuXqW+YbcL
         JT5hJiJRdfDbMRE5Xwuvsx+FbeTa1wlvxg8cYyczK7KqcF1JnnuXaqMwreVcaiFOn4we
         4HOMXkPT2WQxBh0ID/E8/BRaC9JAOojr17v5q6Zy6CrtLPDb+stWJeVLivbwyeN8eMd5
         b3GA==
X-Gm-Message-State: AOJu0YyTRzKm5sxYi2nAeway1OIfT9YV+q7Y1kNGhRJ15lPM3qN1UTjE
	IPdgcJkCQHVlv+6YjC8x/tHupKi7Lw3BDiTDSA==
X-Google-Smtp-Source: AGHT+IGCyJW7+H01CcBpmwMLWO4IJOM2JRZefUJenQ9SapEIQSusWKx57m2Q2rpVYsPLUriKIRjxQtAgRFf96MgkCg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b61a:0:b0:586:e91a:46c2 with SMTP
 id u26-20020a81b61a000000b00586e91a46c2mr107296ywh.4.1691534920928; Tue, 08
 Aug 2023 15:48:40 -0700 (PDT)
Date: Tue, 08 Aug 2023 22:48:12 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1134;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Bp+w2rTLNgdzNlxLi9FLD4utZ4QUqpPxaPIds7U/AGY=; b=odK4V1dqN6Y308K04MH8d/MRrkeaDSd1rELzLfU+7SDbRdFBl0nXUSsw+H9Y12YsVkVDC43lj
 zmYSndS5Js/Dv3+IClsSCDsbs7OJ2vOQ6onFe43X7Ff2wDY/LO6DwG0
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-7-efbbe4ec60af@google.com>
Subject: [PATCH 7/7] netfilter: xtables: refactor deprecated strncpy
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer `strscpy` as it's a more robust interface.

There may have existed a bug here due to both `tbl->repl.name` and
`info->name` having a size of 32 as defined below:
|  #define XT_TABLE_MAXNAMELEN 32

This may lead to buffer overreads in some situations -- `strscpy` solves
this by guaranteeing NUL-termination of the dest buffer.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build tested only
---
 net/netfilter/xt_repldata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_repldata.h b/net/netfilter/xt_repldata.h
index 68ccbe50bb1e..63869fd0ec57 100644
--- a/net/netfilter/xt_repldata.h
+++ b/net/netfilter/xt_repldata.h
@@ -29,7 +29,7 @@
 	if (tbl == NULL) \
 		return NULL; \
 	term = (struct type##_error *)&(((char *)tbl)[term_offset]); \
-	strncpy(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
+	strscpy(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
 	*term = (struct type##_error)typ2##_ERROR_INIT;  \
 	tbl->repl.valid_hooks = hook_mask; \
 	tbl->repl.num_entries = nhooks + 1; \

-- 
2.41.0.640.ga95def55d0-goog


