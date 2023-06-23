Return-Path: <netdev+bounces-13542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193C73BF61
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429E11C2130D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172F1097C;
	Fri, 23 Jun 2023 20:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED210965
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:20:30 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1521A1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4009130358cso3546491cf.2
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687551627; x=1690143627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NgGibosWgwXZWCvlEufPEdWqtxqzB4K6Z81fqz2pho=;
        b=ErmaKSRuPyBdeZPmtZUXCMHv9U+mTNj7iqf9dV8OYcN6tVgK5qubDzk8/60JqWG0R6
         YbBcFsjjl8q60VQzit5rKkQApW/qFhtSbCR8/IQs6Pz5DERcR/StYkbNZwYKuuQZt9Gd
         s/TStK3oZ8Md+v3RpuPaFt0jgy6LWUiPIhxCxsLXrh6tuxikB/WMxGI7V/31pCgkiIZS
         YOQQwcuYAvgbPNfKat3aHjQluhdTRA70j8oZwkGsWSZKRUXDBGazXeu4swhtaYwiBN7P
         1gxz0m776n68XAT6JvutfslZ6jVgSrJY0i6Nwvt7uz0EyJMVQkBBhQBCiPYjX/GSsnpq
         Qy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551627; x=1690143627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NgGibosWgwXZWCvlEufPEdWqtxqzB4K6Z81fqz2pho=;
        b=a3vLV8H7CtvZfYJSdNbkw6ZyI7TMiOsnBrLQS1W6cMjL4M9pYjzwxwt+tvb3R0/NGd
         kUIucqgSlDDOvp7lkjIVl/paUZnIJFKuCPRpO2pjwI7MppBu5Hs3YJw4zKJvFdTpNXSJ
         8GU+Na6/1NjLySGb+7A+rWeMwvBuHWg0GQe9OT/kZML59jmt2RsJ6o0bjzvF+efl2uxm
         Qpra9hJJK7+5/71cJF8WHOOeH6AcYyWHu51iLJPEcdlSvohdx5LjIYZHt+g97fEiVONK
         ouqYzJ5PvCik4uvcHHaSGrTnLbztkirZb+UvCkSO7J+4g4+kqkK2vz0BM8i0oVfp3SBf
         IA5A==
X-Gm-Message-State: AC+VfDzDQRPCwuTeoOSdGhF3ZAPPUSgIPQfsJt2lAlAAUGw9PKYeBnNP
	kJXZ4thz4BsOh8LQfG4ZImWlxMBnUTMuQg==
X-Google-Smtp-Source: ACHHUZ4c7MGu4/kha55ZY/1DTsYYApqnF1XPaZqztA0idB4Rx9pckJRFhXPI3UtLnp7mdE+P/dSoig==
X-Received: by 2002:a05:622a:611:b0:3fd:d376:d9bb with SMTP id z17-20020a05622a061100b003fdd376d9bbmr27619069qta.18.1687551627554;
        Fri, 23 Jun 2023 13:20:27 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003ff0d00a71esm2274152qtw.13.2023.06.23.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:20:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/3] netlink: specs: add display-hint to schema definitions
Date: Fri, 23 Jun 2023 21:19:26 +0100
Message-Id: <20230623201928.14275-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230623201928.14275-1-donald.hunter@gmail.com>
References: <20230623201928.14275-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a display-hint property to the netlink schema that is for providing
optional hints to generic netlink clients about how to display attribute
values. A display-hint on an attribute definition is intended for
letting a client such as ynl know that, for example, a u32 should be
rendered as an ipv4 address. The display-hint enumeration includes a
small number of networking domain-specific value types.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      |  6 ++++++
 Documentation/netlink/genetlink-legacy.yaml | 11 ++++++++++-
 Documentation/netlink/genetlink.yaml        |  6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 0519c257ecf4..57d1c1c4918f 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -195,6 +195,12 @@ properties:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
+              display-hint: &display-hint
+                description: |
+                  Optional format indicator that is intended only for choosing
+                  the right formatting mechanism when displaying values of this
+                  type.
+                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
               # Start genetlink-c
               name-prefix:
                 type: string
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index b474889b49ff..43b769c98fb2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -119,7 +119,8 @@ properties:
               name:
                 type: string
               type:
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string ]
+                description: The netlink attribute type
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
@@ -130,6 +131,12 @@ properties:
               enum:
                 description: Name of the enum type used for the attribute.
                 type: string
+              display-hint: &display-hint
+                description: |
+                  Optional format indicator that is intended only for choosing
+                  the right formatting mechanism when displaying values of this
+                  type.
+                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
         # End genetlink-legacy
 
   attribute-sets:
@@ -179,6 +186,7 @@ properties:
               name:
                 type: string
               type: &attr-type
+                description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
@@ -226,6 +234,7 @@ properties:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
+              display-hint: *display-hint
               # Start genetlink-c
               name-prefix:
                 type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index d8b2cdeba058..1cbb448d2f1c 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -168,6 +168,12 @@ properties:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
+              display-hint: &display-hint
+                description: |
+                  Optional format indicator that is intended only for choosing
+                  the right formatting mechanism when displaying values of this
+                  type.
+                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
-- 
2.39.0


