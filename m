Return-Path: <netdev+bounces-62203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525688261EC
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BC6282113
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C81F9F8;
	Sat,  6 Jan 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJF6CxW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C431101C6
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28ee72913aso295791766b.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579691; x=1705184491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swRgVoWBBqUZvweF3dM0eOjVrJCq4CjyxwVsMrFt/T0=;
        b=kJF6CxW/D/TFuXUFOQZEIw4T36onI2l7LfT2+BypNhejTR1S2RH1Mb8dcD/R3x/xg6
         alOfuMEUxMrITUO+tl86d/49nsX1a9V1rqRL1BjppZIbWB2PMoon2knxzBlCknuHrEo4
         Xhh0O6s0WBquolXLrlYVPhhuBINL2EATzEQmqDhXqgm7oWqfNFS7nqliagQ1gsie+iIm
         zxyYrRprejVbmhGgbLJ9l7sY7/RxAsBa8tbYmpndrvIvspAco+EQ+M+2B2yr+kR8We6n
         yuEA61uD1h0pbyxemlAiRA2barYAzczRuGmyEOJ5k9npNsGlwZzXN629/pTEWdXUET22
         5uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579691; x=1705184491;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swRgVoWBBqUZvweF3dM0eOjVrJCq4CjyxwVsMrFt/T0=;
        b=U0Cwvd2lTwh6Q3dFB4WdCJ0FVaAEO7ycm4yN2qMXk6396SEI5C+EGYCYHGIQnwPsU/
         6wc79KdtISOYve+xd17DvsZ+RvHTal2DeURPUtcJ06MGWiJmS80LDjkW+18eiUs9AXG6
         NU8DPOqVXYOk1IzTxxllG40vjRqc40r9AdkVg3sD+g8SvDaxsvxsLnWGJGrKJbF5lv2D
         G503YVk8fn7QGREB79kFrQljKHPhJJrgdCvGExyYTn1GFM2DnA+ihB9/SAv6C4uur0gP
         YeiHy4kzuHW5k0EbHrOVxTGasl9I8D0HLX5eUDdZGziQCr1z0RBAT9NUeFbZ0VhhPRF+
         T0dQ==
X-Gm-Message-State: AOJu0YzNLSM+56l/oSkKZebeLRWDg/gvGuJOZ25YBqW8GuMFMsnSGcQc
	6kVf1gNuFEj6vMIGvUcj3zw=
X-Google-Smtp-Source: AGHT+IEDDSb+ETlMEKts2joxItzKqazi5Y4eqKNIyB/b7nb8NiUmSV8iSfYs22a42WaH4/vyKL6XOQ==
X-Received: by 2002:a17:906:304f:b0:a23:62fd:e2f6 with SMTP id d15-20020a170906304f00b00a2362fde2f6mr1405662ejd.30.1704579691354;
        Sat, 06 Jan 2024 14:21:31 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id x17-20020a170906297100b00a26e4986df8sm2380056ejd.58.2024.01.06.14.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:21:31 -0800 (PST)
Message-ID: <87a063ed-1b06-40b4-9c12-37658f36ea06@gmail.com>
Date: Sat, 6 Jan 2024 23:21:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 RFC 4/5] ethtool: add linkmode bitmap support to struct
 ethtool_keee
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add linkmode bitmap members to struct ethtool_keee, but keep the legacy
u32 bitmaps for compatibility with existing drivers.
Use link_modes.supported not being empty as indicator that a user wants
to use the linkmode bitmap members instead of the legacy bitmaps.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h |  5 ++++
 net/ethtool/common.c    |  5 ++++
 net/ethtool/common.h    |  1 +
 net/ethtool/eee.c       | 51 ++++++++++++++++++++++++++++++-----------
 net/ethtool/ioctl.c     | 28 +++++++++++++++++++---
 5 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 25f82d23b..f46242033 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -223,6 +223,11 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
+	struct {
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
+	} link_modes;
 	u32	supported;
 	u32	advertised;
 	u32	lp_advertised;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dc..872849646 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -712,3 +712,8 @@ ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
 	}
 }
 EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
+
+bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee)
+{
+	return !linkmode_empty(eee->link_modes.supported);
+}
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9..0f2b5f7ea 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -55,5 +55,6 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 				   struct ethtool_eeprom *ee, u8 *data);
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
+bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee);
 
 #endif /* _ETHTOOL_COMMON_H */
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index fa7ee51b5..b2de845ca 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -30,6 +30,7 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct eee_reply_data *data = EEE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct ethtool_keee *eee = &data->eee;
 	int ret;
 
 	if (!dev->ethtool_ops->get_eee)
@@ -37,9 +38,18 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
-	ret = dev->ethtool_ops->get_eee(dev, &data->eee);
+	ret = dev->ethtool_ops->get_eee(dev, eee);
 	ethnl_ops_complete(dev);
 
