Return-Path: <netdev+bounces-30303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8F786D9A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF0D1C20DEA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4BDDCB;
	Thu, 24 Aug 2023 11:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA424543
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:20:17 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2110F3;
	Thu, 24 Aug 2023 04:20:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31977ace1c8so5854172f8f.1;
        Thu, 24 Aug 2023 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876014; x=1693480814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuJW0LKbZt9E5H/o5pYsw4kheQDvEfUDjmQ5oCP0+3M=;
        b=YvLp6BAuvU4sfSKxfGyAjuBL0mvrUWXpxRKtfBAmHpi6P6hbYU597w84cH8E3+Ymkx
         OxQHGXMoYz/Mu1gdhYpkJj9N8R/azLfAS8hHVOv9rg90DxdWZw1JvuV5vpe88O3ZWwTL
         DB4xasT1loNSnd50celbazHVoX+ZxHug1JCM1po/NDAPnMDKKeu77KrCqm5BMXSPlfFZ
         3owpCQQTSOu4LVQFiuE45s5HNwS2heWZ1/cfWCyNHesOyH4pahSG+55mJrxOcIfjuwpN
         ONjQE8k/cyI4sCK/QkJMKYj3TF/FDtq5CknRdjgpgC5tmWhMmquiEJbOhiKMS1v6LNRk
         ZtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876014; x=1693480814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuJW0LKbZt9E5H/o5pYsw4kheQDvEfUDjmQ5oCP0+3M=;
        b=QaOn1OMO4bPbbmkq/3VkrBPILjTnfvd0bFHfMBpCYXM5Ft5jvGwehMVpWgeUCWhdky
         PBiuNV6OYVviAHcqdxWBLAOnPeCLQ7QUWgswni1QdhoJf5uzKamKeFMsF+73NxZKgf2j
         dRH4GR2EGVXRWN4Sxif65Sa03hQJAxQuHydd2VaRuVDUzBd4f9WS75pV4KjQaYknTJSz
         RtNhYyPJjwShen2cdSO12ysVy3uIM1jpnCLJZMLgX6GwEQSGb8p0FVoe9M/I7GHNyzJY
         QQ6NDag2+cARzvokl1glFN5FqgdPlxudIluYl5emO5db9BL3g+vuD+PoJ3UMV1p37gDz
         oScg==
X-Gm-Message-State: AOJu0YxtJc3X5zNdL0X8JMU+veP1hi46zaCrwVdqgBo/tQPz6SypvlrY
	W/7wFdkdndBs7W/90T0KoPa0DMEHpqZdHA==
X-Google-Smtp-Source: AGHT+IHfDVsyxgqXUWNMvNmXlEKaURz16EI2XRHzZJ8Yul5DE3GlLI6ZaUj+kt/4/JNw9iFfakUSqg==
X-Received: by 2002:adf:f84e:0:b0:315:9362:3c70 with SMTP id d14-20020adff84e000000b0031593623c70mr10974590wrq.60.1692876013697;
        Thu, 24 Aug 2023 04:20:13 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm21875295wru.54.2023.08.24.04.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:20:13 -0700 (PDT)
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
Subject: [PATCH net-next v5 00/12] tools/net/ynl: Add support for netlink-raw families
Date: Thu, 24 Aug 2023 12:19:51 +0100
Message-ID: <20230824112003.52939-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
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

This patchset adds support for netlink-raw families such as rtnetlink.

Patch 1 fixes a typo in existing schemas
Patch 2 contains the schema definition
Patches 3 & 4 update the schema documentation
Patches 5 - 9 extends ynl
Patches 10 - 12 add several netlink-raw specs

The netlink-raw schema is very similar to genetlink-legacy and I thought
about making the changes there and symlinking to it. On balance I
thought that might be problematic for accurate schema validation.

rtnetlink doesn't seem to fit into unified or directional message
enumeration models. It seems like an 'explicit' model would be useful,
to force the schema author to specify the message ids directly.

There is not yet support for notifications because ynl currently doesn't
support defining 'event' properties on a 'do' operation. The message ids
are shared so ops need to be both sync and async. I plan to look at this
in a future patch.

The link and route messages contain different nested attributes
dependent on the type of link or route. Decoding these will need some
kind of attr-space selection that uses the value of another attribute as
the selector key. These nested attributes have been left with type
'binary' for now.

v4 -> v5:
  - Fix schema id in netlink-raw schema
  - Remove doc references to genetlink from netlink-raw schema
  - Add missing whitespace between classes in ynl.py

v3 -> v4:
  - Fix incorrect var name in handle_ntf
  - Update rt_link spec to include operation attributes
  - Update rt_route spec to refine operation attributes

v2 -> v3:
  - Fix typo in existing schemas
  - Rework fixed_header code to fix extack parsing
  - Add support for CREATE, EXCL, REPLACE and APPEND, needed by rt_route

v1 -> v2:
  - Put mcast-group changes in separate patch
  - Put decode_fixed_header refactoring in separate patch
  - Avoid refactoring decode_enum
  - Rename NetlinkProtocolFamily -> NetlinkProtocol and
    GenlProtocolFamily -> GenlProtocol and store in self.nlproto
  - Add spec for rt link.

Donald Hunter (12):
  doc/netlink: Fix typo in genetlink-* schemas
  doc/netlink: Add a schema for netlink-raw families
  doc/netlink: Update genetlink-legacy documentation
  doc/netlink: Document the netlink-raw schema extensions
  tools/ynl: Add mcast-group schema parsing to ynl
  tools/net/ynl: Fix extack parsing with fixed header genlmsg
  tools/net/ynl: Add support for netlink-raw families
  tools/net/ynl: Implement nlattr array-nest decoding in ynl
  tools/net/ynl: Add support for create flags
  doc/netlink: Add spec for rt addr messages
  doc/netlink: Add spec for rt link messages
  doc/netlink: Add spec for rt route messages

 Documentation/core-api/netlink.rst            |    9 +-
 Documentation/netlink/genetlink-c.yaml        |    2 +-
 Documentation/netlink/genetlink-legacy.yaml   |    2 +-
 Documentation/netlink/netlink-raw.yaml        |  410 +++++
 Documentation/netlink/specs/rt_addr.yaml      |  179 ++
 Documentation/netlink/specs/rt_link.yaml      | 1499 +++++++++++++++++
 Documentation/netlink/specs/rt_route.yaml     |  327 ++++
 .../netlink/genetlink-legacy.rst              |   26 +-
 Documentation/userspace-api/netlink/index.rst |    1 +
 .../userspace-api/netlink/netlink-raw.rst     |   58 +
 Documentation/userspace-api/netlink/specs.rst |   13 +
 tools/net/ynl/cli.py                          |   12 +-
 tools/net/ynl/lib/__init__.py                 |    4 +-
 tools/net/ynl/lib/nlspec.py                   |   31 +
 tools/net/ynl/lib/ynl.py                      |  198 ++-
 15 files changed, 2699 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_link.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst

-- 
2.39.2 (Apple Git-143)


