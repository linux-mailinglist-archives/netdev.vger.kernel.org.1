Return-Path: <netdev+bounces-27799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC677D374
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398E32814D3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272818AEB;
	Tue, 15 Aug 2023 19:43:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC01805D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:36 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36B10EC;
	Tue, 15 Aug 2023 12:43:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3178dd771ceso5116541f8f.2;
        Tue, 15 Aug 2023 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128613; x=1692733413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ6MSqKSG4VDbBY3Ml3NZpJP7+4pxYoFOTAuqiAIKcM=;
        b=HasmAn0dMuhojznORZajoyzRaW+8/M4knHqV6rYKfdwAUwmut4LqJsh9PDkB/Wq2is
         ud8nTtIANVSaASebAruGPVJMl7irX82sJXsulVY9ff5wXf2o02jPKJ76YAPxX1jlDng2
         PIf+IGzT2iLxH3JEYE+gnfpuJSS2mGA+xJyIm5X/j2Yki82aP6wsbxtF5txb4shTzt1c
         kNGFJB9QRY8ii2M0lArHhbiqLQUC7eYFzAi+8HOIEYgaMq0zIeAf0aQv8qWcIJhs0Z52
         y1vBbvPDV0nETSsHyct7EQcSgvlHPDSrykoilF27Y2inZBqsbwfi4DvW1EZgnNx+8gIa
         1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128613; x=1692733413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ6MSqKSG4VDbBY3Ml3NZpJP7+4pxYoFOTAuqiAIKcM=;
        b=H2v583By0Fh/thm6tYdkdRY2N014SexMSeM0rtP/8WzPs+55rd9H1yCx8n7My4/JlG
         i1tFRBKNfaG/Gm96b37/mvnVee8hglYxuD+ujp3l9op5Bb+Rmb3jGTVqFUl4u9wJO3/T
         tBBywkKLp4dy4RseitPpWFnFAeUedZIjzhw9tSHgKPfSbfaCtBOH4uRkzCBqThK+BrRM
         HMKKALxNB0Y6yylJt2yGA6myhl5P8H4YvMmPct5SDQLyg1p5cj4UBjihRUwRY+2sxZwl
         zas0prWBrot3GgNnipEK01sDNuFqlKN6MtbJ7eW0gL1vhA3d4gqdxnVcCvywxB8AnrD/
         aXiw==
X-Gm-Message-State: AOJu0YyFzqvz+zkQQhTaWma/mB1SHcKRQkYKVh0sFT1jULxIHLtNKg+R
	oj0EFpHLrWmERtgL5qwOFro3Cx/DyXIVqIve
X-Google-Smtp-Source: AGHT+IEsUDkz9X21kr8hsqAmcX7t8hx++rvo+XjF64s1RpulX6DE9NEUyQ5CvNl8DdyA+MzhS+tFdQ==
X-Received: by 2002:a5d:4d0a:0:b0:317:70da:abdd with SMTP id z10-20020a5d4d0a000000b0031770daabddmr8806549wrt.59.1692128613166;
        Tue, 15 Aug 2023 12:43:33 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/10] doc/netlink: Document the genetlink-legacy schema extensions
Date: Tue, 15 Aug 2023 20:42:46 +0100
Message-ID: <20230815194254.89570-3-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add description of genetlink-legacy specific attributes to the ynl spec
documentation.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/userspace-api/netlink/specs.rst | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index 2e4acde890b7..dde70f9674d4 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -443,3 +443,50 @@ nest
 
 Attribute containing other (nested) attributes.
 ``nested-attributes`` specifies which attribute set is used inside.
+
+genetlink-legacy
+================
+
+The genetlink-legacy schema extends the genetlink schema with some additional
+properties that are needed to support legacy genetlink families.
+
+Globals
+-------
+
+ - ``kernel-policy`` - Specify whether the kernel input policy is ``global``,
+   ``per-op`` or ``split``.
+
+Struct definitions
+------------------
+
+There is a new type of definition called ``struct`` which is used for declaring
+the C struct format of fixed headers and binary attributes.
+
+members
+~~~~~~~
+
+ - ``name`` - The attribute name of the struct member
+ - ``type`` - One of the scalar types ``u8``, ``u16``, ``u32``, ``u64``, ``s8``,
+   ``s16``, ``s32``, ``s64``, ``string`` or ``binary``.
+ - ``byte-order`` - ``big-endian`` or ``little-endian``
+ - ``doc``, ``enum``, ``enum-as-flags``, ``display-hint`` - Same as for
+   attribute definitions.
+
+Attributes
+----------
+
+The genetlink-legacy families can use binary attributes that contain C struct
+data. This is specified using a ``struct`` property containing the name of the
+struct definition.
+
+ - ``struct`` - Name of the struct definition to be used for the attribute.
+
+Operations
+----------
+
+The genetlink-legacy families can use a binary fixed header that contains C
+struct data.
+
+ - ``fixed-header`` - name of the struct definition to be used for the fixed
+   header data. This can be specified as a default for all operations and on a
+   per-operation basis.
-- 
2.41.0


