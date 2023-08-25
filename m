Return-Path: <netdev+bounces-30651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84533788747
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394CB2817FC
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C9D302;
	Fri, 25 Aug 2023 12:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C760D50B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:28:54 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9990D213C;
	Fri, 25 Aug 2023 05:28:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so7476855e9.3;
        Fri, 25 Aug 2023 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966487; x=1693571287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxh0TqxVtXcaHq0ylMyXcEO5QFWRVlnRQVhYAyUGSSM=;
        b=pOlyHx6fkbCvacawyams8ZM3EuF5a/sPJNj+VQeXjESUdEyR8MZDlkn/3esa+MaWQS
         UGzcJg5AmpI6z0cSE1QKvLCRsd2xG5EQnuTl9x+vSST7VHotzn0tRBl6H6e/H5q3COCY
         rcdBkEdxvGmektbRnwllCzxTx+6od4LFTPwb8h+wH9F092LYNP2sNh/82QQ0MGUSWwgH
         0/JNJ06c8X+iB0ycLsmaBhcbhzj8ifjeMQcyLqr7MCjwSyxm9hQhoFpHq9E9ORuYvc2i
         bHqfduk1OqzcDcr7a6eNppQxQYF1zIoVywjM7CSfbHQy5J8LdJu6OvJoxNkKLz1WBwwS
         fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966487; x=1693571287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wxh0TqxVtXcaHq0ylMyXcEO5QFWRVlnRQVhYAyUGSSM=;
        b=jpu/r7/A5vRnxkDZQN2v9PqUEBIiBcqmHXq+ZmUX+V5oEV97ir/s1M/qJmq8aIDdqO
         mkMCFv+zB8TjDljXdcUkX3pFWfGwZDlaFK4a5X+NCnuJSDYAkpW9lZGbcf226x6mac0s
         1RNPIttY+sshxbeTB0NjrpVm15MUx72AIBFjEjyjs1pNZF5G9ndeYlBJWzrfzMzmhCiO
         VkmWev9nXZ5jn38fvrXyUdFJ1V4krgYn/sxCbsJW8F0+o7Ew6243DnCgd+Zh4kd7xI41
         ynpE6RZ5MSKFwB8V2gNBHiV3PFv0n1E9YiIesHiRWxPWHErqWY0NL0s/DbLKcyzBP6h1
         j07A==
X-Gm-Message-State: AOJu0YyIi7ylBebfdDGAVN6uK2WCO3e49jnnAcLxQkUD6tqC8UCZdY42
	GuHuT5aoI8pUnXN4HeZqYu+eX+AmoEE+Wg==
X-Google-Smtp-Source: AGHT+IEiThaZDDRW8eH1RMVXmUVcT61Ga0wN1iZ4kGw9Bsg0oay7afRmadpuhLfTio4p6waYawnluQ==
X-Received: by 2002:a05:600c:3795:b0:400:419c:bbe2 with SMTP id o21-20020a05600c379500b00400419cbbe2mr5325684wmr.24.1692966486483;
        Fri, 25 Aug 2023 05:28:06 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:05 -0700 (PDT)
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
Subject: [PATCH net-next v6 00/12] tools/net/ynl: Add support for netlink-raw families
Date: Fri, 25 Aug 2023 13:27:43 +0100
Message-ID: <20230825122756.7603-1-donald.hunter@gmail.com>
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

v5 -> v6:
  - Remove explicit value definitions from link-attrs in rt_link.yaml

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
 Documentation/netlink/specs/rt_addr.yaml      |  179 +++
 Documentation/netlink/specs/rt_link.yaml      | 1432 +++++++++++++++++
 Documentation/netlink/specs/rt_route.yaml     |  327 ++++
 .../netlink/genetlink-legacy.rst              |   26 +-
 Documentation/userspace-api/netlink/index.rst |    1 +
 .../userspace-api/netlink/netlink-raw.rst     |   58 +
 Documentation/userspace-api/netlink/specs.rst |   13 +
 tools/net/ynl/cli.py                          |   12 +-
 tools/net/ynl/lib/__init__.py                 |    4 +-
 tools/net/ynl/lib/nlspec.py                   |   31 +
 tools/net/ynl/lib/ynl.py                      |  198 ++-
 15 files changed, 2632 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_link.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst

-- 
2.41.0


