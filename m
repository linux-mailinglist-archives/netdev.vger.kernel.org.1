Return-Path: <netdev+bounces-29778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B9784AA5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115B228115A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D760F34CCB;
	Tue, 22 Aug 2023 19:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959D1DDE3
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:22 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73C10F;
	Tue, 22 Aug 2023 12:43:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3ff0056c8e9so1540015e9.3;
        Tue, 22 Aug 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733398; x=1693338198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0m5gXsoY4zRt8C8Ge7ktz0yFqqdgGux2KQODtchpq8=;
        b=Z2A/Ummf+2kA2raBhhx0bShaVMTo/Kn5X8C44xQ/TTI/UgiFlg1R0rOPl8rAeZ7fl0
         nkvTjZpWvw+JcxhJa0LewhFxGpi61UQgV61hVzmK/3saLP9V17ieCXYsz6eI5kQOkUPO
         JmZzNwAXPKAFBcob886RkFvzmZlEon5kZx8atgri4ZB0IxEPVYFkd9ZgfHCyOa/ZkHMS
         FrneI3yIbnHLIOzuDRffA9SCDG4am7pkC9/CkoTyPCX0NSTGQNePUwLRcrfOieR7d1BQ
         dK+CeTAX9DUTfbLY/ixJyyJ/ddQnaMu2xnlSXm79q7CB0+UIAfs9C9zE1RE3yiqRy9mS
         Juhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733398; x=1693338198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0m5gXsoY4zRt8C8Ge7ktz0yFqqdgGux2KQODtchpq8=;
        b=G0SoVHwoeiKMV7akIsc+1tkifPyT6jKoxndHd0QPaXTWjXlvh31wh1p6gNC9zdyINj
         vkvHCfNIn77zQgng/D/8W1B83C4hoNMMpum5PkcmSw+RT5y2hzkkRJKX813BNT/l88FV
         JPdBFB83OHMIAkmz826DJwdW0y33cu1xVHJfau4KbCiAFoeMyrYAaM0N2HzmgaryeXj7
         sRkFSO+N/PAlEh3S5ICJVhRJcbbDiaVaWthkBFf3Q3IlDC6Ag44i6Uk5YBnVbfhudJwt
         87SgzLPypxSrh+AhnkcvcsHwVda6LG26MzbHZY5oI1H7wRI6BvxbzxP2ZwKIjXuZEHXZ
         swlw==
X-Gm-Message-State: AOJu0YxRXW2zF4WUQFDK0Ds8AP7tN6ZdvFqg9uAfYWdhK9gaO80mwUhS
	2FC/FrittC/zbsHAlnnohXlKUoJXP6iYLQ==
X-Google-Smtp-Source: AGHT+IF2Rh9mkBxUgzL76esKU0BGMZm1k8y91smObasaWHvXgrjj4uvnPoiNlBvlKrj+PtF5QU12kQ==
X-Received: by 2002:adf:f985:0:b0:313:f5f8:a331 with SMTP id f5-20020adff985000000b00313f5f8a331mr8323266wrr.34.1692733397847;
        Tue, 22 Aug 2023 12:43:17 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:17 -0700 (PDT)
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
Subject: [PATCH net-next v3 00/12] tools/net/ynl: Add support for netlink-raw families
Date: Tue, 22 Aug 2023 20:42:52 +0100
Message-ID: <20230822194304.87488-1-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/netlink/netlink-raw.yaml        |  414 +++++
 Documentation/netlink/specs/rt_addr.yaml      |  179 +++
 Documentation/netlink/specs/rt_link.yaml      | 1376 +++++++++++++++++
 Documentation/netlink/specs/rt_route.yaml     |  306 ++++
 .../netlink/genetlink-legacy.rst              |   26 +-
 Documentation/userspace-api/netlink/index.rst |    1 +
 .../userspace-api/netlink/netlink-raw.rst     |   58 +
 Documentation/userspace-api/netlink/specs.rst |   13 +
 tools/net/ynl/cli.py                          |   12 +-
 tools/net/ynl/lib/__init__.py                 |    4 +-
 tools/net/ynl/lib/nlspec.py                   |   31 +
 tools/net/ynl/lib/ynl.py                      |  196 ++-
 15 files changed, 2557 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_link.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst

-- 
2.41.0


