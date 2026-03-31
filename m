Return-Path: <netdev+bounces-273780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGz0FcVSzGndSQYAu9opvQ
	(envelope-from <netdev+bounces-273780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E7372954
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 968FF30C58B0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A67466B5E;
	Tue, 31 Mar 2026 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Uwdjtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499D466B5F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998053; cv=none; b=jbUdAKxzI7KQNuzNtzknsBgURD6IX5hs46uUC9avihbWSnTFUjAU3qASpvi24wiBRMwKIXBvHKtkNrISUjP1OFDkDPs9pLRU1rS5TpH2kN4opb8btY9/lFwtNI65hJHsFPzfibO9hUFFIDUwT1LD5tvLR4VLFDDHCgRbFXT1e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998053; c=relaxed/simple;
	bh=tN8N0/Pfy9DaP4Rgpo4ivkxeOwe/BNzpIiyJBucuD/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZR9LGkZEKh2fpqxg0mziqQn+IgnIJmFZjOXI2SQZjrXburAUbpQZLPzUBa/laj4yGLaHrDEAW9b7744dd3te8Ob17O8EmNG946bZbgZiNUOaNO4znRFJcniQ7rQOYcuepUQEKh+qBPukt6iMEYMhwAonabOA3KmPOw5XFuNcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Uwdjtq; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56d357797acso4440214e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998051; x=1775602851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJDO8dNemPTipqN+44lXNB8MtKgUhVoWcKpvwCy+p/c=;
        b=C/UwdjtqPZwwBslKS0bh73EBRmsI1Up8v24uvDO3cRMWaqYl3RADT3SzeXfnjLv/3t
         LdIwnTsgF8/6jVfd4EVCaz5sqOdgjPZYwF4LV1fp6R7MHlQ/QaPckbyLH9SOzNHnjdsn
         U2/mYcwMKmYry73XwogR3p/66akfsaJfMlasHrqNkoHzO61sEcFeR5prdY+KjPO8gJff
         9MZMk8cAVkyGTrVfqAw1JCt8cfgouexpyPpTbKQP/TvC+MY0KLO9asCjCRsuoqNTkFBB
         F2p6gDlKfDGsqnFBRZ1myetyS/ThnQPMTdm+300YNy3Ex9Lb2xXzmR8l3RmXi/028q6V
         oWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998051; x=1775602851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJDO8dNemPTipqN+44lXNB8MtKgUhVoWcKpvwCy+p/c=;
        b=Z//y78pTr5PdriT07fIOH7f8Bjoz0gs1MFgyjS/1FtFgJhA7IOPNOEEA50iHi36qEz
         GBipmdJ/jg6vOwTt21QqUiDB5yRpxhFr+vI3Afoed8HsA+m/fLaHl/P2t0oOkCQdWXey
         xgH2/HsUbKoOXuo/9sl6UVyn3+zElcT15JfWno1QzjTVpFdAkU1BG8WkwxZ4AWP9QigO
         G9mk/I7qxpUngiNy1wu9IwkBJDGRSnyCwH3KIYMjJmzoUqbFTUKBT0aWQO/s2jZ/Ozdg
         RQZGTc900JAtskIAiqoZIRmcWdOAMkni1VxEZk1RICLLQej4ZvjlQdn89ya1DnPvNekb
         XUSA==
X-Gm-Message-State: AOJu0YzQcLkhHcrop9tnOdr/uqcmlJ09WtvdwgMsJcRKGaZRM0yz/3x5
	YFtlgSv1POayCDtJ/w/GgMUgl5vzMgVMEdimUDLSATNeLruboAShBodB
X-Gm-Gg: ATEYQzxOfRp1jld3FZv8dJX0hy3muPLPdKpyQH/NIxBtFUi5Nve4Az8LPi0Fw4Ucfyr
	8DcJ33gOFifHgqVUKuPdnJiIelMYuBqdVN035cY4TGvw6xKYfD4wf2mOaGzRaribrJ31H4gABkn
	9SvlyaiMY8CDdMR0P17IpX8Qb9r9j4QkMkI1Q3UKyNvmpU8b0jqBfgM+TvfmQEhgzzgQX442jNw
	4tWbNxuXhTgNZqpQwIqXi8z2iFoe+7wQXZ+vLIx6YSNQdNSi86M7oldRu6c6cwOLgZtRYnWJ2bH
	6KbNkIUPamroXRIWnE6SvNdlTQSUk/TwfF/SyOX6YCllpJZn319h4ezHBvbiXFi6w2q3AA4JmrN
	2l1vsn9CPWC7l/ufpuBILNcY/ujmTaMNN9ZQwtkwwBXvZrT84P1Ao5x6GB+b9ch2CxibomN1pxI
	6NbIPAjBk51muW+fh8QrxPKEpq+E661RQdh7Z31Q==
X-Received: by 2002:a05:6122:e170:b0:56b:579c:82e with SMTP id 71dfb90a1353d-56d8a843538mr792707e0c.5.1774998050757;
        Tue, 31 Mar 2026 16:00:50 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:49 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:07 -0300
Subject: [net-next PATCH 07/10] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-7-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C39E7372954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Implement hardware offloading of bridge functionality. This is achieved
by using the per-port isolation registers, which contain a forwarding
port mask. The switch will refuse to forward packets ingressed on a
given port to a port which is not in its forwarding mask.

For each bridge that is offloaded, use the DSA-provided bridge number
for the Extended Filtering ID (EFID). When using Independent VLAN
Learning (IVL), the forwarding database is keyed with the tuple
{VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
default EFID 0 for standalone ports where learning is disabled. This
fits nicely because DSA indexes the bridge number starting from 1.

Because of the limited number of EFIDs, we have to set the
max_num_bridges property of our switch to 7: we can't offload more than
that or we will fail to offer IVL as at least two bridges would end up
having to share an EFID.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 123 ++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index c604bd744d38..c955864f17b3 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -285,6 +285,15 @@
 		(RTL8365MB_PORT_ISOLATION_REG_BASE + (_physport))
 #define   RTL8365MB_PORT_ISOLATION_MASK			0x07FF
 
+/* Extended filter ID registers - used to key forwarding database with IVL */
+#define RTL8365MB_EFID_MASK			GENMASK(2, 0)
+#define RTL8365MB_PORT_EFID_REG_BASE		0x0A32
+#define RTL8365MB_PORT_EFID_REG(_p) \
+		(RTL8365MB_PORT_EFID_REG_BASE + ((_p) >> 2))
+#define   RTL8365MB_PORT_EFID_OFFSET(_p)	(((_p) & 0x3) << 2)
+#define   RTL8365MB_PORT_EFID_MASK(_p) \
+		(RTL8365MB_EFID_MASK << RTL8365MB_PORT_EFID_OFFSET(_p))
+
 /* MSTP port state registers - indexed by tree instance */
 #define RTL8365MB_MSTI_CTRL_BASE			0x0A00
 #define RTL8365MB_MSTI_CTRL_REG(_msti, _physport) \
@@ -1447,10 +1456,117 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
 }
 
+static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
+				   u32 efid)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_EFID_REG(port),
+				  RTL8365MB_PORT_EFID_MASK(port),
+				  efid << RTL8365MB_PORT_EFID_OFFSET(port));
+}
+
+/* Port isolation manipulation functions.
+ *
+ * The port isolation register controls the forwarding mask of a given
+ * port. The switch will not forward packets ingressed on a given port
+ * to ports which are not enabled in its forwarding mask.
+ *
+ * The port forwarding mask has the highest priority in forwarding
+ * decisions. The only exception to this rule is when the switch
+ * receives a packet on its CPU port with ALLOW=0. In that case the TX
+ * field of the CPU tag will override the forwarding port mask.
+ */
 static int rtl8365mb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port), mask);