+	if (!ret && !ethtool_eee_use_linkmodes(eee)) {
+		ethtool_convert_legacy_u32_to_link_mode(eee->link_modes.supported,
+							eee->supported);
+		ethtool_convert_legacy_u32_to_link_mode(eee->link_modes.advertising,
+							eee->advertised);
+		ethtool_convert_legacy_u32_to_link_mode(eee->link_modes.lp_advertising,
+							eee->lp_advertised);
+	}
+
 	return ret;
 }
 
@@ -58,14 +68,17 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 		     EEE_MODES_COUNT);
 
 	/* MODES_OURS */
-	ret = ethnl_bitset32_size(&eee->advertised, &eee->supported,
-				  EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_bitset_size(eee->link_modes.advertising,
+				eee->link_modes.supported,
+				__ETHTOOL_LINK_MODE_MASK_NBITS,
+				link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	len += ret;
 	/* MODES_PEERS */
-	ret = ethnl_bitset32_size(&eee->lp_advertised, NULL,
-				  EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_bitset_size(eee->link_modes.lp_advertising, NULL,
+				__ETHTOOL_LINK_MODE_MASK_NBITS,
+				link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 	len += ret;
@@ -87,14 +100,17 @@ static int eee_fill_reply(struct sk_buff *skb,
 	const struct ethtool_keee *eee = &data->eee;
 	int ret;
 
-	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_OURS,
-				 &eee->advertised, &eee->supported,
-				 EEE_MODES_COUNT, link_mode_names, compact);
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_EEE_MODES_OURS,
+			       eee->link_modes.advertising,
+			       eee->link_modes.supported,
+			       __ETHTOOL_LINK_MODE_MASK_NBITS,
+			       link_mode_names, compact);
 	if (ret < 0)
 		return ret;
-	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_PEER,
-				 &eee->lp_advertised, NULL, EEE_MODES_COUNT,
-				 link_mode_names, compact);
+	ret = ethnl_put_bitset(skb, ETHTOOL_A_EEE_MODES_PEER,
+			       eee->link_modes.lp_advertising, NULL,
+			       __ETHTOOL_LINK_MODE_MASK_NBITS,
+			       link_mode_names, compact);
 	if (ret < 0)
 		return ret;
 
@@ -140,9 +156,16 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = ethnl_update_bitset32(&eee.advertised, EEE_MODES_COUNT,
-				    tb[ETHTOOL_A_EEE_MODES_OURS],
-				    link_mode_names, info->extack, &mod);
+	if (ethtool_eee_use_linkmodes(&eee)) {
+		ret = ethnl_update_bitset(eee.link_modes.advertising,
+					  __ETHTOOL_LINK_MODE_MASK_NBITS,
+					  tb[ETHTOOL_A_EEE_MODES_OURS],
+					  link_mode_names, info->extack, &mod);
+	} else {
+		ret = ethnl_update_bitset32(&eee.advertised, EEE_MODES_COUNT,
+					    tb[ETHTOOL_A_EEE_MODES_OURS],
+					    link_mode_names, info->extack, &mod);
+	}
 	if (ret < 0)
 		return ret;
 	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9222fbeeb..0df3f183b 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1517,6 +1517,13 @@ static void eee_to_keee(struct ethtool_keee *keee,
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
 	keee->tx_lpi_timer = eee->tx_lpi_timer;
+
+	ethtool_convert_legacy_u32_to_link_mode(keee->link_modes.supported,
+						eee->supported);
+	ethtool_convert_legacy_u32_to_link_mode(keee->link_modes.advertising,
+						eee->advertised);
+	ethtool_convert_legacy_u32_to_link_mode(keee->link_modes.lp_advertising,
+						eee->lp_advertised);
 }
 
 static void keee_to_eee(struct ethtool_eee *eee,
@@ -1524,13 +1531,28 @@ static void keee_to_eee(struct ethtool_eee *eee,
 {
 	memset(eee, 0, sizeof(*eee));
 
-	eee->supported = keee->supported;
-	eee->advertised = keee->advertised;
-	eee->lp_advertised = keee->lp_advertised;
 	eee->eee_active = keee->eee_active;
 	eee->eee_enabled = keee->eee_enabled;
 	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
 	eee->tx_lpi_timer = keee->tx_lpi_timer;
+
+	if (ethtool_eee_use_linkmodes(keee)) {
+		bool overflow;
+
+		overflow = !ethtool_convert_link_mode_to_legacy_u32(
+				&eee->supported,
+				keee->link_modes.supported);
+		ethtool_convert_link_mode_to_legacy_u32(&eee->advertised,
+				keee->link_modes.advertising);
+		ethtool_convert_link_mode_to_legacy_u32(&eee->lp_advertised,
+				keee->link_modes.lp_advertising);
+		if (overflow)
+			pr_warn("Ethtool ioctl interface doesn't support passing EEE linkmodes beyond bit 32\n");
+	} else {
+		eee->supported = keee->supported;
+		eee->advertised = keee->advertised;
+		eee->lp_advertised = keee->lp_advertised;
+	}
 }
 
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
-- 
2.43.0



