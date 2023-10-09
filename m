Return-Path: <netdev+bounces-38978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53E7BD521
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA521C20860
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85591171E;
	Mon,  9 Oct 2023 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Ry1Omq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDC9CA46
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:26:17 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D619F;
	Mon,  9 Oct 2023 01:26:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53406799540so7606844a12.1;
        Mon, 09 Oct 2023 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839973; x=1697444773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjtzaobE14kySBWrJ30dRxeESe/MopqKn+1Th2lCI/M=;
        b=J8Ry1OmqRpVX40U4NfOdGXKBhx4UCINE/DSduntgZb82c2LYklsqt4rPoFl9+qgTXN
         K8o1IdYD4NrQj2QXGFVkxz6ZBAtACWoK/leCcxHaOqfOcAo/BrfcSA9FcfdLMJFIfPOq
         bvP4nEkzq96RKpASdjr7M5xnDFI+gYkl83al/YB0Q0AhYwCuplk/6Sh5qfvqCK9uB1ig
         fY0m6y2K7+UT/tBTsilTO/NeKhpagJj53A5g9nXzB0vK1V+iyovblCL5rXtT+u/R209O
         FYdnhgw7K3Qi161nqpkfNSK/vju1S7/IhWBvzMN7wiZIURCFs+7QFk3qd8mzVmRsZPSF
         czUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839973; x=1697444773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjtzaobE14kySBWrJ30dRxeESe/MopqKn+1Th2lCI/M=;
        b=f6lXKutJBh8vb134/utpvmUDrmeQdq+moe74xoDZdgKM23JOHbtKwe2Av8jSB47COZ
         SjaMrAVqCTBQPSnbnqOdN17SJNo2H5mN26HBrQLOfkIM8eGtN+cncFlcCsSWWPNy8apR
         5xj689zOJHIk0mHh0n+TtQDIicvk+Bknt7/4ckjSdLP91NvkBMPQ6SA3v0UYjbiYUryO
         DE2zqkKUtcgIRl4qJaFC7QItny9WsmiV4jWGkcV0zEiIrmyVRGwAm4APSsfZQtdBtyF9
         jJbPhN/EMzlWRhXBqt4nE/cClgiBvdib49LX7Xa3jXYLWmjOl5BZgK+S3aLIKS8Aec7Q
         TbRg==
X-Gm-Message-State: AOJu0Yw+AV5krM3trLFRG/FbNvGzp5h97/AUXX3eXPe8m/l1rq3twry7
	GjBS2HDR19x1ECwpWbS2IE1DBkYmUYc=
X-Google-Smtp-Source: AGHT+IE2Il0HhJSJEe/lijyCp6b3SlK2RucHHrX7ubXBWOx1ln7dmo3YWUNTklFr1z523dJRQyS9nA==
X-Received: by 2002:a05:6402:690:b0:533:6379:afaa with SMTP id f16-20020a056402069000b005336379afaamr13271862edy.20.1696839973560;
        Mon, 09 Oct 2023 01:26:13 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:13 -0700 (PDT)
From: Beniamino Galvani <b.galvani@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: consolidate IPv4 route lookup for UDP tunnels
Date: Mon,  9 Oct 2023 10:20:52 +0200
Message-Id: <20231009082059.2500217-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
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

At the moment different UDP tunnels rely on different functions for
IPv4 route lookup, and those functions all implement the same
logic. Only bareudp uses the generic ip_route_output_tunnel(), while
geneve and vxlan basically duplicate it slightly differently.

This series first extends the generic lookup function so that it is
suitable for all UDP tunnel implementations. Then, bareudp, geneve and
vxlan are adapted to use them.

This results in code with less duplication and hopefully better
maintainability.

After this series is merged, IPv6 will be converted in a similar way.

Beniamino Galvani (7):
  ipv4: rename and move ip_route_output_tunnel()
  ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
  ipv4: add new arguments to udp_tunnel_dst_lookup()
  ipv4: use tunnel flow flags for tunnel route lookups
  geneve: add dsfield helper function
  geneve: use generic function for tunnel IPv4 route lookup
  vxlan: use generic function for tunnel IPv4 route lookup

 drivers/net/bareudp.c          |  11 ++--
 drivers/net/geneve.c           | 111 +++++++++++++--------------------
 drivers/net/vxlan/vxlan_core.c | 103 +++++++++++-------------------
 include/net/route.h            |   6 --
 include/net/udp_tunnel.h       |   8 +++
 net/ipv4/route.c               |  48 --------------
 net/ipv4/udp_tunnel_core.c     |  49 +++++++++++++++
 7 files changed, 141 insertions(+), 195 deletions(-)

-- 
2.40.1


