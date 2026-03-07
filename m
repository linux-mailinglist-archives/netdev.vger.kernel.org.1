Return-Path: <netdev+bounces-265191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJSSH5GZrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:33:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E143622DB93
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9998D301C59F
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8C3345CAB;
	Sat,  7 Mar 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShMOHoes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66097313E21
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919182; cv=none; b=m2iBIMyQKfaSSH9lSF2oiTt3eEy6x5xFIyMj2G5BtL8BKvHQh4hRGF34WQ8AngAnayPbhT+G26NLhvf0sOakrQfzMQkXzAW2JrpH8hO+SxOMFEUCrjBaqxWdsEuJVTCPiVypFkPsc+Zbyx1NB1KneFLCgUDrfgIRWKhCZtnlzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919182; c=relaxed/simple;
	bh=IalBsRFpE5x5/xFaVHrbb4x+6gUF1qCnEMvJ6Qfnoas=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C2QKKqxPyGgevuUcajuih2KFwF/g61EOs83FrjerhKKJVwfjatPpXa0+5c2w02Blsg4VhQb4G4sV4KEvlLg1uhWvRdceTZ0dsejDQmKOeoRLuhcnPbbpHDcH/LpRnQ/a6NzEM8wg8S63HPZZECntA6fCK88ZDyBcsl7+KV/pn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShMOHoes; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso2625075f8f.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919180; x=1773523980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pR5q5r3Mes7TJAyUzECgg8kfuz01nC9/URwKM/qNQHw=;
        b=ShMOHoes5v9DatAPD9iUJNBW3fYPAt5/9UtDxkBOYt8WDPwaEE+C7yb2YJp7zT0eVJ
         otyoDr3HJnGp3ABk6v9yrQt+4tu0s95HtBzCza7k9477I1GCX8HUq4FiB5Q1bmDATHPU
         otZaW06falLBDZexfFvZI4N1I+Xu8N0gGecs9p2BWVqoLMNrmjC04+hi4JrEzdZkN0P9
         dnHZNDDaFlj7zWxrv3hp1FR5G9cmAfQc3w/9r4pD+JSJTQCDaXHj1hDmQJzLGPJBO0eE
         lffkn3dgVTE9DeGeMTFjleX8ln2200nV62mfceFLVFrwa412okBskppcZxiQDtrmQoLN
         qZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919180; x=1773523980;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR5q5r3Mes7TJAyUzECgg8kfuz01nC9/URwKM/qNQHw=;
        b=hN+6v8kY7IRNrhlPhGDtSg5Llq5nQcqXdtsJHW7hPet4DIY5vSGYl3KOrwd3Jdt124
         P5IXQQc8X8AkWpfj3l7dWd3DH6YC1wzOZokeERMcip3YGzVROIvWJf+HyYPa70LToiKI
         Jc4Nlr8Ir1XUtyXrpVwhYNCdG8pZLDitEtNBXDRHaG9C+sCUih0+7YMb2z5igriYLyG5
         eHsdYbcJNXADOMbgmBHB6kIoNICUuU/0cbX+C0DDiOXeF6hOBXGlf+8Svy88+zdz1Xk0
         +X4Ak7UumV4yIibz0cpzymefDGFcc5qdQ1hpOV1qskap497UQ79gdiPRdskTzL2CTtBk
         V7MQ==
X-Gm-Message-State: AOJu0YxisyfVug59oLyLRqjaK5h3PCyERMnhuLAAo/3Fw6fdcPiKgt8b
	IyFsp8eZ0Tl7dtQjrL0tTmIvqOYb/qeLbOG7+s5vklUGJdT5mueqxhsJ
X-Gm-Gg: ATEYQzy4u8hBTM943V0qbMLeOQ0nCPWu+GUXMm1CQj/8jYJFIyRU97edSTU4kbZLEgR
	d6CZPkKT8bVVb9Z9BOOJeAHGQk7ZKtbOIM9qCkh7U/U5jOuXZhDQZ5lWQ92jeYBZs/UBmDDaG4V
	KiCg5v5QvVpwb0xIfSYyXlW/MTJ3V9G3MGZ0hW5TnCIHVaV1WkJc7vbZG+DtCxqk0wXH8Ca+5vw
	zLJ/tR6MY34CSIwJSunv067z/MjRzDY6M65PE1kGVyDhrBCl2U41jUIaFlhxgPnpir/cAjvsXOM
	MPIOcZzvhdR4YQrupB0+Lb1pLVlI60LASIAzEDRympZqPLFoHWB8Z40rFiA8QcbvavA5HCQ4waO
	NR2kuX+pLtfpT0Eok0vLnfr50GZU6avlmK3C3v4gMV73rJNSPVhFSfr/9GoJ46ud5UGqCW8+Cw9
	3wXT+RXGFEN6zWTS7svUOV+pAxk3NvD+9aZmpY4vr4kUibqBRe4wnIBsmM3rfxvkjvBq2+FnGHJ
	pAa3Mq6nQi6Pos3mzO1VWmMpsb0ifzmH/zmiomfxOtYZnjawpL1tdsNZ/KGR7GAig==
