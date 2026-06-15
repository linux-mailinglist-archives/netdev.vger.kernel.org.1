Return-Path: <netdev+bounces-299373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtsnAPHBL2q6FwUAu9opvQ
	(envelope-from <netdev+bounces-299373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914A684ECF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=adjajgKU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9050C30465F2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9C3CF206;
	Mon, 15 Jun 2026 09:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B413C2BAC;
	Mon, 15 Jun 2026 09:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514496; cv=none; b=cMBRjFhumLj5jDIaxsSa4EHzA1o/3WttCOK84sWq7l6XriLayGzTqjRUYlAfv42O1KS8M1JdCIwq8TPOHPnZYjPeULo8lnLqOKvfQvAZSOEoutdqMnlAC1kMUDO1ihw4eyRZXdFLNCWS0ZAjDF9UQ8KkARCdqVILXVyaAzCH4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514496; c=relaxed/simple;
	bh=UBQ3UcLPjRIMTkPWF2+utSaOLYSar8jA7aT4PmlpIa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqhJW7iJfSScilI68YWXsvJ65b4unpXyE9oZzmBVQRAg7YSBejSTGA8izpkSrXIb8Pzgo7n5kUdKSvEHCL6sRMBNi7RX8Sn1tn10PZvKxY2Yw+TJjCzYOtrJCdQWTzkXKVjIL6SSNo8bIHPJbjAtBCqQyM0F4/LlsOOGkRqnIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adjajgKU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA251F000E9;
	Mon, 15 Jun 2026 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514492;
	bh=wg8fBQfnN9gNnALaLS/O6GaJwTABoRT4jJ3YV+TtFLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adjajgKUvGOaFCLS2TpY/h4uFBKu4qtoaFZGs1yLcikx0xc/sxz06HIcpswGq0j6t
	 0+N5gds5sg082waUrjzIk8hbY1WF1fpC5peeKda5yKrQ7H4tvLIRdYPaawIt0acNjh
	 xLfpeFfwsWeCJY9BVR83KPCU7CaucA88iUc036RlJz2rLs33trVh649kTyfn9MFZhL
	 ODu7JkRxQumCQ4H9Uza1YzuSUeFi8f7du8CQiBoOBFZheOBgbRJcyzke0aqhXwG2Ii
	 Iu5UJFCRcUgWkxEkCi2dKE7FHwROkHNm6a/qptDAUqjDK7h+RXI2gND5E1OLIkl1Cr
	 A1acw10vItEgw==
From: Simon Horman <horms@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@makrotopia.org,
	bjorn@mork.no
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU driver
Date: Mon, 15 Jun 2026 10:07:33 +0100
Message-ID: <20260615090733.739423-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612132944.460646-3-jelonek.jonas@gmail.com>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299373-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4914A684ECF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: pse-pd: add Realtek/Broadcom PSE MCU driver

This patch adds a driver for a microcontroller that fronts Realtek and
Broadcom PSE silicon on PoE switches, exposing the MCU over I2C/SMBus or
UART using a 12-byte fixed-frame protocol. The driver is split into a
shared core plus two transport modules, with a per-dialect opcode table
and parser hooks for the Realtek vs Broadcom variants.

> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> index 7ef29657ee5d..b065b19db126 100644
> --- a/drivers/net/pse-pd/Kconfig
> +++ b/drivers/net/pse-pd/Kconfig
> @@ -13,6 +13,34 @@ menuconfig PSE_CONTROLLER
>  
>  if PSE_CONTROLLER
>  
> +config PSE_REALTEK
> +	tristate
> +	help
> +	  Shared core for the Realtek/Broadcom PSE MCU driver. This is
> +	  selected automatically by the transport options below.
> +
> +config PSE_REALTEK_I2C
> +	tristate "Realtek/Broadcom PSE MCU driver (I2C transport)"
> +	depends on I2C
> +	select PSE_REALTEK
> +	help
> +	  Driver for the microcontroller (MCU) that fronts the PSE
> +	  hardware on switches with Realtek or Broadcom PSE chips, attached
> +	  via I2C/SMBus. The MCU exposes a message-based protocol; the actual
> +	  PSE silicon is not accessed directly. To compile this driver as a
> +	  module, choose M here: the module will be called realtek-pse-i2c.
> +
> +config PSE_REALTEK_UART
> +	tristate "Realtek/Broadcom PSE MCU driver (UART transport)"
> +	depends on SERIAL_DEV_BUS
> +	select PSE_REALTEK
> +	help
> +	  Driver for the microcontroller (MCU) that fronts the PSE
> +	  hardware on switches with Realtek or Broadcom PSE chips, attached
> +	  via UART. The MCU exposes a message-based protocol; the actual PSE
> +	  silicon is not accessed directly. To compile this driver as a
> +	  module, choose M here: the module will be called realtek-pse-uart.
> +

[Medium]
The realtek, vendor prefix is used for both the Realtek dialect and the
Broadcom dialect compatibles (realtek,pse-mcu-rtk and
realtek,pse-mcu-bcm), and the binding documentation explicitly notes
that the prefix "reflects the platform" rather than the silicon vendor.
DT compatibles are stable ABI once accepted.

Would a brcm, prefix (or per-MCU-part compatibles) for the Broadcom
dialect be more appropriate, given that the BCM variant uses Broadcom
PSE silicon driven by an MCU built by Nuvoton or STMicro and has no
Realtek involvement?

Similarly, would describing the I2C wire framing (native vs SMBus) via
separate compatibles be preferable to encoding it in the
realtek,i2c-protocol DT property, and would describing the actual PSE
chip in DT (rather than relying on runtime device-id detection) match
the usual binding patterns?

>  config PSE_REGULATOR
>  	tristate "Regulator based PSE controller"
>  	help

[ ... ]

> diff --git a/drivers/net/pse-pd/realtek-pse-core.c b/drivers/net/pse-pd/realtek-pse-core.c
> new file mode 100644
> index 000000000000..3a601cfb6280
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-core.c

[ ... ]

> +static int rtpse_port_cmd(struct rtpse_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
> +{
> +	struct rtpse_mcu_msg req, resp;
> +	int ret;
> +
> +	rtpse_mcu_msg_init(&req, opcode);
> +	req.payload[0] = port;
> +	req.payload[1] = arg;
> +
> +	ret = rtpse_do_xfer(pse, &req, &resp);
> +	if (ret)
> +		return ret;
> +
> +	if (resp.payload[0] != port || resp.payload[1] != 0)
> +		return -EIO;
> +
> +	return 0;
> +}

[Medium]
Can an all-zero 12-byte buffer be silently accepted as a successful
PORT_ENABLE/PORT_DISABLE on the BCM dialect for port 0?

For the BCM dialect, RTPSE_CMD_PORT_ENABLE maps to opcode 0x00, and the
checksum of eleven zero bytes is 0, so an all-zero response passes the
opcode and checksum checks in rtpse_do_xfer():

	if (resp->opcode != req->opcode ||
	    resp->checksum != rtpse_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
		return -EBADMSG;

rtpse_port_cmd() then verifies payload[0] == port and payload[1] == 0,
both of which pass when port == 0 and arg is 0 (disable) or when arg is
1 but the MCU never observed the command and the buffer is all zero
anyway since payload[1] is checked against 0.

The seq_num field exists in struct rtpse_mcu_msg and is filled with 0xff
by rtpse_mcu_msg_init() but is never checked on the response side. Could
a seq_num round-trip check (or a non-zero opcode sentinel for the BCM
dialect) reject stale or zeroed-out frames here?

[ ... ]

> +static int rtpse_discover(struct rtpse_ctrl *pse, struct rtpse_mcu_info *info)
> +{
> +	struct rtpse_mcu_ext_config ext_config;
> +	unsigned long deadline;
> +	int ret;
> +
> +	/*
> +	 * The MCU may not answer on the bus yet right after power-up or
> +	 * enable-gpios assertion: depending on the transport it either stays
> +	 * silent (-ETIMEDOUT) or does not ACK its address at all (-ENXIO /
> +	 * -EREMOTEIO). Retry within a bounded wall-time window so a slow boot
> +	 * still probes, while a genuinely unresponsive MCU fails with its real
> +	 * error instead of deferring forever and masking it.
> +	 */
> +	deadline = jiffies + msecs_to_jiffies(RTPSE_MCU_BOOT_TIMEOUT_MS);
> +	do {
> +		ret = rtpse_mcu_get_info(pse, info);
> +		if (ret != -ETIMEDOUT && ret != -ENXIO &&
> +		    ret != -EREMOTEIO && ret != -EAGAIN)
> +			break;
> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
> +	} while (time_before(jiffies, deadline));

[Low]
The comment says the loop is meant to tolerate a slow-boot MCU, but the
retry whitelist excludes -EBADMSG and -EIO.

rtpse_do_xfer() returns -EBADMSG when the opcode or checksum mismatch
fires, and rtpse_port_query()/rtpse_port_cmd() return -EIO when the
echoed port byte does not match the request. On a UART-attached MCU
that emits a single garbled frame while its serial peripheral
stabilises, or on an I2C-attached MCU that returns stale boot-ROM bytes
right after enable-gpios assertion, the first attempt would surface as
one of those errors rather than -ETIMEDOUT or -ENXIO, and the loop
would break out immediately.

Should -EBADMSG (and arguably -EIO) be added to the retry set so the
documented intent matches the actual behaviour?

[ ... ]

> +int rtpse_register(struct rtpse_ctrl *pse)
> +{

[ ... ]

> +	if (!info.system_enable) {
> +		ret = rtpse_set_global_state(pse, true);
> +		/* Dialects without a global-state concept (e.g. BCM) return
> +		 * -EOPNOTSUPP; treat that as "no separate enable required".
> +		 */
> +		if (ret && ret != -EOPNOTSUPP)
> +			return dev_err_probe(pse->dev, ret,
> +					     "failed to enable PSE system\n");
> +	}
> +
> +	ret = regulator_enable(pse->poe_supply);
> +	if (ret)
> +		return dev_err_probe(pse->dev, ret, "failed to enable PoE supply\n");
> +
> +	ret = devm_add_action_or_reset(pse->dev, rtpse_regulator_disable, pse->poe_supply);
> +	if (ret)
> +		return ret;

[Low]
If rtpse_set_global_state(pse, true) succeeds but a later step in
rtpse_register() fails (regulator_enable, devm_add_action_or_reset, or
devm_pse_controller_register), is the MCU left with the PSE subsystem
enabled while the kernel detaches?

The regulator is rolled back via rtpse_regulator_disable through
devm_add_action_or_reset, but there does not seem to be a matching
devm_add_action_or_reset to call rtpse_set_global_state(false) on
probe-failure or driver-removal. Is that asymmetry intentional?

[ ... ]

> diff --git a/drivers/net/pse-pd/realtek-pse-uart.c b/drivers/net/pse-pd/realtek-pse-uart.c
> new file mode 100644
> index 000000000000..785407b379a4
> --- /dev/null
> +++ b/drivers/net/pse-pd/realtek-pse-uart.c

[ ... ]

> +static size_t rtpse_uart_receive(struct serdev_device *serdev,
> +				 const u8 *buf, size_t count)
> +{
> +	struct rtpse_uart *ctx = serdev_device_get_drvdata(serdev);
> +	bool done = false;
> +	size_t take;
> +
> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock) {
> +		take = min(count, sizeof(ctx->rx_buf) - ctx->rx_len);
> +		if (take) {
> +			memcpy(ctx->rx_buf + ctx->rx_len, buf, take);
> +			ctx->rx_len += take;
> +			done = (ctx->rx_len == sizeof(ctx->rx_buf));
> +		}
> +	}
> +	if (done)
> +		complete(&ctx->rx_done);
> +
> +	/* consume all to avoid desync/misalignment */
> +	return count;
> +}

[ ... ]

> +static int rtpse_uart_send(struct rtpse_ctrl *pse, const struct rtpse_mcu_msg *req)
> +{
> +	struct rtpse_uart *ctx = to_rtpse_uart(pse);
> +	int written;
> +
> +	/* clear any leftover rx state before transmitting */
> +	reinit_completion(&ctx->rx_done);
> +	scoped_guard(spinlock_irqsave, &ctx->rx_lock)
> +		ctx->rx_len = 0;

[High]
Is there a race between reinit_completion() here and the asynchronous
serdev receive_buf callback when a previous transaction has timed out
with bytes still in flight?

reinit_completion() is an unlocked x->done = 0 write, and the matching
complete() in rtpse_uart_receive() is called outside rx_lock. The
following interleave seems possible:

  rtpse_uart_send() runs reinit_completion()       /* done = 0 */
  rtpse_uart_receive() takes rx_lock, fills rx_buf
    to 12 bytes, computes done=true, releases lock
  rtpse_uart_send() takes rx_lock, sets rx_len = 0,
    releases lock
  rtpse_uart_receive() calls complete(&ctx->rx_done) /* done = 1 */
  rtpse_uart_send() writes the new request
  rtpse_uart_recv() wait_for_completion_timeout()
    returns immediately (done was 1), then sees
    rx_len == 0 and returns -EIO

rtpse_discover()'s retry whitelist covers -ETIMEDOUT, -ENXIO,
-EREMOTEIO, and -EAGAIN but not -EIO, so a single occurrence of this
race during the boot retry window would break out of the loop and turn
into a permanent dev_err_probe() failure.

Would moving complete() inside rx_lock in rtpse_uart_receive(), or
performing reinit_completion() and rx_len = 0 together inside rx_lock
while excluding the completer, close this window?

> +
> +	written = serdev_device_write(ctx->serdev, (const u8 *)req, sizeof(*req),
> +				      RTPSE_UART_TX_TIMEOUT);
> +	if (written < 0)
> +		return written;
> +	if (written != sizeof(*req))
> +		return -EIO;
> +
> +	return 0;
> +}

[ ... ]

