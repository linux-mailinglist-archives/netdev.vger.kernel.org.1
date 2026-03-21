Return-Path: <netdev+bounces-270249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG2OEkL1vmk0mAMAu9opvQ
	(envelope-from <netdev+bounces-270249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:45:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3D2E70EB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A2C93028111
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CBF33C197;
	Sat, 21 Mar 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="QxUcpPzG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hd7KoQ/X"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC773112C0
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122264; cv=none; b=csghqA6g6RQOw3toiw/GsigxR/x0ZgpcDUtf43hUoWwUDxQGfqB27WMThIy9sw3SmXSNo53nxkhcRj8uA9tXHEmjd3+Kj+3UR0k6HId4kscvKT1PZSl0t1lcRJDh3fdTBbdVHS/eH/F8t0s0OMMw6v1uImPbci0bUUlQxnVTb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122264; c=relaxed/simple;
	bh=mDCcU42fuQP0vVO0Gy4gOjGwPwJZfV7OC7fMeaeUVx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pu0M9szXR4r+dX+fXIZIkt1FbAKGXM9X/9F0/MDqxarM2Q6holFLyr+nxSZQlQuIrh5FFGsA4QoOcLTDet5BTX3Ol3/1iy3EdaKeRlICwSIZ1xFVFZyXFyK/bfh0upYz/H3fSgF4Vz1Pj893q6kIHOUiGO4Ukk41OnBW4XQhouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=QxUcpPzG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hd7KoQ/X; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=QxUcpPzGdNuip2Po5gmi3iiqjFY7/ynZR2I9ieuAv5aiDnLguqrX60snCRgvfIGaIDQ4MbgFwjkP+zmV6PNaPHZqvwTWyA7L4AGdWI++5THv4iuo2llEoEHMooK0Al3lnfYlZjwyIfVimIPb4+jxCBelZSE4t9N5eYE40ouQljjZevbDpCiAINp/J2gJ2sn+5GvPAwPJIgCzbESIVaC/wp97RVt/g3HLm096Ca1YFo2liE02WVm/eTk1orNcDfd9yXWGGCm/T2Md/fv78H9une+8s5FbVPnj6XH84xYPswGrJjxXh11FDoTi3qXKxSAvVvfjQRosb7WBGEm8XmtHrA==; s=purelymail3; d=tinyisr.com; v=1; bh=mDCcU42fuQP0vVO0Gy4gOjGwPwJZfV7OC7fMeaeUVx4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=hd7KoQ/XmEGo95lmo/rZeK2Zd94tVXt8NE3OIZwbeUpRo+LXiwDEwRKJSIx1NW6mamOhqXa4GOC11XMXg4ZvZ1m1VigsxdO6NWV1X9ErYXYJtdfPqxiXPZu18SYblNcylZGMgofXeAGC7xMx2Ap87mmKyBGfSqs5WFE32OgbRNCn5yoOJyIbrvtjqHWwwlDEich3wiUeGbx5MXDIiKMR12uwXhtTIVcN5WjVKjJj9/p0kbCCTbI3NjaKfiDR+WrehJd9XT64VBflHtYoRRJdrAJbs+206jZat5McIDLrhgRxv4xBMLvl5pMg6tZpKOKvhNCRCUF4k7PlHruBOxS42w==; s=purelymail3; d=purelymail.com; v=1; bh=mDCcU42fuQP0vVO0Gy4gOjGwPwJZfV7OC7fMeaeUVx4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 958892867;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Mar 2026 19:44:19 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v3 3/4] net: dsa: initial MT7628 tagging driver
Date: Sat, 21 Mar 2026 21:43:39 +0200
Message-ID: <20260321194340.2140783-4-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321194340.2140783-1-joey@tinyisr.com>
References: <20260321194340.2140783-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270249-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: E2D3D2E70EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the MT7628 embedded switch's tag.

