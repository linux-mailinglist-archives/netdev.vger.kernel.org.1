Return-Path: <netdev+bounces-29893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BC785159
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE76281065
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA99882E;
	Wed, 23 Aug 2023 07:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7298467
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:19:15 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0CDB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7a6509deso19996515ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692775153; x=1693379953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNcQc3Mo3KFQXGR8qTFEk/EAPbT240Qm7HbWEwKTIEE=;
        b=DLOW4n1Es1sY/aAr2Zm7Tfvm2JGeB7yc9atFRgUcg3MXmpNOm8H19swJMaFt3TDvXq
         c26Ys8WUT6ul769ZsPTzgqOMoC+ryOcHCP7+u0FFQ3gYiTgH6pCNmSBeNZe6nHbBGv3h
         JnHbEW/m8dRvR1AokbvOS9AeCQspg8orOu1XLRnzgslEiOVj41DouGH2NKsC2s+EPNVo
         Dn/T1CQIdgTm9G38ABbz0o9NZ6YCLtFx05uvbK8G+P7ARQ71i2pEW+uVdXg8MIqSPPRq
         k+WcmI/UwBIWxTRd/XY1yAgrUdLxXNu3EwuBRtG2X84a7T+Q74UbimrFQ2Wr3d/6xixA
         DBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775153; x=1693379953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNcQc3Mo3KFQXGR8qTFEk/EAPbT240Qm7HbWEwKTIEE=;
        b=gtQmnpbaINuKxt0zKZdq6UvJGk6auhPSu73/8M0pC7yKIJeBvtlUkY7Oan1cn+cM/g
         WugCxZEJmVndvMAqRZZEBKDBjeqN/N2ZoMt+iKDxwH7BMsJlFUFtpywIlHsWgbaGtrF+
         OXo1zNQyLAruFtK3QUNDH80tadWp1oGJCAZrBlrj/dHsWKWdRF9DMwSfw079ZOEVfE5J
         WdeCFJQ0CFNW/x3egYh/EyQvxfiscc+piW1o0iNquP8NsnH6FRIm0kzmVAsrsqyAf1Vk
         1ts7GuJf3dweDzxgAGuoNMsXTqsvUlYfS+/F4ZhrNY9RD6A+ZXTK2qufvINq7PWgdajI
         827g==
X-Gm-Message-State: AOJu0YzZcqwLbqZ1JIvUOVP9C8bhRFF4M6R5EqVZYibZvJ/2BmLO2p+3
	OvcitikSmHXh2DnRm9mSf5YzNvJ+VwVSVQ==
X-Google-Smtp-Source: AGHT+IEOuNYf8hYz75UmE2nqaRfnocatFBHLAMrqNuMABI+zyMkPI3RyQ/kTTvHJlu6cs/ljPGIKTw==
X-Received: by 2002:a17:902:b709:b0:1bd:a0cd:1860 with SMTP id d9-20020a170902b70900b001bda0cd1860mr7919950pls.64.1692775152897;
        Wed, 23 Aug 2023 00:19:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bdea189261sm10221212plb.229.2023.08.23.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:19:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/3] fix macvlan over alb bond support
Date: Wed, 23 Aug 2023 15:19:03 +0800
Message-ID: <20230823071907.3027782-1-liuhangbin@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the macvlan over alb bond is broken after commit
14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds").
Fix this and add relate tests.

Hangbin Liu (3):
  bonding: fix macvlan over alb bond support
  selftest: bond: add new topo bond_topo_2d1c.sh
  selftests: bonding: add macvlan over bond testing

 drivers/net/bonding/bond_alb.c                |   6 +-
 include/net/bonding.h                         |  11 +-
 .../selftests/drivers/net/bonding/Makefile    |   4 +-
 .../drivers/net/bonding/bond_macvlan.sh       |  99 +++++++++++
 .../drivers/net/bonding/bond_options.sh       |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
 7 files changed, 272 insertions(+), 127 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

-- 
2.41.0


