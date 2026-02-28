Return-Path: <netdev+bounces-262199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBR2HnJao2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AB1C8DCE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CFD13284A51
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC03D6CDF;
	Sat, 28 Feb 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="RaTUqJvr";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XdjMe4Na"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D73D6CD6
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304810; cv=none; b=WwE3ExDJEs6AVoXEEAsU7A9MJe80BhgjCr1WVhr2zZvKEf5r3eto1ToPD8+cVKMFKFZjBdFR+aW8wfjKA++PEe9gAJ62ee46lOL4bxXRUYVoaTRsOejnsyss+3doB513Ej4Fb5NKbIh6d2b7F3UW06r5OmapOIzXyihC5JWZ5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304810; c=relaxed/simple;
	bh=kSqFNdLp+5WXA2nm0CtUJ6WKpvc7ucDUSjz+dF7VhTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYH25yFVXD5xg5H5kBGgC67fzI91Ic0DirTYSSDecCltPxjSQaEdRBknHjjtJRLciyQzJPyiHvFvQk6sNe91pGdRmUZwYtjq8TO0PBG3aZQffp8bsfTIJYA9qoFn5Q3M0j0iaREs//dbG5Wkh1GHYd6t0zz42i9HGHOW+em5Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=RaTUqJvr; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XdjMe4Na; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RaTUqJvrghWOvRoEl+i4kgWOdOIm5Q6bxXXFuj1kSt0qvJj0eoxZzU8ze9Wztf1WjnaV5O1jIVnszePfeMchfFeoctb7UGro4fNcX0u2Q8K8IRpBZ3khh3ZU36N5hMJTyxMkyzyRzKBVKeskj02V9+6AUyD8XCGz7XfKzZmQr07KOoUVcmJ9dKhgcRdDH1+Bcv45477VOkL84aTBAsvQ9iEKpK52KZM/Nf+n6O2542jmKzUGXC774z8Ij2Q7cx6t2c8xBRl1uByR9QbS/gTyFBaXKYm6i2KTfvpeqx5q5msl2hxw3s/cie/EH3zUjOi7Mrt5DBGM1wUk7EUz3+huaQ==; s=purelymail3; d=tinyisr.com; v=1; bh=kSqFNdLp+5WXA2nm0CtUJ6WKpvc7ucDUSjz+dF7VhTI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XdjMe4Na2F0+YjnYQddeP8XR0i1IchroFYEy87nn09CO+FY4CFQE1gCWqRcIVii/pvAW7wGbZHtpBOhhqFwYCINrFkuvAM2D0xQPkOXACpGUW1OCtEUH636+GDaKyoCrl3Whnd12Ls4PBd2REpLbw3A9c+s+vyIbSK55q1xn1goqqndkchlHd0csI1Nfqj6lwCr9rtGVvR67b/jALo0+xkUabyiFCLRIcEuC2QBh/FuXzYlmMbONdXIBvuQ+xrHvee2rZuGA/Mn8pW8FNPNDwfXSbQZ+TrnJX61lGCfvG+A4IwffeqZKgE91y2X9iENc7W/KrvosnsvzbtMBHhd+UQ==; s=purelymail3; d=purelymail.com; v=1; bh=kSqFNdLp+5WXA2nm0CtUJ6WKpvc7ucDUSjz+dF7VhTI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1487390422;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 28 Feb 2026 18:53:24 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC PATCH 1/2 net-next] net: dsa: initial MT7628 special tag driver
Date: Sat, 28 Feb 2026 20:52:42 +0200
Message-ID: <20260228185242.800836-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228185242.800836-1-joey@tinyisr.com>
References: <20260228185242.800836-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-262199-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purelymail.com:dkim,tinyisr.com:mid,tinyisr.com:dkim,tinyisr.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B29AB1C8DCE
X-Rspamd-Action: no action

Add support for the MT7628 embedded switch's ralink special tag.

The ralink "special tag" is merged with the VLAN TPID when a VLAN is
appended by the switch. It is not installed if the VLAN tag is already
there on ingress, so the tagger assumes VLAN tagging is set up using
tag_8021q and that the outer tag is only used for port identification
and can be dropped.

On egress the special tag allows precise TX, but the correct VLAN tag
still needs to be appended.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 include/net/dsa.h    |  2 ++
 net/dsa/Kconfig      |  6 ++++
 net/dsa/Makefile     |  1 +
 net/dsa/tag_mt7628.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 net/dsa/tag_mt7628.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc..e93f9356b5c3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE=09=0930
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE=09=0931
 #define DSA_TAG_PROTO_MXL862_VALUE=09=0932
