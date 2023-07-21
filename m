Return-Path: <netdev+bounces-19717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD7A75BD12
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EDA1C215F0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16867F9;
	Fri, 21 Jul 2023 04:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598C7F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:04:18 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919721BC1
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262f7b67da8so820805a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689912256; x=1690517056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/tMk6LKzIoo6vJXJHVG64sPPKUXgW1KwB7m/idCZTo=;
        b=DsOdmCCWiZvPphh3SE707GETF9JuJIx4D1VEoUi6xU3yFUjtAo6cdhbeOBF2fmTi0Z
         AB4nhGTf9nRdmWdlnI5+WKpiyPRvGYnqnwS0T0ykbrYyiomswyWJbaOgYUMRb3TAN9Gy
         3Z2bprauOGdVcLXK1ivpGWJgPiZ9Xmqv/8jvPbUUWrZdYz9/7HGHAGFCupVeuEebE9J9
         69ZJdbFVldVpuLpd96xmD/43WPYWB+ZuzCEMFpbqWJbxslKD8D5a8nlZQL38jGYFJ6mp
         sonB2tZV3SsPpQqLJG+iNGAGUjAIxrVNOzZrPiX0uo084J+0I4+qq7CBXN6yRndKHg8p
         rjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689912256; x=1690517056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/tMk6LKzIoo6vJXJHVG64sPPKUXgW1KwB7m/idCZTo=;
        b=is4aS4GIx4s8WBodglW38E13+mGJevneuKMe0kAcJi5yn6aL29aHWNxVXSIQakv5/d
         Y3/ANKxXBfTQ7098EB8Nx6dKzXlKz9FSUK3xLh0P74IN1PlHo4YthcvcGUKWFUgCkpI4
         zPVve2OI5C3dNukXJFpA/8LVuflxNmoVVKwbndUDWu9y4eW/l9EC19mjZ0f6c75QTLy/
         HJUBI4THvgZzieGy3BU7UPzrdRSBJid8Sd7UZOYIl0iUPaxT39vcuRhXP1q45gQ+Uzjv
         XoM9WB0GMB/pvG2tSfsZ97wxbMQWHip9+wj9yOdKzrFt00cqBYagilqDiN6DC2IM1Sv/
         UpMw==
X-Gm-Message-State: ABy/qLZKocDIILA1M+7HnjSHvqV7jWXsf09+v4f9wzrKlPovLDjeh1d9
	TwEHZI0Txj36R0cTlRplm53TUcaBX9pPTg==
X-Google-Smtp-Source: APBJJlHneyifNhW1esLF1BZX2fUAeet+bn2B2Syb2RQqfojinbT+UwOCPErcIyNZR29LoLnL2l/wvA==
X-Received: by 2002:a17:90b:fc9:b0:263:cdc4:5e89 with SMTP id gd9-20020a17090b0fc900b00263cdc45e89mr497631pjb.8.1689912256562;
        Thu, 20 Jul 2023 21:04:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b00263f6687690sm1640480pjb.18.2023.07.20.21.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 21:04:15 -0700 (PDT)
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
Subject: [PATCHv4 net 2/2] team: reset team's flags when down link is P2P device
Date: Fri, 21 Jul 2023 12:03:56 +0800
Message-Id: <20230721040356.3591174-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230721040356.3591174-1-liuhangbin@gmail.com>
References: <20230721040356.3591174-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding a point to point downlink to team device, we neglected to reset
the team's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to team device. Fix this by
remove multicast/broadcast flags and add p2p and noarp flags.

After removing the none ethernet interface and adding an ethernet interface
to team, we need to reset team interface flags. Unlike bonding interface,
team do not need restore IFF_MASTER, IFF_SLAVE flags.

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: just reset the flags, no need to do ether_setup(), as Paolo pointed.
v3: add function team_ether_setup to reset team back to ethernet.
v2: Add the missed {} after if checking.
---
 drivers/net/team/team.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 555b0b1e9a78..d3dc22509ea5 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
-- 
2.38.1


