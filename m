Return-Path: <netdev+bounces-17752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B475E752F91
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792EC281C4C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BA67EB;
	Fri, 14 Jul 2023 02:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154810FE
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:52:14 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61C2D5D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a337ddff16so1148931b6e.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689303132; x=1691895132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itZXL4k6fYbsy7df2ZYEAjhdAdUX7vCe4y+4yIIQLsg=;
        b=JEDzNMbb0X3nCwqX3KIaTeBF5cr31o+NYlWI+J2Ldu1oNm1bmxnqOhGRZnPC4yDzCP
         /aDP3gxd35IHQ0CudPwXMI2B24J+v7OVk4++e/E1Yr68T/bkMcWmTA54QI64WTcCilQO
         9vWoTm3eH3NnrSkR/Lz+/Re10rEk+pHF8EOHGnYqXmDvtOnfNEE48UytgBu5ZQ2V2Bnz
         HHxzHt+qn4/uiLe2TXCG37mi4lUsHeIpRihVL0IopfCofgstoEBqFCvJU2XQ8qdiwKcL
         VG2TItKGMGkMWFn6qI/i6KKDWmFvyFxoj5rU5qYTnUlwE/TfWpRva7o/ctIm/qBvV9E0
         xmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303132; x=1691895132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itZXL4k6fYbsy7df2ZYEAjhdAdUX7vCe4y+4yIIQLsg=;
        b=l+SnTnNNg1o76DDnE3SF5zs0TX4abLZesbOvo3MtZyarOXFnVcEb41GtGMMWpPQdUx
         2iN1UT5qKj7jl2cw5uJ1lPkY/cqMBLS1ItRCqJ/tS+HWG2N2HeLKIXQz03wf8l3XpCV5
         BeRWiXDRW4Q2QWIDx2NLu+9NQDARreMIRc/gdNLeF4C+LNpV2BvcHJz2KppOziiVuqhb
         uVd1Q74dDBZsEmUtSFBhtdtbmn9jdpLLhvBKDncgqzj3NyDfNN5mvtMlH2xpkivWjaqD
         twf5GFcZf0eTt8MC+ty3hS2Hin93RqKgiaYKS/cYKRRHjWkMds5PO56fmj9EyS+uCCyn
         sTUg==
X-Gm-Message-State: ABy/qLbKcmD3oGW7yyDo+Waol6E9baEkXXVT2+ILIHvYaAQdHSKqcF2l
	zhP+tY1RZ+2fcmlyZiVTSujHRmLDoy2Fzw==
X-Google-Smtp-Source: APBJJlGJn3tcBjVDCQ4zHWjtxAifyrdfNscJrlPw6ZqnQ5i7pcEamK8Ioh7vJeK3XZgBWoMRxmAURA==
X-Received: by 2002:aca:644:0:b0:396:4977:e148 with SMTP id 65-20020aca0644000000b003964977e148mr3508366oig.9.1689303131801;
        Thu, 13 Jul 2023 19:52:11 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id l6-20020a637006000000b0055b07fcb6ddsm6347930pgc.72.2023.07.13.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:52:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] bonding: reset bond's flags when down link is P2P device
Date: Fri, 14 Jul 2023 10:52:00 +0800
Message-Id: <20230714025201.2038731-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714025201.2038731-1-liuhangbin@gmail.com>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7a0f25301f7e..0186b2d19e8d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1508,6 +1508,10 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT)
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
 }
 
 /* On bonding slaves other than the currently active slave, suppress
-- 
2.38.1


