Return-Path: <netdev+bounces-19412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4675A982
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B20D1C213C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971318AF9;
	Thu, 20 Jul 2023 08:30:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06F182A0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ADDCC55B20;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841798;
	bh=6BchUyr+ieuCD6DFiEg1jKSdhCmrd02MqrlW/pCOLe4=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=k6nTxDwHl/UYVdQq0DrYSgNMVaoNnyqtKznsDfcOaYHTZfjlREgiQl7MlDPqitdCp
	 KmrnP/zBZFyvePTM90q1UrG25V15kNpkNAY3N9LJbKD450HEJ4prcpubW9SwcQhRd0
	 C48G85n/r1RVCR7jSRfrFNPyur16PtBC3GjS68Lj8M5Nq5ZnO3GOPfZjDq1qgltazB
	 6IO3FsYWlHkGGyoIuqW6VArrHh268iH4QJ7ktK2DfEsL//foBQE6bj0HzzmxAkcvRp
	 /wKbHG+qvagQ6jMHBl0nkaHganm/W+2jonxlkqA+ITdS6EDUUl6RalEMAyWyaQztw+
	 yUeBIzAAHfHpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4308CC10F19;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:28 +0300
Subject: [PATCH v3 28/42] input: keypad: ep93xx: add DT support for Cirrus
 EP93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-28-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
List-Id: <soc.lore.kernel.org>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lennert Buytenhek <kernel@wantstofly.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, soc@kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>, 
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852591; l=9018;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=ILgXFn+BgEiNlu4IO4ds7zndh5B8E4l1cI7GVmqHVmY=; =?utf-8?q?b=3D65CE2jg8j1Lb?=
 =?utf-8?q?JggvmNOIerdMlttkLu4ghaPqNAQgxh/g0csK6gFoQZw9CNo30XfFNMwPmX54Gje6?=
 /3wz5y1SAyQB2Mt8zMYLEtjIyxj6g//lA8rNG7U80izWvJ32BxTD
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

- drop flags, they were not used anyway
- add OF ID match table
- process "autorepeat", "debounce-delay-ms", prescale from device tree
- drop platform data usage and it's header
- keymap goes from device tree now on

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c            | 46 ---------------------
 drivers/input/keyboard/ep93xx_keypad.c | 74 ++++++++++------------------------
 include/linux/soc/cirrus/ep93xx.h      |  4 --
 3 files changed, 22 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c81a2e84821b..c60a9d3632dd 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -696,52 +696,6 @@ void __init ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data)
 	platform_device_register(&ep93xx_keypad_device);
 }
 
-int ep93xx_keypad_acquire_gpio(struct platform_device *pdev)
-{
-	int err;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_C(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_c;
-		err = gpio_request(EP93XX_GPIO_LINE_D(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_d;
-	}
-
-	/* Enable the keypad controller; GPIO ports C and D used for keypad */
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_KEYS |
-				 EP93XX_SYSCON_DEVCFG_GONK);
-
-	return 0;
-
-fail_gpio_d:
-	gpio_free(EP93XX_GPIO_LINE_C(i));
-fail_gpio_c:
-	for (--i; i >= 0; --i) {
-		gpio_free(EP93XX_GPIO_LINE_C(i));
-		gpio_free(EP93XX_GPIO_LINE_D(i));
-	}
-	return err;
-}
-EXPORT_SYMBOL(ep93xx_keypad_acquire_gpio);
-
-void ep93xx_keypad_release_gpio(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		gpio_free(EP93XX_GPIO_LINE_C(i));
-		gpio_free(EP93XX_GPIO_LINE_D(i));
-	}
-
-	/* Disable the keypad controller; GPIO ports C and D used for GPIO */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
-			       EP93XX_SYSCON_DEVCFG_GONK);
-}
-EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
-
 /*************************************************************************
  * EP93xx I2S audio peripheral handling
  *************************************************************************/
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 55075addcac2..bc302f0fd0b3 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -6,20 +6,13 @@
  *
  * Based on the pxa27x matrix keypad controller by Rodolfo Giometti.
  *
- * NOTE:
- *
- * The 3-key reset is triggered by pressing the 3 keys in
- * Row 0, Columns 2, 4, and 7 at the same time.  This action can
- * be disabled by setting the EP93XX_KEYPAD_DISABLE_3_KEY flag.
- *
- * Normal operation for the matrix does not autorepeat the key press.
- * This action can be enabled by setting the EP93XX_KEYPAD_AUTOREPEAT
- * flag.
  */
 
 #include <linux/bits.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -27,7 +20,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/soc/cirrus/ep93xx.h>
