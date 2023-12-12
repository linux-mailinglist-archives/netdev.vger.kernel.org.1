Return-Path: <netdev+bounces-56618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A966D80FA03
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1041F2123E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670A7E79C;
	Tue, 12 Dec 2023 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzb3jZ5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF78AA;
	Tue, 12 Dec 2023 14:16:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33338c47134so5736820f8f.1;
        Tue, 12 Dec 2023 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419389; x=1703024189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27uWkbmkyJPi62oM04ESj5+OaIZhxLf9WPx67Wq2coQ=;
        b=Rzb3jZ5lRRveusYh5ixAO0Ymr92DONNFxxqoUj3P7prbpo4alTgC//bUFR/lCwCWAz
         zIm4pecrDjp3C3xh9mNWYkdkfgCp88a0/mv37p3/mxuSAWRkdQyBhJKtFiCxQAdi1uM5
         Om+5FncMq8gXcSl63ElXWXv+qILR1M3zfgeAljiGWnPERvRhi+2BQr8eXecJ/lWx5wCu
         FHg39mBiltx6mJFbhl/laErI0i/LcTlP7lLOXGY4k+77RPG6Vjti6NtZE/M6QCLNtxt5
         IPtH2Xs2UJ7oO1MDxkBSqRHeTOW/PLEYcZn0cOY1Ou452Ldmsey7e+knRI1nLTHc6sjv
         tjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419389; x=1703024189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27uWkbmkyJPi62oM04ESj5+OaIZhxLf9WPx67Wq2coQ=;
        b=IWZfzf3503XVXmVChpdnOe8KMpxO28H3JIdMf7nADI+yPme4X/KtIMHU87OwzGRqqs
         u8LIgeZtJZGb4RAjLdBtK5hN/5JQDf7OZviz2NhDB6Mwufm17PPYMvTrbKrUQwjSaN3+
         0GIjHgNPPbb5wce6DxvTtINiQlYC63hSkZUUApY2rCwOBu5v/n9DQ2TIm1l+tyDto6+8
         kLhNlsmIxZH3hfVsiaAM1a7h8nnIO7dbRu0Q8MLYzXLUCeU19abrE508agq3kM08Mdk3
         XidqS6ZwkAZGkxiXuTxX+rtgNo6MgBti3JFg/6n6Gv9h7xZemilCizxI7A8kxGt/0dDp
         HoPA==
X-Gm-Message-State: AOJu0Yw1or3jnCw5q/aY1CysfqcM0tQPmClTxoGUMeVBQU07gRZQ6P84
	xnk90eY+RC4LGDNmD9wNfZCvbMBijO2wFQ==
X-Google-Smtp-Source: AGHT+IF2kgyUc1PwfVXnQlq8Of5H82IJlIFU1ZFjrpaGZGcpNZ8vaXl3JWedDyx1efAx7yWUJpA9tQ==
X-Received: by 2002:adf:fd08:0:b0:333:533d:9ceb with SMTP id e8-20020adffd08000000b00333533d9cebmr3731842wrr.1.1702419388814;
        Tue, 12 Dec 2023 14:16:28 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:28 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 02/13] doc/netlink: Add sub-message support to netlink-raw
Date: Tue, 12 Dec 2023 22:15:41 +0000
Message-ID: <20231212221552.3622-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a 'sub-message' attribute type with a selector that supports
polymorphic attribute formats for raw netlink families like tc.

A sub-message attribute uses the value of another attribute as a
selector key to choose the right sub-message format. For example if the
following attribute has already been decoded:

  { "kind": "gre" }

and we encounter the following attribute spec:

  -
    name: data
    type: sub-message
    sub-message: linkinfo-data-msg
    selector: kind

Then we look for a sub-message definition called 'linkinfo-data-msg' and
use the value of the 'kind' attribute i.e. 'gre' as the key to choose
the correct format for the sub-message:

  sub-messages:
    name: linkinfo-data-msg
    formats:
      -
        value: bridge
        attribute-set: linkinfo-bridge-attrs
      -
        value: gre
        attribute-set: linkinfo-gre-attrs
      -
        value: geneve
        attribute-set: linkinfo-geneve-attrs

This would decode the attribute value as a sub-message with the
attribute-set called 'linkinfo-gre-attrs' as the attribute space.

A sub-message can have an optional 'fixed-header' followed by zero or
more attributes from an attribute-set. For example the following
'tc-options-msg' sub-message defines message formats that use a mixture
of fixed-header, attribute-set or both together:

  sub-messages:
    -
      name: tc-options-msg
      formats:
        -
          value: bfifo
          fixed-header: tc-fifo-qopt
        -
          value: cake
          attribute-set: tc-cake-attrs
        -
          value: netem
          fixed-header: tc-netem-qopt
          attribute-set: tc-netem-attrs

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/netlink-raw.yaml | 65 ++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ad5395040765..04b92f1a5cd6 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -126,8 +126,10 @@ properties:
               name:
                 type: string
               type:
-                description: The netlink attribute type
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+                description: |
+                  The netlink attribute type. Members of type 'binary' or 'pad'
+                  must also have the 'len' property set.
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, pad ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
@@ -150,6 +152,14 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+            if:
+              properties:
+                type:
+                  oneOf:
+                    - const: binary
+                    - const: pad
+            then:
+              required: [ len ]
         # End genetlink-legacy
 
   attribute-sets:
@@ -202,7 +212,8 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         u8, u16, u32, u64, s8, s16, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, array-nest, nest-type-value,
+                        sub-message ]
               doc:
                 description: Documentation of the attribute.
                 type: string
@@ -261,6 +272,17 @@ properties:
                 description: Name of the struct type used for the attribute.
                 type: string
               # End genetlink-legacy
+              # Start netlink-raw
+              sub-message:
+                description: |
+                  Name of the sub-message definition to use for the attribute.
+                type: string
+              selector:
+                description: |
+                  Name of the attribute to use for dynamic selection of sub-message
+                  format specifier.
+                type: string
+              # End netlink-raw
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
@@ -283,6 +305,43 @@ properties:
             items:
               required: [ type ]
 
+  # Start netlink-raw
+  sub-messages:
+    description: Definition of sub message attributes
+    type: array
+    items:
+      type: object
+      additionalProperties: False
+      required: [ name, formats ]
+      properties:
+        name:
+          description: Name of the sub-message definition
+          type: string
+        formats:
+          description: Dynamically selected format specifiers
+          type: array
+          items:
+            type: object
+            additionalProperties: False
+            required: [ value ]
+            properties:
+              value:
+                description: |
+                  Value to match for dynamic selection of sub-message format
+                  specifier.
+                type: string
+              fixed-header:
+                description: |
+                  Name of the struct definition to use as the fixed header
+                  for the sub message.
+                type: string
+              attribute-set:
+                description: |
+                  Name of the attribute space from which to resolve attributes
+                  in the sub message.
+                type: string
+  # End netlink-raw
+
   operations:
     description: Operations supported by the protocol.
     type: object
-- 
2.42.0


