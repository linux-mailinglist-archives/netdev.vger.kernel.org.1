Return-Path: <netdev+bounces-54454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4EE8071DA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491411F21626
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3E93DB8A;
	Wed,  6 Dec 2023 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cKlX6Nk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0527D1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:10:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d351694be7so104015317b3.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701871859; x=1702476659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRvNW+4RzSeqmup1V9r8+czJLIOYItYpCl2sbVK/R3Q=;
        b=0cKlX6NkJLwB4/wXpAq46SiyqU3wLL//UloU8iblkNE91lYRP3mBXfCLxfVSn3+si/
         ti4hm4uLdndGv+ixU7FyH705RCZ4ojrE13ijdsCj58pEC4O0kVM64Dtpllq4vFSHuCcz
         PwkjWZ9CNDDdm4vbFU4DacF9SWJ7o1W+ZNd7BQ+E7wbYbItgvXtPrCYMMkTYr7g+j3Vn
         uD9lcZV4eYHfEu+gLOvD9PHXNsojIEedBrmejsYT0kNANkQAc/PsbYvCPGSe34zAqJnW
         SPXBq8dGgT5Bel2AmuYA2CtvU+3Ox7OxcAJuhmSY2evLOtBlZH7pIJD1i/ylJV0E25XQ
         URvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871859; x=1702476659;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRvNW+4RzSeqmup1V9r8+czJLIOYItYpCl2sbVK/R3Q=;
        b=HrJX77Vgx02//y+CG1/v7XyeF15cHuCZANUL50ID+NkIBR8QDR3SPiNu2+nODDROYF
         cSjaHVaWhAxG2oOch1WR5xR2gq30RxVUZG79VO0c0MBZEmv3ehO6+cn/pqUcapRmZNor
         q6RdyTePuAoHdgROm8j73zjM/Wg8rzOH72ISB+aVVB/r/ibXzhtMXHpfONeAZh+anvJw
         bKUriuYEiFJCX/x4ACLPFcgwTn1otD7DhQZSWsyVAE2B8Q37K6mI8zFEWyiW6v10Dr+z
         QOo/xCm4uqfFCOrCzu5gGb7zCxRM2s4A++CSoXZhPZhU6aSDA8ddQuLp36FAGfF9nHX2
         BdHQ==
X-Gm-Message-State: AOJu0YyAWBSprAhhV2rH1L/FwMBDTVGoVQD8OmVzWicpIve1jpb+Kc0H
	OBJGkaFtX7l6dWyPbtehNuXoQOSf
X-Google-Smtp-Source: AGHT+IHfS+gaDlq83SjTugoepU1C1UoNexsDW+CkC6U/RrsNwWD1qYYUWp4lIjVaqvoEdBlsEsVCQUSH
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:868c:db6b:ace8:1af9])
 (user=maze job=sendgmr) by 2002:a05:690c:3244:b0:5ca:5fcd:7063 with SMTP id
 fg4-20020a05690c324400b005ca5fcd7063mr13808ywb.3.1701871858993; Wed, 06 Dec
 2023 06:10:58 -0800 (PST)
Date: Wed,  6 Dec 2023 06:10:54 -0800
Message-Id: <20231206141054.41736-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH net v2] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Shirley Ma <mashirle@us.ibm.com>, David Ahern <dsahern@kernel.org>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo points out that we effectively clear all unknown
flags from PIO when copying them to userspace in the netlink
RTM_NEWPREFIX notification.

We could fix this one at a time as new flags are defined,
or in one fell swoop - I choose the latter.

We could either define 6 new reserved flags (reserved1..6) and handle
them individually (and rename them as new flags are defined), or we
could simply copy the entire unmodified byte over - I choose the latter.

This unfortunately requires some anonymous union/struct magic,
so we add a static assert on the struct size for a little extra safety.

Cc: Shirley Ma <mashirle@us.ibm.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Fixes: 60872d54d963 ("[IPV6]: Add notification for MIB:ipv6Prefix events.")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/net/addrconf.h | 12 ++++++++++--
 include/net/if_inet6.h |  4 ----
 net/ipv6/addrconf.c    |  6 +-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 82da55101b5a..8e308c2662d7 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -31,17 +31,22 @@ struct prefix_info {
 	__u8			length;
 	__u8			prefix_len;
=20
+	union __attribute__((packed)) {
+		__u8		flags;
+		struct __attribute__((packed)) {
 #if defined(__BIG_ENDIAN_BITFIELD)
-	__u8			onlink : 1,
+			__u8	onlink : 1,
 			 	autoconf : 1,
 				reserved : 6;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8			reserved : 6,
+			__u8	reserved : 6,
 				autoconf : 1,
 				onlink : 1;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
+		};
+	};
 	__be32			valid;
 	__be32			prefered;
 	__be32			reserved2;
@@ -49,6 +54,9 @@ struct prefix_info {
 	struct in6_addr		prefix;
 };
=20
+/* rfc4861 4.6.2: IPv6 PIO is 32 bytes in size */
+static_assert(sizeof(struct prefix_info) =3D=3D 32);
+
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/if_inet6.h>
diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index 3e454c4d7ba6..f07642264c1e 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -22,10 +22,6 @@
 #define IF_RS_SENT	0x10
 #define IF_READY	0x80000000
=20
-/* prefix flags */
-#define IF_PREFIX_ONLINK	0x01
-#define IF_PREFIX_AUTOCONF	0x02
-
 enum {
 	INET6_IFADDR_STATE_PREDAD,
 	INET6_IFADDR_STATE_DAD,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3aaea56b5166..2692a7b24c40 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6149,11 +6149,7 @@ static int inet6_fill_prefix(struct sk_buff *skb, st=
ruct inet6_dev *idev,
 	pmsg->prefix_len =3D pinfo->prefix_len;
 	pmsg->prefix_type =3D pinfo->type;
 	pmsg->prefix_pad3 =3D 0;
-	pmsg->prefix_flags =3D 0;
-	if (pinfo->onlink)
-		pmsg->prefix_flags |=3D IF_PREFIX_ONLINK;
-	if (pinfo->autoconf)
-		pmsg->prefix_flags |=3D IF_PREFIX_AUTOCONF;
+	pmsg->prefix_flags =3D pinfo->flags;
=20
 	if (nla_put(skb, PREFIX_ADDRESS, sizeof(pinfo->prefix), &pinfo->prefix))
 		goto nla_put_failure;
--=20
2.43.0.rc2.451.g8631bc7472-goog


