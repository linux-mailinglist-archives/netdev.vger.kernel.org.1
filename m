Return-Path: <netdev+bounces-17863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DE7534D0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD71C1C215D4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B827C8E5;
	Fri, 14 Jul 2023 08:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAED2FF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:13:57 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C26D3AA9
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a337ddff16so1310857b6e.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689322435; x=1691914435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmbfT+/MzwaSY9zZQ/qDB5qfN1/58V26qFzg36OlU7Q=;
        b=PonEMeGSdFDf8icwuQgtd/RnQX/ppKUPG6lyQVTabqKhl0WB8mqzRH1SLR5qG2w+52
         nuxiZOTdCc7T9QUkNQImiIVyxG0uYtA3G/qTixpR5YRCijrgbq/vzmfqWKPLjf83KwGh
         QLUT+DDBWBaa4haU0/cFHFm34gx2/rJUMIPBK+PtvHZd73HPLEeTR/h8K/RZrSRlQyri
         n7PT4ig2z376jkLhZK84Lj41uHv0O8eXrxoX8UDmT4XN+s+dbt3ztKGQ/hfZMBcNrnj1
         0DE4A2QLojb1Yi2Da8+junYnpsUaveMsAPcLQ41cCIIvrnLDIf01VYFIPwsjn9f3USmu
         zWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322435; x=1691914435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmbfT+/MzwaSY9zZQ/qDB5qfN1/58V26qFzg36OlU7Q=;
        b=QIGzyIBux/GZ6HAQ6GbTucQiTXVOPn1M8LowEOYsz38m5yLxpNuY/vE6nvPpm0IDUS
         tbGKlKlITWwJ2uMpNVEiBur6Ake7JnpHuglrS+nsJ/FRrPafd+1rNc87emNGetXyk9W6
         qaItmlfyX5Bl7fdywAdB6NEvSmXJqEC4jO2u1Afw+a3kp5Ch4faBfa5p314LN/rhI/Ru
         3Yq/1RqEZ+I93yhaeXfT9nQU7+sGBpesVi2vtdXkFUCdgrhhYRRHKs6TR5/NzmG8tcNp
         oGJudhHZrHSdMTvdnT6QQFxO6dePYJlvyMSCsCSotOQyPq9wN0yuZi6x/Qk7MgFBA6oF
         7pTQ==
X-Gm-Message-State: ABy/qLYiLykD515QYikocgEqyNlsBneyjc3FuTVNHnAxaN5qaEWUdeNK
	dgcP9EiGR5Qa0t6kHwr4/sR5fSzRo96GVA==
X-Google-Smtp-Source: APBJJlEFe/FWuH9RButggwIsFTU9mUxwIpHEQcCuAMIo9Q1Sikz8wbGvrKGuYfe3uMfvWd1V9xHSjg==
X-Received: by 2002:a05:6358:8812:b0:135:b4c:a490 with SMTP id hv18-20020a056358881200b001350b4ca490mr6153061rwb.10.1689322434850;
        Fri, 14 Jul 2023 01:13:54 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00263ba6a248bsm715268pji.1.2023.07.14.01.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:13:54 -0700 (PDT)
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
Subject: [PATCHv2 net 1/2] bonding: reset bond's flags when down link is P2P device
Date: Fri, 14 Jul 2023 16:13:39 +0800
Message-Id: <20230714081340.2064472-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714081340.2064472-1-liuhangbin@gmail.com>
References: <20230714081340.2064472-1-liuhangbin@gmail.com>
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
Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
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


