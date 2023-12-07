Return-Path: <netdev+bounces-55087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1B8094F9
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7305B20ACB
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE48840E2;
	Thu,  7 Dec 2023 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="porlm07H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C21715
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 13:57:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c941936f7fso8829157b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701986271; x=1702591071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s948J7sj5ORs8qgkiDHhUgJdtPkA+zULgTGFCTqedVM=;
        b=porlm07HgQHMKQQzk+mhrOF3+zwuTyCexHRJI/E86kTcDYRT2WqgKTvmbBGGzcIns/
         DFK8/NSiUWl78tGe53QWcEUxHsHFcHVyRhKSX7uYcGMjTD+cZQGrKbtstqmx5JLfTBZH
         f6LwLEUmF6BIUJZ5c5zcA06rbCv/fpRtp2NbJYRmwQcHOwHUjkFXIJWQjgde57JRAtP8
         bcmIcOHMjtnV4oJawgTTM6cvpNje6abh3fsADhUBXWm1+iorW4z66G9aiHSUri/avm4S
         0KT4isYymoKyDzGTafcYMdGsCZkRZpeIycdNzhVkj3Un2p0OGkzftjrmuKz/8WOLsOCh
         CxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986271; x=1702591071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s948J7sj5ORs8qgkiDHhUgJdtPkA+zULgTGFCTqedVM=;
        b=ZqYl1M60jWA7hzJJDo4ZIkIaA8XSdJhpnVW1ualLfF8tWtbD435+GxVA6ZXxEGGZ4/
         07k/qTwqxF4H3SuRaNTtIrnw16EOarUAXLRDfzB5VCm3KLzZ+tqnTKfOGjl6J+e2YKJw
         VQA17ZVtdU8OxDKMl949UFOXPgk0GwPgzGdoXKNX0f2nLJkhWf6K9V9CGlx1ko4VedCU
         IfaYaz5WjWfeErYnAs/f60CoI9ONWGQDW+hiEIMTN7g1LM/DZy7i0dNxtGRyRhA2IWsu
         yuCYBbh90mCEq00zmWMmFkSraVoHtSyfEgNnOXSjraf4wZs1IrToTrxCbjVvNQ2BFEdI
         iD6A==
X-Gm-Message-State: AOJu0YwWwsddbsNESSpq+RHDimSIy0webfkxsG63aCbH0uJCS4V0OOM7
	frl/jHIc5BHXA7o9yN3ZcpyfeBQTbtXHozr+oQ==
X-Google-Smtp-Source: AGHT+IEhefxazKpcY5tjjP7IdMQlhRx3wOnhjJuMNzpbjBVpLR1oWst1vOD6/nxUXSg5Gaa1FMKfnu1yylx7V527Sg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8582:0:b0:db7:d0d3:8579 with SMTP
 id x2-20020a258582000000b00db7d0d38579mr150760ybk.6.1701986271039; Thu, 07
 Dec 2023 13:57:51 -0800 (PST)
Date: Thu, 07 Dec 2023 21:57:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN0/cmUC/5WNQQ6CMBBFr2Jm7Zh2BFFX3sMQg+0Ak0hLWmwkh
 LtbuYH5q/cX7y0QOQhHuO4WCJwkincZaL8D0zeuYxSbGUjRUStNGKfgzDijDZI4RHQ84djPOFj
 xj+c7okHVKFvyuSorTZBFY+BWPlvkXmfuJU4+zFsz6d/7lz5pzCupID61FzbFrfO+e/HB+AHqd V2/oLuxHdUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701986270; l=2438;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=7MECXZW2pvskksG435akbDYczjb3pqkffjxJYPwtntE=; b=Wf+9RMODL0PYxFtMgH/aTsi773KuPKHsUSd9qAJ3z7dlVFCRTM9qMMaPzWgYaq5HHO9kkSFR8
 1GjFxwGAjglAySyx1KrP+8q6vWP3MMUcwQyUpkqhHETvBcAl1QEZRTz
X-Mailer: b4 0.12.3
Message-ID: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
Subject: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
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

We expect mdiodev->modalias to be NUL-terminated based on its usage with
strcmp():
|       return strcmp(mdiodev->modalias, drv->name) == 0;

Moreover, mdiodev->modalias is already zero-allocated:
|       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
... which means the NUL-padding strncpy provides is not necessary.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- rename subject line as it was the same as another and was causing
  problems.
- rebased onto mainline bee0e7762ad2c602
- Link to v1 (lore): https://lore.kernel.org/r/20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com
- Link to v1 (patchwork): https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com/
- Link to collided: https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..6cf73c15635b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -506,7 +506,7 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	if (IS_ERR(mdiodev))
 		return -ENODEV;
 
-	strncpy(mdiodev->modalias, bi->modalias,
+	strscpy(mdiodev->modalias, bi->modalias,
 		sizeof(mdiodev->modalias));
 	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->dev.platform_data = (void *)bi->platform_data;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231012-strncpy-drivers-net-phy-mdio_bus-c-0a0d5e875712

Best regards,
--
Justin Stitt <justinstitt@google.com>


