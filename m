Return-Path: <netdev+bounces-174741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DCA60188
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F2419C3A90
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6013C67C;
	Thu, 13 Mar 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYcjbsYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814BEADA;
	Thu, 13 Mar 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895137; cv=none; b=fiDG/Bg5l3ts+gLB5S5rFh+zinbZPsXcYjdXBFnyHI9JdIjcM6gHjEqTVvpNa5+gap/fyb2W0tMD/DSQ6cXkrcphdJjHXoECdnhF24AWlAr7w2nPnnR+GY+ujUBNtSD3S2y3QpxiG38HedgZyUlmk45yIxSKGPResogHyY9mjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895137; c=relaxed/simple;
	bh=J7OISf55ymp3VbBZFNmebeN8OELoSjOnxuiWjAisj2A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dg0P6hXJKohJzm7Kr4MfH7kfMVLFfnia9Vq0X8of/Um4irSZNWTbQQu+lYJ77LC2wSOY1WmUOQCamff9MPmVg9SXRPQ+Kc9BK2Nv+KU8FNXl41eE7b4y7mrHdhWWACbdLJGzIobCmbIra2lV++dtKY2CXhEfUPs5jRWXmjcrtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYcjbsYy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso894366f8f.2;
        Thu, 13 Mar 2025 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895134; x=1742499934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OP6noarsgSs4foxZ/hctMad7052FWZetCEdUR8ODDsI=;
        b=eYcjbsYy8i9gz3Vmch9BqbnbNQnGL+V0uFbw2No1zcW+AlKs5Vp27DK4CfXfR+V1+X
         gDSqWq7Jujb5eyOb8vxUcMDpcVQeH8UB1PaWmzDJV7HSg+/EHM6XsurC0bduBSjASP/o
         gaqKTz/htJBWj00nuiAtc6fybrbeURQVrlaT4x0drK32dWtuD2CiZO8AuxBaofmlwBEi
         vLjAMT67eemCu0unc00o5QDPLWDLZZu9IVPWMJwpewKmMioEBBIxrddJvYvb5yTWjVQM
         l+YMx3Qq3lv0HWGC2Iqd5hRDEKzE3TH3sJ8XpLgJLPlBB7v6jmvXFjctLa2upjj76ES6
         w35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895134; x=1742499934;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OP6noarsgSs4foxZ/hctMad7052FWZetCEdUR8ODDsI=;
        b=OTLWTOgE+YzQYS/waHd4OAJ4oNLcbDh4ZN+9X3EcFO3oTNla0p2Ra7mxMXM9fIqphj
         I9w8ZtwwcWrGRRpjbwZFLlQShi9s3/TnboXS4fvT7InjJONlBtm7nvODr7qnIXMbe2ea
         YOYb/QtirRRfMQngDK4F/KXFpMflpfXhhLczIa2rhUoYcg1HrA9sKqocUgUitEsR2AUo
         YIB1UpL8XtqlRkDvWF+Kojc2mBFueHHmYbPJ0EXu0wYgqJ3Rrfh8hoO2Vhk8x2THkqU7
         jh0ghdmcSGNaudfw1hgwGCCZsWsuVVeq0E0fd34hYarwZwguFB+XwAq3DiczGQsNoxPC
         fX3g==
X-Forwarded-Encrypted: i=1; AJvYcCVBhzJgsSdweX+/iAgcidt7x4j+yNQLegWXQM7N0yQp9P7OwnFZ4CdoEte5KNVIDdSM8WwtFSWP9m01jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzStpJG3Ck9QKVLzRFuc7ru5GWQ72Jz1+kQHGeeQxxdFHUxDK
	MnsfB70PVhkm1uidHbs+Lcx8aQ3FQI7obsqYtBrhHTmP6aIoltzV
X-Gm-Gg: ASbGncsvZW1vzju738IyLdGReIsUG1oyavGBLgbwRHEG9+fJZhE17asXia0Rlw+s8V9
	QRW8bwy+cBPnR0jo8hrsLTWR8lhbj9nNYroTUrCL0s1veNWCRNehixV1trQDz9/i9hEIKC+IsIK
	pO3AzjBSo3Xp5AOu2xeCE9qq5orxgvMJSOXIAVonuOxEUQi1XiqGHcdzPaykGHWNnk5vJM8/ElT
	9+PyubPgo8RgtEZ7JWQglKoh02pez/9TaF26jevaWeoH2ymY9rr2Mvho3GW35Ua5arqxaY55zj1
	7pOH6N9TPJtE56Agd18JOQtdh2AiABsSmFr/avsasKeFoDGQenRQUHIOAYKXJfnsd2aro69Kc8L
	FmE6QpmUa1vdrp+n6TuCzr5+wYr2gl+o40rdLtmhtIqhqhoWlu/OtuFtEexhlu9nTMV9Mw1KYXU
	Xr1+tWXdDU1UC2lxkc/T7YEAp+sF8GHmuw69Oh
X-Google-Smtp-Source: AGHT+IEKA2jCWg2C4Ojm+Cnc948/n1LHTav36l8pMJqSfmrevUhbC4c+EUAPBVXvpBtKXSQBWqljzg==
X-Received: by 2002:adf:b304:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-396c1c20be6mr734729f8f.25.1741895134055;
        Thu, 13 Mar 2025 12:45:34 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78? (dynamic-2a02-3100-9d92-6200-9d62-fd9a-43ed-7e78.310.pool.telefonica.de. [2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm3109775f8f.0.2025.03.13.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:45:33 -0700 (PDT)
Message-ID: <e34c4802-20ce-4556-a47c-812e602e8526@gmail.com>
Date: Thu, 13 Mar 2025 20:45:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/4] net: phy: mxl-gpy: remove call to
 devm_hwmon_sanitize_name
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Xu Liang <lxu@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
devm_hwmon_device_register_with_info") we can simply provide NULL
as name argument.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mxl-gpy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 94d9cb727..cc531cc92 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -225,14 +225,8 @@ static int gpy_hwmon_register(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon_dev;
-	char *hwmon_name;
 
-	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
-	if (IS_ERR(hwmon_name))
-		return PTR_ERR(hwmon_name);
-
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, hwmon_name,
-							 phydev,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
 							 &gpy_hwmon_chip_info,
 							 NULL);
 
-- 
2.48.1



