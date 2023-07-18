Return-Path: <netdev+bounces-18542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B597757926
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C3D2814D7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43978FC0D;
	Tue, 18 Jul 2023 10:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF61FBF9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:17:54 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524810C0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5542330b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689675472; x=1692267472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REOptyezVOiw+1gsTKZNVuJpG4hek0R/RdZkNrLICU4=;
        b=K7kdbO751oIaSuY9fRaJ7sx03Dr2IzpAP7varpTFsa74Rmq3rvPeLldHRMDP70BCZk
         WvBGsyIP6ybOp0TTHEfCU+cQ1uSkcMxypB46fwTdNUTrPNeNlC0VSmeIVBx7mSqotv88
         aSe55ymv+R6MgVUPOpj+6QiID7C+G12u2lhVroI5Vtgz2atj99xyBe2sueIGnPXF2aa4
         gSFbRySNfmiGMlJnMTmoK3JgesVkMrP8HGhFhtEImpikhfabSudZhgrlWaNloXwa33zj
         CLZFl91PbkolIM2g1VIY+xVf3uhcwoUWDdUZdrZikGq0NPd9hJVMWqw6nwoe8NFcdQML
         OUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675472; x=1692267472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REOptyezVOiw+1gsTKZNVuJpG4hek0R/RdZkNrLICU4=;
        b=ixtH/YXYtzZ8FO4T8h8CUskh1SPPFe8EPKkqc9c/IG2pP0W5VzS5AY2IKFjv4Ir2bU
         obGsMxJBQ+T4M2Vbz2xqtcIgbqd5ZfUDisOWumZQd9GzNa+4Elmi8G0kZlJYslCydgLc
         NDvJmTVJlz/LIncB0S5MU9gpze/17Nw5VkJl4e/i0aAOIqwC1EMZm7i2oEsMjKai4sg8
         XAJGBh9cBD8NM/8UUW3fNI7btIIPxY4ClgQeBYYEzPBjjQ8c5MbOlRWX0312isVCntNO
         XwwtesoRDwkoal6ar30kCY/GEXAJfmPmrP+hEfa5zO3KTAasPLJHYtxE5iYyRsihdrek
         /LeA==
X-Gm-Message-State: ABy/qLa64phWGG+s0kLboMo6lKq9kR3Xe7IjCmGdmZaa4i16irU5oKyp
	j3sHqnZ5/6YKBwUnn4p7AYFCfv9hPO3KdCCK
X-Google-Smtp-Source: APBJJlHpBPvRebRls+lIIFEhA5Lvytkdq+GoNousRuvB+TDPt/RJVkBzxVFezL+9VoHCO2yfKT0tEw==
X-Received: by 2002:a05:6a20:4291:b0:133:21c3:115e with SMTP id o17-20020a056a20429100b0013321c3115emr18776079pzj.48.1689675472463;
        Tue, 18 Jul 2023 03:17:52 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k16-20020aa792d0000000b0063d24fcc2b7sm1239023pfa.1.2023.07.18.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:17:51 -0700 (PDT)
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
Subject: [PATCHv3 net 1/2] bonding: reset bond's flags when down link is P2P device
Date: Tue, 18 Jul 2023 18:17:40 +0800
Message-Id: <20230718101741.2751799-2-liuhangbin@gmail.com>
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


