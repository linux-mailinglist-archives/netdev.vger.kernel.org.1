Return-Path: <netdev+bounces-30307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D1786DB4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7618D1C20DF7
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCFDF69;
	Thu, 24 Aug 2023 11:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F6100C1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:22 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0D510FA;
	Thu, 24 Aug 2023 04:20:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5834691f8f.3;
        Thu, 24 Aug 2023 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876019; x=1693480819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/J+nnRKTc28Dk8Gc4n3hxG5SwysHcm0JHfwpZXUZ6k=;
        b=lo4DwLE1Cp5fF2bSj3PFtwSjmPKqKmNpD7zDlYhu4imxcqAdjDl8kNlYVkKPcHsnRy
         DvVEoLy7Av6loK47RRL09cF+9hA7Yjpx06nvYOzwMVblN4Jwft7SUq0i0ZmTOvPAYHo8
         bvtd+8VwTIRySbIdJBY0A5Xxd2i6g8O05cQm/VcRh6oDorJI6v9zdqlHIMXuHtOPbbcw
         TV7FJVKlpOja2a3+SN4/GyhtKAUbbQCTpW8AbLEwf+BeHV7A9oxYWvRiIQ5lFAQ2v0KH
         ICe8NggbLpQLjo8nPh7FLwPKEpar/ekGGL58BCbUt2R+A6ikuZZ9zSC+UhtIDhtEJtD6
         VfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876019; x=1693480819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/J+nnRKTc28Dk8Gc4n3hxG5SwysHcm0JHfwpZXUZ6k=;
        b=Yy2KCx+SVOHbW+d2n7KurBfpJr7y/BFGxoigkeIlDwiKgxSa1fEqSrOxeZ57HMm90e
         kAK+h+hLjtdsbv/AdfivXTq+oRmm9xpXTpKqtJtv+oZUQ33nsQjDJiTVjauZcFfswSTH
         M9oclykG3i1UnmdIKxEg5tsI8k/qd0ha+q/9v/rsSesyqb9xet/V+Nil8ciDis7o8BPl
         Tv4hObkhSxM56f2NScN9XbIQ2CtSZTZBdwAH24WsJb1CE1dp6gT/WcAG7BR4xgemj4Jl
         ngpcMu0rj8HLUFhyIj8LbU/IYvEeQmu1mr52cAUG2Z654qFb0zLtqrn8NSisdR6ElpzC
         XroA==
X-Gm-Message-State: AOJu0YwRcpkrY7kgfrrf4NofCixq4xNWPvq8u0ZIRAKKXLsAxNbT2sE/
	x4ULLjn8utdUlbmUrLJwGYDGrswJwUdFZA==
X-Google-Smtp-Source: AGHT+IFe3rJf1OAwwyToE8mEHlXPoCdVvNiZoGg/eGCT/AS6oPXpV7rtjdId32YG2+TyJUK4CInWig==
X-Received: by 2002:a05:6000:10b:b0:315:a74c:f627 with SMTP id o11-20020a056000010b00b00315a74cf627mr11060337wrx.16.1692876019010;
        Thu, 24 Aug 2023 04:20:19 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:18 -0700 (PDT)
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
Subject: [PATCH net-next v5 04/12] doc/netlink: Document the netlink-raw schema extensions
Date: Thu, 24 Aug 2023 12:19:55 +0100
Message-ID: <20230824112003.52939-5-donald.hunter@gmail.com>
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
2.39.2 (Apple Git-143)


