Return-Path: <netdev+bounces-20917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5296761E58
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75481C20E02
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B432417F;
	Tue, 25 Jul 2023 16:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66B1F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:22:24 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3211A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so8866333e87.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302140; x=1690906940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kALScSudc4ZvsfbM8+kpg1S9XHzm0ZoZelo2+24lvqg=;
        b=H3So+5fSbkRHct92E89YPKrj734Ydo5lwhXLCaiTLFSGLHxYZThDiThaAsqlix3ArI
         B/1TNgpHsgUQyff319VnegXC8t4nnfDgXAuek4uJ8I1ECNvd19Hzu4WQpE31wUi7tzmg
         70oPV7TVAmafimSHerAF3AobMjMnZhkFXVxxF4wg5JmWCQtjq8IxdCf0e7EafExPomrY
         0SrYxsc3GI7lfdFTnvq1nrDu6jsJjAdKh/x6gbM1emJNjHFdquyp25bG/FelcYCgi2Bb
         kbEmiS4Ktmij21oVS/POUg+Hk5adwh0yB61nBbcec7UrwuJ2EjA0elEGFWvAU5v9fmxA
         0y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302140; x=1690906940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kALScSudc4ZvsfbM8+kpg1S9XHzm0ZoZelo2+24lvqg=;
        b=EqeGgdx5U1Uqb0iwyR0ueh7VUrg46AIPRqWcsiCTjWcYpNkPDivfEd7s4nwR4VuDxH
         vXsk9wWN2UOtE19Q1yHAtZLunIPENUeUrwg7NbnBLA1mbhvnO77fV80x/8mm9XfoyYIN
         EG3dSTsqnuJELPf8pagtK7hZL8vrrebzgFuq1hZBlLVhM8sPXXoP4ObLwUuTwN5IQIrT
         iI4GkZ45WT5UsRSEolz0v/kTbUeX+zUxh9VKIOIS2PgntcUqbebIgF8Sq0RZktJeH8xN
         2TLhUg/aVqWaaw7PkMD1ibllMR2tXw1B0CXuAc0zL1U5ToAw1Yb1ZtzZHTR/1g+XnJ4y
         wJGQ==
X-Gm-Message-State: ABy/qLYCtqlea1IArSwKAFNh2DYbfDPG22wbm8FlNSaw6EgAMQeFxHWr
	WXx8NtPJ9VtAXKUGHrOVJM+x5rSnWS6irz+v
X-Google-Smtp-Source: APBJJlHBfH41cH42NFV1UM+MKZBJ4xTdsZW+3tNh5ft8VJQydB2FsmdEAiyFf+H/Ls633JKSuClpfg==
X-Received: by 2002:a19:4357:0:b0:4fb:8dcc:59e5 with SMTP id m23-20020a194357000000b004fb8dcc59e5mr7122373lfj.39.1690302140134;
        Tue, 25 Jul 2023 09:22:20 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:255e:7dc3:bcb1:e213])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c294300b003fc01f7a42dsm13661303wmd.8.2023.07.25.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:22:19 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/3] tools/net/ynl: Add support for netlink-raw families
Date: Tue, 25 Jul 2023 17:22:02 +0100
Message-ID: <20230725162205.27526-1-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds support for netlink-raw families such as rtnetlink.

The first patch contains the schema definition.
The second patch extends ynl to support netlink-raw
The third patch adds rtnetlink addr and route message types

The second patch depends on "tools: ynl-gen: fix parse multi-attr enum
attribute":

https://patchwork.kernel.org/project/netdevbpf/list/?series=769229

The netlink-raw schema is very similar to genetlink-legacy and I thought
about making the changes there and symlinking to it. On balance I
thought that might be problematic for accurate schema validation.

rtnetlink doesn't seem to fit into unified or directional message
enumeration models. It seems like an 'explicit' model would be useful,
to require the schema author to specify the message ids directly. The
patch supports commands and it supports notifications, but it's
currently hard to support both simultaneously from the same netlink-raw
spec. I plan to work on this in a future patchset.

There is not yet support for notifications because ynl currently doesn't
support defining 'event' properties on a 'do' operation. I plan to work
on this in a future patch.

The link message types are a work in progress that I plan to submit in a
future patchset. Links contain different nested attributes dependent on
the type of link. Decoding these will need some kind of attr-space
selection based on the value of another attribute in the message.

Donald Hunter (3):
  doc/netlink: Add a schema for netlink-raw families
  tools/net/ynl: Add support for netlink-raw families
  doc/netlink: Add specs for addr and route rtnetlink message types

 Documentation/netlink/netlink-raw.yaml    | 414 ++++++++++++++++++++++
 Documentation/netlink/specs/rt_addr.yaml  | 179 ++++++++++
 Documentation/netlink/specs/rt_route.yaml | 192 ++++++++++
 tools/net/ynl/lib/nlspec.py               |  25 ++
 tools/net/ynl/lib/ynl.py                  | 185 +++++++---
 5 files changed, 941 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml

-- 
2.41.0


