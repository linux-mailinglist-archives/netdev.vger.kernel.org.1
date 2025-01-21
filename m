Return-Path: <netdev+bounces-159917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E438A175EB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB87A3294
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249254652;
	Tue, 21 Jan 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="G6O7kJWZ"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DD18E3F
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737425901; cv=none; b=Ob2NIYNYNBO35r7D94JIgO/6KTOhKZ2TQid55R3eJh3Zno7fjcaNqrwQPBKtr8E3Yo20OaE32xy8UoJKY0Mo38W8uMHHEyId676TBAZclQX/WkRkIdPfKYCqYEwRfcjOwcJ0IgdMVSH0rr/bWORM3abotK51uUshn/YtPRFJkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737425901; c=relaxed/simple;
	bh=Xp1B/1pd1f2l8mFb+jGUpp4iBNrri5Jv3gfax1MxROY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTtErSX12tzN21hIc8YJIghNtA3Gk6DGbKAcQ3SDYZNoweZ+6RqYZkj8IHJ5RzQhozJbe4FMWq/8cfYUKH6A0pRo++eDAEmuUG87nNSR+Rc41toxH3nz4UavrJe3i0HeGg61EjS/zTk7qY83rt37KCx4oyHurbMp+1BbZMoQnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=G6O7kJWZ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9FD542C0AC1;
	Tue, 21 Jan 2025 15:18:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737425888;
	bh=ytM5RYwnF9BQNzIQmtLopm/o/2pdHksxL7+ZOhYBDfc=;
	h=From:To:Cc:Subject:Date:From;
	b=G6O7kJWZAFUqbU7R4ggHb+x2yeCGJv2i1HLORSsVY5hmha+Lm97f/GccX0s7uD89P
	 G6GUSp04BBLFhKlVBRz/bMvlD9zBa1PHR1+D5wBrlIIOLfKt3n79AQGl6eTAoGk+UA
	 vWR72q6T3fR4t/sQ4djwZhWmqEzIUQ+FG4KzrIG5glKOpxMSx/K9HxwuV9pd9biUeu
	 SdRuHOSFvZUKFWG6wqduM0bIv7M0yQVTkKGjtD89ok2AQzrBsfeM+H/IctN13Hl4WF
	 6Sg8SGxxm5VYV7ruX1f/8TLz7Wz5LO+vwJp162PiwLlzCuGRefDXU4QMyfzPvvvGtp
	 PJhf/UKUAZpeQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678f03e00000>; Tue, 21 Jan 2025 15:18:08 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 5D81013EDC3;
	Tue, 21 Jan 2025 15:18:08 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 62B582A1696; Tue, 21 Jan 2025 15:18:08 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: mvpp2: Add parser configuration for DSA tags
Date: Tue, 21 Jan 2025 15:18:04 +1300
Message-ID: <20250121021804.1302042-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678f03e0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=NI9pEJdog0NyfYoH2ZAA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Allow the header parser to consider DSA and EDSA tagging. Currently the
parser is always configured to use the MH tag, but this results in poor
traffic distribution across queues and sub-optimal performance (in the
case where DSA or EDSA tags are in the header).

Add mechanism to check for tag type in use and then configure the
parser correctly for this tag. This results in proper traffic
distribution and hash calculation.

Use mvpp2_get_tag instead of reading the MH register to determine tag
type. As the MH register is set during mvpp2_open it is subject to
change and not a proper reflection of the tagging type in use.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
Changes in v1:
- use mvpp2_get_tag to ascertain tagging type in use.

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  3 ++
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 37 ++++++++++++++++++-
 .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    | 16 +++++---
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/eth=
ernet/marvell/mvpp2/mvpp2.h
index 44fe9b68d1c2..456f9aeb4d82 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -59,6 +59,8 @@
=20
 /* Top Registers */
 #define MVPP2_MH_REG(port)			(0x5040 + 4 * (port))
+#define MVPP2_MH_EN				BIT(0)
+#define MVPP2_DSA_NON_EXTENDED			BIT(4)
 #define MVPP2_DSA_EXTENDED			BIT(5)
 #define MVPP2_VER_ID_REG			0x50b0
 #define MVPP2_VER_PP22				0x10
@@ -1538,6 +1540,7 @@ void mvpp2_dbgfs_cleanup(struct mvpp2 *priv);
 void mvpp2_dbgfs_exit(void);
=20
 void mvpp23_rx_fifo_fc_en(struct mvpp2 *priv, int port, bool en);
+int mvpp2_get_tag(struct net_device *dev);
=20
 #ifdef CONFIG_MVPP2_PTP
 int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index dd76c1b7ed3a..3a954da7660f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -38,6 +38,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/tso.h>
 #include <linux/bpf_trace.h>
