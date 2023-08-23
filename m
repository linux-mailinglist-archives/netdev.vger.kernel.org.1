Return-Path: <netdev+bounces-29987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74E7856E4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315AA1C20CB3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B68BA57;
	Wed, 23 Aug 2023 11:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED834BA51
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:18 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DECD0;
	Wed, 23 Aug 2023 04:42:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so51399445e9.2;
        Wed, 23 Aug 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790933; x=1693395733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXiZ15W//u92mQp7Srkx/sF9TvvBAVltsBBNXQOl5jY=;
        b=aq5IJEGJwkLprDPQ6hzr4HgQPQeTqZOtPYha7zQr20Sj7NPVYiVzmL84p/30Yeyrrf
         2gNOPeQMdRUbF7k4QrK71cxS0KCfJBNZYBjMG0mj7zhzPuWPS/ABeDioHuYKu+kJg7k7
         euTgWqaxZbpnsIdx64i1nTQTZ56CixxMUai35CQ7XWm70Ry9YPDkkl1k6k22qd93kAhJ
         M6bIWPbtE1cXdiy4Mt0iI3QchdDjqHFa4VlxlpUBWGjG8w6YZd4TaGoA5Jy9gqXKLbgy
         Rl+t/xUNfergGM7rQRZ6A+6olp5NmsTpyt2+wkAFDi9JONM7ptGyEj6exphCHrhHPwNM
         KHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790933; x=1693395733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXiZ15W//u92mQp7Srkx/sF9TvvBAVltsBBNXQOl5jY=;
        b=DlffdmC1LQ260WJnEFQIZ45SHM9PxbkDd1Aouu3lpY9a4uQPgRsqxs4UrkaYHCu8i2
         y5V0PLy661U6j5FQk8aVd66ByLOvT5ZTf9sT73s+juZ0FIOQbz4UJr94i+CTceE7tGUe
         Pd9Vpr2SV/TZp5nSCwTg4NeLN/lwRgYrx0u3mb0rs+s7YiAQYFWfD4DIGg1jkTu6mPPd
         vM8NN0Gaj1emZwxsjNHuwdjsOIoAEDwyc8WIkNwJ01cFfLalMjV4ELh93YxPNMfb1JJL
         2EBfNlTknMJXA+Fjine1nPHvBJUPm9ts8uSM9iPjEl0Yhpki2K3mXjIGxKTprD+6eJmv
         WX9w==
X-Gm-Message-State: AOJu0YxRjL414vajlI1gJjrQroA7smnLkq0vpVY8930k2vpeOLB3essa
	8b5htXzvbRT+ZUEKZUP0D6OKC9DogrRo/Q==
X-Google-Smtp-Source: AGHT+IH4cOHkzIjohlG/PNwp2jq4p1qcHhelZv7T1WD5LFpt2YXcq7qV/a/XJPFz7QNO/l4MhBWHGg==
X-Received: by 2002:a05:600c:2211:b0:3fc:80a:cf63 with SMTP id z17-20020a05600c221100b003fc080acf63mr9772392wml.38.1692790933261;
        Wed, 23 Aug 2023 04:42:13 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:12 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/12] tools/net/ynl: Add support for netlink-raw families
Date: Wed, 23 Aug 2023 12:41:49 +0100
Message-ID: <20230823114202.5862-1-donald.hunter@gmail.com>
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
 Documentation/netlink/netlink-raw.yaml        |  414 +++++
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
 tools/net/ynl/lib/ynl.py                      |  196 ++-
 15 files changed, 2701 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_link.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst

-- 
2.41.0


