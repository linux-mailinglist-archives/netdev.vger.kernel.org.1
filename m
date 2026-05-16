Return-Path: <netdev+bounces-288568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDNlO93oB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E3855A0D7
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B13F7300753D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2B2BCF4C;
	Sat, 16 May 2026 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Hi8/1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250B17B506
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903259; cv=none; b=rt4bI1bJMQbKB3GzZH1nnR+lkI65WjlUVZIbclEbiL1LPhJRidodHU6fSncWmsJff9L8Bc3Gb+kloj51pvgES2qhhjr9BnhB4Xv++Pi5iXhsUm6hZ60tn00V38trL+mHCZtDgHWdksloocVKOT++zOYPftE5VFqxcWFwjsTt7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903259; c=relaxed/simple;
	bh=d3e6yoM6MbyWADLEOBeC2nUM5NL9BWHRb+xSPbkpruU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXYSDMFMCOEzzb09/y8jwDfxXZ/vKotaDvuwKja7gHe6vAe0gK8efRqeF2V7KGEzwp831NqRMm9XjLyBYCaKh/l6HUdDdN2ZMzle/KBNsn8mV8AybjPyErQX0/PajAv8FztY80a+gA0ePuvt19iiOHUVjxu5QBYCKCQd9hYpRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Hi8/1n; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90eb7a63a30so36636185a.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903256; x=1779508056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVDbaW7fpz3Plo272XK0gem4BI3EHahy9a0Dqz3Jv1k=;
        b=O+Hi8/1nxP6aPtY6h5DF0wkEozwgPG5RtES7vpAWu3qtSD9dB7tam6K5XoodQ+aVts
         QZtmJPRG4oM2K8FWz7D4kwizerJkLHCHpVWeaEi9cYRzA1kAfA7ETIzwCUwNlgSM4aKG
         7W+bsPct968DNQCIFB0CWFYmh3c8jJsyFTcxt1o9JkBwcPosVuLAZwPjEYnoxMoRql7x
         dAsd8jOmmv2JY5ZLiZBk+Weyuq2smd5OjHrukLKIwllHpQSx1NXfEJQdWljRLVo2/fXs
         0u2Z4QLo8hb+YIjwo17NgU3pbYE1ctLFE4kpkiKoJc0InzJ1PrRq/05Pv055NEOmaI+R
         g5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903256; x=1779508056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVDbaW7fpz3Plo272XK0gem4BI3EHahy9a0Dqz3Jv1k=;
        b=hX0rE+T1Nx3Ba88rhAvJUzWhF2PqaHvlJYJWRzGDUAnRIDOQoM/DvC8Wgig0uOvxwW
         Pnw3tRIbnSeAgg7a1I2jeN53J/UhG1gKUW+nUGHIvafwuuaKsRmU1TnIwtzREjccDSXS
         0mf51cd9+zvJygZfRvTSSVey59Uja9Oh1281iwt30go0h1Z1Id+2khVRTK+Qfx/Si9zM
         6EP4lqb70WBqyh3ndpwsBx6o2CPLHV2mCUrt8fJqjGcfYQIfbto8fgp2/Fo31VnmMyFP
         o0XvcdtxrcHjOndNtKvEQiwgQimY0PfF7A3WiTJtWiUM1EeHWxFKVXBjX5mZ0TyXKeK/
         pIVg==
X-Gm-Message-State: AOJu0YxfZliQcyH4PyIm0xEExq7+/nWQC6ckV9prJ76WT6rdl4Ds16o1
	Kln0I64O1cMz/A3VUz9rzYSS/05BMCEAMx9Zstnr0tCEeb2aMrazK1rO