The MT7628 tag is merged with the VLAN TPID field when a VLAN is
appended by the switch hardware. It is not installed if the VLAN tag is
already there on ingress. Due to this hardware quirk the tag cannot be
trusted for port 0 if we don't know that the VLAN was added by the
hardware. As a workaround for this the switch is configured to always
append the port PVID tag even if the incoming packet is already tagged.
The tagging driver can then trust that the tag is always accurate and
the whole VLAN tag can be removed on ingress as it's only metadata for
the tagger.

On egress the MT7628 tag allows precise TX, but the correct VLAN tag
from tag_8021q is still appended or the switch will not forward the
packet.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 include/net/dsa.h    |  2 +
 net/dsa/Kconfig      |  6 +++
 net/dsa/Makefile     |  1 +
 net/dsa/tag_mt7628.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)
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
index 000000000000..ef119c37b26a
--- /dev/null
+++ b/net/dsa/tag_mt7628.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Joris Vaisvila <joey@tinyisr.com>
+ * MT7628 switch tag support
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/dsa/8021q.h>
+#include <net/dsa.h>
+
+#include "tag.h"
+
+/*
+ * The MT7628 tag is encoded in the VLAN TPID field.
+ * On TX the lower 6 bits encode the destination port bitmask.
+ * On RX the lower 3 bits encode the source port number.
+ *
+ * The switch hardware will not modify the TPID of an incoming packet if i=
t is
+ * already VLAN tagged. To work around this the switch is configured to al=
ways
+ * append a tag_8021q standalone VLAN tag for each port. That means we can
+ * safely strip the outer VLAN tag after parsing it.
+ *
+ * A VLAN tag is constructed on egress to target the standalone VLAN and
+ * destination port.
+ */
+
+#define MT7628_TAG_NAME "mt7628"
+
+#define MT7628_TAG_TX_PORT_BIT_MASK GENMASK(5, 0)
+#define MT7628_TAG_RX_PORT_MASK GENMASK(2, 0)
+#define MT7628_TAG_LEN 4
+
+static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
+=09=09=09=09       struct net_device *dev)
+{
+=09struct dsa_port *dp;
+=09u16 xmit_vlan;
+=09__be16 *tag;
+
+=09dp =3D dsa_user_to_port(dev);
+=09xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+
+=09skb_push(skb, MT7628_TAG_LEN);
+=09dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
+
+=09tag =3D dsa_etype_header_pos_tx(skb);
+
+=09tag[0] =3D htons(ETH_P_8021Q |
+=09=09       FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
+=09=09=09=09  dsa_xmit_port_mask(skb, dev)));
+=09tag[1] =3D htons(xmit_vlan);
+
+=09return skb;
+}
+
+static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
+=09=09=09=09      struct net_device *dev)
+{
+=09int src_port;
+=09__be16 *phdr;
+=09u16 tpid;
+
+=09if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
+=09=09return NULL;
+
+=09phdr =3D dsa_etype_header_pos_rx(skb);
+=09tpid =3D ntohs(*phdr);
+=09skb_pull_rcsum(skb, MT7628_TAG_LEN);
+=09dsa_strip_etype_header(skb, MT7628_TAG_LEN);
+
+=09src_port =3D tpid & MT7628_TAG_RX_PORT_MASK;
+
+=09skb->dev =3D dsa_conduit_find_user(dev, 0, src_port);
+=09if (!skb->dev)
+=09=09return NULL;
+=09dsa_default_offload_fwd_mark(skb);
+=09return skb;
+}
+
+static const struct dsa_device_ops mt7628_tag_ops =3D {
+=09.name =3D MT7628_TAG_NAME,
+=09.proto =3D DSA_TAG_PROTO_MT7628,
+=09.xmit =3D mt7628_tag_xmit,
+=09.rcv =3D mt7628_tag_rcv,
+=09.needed_headroom =3D MT7628_TAG_LEN,
+};
+
+module_dsa_tag_driver(mt7628_tag_ops);
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MT7628, MT7628_TAG_NAME);
+MODULE_DESCRIPTION("DSA tag driver for MT7628 switch");
+MODULE_LICENSE("GPL");
--=20
2.53.0


