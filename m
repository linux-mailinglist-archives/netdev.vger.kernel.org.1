Return-Path: <netdev+bounces-261985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJxTLAwWommizAQAu9opvQ
	(envelope-from <netdev+bounces-261985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 161581BE83F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE84319D018
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616B4779B4;
	Fri, 27 Feb 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIo2wWph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1558361648
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229923; cv=none; b=iFANJrXTPdH1BAyfqWoGqNX4A0JpKzgMVlXEyBDHxvrpvUGyIZQUvGUaurldspol/znulSZgaTAYGktRtVt1khBUIPaH4V23fyZCCj+g7Ru0m34M/BjTrla4Wzi7Ab/eu2/eo+5oMiS7/AwuyW341J3qIHYlitAYxDsIPYnRsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229923; c=relaxed/simple;
	bh=HiZSP5TgM5leRDu29xBAJPb8j6cMdZuoo57F/G9IURY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JN2S4RgqqxS7POBEpk/f7txv6kwKfduLlqY+lNTG6WczWPRoVTWefdQUH9g3n855ejYKRNiPi6CAZk7Zyum9QWQXg4UdIEZ0INv2EDZJxnCgEoEhJ7U71rWY6xY1pClml+k+q0X5d01yzuM7NOxLKECw2voC8S0q1qWMaVDTprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIo2wWph; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371bb515eso35465685e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772229920; x=1772834720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsLDu8oBR7ijWnJ05MT20Ei/JlKIta0nAR4ReJHJH+k=;
        b=mIo2wWphq9jLDKev5YGznT6Bf7GmQNeQ1ixvJODChhb3i5aE4Yf2SwotHRqpi3Ia83
         uMoWDEwCfAjXCwPXr3UD3d6nqT29FF7Q+8reZadu00vpbDbo9zn1aJ4f1YUXg+0CCot0
         V1F/klQ5HPvC4sJvegbyHsVNaTkvDlU50DjtRb0uUlgp5n/QmgwDMlE0QTPV7EUHlSh5
         Vm/7PITQzZzamfIFyf5zO5zreG6EXAqEaCjZIqiQOW1l4cJsU57PRpZGkMzFu3vPT0qT
         Hxknp9k/Biu5gGgrsrfV2mg8CwIrm95eZBjPvGhYjKKiOOoXSW/zGML3zUUPmmA3BARb
         +5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772229920; x=1772834720;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsLDu8oBR7ijWnJ05MT20Ei/JlKIta0nAR4ReJHJH+k=;
        b=ntn3rj4CQl9m+O0ywypMErWgGuBpF1ad5VM8ngyxkxb8uAwwIQVBh+Uoibbi9sQUHF
         ul8Gnx6QDe9N5vdIwmL5oTwocNaVAbbMhNwBagLMmSLXh3Bg/qrTUny7RLOwCtSsKh2o
         rzR0Sz06bbtFEH27OhktTbrpfb3NLwTWJ0IY1Nmg4CNWMFtazhEum06F5wRoOIP1nFee
         PX/OF+JHjhmMlfEDxInQTrwQQ2fS7KoEJwpa7VO/5pTI3qCqM6ApJBoFlkcJAyzViNZn
         ssD24lg8wooluKc0lPt97j7aY54VFVaCBSarqSlTIi7g6u1FgWD94l24JYFtTagJ2NUH
         Ch+g==
X-Gm-Message-State: AOJu0YyVH6/PR94bn0pi1ZZIDb4AVRBUXROJy5pqEL9rn7iArmhg8HgM
	9R/THJNhsGudWKmY/gRlOKvhsM+fNeUVKObA7ZWYoHzxnfwv5hCGYE3r
X-Gm-Gg: ATEYQzwzh2iJ4R2+DviXT8iZqoU2v4kKX52MRTlavf/pof+/PB8ZaYVBM9suv7xcYJZ
	6nUqz/Ve4rvpCesGYRo7BVzeyVlVGlVuATaeWp/sufQpOpDkjI9xF2iZ04ddrzRxLpeCBT6n7hb
	YzjPWg2oywugBrUhC5FBlRgWYfV2XXTjXoIHbK/y16hBw87w8VaZJlphefbhb3hrOgy42cB92Fq
	+R4r0bitJFuzr2DmlE7J1GX5XkpSyNquwg2KSXoQrSNrQC2Yyl1Z3vVIlsFWewBTUB1UQtHqAkm
	Zd6yXfiAl/9ykvrJs/28TkNBpFqL05ykt1ijxilXzoTydKJYrylWIWHbQmFtsmAPW5oJ888MWLz
	Qb6t/+d8yrA4dd9/cLPDuLN7HQXapqb1+ejm46xlylufFIbO2R0jgbpg6MBCP75pvYhoPZjtvHx
	WSB3ltnkQGo+35WAXAIjMg5E/k5iNAsa68QUtc9lZQDGNxiuOZDs3UMWY/99HDwnn2xFLSVkIqo
	IjTHqQnw/YhWQX+yVTbwfEOBPYTf8amRaK+NStpJiTcrTAsfX1UXE0taijY4gcCpg==
X-Received: by 2002:a05:600c:8b26:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-483c9bc1e0fmr70024685e9.14.1772229919795;
        Fri, 27 Feb 2026 14:05:19 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm268108925e9.13.2026.02.27.14.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:05:19 -0800 (PST)
Message-ID: <ce9f85d2-4f72-4b15-b868-210a8ced662d@gmail.com>
Date: Fri, 27 Feb 2026 23:05:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/8] net: mdio: extend struct mdio_bus_stat_attr
 instead of using dev_ext_attribute
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261985-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 161581BE83F
X-Rspamd-Action: no action

