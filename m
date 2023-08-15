Return-Path: <netdev+bounces-27804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABC77D387
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAC128150F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6919BAD;
	Tue, 15 Aug 2023 19:43:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F998198B5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:42 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5010C1;
	Tue, 15 Aug 2023 12:43:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe490c05c9so39499105e9.0;
        Tue, 15 Aug 2023 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128619; x=1692733419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXA9U813FnAWD4PJve2CXlaLWAIglzuQR7ZCqQRSFQU=;
        b=bNrtfCkQRIpMcMG/2YEHuELjJWlZATUFc2qa7QC8u12GPeNq5NrH6qsSqzQhMc9bO9
         KKVJ5a1y2gNRi5kOjKMWvF18HVERo1TNVl1y9Ax6IrZ/+pvqj/B1rpHo1dJhBTKD0seI
         ElY31jtxvpCXzlLvC/9EiXmRAWsR074YZ0IeFwgGRKgdOyIdCz7R5jCWW1G5nYebGV8c
         aaVtwXzrEqadb8i2Fy0oqZXsE3wdT3O6LFK16r12iIc2Qb0Y2LBB75CMlE5iFB6Ss1Qm
         IUoQAGeQF4AqtKw4xIM0XW75ycYnCXHjJ3Dfj9o4x8bMjy3V4hkSYpDe/gj4xwqr454a
         s8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128619; x=1692733419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXA9U813FnAWD4PJve2CXlaLWAIglzuQR7ZCqQRSFQU=;
        b=MeUzws5CHmJMnJ3uCJhELUv/Z1KZpbel4xDhCmMTBF9Rs+61lKoMmMffREtFyHXnZa
         fPGJiUjFrD2qo9O6e4xvNwTYB5auNrLnILHDixzWkR6lX7sQLOXOtISDUsAWS5U2OdL2
         dlSP1W9YVyIc7cJGZzwFO5+OIjbdz+Ni9qBcpaEkVcYZIA2Kx/Ypsod9UNFvUr8nGz+N
         v474QTQkJ33XqEfXX6zWTRFpgVMCeWH4Fnvafjx4HqHYrzjbDeY62Z5Avf+Nq/dMrrNH
         GI55fqIofijltrL8pZ5KSBcoHf8kYCA4SBQ4zqE+Xi52trL0mMPhsUhBELud1zg6Z+Wp
         cizw==
X-Gm-Message-State: AOJu0Yyl0bmSSCnxFZx/IlWCSeeTTYQX8VFFJVK5CXW0aSMZOgdSryLy
	1jmf/hiNGDT0OiAh1UheML9LjNknGUI8oXBT
X-Google-Smtp-Source: AGHT+IEniH0DBVSNyAt3o0n/OxjyUXL6ApdAtQBj7gh7bWMN9gr2SATcu6UbpqTkXN4LYF6LC/VQaQ==
X-Received: by 2002:a7b:cb96:0:b0:3fc:1a6:79a9 with SMTP id m22-20020a7bcb96000000b003fc01a679a9mr2415052wmi.16.1692128619090;
        Tue, 15 Aug 2023 12:43:39 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:38 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 07/10] tools/net/ynl: Implement nlattr array-nest decoding in ynl
Date: Tue, 15 Aug 2023 20:42:51 +0100
Message-ID: <20230815194254.89570-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815194254.89570-1-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the 'array-nest' attribute type that is used by several
netlink-raw families.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 325dc0d9c5b5..cd983d1f2ee6 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -504,6 +504,17 @@ class YnlFamily(SpecFamily):
                 decoded = NlAttr.formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
+    def _decode_array_nest(self, attr, attr_spec):
+        decoded = []
+        offset = 0
+        while offset < len(attr.raw):
+            item = NlAttr(attr.raw, offset)
+            offset += item.full_len
+
+            subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
+            decoded.append({ item.type: subattrs })
+        return decoded
+
     def _decode(self, attrs, space):
         attr_space = self.attr_sets[space]
         rsp = dict()
@@ -520,6 +531,8 @@ class YnlFamily(SpecFamily):
                 decoded = True
             elif attr_spec["type"] in NlAttr.type_formats:
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
+            elif attr_spec["type"] == 'array-nest':
+                decoded = self._decode_array_nest(attr, attr_spec)
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
-- 
2.41.0


