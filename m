Return-Path: <netdev+bounces-292013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HayCgQ9FmqejgcAu9opvQ
	(envelope-from <netdev+bounces-292013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411D5DDFDB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B043018ADA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79F242D9B;
	Wed, 27 May 2026 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSlKy/4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E937149C7B;
	Wed, 27 May 2026 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842304; cv=none; b=L/G4n1LxRS4iktwBsGe1MfQ6GVaWZW2WvpLgdMS9VTHFCjfgz7l7IXP9WbMu72441uw+z3OqTBPJXFSAxm4CxBUHtVJnnfQjNq0zCY9vbIv7lXjExPo1EQbO6hMHLpI1nMJTToMqLXn41r7v1C0tC8V2EVwIr+HgEUSia0Q1rZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842304; c=relaxed/simple;
	bh=AbOizXm7FATS3iKZLnRSOONN1D6N+xH/sxusibGgvbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfjGYdSy0jUxkv452kJgTFy/D50H6f3cNgJuxBu+d0upFye3QghMvxEUavh1oKtNlmZiGXEfRw5Tkyry9I9EzSRxyAfC7X/IJcr8P544p2bWDXQgC72rHBrC3X5A2XkDeD6FHtmLIHo8sgKhw2qtd/2b33tFFJ8sWgXvV+it06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSlKy/4M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D7E1F000E9;
	Wed, 27 May 2026 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842302;
	bh=yHCTj00vh0IdA0V7aKTuseill+cCJTn72gLzqsxudlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XSlKy/4MaowP5hQ3fmTGFVjlNlV9jbcANuEFe/GliEYGAH7hZncqx+TvUnJuJvafW
	 O3o2nZmtE0baT9cRAabNX9Q37DruDBKFOkeqGdBl8x72taWv1d1/XeUKBpG3k0lRtc
	 RNwDbuYYdk5KFFFraHieaBS5kIlh/X2J8NSDKsW7c40LnzFIyKPFvOjyzNbH0StnW5
	 mhSHU6stW1zzzZVoO9049EveoTP9WkEgWO1Cbr+WABb0b9WqSinaPI2tgiEfeSRSNV
	 IkC0gME+S8GQxpkfy7SwuBvANmW9bkZ+IOlhGfhhWUdGw+Tju0iJF6OV8MXJ6/ky+h
	 G2C5y+qZf4H2A==
From: Jakub Kicinski <kuba@kernel.org>
To: clamor95@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: usb: Add Infineon XMM6260 Baseband modem support
Date: Tue, 26 May 2026 17:38:20 -0700
Message-ID: <20260527003820.3093794-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523084408.50346-3-clamor95@gmail.com>
References: <20260523084408.50346-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8411D5DDFDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: Add Infineon XMM6260 Baseband modem support

This patch adds a platform driver for the Infineon/Intel XMM6260
3G modem. The driver toggles GPIOs and a regulator, drives a pwrseq
provider, and uses the global USB notifier plus rfkill to react to
the modem's HSIC USB enumeration.

A few observations on the commit message and overall placement before
the inline comments:

[Low]
The commit message tail reads:

  The modem is usually connected via the application processor's USB
  line in HSIC mode; however, to work properly, the modem must control
  this line

The sentence stops there with no completion.  Since this is the central
justification for adding a custom driver, can the explanation of what
"control this line" entails and why an existing solution does not work
be added?

[Low]
The driver is placed under drivers/net/usb/ but does not implement a
net_device (no register_netdev / alloc_netdev / netdev_ops, no usbnet
binding, no tx/rx callbacks).  The dmesg in the commit message and the
Kconfig help confirm the modem enumerates as cdc_acm and that data
goes over ttyACM0 with a userspace DHCP client.

Would drivers/usb/misc/ or drivers/power/ be a more natural home, both
for routing the patch to the right maintainers and to avoid this
appearing alongside actual USB net drivers?

[Low]
Could the design be re-expressed as a pure pwrseq provider attached to
the USB device's hub-port DT node, letting the USB core gate
enumeration?  The current driver pulls in pwrseq for part of the work
but keeps regulator + GPIO toggling, an rfkill instance, a global USB
notifier, and an ad-hoc bitmap state machine alongside it.

> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 52a5c0922c79..d54d8db752df 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -642,4 +642,19 @@ config USB_RTL8153_ECM
>  	  CONFIG_USB_RTL8152 is not set, or the RTL8153 device is not
>  	  supported by r8152 driver.
>  
> +config USB_NET_XMM6260
> +	tristate "Infineon XMM626X Baseband HSPA/HSUPA modem"

[Low]
The title says "XMM626X" (suggesting a family), but the USB notifier
hard-codes a single VID:PID 0x1519:0x0020 for XMM6260 only.  Other
626X variants such as XMM6262 will not be matched.  Should the title
be narrowed to XMM6260, or the match table extended?

> +	depends on USB_CHIPIDEA && (RFKILL || RFKILL=n)

[Low]
Does the driver actually have a software dependency on USB_CHIPIDEA?
The XMM6260 driver does not call any chipidea-specific API; it only
reacts to USB enumeration via the generic USB notifier and toggles
GPIOs/regulators/pwrseq.  Tying this to USB_CHIPIDEA prevents using
the driver on other HSIC-/USB-capable SoCs even though nothing in the
code is HCD-specific.

[ ... ]

> diff --git a/drivers/net/usb/baseband-xmm6260.c b/drivers/net/usb/baseband-xmm6260.c
> new file mode 100644
> index 000000000000..6710e46f4170
> --- /dev/null
> +++ b/drivers/net/usb/baseband-xmm6260.c
> @@ -0,0 +1,378 @@

[ ... ]

> +/* bits [0:2] */
> +enum baseband_xmm_ipc_ap_wake_state {
> +	BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY,
> +	BASEBAND_XMM_IPC_AP_WAKE_INIT1,
> +	BASEBAND_XMM_IPC_AP_WAKE_INIT2,
> +	BASEBAND_XMM_IPC_AP_WAKE_L,
> +	BASEBAND_XMM_IPC_AP_WAKE_H,
> +	BASEBAND_XMM_IPC_AP_WAKE_UNINIT,
> +	BASEBAND_XMM_IPC_AP_WAKE_MASK = 7,
> +};
> +
> +#define BASEBAND_XMM_IPC_AP_WAKE_MAX	3
> +
> +#define BASEBAND_XMM_STATE_POWERED	3 /* Tracks regulator state */
> +#define BASEBAND_XMM_STATE_PROTECTED	4 /* Prevents rfkill from access */
> +#define BASEBAND_XMM_STATE_PRESENT	5 /* Tracks USB device presence */
> +#define BASEBAND_XMM_STATE_POWEROFF	6 /* Prevents poweroff recursive call */
> +#define BASEBAND_XMM_STATE_MAX		8

[Low]
The ipc_ap_wake_state enum reaches UNINIT=5 and MASK=7, but
BASEBAND_XMM_IPC_AP_WAKE_MAX=3 caps the encode/decode loops at three
bits.  Bits 3..6 of priv->state are then repurposed as orthogonal
STATE_POWERED / PROTECTED / PRESENT / POWEROFF flags.  Nothing
asserts that the wake-state value fits in three bits, so a future
enum entry past 7, or a typo widening WAKE_MAX, would silently
overwrite the STATE_* flags.  Could a BUILD_BUG_ON or static_assert
guard this invariant?

The L / H / UNINIT / MASK enumerators are also dead today; they only
appear at their declarations.  The block comment above the enum
describes a multi-state protocol with a retry cycle, but the IRQ
handler implements only IRQ_READY and INIT1.  Should the unused
values be removed, or should the handler be completed?

[ ... ]

> +static void set_ipc_ap_wake(struct baseband_xmm_data *priv,
> +			    enum baseband_xmm_ipc_ap_wake_state state)
> +{
> +	for (int i = 0; i < BASEBAND_XMM_IPC_AP_WAKE_MAX; i++)
> +		if (state & BIT(i))
> +			set_bit(i, priv->state);
> +		else
> +			clear_bit(i, priv->state);
> +}
> +
> +static void baseband_xmm_reset(struct baseband_xmm_data *priv)
> +{
> +	int ret;
> +
> +	set_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
> +
> +	if (!test_bit(BASEBAND_XMM_STATE_POWERED, priv->state)) {
> +		ret = regulator_enable(priv->vbat_supply);
> +		if (ret)
> +			dev_err(priv->dev,
> +				"failed to enable vbat power supply\n");
> +
> +		set_bit(BASEBAND_XMM_STATE_POWERED, priv->state);
> +	}

[High]
On regulator_enable() failure, ret is logged but STATE_POWERED is
still set unconditionally.  When baseband_xmm_poweroff() later
observes STATE_POWERED it will call regulator_disable() without a
matching enable, which trips WARN_ON in the regulator core for a
negative use_count and corrupts the disable count for every other
consumer of vbat.  Should the set_bit() be moved inside an "if (!ret)"
branch, or should the function bail out on enable failure?

> +
> +	gpiod_set_value_cansleep(priv->enable_gpio, 0);
> +	msleep(50);
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +	msleep(200);
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +
> +	msleep(50);
> +
> +	/* falling edge trigger to CP */
> +	gpiod_set_value_cansleep(priv->enable_gpio, 1);
> +	usleep_range(50, 100);
> +	gpiod_set_value_cansleep(priv->enable_gpio, 0);
> +	msleep(20);
> +}
> +
> +static void baseband_xmm_poweroff(struct baseband_xmm_data *priv)
> +{
> +	/*
> +	 * The test_bit check prevents poweroff from being recursively
> +	 * called during USB device deregistration. USB device
> +	 * deregistration can be triggered by the driver by calling this
> +	 * function or by some external event. The first case will cause
> +	 * a recursive call by the notifier if not handled, while the
> +	 * second case requires this call to handle the USB controller
> +	 * properly.
> +	 */
> +	if (test_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state))
> +		return;
> +
> +	set_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
> +	set_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state);
> +
> +	pwrseq_power_off(priv->pwrseq);
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +
> +	if (test_bit(BASEBAND_XMM_STATE_POWERED, priv->state)) {
> +		regulator_disable(priv->vbat_supply);
> +		clear_bit(BASEBAND_XMM_STATE_POWERED, priv->state);
> +	}
> +	set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY);
> +
> +	clear_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
> +	clear_bit(BASEBAND_XMM_STATE_PRESENT, priv->state);
> +	clear_bit(BASEBAND_XMM_STATE_POWEROFF, priv->state);
> +}

