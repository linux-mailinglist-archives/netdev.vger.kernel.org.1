Return-Path: <netdev+bounces-156883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5526A082E5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818B8188B5AF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651212054FD;
	Thu,  9 Jan 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U18L/OHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A76205E26
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462597; cv=none; b=UJdAdCC6OmZEdNusRDHEqtrF4UzpKRS2BiBijCj9y1pOOK0cKZUDP1a6hCe2adWSY65iyyZIvSW2PZjt86EuqWSsdkoRP9fJm3BS7k6E0IsLVQ1u848Qm4HTSVfPHlvzK5oHZ3sXmYho9KWo5yLg152muO4jjOxzZzGnbrdBSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462597; c=relaxed/simple;
	bh=bR0kSl4Mnc0fO2OJozhUrdDqn2zkovBZnnQjWmFkdww=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OJPAS2gER2NDzKH+4pHVNuUNcY6jfJRPFcfbo/R6RNJxQGrsNDGDeSTOomItwRt+NUDzCZl8CBiESKqV/FPpaJMF76aKxKaEp13TykfiA7R8f6VZaJr0cKEL+3uYAHWHuNUwaLH2WmKnNMQHqbczdeEh0+5fLNGCfUjJt+FZ0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U18L/OHy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so2343998a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736462594; x=1737067394; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7wfV4Nc3nApY9WmtP5LVKfgC/xd7HERhtf6klRsldSc=;
        b=U18L/OHyrUGrbL60Zmd/OvkNq6nfs/jPW5dJrFoccYmBfxRVCj53nNhWcJv7qSfiaW
         aKZj6dTRIX7HwlWeFRudGF/4KRj6ur9AUsEscsUOKQe0i1aj0Lg1tsee6/NQ5I72Mk5I
         rHXfmIt1dEtkjT4LnLJsudu0in20kDcpNlZmQOoEX5PAA8VDbxR/jC5rjZIMZF3SWlvT
         oVjO0BLPL9sx+TGxQXxzc3OyEZ2EY4cXA3H5ITFB6nChrC+aSsuG3CESzrrmk2YtFDcr
         RTJ1GzgIXn9l6lpV3X5i4StxRQFiBYPPL5rQyIkJ7ROXZVnE+epXnr9JCvRgkHsLRXp/
         Qhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736462594; x=1737067394;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wfV4Nc3nApY9WmtP5LVKfgC/xd7HERhtf6klRsldSc=;
        b=JHQlanuLTbd0w0YRt2gW2KWAcNSAvGDLhs/JkcTd5/liGIY6XRegMNTmX0KC2TLHt2
         UezCOuhZgg+eUN8DzKehrsDYpdlVOMMU3r2N7yapZZ8XQ6z7bIunwqm0XImevEMbuSaV
         4b/iUOv6pROzG57dwdSGOmD4ZG7zcPjz+HsTKovVVQhtXOIs4qKlmFptGH72P3mwoPGO
         B97BTdAfbHQpvAPtEZergiQRPrHTnOmgcPP4odxVr2hN31IFEBNhcVtI6LM17Vf/JyMB
         HHt8p1K/u26SvF1IMZadxnHxmco/fZI6/uTDAD7FkCTy6tFa2snVLFQrHA0lVO7ieLpG
         Vb5A==
X-Gm-Message-State: AOJu0YxE4+3GqBPkJ8UlMDBgqRehFehmGDZfn5F+t+ejzD1/2+9yImOI
	vEzoCqLT9+TGW0l+I00oaTpFW/6kvH84GKsxRFMwwbHasFXO2cO0
X-Gm-Gg: ASbGncu0OkOeo5OKGuOO36igkZ6B8NSFZWju6du33WC0bZCmlSNOXpFIxlGQRNv57G/
	ah0lxiflYfzYel0DFWca/7p8yLY8kas5zYFpnmZfGL7YcblPjyW/P0/LqGZSv4xWd1X6poSn8J6
	4Lkt5AE0sZHRy/RGBJB2nHs0fWPgq/64RyKSv4RmCmN99XOOre52cqjRqjSCm3TFZ7QAJ20QTGC
	HblGqIchJGuVbDhxUllMJrmSA/SaCy2zcPg6LvZDnKYRbz9lEWME2uVppfUZrPQZ17KcRE/ia99
	AKG1z3sz8sT0yWGPhkzfqo6Qq3YCBFGp2zguZaiJ86nwnSxxQMmIZhsBCHruNT+iQP4HwKiBvYM
	rV5xwdAXJ0PNLDyyEuZ7pTq3vZ+Zx2xf3xYF8szQJ83oWqolo
X-Google-Smtp-Source: AGHT+IF7ywO+WYRryBgSA8se1VtML1S8BKr3HN/asYhWwB0poolMDmkxfi2nTuIHAifl7roCFlNqZQ==
X-Received: by 2002:a05:6402:2105:b0:5d3:d7b0:b834 with SMTP id 4fb4d7f45d1cf-5d972df67ecmr6905871a12.1.1736462593601;
        Thu, 09 Jan 2025 14:43:13 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac5c:5700:44f4:3326:ed45:6e1e? (dynamic-2a02-3100-ac5c-5700-44f4-3326-ed45-6e1e.310.pool.telefonica.de. [2a02:3100:ac5c:5700:44f4:3326:ed45:6e1e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4cf8sm966243a12.79.2025.01.09.14.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 14:43:12 -0800 (PST)
Message-ID: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
Date: Thu, 9 Jan 2025 23:43:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net] r8169: remove redundant hwmon support
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The temperature sensor is actually part of the integrated PHY and available
also on the standalone versions of the PHY. Therefore hwmon support will
be added to the Realtek PHY driver and can be removed here.

Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebase patch on net
---
 drivers/net/ethernet/realtek/r8169_main.c | 44 -----------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 739707a7b..8a3959bb2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -16,7 +16,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
-#include <linux/hwmon.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
@@ -5347,43 +5346,6 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
-static umode_t r8169_hwmon_is_visible(const void *drvdata,
-				      enum hwmon_sensor_types type,
-				      u32 attr, int channel)
-{
-	return 0444;
-}
-
-static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-			    u32 attr, int channel, long *val)
-{
-	struct rtl8169_private *tp = dev_get_drvdata(dev);
-	int val_raw;
-
-	val_raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
-	if (val_raw >= 512)
-		val_raw -= 1024;
-
-	*val = 1000 * val_raw / 2;
-
-	return 0;
-}
-
-static const struct hwmon_ops r8169_hwmon_ops = {
-	.is_visible =  r8169_hwmon_is_visible,
-	.read = r8169_hwmon_read,
-};
-
-static const struct hwmon_channel_info * const r8169_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
-	NULL
-};
-
-static const struct hwmon_chip_info r8169_hwmon_chip_info = {
-	.ops = &r8169_hwmon_ops,
-	.info = r8169_hwmon_info,
-};
-
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct rtl8169_private *tp;
@@ -5563,12 +5525,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	/* The temperature sensor is available from RTl8125B */
-	if (IS_REACHABLE(CONFIG_HWMON) && tp->mac_version >= RTL_GIGA_MAC_VER_63)
-		/* ignore errors */
-		devm_hwmon_device_register_with_info(&pdev->dev, "nic_temp", tp,
-						     &r8169_hwmon_chip_info,
-						     NULL);
 	rc = register_netdev(dev);
 	if (rc)
 		return rc;
-- 
2.47.1




