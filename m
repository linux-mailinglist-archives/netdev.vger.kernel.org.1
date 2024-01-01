Return-Path: <netdev+bounces-60757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225D821571
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC414B20EDD
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD6DF6B;
	Mon,  1 Jan 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCa0FwhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EFDF67
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3367601a301so8660531f8f.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704144531; x=1704749331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+bs5iw9ua7ugcupU/KFKirwYtrB9hC/jPn0yX/maV78=;
        b=hCa0FwhAGZUhOdSPN0yND5Ckg76v0gvSZQZHmf8WfAmP+3SMcrFDAfHo7jv6WCe3uN
         K+9ePMcvgy7pULq1b0+msOi+Jll6Rhd5x3IAU4klfbyNcJhUfYthDhr8pm7YPoMtRiic
         lz8aQqGOjtIuIvakIQCMdXsHVV3K+LtOSsa3HTtfmq/rfD8De4OE2z92wak0ja7ZTFIK
         RMzkIwbJY9v23h1Becbmwoj33XjDv+Ahgax1KxPJHYBTqVPV2T3JiksBy9DssJscmawn
         t+tO5l2tw3Nldw3g4eWWnlgQ8O+YP5J4w2Zr5exVtwcvDd200TZ/Ri7fqpAIY0WalVp+
         cq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704144531; x=1704749331;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bs5iw9ua7ugcupU/KFKirwYtrB9hC/jPn0yX/maV78=;
        b=RLjVvIpQ88wl0b2zdEWsOuJqPN/V57dXyItZ9DZNtIsStjI3VaWg/WOZ56huCof5h+
         kRp9+kUpCfaaloQzcJjoFua/Qi77W/FE3V0Kbkgj/gVcnWdKLthQcnXt8d8yS1pH+mL5
         zG1oUqXq5ZS264V26o2YiZGumycUxh0M2CJsBS40LQSZ5jI2972PpacdhPktIuu43Lwk
         YMu54MdgZJpG60eIoB6yz2pxD/2KtfBG3zkdy618CNCPukQSE1dlzoL3vbiUmYFga5Dj
         ZIZVUGKcseV7Vn5x9C1hHOedGHPvfXfBVWJnnMfgoM7ZrxHtw6FywW+Jogm7n2NqXf9N
         KBpw==
X-Gm-Message-State: AOJu0YwIh/1QxX8BXlPzIwcdReKsgMe+kJiuhsQe4nvkIr2Yo/b16bbl
	tTOcZc0/DSwDaqHRt3HHU8Y=
X-Google-Smtp-Source: AGHT+IGFwLwDmV/9e+yFwEAozt/X7vVq9XfkJ0JRzNvgRmG8/n8lmrg8IkVd42QUjItTUo3nvf5sDA==
X-Received: by 2002:adf:dd89:0:b0:336:7431:62b8 with SMTP id x9-20020adfdd89000000b00336743162b8mr5461371wrl.120.1704144530664;
        Mon, 01 Jan 2024 13:28:50 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1? (dynamic-2a01-0c22-6e6b-b000-65c3-c8c0-cae3-f9e1.c22.pool.telefonica.de. [2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1])
        by smtp.googlemail.com with ESMTPSA id k3-20020aa7c043000000b00552eb1b1ed7sm15012188edo.16.2024.01.01.13.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 13:28:50 -0800 (PST)
Message-ID: <e7b66d99-e51b-4c8f-83da-99184e5f41ec@gmail.com>
Date: Mon, 1 Jan 2024 22:28:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/5] net: phy: c45: extend
 genphy_c45_ethtool_[set|get]_eee
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

Extend both functions to use the linkmode bitmap extension if available.

Note: The linkmode extension for now is supported only if ethtool uses
netlink. It's not supported for ioctl.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 9d8b2b5eb..e276dba19 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1454,6 +1454,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
 	bool overflow = false, is_enabled;
+	struct ethtool_keee *keee;
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, adv, lp, &is_enabled);
@@ -1463,6 +1464,16 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	data->eee_enabled = is_enabled;
 	data->eee_active = ret;
 
+	keee = ethtool_eee2keee(data);
+	if (keee) {
+		linkmode_copy(keee->link_modes.supported,
+			      phydev->supported_eee);
+		linkmode_copy(keee->link_modes.advertising, adv);
+		linkmode_copy(keee->link_modes.lp_advertising, lp);
+		keee->use_link_modes = 1;
+		return 0;
+	}
+
 	if (!ethtool_convert_link_mode_to_legacy_u32(&data->supported,
 						     phydev->supported_eee))
 		overflow = true;
@@ -1494,6 +1505,7 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
+	struct ethtool_keee *keee;
 	bool unsupported;
 	int ret;
 
@@ -1501,7 +1513,11 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	if (!data->eee_enabled)
 		goto eee_aneg;
 
-	ethtool_convert_legacy_u32_to_link_mode(adv, data->advertised);
+	keee = ethtool_eee2keee(data);
+	if (keee && keee->use_link_modes)
+		linkmode_copy(adv, keee->link_modes.advertising);
+	else
+		ethtool_convert_legacy_u32_to_link_mode(adv, data->advertised);
 
 	if (linkmode_empty(adv)) {
 		linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
-- 
2.43.0



