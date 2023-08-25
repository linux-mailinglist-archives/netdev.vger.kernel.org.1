Return-Path: <netdev+bounces-30663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E54788780
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22171C20FF7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA895101E2;
	Fri, 25 Aug 2023 12:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDD101C2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:15 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFA2120;
	Fri, 25 Aug 2023 05:28:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso7495285e9.2;
        Fri, 25 Aug 2023 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966503; x=1693571303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpwPycZDfvKtBkur6NB+pKaDkgLkYk3Zg/JjaDmqaGc=;
        b=eTWkr2pylSmiuFCfFkJZcyp9biJsLUE5m03CsOk9GmqoYSj83QTxnxsyBPIRrTQ9cS
         qkpDOmhgfsgzDBi6BO6kuElygLSXyW+cF6oN3m1p5iS/CrUDy9c0XxV7kRjmP7g0jrFb
         XHk6WIhFr0JUmp92rcynpbCrwdiDdXHjCiwcBPIS1fPGNexzYeiqcUS4Q+ZIsvWtL6ka
         wAnhGba4g1Gk2rz6wcmuP1YRqdDsWwV3IHKnwB4uAYZUMs3mk48CondHVQHgHoMzR/iE
         IHRpNkEsCk5dcnvoHo926ei+7Ag8BKSD8WAOC+wjHfWK53Iaj81TwkfxLJxyo3sYUIjI
         hVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966503; x=1693571303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpwPycZDfvKtBkur6NB+pKaDkgLkYk3Zg/JjaDmqaGc=;
        b=jaMDHEYF2CV9mYfsQh0tqtQ5jTtyPMeqNP8hRXUj3YxwzJKxME7RifwZV14mYygByA
         GZ4LoG2kci7V9U/1l8VI101Ri46B9rWue78bIIkBEjfRZb1aUgk41tZtgW5vvUsWRpWS
         1b4RRDgTtOZ61DYEncszq89jk1g0YfYj+wAuAg+ZcuwvrC4mPKqmeF4UodKxGJcuWLOu
         p/WC7ULyRDGdkOpkj7/eTy/aPJ+Kbq8dQ/sr6xpGnyD851Sw37m8pZGZQR1ngIXTyj51
         iqmtJyE52auXgyapIxMe1m7phC0uAbpumdoUt3fcWzUHc4ocoDd1wOPAYLQ6YsItza3K
         W2XQ==
X-Gm-Message-State: AOJu0YyQnV1kgmFDzyOVedKBCodm1F+BjsHnAJZYmTrYHXz/AXsY49EH
	LQPXJvf1E1Ux6PlaylfhFjfqUOsBvdo5Ww==
X-Google-Smtp-Source: AGHT+IHmnPo2PRIhSBpGBkhersl8EVnDxcwjKMp8HtBI+PjacXZg27OMtBN3B3MeAAMhWo9lP0dpKA==
X-Received: by 2002:a05:600c:3795:b0:400:419c:bbe2 with SMTP id o21-20020a05600c379500b00400419cbbe2mr5326181wmr.24.1692966502653;
        Fri, 25 Aug 2023 05:28:22 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:22 -0700 (PDT)
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
Subject: [PATCH net-next v6 12/12] doc/netlink: Add spec for rt route messages
Date: Fri, 25 Aug 2023 13:27:55 +0100
Message-ID: <20230825122756.7603-13-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
2.41.0


