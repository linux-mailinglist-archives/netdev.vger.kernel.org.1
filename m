Return-Path: <netdev+bounces-26071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC0776B47
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B90E1C21399
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F841DDC7;
	Wed,  9 Aug 2023 21:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95824510
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:54:23 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D31A6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:54:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso4776481fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691618061; x=1692222861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkMEyGGNHjpLY2UEkMN7YcqkjDj9e0LTmbSFlK+KoK0=;
        b=VQqAQACYQv8GjP6RmCx4yk0ArjFakRxwqfuCKdZKFFDcf4iW4s5YuusU2csrIqKWV+
         h2w1pNtooaKj51cJfgZXblhg8/xZBk8HSazCyLJuxGwlQfEYGU3flDibNizuJ6Q3JnZl
         O80qxZmB9NdR5xTfOeHoVDh+RqbtQYtVPq21Ymcidnb3zuIZ9SwUc6Ku2fgCPyLR1nMA
         jLFM17Ip9W/l7Wn1B8kCQ+Mzwd9boqsPVaaf/Kt8L8cos3E4wy9bh/Ec2QsCAHp6IpXJ
         D9ZUOmpXbE9r00jHVY51+eTUEgm3A5rzSav8h9OirPhtUdyHdqBgBHA18KE0R/ClCPTQ
         2lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618061; x=1692222861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkMEyGGNHjpLY2UEkMN7YcqkjDj9e0LTmbSFlK+KoK0=;
        b=Dw5WhrJf5xVxt6DcT1qQ5Wlv8DK3TOrUFZd/5yK3onXjva2g9EqCow/WsLzReWd0Hd
         k43E1V9pmc60g7hgsMpVLxDLsryIytplbhUwU/TmcwbPc7efIpGQpRbHqoxmyGZEsfk6
         KhKLsq5EmvkUebuxsqt3e1aPAKoVbpkt7aMnryIvRxzedJvpzZjmJsI5CbjTqfsThLwa
         FBdZJpQLcWqTU55LY//nfbraiANbOW6112+gVMoU/p1zANpDGQZkg/BkFR2tNlyHc4zB
         rK7c7QchuHCDmn+ZR5RyuLEZaUWIoVADslSALLc1MfesMOJgyOJPrz4cwqt02XDdwOic
         7YKQ==
X-Gm-Message-State: AOJu0YzQD/1Uj49r+zPHpKhH5ch1fEJCKjZkw50wFtkwMQTl6SeazDHQ
	3bm4ptHH09JLc5tQUxRZ0t1Sjw==
X-Google-Smtp-Source: AGHT+IFLZ3XxvjmZxptWdKwKgWdhi9Xl+mBhFrej+tA4dJqxwRNQvSph1ArlQyTEWD7Vq+GK3SfMzQ==
X-Received: by 2002:a2e:700c:0:b0:2b9:4492:1226 with SMTP id l12-20020a2e700c000000b002b944921226mr402768ljc.11.1691618060835;
        Wed, 09 Aug 2023 14:54:20 -0700 (PDT)
Received: from bear.local ([69.165.74.129])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e8883000000b002b6995f38a2sm6199lji.100.2023.08.09.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:54:19 -0700 (PDT)
From: Luke Lu <luke.lu@libre.computer>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Da Xue <da@libre.computer>,
	Luke Lu <luke.lu@libre.computer>
Subject: [PATCH net v4] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date: Wed,  9 Aug 2023 21:49:46 +0000
Message-Id: <20230809214946.18975-1-luke.lu@libre.computer>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Da Xue <da@libre.computer>

While testing the suspend/resume function, we found the ethernet
is broken if using internal PHY of Amlogic meson GXL SoC.
After system resume back, the ethernet is down, no carrier found.

	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
		DOWN group default qlen 1000

In this patch, we re-initialize the internal PHY to fix this problem.

	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
		group default qlen 1000

Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")
Signed-off-by: Da Xue <da@libre.computer>
Signed-off-by: Luke Lu <luke.lu@libre.computer>

---
Note, we don't Cc stable kernel tree in this patch intentionally, since
there will be a cherry-pick failure if apply this patch from kernel version
less than v6.2, it's not a logic failure but due to the changes too close.

Please check commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access dummy stubs for GXL, internal PHY")
We plan to slightly rework the patch, and send it to stable tree separately
once this patch is accepted into mainline.

v4:
 - refactor commit message to better explain the problem & fix
 - check return value of genphy_resume()
 - add 'net' annotation
 - add Fixes tag

v3: https://lore.kernel.org/netdev/20230808050016.1911447-1-da@libre.computer
 - fix missing parameter of genphy_resume()

v2: https://lore.kernel.org/netdev/20230804201903.1303713-1-da@libre.computer
 - call generic genphy_resume()

v1: https://lore.kernel.org/all/CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com
---
 drivers/net/phy/meson-gxl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6bce2..9ebe09b0cd8c 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,21 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_resume(phydev);
+	if (ret)
+		return ret;
+
+	ret = meson_gxl_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +211,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= smsc_phy_config_intr,
 		.handle_interrupt = smsc_phy_handle_interrupt,
 		.suspend        = genphy_suspend,
-		.resume         = genphy_resume,
+		.resume         = meson_gxl_phy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
-- 
2.40.1


