Return-Path: <netdev+bounces-49485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF97F2301
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965941F20EEA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A65CBE;
	Tue, 21 Nov 2023 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fYZo3G42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082D91
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:20:06 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD7C93F335
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1700529603;
	bh=Vr9a4uEdlLSG60iE0prA4e6fQhmhmrVr96oFin4o/vw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=fYZo3G42myfpyK7Pmpd1BWqTZHx7vORlPst86gCj1om1FMNJzgxnd1qadaDSP1bZL
	 Gv3cBGvAVAOH6fMTezACtFCeUhvQvX+bSf12S6LI/y0ADu1y8bUz8jpeMMO6tu+Zfp
	 a2gW1eak1jb+gKeumEexJYDBnjHxfSRtiNzlO6Bt1WIS0hDE2Z+r/exGdjyyIL2Htp
	 JSjZsxDK7KqkOa3lzIDedzusQ8WYg8X2yYYNL6DOJmVQseXTYnYIztpQ3GkWwNlrmr
	 aSKJyzWHeNpmmvBhxa4+/1n7Rm+mS84qJxbqW6HxLZmkhkskLg3FM4K1wHOfU+Qq1h
	 0EKTx6DlVs34g==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf62ae2df2so18209115ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529602; x=1701134402;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr9a4uEdlLSG60iE0prA4e6fQhmhmrVr96oFin4o/vw=;
        b=F9sYZJG8afK+Uu3v2kc8BXTOUgDTwYoO52aI6z3HwmPAYdH/x7pTRCwYpGdFr4LCN4
         cJejpK6FVu6Y4qKEya89+oODQJ4x4MDiFIuWKSYxXsCo68qXzQNuWeGOqW5rgI4WBoHC
         HtJTw7c5APoGZ1UFAzZYet10WKxmF+3BNBtYvIxLEjAArqPAgIj23Kp0FLBY+7M42yzd
         qchoz8liZy/d2iTe7imtTRsdIJCgx77NlsgAtSOaqxnYXOWOHYlRr6Z/m2IHllAM45IJ
         agvK2mayL8umk1VHf7kV5afED6sC8KGQXhGTSAV9UY3iv+4CRAfAdTaThEZS9PurRXzn
         OP0w==
X-Gm-Message-State: AOJu0YwFgTzSBVROxV6WKGoDOcYRxxnYcWYydzl+azMS5oU8WuZGYpjw
	n7n36ZSGidKgW5tWjz8zk3/ryo6etYL6xB/KmLY0ywVTgl6l5QCt8hEcA8VRRmIp7pD44B5c2ph
	7qX8x6myTn4lfk/v7lHidCKSp7lP47d1eKA==
X-Received: by 2002:a17:902:e74b:b0:1c0:cbaf:6930 with SMTP id p11-20020a170902e74b00b001c0cbaf6930mr11156871plf.54.1700529602282;
        Mon, 20 Nov 2023 17:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOmw8eEHQVAHuncQin8z4SkLhl/8bj7De6Sh2qlrQDHJ4FtmaliEeIafP9Gcqblv2/P2p3sg==
X-Received: by 2002:a17:902:e74b:b0:1c0:cbaf:6930 with SMTP id p11-20020a170902e74b00b001c0cbaf6930mr11156854plf.54.1700529601952;
        Mon, 20 Nov 2023 17:20:01 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001c9cc44eb60sm3459045plg.201.2023.11.20.17.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 17:20:01 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2D1245FEC8; Mon, 20 Nov 2023 17:20:01 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 25D549F88E;
	Mon, 20 Nov 2023 17:20:01 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, andy@greyhouse.net,
    weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v4] bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
In-reply-to: <20231118081653.1481260-1-shaozhengchao@huawei.com>
References: <20231118081653.1481260-1-shaozhengchao@huawei.com>
Comments: In-reply-to Zhengchao Shao <shaozhengchao@huawei.com>
   message dated "Sat, 18 Nov 2023 16:16:53 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14620.1700529601.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Nov 2023 17:20:01 -0800
Message-ID: <14621.1700529601@famine>

Zhengchao Shao <shaozhengchao@huawei.com> wrote:

>If failed to allocate "tags" or could not find the final upper device fro=
m
>start_dev's upper list in bond_verify_device_path(), only the loopback
>detection of the current upper device should be affected, and the system =
is
>no need to be panic.
>So return -ENOMEM in alb_upper_dev_walk to stop walking, print some warn
>information when failed to allocate memory for vlan tags in
>bond_verify_device_path.
>
>I also think that the following function calls
>netdev_walk_all_upper_dev_rcu
>---->>>alb_upper_dev_walk
>---------->>>bond_verify_device_path
>From this way, "end device" can eventually be obtained from "start device=
"
>in bond_verify_device_path, IS_ERR(tags) could be instead of
>IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>---
>v4: print information instead of warn
>v3: return -ENOMEM instead of zero to stop walk
>v2: use WARN_ON_ONCE instead of WARN_ON
>---
> drivers/net/bonding/bond_alb.c  | 3 ++-
> drivers/net/bonding/bond_main.c | 5 ++++-
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index dc2c7b979656..7edf0fd58c34 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *uppe=
r,
> 	if (netif_is_macvlan(upper) && !strict_match) {
> 		tags =3D bond_verify_device_path(bond->dev, upper, 0);
> 		if (IS_ERR_OR_NULL(tags))
>-			BUG();
>+			return -ENOMEM;
>+
> 		alb_send_lp_vid(slave, upper->dev_addr,
> 				tags[0].vlan_proto, tags[0].vlan_id);
> 		kfree(tags);
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 51d47eda1c87..1a40bd08f984 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2967,8 +2967,11 @@ struct bond_vlan_tag *bond_verify_device_path(stru=
ct net_device *start_dev,
> =

> 	if (start_dev =3D=3D end_dev) {
> 		tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
>-		if (!tags)
>+		if (!tags) {
>+			net_err_ratelimited("%s: %s: Failed to allocate tags\n",
>+					    __func__, start_dev->name);
> 			return ERR_PTR(-ENOMEM);
>+		}
> 		tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;
> 		return tags;
> 	}
>-- =

>2.34.1
>
>

