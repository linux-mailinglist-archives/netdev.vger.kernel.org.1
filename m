Return-Path: <netdev+bounces-19571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4175B3B3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E6F281E86
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0A18C32;
	Thu, 20 Jul 2023 16:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E719BA1
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:00:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EB1BD
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:00:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c386ccab562so783514276.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689868851; x=1690473651;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsUAC4wu3aHvvBcMNevOFR27/9FPI0oSb56XWxGsw/o=;
        b=DYqWxr96dgh7ZdzvUNKRpwIiMs+sxTuXiCtAcGtkhXL+YZ1rUGuOoiI+EkfkVHoj44
         qYWVzhtt4t+KDTaSviO+J6spaGUUIM9Mk+FeW9AUImm2uRRzl+MHeNRXlg0oYZcDoVrD
         QckpM/P+xqPC3eu6MCeSQ4gzL+8jatcKBMFPyh1oBzThwHZzbaAC8LTB1QEasJA+AI7x
         XimcOZC6T2nPH4++Vx6NEoVf4T6GjTZuSccLVi1BbT/r0IVHFJ9+1pOyZnRc2sxtr4v4
         951/F2OO0DU9U3Vv1RonaJVOMO/RSpo2XfC/DDmjeqeahTm91lsb1ucaZcHmG6RmxFeg
         qvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868851; x=1690473651;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsUAC4wu3aHvvBcMNevOFR27/9FPI0oSb56XWxGsw/o=;
        b=f01NlqljuaGwV90cnQIz/j+kTyF+rE7zWh5RGIAyJwdJYi64xPsIrDdOKO+IJ2fd03
         b8WwufMs66ZdogwqXp7ArL3qvRPHe+FkQKvHkM9M4QJvFR482FBlv2fi0dwP4oVdFy3P
         Q2ATkyuaLiyyl+Ax0r2ZwjR4/AMTNTB9BJYNkLt0BNFZHPbaZD8cJobfvUgy7LEtCQUW
         OlTN5KqaAKCFXcPU4cJv4PZJCZUAafJPp36oIgyI1Hk4WZ9LdceXpI584esTZ2n5piad
         NFgmmFeljxUElQgpyHp0eYnFOxSH/wWcqTzyZVlObf7OYYTC5id9XTeuMFPUY4/fPsI4
         j97w==
X-Gm-Message-State: ABy/qLa02b7JP3y3qPfJgBu4PplfEfe6XMRm2PuhnZ1YsDioh2EsqpQ5
	3SwIfSfdLcf+xGQgCyfWaAUxyVqb
X-Google-Smtp-Source: APBJJlG4MD4yv+H+rOV58TbioSCQqAZTeHZqLHmyxTMc9KIwyIqvREujDE/q0XDrg6IKFm00fZlHCx1C
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:d1c9:80db:fd13:9fef])
 (user=maze job=sendgmr) by 2002:a5b:b8b:0:b0:c4c:f97e:421a with SMTP id
 l11-20020a5b0b8b000000b00c4cf97e421amr47099ybq.4.1689868851249; Thu, 20 Jul
 2023 09:00:51 -0700 (PDT)
Date: Thu, 20 Jul 2023 09:00:22 -0700
In-Reply-To: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
Message-Id: <20230720160022.1887942-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Subject: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr can
 create a new temporary address
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Thomas Haller <thaller@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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
Reported-by: Xiao Ma <xiaom@google.com>
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


