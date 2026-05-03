Return-Path: <netdev+bounces-283549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLt0EiXp9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C04B495C
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33563022A84
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E743A8725;
	Sun,  3 May 2026 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo7qBIqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480513A8722
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789128; cv=none; b=ruEBvuXAieNxxcLIEyMK6cJw64yNX64EBUIEcmu5JTuY4yfjAMM1VBQpyOUkGFi5K3WJIjwMW1c6CUL8BdhNhYyxGjhKCKjpBUy+HnrGysGrJXnC7mLSgHa4kTGs8IdTggU9umxnax/LJA4CpWZ3lXMMDYquWAzr2xawdGg3Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789128; c=relaxed/simple;
	bh=SVYnmDG6tmFF4goZMw+UGT/0vPySSrmeO8lWUvPD++M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKoXXAjDItpJETXFkEaeMDzM+DMQ14qEp923AN0xF25NzuyRzYeO/Km1PnYH/4Bl/RQdT15XBuM48TTl6LPtO/qIOxMroEE2KD54zr7/R1uMoDVG5VP5XX+gB79Qx1gUeb+XJFgZuojR4SPyjAxSc7kjmcr+JLUPogOkzqy+kSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo7qBIqj; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4156205eec.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777789126; x=1778393926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBjghMB+iBjACRZcchCHha4bUNqTlrawFRrEM22SWMo=;
        b=bo7qBIqj+TqOsASbECXUZG+DGLW2s/ami3cHbBQL79i/aY+Nfk16Kw28xE6Qp3Rxzp
         gJLX8OlHHBC3CISGmq8KlJS0xUxrr8+hNWjF7qDG9m469f5Idgpm10mt3VF/BL81axb3
         u2QFPjgkS9ZaT8iPro3WQSLzsUyf6UbBmPLiQJf0t27wVYiYYrw8NBr/XNv/z3IZdRmY
         MLlJY9fPMCWTKhLD871FbpgMgGshG2vb2GP4vrigC0I4CXffe/NNrg7fIUKpY3jU1sjX
         YOExEEKmaPgFw71EPsBDOouPh5qr8GmdvRekqK2MryXgedOgW/tyFny4xMG0jjRx8SRN
         +TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777789126; x=1778393926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBjghMB+iBjACRZcchCHha4bUNqTlrawFRrEM22SWMo=;
        b=lrtR1fEgNjMdazAtyyBlWueBm1FGhthk+K+W5aVcfJ6bvsKmeTzpT8jtF36x/sk/6R
         ujarrRo8hjPwbdil1jGKy67FjpPCeEcm6uveRoTDVt7C3O7BtB//ggJs/+s3TlfhSBsI
         jqXJzVauJd80YluVpzVUb1jQTTZCgppCL0IAZXOzbujgF7fmpt2v0qb8uTznAihy0127
         r+3eECmpMS38ymO9GWrPVdIauAYCu68jtk2480NlwmNkw3kPkuGlMHOcwGTrSvqeED/j
         tiA1W0up2uiibWCvk/8BDE0i0KOgc1iUv3jOG/oM+1IGOR2Zb6lHZyDXDD/L/XoKLnE9
         qmcQ==
X-Gm-Message-State: AOJu0YzDofVepH6MMCCGEtvLUnDCs5GAIJBr25u5OqVmCS41lpkoA9kj
	2uiyISXjrXf6Fk/6lDU3PabX+6gn1R7BBI10rPd4xaok+2meOSAnj/ce
X-Gm-Gg: AeBDieurGQNdITDMgknlXUAE2Zx8+Q6KMgxPD21ONTi1hhimPBU3iUGMZw6ylhs3ouF
	WeC7VPv207Z7BVxNHw7ktERXg/w7Qpv/SPnCPx59F/vnBCot5gyNUgho+5fKcNAdFjqZy/Wzq+V
	A61EmFvos2MsLkK9e1rMBZLqqdgVNz+XnKE9ClZ36gvQYDoYpt9tOvbfYqDm1R6DttOa6TIUMCB
	gtqKvhmwj4Cg1L6BiZc1kvV4hUKh0BaxPCsa4DjNwWHhoMSZWQT/b9UsEk3X92DDwD1ql0/CsWI
	MAblNNo1pL7u7vonrFquTp+jv/KFuAn8sk9q+EI/UACRTZXCWLDeu5jfAxq2v2XO6MH2OtfuQ5G
	/Zn9Q3P/Jv58xW9jAGnmES49K4QL9xeXJWNJeF8Smn/k9KSyx25VnDBeeuZy+WQKE5Wxfp6cg/U
	hqccm4PSLgSoPYvLRf9pPihHw7Gxx+dmkjXCOolcnKIfw1xxB+GQ==
X-Received: by 2002:a05:7300:7fa2:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-2efba7afa62mr1969574eec.34.1777789126313;
        Sat, 02 May 2026 23:18:46 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6811fsm11100344eec.29.2026.05.02.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 23:18:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 03 May 2026 03:18:22 -0300
Subject: [net-next PATCH v2 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-realtek_forward-v2-2-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
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
X-Rspamd-Queue-Id: B15C04B495C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283549-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use dsa_switch_for_each_*() whenever possible.

For port setup(), a new blocking setup phase was added for all ports,
including unused ones, before the user and CPU port setup.

CPU isolation now includes all user ports as traffic was being blocked in
some scenarios (suggested by Abdulkader Alrezej).

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
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
2.53.0


