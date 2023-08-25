Return-Path: <netdev+bounces-30655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89949788762
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E49281845
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C5DDA8;
	Fri, 25 Aug 2023 12:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183CDDA7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:03 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7952115;
	Fri, 25 Aug 2023 05:28:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee8b78097so7658945e9.0;
        Fri, 25 Aug 2023 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966492; x=1693571292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO9HdVBn2++QkOdhWN5zvCwhipxwcE7UaJgA1Ip5ex8=;
        b=TwaRj7qOQsJzFTRKe+6TgzR/gztXnGiG6X/rR/j7uq+NyK8NPlFo+UKWoL5ZhSC0+z
         7a5l0JDj+srGBTJ1MeVUbte0RS6ljdFOtX1KQViwzDRs/ur4VJiac7JjokL+7XyWZfO2
         wUq5H8KDNSsDkLoFMJ4VjJl7uATxP7phEoDi84S0AYu/rriIIrJBjzcKNmTpvDrJcccc
         zYyFSn8Oi9VhHy8XOYKHe8NQu7jkR2cF2+9gCkDUxTtquuT+MOipMD1CISgIw2Eqw1+g
         SlnVnAsgIDcNw0JocE53oFqsz0me+4Z73kEadUychRjFwtz0FRBjo9+pJrjPTNGFubFq
         anfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966492; x=1693571292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO9HdVBn2++QkOdhWN5zvCwhipxwcE7UaJgA1Ip5ex8=;
        b=au9T9XEuSLBVY5QPZYhaAWmU2XSZL1+K89dS1dNMd6blKlW0VlkGPcITfF4PSnDl3U
         4ugRf9r2FBkQF6GBjqTf+xGANs71HI5t6NMIsaL6B30shwjFE+y+sozERoTjEy9qbC0C
         iRE2IDJz0OzaWh3FDm6InPck1Nmapz0aW4mOCwRpqsRFR2AcHrUgWXDR84X3XzeEVNkw
         mTgr5/71KK8buKtvsqECfCGev8kEA0qE0tmmLVmxiLKmUdzboBPbeS461j98fSCsunu5
         9pzcWyyiDliKiuiansLfLxk5buf1/mJQupOoiJcNEnjzi1XLRBbKUViR21IIqOh005UF
         sSSA==
X-Gm-Message-State: AOJu0Yy6CVEgM2XeXCL0c37AZJ8SHcE8PywbePuHH6JUpFYgELJJZdMX
	KaVt3eDHca2ud1H9Votr5jCjsHrcWKgA2A==
X-Google-Smtp-Source: AGHT+IFnnJ2+165DUUksUeslHQglFVWYl41ml87pTisA1Hs7lLo32Vxzv+Lk/y6fnqJTjS0VrBQr4w==
X-Received: by 2002:a7b:c7d4:0:b0:401:b908:85a2 with SMTP id z20-20020a7bc7d4000000b00401b90885a2mr876004wmk.23.1692966492653;
        Fri, 25 Aug 2023 05:28:12 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:12 -0700 (PDT)
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
Subject: [PATCH net-next v6 04/12] doc/netlink: Document the netlink-raw schema extensions
Date: Fri, 25 Aug 2023 13:27:47 +0100
Message-ID: <20230825122756.7603-5-donald.hunter@gmail.com>
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

Add a doc page for netlink-raw that describes the schema attributes
needed for netlink-raw.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/userspace-api/netlink/index.rst |  1 +
 .../userspace-api/netlink/netlink-raw.rst     | 58 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst

diff --git a/Documentation/userspace-api/netlink/index.rst b/Documentation/userspace-api/netlink/index.rst
index 26f3720cb3be..62725dafbbdb 100644
--- a/Documentation/userspace-api/netlink/index.rst
+++ b/Documentation/userspace-api/netlink/index.rst
@@ -14,5 +14,6 @@ Netlink documentation for users.
    specs
    c-code-gen
    genetlink-legacy
+   netlink-raw
 
 See also :ref:`Documentation/core-api/netlink.rst <kernel_netlink>`.
diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
new file mode 100644
index 000000000000..f07fb9b9c101
--- /dev/null
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+======================================================
+Netlink specification support for raw Netlink families
+======================================================
+
+This document describes the additional properties required by raw Netlink
+families such as ``NETLINK_ROUTE`` which use the ``netlink-raw`` protocol
+specification.
+
+Specification
+=============
+
+The netlink-raw schema extends the :doc:`genetlink-legacy <genetlink-legacy>`
+schema with properties that are needed to specify the protocol numbers and
+multicast IDs used by raw netlink families. See :ref:`classic_netlink` for more
+information.
+
+Globals
+-------
+
+protonum
+~~~~~~~~
+
+The ``protonum`` property is used to specify the protocol number to use when
+opening a netlink socket.
+
+.. code-block:: yaml
+
+  # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+  name: rt-addr
+  protocol: netlink-raw
+  protonum: 0             # part of the NETLINK_ROUTE protocol
+
+
+Multicast group properties
+--------------------------
+
+value
+~~~~~
+
+The ``value`` property is used to specify the group ID to use for multicast
+group registration.
+
+.. code-block:: yaml
+
+  mcast-groups:
+    list:
+      -
+        name: rtnlgrp-ipv4-ifaddr
+        value: 5
+      -
+        name: rtnlgrp-ipv6-ifaddr
+        value: 9
+      -
+        name: rtnlgrp-mctp-ifaddr
+        value: 34
-- 
2.41.0


