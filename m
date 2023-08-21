Return-Path: <netdev+bounces-29467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC85783602
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB1F1C209FF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E791172B;
	Mon, 21 Aug 2023 22:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF08C03
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 22:54:17 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1D133
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 15:54:15 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F22F3F18D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1692658453;
	bh=6kakkQaN+Ibs1jYiNvFLZex8SNtWQCNc0xbsUATHtKQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=L++ZSiwbB4ws0ZGytXlj0I7sKIl0PyrAPFRZnEoR0nVj4uGVJdq3UQAOGAIktpARj
	 L9K+IoD2y1hAPaNnWWuqaza7ZgOr7hqGoqysd6bdJJE8TkQUVWP9DdAmk2BxQpGG1W
	 22zWgtvDFK0nMi7wbu7XzkpjQoJa67t+FXtq/PT+kiFWg5tEEm7AOhaHoIgnawtb2l
	 WQWNh7wzkGIboTr3tpKVdWTqEdlMV8Q69tBMgSukCy1hxHYtbVVCk6EYqyHNEiSTLO
	 eAUwBpXKQ4MIMQk2TkijxaR747WnY0Mc4a2+kccKGC++CwtHKd8hsYBUybATEo/T+M
	 qcNaSHRGtzZxQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf39e73558so55861835ad.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 15:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658452; x=1693263252;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kakkQaN+Ibs1jYiNvFLZex8SNtWQCNc0xbsUATHtKQ=;
        b=cciAbJM0T5eVw7PNu1SuA6S4HPvbyBxmbScnXsNaLVKf4rjKskO8IWK/PgWujp1Kkb
         vrdsVc5vvflji9D32wZYcNStTdYp4+ptAJvSobBH0fPq54e8uvTv214ZM98LSOQGKqX0
         lTSOwwm4YFZisXbEK6YhBVeX+GVEZqcCeDTx5bGSHVXhXa2AYVgSS1tnk9yfrpVhcxka
         EHPAtIN4UqaX8rlNR7gYIyLWjeS66HmqKLRfHviR3U3AYhfjboFc+Ec9k7SLLTFd7dSY
         VElorPa8YBEVHot4Pk0+Ksd2/hjoeeXTMvIPDK9CxjQ8g2m2zachWHj0dCXNZvQHobWf
         nBpA==
X-Gm-Message-State: AOJu0Yym7yXBfiWHG7WMeTbBfyuNhWjQ+ghPB005KGZBoy0mx74ZIgBK
	w7Ddu3vrdd9rXifNgIlUf+Qbc8AYAQ/X1r1tm0mLKlzHudLeTK7M3VZan1mf6tkDZXv9Uuz0c0J
	n1jzx4zMIjXZQbQj1C7ob41WWVElPtPxIoA==
X-Received: by 2002:a17:902:d511:b0:1bb:ffcc:8eba with SMTP id b17-20020a170902d51100b001bbffcc8ebamr10219174plg.58.1692658451766;
        Mon, 21 Aug 2023 15:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhdrCguNdQZ5GAA9G5VWzM3WYTj/NfwCpqQJ8FG9m2lle4XC3U/v6HRtcCZzpurt/wJaycvA==
X-Received: by 2002:a17:902:d511:b0:1bb:ffcc:8eba with SMTP id b17-20020a170902d51100b001bbffcc8ebamr10219144plg.58.1692658450987;
        Mon, 21 Aug 2023 15:54:10 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001bc5dc0cd75sm7550383plb.180.2023.08.21.15.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2023 15:54:10 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2E9645FEAC; Mon, 21 Aug 2023 15:54:10 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 28CC59F863;
	Mon, 21 Aug 2023 15:54:10 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
    Jiri Pirko <jiri@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>, susan.zheng@veritas.com
Subject: Re: [PATCH net 1/3] bonding: fix macvlan over alb bond support
In-reply-to: <20230819090109.14467-2-liuhangbin@gmail.com>
References: <20230819090109.14467-1-liuhangbin@gmail.com> <20230819090109.14467-2-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Sat, 19 Aug 2023 17:01:07 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1120.1692658450.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2023 15:54:10 -0700
Message-ID: <1121.1692658450@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The commit 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mod=
e
>bonds") aims to enable the use of macvlans on top of rlb bond mode. Howev=
er,
>the current rlb bond mode only handles ARP packets to update remote neigh=
bor
>entries. This causes an issue when a macvlan is on top of the bond, and
>remote devices send packets to the macvlan using the bond's MAC address
>as the destination. After delivering the packets to the macvlan, the macv=
lan
>will rejects them as the MAC address is incorrect. Consequently, this com=
mit
>makes macvlan over bond non-functional.
>
>To address this problem, one potential solution is to check for the prese=
nce
>of a macvlan port on the bond device using netif_is_macvlan_port(bond->de=
v)
>and return NULL in the rlb_arp_xmit() function. However, this approach
>doesn't fully resolve the situation when a VLAN exists between the bond a=
nd
>macvlan.
>
>So let's just do a partial revert for commit 14af9963ba1e in rlb_arp_xmit=
().
>As the comment said, Don't modify or load balance ARPs that do not origin=
ate
>locally.
>
>Fixes: 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bo=
nds")
>Reported-by: susan.zheng@veritas.com
>Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2117816
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_alb.c |  4 ++--
> include/net/bonding.h          | 11 +----------
> 2 files changed, 3 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index b9dbad3a8af8..7765616107e5 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -661,9 +661,9 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb=
, struct bonding *bond)
> 	arp =3D (struct arp_pkt *)skb_network_header(skb);
> =

> 	/* Don't modify or load balance ARPs that do not originate locally
>-	 * (e.g.,arrive via a bridge).
>+	 * (e.g.,arrive via a bridge or macvlan).
> 	 */

	I agree that this is best way to handle this case.  This might
be nitpicking, but I think the comment would be clearer if it didn't
give examples of what is excluded, but instead lists only the things
that are included.  Perhaps something like:

 	/* Don't modify or load balance ARPs that do not originate
	 * from the bond itself or a VLAN directly above the bond.
	 */

	-J

>-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
>+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
> 		return NULL;
> =

> 	dev =3D ip_dev_find(dev_net(bond->dev), arp->ip_src);
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 30ac427cf0c6..5b8b1b644a2d 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -722,23 +722,14 @@ static inline struct slave *bond_slave_has_mac(stru=
ct bonding *bond,
> }
> =

> /* Caller must hold rcu_read_lock() for read */
>-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 =
*mac)
>+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8=
 *mac)
> {
> 	struct list_head *iter;
> 	struct slave *tmp;
>-	struct netdev_hw_addr *ha;
> =

> 	bond_for_each_slave_rcu(bond, tmp, iter)
> 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
> 			return true;
>-
>-	if (netdev_uc_empty(bond->dev))
>-		return false;
>-
>-	netdev_for_each_uc_addr(ha, bond->dev)
>-		if (ether_addr_equal_64bits(mac, ha->addr))
>-			return true;
>-
> 	return false;
> }
> =

>-- =

>2.41.0
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

