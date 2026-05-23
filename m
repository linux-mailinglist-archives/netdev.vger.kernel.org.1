Return-Path: <netdev+bounces-291035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC13LIRBEWrsjAYAu9opvQ
	(envelope-from <netdev+bounces-291035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:56:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A15BD59E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7AF73010623
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36BF3264D9;
	Sat, 23 May 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfShCqQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A341A267
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515762; cv=none; b=OBYBZ/Dc6JO8wJVLQvd7ilAUbvvNGWrPEEKnNoJkiVwNtw+Y/VWsrWHPC8e9ssVEB0gzaXVRTcHkTKmAQw1HX256NLtB1UukgeFqtSmJcUg62Za30Of9By0NYWuaMqpEoF/fojGS7qDohqsl2i6W+QPC7jv+jZeHNyE2QIPk0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515762; c=relaxed/simple;
	bh=D1wj/JFTaFjBniNMTmZjoOwzM5LCRO5q0kzkuvfbs7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqavRiJ5nwDWqxubLUPRemjSaVG7h85AZ6xn8m1/LVQcuBZo1QT5pVHuDop358ohzBUJQu9ZzZvIP+0Dhe0qnfOvvVCbgmWkkt9rbYuxXXLpKBu3RUl3/mgZZD918H7zGkjgiPiBZDG5fr0DpXEOVbcKqMUf3U7Ow8tfsOpX6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfShCqQ2; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5751136c561so6910176e0c.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779515760; x=1780120560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYHIcd4bbGqwm2U+v3yuHG+2tAyqIOBeGKeTJonOCew=;
        b=gfShCqQ2o84jT1g1bTQX1jhNXA/uZKidFandMIPXWzIZRRe8YVL/8fcF3QF4NN0N0s
         KZRfFMJzo7ufDY3Rr/zL/dGDoJJtq/Plje6mCmGdSlgK2BL2WEgzPiNWBvRBKKGEXjsY
         PCEyRYYJQyI+og/MLBadadGnhSp6Nr5oVvBlNtp8nib6n9kC5kcKs1vrJAQXxazTqhIE
         sFH/mfABkPX2v/A9xWtPKz7/FXCEgDCLoT9QZ0GYjMgvmELns3OvB3XLt96zIDoWBA01
         xOSRpYEF5lcE8l8P7riKTGgOR0RQI7JU/hpYlo0u5EDDteCersPDhevEY9TOJoij/28Z
         rbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779515760; x=1780120560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aYHIcd4bbGqwm2U+v3yuHG+2tAyqIOBeGKeTJonOCew=;
        b=cDXua6FWdJp/l4BHiXUNJyigRt20f4UGTx15YcMlo4zS7IZPeyHj0IyGjtthWqtccf
         6d07UAzVrfjh4dlMmZvJfNizTyWx7VD7M3GBIHq+ejqi669L1jDYg6PJLe3c9hUqByb2
         ZdXqMmr184BAzTgc2CW70tGm8yXaQHs7uTW9K6Fi2liOXmL5+Scvy5LuPj+JBlx5tlWv
         fJ87Zmt4nEvjeO0IwBm2jGRsNTNyN6/+6Ew+SfuHh/lHcksS3evoY95zt9MKJo4uw3Lu
         G3RoYYNjMoKEAYWcUeN+MgF47JF68p523iq+6Fzbl4XGYNJRH94LqT+2RpzBkIU14UIz
         SblQ==
X-Gm-Message-State: AOJu0YygI3h372MvXcRWDKOCsSrfdj+Pu6IquLfHga6qpc/TSnO3zPud
	ohAUOdNHsgHKxA6JnvtMPcMqpEAphbAN5WpF9laM++AzKFyiGBJFkrcL
X-Gm-Gg: Acq92OELaOtE7Lal6FFqPOBMvPoZFVCgFP+MFbtr6kJy/MuAUpsNS/E/RZXoJWDjONc
	fkVGVTRznM6jEu/+Sb3BIYa1BVCjmFzAQgE2EydSlacYyUJQEvyz2mLBCdQ2/M729YZJ4W0ZJXt
	EJ7QE3v0jF/yHRYU/BKkBkm397Z0NiVkgWH7CrfW4DTJ07IeJR6eKvFMgNToF1cPdqjtQjxyK/Z
	pV03pXDN+ZmWiXemZ+s7nUNEhXGMAyDQA7JSiCTV2NqV7aQvuUvbBWBmZoSjZvDRO1SDWbDXXTH
	HYu3GebaRWCGDVp5wKylUXv8akncJ/248s4qvcwgNZ9UdE/bakdSzAiNSt86fJhuet42d7nZMDG
	AxGk01Wg8IloJ+JOVY5nfigwG5nuFVKbAtceTppDP+wuq//ecqZlxnJIRZNYR6DT0AhfrXiif68
	wPf0rYwnFCdW888fj1xF3Qj1BGpxarKDXiJKJxRj8=
X-Received: by 2002:a05:6122:2a1:b0:56b:9534:c06f with SMTP id 71dfb90a1353d-5840e635876mr3724170e0c.3.1779515760263;
        Fri, 22 May 2026 22:56:00 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f973300dsm5023718e0c.18.2026.05.22.22.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:55:59 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 May 2026 02:55:35 -0300
Subject: [net-next PATCH v7 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-realtek_forward-v7-2-313805e218f3@gmail.com>
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
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291035-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 498A15BD59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert open-coded port iteration loops to use the DSA helpers and
restructure rtl8365mb_setup() into clear blocking, user, and
CPU port phases.

This refactoring introduces the following behavioral and defensive
changes:
- CPU port forwarding/isolation is now explicitly configured. This is
  necessary to prevent egress traffic from being blocked by the new
  initialization loop that starts with all ports disabled (reported by
  Abdulkader Alrezej during series testing).
- A guard check is added to the interrupt handler (rtl8365mb_irq) to
  safely skip ports without a virtual IRQ mapping. Since unused ports no
  longer receive a virq mapping, this prevents dangerous calls to
  handle_nested_irq(0) if a link event fires on an unmapped port.
- The driver now explicitly returns -EOPNOTSUPP if a DSA cascade link
  port is detected. This topology is not supported yet and has
  historically been broken because the absence of a direct CPU port
  disables CPU tagging entirely, rendering the switch non-functional for
  DSA.
- The rtl8365mb_setup() function now explicitly enforces the presence
  of a CPU port, returning -EINVAL if none are found.

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 158 +++++++++++++++++++++++++-----------
 1 file changed, 109 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 2637884fe472..27746b0694c9 100644
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
+	dsa_switch_for_each_available_port(dp, ds) {
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
@@ -1991,46 +1999,98 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		cpu->mask |= BIT(cpu_dp->index);
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
+
+		if (dsa_port_is_dsa(dp)) {
+			/* Cascading (DSA links) is not supported yet.
+			 * Historically, the driver has always been broken
+			 * without a dedicated CPU port because CPU tagging
+			 * would be disabled, rendering the switch entirely
+			 * non-functional for DSA operations.
+			 */
+			dev_err(ds->dev,
+				"Cascading (DSA link) not supported\n");
+			ret = -EOPNOTSUPP;
+			goto out_teardown_irq;
+		}
 
-		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
-			cpu->trap_port = cpu_dp->index;
-	}
-	cpu->enable = cpu->mask > 0;
-	ret = rtl8365mb_cpu_config(priv);
-	if (ret)
-		goto out_teardown_irq;
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
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
 
-		if (dsa_is_unused_port(ds, i))
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
 			continue;
 
 		/* Forward only to the CPU */
-		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
+		ret = rtl8365mb_port_set_isolation(priv, dp->index,
+						   upports_mask);
 		if (ret)
 			goto out_teardown_irq;
 
-		/* Disable learning */
-		ret = rtl8365mb_port_set_learning(priv, i, false);
+		/* If we support cascade switches, it should also include the
+		 * downstream DSA ports.
+		 */
+		downports_mask |= BIT(dp->index);
+	}
+
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
 		if (ret)
 			goto out_teardown_irq;
+	}
 
-		/* Set the initial STP state of all ports to DISABLED, otherwise
-		 * ports will still forward frames to the CPU despite being
-		 * administratively down by default.
-		 */
-		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+	cpu->mask = upports_mask;
+	cpu->enable = cpu->mask > 0;
 
-		/* Set up per-port private data */
-		p->priv = priv;
-		p->index = i;
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no upstream (CPU, Link) port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
 	}
 
+	ret = rtl8365mb_cpu_config(priv);
+	if (ret)
+		goto out_teardown_irq;
+
 	ret = rtl8365mb_port_change_mtu(ds, cpu->trap_port, ETH_DATA_LEN);
 	if (ret)
 		goto out_teardown_irq;

-- 
2.54.0


