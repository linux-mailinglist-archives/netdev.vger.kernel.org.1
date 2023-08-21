Return-Path: <netdev+bounces-29468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E0783605
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825341C209F6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004C11C9C;
	Mon, 21 Aug 2023 22:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992991172B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 22:57:53 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC826FA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 15:57:51 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9377A3F20F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 22:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1692658670;
	bh=5cXcMQmUKRQrU/+ebTNZuJPZRExTytdKG47S+M3W62Y=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=qFJ9FKhSvgGGi0aBrufRXvzy07e5YzVp7DpDR+YzH5fn/0MwHd1zRAD4Hb1fvWsXm
	 5x4ZPBR34gl6Vf1UPWRPFtgdd2D1/VynzB9ynhLarWzmoeim2woPnqL2EOSit0W+SY
	 mxQUXnhi1zkptok196MASgGoBk6wHfvbORdiDPm8VRO4LvEilwHHd7uc07Uf8ucNac
	 uiJ+DfDRI93axNw0bo9Y+cGuTdj4HRnPI4hOxwH2+YrxK7EID5FYL4XJ1nqkfgZwZs
	 9/V+RLYRLAFQOqKvrq0ZeksoRQ9Nk6Yyn8IKl8PV5WYWwgtQYEYwZzyg+FiJXvVnqR
	 DE/0gw+hZmbvA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68a4025bb30so2011972b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 15:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658669; x=1693263469;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cXcMQmUKRQrU/+ebTNZuJPZRExTytdKG47S+M3W62Y=;
        b=FwKQ2h7UVDm3VB2W+n0RWmzz3UOr8ZoyirFanzH+0KE3L+w0amhiK+kTVEpEkQ6oX9
         5kE5dlFzw41OVfMsRd/WlSsl2wyJZZBkRe6OKgxYQyYC7a74PLZjWUqd3x40uxXm5smK
         kgTxmy5DDEhGhrvKFLYgtpd80WsvIKBL33dedmVcQiJBIFl3z7UvV0kq2ZB1xkbaoM0T
         Pe1WLdqMl0sdTtn5SdR7YxfaitmunTU1OsY87GJcq1DWnPOQyL1CplYhn8muaH7NRi3H
         4tPag4GBbRDVHwTw2Kjxa9EJDhnmw4ySwoyXy4kfXkXtvmqu3KcXnJtVRbdBTPDRXZb+
         teOg==
X-Gm-Message-State: AOJu0YxVxnuDduJcjTZAkFfsU2+p8je2r2T1oljU0LbL7SfJPVDIVmgd
	mDGb0845nI23PA4XHMF48p4r1re+v7Ul9gTKnmP28yT9DMGRlk7KXlYkxee8OeOnwFh7qLxGTG9
	9w7+/Q03Zo1Ss2WthCbgKna1Kz88cs8mJSA==
X-Received: by 2002:a05:6a21:8187:b0:131:4808:d5a1 with SMTP id pd7-20020a056a21818700b001314808d5a1mr5348310pzb.28.1692658669261;
        Mon, 21 Aug 2023 15:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNYL2WSoKQFexdepLo+B2icqXPDX56Q/LG8WpYgYyz09UlxpSUJMqmRT11zX/bz8hmg8DDuA==
X-Received: by 2002:a05:6a21:8187:b0:131:4808:d5a1 with SMTP id pd7-20020a056a21818700b001314808d5a1mr5348298pzb.28.1692658668928;
        Mon, 21 Aug 2023 15:57:48 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id m18-20020aa78a12000000b0068a414858bdsm3027350pfa.118.2023.08.21.15.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2023 15:57:48 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 33FE85FEAC; Mon, 21 Aug 2023 15:57:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2CAEB9F863;
	Mon, 21 Aug 2023 15:57:48 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
    Jiri Pirko <jiri@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Andrew Schorr <ajschorr@alumni.princeton.edu>
Subject: Re: [PATCH net-next] bonding: update port speed when getting bond speed
In-reply-to: <20230821101008.797482-1-liuhangbin@gmail.com>
References: <20230821101008.797482-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 21 Aug 2023 18:10:08 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1317.1692658668.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2023 15:57:48 -0700
Message-ID: <1318.1692658668@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Andrew reported a bonding issue that if we put an active-back bond on top
>of a 802.3ad bond interface. When the 802.3ad bond's speed/duplex changed
>dynamically. The upper bonding interface's speed/duplex can't be changed =
at
>the same time, which will show incorrect speed.
>
>Fix it by updating the port speed when calling ethtool.
>
>Reported-by: Andrew Schorr <ajschorr@alumni.princeton.edu>
>Closes: https://lore.kernel.org/netdev/ZEt3hvyREPVdbesO@Laptop-X1/
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> drivers/net/bonding/bond_main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 447b06ea4fc9..07c2e46d27a8 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5706,6 +5706,7 @@ static int bond_ethtool_get_link_ksettings(struct n=
et_device *bond_dev,
> 	 */
> 	bond_for_each_slave(bond, slave, iter) {
> 		if (bond_slave_can_tx(slave)) {
>+			bond_update_speed_duplex(slave);
> 			if (slave->speed !=3D SPEED_UNKNOWN) {
> 				if (BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
> 					speed =3D bond_mode_bcast_speed(slave,
>-- =

>2.41.0
>
>

