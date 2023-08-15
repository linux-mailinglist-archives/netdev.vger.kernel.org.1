Return-Path: <netdev+bounces-27600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB177C7F8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFB91C20AE4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482A5388;
	Tue, 15 Aug 2023 06:41:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9E185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:41:52 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25234110
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:41:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d63457dd8b8so4948350276.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692081709; x=1692686509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RHhDchD4BGcc2HLql57ZQ9Kb4iGHa6mmW/e//XPq84=;
        b=K5qG0UukuJvsAaMFdG0DIpkzHSavi/dyHL+ppZr7ESPbgrrSObrPj0ZTP2ip5ZlHTe
         BitSESS4NUYK98V6YcpuyrFat+X2DsWO2OT55ck7/V/7Yy1rWlJWMFIs3zJjqh21zf56
         YyXVaPmJ5SDqALERmW8VsxDFGRKingbuHw23Q9iN2/1dJIgasGV9mXDPcTJLmuLkgXKo
         kHhFOjUeh1D6PE+8mW3SOhGx0kJRAG7yWw33tfh3AbFbHvNqhHSWzapRmGg10vNAU4uY
         YCrGFK3aGZr6LpHsyjP5XNT5VTA1doyZe8mNiMJcCE0aZFsnpret70OX0OxEYNwrRLma
         nO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081709; x=1692686509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RHhDchD4BGcc2HLql57ZQ9Kb4iGHa6mmW/e//XPq84=;
        b=JX7+hhuHSB6cLzqZzpaaKzJTOZid6PGyUFleeScO0kaAlapj099GEX6Q4ndmFTwuXS
         Fp58Vg3kOGTUfwipsNFempYVLnwH0aAl+Uh7z1N67IPk5/kckCcHPHqZytu2H8uqvQ+q
         N9JOs9HouTdBHDMONs2IJPiZCc1bu8QpIZRHi4G+/lLcjAswOf0W5QyWjOvzIQgutpbv
         IECmnGzDv6ZwYN4jUrg3PDFtu6CYTf1nXgEmUzClL7wF3PRINDBw863ghNCVngGqrlPx
         bds15uA3YX9s+sBXHYk82biOO2qafx7rMv0UjwJYZNrDtR/OHzKczOYPA/iAZ8qwijw7
         WSUw==
X-Gm-Message-State: AOJu0YyMT5S6Dy17iKmqumpCXW2hu+M/BkbySDLnbCZwQfcsZHVFusMl
	YFC8GK63SxyCfdjj0aEWQRocpN/IaLc1Eeyg0BqSX/C7A7O4FVoOjqc=
X-Google-Smtp-Source: AGHT+IF4P5LmBZ6lS8IHORTz6S24/ZQieodlXFHzR9FTY+dpAAmnjy9Y5lQcbosbtPyIFjxjKxyttMlo0rPky9jh3R4=
X-Received: by 2002:a25:addb:0:b0:bcb:9b43:5a89 with SMTP id
 d27-20020a25addb000000b00bcb9b435a89mr11765171ybe.61.1692081709320; Mon, 14
 Aug 2023 23:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk> <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk> <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk> <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk> <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk> <CACRpkdbN9Vbk+NzeLRNz9ZhSMnJEOF=Af52hjUAmnaTdK9ytvw@mail.gmail.com>
In-Reply-To: <CACRpkdbN9Vbk+NzeLRNz9ZhSMnJEOF=Af52hjUAmnaTdK9ytvw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2023 08:41:36 +0200
Message-ID: <CACRpkdb9H+sQyrBTQBSz8wagtpBVruJj+p+p60hxsfGNbQveUw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 13, 2023 at 11:56=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Sat, Aug 12, 2023 at 2:16=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:

> > So for realtek, I propose (completely untested):
>
> I applied it and it all works fine afterwards on the DIR-685.
> Should I test some different configs in the DTS as well?

I applied the following two patches on top of your patch, and
it works like a charm.

From e23b281afecd019322fd7d3f0e1c2f561842b02a Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2023 08:21:18 +0200
Subject: [PATCH 1/2] RFC: net: dsa: realtek: Implement setting up link on C=
PU
 port

We auto-negotiate most ports in the RTL8366RB driver, but
the CPU port is hard-coded to 1Gbit, full duplex, tx and
rx pause.

Actually respect the arguments passed to the function for
the CPU port.

After this the link is still set up properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch requires Russell Kings patch:
"net: dsa: realtek: add phylink_get_caps implementation"
---
 drivers/net/dsa/realtek/rtl8366rb.c | 42 ++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c
