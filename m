Return-Path: <netdev+bounces-30306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77622786DA3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A085C1C20BE3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A8FC0B;
	Thu, 24 Aug 2023 11:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A5DF72
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:22 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD010FE;
	Thu, 24 Aug 2023 04:20:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so60952075e9.1;
        Thu, 24 Aug 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876018; x=1693480818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7vOTpfqqD54MzrSkWe2MWcCQ4puu0V5khTsQz3wBjk=;
        b=gX0nkGheG1sRPBoeQMDLbfUmiG+4DDE/iTbFCcgh7vJft0YXXdOdZAMBZtZnV0bGO8
         H9EhrPbfprMrOXnqedlSe73TawfVH2Lz9BGhvU1RW5+gNpFHNqYXnwMQUhx+rm5LpOXM
         sd8FVexhOMoL/2hAjLXm32cDPSnQFcSw8UzzbhCyTBiWHwwdDuPxZe9ZG12cmO2SZNAI
         /CBe+2qH4m8fInoHDuYcGabuAyxhYuPdotPCU4nCXZ0efDfr84h/Ud1FVN3HCQdrEyY8
         /mU83Z7tRUVSFb6p7471yzb8JWxPrKa7sMU2zImjFrI1AIBGtUne4xnV+tPt/FDdbvKH
         XSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876018; x=1693480818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7vOTpfqqD54MzrSkWe2MWcCQ4puu0V5khTsQz3wBjk=;
        b=e8PacALFTIKzHg4fGcHryT7wljrMvEVqpYBvPojAcmnugdsrmFah35lksguUy3xA4R
         70Yh+GRAonm3hq/4P+nVe0i+LvjXXyfDaoahdc3fWcfgZhK9OZr8jtv4IS4XnFBg5QSu
         h74pP5qhoHfv8gl7qDXzql+X6InWM9wyVLvm3wx7aL262OqV+zcKVDQ7GQiwgNQux2jK
         QT4NQkwh+ljqzhtIZci6Kz1knBIqfxC3+Gu03y5eQke8/no+hMeINskQgVuj4D/RIHWK
         wjYk6DKtGModKGpPGvxUM97vCPRTITg7tsNnwISgL8ytzy/ovIjbzdZHcRhqw9t7Znsw
         CRQg==
X-Gm-Message-State: AOJu0Yym0auwqEGurF15IH5rds/Dv0MTB9xSdZ/jhCmG1tr89J62/I0+
	7HTFINIDXOM7GhFDPTAfctD07zLCT+25nA==
X-Google-Smtp-Source: AGHT+IGF2jFxGvIfRpD+4B8vndfe9neRU6b/o6Y33RUFXhznitXDjlZdWCN2vClWiBH6jlxMxxI0mw==
X-Received: by 2002:adf:f043:0:b0:317:5b29:f10a with SMTP id t3-20020adff043000000b003175b29f10amr11177920wro.47.1692876017717;
        Thu, 24 Aug 2023 04:20:17 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:17 -0700 (PDT)
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
Subject: [PATCH net-next v5 03/12] doc/netlink: Update genetlink-legacy documentation
Date: Thu, 24 Aug 2023 12:19:54 +0100
Message-ID: <20230824112003.52939-4-donald.hunter@gmail.com>
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

Add documentation for recently added genetlink-legacy schema attributes.
Remove statements about 'work in progress' and 'todo'.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.39.2 (Apple Git-143)


