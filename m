Return-Path: <netdev+bounces-60941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B91821F09
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9F1C22064
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E212E7C;
	Tue,  2 Jan 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVEnZA4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9C14AAB
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555f95cc2e4so2612563a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704210892; x=1704815692; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u78lrSfDo4oO6bqKJIJky2OEN/IPWRifDg6Ux8AnNko=;
        b=WVEnZA4ZwSe23Czx2wb1oB1Reea2PvM6J6OZqMQoJ56pOllqjs4TxBM34n0MlsR+0E
         Yd3xn7UFyxC3giu7XMPkEFLWwkL5Om2IxhgfQDWIBH0lGCBvVk+nbsFZfVKWA+V5diPK
         uyiz1SM+F9AaPouJnX2HZJPTlbmjyiIbqgKmd72yt9qp2y0TU2S2Z7dpramP0DjVtHCb
         Ze9WA6lYVT8dlAF1Fp1XShTo+CkZZ9lyNS/ncrbWEh0LGbWUnYzyu8qj8hSSF04/f2Ff
         wUEN89/Ei5mNIP+z5qhN14apO11Kf+i7LZAcA+5ZYOEDHctI9HWjqKfRTUYMTJXoS1lu
         B4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210892; x=1704815692;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u78lrSfDo4oO6bqKJIJky2OEN/IPWRifDg6Ux8AnNko=;
        b=Oe/thMMVNJy4hMpqYYMFty2z6fYQ9tsNSoODAxGBt2+7yA4Bc9d6h0xfbb6M4g8A1d
         HisTM7oqRB+vf6tXBd67WLS8vv9Y/5r2dPTDD249ER+Ww0ILwSdAPPQ6YACVAu+uzEPr
         6gfDHVuXqTmUkqXG+dj2Bel21GrCYmx3FTZrtgUwv3O4DHo1X4NGtPc546b2XGm3xZoe
         Pg6gDelrT7AcrXYM6Td7r6t9GXHKUwlMSItbjjR0h2+Q3R8YkYUHt2+Ri+kTqNUhVn/k
         pkNwMemeftM4kCp+K4/0E+IzwBUkAw+svg+vN75SkEKfQ20lz/GZnufZDNQZvKs8D1vl
         DrVA==
X-Gm-Message-State: AOJu0YyHz/znywGh3Bg0FoRDTQD2CuUz82PJUadq+p9YpPOYmHbhs219
	Rq4JQzNs0/Q9CgJnF/IBRelXOFsCYhw=
X-Google-Smtp-Source: AGHT+IGeTjd6KNAr2clYj8G+uUOE7r5s490tYc13D0MCL+1OEQFn+2bbJjiIiYdzOkFelaPnyM6ywQ==
X-Received: by 2002:a50:d5cc:0:b0:54c:4837:81e0 with SMTP id g12-20020a50d5cc000000b0054c483781e0mr10571707edj.49.1704210891778;
        Tue, 02 Jan 2024 07:54:51 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c? (dynamic-2a01-0c23-c1df-9400-2dfa-6a98-a1f2-c23c.c23.pool.telefonica.de. [2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c])
        by smtp.googlemail.com with ESMTPSA id q24-20020a056402249800b0055668ccd9a3sm2014462eda.17.2024.01.02.07.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:54:51 -0800 (PST)
Message-ID: <42e0d1c5-fdd2-4347-874d-2dab736abbdc@gmail.com>
Date: Tue, 2 Jan 2024 16:54:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: mdio_bus: make check in
 mdiobus_prevent_c45_scan more granular
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Matching on OUI level is a quite big hammer. So let's make matching
more granular.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6cf73c156..fe4136649 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -621,19 +621,25 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  */
 static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 {
-	int i;
+	static const struct mdio_device_id id_list[] = {
+		{ MICREL_OUI << 10, GENMASK(31, 10) },
+	};
+	int i, j;
 
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		struct phy_device *phydev;
-		u32 oui;
 
 		phydev = mdiobus_get_phy(bus, i);
 		if (!phydev)
 			continue;
-		oui = phydev->phy_id >> 10;
 
-		if (oui == MICREL_OUI)
-			return true;
+		for (j = 0; j < ARRAY_SIZE(id_list); j++) {
+			const struct mdio_device_id *id = id_list + j;
+
+			if (phy_id_compare(phydev->phy_id, id->phy_id,
+					   id->phy_id_mask))
+				return true;
+		}
 	}
 	return false;
 }
-- 
2.43.0