+	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+			    mask);
+}
+
+static int rtl8365mb_port_add_isolation(struct realtek_priv *priv, int port,
+					u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, mask);
+}
+
+static int rtl8365mb_port_remove_isolation(struct realtek_priv *priv, int port,
+					   u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, 0);
+}
+
+static int rtl8365mb_port_bridge_join(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge,
+				      bool *tx_forward_offload,
+				      struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	u32 mask = 0;
+	int ret;
+	int i;
+
+	/* Add this port to the isolation group of every other port
+	 * offloading this bridge.
+	 */
+	for (i = 0; i < priv->num_ports; i++) {
+		/* Handle this port after */
+		if (i == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		ret = rtl8365mb_port_add_isolation(priv, i, BIT(port));
+		if (ret)
+			return ret;
+
+		mask |= BIT(i);
+	}
+
+	/* Add those ports to the isolation group of this port */
+	ret = rtl8365mb_port_add_isolation(priv, port, mask);
+	if (ret)
+		return ret;
+
+	/* Use the bridge number as the EFID for this port */
+	ret = rtl8365mb_port_set_efid(priv, port, bridge.num);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void rtl8365mb_port_bridge_leave(struct dsa_switch *ds, int port,
+					struct dsa_bridge bridge)
+{
+	struct realtek_priv *priv = ds->priv;
+	u32 mask = 0;
+	int i;
+
+	/* Remove this port from the isolation group of every other
+	 * port offloading this bridge.
+	 */
+	for (i = 0; i < priv->num_ports; i++) {
+		/* Handle this port after */
+		if (i == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		rtl8365mb_port_remove_isolation(priv, i, BIT(port));
+
+		mask |= BIT(i);
+	}
+
+	/* Remove those ports from the isolation group of this port */
+	rtl8365mb_port_remove_isolation(priv, port, mask);
+
+	/* Revert to the default EFID 0 for standalone mode */
+	rtl8365mb_port_set_efid(priv, port, 0);
 }
 
 static int rtl8365mb_mib_counter_read(struct realtek_priv *priv, int port,
@@ -2253,6 +2369,9 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
+	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+
 	/* vlan config will only be effective for ports with vlan filtering */
 	ds->configure_vlan_while_not_filtering = true;
 	/* Set up VLAN */
@@ -2376,6 +2495,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl8365mb_port_bridge_join,
+	.port_bridge_leave = rtl8365mb_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,

-- 
2.53.0


