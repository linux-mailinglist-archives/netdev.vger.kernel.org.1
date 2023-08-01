Return-Path: <netdev+bounces-23255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A076B71A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CEF1C20E43
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9623BE6;
	Tue,  1 Aug 2023 14:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9323BC4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:14 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80A125
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso768340566b.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899551; x=1691504351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5H3vrlrNdg0a9iWb1jQYVM+4JsKHr0/fJTZq72Xl38=;
        b=nVayY3zx+JP5VvF4fRkzN7vJeBaZ/QqmIkcEZN0faE1bzwXTETpbMF6s/3PZnTiuhJ
         TrIkj15ldStBeYR5zhwhYsO+UTDJiBHitNp7R9G/lejDuimmwC8XpVliyLC788D4FUT5
         +hQesZ2JRzqaBueizGGERhQMks0POAysO/2zxHFk7Se7aXVtnM1ImfIVTwtAVS6s1Iah
         PkUbwSkX28n8MiJ0Jq5IlHBerFnpZ2K2uYlveRe7LGBq4KxfdVIuJ3Ne0SSPVQbL87ub
         6MPVJmwTYu1ej0S6mD4z0AQd9q8Z37hfbbGuGmUzGEkRc9PRar+y4EfN1ZqeBUIgYomh
         0GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899551; x=1691504351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5H3vrlrNdg0a9iWb1jQYVM+4JsKHr0/fJTZq72Xl38=;
        b=Sd9o+3BAok4Ykwh+t2ahit9f0aTvTJvz0VjK7SFk7E60e8dsxYXrl/Zr+kdpAwd7tz
         FnWmnZf8yPVe4fnn6OZG+KLDa5AKJZrlZzR9QLMcKPF3HOQsPIueFRkZNjbLUfSioWQg
         3DP2F7meo9KrHg7IjJHu223LllpoodrUiqXY8AdlzA687X6RDk4WTnXrWiu0X3FCB+x+
         ulpPRbgHwPSQN9KNTbuGrTQNEfBVmuWYvuHOhMKVctzWDFz9wZIesUWwnC61YZnU7KZ4
         fgCd4jzXIGNpvpGz+kl6a47WjMm4wxbqIa+w2zE7frKNwzffpZXv9ZRFueReKWFzKzKV
         ToJw==
X-Gm-Message-State: ABy/qLa2hRZrCTBDac2OSl21tovDo19Iin4Yp7J8eYOzw3DzemyI6gML
	h5Hft+X0CBx2t9fZWG8ZnEt9jfQaFX899So4qNyuNrTi
X-Google-Smtp-Source: APBJJlFKX3YAJtc+4xxPWDCA1Rh9WV8zVd4BWB65tTSBn9ANeNFMBELnjh5hUnwHIHS4AER1VsgsOw==
X-Received: by 2002:a17:906:cc0c:b0:99b:d350:32dc with SMTP id ml12-20020a170906cc0c00b0099bd35032dcmr2525074ejb.70.1690899551220;
        Tue, 01 Aug 2023 07:19:11 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709067e5000b00992e265a22dsm1486768ejr.136.2023.08.01.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:10 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next 1/8] ynl-gen-c.py: fix rendering of validate field
Date: Tue,  1 Aug 2023 16:19:00 +0200
Message-ID: <20230801141907.816280-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

For split ops, do and dump has different value in validate field. Fix
the rendering so for do op, only "strict" is filled out and for dump op,
"strict" is prefixed by "dump-".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/ynl-gen-c.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 650be9b8b693..1c36d0c935da 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1988,9 +1988,17 @@ def print_kernel_op_table(family, cw):
                 cw.block_start()
                 members = [('cmd', op.enum_name)]
                 if 'dont-validate' in op:
+                    dont_validate = []
+                    for x in op['dont-validate']:
+                        if op_mode == 'do' and x == 'dump':
+                            continue
+                        if op_mode == "dump" and x == 'strict':
+                            x = 'dump-' + x
+                        dont_validate.append(x)
+
                     members.append(('validate',
                                     ' | '.join([c_upper('genl-dont-validate-' + x)
-                                                for x in op['dont-validate']])), )
+                                                for x in dont_validate])), )
                 name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
-- 
2.41.0


