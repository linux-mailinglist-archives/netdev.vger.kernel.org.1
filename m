Return-Path: <netdev+bounces-288565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMk0KMfoB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7EB55A0C9
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B73D13007885
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B5266581;
	Sat, 16 May 2026 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7l99Ugm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F839292B44
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903237; cv=none; b=sQ4yeLNMED3DPYWiKD3+A5Dl5YVFMqExo74RKUJpDwdHi8LYhXYTi8ADq35DckaSPbgvCvERaiXBIDE3VSEh2N4W8wx2jfHJh7wt6nuRxlCfTs6+1ouy6yXPzH4gnjPXeTElKRP9iesDAjtkkkF7WmGId+Yo+DT7pZe4usnTTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903237; c=relaxed/simple;
	bh=ftm9A2pazaly3ujJmyyLWE2kx9nI+iOOSiT6EuIzSXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji6dTqryW5knBdbuT9tMCJaRoD0d2CfkCj/eVyBjNTgRu6hM70ZtYVlfP4XdscdQN9Xj8Ft5vrHRdDfGVs5TTRKv3PuAiL6iHqKRa4OkyWuNu+ZRmYia4q4SFbZDXbzZkyYOZWzuMwpA6OzoxuS9ntlc7TcsIZGF/wx93VeI60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7l99Ugm; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8c921396e37so8015776d6.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903235; x=1779508035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+EAZsJ8T3e8lYxhL4SWBYpxdBnvWEKX6PuId/d7ZxY=;
        b=s7l99UgmRyp6Lx1D5RJq3CyaCzpH5yfw8Qi69LOSSH37lJeYiNbbEAAkyNu+13/D0j
         7TawNkrSU5CjEfkhpKg/Gp0szVF993evJpuyyDRx1lRedarYXZIshte4FJokgqoj37nB
         RAHafF7Vs6gaaTA+z+ThyZoY0Gda8qqYvejrReZLY8Ur3WXsnpQwWDBwVigFVYfMDSp/
         75vvqexnMwMmMs3Uqjn7EA0z6K/62Ra+dOfJs9UnrN0QoSG9+58EI2TVZn7p6iZXP6FK
         Fx5FrS8X5d/cQkIlM5GBerWQQVJ0kIea8nwbzuJqCKO3V0Tz/KEPrZQD0HClptpsBpgd
         REUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903235; x=1779508035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+EAZsJ8T3e8lYxhL4SWBYpxdBnvWEKX6PuId/d7ZxY=;
        b=KzPmpvBH4KOd7qVxuWgHq7Cfa8qBbtyPAoURw3Tt4Sbh54EGt9yb8UQhvPLDIHjzUI
         HXVADYt+mRxPFHEv4Fe4WrbK3/t4NcRWUQOeFUXj9b+0V8B7GG6pnzbnVF19Dy8qvdwl
         OnmvjDa9nNX2d7afnon8qovAapS3iz4Vg/z5TCc5JfpDS8qraqJpsO1UweFrcYJLmEx1
         DMNENwmLeXjWOaKKJqb8dG2ABaC/COen3pc3xbMx/kVIrksPlN8sGhkkdALCt6mIbCNn
         q0wFBdxVWMRxcTTqDeg7jFH2iTZIsJy2jGNcVLefWVRCX+BfyVEnKGwTedBEacEsoDLB
         XGOQ==
X-Gm-Message-State: AOJu0YyLEais0axQDlcB0yZQ0ZUkNiDlTlHwCL5GZ9ZJGv2qAMVjIsZe
	qyyXBfX56OJmjdOP7yLxRI/1Q1Hb00ai7JFC/T+uWK+ZbWW9njgtogNd