b/drivers/net/dsa/realtek/rtl8366rb.c
index 76b5c43e1430..385225980e8d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -95,12 +95,6 @@
 #define RTL8366RB_PAACR_RX_PAUSE    BIT(6)
 #define RTL8366RB_PAACR_AN        BIT(7)

-#define RTL8366RB_PAACR_CPU_PORT    (RTL8366RB_PAACR_SPEED_1000M | \
-                     RTL8366RB_PAACR_FULL_DUPLEX | \
-                     RTL8366RB_PAACR_LINK_UP | \
-                     RTL8366RB_PAACR_TX_PAUSE | \
-                     RTL8366RB_PAACR_RX_PAUSE)
-
 /* bits 0..7 =3D port 0, bits 8..15 =3D port 1 */
 #define RTL8366RB_PSTAT0        0x0014
 /* bits 0..7 =3D port 2, bits 8..15 =3D port 3 */
@@ -1081,6 +1075,7 @@ rtl8366rb_mac_link_up(struct dsa_switch *ds, int
port, unsigned int mode,
               int speed, int duplex, bool tx_pause, bool rx_pause)
 {
     struct realtek_priv *priv =3D ds->priv;
+    unsigned int val;
     int ret;

     if (port !=3D priv->cpu_port)
@@ -1088,22 +1083,51 @@ rtl8366rb_mac_link_up(struct dsa_switch *ds,
int port, unsigned int mode,

     dev_dbg(priv->dev, "MAC link up on CPU port (%d)\n", port);

-    /* Force the fixed CPU port into 1Gbit mode, no autonegotiation */
+    /* Force the fixed CPU port forced, no autonegotiation */
     ret =3D regmap_update_bits(priv->map, RTL8366RB_MAC_FORCE_CTRL_REG,
                  BIT(port), BIT(port));
     if (ret) {
-        dev_err(priv->dev, "failed to force 1Gbit on CPU port\n");
+        dev_err(priv->dev, "failed to force CPU port\n");
         return;
     }

+    /* Conjure port config */
+    switch (speed) {
+    case SPEED_10:
+        val =3D RTL8366RB_PAACR_SPEED_10M;
+        break;
+    case SPEED_100:
+        val =3D RTL8366RB_PAACR_SPEED_100M;
+        break;
+    case SPEED_1000:
+        val =3D RTL8366RB_PAACR_SPEED_1000M;
+        break;
+    default:
+        val =3D RTL8366RB_PAACR_SPEED_1000M;
+        break;
+    }
+
+    if (duplex =3D=3D DUPLEX_FULL)
+        val |=3D RTL8366RB_PAACR_FULL_DUPLEX;
+
+    if (tx_pause)
+        val |=3D  RTL8366RB_PAACR_TX_PAUSE;
+
+    if (rx_pause)
+        val |=3D RTL8366RB_PAACR_RX_PAUSE;
+
+    val |=3D RTL8366RB_PAACR_LINK_UP;
+
     ret =3D regmap_update_bits(priv->map, RTL8366RB_PAACR2,
                  0xFF00U,
-                 RTL8366RB_PAACR_CPU_PORT << 8);
+                 val << 8);
     if (ret) {
         dev_err(priv->dev, "failed to set PAACR on CPU port\n");
         return;
     }

+    dev_dbg(priv->dev, "set PAACR to %04x\n", val);
+
     /* Enable the CPU port */
     ret =3D regmap_update_bits(priv->map, RTL8366RB_PECR, BIT(port),
                  0);
--=20
2.41.0

From e534aebdd57bbbab3aff56198ffa38f21b752752 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2023 08:30:13 +0200
Subject: [PATCH 2/2] RFC: ARM: gemini: dir-685: Set switch link to rgmii-id

As concluded from discussions on the mailing lists, this
setting makes no sense. The only reason it worked was because
of hard-coded default handling in the drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch requires Russell Kings patch
"net: dsa: realtek: add phylink_get_caps implementation"
---
 arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
b/arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
index 396149664297..778115c4461c 100644
--- a/arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts
@@ -237,7 +237,7 @@ rtl8366rb_cpu_port: port@5 {
                 reg =3D <5>;
                 label =3D "cpu";
                 ethernet =3D <&gmac0>;
-                phy-mode =3D "rgmii";
+                phy-mode =3D "rgmii-id";
                 fixed-link {
                     speed =3D <1000>;
                     full-duplex;
--=20
2.41.0

Yours,
Linus Walleij

