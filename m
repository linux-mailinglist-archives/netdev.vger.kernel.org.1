Return-Path: <netdev+bounces-22656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6F768930
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 00:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542981C20971
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10116433;
	Sun, 30 Jul 2023 22:51:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18D1FA4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 22:51:57 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3903116
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:51:53 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E19C1420BE
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1690757509;
	bh=rLOxZAal2Q3tnxIsm97WFFwAWgRhrAZUuymq/2bxql0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=YOCwq2gbxlIMOU1cYtFphv+/YMTPj81B8t/Qt2q/VtSVLE9hWfdnd8a6xKjO4icrb
	 AZJDQlj3HOdulbEjf5QA3P0JhfaAfoOpupEIMu0k/gCksA7c9zFmQIId6Tu3GH+232
	 ocDO0/40EUAze8tAn5Mi+hqrc5wUa/4+mNj8+nzKyomZaEl/2M/Fv6WjRa2c4JNDvv
	 xGhsmOEULF2pS0rrDQbZcM1FH8mbkguTeA6+ad67JqWk4LPVHSp2Ci1vz+GZwV5Zi9
	 K8PV7wxq6Mk5uATI9ANmOTwiXfpPofzAKm7L1CYMscdqUTDlRXoGz65MC7JJGWt13o
	 f1M8eb1gD5q/A==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-686baf1a407so2629921b3a.1
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757508; x=1691362308;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLOxZAal2Q3tnxIsm97WFFwAWgRhrAZUuymq/2bxql0=;
        b=TrJeRMaS0SbmFGeARW9Lk+NVKDlx5JIAp/7jSYXGhtkscZIiQobiltAb6Wqx6o6HqB
         lyaF9se5P7WxvcVwGPpF1/ki4f3yLE7Qn4tlfmn8PV/034nXJ2qWypRnAzg256uGyP/g
         TrpZdkH/WoPx7VYFEIUjcObJ+7yLpjlgIK23z8CUHZ1gyWe2R3ke7G96zMHHO0/7j8ro
         xG8HxhFEZg1Qlg+vg+32Q8MW03s86JHGKCtE77vyAtVV4iyAFwCUDIG0xdyoL97dgGPr
         p7Ewmrl+/SzlxGu3ZVIXLgb3AWitxsYlAm4oJlHr9y+gIlQLKpXPaI7wiZ5u6KcT1+AJ
         UyEw==
X-Gm-Message-State: ABy/qLaW+RVZUIvo6x6tR8LL3HB3J5sCYBXx5f4E6DNtfJt4HgtRunC0
	N2e2tM3ZKH2sAS/z72jHnsDmurESkq2AvxrvfbvSPGwmlRGOWEMvo9m3XryFNPVDz6UFaP38Saj
	NVoGXsfFb/Th474SXx2nLP2jer2H3zSBvnw==
X-Received: by 2002:a05:6a00:1394:b0:666:c1ae:3b87 with SMTP id t20-20020a056a00139400b00666c1ae3b87mr12190686pfg.12.1690757507795;
        Sun, 30 Jul 2023 15:51:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNv+cDJBtbDlEpJqJHmpZE7RxFPIs2sjiOc3SqlY3UwrtD9UdBul45OShUAi53XHpYU9gFlA==
X-Received: by 2002:a05:6a00:1394:b0:666:c1ae:3b87 with SMTP id t20-20020a056a00139400b00666c1ae3b87mr12190669pfg.12.1690757507451;
        Sun, 30 Jul 2023 15:51:47 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0064fde7ae1ffsm6361068pfa.38.2023.07.30.15.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2023 15:51:47 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 904605FEAC; Sun, 30 Jul 2023 15:51:46 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 88F609F83D;
	Sun, 30 Jul 2023 15:51:46 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Mat Kowalski <mko@redhat.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next,v4] bonding: support balance-alb with openvswitch
In-reply-to: <96a1ab09-7799-6b1f-1514-f56234d5ade7@redhat.com>
References: <96a1ab09-7799-6b1f-1514-f56234d5ade7@redhat.com>
Comments: In-reply-to Mat Kowalski <mko@redhat.com>
   message dated "Sat, 29 Jul 2023 19:31:05 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18960.1690757506.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Jul 2023 15:51:46 -0700
Message-ID: <18961.1690757506@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mat Kowalski <mko@redhat.com> wrote:

>Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
>vlan to bridge") introduced a support for balance-alb mode for
>interfaces connected to the linux bridge by fixing missing matching of
>MAC entry in FDB. In our testing we discovered that it still does not
>work when the bond is connected to the OVS bridge as show in diagram
>below:
>
>eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>                         |
>                       bond0.150(mac:eth0_mac)
>                         |
>                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)
>
>This patch fixes it by checking not only if the device is a bridge but
>also if it is an openvswitch.

	What changed between v3 and v4?

	-J

>Signed-off-by: Mateusz Kowalski <mko@redhat.com>
>---
> drivers/net/bonding/bond_alb.c | 2 +-
> include/linux/netdevice.h      | 5 +++++
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index b9dbad3a8af8..cc5049eb25f8 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb=
, struct bonding *bond)
> =

> 	dev =3D ip_dev_find(dev_net(bond->dev), arp->ip_src);
> 	if (dev) {
>-		if (netif_is_bridge_master(dev)) {
>+		if (netif_is_any_bridge_master(dev)) {
> 			dev_put(dev);
> 			return NULL;
> 		}
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 84c36a7f873f..27593c0d3c15 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -5103,6 +5103,11 @@ static inline bool netif_is_ovs_port(const struct =
net_device *dev)
> 	return dev->priv_flags & IFF_OVS_DATAPATH;
> }
> =

>+static inline bool netif_is_any_bridge_master(const struct net_device *d=
ev)
>+{
>+	return netif_is_bridge_master(dev) || netif_is_ovs_master(dev);
>+}
>+
> static inline bool netif_is_any_bridge_port(const struct net_device *dev=
)
> {
> 	return netif_is_bridge_port(dev) || netif_is_ovs_port(dev);
>-- =

>2.41.0

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

