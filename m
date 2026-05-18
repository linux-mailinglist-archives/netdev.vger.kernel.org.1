Return-Path: <netdev+bounces-288794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE1HAcZmCmq60wQAu9opvQ
	(envelope-from <netdev+bounces-288794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F64564AFB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD8FB3009550
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B501EB5C2;
	Mon, 18 May 2026 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B95BDtLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCF1E7C23
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066542; cv=none; b=bAJPEce90umFXTZ7cVSLe/t5m4RcGlTnZzQ8s3yD5hL4SSfRF15qLidWlGUVr1NGfTdo/XDms40DZh9R8e9wyKHX4ofEOrJjvu2JzAzrq72yndd1oeS8VzoC2uiM08ddL3zIUg4eSoOEto62uhKJH6V5bRqA7LV/+jPcMBJgYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066542; c=relaxed/simple;
	bh=JsJPzvgBq6j1InlniRHRPtiI5a1LOa+asIJ4eGspAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyTlHwFP7qIPuVOHNjlTl9cLjwhhV9eqc7aAYeygSwSycHsHpxwgNY7s4uKytlA6+xz3wdXmyZaNOA9i+IlCHPWo0h8mLrdwlbBOiOPg/lr4CG14AaumDFOmsIv4hiUqXFGsrT+RJmAa8K7j+H8fm+RIpM2e2DKJ1DRAm4wiyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B95BDtLn; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1357c851a48so790891c88.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066540; x=1779671340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv0f2OTfEldCB2gIZJHQbZBwbOUZm5r2cudeIOKxzHY=;
        b=B95BDtLnqReZ146qK83o7SKtvsnxWcoHkvPjGZFaaiAzj0XOXoQYbUNb1dhAb5khb8
         Kf7FmUqR0z6V1mEAhx9JmNwH08v2x9aPPcHM7gaTwYYv1iCS0HifLVhE3Joz2jcP+2yy
         EjKLKTe4DOt00fvpHWgKjQECFiZAzGCH9//VexIjGBFoUi6+dh2PApanExOaczoqm1U/
         m53+jhbgXu17d6pzuK/BAZ1Ega6r4wvriYXyuk2HzefGF8SVC0zShADNGioofPp8qygX
         sjUEuKBnG2KJatW6PCIuqRwM1d91NU4j3xr0svkbLwRpobiN2O6J/fajdBK1QinC6qz5
         /zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066540; x=1779671340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bv0f2OTfEldCB2gIZJHQbZBwbOUZm5r2cudeIOKxzHY=;
        b=RAzDChtLgpPaxjGvHHmNSO84wiAr9DrKCUfgkMzB4jK66K+QFaehk8ts+QdEIx2We+
         9c3Ox6YAtnXrynYPJNeVRuizjG4fje8Giw5FzMw9W3ufsFvlSePqpTSIcPo3SGWi0iG6
         bJMw+TGPXSWiNQGfQBB3JhXip6Jmhy1AR/prQGCf0Ps9MhqfdXsfG8sQt9TjoU1L7n4p
         AF7oK7XgupDAjsxz9T6xzhDy1MufZ3kyVg2Aumd2aWDthyXIzsetv9OBbywUCYlnjbXl
         sbM+E2NdPL7FscCzRrUQmPZnLoPBbcY5mclsMq/BQqI5JXVtZ4uHYGstJ+0mSf5sp61F
         DZuw==
X-Gm-Message-State: AOJu0Yyd5EirC1D2dEA95+Wa2s1vBCXdneB9hHaWtHH4dadSe7Fh1xGM
	XKYNFlFXQyuytb2BpSih5xyOOPuLHv6hw3Y5muTz5eP3naK1o9Y9t3MfEtcFpXmurV4=
X-Gm-Gg: Acq92OEt/CHyldRbRfx8tWGLdE0q4mn6DK3o2+8CqcjgSyPmIRxlEMsgvfwY81E5mEl
	T1N5rxXcnWhdhf6zBSMbmSoT8DXB73l7i6bO0C/HBNWxoKgUvEUXTVUHwd1g4RzJKGxsFk/1k5U
	4v61U3CtzgmzuBZJe7s5uS6u6avhYFSu94EUTMlA7YRHKgLre4g3MKf4TYwCA3Gu3ausWjdn1gt
	FZKvK/z2xZHU7MgBU9ukWRkaQ6ZdQvycSNe68x1YwmljLU4yHhv1mZql3gqXg80ynnJH/0FEFeh
	leFZvkcSGjV87BJcGAp2e8pi4P5nIr1kho4p3O/7U5v8LZBXo6ao9EjyxQ3CIC/VfyuNmtpnldD
	d0A8fT3+wsevT739lRiWhuTnJ8qNP/8yxGUXs5eEroU7P9HZz7fAZj1+A+h01YPDnYQEGO0DCqS
	Q6MWi13EQrjf8PLWCBXg5tajNK8s+xVTYVW1q9jr87UTfKBQe8jQ5BEqNaBmU3Hm5ClmaLYrArE
	U0rzFOy+M6f+I5g8wdxyLDtxjLtKIBtaDeM4Q9dFcYV0wNBdSLrh4GnNwBA1Svb1Vbm8Fj+16G4
	RLXhNK7m7r1wpO7YgA==
X-Received: by 2002:a05:7022:388a:b0:128:d967:4673 with SMTP id a92af1059eb24-13504515161mr5312353c88.16.1779066539993;
        Sun, 17 May 2026 18:08:59 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm18891372c88.0.2026.05.17.18.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:08:59 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction macros
Date: Sun, 17 May 2026 18:07:24 -0700
Message-ID: <20260518010739.80979-5-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010739.80979-1-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89F64564AFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288794-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that the BUS_ALIGN variable has been removed, the
arcnet_in/out/read/write* macros behave identically to the functions
they wrap. Expand them and remove their definitions to make the code
easier to maintain.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arcdevice.h    | 18 -------
 drivers/net/arcnet/com20020-pci.c |  6 +--
 drivers/net/arcnet/com20020.c     | 89 +++++++++++++++----------------
 drivers/net/arcnet/com20020.h     |  4 +-
 4 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index c870b8e21d44..a7c217359679 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -372,23 +372,5 @@ static inline void arcnet_set_addr(struct net_device *dev, u8 addr)
 	dev_addr_set(dev, &addr);
 }
 