X-Gm-Gg: Acq92OFFYajA1ztois51e5WEWg1fy9Q3gZWR2d/oXEllLcPtwVGtwzI+LGHwtFevXAD
	CX2jOBdjVDUcZaGHr7w+16flZn3Ez6l2C7CflU0/UCQgQwMyk2OYFT1DW3e4zOzHbHf957xv9y5
	qCRNus4Dkysa9GUtNCd58dPsOzjLwwcNkqwpLM+ABaFTcl1sQFWUSh3iCmUeLQtB77UT/LK6rx7
	KA4OgMT0uZQCoJBGk5g7P1vrK5Q4VDqELyC2eaB9bJe7SegQI8KTYPw5aza1MRFsy3Kc7UFuwVY
	i6sFBhl9Le67kJQgMRkayKfSdGfnTarZyJltm50+uayxrYP+BtjEsLNEuKyl4ZXtAj0w/btHAeF
	PkMlUB5v6wJtmdTQ23xJYjDaPz99/efa6OuFNexQkPw50QvJijduY0GNkqJ9TllcwqxbWb+R+tm
	aV3L1rQMZ+oRCjRisdpuadcLkD0UosDHGEMlji0Z5hmuOdH7MW7g==
X-Received: by 2002:a05:6214:55c6:b0:8ca:e41:ab8 with SMTP id 6a1803df08f44-8ca0f63466bmr100980096d6.7.1778903235234;
        Fri, 15 May 2026 20:47:15 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm70874546d6.16.2026.05.15.20.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:14 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 May 2026 00:46:18 -0300
Subject: [net-next PATCH v4 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-realtek_forward-v4-2-8b6d6a1eefdc@gmail.com>
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
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4A7EB55A0C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use dsa_switch_for_each_*() whenever possible.

For port setup(), a new blocking setup phase was added for all ports,
including unused ones, before the user and CPU port setup.

CPU isolation includes all user ports as traffic was being blocked in
some scenarios (suggested by Abdulkader Alrezej).

The driver bails out if a DSA port is detected as the driver was not
tested in a cascading setup.

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 141 +++++++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 9cb0f0b9beb6..d1de9158870c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1540,18 +1540,15 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
 	struct dsa_switch *ds = &priv->ds;
-	int i;
+	struct dsa_port *dp;
 
 	/* Per-chip global mutex to protect MIB counter access, since doing
 	 * so requires accessing a series of registers in a particular order.
 	 */
 	mutex_init(&mb->mib_lock);
 
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
-
-		if (dsa_is_unused_port(ds, i))
-			continue;
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
 		/* Per-port spinlock to protect the stats64 data */
 		spin_lock_init(&p->stats_lock);
@@ -1567,13 +1564,10 @@ static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
 	struct dsa_switch *ds = &priv->ds;
-	int i;
-
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
+	struct dsa_port *dp;
 
-		if (dsa_is_unused_port(ds, i))
-			continue;
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
 		cancel_delayed_work_sync(&p->mib_work);
 	}
@@ -1632,6 +1626,9 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	for_each_set_bit(line, &line_changes, priv->num_ports) {
 		int child_irq = irq_find_mapping(priv->irqdomain, line);
 
+		if (!child_irq)
+			continue;
+
 		handle_nested_irq(child_irq);
 	}
 
@@ -1695,13 +1692,14 @@ static int rtl8365mb_irq_disable(struct realtek_priv *priv)
 static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
 	struct device_node *intc;
+	struct dsa_port *dp;
 	u32 irq_trig;
 	int virq;
 	int irq;
 	u32 val;
 	int ret;
