Return-Path: <netdev+bounces-17161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5821750A21
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4901C20FCA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F434CC1;
	Wed, 12 Jul 2023 13:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F5100AE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:55:30 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FF10C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:55:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so71735147b3.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689170127; x=1691762127;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOyxg8DmgqkozTi4nw3StFZkKAVktiq79mWFvDEFLjI=;
        b=5eu9WR3WSPE/ukrDZckifZoEcHNhKzj8+LqwwdOxNeib4RM95LQNdvUUaWKyToyWmh
         sdIdLo8SJR9qTl068+bGjVpWorBVvQ6H+w8U1+JaDrbW7znhayN3AvfoCee58ULl5aCC
         TX9lC5kFljb5I9ZW9A2GxmzxN2PtaPIC+OvMN29uEWGK7mfgGdlmtCa6Ybb/m02n0ze/
         IK4nuiH7VXvT+QScjoQL2alCzCi1ZHXpyFvjp2VpPc9r6MNY7W+m5tCoYC4Krc3AwZmZ
         7QaIw+iaJ2jBX6EfTqoy4ASaRnpo1K519rRHRFCIVhrIDqicjlvVfUarptOJwt/o3Ftb
         Qenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170127; x=1691762127;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOyxg8DmgqkozTi4nw3StFZkKAVktiq79mWFvDEFLjI=;
        b=VyqR8hmWogrdFYxfO60qIJH/kVOfH9SbMp0SdTPZvSTf2BYw3HogFSQD8IFd2H8dGp
         uiylbzif2AK7L198mZ52WsQUoOaUdDhGC2PWQaM/zKNG+tljdpGdkC7DUxkMWmPHrSBX
         HTRRxFhE5gJswinvdvPxT5oacdp4L5lp6bJXkGe097WClUxy9rNnZi4JEHy+Y8DSAAQt
         kuRx/sHknLb3cYUSFORiY/D3O3hkkdRuzjVhy9VElOWVjXN4hIMGkR1BvC2nxxKhUBwj
         qCDGBTpfzyJPvlCY1nGyXWIthibO90z+dSZdux1Xzh7b55TAoAeyyeYYT7r16TiXofow
         6iQA==
X-Gm-Message-State: ABy/qLZfjWMAzDv8uV06wg5FzVc7OIinbP7trrLzBruQwn/OTZDsTls/
	BZlwqf8P5Xbv1iR5pYIc+dgbhk3B
X-Google-Smtp-Source: APBJJlExgN+6v6onn9+SdCKtPJitBXVABkVNIs/0lzM49gzgUND2OEXfDQ4efZrnYUse8ykWizC/HpYA
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:cdf9:6213:9376:ab44])
 (user=maze job=sendgmr) by 2002:a81:404d:0:b0:570:75a8:7867 with SMTP id
 m13-20020a81404d000000b0057075a87867mr159778ywn.4.1689170127706; Wed, 12 Jul
 2023 06:55:27 -0700 (PDT)
Date: Wed, 12 Jul 2023 06:55:19 -0700
Message-Id: <20230712135520.743211-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Subject: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr can
 create a new temporary address
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

currently on 6.4 net/main:

  # ip link add dummy1 type dummy
  # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
  # ip link set dummy1 up
  # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
      inet6 2000::44f3:581c:8ca:3983/64 scope global temporary dynamic
         valid_lft 604800sec preferred_lft 86172sec
      inet6 2000::1/64 scope global mngtmpaddr
         valid_lft forever preferred_lft forever
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

  # ip -6 addr del 2000::44f3:581c:8ca:3983/64 dev dummy1

  (can wait a few seconds if you want to, the above delete isn't [directly]=
 the problem)

  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
      inet6 2000::1/64 scope global mngtmpaddr
         valid_lft forever preferred_lft forever
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

  # ip -6 addr del 2000::1/64 mngtmpaddr dev dummy1
  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UN=
KNOWN group default qlen 1000
      inet6 2000::81c9:56b7:f51a:b98f/64 scope global temporary dynamic
         valid_lft 604797sec preferred_lft 86169sec
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

This patch prevents this new 'global temporary dynamic' address from being
created by the deletion of the related (same subnet prefix) 'mngtmpaddr'
(which is triggered by there already being no temporary addresses).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Fixes: 53bd67491537 ("ipv6 addrconf: introduce IFA_F_MANAGETEMPADDR to tell=
 kernel to manage temporary addresses")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/ipv6/addrconf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..94cec2075eee 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *idev=
,
 			ipv6_ifa_notify(0, ift);
 	}
=20
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft =3D=3D 0, prefered_lft =3D=3D 0,=
 create =3D=3D false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create =3D true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, false);
--=20
2.41.0.255.g8b1d071c50-goog


