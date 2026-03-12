Return-Path: <netdev+bounces-267005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO+cDkGSsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-267005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:15:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5922270391
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88311305C6E4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682A3BE63A;
	Thu, 12 Mar 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hp+t8ykU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88A3B47D4
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310324; cv=none; b=WJQabimVogFkNjKfurEugTkHT2Ok8xx3P+xqWX4XuNG6QfURm9TCGswVflXtN9Ky9lCBU1Cv0lJP7J5vCCCgwSyYAALZZP9CDyaoF0Xk4aHB2BGktkgJ4mfaT43OlEnRgXOgZDxhJ78KUUvnQ1hJ/AEy/Z7FDnuFzgFbgchlzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310324; c=relaxed/simple;
	bh=6xUWKdeUm13YMjnYSU6F2gpNMpsC2neElMV4EzL5Njs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhHS+Ogcdbh1BlwEsDD5wMJlzcr76K5X4g/C1VTEqamx6O8LH49rPwxRrn7nPiCEKv37LcRDMdO/0XtBD6s/Pc1Qt7IuEB/13rgM95VSlqBffjgUfCXMxgB68XQzm+X1BBbAldZ0SvZmrC7xWJCpF1cmi1bYn9LK9uPSRKMlMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hp+t8ykU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E1C974E42650;
	Thu, 12 Mar 2026 10:12:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B21AB5FDEB;
	Thu, 12 Mar 2026 10:12:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DFE610368916;
	Thu, 12 Mar 2026 11:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773310320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lj7v8KqAHFpPD+bbuLSZdQfcrsKxuMLWjY2vWELEISw=;
	b=hp+t8ykUahsGtr0cK+M2lXNRD8ODQBIMFRzp3qoMPndxGauz3WJl2gZGyJzv9rhO2BzEfB
	1mm3ifxAGhW7gOtndV6Gl3tkVBlR3+3FdlMpPy0imKO3GHrhGDWHURUtDsVGhnhSkWbVJ2
	vlZZOSiXo3OYnXKM2LtpoPcNH3F/FRg1j5daWQizrIAZNlRhcv3UAMgbjrRtuM3AZV/AOz
	Rse89qlv1VJlId9mybaJP8pnudgIBP8Vq0Xio+EdwngnUruw89lPzhcq1QXF9HEdxOEi+L
	D3g4uqfDV052jeAwt7ganfNXgo5JZ0TFE37HrOwHwaoi4ngOxPISMyqI6Z6X5w==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: Ryan.Wanner@microchip.com,
	Valentina.FernandezAlanis@microchip.com,
	abin.joseph@amd.com,
	alex@ghiti.fr,
	andrew+netdev@lunn.ch,
	aou@eecs.berkeley.edu,
	claudiu.beznea@tuxon.dev,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	daire.mcnamara@microchip.com,
	dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	richardcochran@gmail.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	sean.anderson@linux.dev,
	thomas.petazzoni@bootlin.com,
	vineeth.karumanchi@amd.com
Subject: [PATCH 1/3] net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
Date: Thu, 12 Mar 2026 11:11:36 +0100
Message-ID: <20260312101138.465482-1-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
References: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,amd.com,ghiti.fr,lunn.ch,eecs.berkeley.edu,tuxon.dev,kernel.org,raspberrypi.com,davemloft.net,vger.kernel.org,google.com,bootlin.com,lists.infradead.org,redhat.com,dabbelt.com,gmail.com,sifive.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267005-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: C5922270391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DCFG1 (design config 1 register) carries a bit indicating whether User
I/O feature has been enabled or not. The MACB/GEM driver has a cap flag
indicating that HW has the feature disabled (default is enabled). Add
the missing connection between DCFG1 bit and MACB_CAPS_USRIO_DISABLED.

Indirect impact: avoid useless writel() on USERIO register; this is not
an important fix because USERIO is anyway read-only when feature is
disabled.

If for some reason a compatible sets USRIO_DISABLED but DCFG1 indicates
it is enabled, we still keep the disabled capability flag. This ensures
we don't break "cdns,np4-macb" that sets the flag from compatible match
data.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 2 ++
 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8e5305f9a754..16527dbab875 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -524,6 +524,8 @@
 #define GEM_IRQCOR_SIZE				1
 #define GEM_DBWDEF_OFFSET			25
 #define GEM_DBWDEF_SIZE				3
+#define GEM_USERIO_OFFSET			9
+#define GEM_USERIO_SIZE				1
 #define GEM_NO_PCS_OFFSET			0
 #define GEM_NO_PCS_SIZE				1
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6ac68731784f..ecab7fdc962d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4481,6 +4481,8 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
 		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
 			bp->caps |= MACB_CAPS_PCS;
+		if (!(dcfg & GEM_BIT(USERIO)))
+			bp->caps |= MACB_CAPS_USRIO_DISABLED;
 		dcfg = gem_readl(bp, DCFG12);
 		if (GEM_BFEXT(HIGH_SPEED, dcfg) == 1)
 			bp->caps |= MACB_CAPS_HIGH_SPEED;
-- 
2.53.0


