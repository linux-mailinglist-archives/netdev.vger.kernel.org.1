Return-Path: <netdev+bounces-291038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBPsIxtCEWrsjAYAu9opvQ
	(envelope-from <netdev+bounces-291038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E62135BD5D9
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E3B0304E4E4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17A31A570;
	Sat, 23 May 2026 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1N6Nt5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD333439
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515784; cv=none; b=UCl4y0gZ/b97llTnvYxyH7j2LXfwHekE8T1M0zaayLbcMrAnAU6q1pGWx1WH9E2xO+3WLYEvM/NrxeBqAtnq1MpKAemzn7y+X3gpvino4Hj3632cbtRYKVtxAWjrgjIt8iBNRFttWK9ZNmpN5Wv4BjLjV2iklMR6pT9RSPbvmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515784; c=relaxed/simple;
	bh=LEWs5swyZlzf2yL8EzLPdSAuQ2QDmyXR7FRBrl1424k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ui2SjbDiQwS3PNx017cX/ZaZDvWN31eo0sOQihN3bmi1jiX6LI18WkgoMqyVcjT1IWk1smhkeESh30R7P1ntqaWvnV+AaazKWL2/taA2SpUH29uTjEIZrVl5ntu+xlcd3dBu07h7NxFQXc8+BskQ6qDnzw1uo407ArfzwFEtCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1N6Nt5W; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56f75445470so6247423e0c.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779515780; x=1780120580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOtHAzQQa1iTfAL6DZV8/XhbP/uEZxKFmEY5ipF+zAY=;
        b=s1N6Nt5Wm5fAd5gwhoCsaKTa85wAYCc1GKnLTJHJoWepxclQvZhPs01eBKpSBlONV+
         3Fu2TcKIy7rB08h1E1OAKJ3s1szvBthGQHyZNXEWhIrl/ntckYNOxUBG7UBDZO2D8/xi
         ngo8BjJg6UHxWpNJmZUycKjl02bme0atD0BnuUMp+QmqVTp1UUZLkzViyC61b6pd5VXm
         7yHPY/3qjpo1T4HSpb0Wxi68ERRRe+2R0l+PZUdFBWUmqYXQv55eGs5S+H0wXC1PzQpC
         WaX4QwkUD55HrayOEA1Sy1EvkA/1PZE4KN8HVpbMxJ9WHZjA4CxcHSOglq83bdgnmZZZ
         HuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779515780; x=1780120580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOtHAzQQa1iTfAL6DZV8/XhbP/uEZxKFmEY5ipF+zAY=;
        b=TuWA0CMP8sYoJ0tVt5BbU94YtFYP9UnbM4di8YmC3wAeD8kO9B8xVkS+zXLjQKf7eC
         uWvGZykPK32SPQEdxHRe0qC92BIqlbg+kOfsob1D6vn9KavJdI5BUtpEqLeUSvSJ9MVf
         0wEUIhL3oMoQXGJ1PEsAlDfpOMmM5frwJydWC1733ZRCv96xQz7PvSBbF6TH78MoroRI
         weEQ4vKUZdo5FiHqHws1oc6cL2usoKi0bC7JW35Yhmi4darKrn+KrKVfJT9cofJFr/S5
         pZBcD4L0xcKhqSjPDKJQzUQlxuvx23ieaIhahmCgRdfRb25eDD5ad34g4Fc9MsOECO0u
         uYEw==
X-Gm-Message-State: AOJu0Yzo+4a4fO9+WWrn5e8+gPZt0Nl46WuIa7qEvc2IdhozySDNUB0e
	vX+MT7osLMPBvHYkoHjwo9K0/4gLwW7+9RzJ67Mt0nl9q/UVpEdZbtqa
X-Gm-Gg: Acq92OHFB7v1TSMvQQIbAuUdr6dWq8SRS57z0bnnXDPXioXqyxXQsH5XmTJqDALwXLx
	K73eyRKs5w4JAZ43pvLOEMlWPwvIa0wdbPEr6UqBqikRySbQ8liIhRrXXtQYbqnfgFYedIuOj8x
	nMc1i2pjStuT56JnAG+sUSjKchetvnpjhthHh48NM6SsE5cqotyAZoaDZthT9c2uC/wxyn81bZQ
	gaaR5U0lzhD5axlCojJ3HgtaDQ/dpScdL/UeMrE5LokEqZIyvifUAOYtrshTpNFpnAq8TQOOKtv
	kbcOPu0ltjSP6EX6wIB0z90KvE27veTzUWsoCXz5tvEakshIZQsVx0jZP193hR9yzxOQsyh+Sz9
	OcJjorVG4POQbmz/lOvBpysNC4OzUVXVJM5yyPL7NWDAocgQ54kLtZNQCaS3GIZ6ondCyZda47h
	pAkfvDlbpb8bfbe19u6g3M70xP9gz0U6kYeSakXO6vVWTy6Y+dPw==
X-Received: by 2002:a05:6122:e250:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-5865fc0355cmr3963769e0c.5.1779515779702;
        Fri, 22 May 2026 22:56:19 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f973300dsm5023718e0c.18.2026.05.22.22.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:56:18 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 May 2026 02:55:38 -0300
Subject: [net-next PATCH v7 5/8] net: dsa: realtek: rtl8365mb: add VLAN
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260523-realtek_forward-v7-5-313805e218f3@gmail.com>
References: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
In-Reply-To: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yury Norov <ynorov@nvidia.com>, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bang-olufsen.dk:email,nvidia.com:email]
X-Rspamd-Queue-Id: E62135BD5D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
structures for VLANs:

- VLAN4K: A full table with 4096 entries defining port membership and
  tagging.
- VLANMC: A smaller table with 32 entries used primarily for PVID
  assignment.

In this hardware, a port's PVID must point to an index in the VLANMC
table rather than a VID directly. Since the VLANMC table is limited to
32 entries, the driver implements a dynamic allocation scheme to
maximize resource usage:

- VLAN4K is treated by the driver as the source of truth for membership.
- A VLANMC entry is only allocated when a port is configured to use a
  specific VID as its PVID.
- VLANMC entries are deleted when no longer needed as a PVID by any port.

Although VLANMC has a members field, the switch only checks membership
in the VLAN4K table. This driver will use VLANMC members field as way to
track which ports are using that entry as PVID.

