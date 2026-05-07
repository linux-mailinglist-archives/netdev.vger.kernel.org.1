Return-Path: <netdev+bounces-285128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP9TGO3/+2njJgAAu9opvQ
	(envelope-from <netdev+bounces-285128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA34E2829
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E82C43007B04
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F702C0261;
	Thu,  7 May 2026 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHk6kbr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B621D3E4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122726; cv=none; b=AwMYcsUIshJzX4Yk0xqmWcUOjqBw7+pPviEXcmNIiRKWwG3v9H0KGhudEDwQ5cZmPaanvDaEf1LQV2pj27ulPdGXQy0ov5C3iYdA0yUD6qKEgj9w8JYHHaYg0eWSqFBnjAerTuYz1rfGfznGyB9K3R5aYct0jO7XLeuMbaYPq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122726; c=relaxed/simple;
	bh=dgpQsNkKADGV8s+92naskib3EVb3gkNYU31XNjWFc88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhze0aeqIabZa/TUZYxPQSDgfqeL/5sIxbZMy84UfXSjE7+JaIAwcri5qttQEFcnpsTNP4MCkpDaNUD2pOGPfXP72UNir+Jg4nmp9P1LpGOt+te6ok/8CzrzoIM7d3AYBGFdK/IkK4YcAQabseeVoFX9AMpVuT2dXS+pscxS/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHk6kbr2; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so685856c88.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122724; x=1778727524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4KoOpyEc9o6S/LrD6WQS+XI6ueOOXXtH3KeEmS5GBU=;
        b=fHk6kbr2thmQPQPiL5mkDmMo7LRhTs8aA2ODt30aFs6mEY8KT8j3l10BFnZ8BwXAsX
         Clzoiac3DTQAOuPh6jA0WC+1bBiXyxQ3E+PSGb/pQ+aOJOvcb95b/q+WqX/Wk2D8HEbt
         sI/xIO9wbKuFdKTgv1z6F3zQZyHUKeS3ZF125TCF9+HgoIwSPSKKZEKz6Ax3yL47hymE
         6Ju7zpNpjkybZTmD4NhL/lPAl9vmrGNOMaQ+RBecAC1CG6EeGaEw532/Qs7Cs1JNYjDl
         9rE6hpoZnlJfJkBiHEuf1hkaUxg/Ke9UgRiAYrkpjGMkQghHYf6jjdD/g+33TA7f9wYc
         aBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122724; x=1778727524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4KoOpyEc9o6S/LrD6WQS+XI6ueOOXXtH3KeEmS5GBU=;
        b=qRrsQ12PPIPi6x6zr8+in468byaohhmDbs4Q4B2phjddbOH8g4jGZlvUgDbI/raWm7
         v2m7pfTDwPHKGAJ/lKDcK7LLTUChs0wxdaa0UKMdjkjpv0KUKwXNllkuWsV0Vj9GtHJM
         HrHRes2xRuHx9OVQmoKglqfsp4Oi1yrdwcobEioR4rsN4/eo3jmc7+/NjFYVNaqBDZML
         UXRjAIGR5z8TiGA5BML5W+pKs8E6jdcB9WC/D9XLIF9UlgHWXyRmEE75yywEv+4pr5+N
         LbNfhxQq4Ene/nN17VFEvTNE+MNZqZgC6Pkcuy3x5Cprr218OejtmPW1D2TxFdRYJWVe
         jTJw==
X-Gm-Message-State: AOJu0YwJXjD1EfjhU4RSre7TyjHhcKUhF/69iJ7r49VWYfkEn0Is6CCE
	R6QJqqpp+VKB6APiht9J6CmtPa12/SrHhkM//7qz6XPFuKDVpqtT54Df
X-Gm-Gg: AeBDietvGX2I+ZHnNQOUjtekrpAAzl6NACz4AYAIwAYml4L5HvDqSmKiuvfdcgfD44P
	S/n8U1RA95wwMmqHKiqqxTckjV8YNL86IDnR9rSWBkNrfO5eKKjqqp4soJ0BLTJ/E7qqWXg8Z2j
	p3kuitWXoZKvx2MiS92gbVlL/KrW36HRTrThFwReLwKjkDd2oh44uuE+reqQiLtQV6XgG2Sj9uK
	MEApOOgrDCZ9of8grSMrC4EY32o5Mb85s26MVWN81JUIsnM/8sDtTs1aY5VUAzMycbnHNtOpTHD
	3PvqdPhE6mYWd+laL7OLJPQnErCv3/Qt9S/Ki4KOCCCDHImJML4GC94NX6lekh2teeb1QQpRR+d
	HYOoGiYrXI9lc0inSzdTNroLpfJYG+8XJuxdFGDPWaw1FgoyJZ2Jcj8YPWOyTBzp6GqanGXLMvp
	laY6N6gsXzrwhrTP2H/6U3AuhL3eiDVW6beraTGqpYGAIIr0brNQ==
X-Received: by 2002:a05:7022:f005:b0:12c:8b9:7208 with SMTP id a92af1059eb24-1318e811fffmr2977863c88.26.1778122724290;
        Wed, 06 May 2026 19:58:44 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm6561267c88.8.2026.05.06.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:58:43 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 06 May 2026 23:58:19 -0300
Subject: [net-next PATCH v3 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
In-Reply-To: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
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
X-Rspamd-Queue-Id: 51AA34E2829
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Use dsa_switch_for_each_*() whenever possible.

For port setup(), a new blocking setup phase was added for all ports,
including unused ones, before the user and CPU port setup.

CPU isolation now includes all user ports as traffic was being blocked in
some scenarios (suggested by Abdulkader Alrezej).

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 115 +++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index edbc16345d0d..7ddb82fcd026 100644
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
@@ -1943,11 +1946,11 @@ static int rtl8365mb_reset_chip(struct realtek_priv *priv)
 static int rtl8365mb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp, *dp;
 	struct rtl8365mb_cpu *cpu;
-	struct dsa_port *cpu_dp;
 	struct rtl8365mb *mb;
+	u32 userports_mask;
 	int ret;
-	int i;
 
 	mb = priv->chip_data;
 	cpu = &mb->cpu;
@@ -1974,44 +1977,58 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
+
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
+
+		/* Start with all port completely isolated */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
+		if (ret)
+			goto out_teardown_irq;
+
+		/* Disable learning */
+		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
+		if (ret)
+			goto out_teardown_irq;
+
+		/* Set up per-port private data */
+		p->priv = priv;
+		p->index = dp->index;
+	}
+
+	userports_mask = dsa_user_ports(ds);
+
 	/* Configure CPU tagging */
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		cpu->mask |= BIT(cpu_dp->index);
-
+		/* Use the first CPU port as trap_port */
 		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
 			cpu->trap_port = cpu_dp->index;
+
+		/* Forward to all user ports */
+		ret = rtl8365mb_port_set_isolation(priv, cpu_dp->index,
+						   userports_mask);
+		if (ret)
+			goto out_teardown_irq;
 	}
+
+	cpu->mask = dsa_cpu_ports(ds);
 	cpu->enable = cpu->mask > 0;
 	ret = rtl8365mb_cpu_config(priv);
 	if (ret)
 		goto out_teardown_irq;
 
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
-
-		if (dsa_is_unused_port(ds, i))
-			continue;
-
+	/* Configure user ports */
+	dsa_switch_for_each_user_port(dp, ds) {
 		/* Forward only to the CPU */
-		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, cpu->mask);
 		if (ret)
 			goto out_teardown_irq;
-
-		/* Disable learning */
-		ret = rtl8365mb_port_set_learning(priv, i, false);
-		if (ret)
-			goto out_teardown_irq;
-
-		/* Set the initial STP state of all ports to DISABLED, otherwise
-		 * ports will still forward frames to the CPU despite being
-		 * administratively down by default.
-		 */
-		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
-
-		/* Set up per-port private data */
-		p->priv = priv;
-		p->index = i;
 	}
 
 	ret = rtl8365mb_port_change_mtu(ds, cpu->trap_port, ETH_DATA_LEN);

-- 
2.54.0


