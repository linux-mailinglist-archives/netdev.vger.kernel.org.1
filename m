Return-Path: <netdev+bounces-19716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E075BD11
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716161C215F3
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AC81E;
	Fri, 21 Jul 2023 04:04:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790377F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:04:15 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5C1BFC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2632336f75fso879182a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689912253; x=1690517053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu40FYf4l16wl+LuNHGFQ31ZyL4l6RFv71xxNKtpWTg=;
        b=gDG2UQ3Y5GmywxAfp4w8pbCQSI4sK7NkUE/eftLIlP6Dc5XpUXW061VnILiTwrR8VV
         TSzGHpMgoRw0ofZLpWwC3REYKDk6YSVctPyvIZAD0SODYiDHVZHxqCIRz0lVa+8piKWu
         zPhnzvqdxtsFEIvY+WhlBL40b5WnXRL0P/5sKLwBl4A4MP3EYpATUXf6Htf4M96DDiC2
         lBxzUwjAbwEz8Rf9soHDs2H0jf8WVKM+YiHNCkjFRRqTHSpiG9JGtYCcVWmkUEKfQmLq
         iK4I254cBfIFr5hqvQ7fqZbeVpBGnURkJ1ivBDfVZaXFAgHwZuvri+k4UrPhKny/YIyC
         fU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689912253; x=1690517053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu40FYf4l16wl+LuNHGFQ31ZyL4l6RFv71xxNKtpWTg=;
        b=gPgHgDPnSaFJmtGLcybewt3LKJ1f+hkfwmiGnUgx6ZQJ3OxrjQRdwOH9sNc/fYUHme
         v4dJrtaxE/ph8i4gbWXZAKpSc7WxHef7+T+3c1XSZ/0o/tm7tTZ6ric+odShbi+/ywr9
         3ji2tdwCJEYpI3L/tzTXAlXLXNgNdgTaWop/sTWHj2zaQgfM6hspRIxYWxiC9+6+Rdcp
         7+Y2uAuE4JetnSZ3OR3RaH4lEWJBNlKUJ+7zOVQBl+SDs2+Y1eU/dMRugKw2ZDDklESl
         Hu1rjUDHW85FgmLbZHsZcmN8gL3FZzZKK1edQFm2EKwFz+tbhI324nCxE4irnn3MJw1a
         1X8w==
X-Gm-Message-State: ABy/qLamkMXI3Ma4n6Kb+Z2WVs0F511FgH+98jJ5wCHfT1Y8ecPUpdu+
	78T0qVJms+3BTALznSx8IJHAry1G4MtxQQ==
X-Google-Smtp-Source: APBJJlGK4wk540ps49SvUpFF/ivrSxuDDXWJPxpzPCPyQABrPoHdMHHbByE0Huh0cHD+MH0rKur6vQ==
X-Received: by 2002:a17:90a:b283:b0:262:e3aa:fd73 with SMTP id c3-20020a17090ab28300b00262e3aafd73mr608705pjr.17.1689912252934;
        Thu, 20 Jul 2023 21:04:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b00263f6687690sm1640480pjb.18.2023.07.20.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 21:04:12 -0700 (PDT)
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
Subject: [PATCHv4 net 1/2] bonding: reset bond's flags when down link is P2P device
Date: Fri, 21 Jul 2023 12:03:55 +0800
Message-Id: <20230721040356.3591174-2-liuhangbin@gmail.com>
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

When adding a point to point downlink to the bond, we neglected to reset
the bond's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to the bonding.

To address this issue, let's reset the bond's flags for P2P interfaces.

Before fix:
7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr 167f:18:f188::
8: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/gre6 2006:70:10::1 brd 2006:70:10::2
    inet6 fe80::200:ff:fe00:0/64 scope link
       valid_lft forever preferred_lft forever

After fix:
7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond2 state UNKNOWN group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr c29e:557a:e9d9::
8: bond0: <POINTOPOINT,NOARP,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2
    inet6 fe80::1/64 scope link
       valid_lft forever preferred_lft forever

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: no change.
v3: no change.
v2: Add the missed {} after if checking.
---
 drivers/net/bonding/bond_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7a0f25301f7e..484c9e3e5e82 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1508,6 +1508,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
-- 
2.38.1


