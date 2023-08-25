Return-Path: <netdev+bounces-30661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243B788779
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325841C20FE7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20478101C8;
	Fri, 25 Aug 2023 12:29:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E6101C2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:12 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0E271B;
	Fri, 25 Aug 2023 05:28:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fee8b78097so7659825e9.0;
        Fri, 25 Aug 2023 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966500; x=1693571300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgFxz6c7G9zGaCUht47lmD9+ThAV4YgMBfvso9jo/Po=;
        b=JaMBs3JygI/K+3ipCwFPyH8IwzkAwWNBdC0LvHOC3JIqgmvWoqq6+NV2o/xUL/+/ne
         gsjPsGXoFn8csRQ6ZbAn1kMYUiol4Wl3owwhOquVFXLYpJZmGxtqddMCK8AaENc9Oddg
         Pu4tTq/0I+i3zje1X/mLQkKKN/tfzcm5rGzuyUO3AYeotnCRG229p9sDz0wxfKq6gHtw
         zUsEIka8M0vd6Te0FUxDOKh1ZtOiINswoXPVSQ9Oo0aBVn1d8tQ0pIVKXQAbsNGr+9Py
         KGRTMi3/5nIaq3dQImoHLfV0SO8mTEi3VVBRIjRsq5cLfT4uBMGnFk3zzZXnjZ63cYTA
         f03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966500; x=1693571300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgFxz6c7G9zGaCUht47lmD9+ThAV4YgMBfvso9jo/Po=;
        b=LZo2YAdOhb0flKb1oXy8SX/t/lVw+qdXY7UYAB12X6W5AYvfNGImwqNEfVa6NTnSQN
         HWFLux6Bh7GO/G7UOkyRzd3kFwkeemyV3fmk44wVy/RhF8BCJZkEs9E9MtMlrw0vDvww
         Ey/i+47zEcR/rzLN1c5JvpC48KipGT4FR+iExGGhxEwRHnAJ8Oi7JRXZ6mbX98+NiF96
         1197a2gqlOJsXNTxWi4xZlhxTt+TV1dwR506X2wIUtyqCPD5g9pGChs1FhrTEYE7Nr4l
         5EeI1PnUmIWEVcA4p9wMqLYADcsqBmvvMbbv31n8xLWMPpmS65QoQmexAjwM7K7h1NM+
         k8YA==
X-Gm-Message-State: AOJu0Yza4WywMEzNz6NTz0hvI1/dmFrj26m6kkWgiGYDa+uP5/5BfEav
	XWCoA7NBuCmJkb6ozbeMVWG/FX3TZADODQ==
X-Google-Smtp-Source: AGHT+IH6+ssp0gDBeVMs3bsf+sbdEtW8SJ6tP92EiOGDU1yNVal5tPKqrohLMjddsgcHrm17FwPW5w==
X-Received: by 2002:a7b:cc93:0:b0:3fe:f74c:b4f6 with SMTP id p19-20020a7bcc93000000b003fef74cb4f6mr8689528wma.17.1692966499973;
        Fri, 25 Aug 2023 05:28:19 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:19 -0700 (PDT)
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
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 10/12] doc/netlink: Add spec for rt addr messages
Date: Fri, 25 Aug 2023 13:27:53 +0100
Message-ID: <20230825122756.7603-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825122756.7603-1-donald.hunter@gmail.com>
References: <20230825122756.7603-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add schema for rt addr with support for:
     - newaddr, deladdr, getaddr (dump)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/netlink/specs/rt_addr.yaml | 179 +++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
new file mode 100644
index 000000000000..cbee1cedb177
--- /dev/null
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-addr
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Address configuration over rtnetlink.
+
+definitions:
+  -
+    name: ifaddrmsg
+    type: struct
+    members:
+      -
+        name: ifa-family
+        type: u8
+      -
+        name: ifa-prefixlen
+        type: u8
+      -
+        name: ifa-flags
+        type: u8
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: ifa-scope
+        type: u8
+      -
+        name: ifa-index
+        type: u32
+  -
+    name: ifa-cacheinfo
+    type: struct
+    members:
+      -
+        name: ifa-prefered
+        type: u32
+      -
+        name: ifa-valid
+        type: u32
+      -
+        name: cstamp
+        type: u32
+      -
+        name: tstamp
+        type: u32
+
+  -
+    name: ifa-flags
+    type: flags
+    entries:
+      -
+        name: secondary
+      -
+        name: nodad
+      -
+        name: optimistic
+      -
+        name: dadfailed
+      -
+        name: homeaddress
+      -
+        name: deprecated
+      -
+        name: tentative
+      -
+        name: permanent
+      -
+        name: managetempaddr
+      -
+        name: noprefixroute
+      -
+        name: mcautojoin
+      -
+        name: stable-privacy
+
+attribute-sets:
+  -
+    name: addr-attrs
+    attributes:
+      -
+        name: ifa-address
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-local
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-label
+        type: string
+      -
+        name: ifa-broadcast
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-anycast
+        type: binary
+      -
+        name: ifa-cacheinfo
+        type: binary
+        struct: ifa-cacheinfo
+      -
+        name: ifa-multicast
+        type: binary
+      -
+        name: ifa-flags
+        type: u32
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: ifa-rt-priority
+        type: u32
+      -
+        name: ifa-target-netnsid
+        type: binary
+      -
+        name: ifa-proto
+        type: u8
+
+
+operations:
+  fixed-header: ifaddrmsg
+  enum-model: directional
+  list:
+    -
+      name: newaddr
+      doc: Add new address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 20
+          attributes: &ifaddr-all
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - ifa-address
+            - ifa-label
+            - ifa-local
+            - ifa-cacheinfo
+    -
+      name: deladdr
+      doc: Remove address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 21
+          attributes:
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - ifa-address
+            - ifa-local
+    -
+      name: getaddr
+      doc: Dump address information.
+      attribute-set: addr-attrs
+      dump:
+        request:
+          value: 22
+          attributes:
+            - ifa-index
+        reply:
+          value: 20
+          attributes: *ifaddr-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-ifaddr
+      value: 5
+    -
+      name: rtnlgrp-ipv6-ifaddr
+      value: 9
-- 
2.41.0