-/* I/O equivalents */
-
-/* addr and offset allow register like names to define the actual IO address */
-#define arcnet_inb(addr, offset)					\
-	inb((addr) + (offset))
-#define arcnet_outb(value, addr, offset)				\
-	outb(value, (addr) + (offset))
-
-#define arcnet_insb(addr, offset, buffer, count)			\
-	insb((addr) + (offset), buffer, count)
-#define arcnet_outsb(addr, offset, buffer, count)			\
-	outsb((addr) + (offset), buffer, count)
-
-#define arcnet_readb(addr, offset)					\
-	readb((addr) + (offset))
-#define arcnet_writeb(value, addr, offset)				\
-	writeb(value, (addr) + (offset))
-
 #endif				/* __KERNEL__ */
 #endif				/* _LINUX_ARCDEVICE_H */
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index dbadda08dce2..98f68cb13a52 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -195,8 +195,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		 * ARCNET controller needs
 		 * this access to detect bustype
 		 */
-		arcnet_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
-		arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
+		outb(0x00, ioaddr + COM20020_REG_W_COMMAND);
+		inb(ioaddr + COM20020_REG_R_DIAGSTAT);
 
 		SET_NETDEV_DEV(dev, &pdev->dev);
 		dev->base_addr = ioaddr;
@@ -224,7 +224,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
 		}
 