[High]
Are STATE_PROTECTED / STATE_POWEROFF / STATE_PRESENT being used here
as ad-hoc locks rather than as state?  The pattern is set on entry,
cleared on exit:

    if (test_bit(STATE_POWEROFF, priv->state))
        return;
    set_bit(STATE_PROTECTED, ...);
    set_bit(STATE_POWEROFF, ...);
    ...
    clear_bit(STATE_PROTECTED, ...);
    clear_bit(STATE_PRESENT, ...);
    clear_bit(STATE_POWEROFF, ...);

test_bit() followed by set_bit() is not atomic, so two callers (the
USB_DEVICE_REMOVE notifier on one CPU, the rfkill set_block callback,
the delayed work, or remove() on another) can both observe POWEROFF=0
and both proceed, calling pwrseq_power_off() twice and (when
STATE_POWERED is set) regulator_disable() twice.

The same concern applies to baseband_xmm_set_block(), which reads
STATE_PROTECTED and STATE_PRESENT outside of any lock, and to the
three separate set_bit/clear_bit operations inside set_ipc_ap_wake()
that the IRQ handler reads back via three separate test_bit() calls
(potential torn read across bits 0..2).

The networking subsystem documentation calls this pattern out
explicitly: "any pattern where a flag, atomic variable, or bit
operation appears to guard a section of code rather than express
state ... is a bug".  Could a real mutex (or spinlock for the IRQ
handler reads) be used instead?

