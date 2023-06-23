Return-Path: <netdev+bounces-13544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E673BF66
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C131C21358
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CF11C9B;
	Fri, 23 Jun 2023 20:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DC11C82
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:20:33 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD399B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7653bd3ff2fso91930285a.3
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687551631; x=1690143631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KXRmwGlX26l6IoJaqpuWsvFXl//DVOiUglxpZ5psQI=;
        b=M5p3NoHm07kG+oLLAlNOWfxMIxXHTC8VSIj3a/ad6EgSlkkoninYG+D2g0hJuS0Gzh
         IRtqQajc0HtpXlkkGwv3ShU9ur2Ksk7ChxwG/oPYm7Ug6bId9N0ujgS14bLwkQ2pj+pO
         8rakYs4rQcxoid9wMITiOK4iZoRPbZllY17hv5lu7dztgavVv7i8rGnuUc5UTEmqU1to
         xxcmBsLD3BsW/bSy76NScXbH+0TgsK4y4PMXgbifxX2IxopFI3FEANXzxTVxHujuhZmZ
         fSLsi7MUW9FYYNRq4dmFWE/zrWUXu1kXThk8SWzkYYYHIjpZQXEB3Kdxg1HZujTKrG1e
         PsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551631; x=1690143631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KXRmwGlX26l6IoJaqpuWsvFXl//DVOiUglxpZ5psQI=;
        b=f5gel2L3UTPE6PmjMwjhH4iNRzYyDSX4XAKIVwjGhucv2jjEKWsijlm9PfNSPp9snL
         T2wYpraIjY+Hz5kGLiWnBlnifdPyERWLHLrVttNBplV6iRguZ92jJ15ZNKq3sQgXxCJ6
         ASWs8jTByAOlzEJPZQkyHHik0VKK5mo7zI74nIBya1c7cSrGi3bYsVPiPY23Ol6p0CB0
         GBVudnkrZXVMILnqamttkE7eiLctXt6fwFfvQcv26MEc9xU8hIGyryyPE6TjkVLHDCBi
         ImyuT8X5x6fogS+SE2Kd1qksb6vpNdjh7U3np2qJOsn+kRiDsyAN7t+HoQ6IRLlMmTAh
         2JYQ==
X-Gm-Message-State: AC+VfDx9WbZhPoI10pWH6J9pls6Ct5mGaA+rRGSAK8eeSyZxXrB2d3+k
	aSvDZB9ui4I6MR4SIaZKU/lbbdHTO3axJw==
X-Google-Smtp-Source: ACHHUZ7j6Q4nIGtLGV1GfbizE7ldFv+aNitX9mctnb8wwkXya/954jFEgbFLFfUzcAEvStA62+7wiA==
X-Received: by 2002:a05:622a:194:b0:400:92bd:9e96 with SMTP id s20-20020a05622a019400b0040092bd9e96mr180146qtw.67.1687551630958;
        Fri, 23 Jun 2023 13:20:30 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003ff0d00a71esm2274152qtw.13.2023.06.23.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:20:30 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/3] netlink: specs: add display hints to ovs_flow
Date: Fri, 23 Jun 2023 21:19:28 +0100
Message-Id: <20230623201928.14275-4-donald.hunter@gmail.com>
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

Add display hints for mac, ipv4, ipv6, hex and uuid to the ovs_flow
schema.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 107 ++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 1ecbcd117385..109ca1f57b6c 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -33,6 +33,20 @@ definitions:
         name: n-bytes
         type: u64
         doc: Number of matched bytes.
+  -
+    name: ovs-key-ethernet
+    type: struct
+    members:
+      -
+        name: eth-src
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: eth-dst
+        type: binary
+        len: 6
+        display-hint: mac
   -
     name: ovs-key-mpls
     type: struct
@@ -49,10 +63,12 @@ definitions:
         name: ipv4-src
         type: u32
         byte-order: big-endian
+        display-hint: ipv4
       -
         name: ipv4-dst
         type: u32
         byte-order: big-endian
+        display-hint: ipv4
       -
         name: ipv4-proto
         type: u8
@@ -66,6 +82,45 @@ definitions:
         name: ipv4-frag
         type: u8
         enum: ovs-frag-type
+  -
+    name: ovs-key-ipv6
+    type: struct
+    members:
+      -
+        name: ipv6-src
+        type: binary
+        len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: ipv6-dst
+        type: binary
+        len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: ipv6-label
+        type: u32
+        byte-order: big-endian
+      -
+        name: ipv6-proto
+        type: u8
+      -
+        name: ipv6-tclass
+        type: u8
+      -
+        name: ipv6-hlimit
+        type: u8
+      -
+        name: ipv6-frag
+        type: u8
+  -
+    name: ovs-key-ipv6-exthdrs
+    type: struct
+    members:
+      -
+        name: hdrs
+        type: u16
   -
     name: ovs-frag-type
     name-prefix: ovs-frag-type-
@@ -129,6 +184,51 @@ definitions:
       -
         name: icmp-code
         type: u8
+  -
+    name: ovs-key-arp
+    type: struct
+    members:
+      -
+        name: arp-sip
+        type: u32
+        byte-order: big-endian
+      -
+        name: arp-tip
+        type: u32
+        byte-order: big-endian
+      -
+        name: arp-op
+        type: u16
+        byte-order: big-endian
+      -
+        name: arp-sha
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: arp-tha
+        type: binary
+        len: 6
+        display-hint: mac
+  -
+    name: ovs-key-nd
+    type: struct
+    members:
+      -
+        name: nd_target
+        type: binary
+        len: 16
+        byte-order: big-endian
+      -
+        name: nd-sll
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: nd-tll
+        type: binary
+        len: 6
+        display-hint: mac
   -
     name: ovs-key-ct-tuple-ipv4
     type: struct
@@ -345,6 +445,7 @@ attribute-sets:
           value of the OVS_FLOW_ATTR_KEY attribute. Optional for all
           requests. Present in notifications if the flow was created with this
           attribute.
+        display-hint: uuid
       -
         name: ufid-flags
         type: u32
@@ -374,6 +475,7 @@ attribute-sets:
       -
         name: ethernet
         type: binary
+        struct: ovs-key-ethernet
         doc: struct ovs_key_ethernet
       -
         name: vlan
@@ -390,6 +492,7 @@ attribute-sets:
       -
         name: ipv6
         type: binary
+        struct: ovs-key-ipv6
         doc: struct ovs_key_ipv6
       -
         name: tcp
@@ -410,10 +513,12 @@ attribute-sets:
       -
         name: arp
         type: binary
+        struct: ovs-key-arp
         doc: struct ovs_key_arp
       -
         name: nd
         type: binary
+        struct: ovs-key-nd
         doc: struct ovs_key_nd
       -
         name: skb-mark
@@ -457,6 +562,7 @@ attribute-sets:
       -
         name: ct-labels
         type: binary
+        display-hint: hex
         doc: 16-octet connection tracking label
       -
         name: ct-orig-tuple-ipv4
@@ -486,6 +592,7 @@ attribute-sets:
       -
         name: ipv6-exthdrs
         type: binary
+        struct: ovs-key-ipv6-exthdrs
         doc: struct ovs_key_ipv6_exthdr
   -
     name: action-attrs
-- 
2.39.0