Currently the var member of struct dev_ext_attribute is used in a very
ugly way. Extend struct mdio_bus_stat_attr instead, what allows to
simplify the code and also slightly reduces memory footprint.

Note: Member addr is renamed to avoid a conflict in macro
      MDIO_BUS_STATS_ADDR_ATTR_DECL.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 45 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afdf1ad6c0e..4fe9859369b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -124,10 +124,16 @@ static void mdiobus_release(struct device *d)
 }
 
 struct mdio_bus_stat_attr {
-	int addr;
+	struct device_attribute attr;
+	int address;
 	unsigned int field_offset;
 };
 
+static struct mdio_bus_stat_attr *to_sattr(struct device_attribute *attr)
+{
+	return container_of(attr, struct mdio_bus_stat_attr, attr);
+}
+
 static u64 mdio_bus_get_stat(struct mdio_bus_stats *s, unsigned int offset)
 {
 	const char *p = (const char *)s + offset;
@@ -157,18 +163,14 @@ static ssize_t mdio_bus_stat_field_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
+	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
 	struct mii_bus *bus = to_mii_bus(dev);
-	struct mdio_bus_stat_attr *sattr;
-	struct dev_ext_attribute *eattr;
 	u64 val;
 
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	sattr = eattr->var;
-
-	if (sattr->addr < 0)
+	if (sattr->address < 0)
 		val = mdio_bus_get_global_stat(bus, sattr->field_offset);
 	else
-		val = mdio_bus_get_stat(&bus->stats[sattr->addr],
+		val = mdio_bus_get_stat(&bus->stats[sattr->address],
 					sattr->field_offset);
 
 	return sysfs_emit(buf, "%llu\n", val);
@@ -178,37 +180,31 @@ static ssize_t mdio_bus_device_stat_field_show(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
 {
+	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
 	struct mdio_device *mdiodev = to_mdio_device(dev);
 	struct mii_bus *bus = mdiodev->bus;
-	struct mdio_bus_stat_attr *sattr;
-	struct dev_ext_attribute *eattr;
 	int addr = mdiodev->addr;
 	u64 val;
 
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	sattr = eattr->var;
-
 	val = mdio_bus_get_stat(&bus->stats[addr], sattr->field_offset);
 
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
 #define MDIO_BUS_STATS_ATTR_DECL(field, file)				\
-static struct dev_ext_attribute dev_attr_mdio_bus_##field = {		\
+static struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {		\
 	.attr = { .attr = { .name = file, .mode = 0444 },		\
 		     .show = mdio_bus_stat_field_show,			\
 	},								\
-	.var = &((struct mdio_bus_stat_attr) {				\
-		-1, offsetof(struct mdio_bus_stats, field)		\
-	}),								\
+	.address = -1,							\
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 };									\
-static struct dev_ext_attribute dev_attr_mdio_bus_device_##field = {	\
+static struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = {	\
 	.attr = { .attr = { .name = file, .mode = 0444 },		\
 		     .show = mdio_bus_device_stat_field_show,		\
 	},								\
-	.var = &((struct mdio_bus_stat_attr) {				\
-		-1, offsetof(struct mdio_bus_stats, field)		\
-	}),								\
+	.address = -1,							\
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 };
 
 #define MDIO_BUS_STATS_ATTR(field)					\
@@ -220,13 +216,12 @@ MDIO_BUS_STATS_ATTR(writes);
 MDIO_BUS_STATS_ATTR(reads);
 
 #define MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr, file)		\
-static struct dev_ext_attribute dev_attr_mdio_bus_addr_##field##_##addr = { \
+static struct mdio_bus_stat_attr dev_attr_mdio_bus_addr_##field##_##addr = { \
 	.attr = { .attr = { .name = file, .mode = 0444 },		\
 		     .show = mdio_bus_stat_field_show,			\
 	},								\
-	.var = &((struct mdio_bus_stat_attr) {				\
-		addr, offsetof(struct mdio_bus_stats, field)		\
-	}),								\
+	.address = addr,						\
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 }
 
 #define MDIO_BUS_STATS_ADDR_ATTR(field, addr)				\
-- 
2.53.0



