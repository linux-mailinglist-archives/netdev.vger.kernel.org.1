Return-Path: <netdev+bounces-62204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499E8261ED
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A69C282F58
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4690101D3;
	Sat,  6 Jan 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHcm4DXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C857101CA
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28d61ba65eso68136266b.3
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579748; x=1705184548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pYrH4YoFwQSChSTktQgJeic7UyFCxwFxzIQ+cNAXc30=;
        b=cHcm4DXtD8jhNRXRDjzlkjd3YJP1dGNvgh0FeeC2QBkwPLPlc71bKsTn8OUnGyiaqr
         awQPqb7ZF+o7yaVdb7Mp2uOcFtqWpSKDCj9lWN7B7lGgM228kqc2CM284DGDU+hICf7z
         jrPQym0M1a7XQtMzx0vApsBhmswihrE+BGetwc1taj1MG/qhSpBtwagtguL8y620FW1K
         +ymeBPI/+IgMBMt2ZgwozBqn80Vy/zCFKKf+AMuqZunnv13aNSS8FZhD1NhO4wfnR2Vb
         CMT2cp0YmPUz7f8GH6haCnCFGavn2eo/WD8Ns0aaMHIzCuqYul345GboH13ytYx89EU/
         HbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579748; x=1705184548;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYrH4YoFwQSChSTktQgJeic7UyFCxwFxzIQ+cNAXc30=;
        b=f7QH8z9+tjoA2x5vEinAogBAouhsdj/zJ2UQF+P23Bzr2Jb5L93ux9DJ2p2ONCMODQ
         GNijSftA44gZZJ/RX2rEEQHbtHV7nbIKMuOWNNoSFOAQ7t261DO746fyv9OckzN2awe5
         uPU/DS8YfnIywtQeVR50yI0sXH0mxE7evdc8es3MhAXCuDSvrHejzIobJrs+p/O5nQRM
         0pJTN39ey/8S3RW91a595KLN7t2O/fVG0PyE4wTJVLDvms8U4NfTGWUavh1t7uDGDXCT
         22licqPxokX4hvXDLAMn/WD7CAOFxrtNGYTn7pi9L4uPSnsGf4uccZ6/chmy4GxhTJ82
         ya8Q==
X-Gm-Message-State: AOJu0Yz1ZnAuwxvxyfOGnNhAMDEntwf1j12RGkh/CbCZWEqM1nhVF8v2
	Yqv5udKaDhM9cOOH+U3Y4y8=
X-Google-Smtp-Source: AGHT+IFzu+X6SHxWX1Sr0WQPdnUqH7QYG3iUJeSL0Tbo3jFRksy1OBiEUkIgmJTlSY9L7TSdyfcA5g==
X-Received: by 2002:a17:906:1ce:b0:a2a:360e:f79 with SMTP id 14-20020a17090601ce00b00a2a360e0f79mr110364ejj.81.1704579748380;
        Sat, 06 Jan 2024 14:22:28 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id x17-20020a170906297100b00a26e4986df8sm2380056ejd.58.2024.01.06.14.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:22:28 -0800 (PST)
Message-ID: <aed2d656-e545-412c-bd26-6eb7f5b1e101@gmail.com>
Date: Sat, 6 Jan 2024 23:22:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 RFC 5/5] net: phy: c45: change
 genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
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

Change genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index adee5e712..cc05b59b8 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1453,7 +1453,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
-	bool overflow = false, is_enabled;
+	bool is_enabled;
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, adv, lp, &is_enabled);
@@ -1462,17 +1462,9 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 
 	data->eee_enabled = is_enabled;
 	data->eee_active = ret;
-
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->supported,
-						     phydev->supported_eee))
-		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->advertised, adv))
-		overflow = true;
-	if (!ethtool_convert_link_mode_to_legacy_u32(&data->lp_advertised, lp))
-		overflow = true;
-
-	if (overflow)
-		phydev_warn(phydev, "Not all supported or advertised EEE link modes were passed to the user space\n");
+	linkmode_copy(data->link_modes.supported, phydev->supported_eee);
+	linkmode_copy(data->link_modes.advertising, adv);
+	linkmode_copy(data->link_modes.lp_advertising, lp);
 
 	return 0;
 }
@@ -1495,24 +1487,22 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	int ret;
 
 	if (data->eee_enabled) {
-		if (data->advertised) {
-			__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
+		unsigned long *adv = data->link_modes.advertising;
 
-			ethtool_convert_legacy_u32_to_link_mode(adv,
-								data->advertised);
-			linkmode_andnot(adv, adv, phydev->supported_eee);
-			if (!linkmode_empty(adv)) {
+		if (!linkmode_empty(adv)) {
+			__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
+			bool unsupp;
+
+			unsupp = linkmode_andnot(tmp, adv, phydev->supported_eee);
+			if (unsupp) {
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
-
-			ethtool_convert_legacy_u32_to_link_mode(phydev->advertising_eee,
-								data->advertised);
 		} else {
-			linkmode_copy(phydev->advertising_eee,
-				      phydev->supported_eee);
+			adv = phydev->supported_eee;
 		}
 
+		linkmode_copy(phydev->advertising_eee, adv);
 		phydev->eee_enabled = true;
 	} else {
 		phydev->eee_enabled = false;
-- 
2.43.0



