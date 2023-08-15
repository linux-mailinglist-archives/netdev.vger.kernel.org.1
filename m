Return-Path: <netdev+bounces-27806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00A77D38A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404B61C20DF8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799D1AA7D;
	Tue, 15 Aug 2023 19:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7681AA70
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:46 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C01810C1;
	Tue, 15 Aug 2023 12:43:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so52363075e9.2;
        Tue, 15 Aug 2023 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128623; x=1692733423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1LGjCQUqcrNY0alG6lWK84AzftAjPlRFsXyMgA7/MU=;
        b=KhA5goXJwj8cJWFlmNkLcnXNViZLqK5ppltBZ5uCv0sY3H8kEL6An39nuKE/68cvZN
         /Tr6bIxv96NksGRIvD5sXSKj8iDtOPPAHGRbWttkoqyml/QLqgaYgR7JpALr04lUR3/m
         xqAzic6RNhFToWEsKJ6mgVV1sXweO0BxMeN+CCIAdfEuoa10R4p3Jx3/F5IQfkT5D1iL
         duCN5bAIgAAXzE7BY8sadMotFb7volgtjNWSrW3xjsXqU5I5yIU3mrC0mpsvU5am35tc
         Gpuppiv8eStoR1mlYtp89U4z3svTkkfS3ifwEYMXxUjmQlESNAKggL4qj+/l14z20zVa
         G2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128623; x=1692733423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1LGjCQUqcrNY0alG6lWK84AzftAjPlRFsXyMgA7/MU=;
        b=OMR8NphrkRWh76+P8d7ll+d+eXy4LO0KSXSaGEqC3IgnzJ7y8vUtHgCQLy5WvBfRZg
         TZpmgilLxcaEJ9z5RQBFttvoLs8F1nY7XqdYN+g3xGdvcgkXB1BbyHp6DKrDhZPfkxkm
         E+qtJs1NIEAYkESsvaxEUoqsI4+/SN//HE9BSNI6mSyhwCulJUgMaqhGFSZ0ESuFrkg0
         D+vkT+anr2r2P+UDClhnYOIbV+Dq7Gt5U6Ve0IcYcACnDsrLr/2q44GZnIcTb8DFt6xt
         wOLZBgT2ppSB9Ywfw5jfFKUclCX4WqvStOPEV+zbqcECGhudhm8topTIhJtyUbCSdzPq
         cvQw==
X-Gm-Message-State: AOJu0YxWAWaY9iqBBs0Z5l9B4sfDWQEMIP3dmw+0L4P2LzbEXy4I7qEU
	5W9Qw73hsMafwXmlOi7YB1NdcQt8QhylErm3
X-Google-Smtp-Source: AGHT+IEqevzzUxvLf4B29y/5WfXNAG9nvK2eScl009GC4kSDJaNRfPL6zi9Ld7Ty8XhA9wiobnih3g==
X-Received: by 2002:a5d:6202:0:b0:319:52a5:569f with SMTP id y2-20020a5d6202000000b0031952a5569fmr8483021wru.11.1692128623145;
        Tue, 15 Aug 2023 12:43:43 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:42 -0700 (PDT)
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
Subject: [PATCH net-next v2 10/10] doc/netlink: Add spec for rt route messages
Date: Tue, 15 Aug 2023 20:42:54 +0100
Message-ID: <20230815194254.89570-11-donald.hunter@gmail.com>
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

Add schema for rt route with support for getroute.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_route.yaml | 288 ++++++++++++++++++++++
 1 file changed, 288 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_route.yaml

diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
new file mode 100644
index 000000000000..eb4f6bb80100
--- /dev/null
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -0,0 +1,288 @@
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
+      dump:
+        request:
+          value: 26
+        reply:
+          value: 24
+          attributes:
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
-- 
2.41.0


