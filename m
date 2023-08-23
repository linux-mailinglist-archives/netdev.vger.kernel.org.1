Return-Path: <netdev+bounces-29990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871517856EE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA61C20BEB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B4C125;
	Wed, 23 Aug 2023 11:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71BC120
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:22 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED002E5D;
	Wed, 23 Aug 2023 04:42:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so87912561fa.2;
        Wed, 23 Aug 2023 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790939; x=1693395739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUGgPZ+TP4ZifrffC8kSTbVK7lcYBjw+R1LU/DN1/6E=;
        b=cw8Div0VHJdJVm7okupxhCbDMUwUYV+58rlsWchHXMeTLE1b4yo3teGN9sMIIXOdsH
         zMivc5rcSMVeANur5m6QXt1wdtc6enXNUO3T9Ex/ffpH1BD0Bwps+G0taoJIbyt5JaXR
         KNRPSQbBj8EY2r4fyPS68xQXcLqig8nve/9YfBp+ciiZTJG7tLHxbMI49zNpafpS5psz
         gkPA8V6GJ6HU2TT2aFVE3tnXnInxediGHxYVRfLx1hQdO0v+AdZq4mGOQYfIwFjgpSDE
         KFXHi8D8XV4DBh1B+oeBO+3jHS38N+0vDisqZ06zsWAJTFSjydApjeAQ+jhiAzIM9N4R
         IMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790939; x=1693395739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUGgPZ+TP4ZifrffC8kSTbVK7lcYBjw+R1LU/DN1/6E=;
        b=LX169Sh+SAgcn9QJfM0OaWuO0RAVKjc1vPquv4DEFn+6fc7BnHraPmBIrmcMyvWONQ
         BieodTwoE+OK71+R8Ddzdom8IcIMIeoFMuM+eF1gZuuJA6wISP+PRurEUWg+XHNiGmae
         2i2YioPGRzxuU3I63j2SdbPrLGfAG+USv3tI3Tt7Qo6dYlCVIX/xNB1mY0zW+rA5n6Wp
         SzM0V2CLQjws3uWADBdV0eAIlHdgP5Av4l46nOKCmAgpDST+eEXnDcOb4DgyNKF8OZvO
         BXWD8cdE7R0cfPK3NT1FQIO38ed6mz3GsR9o4i70GfexFI2O3Bd5vR4R2PJj8wE9uaQb
         4hfw==
X-Gm-Message-State: AOJu0YzquUa34tkjnvGWE/2CHrYtowKGE1NPy3jhNJtQav8uoZ+eaNzP
	3yAb3uYdtiAZ/cdIwDACP58LyVfTySsgvA==
X-Google-Smtp-Source: AGHT+IHgNYHZ359eBCwMy1UYcMI3juAw3RAXa1oXfq+dgdZ74Z8ewKYIYiRlhQqx2Leu+ThsIVp7wg==
X-Received: by 2002:a2e:8091:0:b0:2b9:55c9:c228 with SMTP id i17-20020a2e8091000000b002b955c9c228mr8723359ljg.27.1692790938460;
        Wed, 23 Aug 2023 04:42:18 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:17 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/12] doc/netlink: Document the netlink-raw schema extensions
Date: Wed, 23 Aug 2023 12:41:53 +0100
Message-ID: <20230823114202.5862-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823114202.5862-1-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
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

Add a doc page for netlink-raw that describes the schema attributes
needed for netlink-raw.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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


