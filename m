Return-Path: <netdev+bounces-51942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8197FCC72
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DD61C20AD0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CE1FB2;
	Wed, 29 Nov 2023 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5gDU/DR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981C10E2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:55:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4734b975so21558375e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701222953; x=1701827753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p1liFusUWRbUuFv96CNrCOEbn0jKp9XD9lRiTcEZnqc=;
        b=T5gDU/DReyd173IuGU7CO6F8gh0vy1sxDgUyEbOPqNrupqzAAkNvf+ZZttzx30w9N5
         tNZEYIKq0qzFVl+Pn/rdGmeWCh3zg4BnIIRI0UPgNFSEFVteufjhdS6O8ZwqJwHLYlZa
         wzyVMM75f4E1LiJANp8kqswCzlYV4hiQDEkcOBcdR8729Ca848RabNZAvqT364tuKIRA
         zctOuAgq88zRkvw0c6qThl0M2p8ev+Cmlvl807RF7AJQfWwS8lW2DfJ5lXA0Ju+GoERJ
         UqwDrWdaU2bsKWhOkERk0c82wqM8T4/ispPfS9xUZFrU9/rJKlsKscGjDol3iwbi2Z+G
         mqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701222953; x=1701827753;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1liFusUWRbUuFv96CNrCOEbn0jKp9XD9lRiTcEZnqc=;
        b=lqGCKfw2Dy+uzyuRZ6tAYYQOMzyBBS45JzEzLqixeLzQPJ3WKn/rQam/gPuXacCtkL
         mI6TQfuhfnumMkHRe1r7AFQR0yfnVYffP3zUpEQx82CGv4FS9qgfeXMP2eYAuv4K6zRA
         VJOKTQu7zqkAPo5NRvxSJYt7bt0A2h/11535VEn6cVMPRQQtsHi3nRCQW9CqT8rFzRl6
         7bPUUWl5KT+J9MNHli5+MHlMPti1icClNlMXHarkfgKAobCrJvKMH2jyHVQU2a/ry1ln
         mDNeQZxrG3eDQOi/Rjg8effDbAnK8BDRLKmdaNIYaRIA7Xgj1XaztbwZxv/KcqQYNa3P
         Euxg==
X-Gm-Message-State: AOJu0YxVdk85GDvVdjfUX92zWP1klGZcWeO2eOVL6aUTMiwo6LobCWVC
	zTbT0em78k0Jo2WrSolkIO0=
X-Google-Smtp-Source: AGHT+IFLtRh3Zh9yU+Grb3D3Vyy8yRp9XRUPMX+OX1ehx8oovRRgpIf1KYyKnW//1M+Fw17DWkFxHQ==
X-Received: by 2002:adf:e5d0:0:b0:332:f97e:7850 with SMTP id a16-20020adfe5d0000000b00332f97e7850mr6878304wrn.24.1701222953533;
        Tue, 28 Nov 2023 17:55:53 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00332f6ad2ca8sm10576614wrw.36.2023.11.28.17.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:55:53 -0800 (PST)
Message-ID: <65669a29.5d0a0220.19703.34e3@mx.google.com>
X-Google-Original-Message-ID: <ZWaaJ10f5gzZtHRn@Ansuel-xps.>
Date: Wed, 29 Nov 2023 02:55:51 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 8/8] dsa: qca8k: Use DSA common code for LEDs
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-9-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Osjrot9O7QDzOwZC"
Content-Disposition: inline
In-Reply-To: <20231128232135.358638-9-andrew@lunn.ch>


--Osjrot9O7QDzOwZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2023 at 12:21:35AM +0100, Andrew Lunn wrote:
> Rather than parse the device tree in the qca8k driver, make use of the
> common code in the DSA core.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Hi,

I attached a fixup patch for this to correctly work. Since we are using
port_num the thing needs to be decrememted by one.

-- 
	Ansuel

--Osjrot9O7QDzOwZC
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fixup-dsa-qca8k-Use-DSA-common-code-for-LEDs.patch"

From 95598e6892cb0d392249f099587bd81ea3b664de Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Wed, 29 Nov 2023 02:50:09 +0100
Subject: [PATCH] fixup! dsa: qca8k: Use DSA common code for LEDs

Fix off-by-one from port_num to phy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-leds.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index febae23b65a9..67f42a0dbbd8 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -9,7 +9,7 @@
 static int
 qca8k_get_enable_led_reg(int port_num, int led_num, struct qca8k_led_pattern_en *reg_info)
 {
-	switch (port_num) {
+	switch (qca8k_port_to_phy(port_num)) {
 	case 0:
 		reg_info->reg = QCA8K_LED_CTRL_REG(led_num);
 		reg_info->shift = QCA8K_LED_PHY0123_CONTROL_RULE_SHIFT;
@@ -41,7 +41,7 @@ qca8k_get_control_led_reg(int port_num, int led_num, struct qca8k_led_pattern_en
 	 * 3 control rules for phy0-3 that applies to all their leds
 	 * 3 control rules for phy4
 	 */
-	if (port_num == 4)
+	if (qca8k_port_to_phy(port_num) == 4)
 		reg_info->shift = QCA8K_LED_PHY4_CONTROL_RULE_SHIFT;
 	else
 		reg_info->shift = QCA8K_LED_PHY0123_CONTROL_RULE_SHIFT;
@@ -127,7 +127,8 @@ qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
 	 * to calculate the shift and the correct reg due to this problem of
 	 * not having a 1:1 map of LED with the regs.
 	 */
-	if (port_num == 0 || port_num == 4) {
+	if (qca8k_port_to_phy(port_num) == 0 ||
+	    qca8k_port_to_phy(port_num) == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -162,7 +163,8 @@ qca8k_led_blink_set(struct dsa_switch *ds, int port_num, u8 led_num,
 
 	qca8k_get_enable_led_reg(port_num, led_num, &reg_info);
 
-	if (port_num == 0 || port_num == 4) {
+	if (qca8k_port_to_phy(port_num) == 0 ||
+	    qca8k_port_to_phy(port_num) == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -187,7 +189,8 @@ qca8k_led_trigger_offload(struct qca8k_priv *priv, int port_num, u8 led_num,
 	if (enable)
 		val = QCA8K_LED_RULE_CONTROLLED;
 
-	if (port_num == 0 || port_num == 4) {
+	if (qca8k_port_to_phy(port_num) == 0 ||
+	    qca8k_port_to_phy(port_num) == 4) {
 		mask = QCA8K_LED_PATTERN_EN_MASK;
 		val <<= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
@@ -210,7 +213,8 @@ qca8k_led_hw_control_status(struct qca8k_priv *priv, int port_num, u8 led_num)
 
 	val >>= reg_info.shift;
 
-	if (port_num == 0 || port_num == 4) {
+	if (qca8k_port_to_phy(port_num) == 0 ||
+	    qca8k_port_to_phy(port_num) == 4) {
 		val &= QCA8K_LED_PATTERN_EN_MASK;
 		val >>= QCA8K_LED_PATTERN_EN_SHIFT;
 	} else {
-- 
2.40.1


--Osjrot9O7QDzOwZC--

