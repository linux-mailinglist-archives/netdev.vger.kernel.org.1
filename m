Return-Path: <netdev+bounces-57828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190CF8144A5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845DDB20F88
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7518C11;
	Fri, 15 Dec 2023 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaRrT7Gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA81944D;
	Fri, 15 Dec 2023 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso9021535e9.0;
        Fri, 15 Dec 2023 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633056; x=1703237856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7hVHKw1SImeQJ7Svu2PeuRb2LMO2eOKpW/mHG1Byp0=;
        b=EaRrT7GdBR8WZ8r60xcytHQUmo5woWnWE1qvhtSQvOgWqOcTfcK2odiMBcJXVToQ4h
         qQolOr0rOM+8m6zwUIVQFCsy70AVJuUmHuCHdt0S7AAVjzyVjAbPjt3jxYyrrYAhTJTQ
         6e67nEBV+UIOft+57MBO6zAGvWsjQdxT9roVJZPd1XvvMi/hdAyc7kg6yHZwc+HV4WWw
         SgTjMNqyTqQ7/h3Isb0L9F73OIfPS/8t3OUyC8VhB5QB7lBj3+akKsVUn0h/C68jEFZk
         06cpf/xj3A+xxG9VFet/lx3j22ZRgcLRwJnMHYbfA8PxtoAaPnkuL941CvaXmpDygL9g
         wKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633056; x=1703237856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7hVHKw1SImeQJ7Svu2PeuRb2LMO2eOKpW/mHG1Byp0=;
        b=cLHqu+E57jEuzr8PbwQ9WyluUO5ZQVhlJLjl5mHfGzbcbOGhpZkq8p4kpVis7DryuS
         jxeJwqY8SMIUnOm4eWgErWi/hi1IYo3HwWN85aLkmm6iT+Gw1lA+U0P9jaUJHv3ahvvC
         OZEzgN3qhNjnXWOLwDUXrfpRV5cHh0nUYnmtEXpxg2rG7V2x/XvXraZejoNRy/zRSPuZ
         2kZHoj39p92OYA3DuQS/AU3vjU8E72CT7doZL43c2q2OBD1ZrmRzrrY4qPUCJ4HE2HYX
         wAwZMqWfLbeExni6JfqOOSSyBbqW4l9qETDjBa4KfRcIrIHGV4We3pb3/XR35Mu9UdNo
         1jzA==
X-Gm-Message-State: AOJu0Yx6vxRJOElGy/bm6Qt8d6joSqjsXNdPJdv/EkNixjoVvL+RLfNK
	mkFuKdBvpATb8T0ijsepCUUj803gIDE51g==
X-Google-Smtp-Source: AGHT+IG6HiZjWRXiD7WFG1P7lSakTUuQj96Zjdbl2SQfOrN44EVEU/4mrTVAqodbAL9qNF0hAhArkg==
X-Received: by 2002:a05:600c:1d1a:b0:40c:228f:d313 with SMTP id l26-20020a05600c1d1a00b0040c228fd313mr5680692wms.50.1702633056113;
        Fri, 15 Dec 2023 01:37:36 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:35 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 03/13] doc/netlink: Document the sub-message format for netlink-raw
Date: Fri, 15 Dec 2023 09:37:10 +0000
Message-ID: <20231215093720.18774-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the spec format used by netlink-raw families like rt and tc.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 .../userspace-api/netlink/netlink-raw.rst     | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index f07fb9b9c101..1e14f5f22b8e 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -14,7 +14,8 @@ Specification
 The netlink-raw schema extends the :doc:`genetlink-legacy <genetlink-legacy>`
 schema with properties that are needed to specify the protocol numbers and
 multicast IDs used by raw netlink families. See :ref:`classic_netlink` for more
-information.
+information. The raw netlink families also make use of type-specific
+sub-messages.
 
 Globals
 -------
@@ -56,3 +57,96 @@ group registration.
       -
         name: rtnlgrp-mctp-ifaddr
         value: 34
+
+Sub-messages
+------------
+
+Several raw netlink families such as
+:doc:`rt_link<../../networking/netlink_spec/rt_link>` and
+:doc:`tc<../../networking/netlink_spec/tc>` use attribute nesting as an
+abstraction to carry module specific information.
+
+Conceptually it looks as follows::
+
+    [OUTER NEST OR MESSAGE LEVEL]
+      [GENERIC ATTR 1]
+      [GENERIC ATTR 2]
+      [GENERIC ATTR 3]
+      [GENERIC ATTR - wrapper]
+        [MODULE SPECIFIC ATTR 1]
+        [MODULE SPECIFIC ATTR 2]
+
+The ``GENERIC ATTRs`` at the outer level are defined in the core (or rt_link or
+core TC), while specific drivers, TC classifiers, qdiscs etc. can carry their
+own information wrapped in the ``GENERIC ATTR - wrapper``. Even though the
+example above shows attributes nesting inside the wrapper, the modules generally
+have full freedom to define the format of the nest. In practice the payload of
+the wrapper attr has very similar characteristics to a netlink message. It may
+contain a fixed header / structure, netlink attributes, or both. Because of
+those shared characteristics we refer to the payload of the wrapper attribute as
+a sub-message.
+
+A sub-message attribute uses the value of another attribute as a selector key to
+choose the right sub-message format. For example if the following attribute has
+already been decoded:
+
+.. code-block:: json
+
+  { "kind": "gre" }
+
+and we encounter the following attribute spec:
+
+.. code-block:: yaml
+
+  -
+    name: data
+    type: sub-message
+    sub-message: linkinfo-data-msg
+    selector: kind
+
+Then we look for a sub-message definition called ``linkinfo-data-msg`` and use
+the value of the ``kind`` attribute i.e. ``gre`` as the key to choose the
+correct format for the sub-message:
+
+.. code-block:: yaml
+
+  sub-messages:
+    name: linkinfo-data-msg
+    formats:
+      -
+        value: bridge
+        attribute-set: linkinfo-bridge-attrs
+      -
+        value: gre
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: geneve
+        attribute-set: linkinfo-geneve-attrs
+
+This would decode the attribute value as a sub-message with the attribute-set
+called ``linkinfo-gre-attrs`` as the attribute space.
+
+A sub-message can have an optional ``fixed-header`` followed by zero or more
+attributes from an ``attribute-set``. For example the following
+``tc-options-msg`` sub-message defines message formats that use a mixture of
+``fixed-header``, ``attribute-set`` or both together:
+
+.. code-block:: yaml
+
+  sub-messages:
+    -
+      name: tc-options-msg
+      formats:
+        -
+          value: bfifo
+          fixed-header: tc-fifo-qopt
+        -
+          value: cake
+          attribute-set: tc-cake-attrs
+        -
+          value: netem
+          fixed-header: tc-netem-qopt
+          attribute-set: tc-netem-attrs
+
+Note that a selector attribute must appear in a netlink message before any
+sub-message attributes that depend on it.
-- 
2.42.0


