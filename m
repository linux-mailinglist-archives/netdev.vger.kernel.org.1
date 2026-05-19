Return-Path: <netdev+bounces-289272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EPUFwLuC2pQRQUAu9opvQ
	(envelope-from <netdev+bounces-289272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC85774D9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CB4430298FA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03B309EF2;
	Tue, 19 May 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdqQQzKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDA1AF0BB
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166708; cv=none; b=Wwkr83dsR/fSo7V5lGHZHLf6KHvpxNREGAM0x9fd2Z3j3FXjZvSskyL4YtHO9uSbHbOZlsvRINg9OfU3wjB+ss7j4Ftp7W0ZJFYLZFmTlBAtKBt8OK+mgET/nL3nBKnLNSXm1CQ9xCxX2Kzm4ryldZP4e9CMYwwfAFdXWKAzPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166708; c=relaxed/simple;
	bh=hMAGhmqHDyXPih7XwdU10TC/NFpFrguGzuIpkV2/cAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fP7OrHhMLsVOezQ0xWbTFGIXkZIrgZW196s3eun834pf4ddld2RsFSbTs9dncRMRyWyTm3ljpZf7dWKTlb+Buoc8aCSoXspU/Xq0NOdzhpKHPiwRDBN94EADKImiGUgZ7llu5kfnkOwU+6XQGRgnx2AF4qMRSOZ8uXogdxcuENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdqQQzKg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90fa736d46fso207495785a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779166706; x=1779771506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxmDMyxKH6wofU6MgwFcS09w4WkrV6gsi3er7J60bO4=;
        b=KdqQQzKgDF6H163n57wzhpvESKc4S+rHKqJ2+auMreDRLi8OOF653QCnBGYG+3W9Jh
         xqRJX7hxG9nhUGu7DPgWdR08mu8t7tmYv3CRaubgBQdEKQG3s2u0pDGoPyzpm/q65p99
         vab7HZCEO0so5SXbOEP1O8j+4QGPrDXSCjW99vY++mEt7JFuaHKVZNVtSt10MSJ48gl2
         xsrRGJ7YGuH0iyxlRY5SVV62CGA12RNgjVgbV3kdouQtew+/rjC5F/7jtAj0swrffz9M
         e0nFxE1Kj4aDOST5JNAkdvWUXiqqXSartiRwjCZn4TriCFqWMALmoMF7ZTeZXn+/6iBD
         cdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166706; x=1779771506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FxmDMyxKH6wofU6MgwFcS09w4WkrV6gsi3er7J60bO4=;
        b=knHLBNwSPXjLW09lr/FNBAfDTZOUyt5QkVRLRPbLMM5imK5VdHdS0BgXtjfU+hSslL
         YVy+2GyMFHRv8w5u/8Rd0jVraRrbYKTh60sqpzJj9rrYvgSxd8wfCtVnJdSowZkP2/EC
         KGhzXXKfmfBNbOTKn+SMIvzjMZw1I7YAIjOZ9NToxMDO7wtXWNCsn/H7NngyCSRgwdmu
         sQCvbrwdAyoJwQGCcF1Suocom9SWp8DBnBKJ/498cc3YHu0MIKE/8RP/oT74BTgcBz1L
         3ho7VohdU6qHxohbfmeUgLr8Kozp2kyS6ZQqYS8+KBgnF34667Ybp8lQ9CqhZBO4sZp7
         ueCw==
X-Gm-Message-State: AOJu0YyLIOz9csswnrfE/M3fe3h6PbRHUqjLCgPdRBwyQEA43ZNx1cz5
	XnCFw0CNnQTUIIEervFLjtr/cx2unPXSukyIfZ8D5mcQMk1xg0pelckg
X-Gm-Gg: Acq92OFSFOIXPba3y6cTd+w0xA0bXbkcr7ECbb5DW/PPidQAB8ECSr9ilMTJamP+QJ+
	8GUmX2mksXrBgkNdK3NCulqJBdUD/xI1WTZ2AZEVM2veX82bBdlYJ8uh6MBHAgIqR+ZJn3b0+to
	Fz961mjwAWcJgi7nLREdHmGfJY25cWLqKc6lQx3KhQPaHAFqHNVTTLOuJgsTiRNzhWwzMmGNTJ1
	q17dVh9hFq9Sh0c3hpm2+YiFlN+rLB/inKdoM5MIQRmkoQQAuYeVgGe77zJ1GNGTMOPliZpviyX
	sxp/vpKAru8gYDHEtjpVLfjakq9YuFq7cX8iWmLEP3Ka82G46se3XLR+WsdcQyyNrUyPeJQap7x
	xifuF724nIOXa5wgXqAqKVI0yQqnh3vWb2W/jyytG/v1Z+7gS/zMJnbnT+4F3oEdmdiep71ZAf0
	bszHq/Z+0KMjhHNyfrlcjCAJW/PkCUTrBxaelz72I=
X-Received: by 2002:a05:620a:1793:b0:910:8089:4909 with SMTP id af79cd13be357-911ce3327f9mr2663369985a.23.1779166705722;
        Mon, 18 May 2026 21:58:25 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1588593185a.23.2026.05.18.21.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:58:25 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 19 May 2026 01:57:57 -0300
Subject: [net-next PATCH v5 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-realtek_forward-v5-2-cb9f702c1782@gmail.com>
References: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
In-Reply-To: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BAC85774D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/dsa/realtek/rtl8365mb.c | 142 +++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c04786be3f79..60a21a428e13 100644
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
@@ -1841,9 +1842,11 @@ static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
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
@@ -1961,10 +1964,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -1991,46 +1995,84 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
+			dev_err(ds->dev, "Cascading(DSA link) not supported\n");
+			ret = -EOPNOTSUPP;
+			goto out_teardown_irq;
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
 	}
 
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


