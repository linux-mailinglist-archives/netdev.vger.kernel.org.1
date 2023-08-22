Return-Path: <netdev+bounces-29781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76582784AB4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7811C20BBF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5634CED;
	Tue, 22 Aug 2023 19:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EC34CE9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:25 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB9CDD;
	Tue, 22 Aug 2023 12:43:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1602855f8f.3;
        Tue, 22 Aug 2023 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733401; x=1693338201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucW7TreuqN9dI6aXR91207nynQFU7Gr4soTYfwMw7Mw=;
        b=CvtbuErTDZfUZGzZnDOCesKWuEwhctrqv5ATzoGgnHrK2gygDLoYBIZz2D/XKDvbQf
         5D/X4ypfypYLo9cdj4cIH1Csoh4oAqQHdjT0zzkUc0OA37mN+HYB5yCYShC6fwf007ti
         3ndxMIu7onB28raRxsRUgCYjuVKxC86qspZ1lsVDKaE8W3U/5dp09XYvM/bYihwaUjGe
         g6+MVidHgDllJtANR4UM+dJ8DSTSWzC49dG8HpaCAG76ZtEvy2xfshPawbk8p594ZqJf
         MbHgWfyqKr5i1vGZveHcSrWAHlVcyChuFIYeHrgrCXK+zS/eiNvGgddHxPX/ZyXMT9ry
         SfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733401; x=1693338201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucW7TreuqN9dI6aXR91207nynQFU7Gr4soTYfwMw7Mw=;
        b=AnvfSl6MXj2j2rgIH5Qmz2ubrrvmOi1b0cPwhrfcGiexF/vOpH4RFvtA/J1w3xUibN
         oUW4B5DqCe3B7uBASz5Wlx7cC4qywQ08UcyAew/N/sTR7Y2S+BeHJsvaXRXPxGV2/0oL
         pWiV6bNOYa35F0l8pIc+DGprjTOVC5KYuGQWhBK71Po8x/DQ/sDT1uaRiPrB6Z28eiWs
         qCxABwBxkD3TjXWafBIPapbtYLn+o9uN/2D3j1zFkCRuqGc/iisdYl+5juXMLUsLABDa
         DhihYTjxvkwvPbD5Av/Tf4+ZISCzSV4SUnh0lJ8e1hxmRgR0ecWgfILlwGM4S+M/x5nx
         3T3g==
X-Gm-Message-State: AOJu0Yz3/LWpr5DhpwwB7Hlr5mEgdsdp/6Me/zIcXV8UlonN13fn5IeG
	shR8tEu7cPpVg0Htl3wYKzfrUe8FhtpVtA==
X-Google-Smtp-Source: AGHT+IH/T1+SlLelndIzYpTlgyEzsaMEEPlmKIwNx6Gu8L+sylLe7JYTnDWhrtloSxdL5tLg/rGm+w==
X-Received: by 2002:a5d:54cd:0:b0:314:4237:8832 with SMTP id x13-20020a5d54cd000000b0031442378832mr7199959wrv.48.1692733401475;
        Tue, 22 Aug 2023 12:43:21 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/12] doc/netlink: Update genetlink-legacy documentation
Date: Tue, 22 Aug 2023 20:42:55 +0100
Message-ID: <20230822194304.87488-4-donald.hunter@gmail.com>
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

Add documentation for recently added genetlink-legacy schema attributes.
Remove statements about 'work in progress' and 'todo'.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/core-api/netlink.rst            |  9 ++++---
 .../netlink/genetlink-legacy.rst              | 26 ++++++++++++-------
 Documentation/userspace-api/netlink/specs.rst | 13 ++++++++++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/Documentation/core-api/netlink.rst b/Documentation/core-api/netlink.rst
index e4a938a05cc9..9f692b02bfe6 100644
--- a/Documentation/core-api/netlink.rst
+++ b/Documentation/core-api/netlink.rst
@@ -67,10 +67,11 @@ Globals
 kernel-policy
 ~~~~~~~~~~~~~
 
-Defines if the kernel validation policy is per operation (``per-op``)
-or for the entire family (``global``). New families should use ``per-op``
-(default) to be able to narrow down the attributes accepted by a specific
-command.
+Defines whether the kernel validation policy is ``global`` i.e. the same for all
+operations of the family, defined for each operation individually - ``per-op``,
+or separately for each operation and operation type (do vs dump) - ``split``.
+New families should use ``per-op`` (default) to be able to narrow down the
+attributes accepted by a specific command.
 
 checks
 ------
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 802875a37a27..40b82ad5d54a 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -8,11 +8,8 @@ This document describes the many additional quirks and properties
 required to describe older Generic Netlink families which form
 the ``genetlink-legacy`` protocol level.
 
-The spec is a work in progress, some of the quirks are just documented
-for future reference.
-
-Specification (defined)
-=======================
+Specification
+=============
 
 Attribute type nests
 --------------------
@@ -156,16 +153,27 @@ it will be allocated 3 for the request (``a`` is the previous operation
 with a request section and the value of 2) and 8 for response (``c`` is
 the previous operation in the "from-kernel" direction).
 
-Other quirks (todo)
-===================
+Other quirks
+============
 
 Structures
 ----------
 
 Legacy families can define C structures both to be used as the contents of
 an attribute and as a fixed message header. Structures are defined in
-``definitions``  and referenced in operations or attributes. Note that
-structures defined in YAML are implicitly packed according to C
+``definitions``  and referenced in operations or attributes.
+
+members
+~~~~~~~
+
+ - ``name`` - The attribute name of the struct member
+ - ``type`` - One of the scalar types ``u8``, ``u16``, ``u32``, ``u64``, ``s8``,
+   ``s16``, ``s32``, ``s64``, ``string`` or ``binary``.
+ - ``byte-order`` - ``big-endian`` or ``little-endian``
+ - ``doc``, ``enum``, ``enum-as-flags``, ``display-hint`` - Same as for
+   :ref:`attribute definitions <attribute_properties>`
+
+Note that structures defined in YAML are implicitly packed according to C
 conventions. For example, the following struct is 4 bytes, not 6 bytes:
 
 .. code-block:: c
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index 2e4acde890b7..cc4e2430997e 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -68,6 +68,10 @@ The following sections describe the properties of the most modern ``genetlink``
 schema. See the documentation of :doc:`genetlink-c <c-code-gen>`
 for information on how C names are derived from name properties.
 
+See also :ref:`Documentation/core-api/netlink.rst <kernel_netlink>` for
+information on the Netlink specification properties that are only relevant to
+the kernel space and not part of the user space API.
+
 genetlink
 =========
 
@@ -180,6 +184,8 @@ attributes
 
 List of attributes in the set.
 
+.. _attribute_properties:
+
 Attribute properties
 --------------------
 
@@ -264,6 +270,13 @@ a C array of u32 values can be specified with ``type: binary`` and
 ``sub-type: u32``. Binary types and legacy array formats are described in
 more detail in :doc:`genetlink-legacy`.
 
+display-hint
+~~~~~~~~~~~~
+
+Optional format indicator that is intended only for choosing the right
+formatting mechanism when displaying values of this type. Currently supported
+hints are ``hex``, ``mac``, ``fddi``, ``ipv4``, ``ipv6`` and ``uuid``.
+
 operations
 ----------
 
-- 
2.41.0