X-Received: by 2002:a05:600c:45c6:b0:483:7ae2:1737 with SMTP id 5b1f17b1804b1-48526957d45mr105179165e9.17.1772919179736;
        Sat, 07 Mar 2026 13:32:59 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853044d849sm95136945e9.11.2026.03.07.13.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:32:59 -0800 (PST)
Message-ID: <1a597d71-dc16-41a2-82d0-5db2d4949eca@gmail.com>
Date: Sat, 7 Mar 2026 22:32:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/5] net: phy: move (of_)mdio_find_bus to
 mdio_bus_provider.c
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Language: en-US
In-Reply-To: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E143622DB93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.855];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Functionality outside libphy shouldn't access mdio_bus_class directly.
So move both functions to the provider side. This is a step towards
making mdio_bus_class private to libphy.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c          | 44 -----------------------------
 drivers/net/phy/mdio_bus_provider.c | 44 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a30c679feec..c9a495390d2 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -276,50 +276,6 @@ const struct class mdio_bus_class = {
 };
 EXPORT_SYMBOL_GPL(mdio_bus_class);
 
-/**
- * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
- * @mdio_name: The name of a mdiobus.
- *
- * Return: a reference to the mii_bus, or NULL if none found. The
- * embedded struct device will have its reference count incremented,
- * and this must be put_deviced'ed once the bus is finished with.
- */
-struct mii_bus *mdio_find_bus(const char *mdio_name)
-{
-	struct device *d;
-
-	d = class_find_device_by_name(&mdio_bus_class, mdio_name);
-	return d ? to_mii_bus(d) : NULL;
-}
-EXPORT_SYMBOL(mdio_find_bus);
-
-#if IS_ENABLED(CONFIG_OF_MDIO)
-/**
- * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
- * @mdio_bus_np: Pointer to the mii_bus.
- *
- * Return: a reference to the mii_bus, or NULL if none found. The
- * embedded struct device will have its reference count incremented,
- * and this must be put once the bus is finished with.
- *
- * Because the association of a device_node and mii_bus is made via
- * of_mdiobus_register(), the mii_bus cannot be found before it is
- * registered with of_mdiobus_register().
- *
- */
-struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
-{
-	struct device *d;
-
-	if (!mdio_bus_np)
-		return NULL;
-
-	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
-	return d ? to_mii_bus(d) : NULL;
-}
-EXPORT_SYMBOL(of_mdio_find_bus);
-#endif
-
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
 	preempt_disable();
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 4b063740574..d50fe6eb4b0 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -440,3 +440,47 @@ void mdiobus_free(struct mii_bus *bus)
 	put_device(&bus->dev);
 }
 EXPORT_SYMBOL(mdiobus_free);
+
+/**
+ * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
+ * @mdio_name: The name of a mdiobus.
+ *
+ * Return: a reference to the mii_bus, or NULL if none found. The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put_deviced'ed once the bus is finished with.
+ */
+struct mii_bus *mdio_find_bus(const char *mdio_name)
+{
+	struct device *d;
+
+	d = class_find_device_by_name(&mdio_bus_class, mdio_name);
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(mdio_find_bus);
+
+#if IS_ENABLED(CONFIG_OF_MDIO)
+/**
+ * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
+ * @mdio_bus_np: Pointer to the mii_bus.
+ *
+ * Return: a reference to the mii_bus, or NULL if none found. The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put once the bus is finished with.
+ *
+ * Because the association of a device_node and mii_bus is made via
+ * of_mdiobus_register(), the mii_bus cannot be found before it is
+ * registered with of_mdiobus_register().
+ *
+ */
+struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
+{
+	struct device *d;
+
+	if (!mdio_bus_np)
+		return NULL;
+
+	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(of_mdio_find_bus);
+#endif
-- 
2.53.0



