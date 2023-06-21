Return-Path: <netdev+bounces-12748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B01738C87
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80AB1C20F18
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE219BD5;
	Wed, 21 Jun 2023 17:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7519BAE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:02:51 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE710D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:02:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f84f75bf4so2886825a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366970; x=1689958970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=CDe40wq+ByPLHcciah53IyY8ka+k/FUoh9rlvUpk0Rz5YkBccmLt3wUrapCI6HMtqD
         nZxp8Bqv60jel7eAZmLxSoMXdNENuypCbVFCeH8QquCA1Ip1q1nRmSimkOtsY9iWS1yl
         IYqe6Xx0LLp/gMBVqTyGXFOekUpDa8s4tCkYPZShFrbgwyr7qco/N+m9MyDrQmalEppi
         I3skQXpqbpInihHpmi1NwgCLEyg+/FMITmbNezFTMvVErPd0x7UWmDcJq50R35AxPuIq
         KT9dfW1d4gxU856yNbpSfj4HKOjxb27nbSJz4AMDDWJY8oPUAQqwY4ZLjgK2FnsEddvG
         j/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366970; x=1689958970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=fnloGgeeiUXIPnGREh5thQ52UNqeFDxt+4zW+17n9TfcA7/jf+fwuOA5PgHX2nRQQz
         QLgYCV08p+Ii0lq5ZAgng6f/PX/Wb8jqtccNzK2bwxw7UY+TW1lC0dGmGihU3stPRJ4k
         y8A34Y6wtWQ9EuepDtkV1fQIBhRtb+TgB0uJ55NaTggjp1T1PDDZ8EaT/BLCth7ImXF8
         8EDIVJ9SBfIIRtRR3mK3ZbLLXVUucnQJTaLC1dyR7/WpEsiSb2nC3pTz3g8EljO9g6SV
         mrJwYNjcEZ9jW+ipRYMNp2vRBxwscran/E5uKyf0bkpi5RCTVFgkNto3hoW6P5BAitIR
         6YbA==
X-Gm-Message-State: AC+VfDz2jVn3+noFab/sbhHd/DoWde7gO5H3zi+UW1cgpzf3ruhsUYOS
	HYIadJGzSe65tbahwAIvKVI4MoE=
X-Google-Smtp-Source: ACHHUZ7T4z5BMYP8aOK9EXSfV5iL1qhQkAqfBTuu6hJZfby78AK9fENfUPBKIY8cnY//hlpEXkd6pfE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:5896:b0:261:2e5:b5af with SMTP id
 j22-20020a17090a589600b0026102e5b5afmr266907pji.1.1687366969970; Wed, 21 Jun
 2023 10:02:49 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:35 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-3-sdf@google.com>
Subject: [RFC bpf-next v2 02/11] bpf: Resolve single typedef when walking structs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is impossible to use skb_frag_t in the tracing program. So let's
resolve a single typedef when walking the struct.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..9bdaa1225e8a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6140,6 +6140,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	*flag = 0;
 again:
 	tname = __btf_name_by_offset(btf, t->name_off);
+	if (btf_type_is_typedef(t))
+		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log, "Type '%s' is not a struct\n", tname);
 		return -EINVAL;
-- 
2.41.0.162.gfafddb0af9-goog


