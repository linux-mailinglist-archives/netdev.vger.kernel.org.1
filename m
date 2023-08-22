Return-Path: <netdev+bounces-29782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9D784AB7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C921C20B7B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340DE34CF8;
	Tue, 22 Aug 2023 19:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA934CCB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:27 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E6CED;
	Tue, 22 Aug 2023 12:43:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e742a787so2996060f8f.1;
        Tue, 22 Aug 2023 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733402; x=1693338202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUGgPZ+TP4ZifrffC8kSTbVK7lcYBjw+R1LU/DN1/6E=;
        b=FjTeQoVmTJjptZwyEPuVvmIhUxhdI/QnzG5wI9a3IEeDtWIf86CU6MA/gRriKFlAW5
         V+FdBZotJe1iQ+9ZEmy7kp58cR1s/rarvcsAGU8r4wn9uRWN061fB8LBEMwh/qB25y1L
         HVtobh/44lkpb0PxngSKJKQU1UguK1ynP45O3uKLNEkssRaIrnf/qTpqpiirgMpKKlvo
         kZ0xbOY3xKh3eVwXxY/ypT/i1ccg0TDz4w5NpIJlTuKGCFom8jVIlT5HLz4rVT9HNQBx
         hTEO3YsB9U1ZO+Q4HbjRdGy1UDKJQYdV3rvcHwvKg9Tc3kJPAclceBRwNABMYMFQL8NU
         jnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733402; x=1693338202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUGgPZ+TP4ZifrffC8kSTbVK7lcYBjw+R1LU/DN1/6E=;
        b=Ag2WAzlvFIEl6reTLoHilWQb3frrGz9ptUH1vL4Egv6IB7dLccq4xHN3Wk/Y/4EAeR
         Xx8hFHFlSY4n2RaLSZCX61oWlTZFi/L49W/D7IoVV9ccExdt3IsBQECqWf3PidBEHtG6
         96AvBpxWvNxNEvaml8+KEqhS65ncAcGHlHaJHdZTVDhO5MCls0+qSvxukX9j/vsm6GYB
         N/gBGX04XuSVZjrYKrOU5iIIJiehd3kNMUJDw31m7eBYHkkCZbyeSMfngyd0gh9prp4N
         TNlxUt8oCUHmdRX2F7i+plYlhcYxHHd0MtSVEY6TqtX7pfynHYNH8d8C4HfOokdYnEeh
         br4A==
X-Gm-Message-State: AOJu0YxwS5n+oL5OQN1LH4Fao+XpkrG807cEZVDcQ71aUJqZvh7VYXGU
	WoJnwhS5vreLE7DGClF5pPIUZMD2gSdMpg==
X-Google-Smtp-Source: AGHT+IEmgIbyflqbMCrkvfXIMdJ5tPVQ5JRrDkxG0v7Z9RT5Ens0CHyImAJKxLiriWLhuo9g/zDOVg==
X-Received: by 2002:a5d:5272:0:b0:313:e391:e492 with SMTP id l18-20020a5d5272000000b00313e391e492mr10772651wrc.17.1692733402613;
        Tue, 22 Aug 2023 12:43:22 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:22 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/12] doc/netlink: Document the netlink-raw schema extensions
Date: Tue, 22 Aug 2023 20:42:56 +0100
Message-ID: <20230822194304.87488-5-donald.hunter@gmail.com>
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