-	int i;
 
 	intc = of_get_child_by_name(priv->dev->of_node, "interrupt-controller");
 	if (!intc) {
@@ -1727,8 +1725,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_create_mapping(priv->irqdomain, i);
+	dsa_switch_for_each_available_port(dp, ds) {
+		virq = irq_create_mapping(priv->irqdomain, dp->index);
 		if (!virq) {
 			dev_err(priv->dev,
 				"failed to create irq domain mapping\n");
@@ -1798,9 +1796,11 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	mb->irq = 0;
 
 out_remove_irqdomain:
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_find_mapping(priv->irqdomain, i);
-		irq_dispose_mapping(virq);
+	dsa_switch_for_each_available_port(dp, ds) {
+		virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+		if (virq)
+			irq_dispose_mapping(virq);
 	}
 
 	irq_domain_remove(priv->irqdomain);
@@ -1815,8 +1815,9 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
 	int virq;
-	int i;
 
 	if (mb->irq) {
 		free_irq(mb->irq, priv);
@@ -1824,9 +1825,11 @@ static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 	}
 
 	if (priv->irqdomain) {
-		for (i = 0; i < priv->num_ports; i++) {
-			virq = irq_find_mapping(priv->irqdomain, i);
-			irq_dispose_mapping(virq);
+		dsa_switch_for_each_available_port(dp, ds) {
+			virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+			if (virq)
+				irq_dispose_mapping(virq);
 		}
 
 		irq_domain_remove(priv->irqdomain);
@@ -1944,10 +1947,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb_cpu *cpu;
-	struct dsa_port *cpu_dp;
+	u32 downports_mask = 0;
+	u32 upports_mask = 0;
 	struct rtl8365mb *mb;
+	struct dsa_port *dp;
 	int ret;
-	int i;
 
 	mb = priv->chip_data;
 	cpu = &mb->cpu;
@@ -1974,46 +1978,83 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		cpu->mask |= BIT(cpu_dp->index);
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
-		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
-			cpu->trap_port = cpu_dp->index;
-	}
-	cpu->enable = cpu->mask > 0;
-	ret = rtl8365mb_cpu_config(priv);
-	if (ret)
-		goto out_teardown_irq;
-
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
+		if (dsa_port_is_dsa(dp)) {
+			dev_err(ds->dev, "Cascading (DSA links) not supported");
+			return -EOPNOTSUPP;
+		}
 
-		if (dsa_is_unused_port(ds, i))
-			continue;
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
-		/* Forward only to the CPU */
-		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
+		/* Start with all port completely isolated */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
 		if (ret)
 			goto out_teardown_irq;
 
 		/* Disable learning */
-		ret = rtl8365mb_port_set_learning(priv, i, false);
+		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
 		if (ret)
 			goto out_teardown_irq;
 
-		/* Set the initial STP state of all ports to DISABLED, otherwise
-		 * ports will still forward frames to the CPU despite being
-		 * administratively down by default.
-		 */
-		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
-
 		/* Set up per-port private data */
 		p->priv = priv;
-		p->index = i;
+		p->index = dp->index;
+
+		/* Collect CPU ports. If we support cascade switches, it should
+		 * also include the upstream DSA ports.
+		 */
+		if (!dsa_port_is_cpu(dp))
+			continue;
+
+		upports_mask |= BIT(dp->index);
+	}
+
+	/* Configure user ports */
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		/* Forward only to the CPU */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, upports_mask);
+		if (ret)
+			goto out_teardown_irq;
+
+		/* If we support cascade switches, it should also include the
+		 * downstream DSA ports.
+		 */
+		downports_mask |= BIT(dp->index);
 	}
 
+	/* Configure CPU tagging */
+	/* If we support cascade switches, it should also include the upstream
+	 * DSA ports.
+	 */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		/* Use the first CPU port as trap_port */
+		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
+			cpu->trap_port = dp->index;
+
+		/* Forward to all user ports */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index,
+						   downports_mask);
+		if (ret)
+			goto out_teardown_irq;
+	}
+
+	cpu->mask = upports_mask;
+	cpu->enable = cpu->mask > 0;
+
+	ret = rtl8365mb_cpu_config(priv);
+	if (ret)
+		goto out_teardown_irq;
+
 	ret = rtl8365mb_port_change_mtu(ds, cpu->trap_port, ETH_DATA_LEN);
 	if (ret)
 		goto out_teardown_irq;

-- 
2.54.0


