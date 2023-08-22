Return-Path: <netdev+bounces-29789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2B784AC6
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B732811C5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B334CD3;
	Tue, 22 Aug 2023 19:43:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1F34CCB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:42 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7FDCD0;
	Tue, 22 Aug 2023 12:43:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so46220575e9.0;
        Tue, 22 Aug 2023 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733412; x=1693338212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz0l8uMD+hXFXMEPbqWlQz6ra+BzX6Zb11bNTG8Zq6Q=;
        b=kxIj1v2/BrCrldFKxU0Fib4OPvkAg7o1p/4SWp1ymdvPSboz3C6S4TmqUf2mB0qfEF
         mXQZZsn3z1GvJ9Yn+XvdlQ3CXYDISByOlqSIlyqwKcer5d2YI42hug79enOlOr+7WDu7
         LJS+mCHVn0MKEeqihOfrWcFQ8dUI+eB747U0Swn0licSrx6ZpX+ATd9v/UasPahtKwHF
         3U35U195tsG4uC7IwyEjvlrVLX9gH7rWNdCRcNd+BREl7zTqvgd5nxI8tZxW+AgQZadV
         7X0Zq+SEDTiiX/dem1R5jWtvo5oiV4Lh3pK59zNEntBnbz5FwFFmg78iGPb3UesL9kDn
         85KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733412; x=1693338212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz0l8uMD+hXFXMEPbqWlQz6ra+BzX6Zb11bNTG8Zq6Q=;
        b=MfVTiV11PmnWnNnFSIXQOj3Wo+682yng5Ut25XkJSGqvuAzIWtCwRC2bfza1MxIpLI
         MzpZfWsR3oljVLZGA40U7+xYduzatu/GDJGarj4rZpcbuauE2qSR3MD9nbEHNSWJ/mEH
         EmWY3wQcAHHwGBTez5fgIjh00bq9D81o4T9ztGeyKdAdUiDwX0hjeSYQFLYcIlnqKiwn
         6DBzuAo+ZyU8+erGrtbMXRCteyr0IDfwwcchJ1YXz/oLfGW5lk7NcNCCs8csvAOR+ONY
         +nuEHGurJQVTx7HrP7A1xhM8YezP17tfOX750PZzMMYQIhUQt/2CQlT5GnHZZGP2FVIA
         diNw==
X-Gm-Message-State: AOJu0YzbO+YBtFBt2q+fZtgLg0KVtxmhJhj5i5mugnv8I6zRwI+drVOJ
	HcDDsuyg1UbWqABnGIHTddfKG1AUw0aA/Q==
X-Google-Smtp-Source: AGHT+IEdfBTKwHzDe4WTCEJZOsl480EzPrbOurDBLLEbdLTF3Y/45a+PDa3egKT2DPl4afdmU9Uy3A==
X-Received: by 2002:a7b:c4c9:0:b0:3fe:2b8c:9f0b with SMTP id g9-20020a7bc4c9000000b003fe2b8c9f0bmr7975170wmk.23.1692733412095;
        Tue, 22 Aug 2023 12:43:32 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/12] doc/netlink: Add spec for rt route messages
Date: Tue, 22 Aug 2023 20:43:04 +0100
Message-ID: <20230822194304.87488-13-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822194304.87488-1-donald.hunter@gmail.com>
References: <20230822194304.87488-1-donald.hunter@gmail.com>
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
 Documentation/netlink/specs/rt_route.yaml | 306 ++++++++++++++++++++++
 1 file changed, 306 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_route.yaml

diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
new file mode 100644
index 000000000000..c87e5ec6f675
--- /dev/null
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -0,0 +1,306 @@
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
2.41.0


