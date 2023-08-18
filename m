Return-Path: <netdev+bounces-28784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CC780AED
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448F7282362
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B8182B7;
	Fri, 18 Aug 2023 11:19:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC918031
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:19:34 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BB03AB4
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:19:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso7624665e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692357569; x=1692962369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=keSkFVFOG1xXMD2Ss8XWjzvdB6PzmAvHeqofcO2CUFU=;
        b=uF9HSyxZdrU8bMAF+Hzbpr5904qQqBl/bJ+w/Xlq1Szx8/pgjrc5B0jSfwTFRzEm4N
         XPWJRRuSZQ4NbQA9MV3ljVOVgj+dhGrcsmIvMT1bhEqyqKX1CFmW464ZtsWxuWToZlss
         vEXt1UZ2x7V5c0GKsfzR5xoLu0jKoZX5rU/J+EqhT3r281DbsYI1P0wlsHeAhnvZMiUH
         AN2+/UEvcthbvIe4bLTRL59WU4QEqZ2RC4m1neyCxMmZxxxsvjhZhn3UjqKwKVAONTVw
         ZloNNrlvWWC6ny+ljiO4Xxta32uAZU3eq4qI8Sl8pj6fMwR8WTeVmUK43RIuVtIwCs/x
         gR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692357569; x=1692962369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keSkFVFOG1xXMD2Ss8XWjzvdB6PzmAvHeqofcO2CUFU=;
        b=ekq7nFsCLpcbC8nK4ODDrsVqNajaY/zPyFLtcfEqbb/9QeJ1/DHVKSfolBeHJTNfhD
         m/pEowc90Q6UJhQHqibC3vm/DvLOdtur6pHR+j2CE7KpdOSeRxkWuiIgjxxR+tb+JT9x
         jIcpO6d+UkO3YFGWPk4yi/FcVS9+Jp0XXTBCYeKFWZ8IKkhu3fY9jTJqEE6Zwnn+mxWK
         MQtwygfqy+diivqrRLqWrAKth8lLovWKXzMv4BnNikM5Cm/YKfVAtu/rET8OnJURt3gi
         /D3DH9pE8dhA2ABaNGe4hC/kT6voh76Cpye48ueTdWtT/8jWx3//FSbhV3PKD67epLMD
         qh3Q==
X-Gm-Message-State: AOJu0YzphJKbzm6FjndWUFsEolekbdCi2TUD0luBVFx4jo83FqTjsbQD
	YbatFkPpLRAfEYXIe4bkIuv5v6UJrud07zuRRC68gA==
X-Google-Smtp-Source: AGHT+IEL9qpTUTqbLAc37QmG92g2/q9Aj7NqbyV1SMtgwOskN/MaN7F7sFmFZsC68bx0slhKNwZK7Q==
X-Received: by 2002:a5d:5109:0:b0:317:5b1b:1a40 with SMTP id s9-20020a5d5109000000b003175b1b1a40mr1626683wrt.49.1692357569025;
        Fri, 18 Aug 2023 04:19:29 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d4b8e000000b0031434c08bb7sm2430454wrt.105.2023.08.18.04.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 04:19:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] tools: ynl-gen: use temporary file for rendering
Date: Fri, 18 Aug 2023 13:19:27 +0200
Message-ID: <20230818111927.2237134-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Currently any error during render leads to output an empty file.
That is quite annoying when using tools/net/ynl/ynl-regen.sh
which git greps files with content of "YNL-GEN.." and therefore ignores
empty files. So once you fail to regen, you have to checkout the file.

Avoid that by rendering to a temporary file first, only at the end
copy the content to the actual destination.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/ynl-gen-c.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 5f39d2490655..bdff8dfc29c9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -5,6 +5,8 @@ import argparse
 import collections
 import os
 import re
+import shutil
+import tempfile
 import yaml
 
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
@@ -2304,7 +2306,7 @@ def main():
     parser.add_argument('-o', dest='out_file', type=str)
     args = parser.parse_args()
 
-    out_file = open(args.out_file, 'w+') if args.out_file else os.sys.stdout
+    tmp_file = tempfile.TemporaryFile('w+') if args.out_file else os.sys.stdout
 
     if args.header is None:
         parser.error("--header or --source is required")
@@ -2329,7 +2331,7 @@ def main():
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
         os.sys.exit(1)
 
-    cw = CodeWriter(BaseNlLib(), out_file)
+    cw = CodeWriter(BaseNlLib(), tmp_file)
 
     _, spec_kernel = find_kernel_root(args.spec)
     if args.mode == 'uapi' or args.header:
@@ -2578,6 +2580,10 @@ def main():
     if args.header:
         cw.p(f'#endif /* {hdr_prot} */')
 
+    if args.out_file:
+        out_file = open(args.out_file, 'w+')
+        tmp_file.seek(0)
+        shutil.copyfileobj(tmp_file, out_file)
 
 if __name__ == "__main__":
     main()
-- 
2.41.0