X-Gm-Gg: Acq92OGyCEaYXU7Gm8aQt19svFrwd78o8SA0sNnEaQRIpJGT310wW9L34wyst/1rkKg
	X5COY4KNQh6GHmk7cGS+sewJC7vc+WhSDMJWUAZ8rpIlbcIH2sY8paJbxNWcyCKt9Z2NJY0QQTV
	OEWsh3oDAVrxZWAxdgl7bWnHSP0aIBSiAh78qgQzT9fkWQQGVb0PxU9hANY39GAwBKIw9lNVJN9
	S/p3Rvy6TIs1WQ2Rb5FArfBFVPxErNqdzgwceCD9d+Nys4G5lCQdfSp3jDlIsLvPb6If0qkQiXA
	jImB6V8ro8luGzqELycntw7iTWIB8IC2Djq5tWrtB8FYmL4BAT4lLN89fHmbbGOzUPyoFusTdbp
	JiCmvk6eXI1m8tUflz0shDsHJ9xODeSsKOk+EOMiL+7fLuZEEFahErglvP5/+5TAWySKrjQYp5i
	WNJ5csWPm/lmLyViHoO21eYGSnSZzAH/20qrMzPFs=
X-Received: by 2002:a05:620a:1792:b0:90d:e802:79e5 with SMTP id af79cd13be357-911d02ad42bmr1121951585a.57.1778903255437;
        Fri, 15 May 2026 20:47:35 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm70874546d6.16.2026.05.15.20.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:34 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 May 2026 00:46:21 -0300
