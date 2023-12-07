Return-Path: <netdev+bounces-55085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B78094F1
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B4F1C20B10
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029F840DE;
	Thu,  7 Dec 2023 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdaoTNUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3ACAC
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 13:54:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so14363737b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 13:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701986076; x=1702590876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Noxi+OqGUk9/20RL0r0Ovx99qYSoefYFwzxukbeHOP4=;
        b=qdaoTNUf8vq8NB7lgw9jI1u1kGNQui1LEmVg7IzJNYj5lXpuph2wxEL8aAe6GUiQAn
         meiq5L4RDWZ9QVZD/o94qChXDw3fS7tkzz9hZK+IeCU0+KCh1qs9L+R//ZXnPAMZkeSA
         9cTY655w/8KEoPsrJd75F05J3l8kv2nEEpfbpyGLHbjQNHAyyRxigG5icl9HkBbNK7YE
         UiO18s5YEHFh+gZDhxAF4WmUm/V/e0CII1iEN1WLwysKtdaYgsjEXIlm2VHvFi1C7WDA
         Jai4sh7v5ZC/jYw+nHhe3IF9agW5MNyJonqb9BbglX2ky+Mm+AoCnMJWCO5jwhwClJPh
         6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986076; x=1702590876;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Noxi+OqGUk9/20RL0r0Ovx99qYSoefYFwzxukbeHOP4=;
        b=hCdZrFt8SrmZB48yw1Epy4Mas9lZJg8IQNuQKDlwCGb/JtpuHuYx5BTHh7S5eRD3nf
         5QDIfmWrUdY4/NVU5M5UkDf0MrJNkPwkoKvPlTrXQuVZinxVzKMBCNT/yHciKjPsszvl
         LuXy6rKBe5gDZ74M31KD0v1DE/iu6kDj+BjFL89jDEpt6ERQimOuat++RuDmKfJgx372
         Rjo6RiT5pc3zXEUsH7/hDAdtC0lIIA/nX56pSFi+MmKTqTUU9Ql6kVdxZ7Nc84aOCKPJ
         0Pa7nkZ7qQKXPNWkHxTkVL/Zo4BsfVG7flOo6WXE5aOPLpdaxvPLnVT3qpieDAlnGfFy
         IF3A==
X-Gm-Message-State: AOJu0YxI+5JKHyU5oPZxMJoW9knIPb4CF4UQxM01NDubbrIV4ghjBJLI
	Pdb7Z8rm682c5/fl18xzBpFoykVx79oMfC7kxw==
X-Google-Smtp-Source: AGHT+IEfP8G6Mq6p9f3UpWaqraovTeynqyUcXUgsTtwAM9ie4HXQ+50Qc28Hx2+aHE9Jofu36ETlW3y5yA0H5JbCjg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dac7:0:b0:da0:3117:f35 with SMTP
 id n190-20020a25dac7000000b00da031170f35mr50538ybf.3.1701986076410; Thu, 07
 Dec 2023 13:54:36 -0800 (PST)
Date: Thu, 07 Dec 2023 21:54:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABY/cmUC/5WNQQqDMBBFr1Ky7pQkgmBXvUdxYWbGOFATSSRUx
 Ls3tSfo5sH7i/92lTkJZ3W/7CpxkSwxVLHXi8JpCJ5BqLqy2jZGGwt5TQGXDShJ4ZQh8AozSfz
 BLxUIjog6Jo1to1W9WhKP8j4zz776JHmNaTurxXzXPwPFgIHBdU63OCIN7uFj9C++YZxVfxzHB 6DmPazZAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701986075; l=2506;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zIrhzyHJNpJ40QKMRusYTExmdzhkSwgmZkrSxmSyxvs=; b=RRGltwx9Y0ze6MjA6QcpAPfN/r19x0syHfol/YE9t1zYphYLUnvX5TOrPEtZsMYZsJsdKTs+v
 gSjruECAkTlAYO1P+Ow+E5USv9FTXuiPVpyLCFA7mN9EigO70KzLKKJ
X-Mailer: b4 0.12.3
Message-ID: <20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com>
Subject: [PATCH v2] net: mdio-gpio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect new_bus->id to be NUL-terminated but not NUL-padded based on
its prior assignment through snprintf:
|       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);

We can also use sizeof() instead of a length macro as this more closely
ties the maximum buffer size to the destination buffer.

Due to this, a suitable replacement is `strscpy` [2] due to the fact
that it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- change subject line as it was causing problems in patchwork with
  "superseded" label being improperly applied.
- update commit msg with rationale around sizeof() (thanks Kees)
- Link to v1 (lore): https://lore.kernel.org/r/20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com
- Link to v1 (patchwork): https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com/
- Link to other patch with same subject message: https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/mdio/mdio-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 0fb3c2de0845..a1718d646504 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -125,7 +125,7 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	if (bus_id != -1)
 		snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
 	else
-		strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
+		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
 	if (pdata) {
 		new_bus->phy_mask = pdata->phy_mask;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-mdio-mdio-gpio-c-bddd9ed0c630

Best regards,
--
Justin Stitt <justinstitt@google.com>