-#include <linux/platform_data/keypad-ep93xx.h>
 #include <linux/pm_wakeirq.h>
 
 /*
@@ -61,12 +53,16 @@
 #define KEY_REG_KEY1_MASK	GENMASK(5, 0)
 #define KEY_REG_KEY1_SHIFT	0
 
+#define EP93XX_MATRIX_ROWS		(8)
+#define EP93XX_MATRIX_COLS		(8)
+
 #define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
 
 struct ep93xx_keypad {
-	struct ep93xx_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	struct clk *clk;
+	unsigned int	debounce;
+	uint16_t	prescale;
 
 	void __iomem *mmio_base;
 
@@ -133,23 +129,11 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 
 static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 {
-	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	clk_set_rate(keypad->clk, pdata->clk_rate);
-
-	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
-		val |= KEY_INIT_DIS3KY;
-	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
-		val |= KEY_INIT_DIAG;
-	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
-		val |= KEY_INIT_BACK;
-	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
-		val |= KEY_INIT_T2;
-
-	val |= ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
+	val |= ((keypad->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
 
-	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
+	val |= ((keypad->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
 
 	__raw_writel(val, keypad->mmio_base + KEY_INIT);
 }
@@ -220,17 +204,10 @@ static int ep93xx_keypad_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
 				ep93xx_keypad_suspend, ep93xx_keypad_resume);
 
-static void ep93xx_keypad_release_gpio_action(void *_pdev)
-{
-	struct platform_device *pdev = _pdev;
-
-	ep93xx_keypad_release_gpio(pdev);
-}
-
 static int ep93xx_keypad_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct ep93xx_keypad *keypad;
-	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
 	int err;
 
@@ -238,14 +215,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (!keypad)
 		return -ENOMEM;
 
-	keypad->pdata = dev_get_platdata(&pdev->dev);
-	if (!keypad->pdata)
-		return -EINVAL;
-
-	keymap_data = keypad->pdata->keymap_data;
-	if (!keymap_data)
-		return -EINVAL;
-
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (keypad->irq < 0)
 		return keypad->irq;
@@ -254,19 +223,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-	err = ep93xx_keypad_acquire_gpio(pdev);
-	if (err)
-		return err;
-
-	err = devm_add_action_or_reset(&pdev->dev,
-				       ep93xx_keypad_release_gpio_action, pdev);
-	if (err)
-		return err;
-
 	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk))
 		return PTR_ERR(keypad->clk);
 
+	device_property_read_u32(dev, "debounce-delay-ms", &keypad->debounce);
+	device_property_read_u16(dev, "cirrus,prescale", &keypad->prescale);
+
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -278,13 +241,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	input_dev->open = ep93xx_keypad_open;
 	input_dev->close = ep93xx_keypad_close;
 
-	err = matrix_keypad_build_keymap(keymap_data, NULL,
+	err = matrix_keypad_build_keymap(NULL, NULL,
 					 EP93XX_MATRIX_ROWS, EP93XX_MATRIX_COLS,
 					 keypad->keycodes, input_dev);
 	if (err)
 		return err;
 
-	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
+	if (device_property_read_bool(&pdev->dev, "autorepeat"))
 		__set_bit(EV_REP, input_dev->evbit);
 	input_set_drvdata(input_dev, keypad);
 
@@ -315,10 +278,17 @@ static int ep93xx_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_keypad_of_ids[] = {
+	{ .compatible = "cirrus,ep9307-keypad" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_keypad_of_ids);
+
 static struct platform_driver ep93xx_keypad_driver = {
 	.driver		= {
 		.name	= "ep93xx-keypad",
 		.pm	= pm_sleep_ptr(&ep93xx_keypad_pm_ops),
+		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
 	.remove		= ep93xx_keypad_remove,
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index f38937a6f08c..43b1f11526e4 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -16,8 +16,6 @@ int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
 void ep93xx_ide_release_gpio(struct platform_device *pdev);
-int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
-void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 unsigned int ep93xx_chip_revision(void);
@@ -27,8 +25,6 @@ static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return
 static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
 static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
-static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
 

-- 
2.39.2


