Return-Path: <netdev+bounces-28924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D57812D7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563451C212CE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B71B7D6;
	Fri, 18 Aug 2023 18:24:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BD1AA8A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:24:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3BD30C4
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:24:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e4d2b7d16so15795697b3.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692383095; x=1692987895;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEP+Xc9+DcK9ln10C/TfuNCNHPTHuxQsmeqenPevQag=;
        b=qum7HnAmF9a7orzbWImh1rr2Ob9oK6qeB5WX/K3ZurQ1NKGLAol7ZAdC0aSxViO0lt
         lXN+x0cfkdMSAeive9f7KxLkfjHZcwMtFIwEwtx5HfHf4y7/lZl8w5yIGT08wkdRZ2tX
         wBXB5viGjgSWFkMA1870ZDhO4EN+fgfHhdBQGdgRbWE/51RvMyi2mnO6Ihl0+jhVDt+H
         Xloairgrz1B3VkDhBYMVML01nlfJ+IiEZe9iETa4bHL4u1172TRRehmibf+y6QcBJef3
         +mN2ZUXsvGYUbF+8HabxepaBlsyjndZ/w0KAwIqWUViE2Oi45vKW1TYSiREzJu6O6SqQ
         tz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692383095; x=1692987895;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEP+Xc9+DcK9ln10C/TfuNCNHPTHuxQsmeqenPevQag=;
        b=iQ78BN0V2JDUBh797MuyrBwl7hjdeJNWhjUtafk4bqutv6S/HoPx4qHBG1SrO9gsJE
         4rVoFoWSwBMMvFFL8EyD+cAGXbG58M4wJnNGvB9qWevCAKAZmXTLP3gBB+7OszX50MnM
         UqibFaORzVHCV+ATmHgHWqbV+5rZtaWPcmgsW93pkxV97n3dhDhjbXdBT4DcMPYHyYyp
         237ZRu74BMzEPFaBl8gExyscaI4yPgM9n5ozy/1lLripGRdRi+fVbJyr/1vRm5UknyZ2
         1TXBE6whJryR50KpgsE3nYVqSDgdee6HyABlFIGtVlY5JJnM+UDwzazPyhA8RFBJUU9c
         /wEw==
X-Gm-Message-State: AOJu0YwzJE6Nl7zRwsPHT/GrX3W4yeZsQKLbUrnKM1joNYI5eLEfLuvR
	cgghd/hS7tvHzsWOkQHbMVETP2bccA==
X-Google-Smtp-Source: AGHT+IFsLdfpQcST2G6lzA/KNPaXpprGeMqiRxg/aN3v3lS083LoAR41PRG7R91n4uQ0hrUKt7rNRF8qhg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:f4bf:ee5:c87b:90c4])
 (user=prohr job=sendgmr) by 2002:a25:ab54:0:b0:c6a:caf1:e601 with SMTP id
 u78-20020a25ab54000000b00c6acaf1e601mr47182ybi.13.1692383095300; Fri, 18 Aug
 2023 11:24:55 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:22:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818182249.3348910-1-prohr@google.com>
Subject: [PATCH net-next v2] net: release reference to inet6_dev pointer
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

addrconf_prefix_rcv returned early without releasing the inet6_dev
pointer when the PIO lifetime is less than accept_ra_min_lft.

Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA li=
fetimes")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5184bd0ceb12..47d1dd8501b7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2742,7 +2742,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 	}
=20
 	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
-		return;
+		goto put;
=20
 	/*
 	 *	Two things going on here:
--=20
2.42.0.rc1.204.g551eb34607-goog