+#define DSA_TAG_PROTO_MT7628_VALUE=09=0933
=20
 enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_NONE=09=09=3D DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_YT921X=09=09=3D DSA_TAG_PROTO_YT921X_VALUE,
 =09DSA_TAG_PROTO_MXL_GSW1XX=09=3D DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 =09DSA_TAG_PROTO_MXL862=09=09=3D DSA_TAG_PROTO_MXL862_VALUE,
+=09DSA_TAG_PROTO_MT7628=09=09=3D DSA_TAG_PROTO_MT7628_VALUE,
 };
=20
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..4aa73bd1aa9b 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -211,4 +211,10 @@ config NET_DSA_TAG_YT921X
 =09  Say Y or M if you want to enable support for tagging frames for
 =09  Motorcomm YT921x switches.
=20
+config NET_DSA_TAG_MT7628
+=09tristate "Tag driver for the MT7628 embedded switch"
+=09help
+=09  Say Y or M if you want to enable support for tagging frames for the
+=09  switch embedded in the MT7628 SoC.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..d25ec0ab7d67 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) +=3D tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) +=3D tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) +=3D tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) +=3D tag_yt921x.o
+obj-$(CONFIG_NET_DSA_TAG_MT7628) +=3D tag_mt7628.o
=20
 # for tracing framework to find trace.h
 CFLAGS_trace.o :=3D -I$(src)
diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
new file mode 100644
index 000000000000..a612df43682c
--- /dev/null
+++ b/net/dsa/tag_mt7628.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Joris Vaisvila <joey@tinyisr.com>
+ * MT7628 ralink special tag support
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/dsa/8021q.h>
+#include <net/dsa.h>
+
+#include "tag.h"
+
+/*=20
+ * MT7628 uses the ralink special tag. It merges the VLAN TPID with source
+ * port ID on RX and target port bitmap on TX.
+ *
+ * The switch forwarding is controlled with VLANs, so each port is put in =
a
+ * standalone VLAN using tag_8021q. Double tag is enabled to simulate VLAN
+ * unaware ports.
+ *
+ * A VLAN tag is constructed on egress to target the standalone VLAN and p=
ort.
+ * The outer VLAN tag is parsed and removed on ingress.
+ */
+
+#define MT7628_TAG_NAME "tag_mt7628"
+
+#define SPECIAL_HEADER_RECV_SOURCE_PORT_MASK GENMASK(2, 0)
+#define SPECIAL_TAG_LEN 4
+
+static struct sk_buff *dsa_user_special_xmit(struct sk_buff *skb,
+=09=09=09=09=09     struct net_device *dev)
+{
+=09struct dsa_port *dp =3D dsa_user_to_port(dev);
+=09u16 xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+=09u8 *special_tag;
+
+=09skb_push(skb, SPECIAL_TAG_LEN);
+=09dsa_alloc_etype_header(skb, SPECIAL_TAG_LEN);
+
+=09special_tag =3D dsa_etype_header_pos_tx(skb);
+
+=09special_tag[0] =3D ETH_P_8021Q >> 8;
+=09special_tag[1] =3D BIT(dp->index);
+
+=09special_tag[2] =3D xmit_vlan >> 8;
+=09special_tag[3] =3D xmit_vlan & 0xff;
+=09return skb;
+}
+
+static struct sk_buff *dsa_user_special_recv(struct sk_buff *skb,
+=09=09=09=09=09     struct net_device *dev)
+{
+=09u16 hdr;
+=09int port;
+=09__be16 *phdr;
+
+=09if (unlikely(!pskb_may_pull(skb, SPECIAL_TAG_LEN)))
+=09=09return NULL;
+
+=09phdr =3D dsa_etype_header_pos_rx(skb);
+=09hdr =3D ntohs(*phdr);
+=09skb_pull_rcsum(skb, SPECIAL_TAG_LEN);
+=09dsa_strip_etype_header(skb, SPECIAL_TAG_LEN);
+
+=09port =3D hdr & SPECIAL_HEADER_RECV_SOURCE_PORT_MASK;
+
+=09skb->dev =3D dsa_conduit_find_user(dev, 0, port);
+=09if (!skb->dev)
+=09=09return NULL;
+=09dsa_default_offload_fwd_mark(skb);
+=09return skb;
+}
+
+static const struct dsa_device_ops mt7628_tag_ops =3D {
+=09.name =3D MT7628_TAG_NAME,
+=09.proto =3D DSA_TAG_PROTO_MT7628,
+=09.xmit =3D dsa_user_special_xmit,
+=09.rcv =3D dsa_user_special_recv,
+=09.needed_headroom =3D SPECIAL_TAG_LEN,
+};
+module_dsa_tag_driver(mt7628_tag_ops);
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MT7628, MT7628_TAG_NAME);
+MODULE_DESCRIPTION("DSA tag driver for MT7628 switch");
+MODULE_LICENSE("GPL v2");
--=20
2.53.0


