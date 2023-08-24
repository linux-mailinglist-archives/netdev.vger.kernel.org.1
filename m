Return-Path: <netdev+bounces-30314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF5786DC3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6525128156F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA131DF49;
	Thu, 24 Aug 2023 11:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292712B61
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:36 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3710FA;
	Thu, 24 Aug 2023 04:20:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40061928e5aso12226605e9.3;
        Thu, 24 Aug 2023 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876029; x=1693480829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjfqjRgnje5cPHodoqa0yOt9g/nnGOz6OtgeJ4an+9k=;
        b=HqT30jT9I9v3xPcWik2GUImh6yPXLn/am2J3XlAVKkRhYfcyx9PU9zKgb2ecXbF48w
         Xic8/FFID36/Xwf25gJmN+fQQHQj9OyPXZxdIdnePIcRP+3HM58wffeYe6qF3Naohl/7
         4loSd3Ng7jyeRe2IU31671DQr3Qaipx3pOiyNxumnPougN4AJJjlbmwyPaVEIyq9gj6z
         rSclmXXb5MnwWIYKe2RY+fCT/iaw6I0LZudt/zRZu+8yZSrp8nYy+MpIiKc8JdG2iuqy
         zsYefw6qHg7TFoBizuLXff+wrdOaLWgY8pOTFMAThGKMIK3svKYARlfKaMKbXmzUZRsk
         x8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876029; x=1693480829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjfqjRgnje5cPHodoqa0yOt9g/nnGOz6OtgeJ4an+9k=;
        b=VRBW5TcbVVv8HHafAvTa/FcqvohLVj//8bcSX+54xQovIm5f+yRnSSVf/Cs1HmbW9/
         rco/ToYq/CBqsXgBkO+T7pgz8iP2BhsqjwwK9D2zuIQ79bTlra0ZFO/+VEC0xtvOUZ9W
         KoukWyB/UqnJxfAQIrNOgy+0DdpZQ+TQi/Q42SqFFK70RFBlSIU15O1SMkvDvmt0cjg9
         SZjpaywzr26KGw871OSQy0LuYbfHPpZQxHOg17UatowI6wOgT6EclA9wtyXF0Xhk0DUA
         MJ2z/d/I5hQ8adl1/vP8Xs7LSL7R/f58xpjjfhGeYH3FKZk3N8y4GkbmJR1s3cS4tn4x
         CFGA==
X-Gm-Message-State: AOJu0YyQnB1xvem2f3p9M4afz+lQVlwuvJZWiP72ka8vlhp4z/4K+IKe
	n6lJnrxojibj0xUsHki9OMBwlovWsVMzFQ==
X-Google-Smtp-Source: AGHT+IH5Ayoui4udJ8Ix3BrhMUupuZ1s5VBVfc8o+t1Y0Wb7FmaYPn6LR1uJiBit938hAIKCu0ioNQ==
X-Received: by 2002:a1c:ed09:0:b0:3f9:82f:bad1 with SMTP id l9-20020a1ced09000000b003f9082fbad1mr11689472wmh.40.1692876029300;
        Thu, 24 Aug 2023 04:20:29 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:28 -0700 (PDT)
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
Subject: [PATCH net-next v5 12/12] doc/netlink: Add spec for rt route messages
Date: Thu, 24 Aug 2023 12:20:03 +0100
Message-ID: <20230824112003.52939-13-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824112003.52939-1-donald.hunter@gmail.com>
References: <20230824112003.52939-1-donald.hunter@gmail.com>
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

Add schema for rt route with support for getroute, newroute and
delroute.

Routes can be dumped with filter attributes like this:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_route.yaml \
    --dump getroute --json '{"rtm-family": 2, "rtm-table": 254}'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/netlink/specs/rt_route.yaml | 327 ++++++++++++++++++++++
 1 file changed, 327 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_route.yaml

diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
new file mode 100644
index 000000000000..f4368be0caed
--- /dev/null
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -0,0 +1,327 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-route
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Route configuration over rtnetlink.
+
+definitions:
+  -
+    name: rtm-type
+    name-prefix: rtn-
+    type: enum
+    entries:
+      - unspec
+      - unicast
+      - local
+      - broadcast
+      - anycast
+      - multicast
+      - blackhole
+      - unreachable
+      - prohibit
+      - throw
+      - nat
+      - xresolve
+  -
+    name: rtmsg
+    type: struct
+    members:
+      -
+        name: rtm-family
+        type: u8
+      -
+        name: rtm-dst-len
+        type: u8
+      -
+        name: rtm-src-len
+        type: u8
+      -
+        name: rtm-tos
+        type: u8
+      -
+        name: rtm-table
+        type: u8
+      -
+        name: rtm-protocol
+        type: u8
+      -
+        name: rtm-scope
+        type: u8
+      -
+        name: rtm-type
+        type: u8
+        enum: rtm-type
+      -
+        name: rtm-flags
+        type: u32
+  -
+    name: rta-cacheinfo
+    type: struct
+    members:
+      -
+        name: rta-clntref
+        type: u32
+      -
+        name: rta-lastuse
+        type: u32
+      -
+        name: rta-expires
+        type: u32
+      -
+        name: rta-error
+        type: u32
+      -
+        name: rta-used
+        type: u32
+
+attribute-sets:
+  -
+    name: route-attrs
+    attributes:
+      -
+        name: rta-dst
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-src
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-iif
+        type: u32
+      -
+        name: rta-oif
+        type: u32
+      -
+        name: rta-gateway
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-priority
+        type: u32
+      -
+        name: rta-prefsrc
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-metrics
+        type: nest
+        nested-attributes: rta-metrics
+      -
+        name: rta-multipath
+        type: binary
+      -
+        name: rta-protoinfo # not used
+        type: binary
+      -
+        name: rta-flow
+        type: u32
+      -
+        name: rta-cacheinfo
+        type: binary
+        struct: rta-cacheinfo
+      -
+        name: rta-session # not used
+        type: binary
+      -
+        name: rta-mp-algo # not used
+        type: binary
+      -
+        name: rta-table
+        type: u32
+      -
+        name: rta-mark
+        type: u32
+      -
+        name: rta-mfc-stats
+        type: binary
+      -
+        name: rta-via
+        type: binary
+      -
+        name: rta-newdst
+        type: binary
+      -
+        name: rta-pref
+        type: u8
+      -
+        name: rta-encap-type
+        type: u16
+      -
+        name: rta-encap
+        type: binary # tunnel specific nest
+      -
+        name: rta-expires
+        type: u32
+      -
+        name: rta-pad
+        type: binary
+      -
+        name: rta-uid
+        type: u32
+      -
+        name: rta-ttl-propagate
+        type: u8
+      -
+        name: rta-ip-proto
+        type: u8
+      -
+        name: rta-sport
+        type: u16
+      -
+        name: rta-dport
+        type: u16
+      -
+        name: rta-nh-id
+        type: u32
+  -
+    name: rta-metrics
+    attributes:
+      -
+        name: rtax-unspec
+        type: unused
+        value: 0
+      -
+        name: rtax-lock
+        type: u32
+      -
+        name: rtax-mtu
+        type: u32
+      -
+        name: rtax-window
+        type: u32
+      -
+        name: rtax-rtt
+        type: u32
+      -
+        name: rtax-rttvar
+        type: u32
+      -
+        name: rtax-ssthresh
+        type: u32
+      -
+        name: rtax-cwnd
+        type: u32
+      -
+        name: rtax-advmss
+        type: u32
+      -
+        name: rtax-reordering
+        type: u32
+      -
+        name: rtax-hoplimit
+        type: u32
+      -
+        name: rtax-initcwnd
+        type: u32
+      -
+        name: rtax-features
+        type: u32
+      -
+        name: rtax-rto-min
+        type: u32
+      -
+        name: rtax-initrwnd
+        type: u32
+      -
+        name: rtax-quickack
+        type: u32
+      -
+        name: rtax-cc-algo
+        type: string
+      -
+        name: rtax-fastopen-no-cookie
+        type: u32
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: getroute
+      doc: Dump route information.
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 26
+          attributes:
+            - rtm-family
+            - rta-src
+            - rtm-src-len
+            - rta-dst
+            - rtm-dst-len
+            - rta-iif
+            - rta-oif
+            - rta-ip-proto
+            - rta-sport
+            - rta-dport
+            - rta-mark
+            - rta-uid
+        reply:
+          value: 24
+          attributes: &all-route-attrs
+            - rtm-family
+            - rtm-dst-len
+            - rtm-src-len
+            - rtm-tos
+            - rtm-table
+            - rtm-protocol
+            - rtm-scope
+            - rtm-type
+            - rtm-flags
+            - rta-dst
+            - rta-src
+            - rta-iif
+            - rta-oif
+            - rta-gateway
+            - rta-priority
+            - rta-prefsrc
+            - rta-metrics
+            - rta-multipath
+            - rta-flow
+            - rta-cacheinfo
+            - rta-table
+            - rta-mark
+            - rta-mfc-stats
+            - rta-via
+            - rta-newdst
+            - rta-pref
+            - rta-encap-type
+            - rta-encap
+            - rta-expires
+            - rta-pad
+            - rta-uid
+            - rta-ttl-propagate
+            - rta-ip-proto
+            - rta-sport
+            - rta-dport
+            - rta-nh-id
+      dump:
+        request:
+          value: 26
+          attributes:
+            - rtm-family
+        reply:
+          value: 24
+          attributes: *all-route-attrs
+    -
+      name: newroute
+      doc: Create a new route
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 24
+          attributes: *all-route-attrs
+    -
+      name: delroute
+      doc: Delete an existing route
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 25
+          attributes: *all-route-attrs
-- 
2.39.2 (Apple Git-143)


