Return-Path: <netdev+bounces-60756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214882156C
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84F72819FF
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50409DF66;
	Mon,  1 Jan 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrqiiFVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FDDF67
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a277339dcf4so307399666b.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704144408; x=1704749208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSGlwBuvtrMC+28h+C3evEt23+rLsKA1EKgBlxOw7gg=;
        b=DrqiiFVq7t1tz4KDZMFSNQ1ovJJifKSLMTAbqIbpM9kOaL74kwbyvuktjfe++84zqU
         cWlF1TNLg3Zh37At+xh+KVJXDbR3pYO7xFiR+iSvGAfvuluOkTamyKEiZovuzFxzEedu
         iVdX0ZICo0eX52YknYnfYgSm+U1ZavuGA3NRQHvY2krY4Kv3zJwT28zBCpqiwWxRzqxz
         Ncg661HDJVQUeQPjFma14v+82WLpuS9XGilHC6uyirOPyfySa7CjMqaKjtS5wc6RspBP
         Zd2EJECPyzq482PB6XnTOKNQ3Uyi/MAemhTRr3KFhv98qEIuqH8lNGVNPHsYBJQSYLLb
         o9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704144408; x=1704749208;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSGlwBuvtrMC+28h+C3evEt23+rLsKA1EKgBlxOw7gg=;
        b=VK168eiraYZ+04SK8uvY86sOIrEJKMhIlDuAuOYllbJvc9pvELhuSJ1rP++6sg0mAj
         AFTOK2E68IFqR7uHesuNkJyGT7Uu4z0kClW6JxMrDjd449qN7R+1b6pL0gxj040q1Yau
         jKeGeQEIfGxY8xFskRlryDDptM4D9qZ/xVWcBIvS15MdMCHLOz5/mc8s8Gc6PvKI5SGY
         JFOGv+hTk8DF9sXD894c0U6bDg6dBtQ+B9Mh7MU+n1Ch6RgimPQdITkHTbtNnYLWJV4W
         c1KrqZX7ACESCyJFZAcO5rmpuPKMqH16hKiJd1mj6nh8TWQ5dfrt6XilTSDIjFDM8yuU
         lfwA==
X-Gm-Message-State: AOJu0Yy94um9pb6IRHifzXRylVT27T8XBGbPM0SW4OozGUMcvv27/wJm
	ATmXQgykqHYNjegohYjTL/A=
X-Google-Smtp-Source: AGHT+IHHi14nHLylYsoVrBmoaZ5Tfo8v3QEDJow93pjLf6tMs7en0YDyRAphweJaYE2TYZA3U/yNIw==
X-Received: by 2002:a17:907:9055:b0:a27:a34e:bc9 with SMTP id az21-20020a170907905500b00a27a34e0bc9mr1104883ejc.30.1704144407654;
        Mon, 01 Jan 2024 13:26:47 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1? (dynamic-2a01-0c22-6e6b-b000-65c3-c8c0-cae3-f9e1.c22.pool.telefonica.de. [2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1])
        by smtp.googlemail.com with ESMTPSA id fv14-20020a170907508e00b00a269f8e8869sm11159750ejc.128.2024.01.01.13.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 13:26:47 -0800 (PST)
Message-ID: <ccd1dc6a-5dc8-46de-a881-ebd2eda6dcee@gmail.com>
Date: Mon, 1 Jan 2024 22:26:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/5] net: phy: c45: prepare
 genphy_c45_ethtool_set_eee for follow-up extension
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This prepares genphy_c45_ethtool_set_eee() for functional changes in a
follow-up patch. No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf1..9d8b2b5eb 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1492,32 +1492,31 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_eee *data)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
+	bool unsupported;
 	int ret;
 
-	if (data->eee_enabled) {
-		if (data->advertised) {
-			__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
-
-			ethtool_convert_legacy_u32_to_link_mode(adv,
-								data->advertised);
-			linkmode_andnot(adv, adv, phydev->supported_eee);
-			if (!linkmode_empty(adv)) {
-				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
-				return -EINVAL;
-			}
-
-			ethtool_convert_legacy_u32_to_link_mode(phydev->advertising_eee,
-								data->advertised);
-		} else {
-			linkmode_copy(phydev->advertising_eee,
-				      phydev->supported_eee);
-		}
+	phydev->eee_enabled = data->eee_enabled;
+	if (!data->eee_enabled)
+		goto eee_aneg;
 
-		phydev->eee_enabled = true;
-	} else {
-		phydev->eee_enabled = false;
+	ethtool_convert_legacy_u32_to_link_mode(adv, data->advertised);
+
+	if (linkmode_empty(adv)) {
+		linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+		goto eee_aneg;
 	}
 
+	unsupported = linkmode_andnot(tmp, adv, phydev->supported_eee);
+	if (unsupported) {
+		phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
+		return -EINVAL;
+	}
+
+	linkmode_copy(phydev->advertising_eee, adv);
+
+eee_aneg:
 	ret = genphy_c45_an_config_eee_aneg(phydev);
 	if (ret < 0)
 		return ret;
-- 
2.43.0