+#include <net/dsa.h>
=20
 #include "mvpp2.h"
 #include "mvpp2_prs.h"
@@ -4769,6 +4770,36 @@ static bool mvpp22_rss_is_supported(struct mvpp2_p=
ort *port)
 		!(port->flags & MVPP2_F_LOOPBACK);
 }
=20
+int mvpp2_get_tag(struct net_device *dev)
+{
+	int tag;
+	int dsa_proto =3D DSA_TAG_PROTO_NONE;
+
+#if IS_ENABLED(CONFIG_NET_DSA)
+	if (netdev_uses_dsa(dev))
+		dsa_proto =3D dev->dsa_ptr->tag_ops->proto;
+#endif
+
+	switch (dsa_proto) {
+	case DSA_TAG_PROTO_DSA:
+		tag =3D MVPP2_TAG_TYPE_DSA;
+		break;
+	case DSA_TAG_PROTO_EDSA:
+	/**
+	 * DSA_TAG_PROTO_EDSA and MVPP2_TAG_TYPE_EDSA are
+	 * referring to separate things. MVPP2_TAG_TYPE_EDSA
+	 * refers to extended DSA, while DSA_TAG_PROTO_EDSA
+	 * refers to Ethertype DSA. Ethertype DSA requires no
+	 * setting in the parser.
+	 */
+	default:
+		tag =3D MVPP2_TAG_TYPE_MH;
+		break;
+	}
+
+	return tag;
+}
+
 static int mvpp2_open(struct net_device *dev)
 {
 	struct mvpp2_port *port =3D netdev_priv(dev);
@@ -4788,7 +4819,11 @@ static int mvpp2_open(struct net_device *dev)
 		netdev_err(dev, "mvpp2_prs_mac_da_accept own addr failed\n");
 		return err;
 	}
-	err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH)=
;
+
+	if (netdev_uses_dsa(dev))
+		err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, mvpp2_get_tag(dev=
));
+	else
+		err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH=
);
 	if (err) {
 		netdev_err(dev, "mvpp2_prs_tag_mode_set failed\n");
 		return err;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net=
/ethernet/marvell/mvpp2/mvpp2_prs.c
index 9af22f497a40..f14b9e8c301e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -1963,7 +1963,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port=
, u16 vid)
 {
 	unsigned int vid_start =3D MVPP2_PE_VID_FILT_RANGE_START +
 				 port->id * MVPP2_PRS_VLAN_FILT_MAX;
-	unsigned int mask =3D 0xfff, reg_val, shift;
+	unsigned int mask =3D 0xfff, tag, shift;
 	struct mvpp2 *priv =3D port->priv;
 	struct mvpp2_prs_entry pe;
 	int tid;
@@ -1973,8 +1973,8 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port=
, u16 vid)
 	/* Scan TCAM and see if entry with this <vid,port> already exist */
 	tid =3D mvpp2_prs_vid_range_find(port, vid, mask);
=20
-	reg_val =3D mvpp2_read(priv, MVPP2_MH_REG(port->id));
-	if (reg_val & MVPP2_DSA_EXTENDED)
+	tag =3D mvpp2_get_tag(port->dev);
+	if (tag & MVPP2_DSA_EXTENDED)
 		shift =3D MVPP2_VLAN_TAG_EDSA_LEN;
 	else
 		shift =3D MVPP2_VLAN_TAG_LEN;
@@ -2071,7 +2071,7 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_po=
rt *port)
 {
 	unsigned int tid =3D MVPP2_PRS_VID_PORT_DFLT(port->id);
 	struct mvpp2 *priv =3D port->priv;
-	unsigned int reg_val, shift;
+	unsigned int tag, shift;
 	struct mvpp2_prs_entry pe;
=20
 	if (priv->prs_shadow[tid].valid)
@@ -2081,8 +2081,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_po=
rt *port)
=20
 	pe.index =3D tid;
=20
-	reg_val =3D mvpp2_read(priv, MVPP2_MH_REG(port->id));
-	if (reg_val & MVPP2_DSA_EXTENDED)
+	tag =3D mvpp2_get_tag(port->dev);
+	if (tag & MVPP2_DSA_EXTENDED)
 		shift =3D MVPP2_VLAN_TAG_EDSA_LEN;
 	else
 		shift =3D MVPP2_VLAN_TAG_LEN;
@@ -2393,6 +2393,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int =
port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
+		/* Set Marvell Header register for Ext. DSA tag */
+		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_EXTENDED);
 		break;
=20
 	case MVPP2_TAG_TYPE_DSA:
@@ -2406,6 +2408,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int =
port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		/* Set Marvell Header register for DSA tag */
+		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_NON_EXTENDED);
 		break;
=20
 	case MVPP2_TAG_TYPE_MH:
--=20
2.47.1