> +
> +static int baseband_xmm_usb_notifier_call(struct notifier_block *nb,
> +					  unsigned long action, void *data)
> +{
> +	struct baseband_xmm_data *priv =
> +		container_of(nb, struct baseband_xmm_data, nb);
> +	struct usb_device *udev;
> +	u16 product, vendor;
> +
> +	if (action == USB_BUS_ADD || action == USB_BUS_REMOVE)
> +		return NOTIFY_OK;
> +
> +	udev = data;
> +	product = le16_to_cpu(udev->descriptor.idProduct);
> +	vendor = le16_to_cpu(udev->descriptor.idVendor);
> +
> +	switch (action) {
> +	case USB_DEVICE_ADD:
> +		/* Infineon XMM6260 ID 1519:0020 */
> +		if (vendor == BASEBAND_VENDOR_ID_COMNEON &&
> +		    product == BASEBAND_PRODUCT_ID_XMM6260) {
> +			cancel_delayed_work_sync(&priv->modem_work);
> +			clear_bit(BASEBAND_XMM_STATE_PROTECTED, priv->state);
> +			set_bit(BASEBAND_XMM_STATE_PRESENT, priv->state);
> +		}
> +		break;

[Low]
Match is purely on VID:PID via the global USB notifier, with no
binding between this platform_device instance and the USB device that
enumerates.  If two XMM6260 modems are present in the system, both
driver instances react to either modem's add/remove.  Would binding a
USB device driver to that VID:PID, or routing the lifecycle through a
pwrseq attached to the hub-port node, give a stable per-instance
association?

> +
> +	case USB_DEVICE_REMOVE:
> +		/* Infineon XMM6260 ID 1519:0020 */
> +		if (vendor == BASEBAND_VENDOR_ID_COMNEON &&
> +		    product == BASEBAND_PRODUCT_ID_XMM6260)
> +			baseband_xmm_poweroff(priv);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

[ ... ]

> +static irqreturn_t baseband_hostwake_interrupt(int irq, void *dev_id)
> +{
> +	struct baseband_xmm_data *priv = dev_id;
> +	int state = gpiod_get_value(priv->ipc_ap_gpio);

[Medium]
This handler is registered with devm_request_threaded_irq(..., NULL,
&baseband_hostwake_interrupt, IRQF_ONESHOT | irqflags, ...), so it
runs in threaded (sleepable) context.  Should this read use
gpiod_get_value_cansleep() instead of gpiod_get_value()?  If ap-wake
is sourced from a sleeping GPIO controller (I2C/SPI expander, PMIC),
gpiod_get_value() will trip the WARN_ON(desc->gdev->can_sleep) in
gpiolib on every interrupt.  All other GPIO accesses in the driver
already use the *_cansleep variants.

> +
> +	switch (get_ipc_ap_wake(priv)) {
> +	case BASEBAND_XMM_IPC_AP_WAKE_IRQ_READY:
> +		if (!state) {
> +			set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_INIT1);
> +			pwrseq_power_on(priv->pwrseq);
> +		}
> +		break;
> +
> +	case BASEBAND_XMM_IPC_AP_WAKE_INIT1:
> +		if (state) {
> +			set_ipc_ap_wake(priv, BASEBAND_XMM_IPC_AP_WAKE_INIT2);
> +			schedule_delayed_work(&priv->modem_work,
> +					      msecs_to_jiffies(BASEBAND_XMM_INIT_DELAY));
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Medium]
Is the polarity of the IRQ_READY -> INIT1 transition consistent with
the comment above the enum?  The block comment states:

  AP wake interrupt keeps low util CP starts to initiate its HSIC hw.
  AP wake interrupt goes up during CP HSIC init
  (BASEBAND_XMM_IPC_AP_WAKE_INIT1 state)

So entering INIT1 corresponds to a rising edge (line goes high).  But
the handler enters INIT1 only when "!state" (line is low) and that's
where it calls pwrseq_power_on().  Either the comment is describing
the protocol incorrectly or the conditional checks the wrong polarity;
if the comment is accurate, the modem would never power on.  Could
this be clarified?

[Low]
For the non-DT path, irqflags is set to
IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING and the handler decides
which transition occurred by re-reading the GPIO.  The value seen in
the handler is the current level, not necessarily the level that
triggered the IRQ.  A coalesced fast L->H->L sequence (or a noisy
edge) can cause the handler to read a state that does not correspond
to the triggering edge, missing the INIT1 -> INIT2 transition or
jumping over states.  Should each edge be latched (e.g. by remembering
the previous level) instead of re-sampled?

> +
> +static int baseband_xmm_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	bitmap_zero(priv->state, BASEBAND_XMM_STATE_MAX);
> +	INIT_DELAYED_WORK(&priv->modem_work, baseband_xmm_work);
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
> +
> +	/*
> +	 * Systems using device tree should set up interrupt via DT,
> +	 * the rest will use the default edge both interrupt.
> +	 */
> +	irqflags = dev->of_node ? 0 : IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
> +
> +	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
> +					&baseband_hostwake_interrupt,
> +					IRQF_ONESHOT | irqflags,
> +					"modem-hostwake", priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IRQ %d\n", priv->irq);
> +
> +	priv->rfkill_dev = rfkill_alloc("xmm-modem", dev, RFKILL_TYPE_WWAN,
> +					&baseband_xmm_rfkill_ops, priv);
> +	if (!priv->rfkill_dev)
> +		return -ENOMEM;
> +
> +	ret = rfkill_register(priv->rfkill_dev);
> +	if (ret) {
> +		rfkill_destroy(priv->rfkill_dev);
> +		return dev_err_probe(dev, ret,
> +				     "failed to register WWAN rfkill\n");
> +	}

[High]
Once devm_request_threaded_irq() succeeds, the IRQ is live and the
handler can already step through IRQ_READY -> INIT1 (calling
pwrseq_power_on()) and on the next edge INIT1 -> INIT2, where it does:

    schedule_delayed_work(&priv->modem_work,
                          msecs_to_jiffies(BASEBAND_XMM_INIT_DELAY));

If rfkill_alloc() returns NULL or rfkill_register() fails, probe
returns an error.  devres releases the IRQ but does not cancel the
queued delayed work, and the devm_kzalloc()'d priv is then freed.
Five seconds later baseband_xmm_work() runs and dereferences priv
(priv->pwrseq, priv->state, priv->reset_gpio, priv->vbat_supply).

Should the error paths after devm_request_threaded_irq() call
cancel_delayed_work_sync(&priv->modem_work), or should the cancel be
registered via devm_add_action_or_reset()?

> +
> +	priv->nb.notifier_call = baseband_xmm_usb_notifier_call;
> +	usb_register_notify(&priv->nb);
> +
> +	return 0;
> +}

[High]
The ordering here is rfkill_register() first, usb_register_notify()
second.  rfkill_register() schedules sync_work, which runs the
set_block callback asynchronously.  Since this driver does not set
rfkill->persistent, the default state is unblocked, so set_block(false)
calls baseband_xmm_reset() -> regulator_enable() + GPIO toggling, and
the IRQ handler can step through IRQ_READY -> INIT1 -> INIT2 and
pwrseq_power_on() the modem, which then enumerates on USB.

If usb_register_notify() has not yet run when USB enumeration
completes, the USB_DEVICE_ADD notification is missed: STATE_PRESENT
is never set, the cancel_delayed_work_sync() in the notifier never
runs, and the 5-second watchdog work then calls baseband_xmm_poweroff()
on a working modem.

Should usb_register_notify() be called before rfkill_register()?

> +
> +static void baseband_xmm_remove(struct platform_device *pdev)
> +{
> +	struct baseband_xmm_data *priv = platform_get_drvdata(pdev);
> +
> +	rfkill_unregister(priv->rfkill_dev);
> +	rfkill_destroy(priv->rfkill_dev);
> +
> +	disable_irq(priv->irq);
> +	cancel_delayed_work_sync(&priv->modem_work);
> +
> +	usb_unregister_notify(&priv->nb);
> +	baseband_xmm_poweroff(priv);
> +}

[Medium]
Between cancel_delayed_work_sync() and usb_unregister_notify(), a
USB_DEVICE_REMOVE notification can still be in flight on another CPU
and call baseband_xmm_poweroff().  usb_unregister_notify() then waits
for that callback to complete, and immediately afterwards remove()
itself calls baseband_xmm_poweroff().  Combined with the
ad-hoc-locking concern above, this can result in pwrseq_power_off()
running twice and possibly regulator_disable() running twice.

Would unregistering the notifier first (before disable_irq /
cancel_delayed_work_sync) close that window?

[ ... ]

> +module_platform_driver(baseband_xmm_driver);
> +
> +MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");

[Low]
The name spelling here (Svyatolsav) does not match the file copyright
header or the patch's Signed-off-by ("Svyatoslav"); the 's' and 'l'
are transposed.

> +MODULE_DESCRIPTION("Baseband Infineon XMM6260 driver");
> +MODULE_LICENSE("GPL");
-- 
pw-bot: cr

