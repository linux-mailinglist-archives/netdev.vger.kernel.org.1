Return-Path: <netdev+bounces-293501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ9pN1f0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A302D618F2B
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7DAB300751D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32523392E;
	Mon,  1 Jun 2026 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K932Lv07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAD22F74A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282435; cv=none; b=M+rMTE0gEaw56IXcf3op2G17YVypxCsFoKc0MGTDddmmQsXVoXtz7h0TG+op2mf/4UkiJ0JTgWNrr5azLWtPeqe4tXTUwihUJqoO3cyN0xPVMk3Lffp/yH6cZhMK3XISU1DajmUHZJC7retN1ZQUlQmzkC2L3obEP+dhq0NkDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282435; c=relaxed/simple;
	bh=5dYlY5NFT//qz4qKSha3nySh7byb6+j8RqxsiJeLH3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0ESBwwXw5MWBGNADGF0Iz+psQJMFS9S3ZjXpUJgRuhg4ZYLPCmDmSg1fBJxPKFehsAMiB2lu5XcS65BN7I0jPX+ajsx5N1qid9A36NTNZN9OvLj1b0XQGFqTCKJRG3HaAHeUlsZSAYEhmLXuL1IBvQeNJTIir14uAkS/gMpbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K932Lv07; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6607048fa62so707318d50.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282433; x=1780887233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tI2nNj+yjli0CDKmMBa2bKFaR7UzRezw5AyPk17SX4=;
        b=K932Lv07Jgoha0TjGoyfeB4Y3t85xejTbd2OgpWXf+lMTV9j5G2XMx+ewuY9jFkkNO
         LTIPegedMj9vT8L9PubU3BVMLiXohQC5j9hMNgMlFPhbREiYrdhmJs8XDuEOV4AJ2/QT
         VDjErC4F/tIOUXB2irxpx3BvmLeleWQIEacQrOmAhEPK63l70ikbilrz1eQ7ZqxQTLY4
         TZ+vuhTHf/A75TIJobDE9dWxCV1TSYEB1PjoMoJgZZV4SkCL2x6RlBz54IwYrKr4CxeS
         vBovo8rp96ewywFU4GXCq8K9zIJVaq6NYDAywVeuCDjbcE7mAOpao2EryETDanRIqhop
         99KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282433; x=1780887233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4tI2nNj+yjli0CDKmMBa2bKFaR7UzRezw5AyPk17SX4=;
        b=OcN5JUTv89j0S3pvYfeLqiCD+qRzn55iNgxP7b7ZueZV+0cvLNaHLhu0Oai0STiNkC
         4CLNsQTFI/yMI+dIMqIs3D4MxumFmaZQ8u/hX57nvTbbH806gPsAgFAXo6rCXKXUfOxx
         0b3QbAQcTASaLM/WjRK1keqtKgraY4Uc5Nx1IjTJ18hpaImKuCXDK8l2yDJtPvMG0+yj
         JuVYIhQ8KxM3j7K7ZOXrd2U4V+/GuzEV1tojk2uWft6r+lPwdwWF81aMc6PVG65LC+4R
         0iVKOtyc/J14zIf3a7VqmJbM0fLYqdSYdj6NP6eiva9PboKMq6L2hiwA7t99OMXEa5+b
         vOCg==
X-Gm-Message-State: AOJu0Yw6CDYTTzLuCebtZW4cwLT5Gz/omeW1Otemx7URiVTprW7bllgf
	AnRBGsSpM+lHilg+xOus7i0mfn/MsYQdsu92P9K2W+JHklq3vAXKC5SF
X-Gm-Gg: Acq92OGThgKON+JuyunzHY7gFYeQvaypsFtD+bzKF+8PpnVqS/lyuBAZG0EaeQRKy5Y
	lBLHwURMLn2UzLqwo3alkPu9S0bL+q4r1ayC6Tw5mHRSqwzskXXb92ZHx5VEAMNbh2RA3+C5hmb
	KcCVwzOF6TaS1WYGqaasM+tZPk8YK09affWPDO06qwQ723uIqOuWqQqlcDReTMXgP3sCCgOQdoJ
	Vx+wVcidNfznngjprdRkkYhtJN4v1oQ/VCAHWSjNERdwU2+3MqhzsXAXe+C7LseWAG74Bqu6msz
	x8rAnAuwElgbdvrzZY+haelMZE5qFOPSFrAYbLTccYIbDz+3ikSS4316fvBxV9o+vnP7bAUKj4x
	MuxaEPF3SJU6vxvw4DTNJXTcRsw/F4igvNzbHcC5R5SH/bHyMunIljfvSaBBjE7Ko8ljtJg4Woj
	OKP0Xj3NLLcQ57SAhwa8an+2oIhTC2ozdym1qvwb5PZLmh5RvZDw==
X-Received: by 2002:a53:b1cd:0:b0:651:e1e7:7f50 with SMTP id 956f58d0204a3-6605f1958aemr5693016d50.29.1780282432982;
        Sun, 31 May 2026 19:53:52 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:53:52 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:18 -0300
Subject: [net-next PATCH v11 3/9] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-realtek_forward-v11-3-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-293501-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A302D618F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert open-coded port iteration loops to use the DSA helpers and
restructure rtl8365mb_setup() into clear blocking, user, and
CPU port phases.

As part of this refactoring, unused ports are explicitly placed into a
blocked, isolated state with learning disabled, ensuring safe default
hardware behavior. The driver also does not allocate a virtual IRQ
mapping for unused ports. To accommodate this, a guard check is added to
the interrupt handler (rtl8365mb_irq) to safely skip ports without a
valid IRQ mapping. The irq domain teardown, however, does clean all
ports as external PHYs may still map the IRQ.

Furthermore, since the new initialization loop starts with all ports
administratively isolated by default, CPU port forwarding and isolation
masks are explicitly configured at the end of the setup phase to prevent
egress traffic from being blocked.

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 152 +++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 37e1d7654b1d..8460f36df4e5 100644
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
@@ -1991,67 +1999,99 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	for (i = 0; i < priv->num_ports; i++) {
+	dsa_switch_for_each_port(dp, ds) {
 		/* Cascading (DSA links) is not supported yet.
 		 * Historically, the driver has always been broken
 		 * without a dedicated CPU port because CPU tagging
 		 * would be disabled, rendering the switch entirely
 		 * non-functional for DSA operations.
 		 */
-		if (dsa_is_dsa_port(ds, i)) {
+		if (dsa_port_is_dsa(dp)) {
 			dev_err(priv->dev, "Cascading (DSA link) not supported\n");
 			ret = -EOPNOTSUPP;
 			goto out_teardown_irq;
 		}
 	}
 
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
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
-	if (!cpu->enable) {
-		dev_err(priv->dev, "no CPU port defined\n");
-		ret = -EINVAL;
-		goto out_teardown_irq;
-	}
+		/* Start with all port completely isolated */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
+		if (ret)
+			goto out_teardown_irq;
 
-	ret = rtl8365mb_cpu_config(priv);
-	if (ret)
-		goto out_teardown_irq;
+		/* Disable learning */
+		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
+		if (ret)
+			goto out_teardown_irq;
 
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
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
+		dev_err(priv->dev, "no CPU port defined\n");
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


