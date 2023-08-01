Return-Path: <netdev+bounces-23256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2576B725
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05E82819C5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515C25148;
	Tue,  1 Aug 2023 14:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56624166
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:15 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65257E45
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so8175758a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899552; x=1691504352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2cfvhx3D7hiMArRKGhXMYYteYluRWre8IDEWIBOsHM=;
        b=mGkz337DXIQUsSq2DX47UrAPZJhcJ7/+gJnzGromiYIBaasYOwv8ypcKC+Z1zo/yfN
         XfqHDJwHf08dk1f/N45UqQM+BLnYsa97k+RNcohBMdk5QEOy8k0QTUE92W17T9Spcl0F
         iEF/JPXSUAZTkwRDOE2nPU4/AB1x2/BX1/7SSh3wNSsIa/7yhQ+C9h/nylkrJL23Hm/n
         J7UZe5HDEwqQI0/dsTncm6PDVD6MEOEkshKGkeecr2ngjxvdlXoAjeLDZk+6t5L/mCNW
         mXD8Jvn1TSE3rQMxpoChvQcc6jqkc7PlNffj3V1RqWfPf1Fw8N5+6c97Dyex6CStCm9X
         Jl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899552; x=1691504352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2cfvhx3D7hiMArRKGhXMYYteYluRWre8IDEWIBOsHM=;
        b=UoTHkmgU/Ly4Ts3Ow++47vn4FgmEoiIU/BxhK43L/oxLaYGX28mjf7M3zw91O0BMMs
         Xhx9LqGlllxdPryFnE8JgMOJqs7aTHU4UNbE1o7HSJHoAML6h7f/C3KSvdKphLsOzmU9
         UcQGupoL/8jG257bL6hUCZTO+SQ5HbesMQA/8XIOTkYShTpQW+rR6ItZoSuDw6bWr3uj
         AZ5QNn4Qoe+H2pVGIqtzORkHmqMEOSyk5X8ZLLOm/41OALlXOa37WyHLnuA/fc1GcFiz
         OLFIISRncgeb94LP0Jk8rEFC7vtB8gpcqwrWijIW+bIEppl/SbaElJWDkkch1yYYsy0O
         lrBA==
X-Gm-Message-State: ABy/qLa3kxpD/527RYPS4E2603hjXuSUJoBs/RdJlX9Rv03srKJ8ZLGs
	gAokyIlIKJu36SNSyQUiHXaFY1tuk6M/iCmO73VI5w==
X-Google-Smtp-Source: APBJJlG4o7SOPNCXTpAxMa7EUt4cZAI3gkzp26oQoLXIhOSRaLxctFjt1quNTX84QP0naBHM7YxK7Q==
X-Received: by 2002:aa7:c919:0:b0:51e:166a:ac7f with SMTP id b25-20020aa7c919000000b0051e166aac7fmr2605559edt.28.1690899552800;
        Tue, 01 Aug 2023 07:19:12 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7d58d000000b005227b065a78sm7017014edq.70.2023.08.01.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:12 -0700 (PDT)
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
Subject: [patch net-next 2/8] ynl-gen-c.py: allow directional model for kernel mode
Date: Tue,  1 Aug 2023 16:19:01 +0200
Message-ID: <20230801141907.816280-3-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Directional model is only considered in uapi mode. No reason to forbid
directional model for kernel mode, so lift the limitation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/ynl-gen-c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1c36d0c935da..6f77c69fc410 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2317,7 +2317,7 @@ def main():
         return
 
     supported_models = ['unified']
-    if args.mode == 'user':
+    if args.mode in  ['user', 'kernel']:
         supported_models += ['directional']
     if parsed.msg_id_model not in supported_models:
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
-- 
2.41.0


