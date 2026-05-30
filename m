Return-Path: <netdev+bounces-293331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLwBJqTBGmp88AgAu9opvQ
	(envelope-from <netdev+bounces-293331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:53:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBBE60C42E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860A63004D2C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D637AA83;
	Sat, 30 May 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et94EE7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADD36DA18
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138324; cv=none; b=nW1sYOASkC5CyDfU73evcCRAYuaRa0Rrj2XDwhO5iuIzk+7qTtOpk812J9QHgDVXbg0RVBso+chTywUdRqay0TMGVHEuD04M+n5uUgQQRQ2lygcgKt2FopubcwN8Lp8j1BvSYIDUc8/R2U9hQwCko9T3ZQtJf1Qd5T30n3atvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138324; c=relaxed/simple;
	bh=YE8yAci25sZxPGcV1uGvCIx8UtQWcWaIps8F73J1ZbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XccghauJnckehhqntqj/lZ3LXbGeVayVVWfsDaX46kU00f0ojK1l36tBs0n3wq3xJSSofHR1Gwcn+dzEr9q24kjg+KCWef8oHhovQbOZohTwmIDQ+U3Gj4h0xMk5V641yyiz0tC85GeXwHR/Jl51C+hH0E+ntOHWBenYtFlKxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et94EE7z; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dc18e2498bso37994137b3.3
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138322; x=1780743122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEznufSV9FiyZUofh6eH1tSidWmVGDG7OZcTFQAh4VI=;
        b=et94EE7zApNZ3vIkTw9NCqXiUJJBegZAiCwum1ReXq17Zbpy9QViVPU1uI4HwHXoWF
         LffcxAP1gfs0QrPdMp8EP1ZV32hJfWXWYleFUXlmgo0DpF/7Ov4jKtW7Osj5faE2nUmZ
         Dv5PSTKuwz8vXlk4qVVI7r4ujw2kOrJH1uGS1OSE+fyn+KKQp/2qLFGb4vKwtWGXv34K
         mvFYdp9ZUBR+3fXUeR/YXM9FEXZlO5MGYm8W0HXMuCYRIVlTYlN4W0qEIsVisLpl/IVt
         A7+gkzc6lMVeOnRScsJR7hbjZDAc9cJ34VG4l7qeacMEyJXE3UbA6iDIWSDTAdaNHcIS
         Gd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138322; x=1780743122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEznufSV9FiyZUofh6eH1tSidWmVGDG7OZcTFQAh4VI=;
        b=gkL4YkPgR3TDwtCSHY+YFyK3pQKwAIPZOv3+OfoaRaPCErKXNCYgZLZlSAmn0Stvy3
         ZeWug3v6Y0nU5v5G/+EuDyPN7zxpzRcyaenKzuZ/0nz/812HCeZ4oWD3nf1Ww78lPLI5
         rKPlP8DX1WPLkiSeYL+ZsIWH92wJtp9LAjPhrwcvDW8NniMjL8kUbxB7rdjT3CfWA2Mi
         4Gpj5ebULfrDDnGjg1vvXDvgpN/iFMzj9yy53C7CNkHV6wZITRoQUlfzFu06SJijWktn
         LQvKhpdummoN3T4f5LEKZbRDmHjEehzuDxeTS/bZVR+tpZplZwTnc6AB45cV3p8WZhpA
         Hh6A==
X-Gm-Message-State: AOJu0Yz2DAl4JOXnrGJYa+eSi3BnGDJev0WFj+dH27eNXreu+BwbagA+
	KDRwYvleCoUrApwwgbnp5lJFSSiPbj0/IxKB6s47UeJzeVzN2G375ied
X-Gm-Gg: Acq92OE4MeMBBwsjedBYPO0rCxcKYwZa4S4R23CmkSm+mczLeyec68UzmTQ5qDzzcGa
	nL3nt60vNhqkl3wPzd/nYfs2ADMpCPScEVVnT9W2SVe/8+NLAwW6zVU7+6p1AjfdYuKjXLPsZj7
	qYdvYN+Nu3RnyIFBgLSsA3OqrcNaNDOR0L9/5yHiuwztySShfgrNPtZm0pzBg9zH+L/TBEiVvKn
	o38diYoB8fR47y68BgPRVrXBD7l8ERfiZ6in0qom/C3TxpUrJilN9vfFgoBlk9Cp7t2NokF941R
	2Myj0XJy0QSUBPOYdKwl9GG04Rs7G0fUaT3NvUi4AZIyYqTTvxvvTXI0CgA1Byq/hUKaxAJs9Ce
	fH3lxUKmp7mUsx7B55hLw7pC3CNqeOwxl1M21L6YWrPKHWOFSOXu0a2HsvwDoi4U87qkzMWhOP0
	onoSaeFVM5GFXoqHLojt1V7TdU5uv/Mo6fuQqb7jEzf1LGa7X0xtLIwreoi5lg
X-Received: by 2002:a05:690c:dc2:b0:7dc:a5a8:8b9 with SMTP id 00721157ae682-7e058d3094amr31058287b3.10.1780138321887;
        Sat, 30 May 2026 03:52:01 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e176d6ff86sm5579357b3.16.2026.05.30.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:52:01 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 07:51:08 -0300
Subject: [net-next PATCH v10 3/9] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-realtek_forward-v10-3-d14b51e6a69d@gmail.com>
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
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
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9EBBE60C42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert open-coded port iteration loops to use the DSA helpers and
restructure rtl8365mb_setup() into clear blocking, user, and
CPU port phases.

As part of this refactoring, unused ports are no longer initialized and
no longer receive a virtual IRQ mapping. To accommodate this, a guard
check is added to the interrupt handler (rtl8365mb_irq) to safely skip
ports without a valid IRQ mapping

Furthermore, since the new initialization loop starts with all ports
administratively isolated by default, CPU port forwarding and isolation
masks are explicitly configured at the end of the setup phase to prevent
egress traffic from being blocked.

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 160 ++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 60 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index a1641378fcbb..fe7e0f0a66b7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1554,18 +1554,15 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
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
@@ -1581,13 +1578,10 @@ static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
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
@@ -1646,6 +1640,9 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	for_each_set_bit(line, &line_changes, priv->num_ports) {
 		int child_irq = irq_find_mapping(priv->irqdomain, line);
 
+		if (!child_irq)
+			continue;
+
 		handle_nested_irq(child_irq);
 	}
 
@@ -1709,13 +1706,14 @@ static int rtl8365mb_irq_disable(struct realtek_priv *priv)
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
@@ -1744,8 +1742,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_create_mapping(priv->irqdomain, i);
+	dsa_switch_for_each_available_port(dp, ds) {
+		virq = irq_create_mapping(priv->irqdomain, dp->index);
 		if (!virq) {
 			dev_err(priv->dev,
 				"failed to create irq domain mapping\n");
@@ -1815,9 +1813,11 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	mb->irq = 0;
 
 out_remove_irqdomain:
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_find_mapping(priv->irqdomain, i);
-		irq_dispose_mapping(virq);
+	dsa_switch_for_each_port(dp, ds) {
+		virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+		if (virq)
+			irq_dispose_mapping(virq);
 	}
 
 	irq_domain_remove(priv->irqdomain);
@@ -1832,8 +1832,9 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
 	int virq;
-	int i;
 
 	if (mb->irq) {
 		free_irq(mb->irq, priv);
@@ -1841,9 +1842,15 @@ static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 	}
 
 	if (priv->irqdomain) {
-		for (i = 0; i < priv->num_ports; i++) {
-			virq = irq_find_mapping(priv->irqdomain, i);
-			irq_dispose_mapping(virq);
+		/* Unused ports with a linked PHY still have an active IRQ
+		 * mapping that must be disposed of during teardown. Loop
+		 * through all ports.
+		 */
+		dsa_switch_for_each_port(dp, ds) {
+			virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+			if (virq)
+				irq_dispose_mapping(virq);
 		}
 
 		irq_domain_remove(priv->irqdomain);
@@ -1961,10 +1968,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -1991,33 +1999,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		cpu->mask |= BIT(cpu_dp->index);
-
-		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
-			cpu->trap_port = cpu_dp->index;
-	}
-	cpu->enable = cpu->mask > 0;
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
-	if (!cpu->enable) {
-		dev_err(priv->dev, "no upstream (CPU, Link) port defined\n");
-		ret = -EINVAL;
-		goto out_teardown_irq;
-	}
-
-	ret = rtl8365mb_cpu_config(priv);
-	if (ret)
-		goto out_teardown_irq;
-
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
-
-		if (dsa_is_unused_port(ds, i))
-			continue;
-
-		if (dsa_is_dsa_port(ds, i)) {
+		if (dsa_port_is_dsa(dp)) {
 			/* Cascading (DSA links) is not supported yet.
 			 * Historically, the driver has always been broken
 			 * without a dedicated CPU port because CPU tagging
@@ -2029,27 +2015,81 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 			goto out_teardown_irq;
 		}
 
-		/* Forward only to the CPU */
-		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
+
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
+		ret = rtl8365mb_port_set_isolation(priv, dp->index,
+						   upports_mask);
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
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no upstream (CPU, Link) port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
+	}
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


