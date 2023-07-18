Return-Path: <netdev+bounces-18543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80B757928
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25F22814A0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813FFBFD;
	Tue, 18 Jul 2023 10:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91DFBF9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:18:02 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E971B6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68336d06620so5568173b3a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689675476; x=1692267476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y7jUOVKBjqyQ/TJgMYGI/tXWQ1G0H8dJlgsa6FckGI=;
        b=bU1voPVjtnutN4KosyhYnTMXQwj6J5WdruXcGfbTTWwHezSV/4eeIwihFkmxsXMqzG
         mWQqaknMIeuKT1qTVypGAd09pEO8kAoPou4YbYDYEbPa1adY1WG3ZAKclHRdcitqw9UR
         S1MVWz72NXhOLrDEknCUAjOA51DGI3WAD494FRM56yUosXuuR+bS+3IZDQ/A9IYfeGe+
         nGDrfEvRGr+cfO/t9jMTlHw8uyllElNjRTOmqSMvzha6ZuQxcOj1AmuKjKjS+AIFb9Qm
         A2PDLBLTzWNFtKUK9AGxiJhZdEWBqvVTzgpzMavyb0mOGNvHkoPZbSGKmdpWoi7GO68q
         staw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675476; x=1692267476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y7jUOVKBjqyQ/TJgMYGI/tXWQ1G0H8dJlgsa6FckGI=;
        b=NUFQ+kgtcTcec5FztFG1L57v6GzmpWCX/zFQjoXocTD0hRmkz8NAMSL4rvivC+acc/
         Hlktotr3eV7sO/K2OAOrSedUzMmBnJbzK/YAa/IJ+Esw3ABM1BJmvnabtkWL4uDtNjiB
         xiNNR+kyIkx1OI7YR+6jm50NIiIvLP0LTZTdVIeoLSB1bsZPRW2OkCPbvVhaI/tYc9D5
         mBxfIMZm3JuV4ZkFLs1V8LWm+V93qy25fl8KA+T8VjUWHKYNIyoO9fNp+ZaE0VLTRLbc
         L0k5+d14LEW//sULiaTFXrwwaKJQ0igVbk1W8Kki/ivSM3lebhTioEbWIh8xQK6hHQBF
         Tj6w==
X-Gm-Message-State: ABy/qLYWX+xgkSo3qJFmOzQx18CAb1/k6lUJ8yMnam0ak8q23dbQtfTY
	pc8wYNbHMGEKoe9SnXla4q7jfPNYQrf4+sMv
X-Google-Smtp-Source: APBJJlHxWTkZ1OA3BNxaDHdfptySZ3ur+WdDFmtop5cl94AqeqEYMR+eCY2rHFDf08LZizxxa2ovRA==
X-Received: by 2002:a05:6a00:10c9:b0:682:4c1c:a0fc with SMTP id d9-20020a056a0010c900b006824c1ca0fcmr18598293pfu.19.1689675475901;
        Tue, 18 Jul 2023 03:17:55 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k16-20020aa792d0000000b0063d24fcc2b7sm1239023pfa.1.2023.07.18.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:17:55 -0700 (PDT)
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
Subject: [PATCHv3 net 2/2] team: reset team's flags when down link is P2P device
Date: Tue, 18 Jul 2023 18:17:41 +0800
Message-Id: <20230718101741.2751799-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718101741.2751799-1-liuhangbin@gmail.com>
References: <20230718101741.2751799-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding a point to point downlink to team device, we neglected to reset
the team's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to team device. Fix this by
remove multicast/broadcast flags and add p2p and noarp flags.

After removing the none ethernet interface and adding an ethernet interface
to team, we need to reset team interface flags and hw address back. Unlike
bonding interface, team do not need restore IFF_MASTER, IFF_SLAVE flags.

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: add function team_ether_setup to reset team back to ethernet.
v2: Add the missed {} after if checking.
---
 drivers/net/team/team.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 555b0b1e9a78..2e124a3b81d1 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,20 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
+}
+
+static void team_ether_setup(struct net_device *dev)
+{
+	unsigned int flags = dev->flags & IFF_UP;
+
+	ether_setup(dev);
+	dev->flags |= flags;
+	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
@@ -2158,7 +2172,14 @@ static int team_dev_type_check_change(struct net_device *dev,
 	}
 	dev_uc_flush(dev);
 	dev_mc_flush(dev);
-	team_setup_by_port(dev, port_dev);
+
+	if (port_dev->type != ARPHRD_ETHER) {
+		team_setup_by_port(dev, port_dev);
+	} else {
+		team_ether_setup(dev);
+		eth_hw_addr_inherit(dev, port_dev);
+	}
+
 	call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, dev);
 	return 0;
 }
-- 
2.38.1