VLANMC index 0, although a valid entry, is reserved in this driver as a
neutral PVID value for ports not using a specific PVID.

In the subsequent RTL8367D switch family, VLANMC table was
removed and PVID assignment was delegated to a dedicated set of
registers.

All ports start isolated, forwarding exclusively to CPU ports, and
with VLAN transparent, ignoring VLAN membership. Once a member in a
bridge, the port isolation is expanded to include the bridge members.
When that bridge enables VLAN filtering, the VLAN transparent feature is
disabled, letting the switch filter based on VLAN setup.

The use of FIELD_PREP for reconstructing LO/HI values was suggested by
Yury Norov.

Fix for vlan_setup and vlan_filtering was suggested by Abdulkader
Alrezej.

Suggested-by: Yury Norov <ynorov@nvidia.com>
Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/realtek.h        |   5 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 309 ++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 961 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  41 ++
 drivers/net/dsa/realtek/rtl83xx.c        |   1 +
 6 files changed, 1318 insertions(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 99654c4c5a3d..b7fc4e852fd8 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -18,3 +18,4 @@ endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
+		  rtl8365mb_vlan.o \
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index c03485a80d93..b9c4cbdd72fb 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -54,6 +54,11 @@ struct realtek_priv {
 	struct regmap		*map;
 	struct regmap		*map_nolock;
 	struct mutex		map_lock;
+	/* vlan_lock protects against concurrent Read-Modify-Write operations
+	 * on the global VLAN 4K and VLANMC tables, such as when adding or
+	 * deleting port VLAN memberships and PVID configurations.
+	 */
+	struct mutex		vlan_lock;
 	struct mii_bus		*user_mii_bus;
 	struct mii_bus		*bus;
 	int			mdio_addr;
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 27746b0694c9..c04145aabcaa 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_vlan.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -292,6 +293,57 @@
 #define   RTL8365MB_MSTI_CTRL_PORT_STATE_MASK(_physport) \
 		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
 
+/* Miscellaneous port configuration register, incl. VLAN egress mode */
+#define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
+#define RTL8365MB_PORT_MISC_CFG_REG(_p) \
+		(RTL8365MB_PORT_MISC_CFG_REG_BASE + ((_p) << 5))
+#define   RTL8365MB_PORT_MISC_CFG_SMALL_TAG_IPG_MASK		0x8000
+#define   RTL8365MB_PORT_MISC_CFG_TX_ITFSP_MODE_MASK		0x4000
+#define   RTL8365MB_PORT_MISC_CFG_FLOWCTRL_INDEP_MASK		0x2000
+#define   RTL8365MB_PORT_MISC_CFG_DOT1Q_REMARK_ENABLE_MASK	0x1000
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_FLOWCTRL_MASK	0x0800
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_IFG_MASK		0x0400
+#define   RTL8365MB_PORT_MISC_CFG_RX_SPC_MASK			0x0200
+#define   RTL8365MB_PORT_MISC_CFG_CRC_SKIP_MASK			0x0100
+#define   RTL8365MB_PORT_MISC_CFG_PKTGEN_TX_FIRST_MASK		0x0080
+#define   RTL8365MB_PORT_MISC_CFG_MAC_LOOPBACK_MASK		0x0040
+/* See &rtl8365mb_vlan_egress_mode */
+#define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		0x0030
+#define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	0x000F
+
+/**
+ * enum rtl8365mb_vlan_egress_mode - port VLAN egress mode
+ * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
+ * @RTL8365MB_VLAN_EGRESS_MODE_KEEP: the VLAN tag format of egressed packets
+ * will remain the same as their ingressed format, but the priority and VID
+ * fields may be altered
+ * @RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG: always egress with priority tag
+ * @RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP: the VLAN tag format of egressed
+ * packets will remain the same as their ingressed format, and neither the
+ * priority nor VID fields can be altered
+ */
+enum rtl8365mb_vlan_egress_mode {
+	RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL = 0,
+	RTL8365MB_VLAN_EGRESS_MODE_KEEP = 1,
+	RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG = 2,
+	RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP = 3,
+};
+
+/* VLAN control register */
+#define RTL8365MB_VLAN_CTRL_REG			0x07A8
+#define   RTL8365MB_VLAN_CTRL_EN_MASK		0x0001
+
+/* VLAN ingress filter register */
+#define RTL8365MB_VLAN_INGRESS_REG				0x07A9
+#define   RTL8365MB_VLAN_INGRESS_MASK				GENMASK(10, 0)
+#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_OFFSET(_p)	(_p)
+#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(_p)	BIT(_p)
+
+/* VLAN "transparent" setting registers */
+#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE	0x09D0
+#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(_p) \
+		(RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE + (_p))
+
 /* MIB counter value registers */
 #define RTL8365MB_MIB_COUNTER_BASE	0x1000
 #define RTL8365MB_MIB_COUNTER_REG(_x)	(RTL8365MB_MIB_COUNTER_BASE + (_x))
@@ -1210,6 +1262,253 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
 			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
 }
 
+static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
+					  int igr_port, int egr_port,
+					  bool enable)
+{
+	dev_dbg(priv->dev, "%s transparent VLAN from %d to %d\n",
+		enable ? "Enable" : "Disable", igr_port, egr_port);
+
+	/* "Transparent" between the two ports means that packets forwarded by
+	 * igr_port and egressed on egr_port will not be filtered by the usual
+	 * VLAN membership settings.
+	 */
+	return regmap_update_bits(priv->map,
+			RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(egr_port),
+			BIT(igr_port), enable ? BIT(igr_port) : 0);
+}
+
+static int rtl8365mb_port_set_ingress_filtering(struct realtek_priv *priv,
+						int port, bool enable)
+{
+	/* Ingress filtering enabled: Discard VLAN-tagged frames if the port is
+	 * not a member of the VLAN with which the packet is associated.
+	 * Untagged packets will also be discarded unless the port has a PVID
+	 * programmed. Priority-tagged frames are treated as untagged frames.
+	 *
+	 * Ingress filtering disabled: Accept all tagged and untagged frames.
+	 */
+	return regmap_update_bits(priv->map, RTL8365MB_VLAN_INGRESS_REG,
+			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port),
+			enable ?
+			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port) :
+			0);
+}
+
+static int
+rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
+				    enum rtl8365mb_vlan_egress_mode mode)
+{
+	u32 val;
+
+	val = FIELD_PREP(RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, mode);
+	return regmap_update_bits(priv->map,
+			RTL8365MB_PORT_MISC_CFG_REG(port),
+			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
+}
+
+static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
+					 bool vlan_filtering,
+					 struct netlink_ext_ack *extack)
+{
+	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
+	enum rtl8365mb_vlan_egress_mode mode;
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u16 pvid_vid;
+	int ret;
+
+	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
+		vlan_filtering ? "enable" : "disable");
+
+	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
+						  &prev_accepted_frame);
+	if (ret) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to get current framefilter");
+		return ret;
+	}
+
+	/* While filtering, only accepts untagged frames if PVID is enabled */
+	if (vlan_filtering) {
+		dp = dsa_to_port(ds, port);
+
+		ret = rtl8365mb_vlan_port_get_pvid(priv, port, &pvid_vid);
+		if (ret)
+			return ret;
+
+		if (pvid_vid)
+			accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
+		else
+			accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
+	} else {
+		accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
+	}
+
+	/* When vlan filter is enable/disabled in a bridge, this function is
+	 * called for all member ports. We need to enable/disable ingress
+	 * VLAN membership check.
+	 */
+	ret = rtl8365mb_port_set_ingress_filtering(priv, port, vlan_filtering);
+	if (ret)
+		return ret;
+
+	/* However, we also enable/disable egress filtering because the switch
+	 * still consider the egress interface VLAN membership to forward the
+	 * traffic. We enable/disable that check disabling/enabling transparent
+	 * VLAN between the ingress port and all other available ports.
+	 */
+	dsa_switch_for_each_available_port(dp, ds) {
+		/* port isolation will still keep traffic inside the bridge */
+		ret = rtl8365mb_port_set_transparent(priv, port, dp->index,
+						     !vlan_filtering);
+		if (ret)
+			goto undo_transparent;
+	}
+
+	if (accepted_frame != prev_accepted_frame) {
+		ret = rtl8365mb_vlan_port_set_framefilter(priv, port,
+							  accepted_frame);
+		if (ret) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to set port framefilter");
+			goto undo_transparent;
+		}
+	}
+
+	/* When VLAN filtering is disabled, preserve frames exactly as received.
+	 * Otherwise, the VLAN egress pipeline may still alter tag state
+	 * according to VLAN membership and untag configuration.
+	 */
+	if (vlan_filtering)
+		mode = RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL;
+	else
+		mode = RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP;
+
+	ret = rtl8365mb_port_set_vlan_egress_mode(priv, port, mode);
+	if (ret)
+		goto undo_set_framefilter;
+
+	return ret;
+
+undo_set_framefilter:
+	if (prev_accepted_frame != accepted_frame)
+		rtl8365mb_vlan_port_set_framefilter(priv, port,
+						    prev_accepted_frame);
+undo_transparent:
+	dsa_switch_for_each_port_continue_reverse(dp, ds) {
+		if (dsa_port_is_unused(dp))
+			continue;
+
+		rtl8365mb_port_set_transparent(priv, port, dp->index,
+					       vlan_filtering);
+	}
+
+	rtl8365mb_port_set_ingress_filtering(priv, port, !vlan_filtering);
+
+	return ret;
+}
+
+static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
+				   const struct switchdev_obj_port_vlan *vlan,
+				   struct netlink_ext_ack *extack)
+{
+	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	int ret;
+
+	dev_dbg(priv->dev, "add VLAN %d on port %d, %s, %s\n",
+		vlan->vid, port, untagged ? "untagged" : "tagged",
+		pvid ? "PVID" : "no PVID");
+
+	/* VID == 0 is reserved in this driver */
+	if (vlan->vid == 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "VLAN 0 is not supported by this hardware");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&priv->vlan_lock);
+
+	/* add port to vlan4k. It knows nothing about PVID */
+	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
+	if (ret)
+		goto out_unlock;
+
+	/* Set PVID if needed */
+	if (pvid) {
+		ret = rtl8365mb_vlan_pvid_port_add(ds, port, vlan, extack);
+		if (ret)
+			goto undo_vlan_4k;
+	} else {
+		/* or try to unset it if not */
+		ret = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
+		if (ret)
+			goto undo_vlan_4k;
+	}
+
+	ret = 0;
+	goto out_unlock;
+
+undo_vlan_4k:
+	(void)rtl8365mb_vlan_4k_port_del(ds, port, vlan);
+
+out_unlock:
+	mutex_unlock(&priv->vlan_lock);
+	return ret;
+}
+
+static int rtl8365mb_port_vlan_del(struct dsa_switch *ds, int port,
+				   const struct switchdev_obj_port_vlan *vlan)
+{
+	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	int ret1, ret2;
+
+	dev_dbg(priv->dev, "del VLAN %d on port %d, %s, %s\n",
+		vlan->vid, port, untagged ? "untagged" : "tagged",
+		pvid ? "PVID" : "no PVID");
+
+	mutex_lock(&priv->vlan_lock);
+	ret1 = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
+	ret2 = rtl8365mb_vlan_4k_port_del(ds, port, vlan);
+	mutex_unlock(&priv->vlan_lock);
+
+	return ret1 ?: ret2;
+}
+
+/* VLAN support is always enabled in the switch.
+ *
+ * Standalone forwarding relies on transparent VLAN mode combined with per-port
+ * isolation masks restricting egress to CPU ports only.
+ *
+ */
+static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int ret;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		/* Disable vlan-filtering for all ports */
+		ret = rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to disable vlan filtering on port %d\n",
+				dp->index);
+			return ret;
+		}
+	}
+
+	/* VLAN is always enabled. */
+	ret = regmap_update_bits(priv->map, RTL8365MB_VLAN_CTRL_REG,
+				 RTL8365MB_VLAN_CTRL_EN_MASK,
+				 FIELD_PREP(RTL8365MB_VLAN_CTRL_EN_MASK, 1));
+	return ret;
+}
+
 static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 				       bool enable)
 {
@@ -2095,6 +2394,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	ds->configure_vlan_while_not_filtering = true;
+
+	/* Set up VLAN */
+	ret = rtl8365mb_vlan_setup(ds);
+	if (ret)
+		goto out_teardown_irq;
+
 	ret = rtl83xx_setup_user_mdio(ds);
 	if (ret) {
 		dev_err(priv->dev, "could not set up MDIO bus\n");
@@ -2205,6 +2511,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
+	.port_vlan_add = rtl8365mb_port_vlan_add,
+	.port_vlan_del = rtl8365mb_port_vlan_del,
+	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
 	.get_sset_count = rtl8365mb_get_sset_count,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
new file mode 100644
index 000000000000..202ef9de1161
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -0,0 +1,961 @@
+// SPDX-License-Identifier: GPL-2.0
+/* VLAN configuration interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ *
+ * VLAN configuration takes place in two separate domains of the switch: the
+ * VLAN4k table and the VLAN membership configuration (MC) database. While the
+ * VLAN4k table is exhaustive and can be fully populated with 4096 VLAN
+ * configurations, the same does not hold for the VLAN membership configuration
+ * database, which is limited to 32 entries.
+ *
+ * The switch will normally only use the VLAN4k table when making forwarding
+ * decisions. The VLAN membership configuration database is a vestigial ASIC
+ * design and is only used for a few specific features in the rtl8365mb
+ * family. This means that the limit of 32 entries should not hinder us in
+ * programming a huge number of VLANs into the switch.
+ *
+ * One necessary use of the VLAN membership configuration database is for the
+ * programming of a port-based VLAN ID (PVID). The PVID is programmed on a
+ * per-port basis via register field, which refers to a specific VLAN membership
+ * configuration via an index 0~31. In order to maintain coherent behaviour on a
+ * port with a PVID, it is necessary to keep the VLAN configuration synchronized
+ * between the VLAN4k table and the VLAN membership configuration database.
+ *
+ * Since VLAN membership configs are a scarce resource, it will only be used
+ * when strictly needed (i.e. a VLAN with members using PVID). Otherwise, the
+ * VLAN4k will be enough.
+ *
+ * With some exceptions, the entries in both the VLAN4k table and the VLAN
+ * membership configuration database offer the same configuration options. The
+ * differences are as follows:
+ *
+ * 1. VLAN4k entries can specify whether to use Independent or Shared VLAN
+ *    Learning (IVL or SVL respectively). VLAN membership config entries
+ *    cannot. This underscores the fact that VLAN membership configs are not
+ *    involved in the learning process of the ASIC.
+ *
+ * 2. VLAN membership config entries use an "enhanced VLAN ID" (efid), which has
+ *    a range 0~8191 compared with the standard 0~4095 range of the VLAN4k
+ *    table. This underscores the fact that VLAN membership configs can be used
+ *    to group ports on a layer beyond the standard VLAN configuration, which
+ *    may be useful for ACL rules which specify alternative forwarding
+ *    decisions.
+ *
+ * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
+ *
+ */
+
+#include "rtl8365mb_vlan.h"
+#include "rtl8365mb_table.h"
+#include <linux/if_bridge.h>
+#include <linux/lockdep.h>
+#include <linux/regmap.h>
+
+/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
+#define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
+#define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
+#define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
+#define   RTL8365MB_CVLAN_UNTAG_LO_MASK			GENMASK(7, 0)
+#define RTL8365MB_CVLAN_ENTRY_D1_FID_MASK		GENMASK(3, 0)
+#define RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK		GENMASK(4, 4)
+#define RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK		GENMASK(7, 5)
+#define RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK		GENMASK(8, 8)
+#define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
+#define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
+#define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+/* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
+#define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
+/* extends RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK		GENMASK(5, 3)
+#define   RTL8365MB_CVLAN_UNTAG_HI_MASK			GENMASK(10, 8)
+/* extends RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK	GENMASK(6, 6)
+#define   RTL8365MB_CVLAN_METERIDX_HI_MASK		GENMASK(5, 5)
+
+/* VLAN member configuration registers 0~31, u16[3] */
+#define RTL8365MB_VLAN_MC_BASE				0x0728
+#define RTL8365MB_VLAN_MC_ENTRY_SIZE			4 /* 64-bit */
+#define RTL8365MB_VLAN_MC_REG(index) \
+		(RTL8365MB_VLAN_MC_BASE + \
+		 (RTL8365MB_VLAN_MC_ENTRY_SIZE * (index)))
+#define   RTL8365MB_VLAN_MC_D0_MBR_MASK			GENMASK(10, 0)
+#define   RTL8365MB_VLAN_MC_D1_FID_MASK			GENMASK(3, 0)
+
+#define   RTL8365MB_VLAN_MC_D2_VBPEN_MASK		GENMASK(0, 0)
+#define   RTL8365MB_VLAN_MC_D2_VBPRI_MASK		GENMASK(3, 1)
+#define   RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK		GENMASK(4, 4)
+#define   RTL8365MB_VLAN_MC_D2_METERIDX_MASK		GENMASK(10, 5)
+#define   RTL8365MB_VLAN_MC_D3_EVID_MASK		GENMASK(12, 0)
+
+/* Some limits for VLAN4k/VLAN membership config entries */
+#define RTL8365MB_PRIORITYMAX	7
+#define RTL8365MB_FIDMAX	15
+#define RTL8365MB_METERMAX	63
+#define RTL8365MB_VLAN_MCMAX	31
+
+/* RTL8367S supports 4k vlans (vid<=4095) and 32 enhanced vlans
+ * for VIDs up to 8191
+ */
+#define RTL8365MB_MAX_4K_VID	0x0FFF /* 4095 */
+#define RTL8365MB_MAX_MC_VID	0x1FFF /* 8191 */
+
+ /* Port-based VID registers 0~5 - each one holds an MC index for two ports */
+#define RTL8365MB_VLAN_PVID_CTRL_BASE			0x0700
+#define RTL8365MB_VLAN_PVID_CTRL_REG(_p) \
+		(RTL8365MB_VLAN_PVID_CTRL_BASE + ((_p) >> 1))
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT0_MCIDX_MASK	0x001F
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT1_MCIDX_MASK	0x1F00
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p) \
+		(((_p) & 1) << 3)
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
+		(0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
+
+/* Frame type filtering registers */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
+		(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE + ((port) >> 3))
+/* required as FIELD_PREP cannot use non-constant masks */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port) \
+		(0x3 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port))
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port) \
+		(((port) & 0x7) << 1)
+
+/**
+ * struct rtl8365mb_vlan4k - VLAN4k table entry
+ * @vid: VLAN ID (0~4095)
+ * @member: port mask of ports in this VLAN
+ * @untag: port mask of ports which untag on egress
+ * @fid: filter ID - only used with SVL (unused)
+ * @priority: priority classification (unused)
+ * @priority_en: enable priority (unused)
+ * @policing_en: enable policing (unused)
+ * @ivl_en: enable IVL instead of default SVL
+ * @meteridx: metering index (unused)
+ *
+ * This structure is used to get/set entries in the VLAN4k table. The
+ * VLAN4k table dictates the VLAN configuration for the switch for the
+ * vast majority of features.
+ */
+struct rtl8365mb_vlan4k {
+	u16 vid;
+	u16 member;
+	u16 untag;
+	u8 fid : 4;
+	u8 priority : 3;
+	u8 priority_en : 1;
+	u8 policing_en : 1;
+	u8 ivl_en : 1;
+	u8 meteridx : 6;
+};
+
+/**
+ * struct rtl8365mb_vlanmc - VLAN membership config
+ * @evid: Enhanced VLAN ID (0~8191)
+ * @member: port mask of ports in this VLAN
+ * @fid: filter ID - only used with SVL (unused)
+ * @priority: priority classification (unused)
+ * @priority_en: enable priority (unused)
+ * @policing_en: enable policing (unused)
+ * @meteridx: metering index (unused)
+ *
+ * This structure is used to get/set entries in the VLAN membership
+ * configuration database. This feature is largely vestigial, but
+ * still needed for at least the following features:
+ *   - PVID configuration
+ *   - ACL configuration
+ *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
+ *     can also select VLAN based on the VLAN tag if VSEL=0
+ *
+ * This is a low-level structure and it is recommended to interface with
+ * the VLAN membership config database via &struct rtl8365mb_vlanmc_entry.
+ */
+struct rtl8365mb_vlanmc {
+	u16 evid;
+	u16 member;
+	u8 fid : 4;
+	u8 priority : 3;
+	u8 priority_en : 1;
+	u8 policing_en : 1;
+	u8 meteridx : 6;
+};
+
+static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+				  struct rtl8365mb_vlan4k *vlan4k)
+{
+	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
+	int val;
+	int ret;
+
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
+				    data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	/* Unpack table entry */
+	memset(vlan4k, 0, sizeof(*vlan4k));
+	vlan4k->vid = vid;
+
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]);
+	vlan4k->member = FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK, val);
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
+	vlan4k->member |= FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK, val);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, data[0]);
+	vlan4k->untag = FIELD_PREP(RTL8365MB_CVLAN_UNTAG_LO_MASK, val);
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, data[2]);
+	vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
+
+	vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, data[1]);
+	vlan4k->priority_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK, data[1]);
+	vlan4k->priority =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK, data[1]);
+	vlan4k->policing_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK, data[1]);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, data[1]);
+	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
+	vlan4k->meteridx = val;
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, data[2]);
+	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+	vlan4k->meteridx |= val;
+
+	vlan4k->ivl_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK, data[1]);
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
+				   const struct rtl8365mb_vlan4k *vlan4k)
+{
+	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
+	u16 vid;
+	int val;
+
+	/* Pack table entry value */
+	val = FIELD_GET(RTL8365MB_CVLAN_MBR_LO_MASK, vlan4k->member);
+	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, val);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_LO_MASK, vlan4k->untag);
+	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, val);
+
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, vlan4k->fid);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
+			      vlan4k->priority_en);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
+			      vlan4k->priority);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
+			      vlan4k->policing_en);
+
+	/* FIELD_* does not play nice with struct bitfield. */
+	val = vlan4k->meteridx;
+	val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, val);
+
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
+			      vlan4k->ivl_en);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_MBR_HI_MASK, vlan4k->member);
+	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, val);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_HI_MASK, vlan4k->untag);
+	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, val);
+
+	val = vlan4k->meteridx;
+	val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, val);
+
+	vid = vlan4k->vid;
+	return rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				     RTL8365MB_TABLE_OP_WRITE, &vid, 0, 0,
+				     data, ARRAY_SIZE(data));
+}
+
+#define RTL_VLAN_ERR(msg)						\
+	do {								\
+		const char *__msg = (msg);				\
+									\
+		if (extack)						\
+			NL_SET_ERR_MSG_FMT_MOD(extack, "%s", __msg);	\
+		dev_err(priv->dev, "%s", __msg);			\
+	} while (0)
+
+static int
+rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
+			   const struct switchdev_obj_port_vlan *vlan,
+			   struct netlink_ext_ack *extack,
+			       bool include)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlan4k vlan4k = {0};
+	int ret;
+
+	dev_dbg(priv->dev, "%s VLAN %d 4K on port %d\n",
+		include ? "add" : "del",
+		vlan->vid, port);
+
+	if (vlan->vid > RTL8365MB_MAX_4K_VID) {
+		RTL_VLAN_ERR("VLAN ID greater than "
+			     __stringify(RTL8365MB_MAX_4K_VID));
+		return -EINVAL;
+	}
+
+	ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLAN 4k table");
+		return ret;
+	}
+
+	if (include)
+		vlan4k.member |= BIT(port);
+	else
+		vlan4k.member &= ~BIT(port);
+
+	if (include && (vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED))
+		vlan4k.untag |= BIT(port);
+	else
+		vlan4k.untag &= ~BIT(port);
+	vlan4k.ivl_en = true; /* always use Independent VLAN Learning */
+
+	ret = rtl8365mb_vlan_4k_write(priv, &vlan4k);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to write VLAN 4k table");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_4k_port_add() - Add a port to a VLAN 4K table entry
+ * @ds: dsa switch instance
+ * @port: port index
+ * @vlan: switchdev VLAN object containing the target VID and flags
+ * @extack: netlink extended ACK for error reporting
+ *
+ * Adds the specified port to the hardware VLAN 4K membership table.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+
+	lockdep_assert_held(&priv->vlan_lock);
+
+	return rtl8365mb_vlan_4k_port_set(ds, port, vlan, extack, true);
+}
+
+/**
+ * rtl8365mb_vlan_4k_port_del() - Remove a port from a VLAN 4K table entry
+ * @ds: dsa switch instance
+ * @port: port index
+ * @vlan: switchdev VLAN object containing the target VID
+ *
+ * Removes the specified port from the hardware VLAN 4K membership table.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan)
+{
+	struct realtek_priv *priv = ds->priv;
+
+	lockdep_assert_held(&priv->vlan_lock);
+
+	return rtl8365mb_vlan_4k_port_set(ds, port, vlan, NULL, false);
+}
+
+static int rtl8365mb_vlan_mc_read(struct realtek_priv *priv, u32 index,
+				  struct rtl8365mb_vlanmc *vlanmc)
+{
+	u16 data[RTL8365MB_VLAN_MC_ENTRY_SIZE];
+	int ret;
+
+	ret = regmap_bulk_read(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+			       RTL8365MB_VLAN_MC_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	vlanmc->member = FIELD_GET(RTL8365MB_VLAN_MC_D0_MBR_MASK, data[0]);
+	vlanmc->fid = FIELD_GET(RTL8365MB_VLAN_MC_D1_FID_MASK, data[1]);
+	vlanmc->meteridx = FIELD_GET(RTL8365MB_VLAN_MC_D2_METERIDX_MASK,
+				     data[2]);
+	vlanmc->policing_en = FIELD_GET(RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK,
+					data[2]);
+	vlanmc->priority = FIELD_GET(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, data[2]);
+	vlanmc->priority_en = FIELD_GET(RTL8365MB_VLAN_MC_D2_VBPEN_MASK,
+					data[2]);
+	vlanmc->evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, data[3]);
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_mc_write(struct realtek_priv *priv, u32 index,
+				   const struct rtl8365mb_vlanmc *vlanmc)
+{
+	u16 data[RTL8365MB_VLAN_MC_ENTRY_SIZE] = { 0 };
+	int ret;
+
+	data[0] |= FIELD_PREP(RTL8365MB_VLAN_MC_D0_MBR_MASK, vlanmc->member);
+	data[1] |= FIELD_PREP(RTL8365MB_VLAN_MC_D1_FID_MASK, vlanmc->fid);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_METERIDX_MASK,
+			      vlanmc->meteridx);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK,
+			      vlanmc->policing_en);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, vlanmc->priority);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPEN_MASK,
+			      vlanmc->priority_en);
+	data[3] |= FIELD_PREP(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlanmc->evid);
+
+	ret = regmap_bulk_write(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+				RTL8365MB_VLAN_MC_ENTRY_SIZE);
+
+	return ret;
+}
+
+static int rtl8365mb_vlan_mc_erase(struct realtek_priv *priv, u32 index)
+{
+	u16 data[RTL8365MB_VLAN_MC_ENTRY_SIZE] = { 0 };
+	int ret;
+
+	ret = regmap_bulk_write(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+				RTL8365MB_VLAN_MC_ENTRY_SIZE);
+
+	return ret;
+}
+
+/**
+ * rtl8365mb_vlan_mc_find() - find VLANMC index by VID or the first free index
+ *
+ * @priv: realtek_priv pointer
+ * @vid: VLAN ID
+ * @index: found index
+ * @first_free: found free index
+ *
+ * If a VLAN MC entry using @vid was found, @index will return the matched index
+ * and @first_free is undefined. If not found, @index will return 0 and
+ * @first_free will return the first found free index in VLAN MC or 0 if the
+ * table is full.
+ *
+ * Although 0 is a valid VLAN MC index, it is reserved for ports without PVID,
+ * including standalone, non-member ports. It uses VID == 0.
+ *
+ * Both @index and @first_free will be in the * 1..@RTL8365MB_VLAN_MCMAX range.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ *
+ */
+static int rtl8365mb_vlan_mc_find(struct realtek_priv *priv, u16 vid,
+				  u8 *index, u8 *first_free)
+{
+	u32 vlan_entry_d3;
+	u8 vlanmc_idx;
+	u16 evid;
+	int ret;
+
+	*index = 0;
+	*first_free = 0;
+
+	/* look for existing entry or an empty one */
+	/* By design, VlanMC[0] is reserved as a neutral PVID value for
+	 * standalone ports. It always has EVID == 0. That way, we assume that
+	 * all entries after index 0 with VID == 0 are empty.
+	 **/
+	for (vlanmc_idx = 1; vlanmc_idx <= RTL8365MB_VLAN_MCMAX; vlanmc_idx++) {
+		/* just read the 4th word, where the evid is */
+		ret = regmap_read(priv->map,
+				  RTL8365MB_VLAN_MC_REG(vlanmc_idx) + 3,
+				  &vlan_entry_d3);
+		if (ret)
+			return ret;
+
+		evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlan_entry_d3);
+
+		if (evid == vid) {
+			*index = vlanmc_idx;
+			return 0;
+		}
+
+		if (evid == 0x0 && *first_free < 1)
+			*first_free = vlanmc_idx;
+	}
+	return 0;
+}
+
+static int rtl8365mb_vlan_port_get_pvid_idx(struct realtek_priv *priv,
+					    int port, u8 *vlanmc_idx)
+{
+	u32 data;
+	int ret;
+
+	ret = regmap_read(priv->map, RTL8365MB_VLAN_PVID_CTRL_REG(port), &data);
+	if (ret)
+		return ret;
+
+	*vlanmc_idx = (data & RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(port))
+		      >> RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(port);
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_mc_port_set() - include or exclude a port from VlanMC
+ * @ds: dsa switch
+ * @port: the port number
+ * @vid: the vlan VID to include/exclude @port
+ * @pvid: inform if vid is used as pvid in @port
+ * @extack: optional extack to return errors
+ * @include: whether to include or exclude @port
+ *
+ * This function is used to include/exclude ports to the VlanMC table.
+ *
+ * VlanMC stands for VLAN membership config and it is used exclusively for
+ * PVID. If @vlan members are not using PVID, this function will either
+ * remove or not create a new VlanMC entry.
+ *
+ * VlanMC members are used as a reference port map, cleaning the entry once
+ * no port is using it.
+ *
+ * Port PVID and accepted frame type are updated as well.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: Returns 0 on success, a negative error on failure.
+ */
+static
+int rtl8365mb_vlan_mc_port_set(struct dsa_switch *ds, int port,
+			       u16 vid, bool pvid,
+			       struct netlink_ext_ack *extack,
+			       bool include)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u8 first_unused = 0;
+	u8 vlanmc_idx = 0;
+	int ret;
+
+	dev_dbg(priv->dev, "%s VLAN %d MC on port %d\n",
+		include ? "add" : "del",
+		vid, port);
+
+	if (vid > RTL8365MB_MAX_MC_VID) {
+		RTL_VLAN_ERR("VLAN ID greater than "
+			     __stringify(RTL8365MB_MAX_MC_VID));
+		return -EINVAL;
+	}
+
+	/* look for existing entry or an empty slot */
+	ret = rtl8365mb_vlan_mc_find(priv, vid, &vlanmc_idx,
+				     &first_unused);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to find a VLAN MC table index");
+		return ret;
+	}
+
+	if (vlanmc_idx) {
+		ret = rtl8365mb_vlan_mc_read(priv, vlanmc_idx, &vlanmc);
+		if (ret) {
+			RTL_VLAN_ERR("Failed to read VLAN MC table");
+			return ret;
+		}
+	} else if (include) {
+		/* for now, vlan_mc is only required for PVID. Defer allocation
+		 * until at least one port uses PVID.
+		 */
+		if (!pvid) {
+			dev_dbg(priv->dev,
+				"Not creating VlanMC for vlan %d until a port uses PVID (%d does not)\n",
+				vid, port);
+			return 0;
+		}
+
+		if (!first_unused) {
+			RTL_VLAN_ERR("All VLAN MC entries (0.."
+				     __stringify(RTL8365MB_VLAN_MCMAX)
+				     ") are in use.");
+			return -E2BIG;
+		}
+
+		vlanmc_idx = first_unused;
+		vlanmc.evid = vid;
+
+	} else /* excluding and VLANMC not found */ {
+		return 0;
+	}
+
+	dev_dbg(priv->dev,
+		"VLAN %d (idx: %d) PVID curr members: %08x\n",
+		vid, vlanmc_idx, vlanmc.member);
+
+	/* here we either have an existing VLANMC (with PVID members) or the
+	 * added port is using this VLAN as PVID
+	 */
+	if (include)
+		vlanmc.member |= BIT(port);
+	else
+		vlanmc.member &= ~BIT(port);
+
+	/* just like we don't need to create a VLAN_MC when there is no port
+	 * using it as PVID, we can erase it when there is no more port using
+	 * it as PVID.
+	 */
+	if (!vlanmc.member) {
+		dev_dbg(priv->dev,
+			"Clearing VlanMC index %d previously used by VID %d\n",
+			vlanmc_idx, vid);
+		ret = rtl8365mb_vlan_mc_erase(priv, vlanmc_idx);
+	} else {
+		dev_dbg(priv->dev,
+			"Saving VlanMC index %d with VID %d\n",
+			vlanmc_idx, vid);
+		ret = rtl8365mb_vlan_mc_write(priv, vlanmc_idx, &vlanmc);
+	}
+	if (ret) {
+		RTL_VLAN_ERR("Failed to write vlan MC entry");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_port_set_pvid(struct realtek_priv *priv,
+					int port, u16 vlanmc_idx)
+{
+	int ret;
+	u32 val;
+
+	dev_dbg(priv->dev, "set PVID IDX %d on port %d\n", vlanmc_idx, port);
+
+	val = vlanmc_idx << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(port);
+	ret = regmap_update_bits(priv->map,
+				 RTL8365MB_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(port),
+				 val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_mc_get_pvid(struct realtek_priv *priv,
+				      int port, u8 *vlanmc_idx,
+				      struct rtl8365mb_vlanmc *vlanmc)
+{
+	int ret;
+
+	ret = rtl8365mb_vlan_port_get_pvid_idx(priv, port, vlanmc_idx);
+	if (ret)
+		return ret;
+
+	memset(vlanmc, 0, sizeof(*vlanmc));
+
+	if (!*vlanmc_idx)
+		return 0;
+
+	ret = rtl8365mb_vlan_mc_read(priv, *vlanmc_idx, vlanmc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_port_get_pvid - Retrieve the port PVID
+ * @priv: realtek switch private structure
+ * @port: port index
+ * @pvid: pointer to store the retrieved VLAN ID
+ *
+ * Returns the port PVID if defined or 0 if not.
+ *
+ * Context: Can sleep. Takes and releases &priv->map_lock.
+ * Returns 0 on success or a negative error code on failure.
+ */
+int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
+{
+	struct rtl8365mb_vlanmc vlanmc;
+	u8 vlanmc_idx;
+	int ret;
+
+	ret = rtl8365mb_vlan_mc_get_pvid(priv, port, &vlanmc_idx, &vlanmc);
+	if (ret)
+		return ret;
+
+	*pvid = vlanmc.evid;
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_port_get_framefilter() - Get the ingress frame filtering mode
+ * for a port
+ * @priv: realtek switch private structure
+ * @port: port index
+ * @frame_type: pointer to store the retrieved ingress frame filter type
+ *
+ * Context: Can sleep. Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int
+rtl8365mb_vlan_port_get_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress *frame_type)
+{
+	u32 val;
+	int ret;
+
+	/* Even if ACCEPT_FRAME_TYPE_ANY, the switch will still check if the
+	 * port is a member of vlan PVID
+	 */
+
+	ret = regmap_read(priv->map, RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port),
+			  &val);
+	if (ret)
+		return ret;
+
+	*frame_type = field_get(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port),
+				val);
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_port_set_framefilter() - Set the ingress frame filtering mode
+ * for a port
+ * @priv: realtek switch private structure
+ * @port: port index
+ * @frame_type: the ingress frame filter type to configure
+ *
+ * Context: Can sleep. Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int
+rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress frame_type)
+{
+	u32 val;
+
+	/* Even if ACCEPT_FRAME_TYPE_ANY, the switch will still check if the
+	 * port is a member of vlan PVID
+	 */
+	val = frame_type << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port);
+
+	return regmap_update_bits(priv->map,
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port),
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port),
+				  val);
+}
+
+/**
+ * rtl8365mb_vlan_pvid_port_add() - Configure a port's PVID and associated
+ * VLANMC entry
+ * @ds: dsa switch instance
+ * @port: port index
+ * @vlan: switchdev VLAN object containing the PVID target VID and flags
+ * @extack: netlink extended ACK for error reporting
+ *
+ * Allocates or reuses a hardware VLANMC entry to map the given port to its new
+ * PVID. Gracefully unwinds and restores previous configuration if a hardware
+ * write operation fails during execution.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlanmc prev_vlanmc = {0};
+	u8 _unused_first_free_idx;
+	u8 prev_vlanmc_idx;
+	u8 vlanmc_idx;
+	int ret;
+
+	lockdep_assert_held(&priv->vlan_lock);
+
+	if (!pvid)
+		return 0;
+
+	/* Read the old PVID exclusively to undo in case of error */
+	ret = rtl8365mb_vlan_mc_get_pvid(priv, port, &prev_vlanmc_idx,
+					 &prev_vlanmc);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read current VLAN MC");
+		return ret;
+	}
+
+	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
+						  &prev_accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to get current framefilter");
+		return ret;
+	}
+
+	/* Find or allocate a new vlan MC and add port to members,
+	 * although members are not checked by the HW in vlan MC.
+	 */
+	ret = rtl8365mb_vlan_mc_port_set(ds, port, vlan->vid, pvid,
+					 extack, true);
+	if (ret)
+		return ret;
+
+	/* look for existing entry */
+	ret = rtl8365mb_vlan_mc_find(priv, vlan->vid, &vlanmc_idx,
+				     &_unused_first_free_idx);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to find a VLAN MC table index");
+		goto undo_vlan_mc_port_set;
+	}
+
+	if (!vlanmc_idx) {
+		RTL_VLAN_ERR("VLAN should already exist in VLAN MC");
+		ret = -ENOENT;
+		goto undo_vlan_mc_port_set;
+	}
+
+	ret = rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port PVID");
+		goto undo_vlan_mc_port_set;
+	}
+
+	/* Changing accept frame is what enables PVID (if not enabled before) */
+	accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
+	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port frame filter");
+		goto undo_vlan_port_set_pvid;
+	}
+
+	/* A VLAN can be added with PVID without removing from the old
+	 * PVID VLAN. Clear PVID from the old VLAN MC (if needed).
+	 */
+	if (prev_vlanmc_idx && (prev_vlanmc.evid != vlan->vid)) {
+		ret = rtl8365mb_vlan_mc_port_set(ds, port, prev_vlanmc.evid,
+						 false, NULL, false);
+		if (ret) {
+			RTL_VLAN_ERR("Failed to clear old VLAN MC");
+			goto undo_set_framefilter;
+		}
+	}
+
+	return 0;
+
+undo_set_framefilter:
+	(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
+						  prev_accepted_frame);
+
+undo_vlan_port_set_pvid:
+	(void)rtl8365mb_vlan_port_set_pvid(priv, port, prev_vlanmc_idx);
+
+undo_vlan_mc_port_set:
+	(void)rtl8365mb_vlan_mc_port_set(ds, port, vlan->vid,
+					 false, NULL, false);
+
+	return ret;
+}
+
+/**
+ * rtl8365mb_vlan_pvid_port_del() - Remove a port's PVID configuration
+ * @ds: dsa switch instance
+ * @port: port index
+ * @vlan: switchdev VLAN object containing the VID to match
+ *
+ * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
+ * the associated VLANMC entry if no other ports are referencing it.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Takes and releases &priv->map_lock.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
+	struct netlink_ext_ack *extack = NULL;
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u8 vlanmc_idx;
+	int ret;
+
+	lockdep_assert_held(&priv->vlan_lock);
+
+	ret = rtl8365mb_vlan_mc_get_pvid(priv, port, &vlanmc_idx,
+					 &vlanmc);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read current VLAN MC");
+		return ret;
+	}
+
+	/* Port is not using PVID. Nothing to remove. */
+	if (!vlanmc_idx)
+		return 0;
+
+	/* We are leaving a non PVID vlan, Nothing to remove. */
+	if (vlanmc.evid != vlan->vid)
+		return 0;
+
+	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
+						  &prev_accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to get current framefilter");
+		return ret;
+	}
+
+	/* Changing accept frame is what really removes PVID. But only do
+	 * that if we are filtering vlan
+	 */
+	if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+		accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
+
+		ret = rtl8365mb_vlan_port_set_framefilter(priv, port,
+							  accepted_frame);
+		if (ret) {
+			RTL_VLAN_ERR("Failed to set port frame filter");
+			return ret;
+		}
+	} else {
+		/* skip undo_set_framefilter */
+		accepted_frame = prev_accepted_frame;
+	}
+
+	ret = rtl8365mb_vlan_port_set_pvid(priv, port, 0);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port PVID to 0");
+		goto undo_set_framefilter;
+	}
+
+	/* Clears the VLAN MC membership and maybe VLAN MC entry if empty */
+	ret = rtl8365mb_vlan_mc_port_set(ds, port, vlanmc.evid,
+					 false, NULL, false);
+	if (ret)
+		goto undo_port_set_pvid;
+
+	return 0;
+
+undo_port_set_pvid:
+	(void)rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
+
+undo_set_framefilter:
+	if (prev_accepted_frame != accepted_frame)
+		(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
+							  prev_accepted_frame);
+
+	return ret;
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
new file mode 100644
index 000000000000..131c5ffb9e44
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* VLAN configuration interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ *
+ */
+
+#ifndef _REALTEK_RTL8365MB_VLAN_H
+#define _REALTEK_RTL8365MB_VLAN_H
+
+#include <linux/types.h>
+
+#include "realtek.h"
+
+enum rtl8365mb_frame_ingress {
+	RTL8365MB_FRAME_TYPE_ANY_FRAME = 0,
+	RTL8365MB_FRAME_TYPE_TAGGED_ONLY,
+	RTL8365MB_FRAME_TYPE_UNTAGGED_ONLY,
+};
+
+int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port,
+				 u16 *pvid);
+int
+rtl8365mb_vlan_port_get_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress *frame_type);
+int
+rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress frame_type);
+int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack);
+int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan);
+int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack);
+int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan);
+#endif /* _REALTEK_RTL8365MB_VLAN_H */
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 2b9bd4462714..93bc47dfe7f7 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -155,6 +155,7 @@ rtl83xx_probe(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&priv->map_lock);
+	mutex_init(&priv->vlan_lock);
 
 	rc.lock_arg = priv;
 	priv->map = devm_regmap_init(dev, NULL, priv, &rc);

-- 
2.54.0