-		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
+		if (inb(ioaddr + COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
 			ret = -EIO;
 			goto err_free_arcdev;
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index f2fa26626a06..59a4748d051f 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -65,13 +65,13 @@ static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
-		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
+	     ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(ofs & 0xff, ioaddr + COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "insb", count,
-	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     insb(ioaddr + COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 static void com20020_copy_to_card(struct net_device *dev, int bufnum,
@@ -80,12 +80,12 @@ static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | AUTOINCflag, ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb((ofs >> 8) | AUTOINCflag, ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(ofs & 0xff, ioaddr + COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "outsb", count,
-	     arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     outsb(ioaddr + COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 /* Reset the card and check some basic stuff during the detection stage. */
@@ -94,9 +94,9 @@ int com20020_check(struct net_device *dev)
 	int ioaddr = dev->base_addr, status;
 	struct arcnet_local *lp = netdev_priv(dev);
 
-	arcnet_outb(XTOcfg(3) | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+	outb(XTOcfg(3) | RESETcfg, ioaddr + COM20020_REG_W_CONFIG);
 	udelay(5);
-	arcnet_outb(XTOcfg(3), ioaddr, COM20020_REG_W_CONFIG);
+	outb(XTOcfg(3), ioaddr + COM20020_REG_W_CONFIG);
 	mdelay(RESETtime);
 
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
@@ -107,23 +107,23 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->setup | P1MODE;
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 
 	if (lp->clockm != 0) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup2, ioaddr + COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		outb(STARTIOcmd, ioaddr + COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* set node ID to 0x42 (but transmitter is disabled, so it's okay) */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(0x42, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
+	outb(0x42, ioaddr + COM20020_REG_W_XREG);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	status = inb(ioaddr + COM20020_REG_R_STATUS);
 
 	if ((status & 0x99) != (NORXflag | TXFREEflag | RESETflag)) {
 		arc_printk(D_NORMAL, dev, "status invalid (%Xh).\n", status);
@@ -131,18 +131,17 @@ int com20020_check(struct net_device *dev)
 	}
 	arc_printk(D_INIT_REASONS, dev, "status after reset: %X\n", status);
 
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
-		    ioaddr, COM20020_REG_W_COMMAND);
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	outb(CFLAGScmd | RESETclear | CONFIGclear,
+	     ioaddr + COM20020_REG_W_COMMAND);
+	status = inb(ioaddr + COM20020_REG_R_STATUS);
 	arc_printk(D_INIT_REASONS, dev, "status after reset acknowledged: %X\n",
 		   status);
 
 	/* Read first location of memory */
-	arcnet_outb(0 | RDDATAflag | AUTOINCflag,
-		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(0, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb(0 | RDDATAflag | AUTOINCflag, ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(0, ioaddr + COM20020_REG_W_ADDR_LO);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_RW_MEMDATA);
+	status = inb(ioaddr + COM20020_REG_RW_MEMDATA);
 	if (status != TESTvalue) {
 		arc_printk(D_NORMAL, dev, "Signature byte not found (%02Xh != D1h).\n",
 			   status);
@@ -159,7 +158,7 @@ static int com20020_set_hwaddr(struct net_device *dev, void *addr)
 
 	dev_addr_set(dev, hwaddr->sa_data);
 	com20020_set_subaddress(lp, ioaddr, SUB_NODE);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	outb(dev->dev_addr[0], ioaddr + COM20020_REG_W_XREG);
 
 	return 0;
 }
@@ -170,7 +169,7 @@ static int com20020_netdev_open(struct net_device *dev)
 	struct arcnet_local *lp = netdev_priv(dev);
 
 	lp->config |= TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 
 	return arcnet_open(dev);
 }
@@ -184,7 +183,7 @@ static int com20020_netdev_close(struct net_device *dev)
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	return 0;
 }
 
@@ -220,24 +219,24 @@ int com20020_found(struct net_device *dev, int shared)
 
 	/* FIXME: do this some other way! */
 	if (!dev->dev_addr[0])
-		arcnet_set_addr(dev, arcnet_inb(ioaddr, 8));
+		arcnet_set_addr(dev, inb(ioaddr + 8));
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 
 	if (lp->card_flags & ARC_CAN_10MBIT) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup2, ioaddr + COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		outb(STARTIOcmd, ioaddr + COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* Default 0x38 + register: Node ID */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
+	outb(dev->dev_addr[0], ioaddr + COM20020_REG_W_XREG);
 
 	/* reserve the irq */
 	if (request_irq(dev->irq, arcnet_interrupt, shared,
@@ -288,26 +287,26 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 	arc_printk(D_DEBUG, dev, "%s: %d: %s: dev: %p, lp: %p, dev->name: %s\n",
 		   __FILE__, __LINE__, __func__, dev, lp, dev->name);
 	arc_printk(D_INIT, dev, "Resetting %s (status=%02Xh)\n",
-		   dev->name, arcnet_inb(ioaddr, COM20020_REG_R_STATUS));
+		   dev->name, inb(ioaddr + COM20020_REG_R_STATUS));
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 	lp->config |= (lp->timeout << 3) | (lp->backplane << 2);
 	/* power-up defaults */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
 	if (really_reset) {
 		/* reset the card */
-		arcnet_outb(lp->config | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config | RESETcfg, ioaddr + COM20020_REG_W_CONFIG);
 		udelay(5);
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 		mdelay(RESETtime * 2);
 				/* COM20020 seems to be slower sometimes */
 	}
 	/* clear flags & end reset */
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
-		    ioaddr, COM20020_REG_W_COMMAND);
+	outb(CFLAGScmd | RESETclear | CONFIGclear,
+	     ioaddr + COM20020_REG_W_COMMAND);
 
 	/* verify that the ARCnet signature byte is present */
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
@@ -321,7 +320,7 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 		return 1;
 	}
 	/* enable extended (512-byte) packets */
-	arcnet_outb(CONFIGcmd | EXTconf, ioaddr, COM20020_REG_W_COMMAND);
+	outb(CONFIGcmd | EXTconf, ioaddr + COM20020_REG_W_COMMAND);
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
@@ -334,22 +333,22 @@ static void com20020_setmask(struct net_device *dev, int mask)
 	u_int ioaddr = dev->base_addr;
 
 	arc_printk(D_DURING, dev, "Setting mask to %x at %x\n", mask, ioaddr);
-	arcnet_outb(mask, ioaddr, COM20020_REG_W_INTMASK);
+	outb(mask, ioaddr + COM20020_REG_W_INTMASK);
 }
 
 static void com20020_command(struct net_device *dev, int cmd)
 {
 	u_int ioaddr = dev->base_addr;
 
-	arcnet_outb(cmd, ioaddr, COM20020_REG_W_COMMAND);
+	outb(cmd, ioaddr + COM20020_REG_W_COMMAND);
 }
 
 static int com20020_status(struct net_device *dev)
 {
 	u_int ioaddr = dev->base_addr;
 
-	return arcnet_inb(ioaddr, COM20020_REG_R_STATUS) +
-		(arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT) << 8);
+	return inb(ioaddr + COM20020_REG_R_STATUS) +
+		(inb(ioaddr + COM20020_REG_R_DIAGSTAT) << 8);
 }
 
 static void com20020_close(struct net_device *dev)
@@ -359,7 +358,7 @@ static void com20020_close(struct net_device *dev)
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 }
 
 /* ARCnet does not support multicast, only unicast and broadcast */
@@ -374,14 +373,14 @@ static void com20020_set_rx_mode(struct net_device *dev)
 			arc_printk(D_NORMAL, dev, "Setting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup |= PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 	} else {
 		/* Disable promiscuous mode, use normal mode */
 		if ((lp->setup & PROMISCset))
 			arc_printk(D_NORMAL, dev, "Resetting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup &= ~PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 	}
 }
 
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index 0bcc5d0a6903..e7aac0e81a13 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -123,9 +123,9 @@ static inline void com20020_set_subaddress(struct arcnet_local *lp,
 {
 	if (val < 4) {
 		lp->config = (lp->config & ~0x03) | val;
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	} else {
-		arcnet_outb(val, ioaddr, COM20020_REG_W_SUBADR);
+		outb(val, ioaddr + COM20020_REG_W_SUBADR);
 	}
 }
 
-- 
2.43.0