Subject: [net-next PATCH v4 5/8] net: dsa: realtek: rtl8365mb: add VLAN
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-realtek_forward-v4-5-8b6d6a1eefdc@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
In-Reply-To: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 78E3855A0D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

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
in the VLAN4K table. However, when a corresponding VLAN entry also exists
in VLANMC, this driver keeps both membership configurations in sync.

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
Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 261 ++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 813 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  25 +
 4 files changed, 1100 insertions(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 99654c4c5a3d..b7fc4e852fd8 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -18,3 +18,4 @@ endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
+		  rtl8365mb_vlan.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index d1de9158870c..90c3001d31f2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_vlan.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -292,6 +293,67 @@
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
 /* MIB counter value registers */
 #define RTL8365MB_MIB_COUNTER_BASE	0x1000
 #define RTL8365MB_MIB_COUNTER_REG(_x)	(RTL8365MB_MIB_COUNTER_BASE + (_x))
@@ -1196,6 +1258,195 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
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
+	enum rtl8365mb_vlan_egress_mode mode;
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int ret;
+
+	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
+		vlan_filtering ? "enable" : "disable");
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
+		goto undo_transparent;
+
+	return ret;
+
+undo_transparent:
+	/* It will also try to undo the failed port if the error happened
+	 * inside the transparent VLAN loop but that might be inocuous.
+	 */
+	dsa_switch_for_each_port_continue_reverse(dp, ds) {
+		if (dsa_port_is_unused((dp)))
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
+	/* add port to vlan4k. It knows nothing about PVID */
+	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
+	if (ret)
+		return ret;
+
+	/* Set PVID if needed */
+	if (pvid) {
+		ret = rtl8365mb_vlan_pvid_port_add(ds, port, vlan, extack);
+		if (ret)
+			goto undo_vlan_4k;
+	}
+
+	return 0;
+
+undo_vlan_4k:
+	(void)rtl8365mb_vlan_4k_port_del(ds, port, vlan);
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
+	ret1 = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
+	ret2 = rtl8365mb_vlan_4k_port_del(ds, port, vlan);
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
@@ -2059,6 +2310,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2169,6 +2427,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
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
index 000000000000..82add166ff91
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -0,0 +1,813 @@
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
+enum rtl8365mb_frame_ingress {
+	RTL8365MB_FRAME_TYPE_ANY_FRAME = 0,
+	RTL8365MB_FRAME_TYPE_TAGGED_ONLY,
+	RTL8365MB_FRAME_TYPE_UNTAGGED_ONLY,
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
+int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack)
+{
+	return rtl8365mb_vlan_4k_port_set(ds, port, vlan, extack, true);
+}
+
+int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan)
+{
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
+static int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv,
+					int port, u8 *vlanmc_idx)
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
+ * rtl8365mb_vlan_mc_pvid_members() - Get a bitmap of vlan PVID members
+ *
+ * @ds: DSA switch
+ * @vlanmc_idx: the index of a VLAN in VLAN MC table
+ * @members: the returned bitmap of members that have PVID status
+ *
+ * This function iterates over DSA ports and creates a bitmap representation of
+ * those ports that have PVID pointing to this VLAN (identified by its table
+ * index and not VID). If you need to get the table index from VID, see
+ * rtl8365mb_vlan_mc_find()
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ **/
+static int rtl8365mb_vlan_mc_pvid_members(struct dsa_switch *ds,
+					  u8 vlanmc_idx, u16 *members)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u8 _vlanmc_idx;
+	int ret;
+
+	*members = 0;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		ret = rtl8365mb_vlan_port_get_pvid(priv, dp->index,
+						   &_vlanmc_idx);
+		if (ret)
+			return ret;
+
+		if (_vlanmc_idx == vlanmc_idx)
+			*members |= BIT(dp->index);
+	}
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_mc_port_set() - include or exclude a port from vlanMC
+ * @ds: dsa switch
+ * @port: the port number
+ * @vlan: the vlan to include/exclude @port
+ * @extack: optional extack to return errors
+ * @include: whether to include or exclude @port
+ *
+ * This function is used to include/exclude ports to the vlanMC table.
+ *
+ * VlanMC stands for VLAN membership config and it is used exclusively for
+ * PVID. If @vlan members are not using PVID, this function will either
+ * remove or not create a new vlanMC entry.
+ *
+ * vlanMC members are kept in sync with vlan4k, although the switch only
+ * checks membership in vlan4k table.
+ *
+ * Port PVID and accepted frame type are updated as well.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ */
+static
+int rtl8365mb_vlan_mc_port_set(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack,
+			       bool include)
+{
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlan4k vlan4k = {0};
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u16 pvid_members = 0;
+	u8 first_unused = 0;
+	u8 vlanmc_idx = 0;
+	int ret;
+
+	dev_dbg(priv->dev, "%s VLAN %d MC on port %d\n",
+		include ? "add" : "del",
+		vlan->vid, port);
+
+	if (vlan->vid > RTL8365MB_MAX_MC_VID) {
+		RTL_VLAN_ERR("VLAN ID greater than "
+			     __stringify(RTL8365MB_MAX_MC_VID));
+		return -EINVAL;
+	}
+
+	/* look for existing entry or an empty slot */
+	ret = rtl8365mb_vlan_mc_find(priv, vlan->vid, &vlanmc_idx,
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
+				vlan->vid, port);
+			return 0;
+		}
+
+		if (!first_unused) {
+			RTL_VLAN_ERR("All VLAN MC entries ("
+				     __stringify(RTL8365MB_VLAN_MCMAX + 1)
+				     ") are in use.");
+			return -E2BIG;
+		}
+
+		/* Retrieve vlan4k members as we might have deferred VlanMC
+		 * before.
+		 */
+		if (vlan->vid <= RTL8365MB_MAX_4K_VID) {
+			ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
+			if (ret) {
+				RTL_VLAN_ERR("Failed to read VLAN 4k table");
+				return ret;
+			}
+		}
+
+		vlanmc_idx = first_unused;
+		vlanmc.evid = vlan->vid;
+
+		/* for new vlan_mc, sync current vlan4k members,
+		 * although only vlan4k members matter.
+		 */
+		vlanmc.member |= vlan4k.member;
+	} else /* excluding and VLANMC not found */ {
+		return 0;
+	}
+
+	ret = rtl8365mb_vlan_mc_pvid_members(ds, vlanmc_idx,
+					     &pvid_members);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLANMC PVID members");
+		return ret;
+	}
+	dev_dbg(priv->dev,
+		"VLAN %d (idx: %d) PVID curr members: %08x\n",
+		vlan->vid, vlanmc_idx, pvid_members);
+
+	/* here we either have an existing VLANMC (with PVID members) or the
+	 * added port is using this VLAN as PVID
+	 */
+	if (include) {
+		vlanmc.member |= BIT(port);
+		if (pvid)
+			pvid_members |= BIT(port);
+	} else {
+		vlanmc.member &= ~BIT(port);
+		pvid_members &= ~BIT(port);
+	}
+
+	/* just like we don't need to create a VLAN_MC when there is no port
+	 * using it as PVID, we can erase it when there is no more port using
+	 * it as PVID.
+	 */
+	if (!pvid_members) {
+		dev_dbg(priv->dev,
+			"Clearing VlanMC index %d previously used by VID %d\n",
+			vlanmc_idx, vlan->vid);
+		ret = rtl8365mb_vlan_mc_erase(priv, vlanmc_idx);
+	} else {
+		dev_dbg(priv->dev,
+			"Saving VlanMC index %d with VID %d\n",
+			vlanmc_idx, vlan->vid);
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
+static int
+rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress accepted_frame)
+{
+	u32 val;
+
+	/* Even if ACCEPT_FRAME_TYPE_ANY, the switch will still check if the
+	 * port is a member of vlan PVID
+	 */
+	val = accepted_frame << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port);
+
+	return regmap_update_bits(priv->map,
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port),
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port),
+				  val);
+}
+
+int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	enum rtl8365mb_frame_ingress accepted_frame;
+	struct realtek_priv *priv = ds->priv;
+	u8 _unused_first_free_idx;
+	u8 vlanmc_idx;
+	int ret;
+
+	if (!pvid)
+		return 0;
+
+	/* A VLAN can be added with PVID without removing from the old
+	 * PVID VLAN. Clear PVID from any VLAN if needed.
+	 */
+	ret = rtl8365mb_vlan_pvid_port_del(ds, port, NULL);
+	if (ret)
+		return ret;
+
+	/* Find or allocate a new vlan MC and add port to members,
+	 * although members are not checked by the HW in vlan MC.
+	 */
+	ret = rtl8365mb_vlan_mc_port_set(ds, port, vlan, extack, true);
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
+		goto undo_vlan_pvid_port_set;
+	}
+
+	return 0;
+
+undo_vlan_pvid_port_set:
+	(void)rtl8365mb_vlan_port_set_pvid(priv, port, 0);
+
+undo_vlan_mc_port_set:
+	(void)rtl8365mb_vlan_mc_port_set(ds, port, vlan, NULL, false);
+	return ret;
+}
+
+int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	enum rtl8365mb_frame_ingress accepted_frame;
+	struct netlink_ext_ack *extack = NULL;
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u8 vlanmc_idx;
+	int ret;
+
+	ret = rtl8365mb_vlan_port_get_pvid(priv, port, &vlanmc_idx);
+	if (ret)
+		return ret;
+
+	/* Port is not using PVID. Nothing to remove. */
+	if (!vlanmc_idx)
+		return 0;
+
+	ret = rtl8365mb_vlan_mc_read(priv, vlanmc_idx, &vlanmc);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLAN MC table");
+		return ret;
+	}
+
+	/* We are leaving a non PVID vlan, Nothing to remove. */
+	if (vlan && (vlanmc.evid != vlan->vid))
+		return 0;
+
+	/* Changing accept frame is what really removes PVID */
+	accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
+	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port frame filter");
+		return ret;
+	}
+
+	ret = rtl8365mb_vlan_port_set_pvid(priv, port, 0);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port PVID to 0");
+		return ret;
+	}
+
+	/* Clears the VLAN MC membership and maybe VLAN MC entry if empty */
+	return rtl8365mb_vlan_mc_port_set(ds, port, vlan, NULL, false);
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
new file mode 100644
index 000000000000..ed63a0ec0d10
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -0,0 +1,25 @@
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

-- 
2.54.0


