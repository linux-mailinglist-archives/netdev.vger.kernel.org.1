Return-Path: <netdev+bounces-55603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568580BA4A
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06291F20FAF
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069D8494;
	Sun, 10 Dec 2023 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E74kN/au"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF727CE
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:10:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d749e4fa3dso43336497b3.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702206638; x=1702811438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JYbP30LV20QRsL/owp33BeqXTpPwV3QAP/6cuUo5hc=;
        b=E74kN/auDyAit29igGbKpsF+MQ8z1b8gsQEko146tPkhXgpZL334e/K4eKvlWMdZfO
         bEv5aAnfShLaYKevE+ILYbJE79Dfm6WIr2zDFFuwo8L67y3euD4iJLYRw+6gSJMIMlhO
         tWLPqEErzTTwsVAYjjPGo14O1p7ljpnIcMSPtDgm7pdJpuF+/A+/4bjhk42C4be/ehDi
         JIlR/dxklgVrZePnjWnoJ3JwI0gDOI34szVuQ1AnQTdh3GBGGL0Jg6hyglNUW5NGG+2n
         w5ws7/GdqfWGcBmcbNT1SM/+bAMq6ir23Fzd6F6ReVlVEHTOFjopF5FHL3V2Jyuu8wMz
         58aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702206638; x=1702811438;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JYbP30LV20QRsL/owp33BeqXTpPwV3QAP/6cuUo5hc=;
        b=JEPaPHEQetXshz5Lk4ajAbVHe5Q7ihuRsA1bxCORHj0niATwBn/Zjcd2HlAWazEhmk
         +g/YEVSXc/RjxZuJtXwC11Bev4iX3I2Klu1XZZtr7Sxy6pD/pyUSQpzOElq4RI7V20Hp
         UwnUW9UW9mnconRZ/ZFVzdTc9kK/thK7N9Kr2ZJphvg/P89jqLTQd5PpbDKSSzBopKaF
         3zm0RGP+ExTKvFaFq+oeGgrwNzPwTZ3r1Gbt3MTH+6ruusDywdzWf7BeARCt1R8xjC26
         +YrDQ849srTpa9bj8KgfgovsMJspX8YWkBFtTVx+7Zjyrqvp9SCC73NQM9EKPSAGaFYN
         DLSw==
X-Gm-Message-State: AOJu0YxYlaZgOZI5AydDQ2KYE4tkWQIlXBS9yRefZHi4W+/1i/dV328L
	3esnzEA159uHTlkbzJYeHQCRoX1O
X-Google-Smtp-Source: AGHT+IHaR4GlzWwKbCnH171TNpxU4/2eP7fVsiz3k4TqKAq6nOCwwhlz6S7hNs2Ah6N7B2oe38Rt+Uyo
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:5ede:596c:db09:feb])
 (user=maze job=sendgmr) by 2002:a05:6902:9:b0:db5:382f:3997 with SMTP id
 l9-20020a056902000900b00db5382f3997mr16597ybh.11.1702206637803; Sun, 10 Dec
 2023 03:10:37 -0800 (PST)
Date: Sun, 10 Dec 2023 03:10:32 -0800
Message-Id: <20231210111033.1823491-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Flavio Crisciani <fcrisciani@google.com>, 
	"Theodore Y. Ts'o" <tytso@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The clear intent of net_ctl_permissions() is that having CAP_NET_ADMIN
grants write access to networking sysctls.

However, it turns out there is an edge case where this is insufficient:
inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
which can return -EACCES and thus block *all* write access.

Note: AFAICT this check is wrt. the uid/gid mapping that was
active at the time the filesystem (ie. proc) was mounted.

In order for this check to not fail, we need net_ctl_set_ownership()
to set valid uid/gid.  It is not immediately clear what value
to use, nor what values are guaranteed to work.
It does make sense that /proc/sys/net appear to be owned by root
from within the netns owning userns.  As such we only modify
what happens if the code fails to map uid/gid 0.
Currently the code just fails to do anything, which in practice
results in using the zeroes of freshly allocated memory,
and we thus end up with global root.
With this change we instead use the uid/gid of the owning userns.
While it is probably (?) theoretically possible for this to *also*
be unmapped from the /proc filesystem's point of view, this seems
much less likely to happen in practice.

The old code is observed to fail in a relatively complex setup,
within a global root created user namespace with selectively
mapped uid/gids (not including global root) and /proc mounted
afterwards (so this /proc mount does not have global root mapped).
Within this user namespace another non privileged task creates
a new user namespace, maps it's own uid/gid (but not uid/gid 0),
and then creates a network namespace.  It cannot write to networking
sysctls even though it does have CAP_NET_ADMIN.

This is because net_ctl_set_ownership fails to map uid/gid 0
(because uid/gid 0 are *not* mapped in the owning 2nd level user_ns),
and falls back to global root.
But global root is not mapped in the 1st level user_ns,
which was inherited by the /proc mount, and thus fails...

Note: the uid/gid of networking sysctls is of purely superficial
importance, outside of this UNMAPPED check, it does not actually
affect access, and only affects display.

Access is always based on whether you are *global* root uid
(or have CAP_NET_ADMIN over the netns) for user write access bits
(or are in *global* root gid for group write access bits).

Cc: Flavio Crisciani <fcrisciani@google.com>
Cc: "Theodore Y. Ts'o" <tytso@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's=
 owner")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/sysctl_net.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..ded399f380d9 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -58,16 +58,11 @@ static void net_ctl_set_ownership(struct ctl_table_head=
er *head,
 				  kuid_t *uid, kgid_t *gid)
 {
 	struct net *net =3D container_of(head->set, struct net, sysctls);
-	kuid_t ns_root_uid;
-	kgid_t ns_root_gid;
+	kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
+	kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
=20
-	ns_root_uid =3D make_kuid(net->user_ns, 0);
-	if (uid_valid(ns_root_uid))
-		*uid =3D ns_root_uid;
-
-	ns_root_gid =3D make_kgid(net->user_ns, 0);
-	if (gid_valid(ns_root_gid))
-		*gid =3D ns_root_gid;
+	*uid =3D uid_valid(ns_root_uid) ? ns_root_uid : net->user_ns->owner;
+	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : net->user_ns->group;
 }
=20
 static struct ctl_table_root net_sysctl_root =3D {
--=20
2.43.0.472.g3155946c3a-goog


