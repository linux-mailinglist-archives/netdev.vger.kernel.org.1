Return-Path: <netdev+bounces-304007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e4wSBmEQRmoiIwsAu9opvQ
	(envelope-from <netdev+bounces-304007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566C6F413C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304007-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304007-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6150302658C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFE38F925;
	Thu,  2 Jul 2026 07:13:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C038E8DC;
	Thu,  2 Jul 2026 07:13:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976389; cv=none; b=PCsS2uJS+06LGvIeMK0rnNvulXPyj9fGb7RBC50zlCmRIUCQVtZZXsImeEhnogXtFVoRVyI0hsToDBLvmq7PSBqrmfBi60muxgUibi+t+K3S7OaIzAkK7+OUPWZrsHrq7t0MoKCO+1RDLnRKfRXcG9GfumvNdUez2FOZLCVnaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976389; c=relaxed/simple;
	bh=QypvFCHvOgZ4g7vX3sMWHeIMkrjkcfjm8eROUXTFqk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps/TG/B/alBwUufoZUzHZb702JFrSgBxqkN9KruVYXv5FBIGkA5Xj2onjxOe/lxl/xdjbWWhkNOpTG8lFK3e7zZOeVpMb1nbeShFcbb93cEcoe30Wn1x6Gm9w9WUgHDaPHlg4tfgAnwRiPAvcbmdQy4CSCRcSUgx1VsVs69GnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4694B2003DD;
	Thu, 02 Jul 2026 09:13:02 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wfBba-005hya-0Y;
	Thu, 02 Jul 2026 09:13:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wfBba-0000000DEQZ-0Bxw;
	Thu, 02 Jul 2026 09:13:02 +0200
Date: Thu, 2 Jul 2026 09:13:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v4 2/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU driver
Message-ID: <akYPfkRbEzWFuC6j@pengutronix.de>
References: <20260630105651.756058-1-jelonek.jonas@gmail.com>
 <20260630105651.756058-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630105651.756058-3-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-304007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6566C6F413C

Hi Jonas,

On Tue, Jun 30, 2026 at 10:56:50AM +0000, Jonas Jelonek wrote:
> A range of PoE switches use a small microcontroller on the PCB to front
> the actual PSE silicon. The host CPU talks to that MCU over I2C/SMBus or
> UART using a fixed 12-byte request/response protocol with a trailing
> checksum; the PSE chips are managed by the MCU and are not accessed
> directly. The same protocol family is spoken by Realtek and Broadcom PSE
> MCUs, diverging in opcode numbering and a few response layouts, which the
> driver abstracts behind a per-dialect opcode table and parser hooks
> selected by the compatible. The specific PSE chip behind the MCU is
> detected at runtime and only influences per-chip constants (power scaling
> and the per-port cap).
> 
> The driver is split into a shared core and two transport modules:
> 
> - PSE_REALTEK_MCU: protocol, message framing, dialect machinery, and the
>   pse_controller_ops glue.
> - PSE_REALTEK_MCU_I2C / PSE_REALTEK_MCU_UART: transport modules
>   registering the MCU on an I2C bus or a serdev port respectively.
> 
> The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
> realtek,pse-mcu-rtk / realtek,pse-mcu-brcm compatibles: all name the
> Realtek PSE-MCU front-end, not the MCU silicon or the PSE chip behind
> it (see the binding for the prefix rationale). Broadcom PSE MCUs speak
> the same protocol family and are handled by the same shared core
> through the dialect abstraction selected by the '-brcm' compatible.
> 
> Power budgeting is left to the MCU firmware; the driver advertises
> PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

LGTM, there are some nitpicks from my side
otherwise:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

...
> +/* Shorthand for the designated-initializer entries in dialect opcode tables. */
> +#define RTPSE_MCU_OP(opc)	{ .op = (opc), .valid = true }
> +
> +/* Forward-declared so dialects can supply response parsers (defined below). */

No forward declarations please move the structs here.

> +struct rtpse_mcu_info;
> +struct rtpse_mcu_port_status;
> +
> +struct rtpse_mcu_dialect {
> +	struct rtpse_mcu_opcode opcode[RTPSE_MCU_NUM_CMDS];
> +
> +	/*
> +	 * Response parsers. Each dialect must supply its own; the core calls
> +	 * these unconditionally rather than carrying a default that would
> +	 * silently mis-decode bytes from a dialect that forgot to set them.
> +	 */
> +	int (*parse_system_info)(const u8 *payload, struct rtpse_mcu_info *info);
> +	int (*parse_port_class)(const struct rtpse_mcu_port_status *status);
> +	const char *(*mcu_type_str)(unsigned int mcu_type);
> +};
> +struct rtpse_mcu_port_config {
> +	bool enable;

in this struct we use only enable, do you plan to wire it somewhere
later? I assume you wont to keep it as documentation. May be add some
debug traces? And add some comments what do you already know about this
fields.

> +	u8 function_mode;
> +	u8 detection_type;
> +	u8 cls_type;
> +	u8 disconnect_type;
> +	u8 pair_type;
> +};
> +
> +struct rtpse_mcu_port_ext_config {

Same here.

> +	u8 inrush_mode;
> +	u8 limit_type;
> +	u8 max_power;
> +	u8 priority;
> +	u8 chip_addr;
> +	u8 channel;
> +};


> +static int rtpse_mcu_port_set_pw_limit(struct pse_controller_dev *pcdev, int id, int max_mW)
> +{
> +	const struct rtpse_mcu_opcode *type_opc, *val_opc;
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
> +	const struct rtpse_mcu_chip_info *chip = pse->chip;
> +	unsigned int prg_val;
> +	int ret;
> +
> +	if (max_mW < 0 || max_mW > chip->max_mW_per_port)
> +		return -ERANGE;
> +
> +	type_opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE];
> +	val_opc = &pse->dialect->opcode[chip->pw_set_cmd];
> +	if (!type_opc->valid || !val_opc->valid)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Switch the port to user-defined limit mode first, then program the
> +	 * limit value. If the second cmd fails, the port is left in
> +	 * user-defined mode but with the previous limit value; the next
> +	 * successful set_pw_limit call recovers it.
> +	 */
> +	ret = rtpse_mcu_port_cmd(pse, id, type_opc->op, RTPSE_MCU_PORT_PW_LIMIT_TYPE_USER);
> +	if (ret)
> +		return ret;
> +
> +	prg_val = min_t(unsigned int, max_mW / chip->pw_set_lsb_mW, 0xff);

Add some define for 0xff.
Can max_mW be zero?

> +
> +	return rtpse_mcu_port_cmd(pse, id, val_opc->op, prg_val);
> +}
> +
> +static int rtpse_mcu_port_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
> +					      struct pse_pw_limit_ranges *out)
> +{
> +	struct ethtool_c33_pse_pw_limit_range *range;
> +	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);

In the drivers/net, All declarations should be in reverse tree style.

> +	range = kzalloc_obj(*range, GFP_KERNEL);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	range[0].min = 0;
> +	range[0].max = pse->chip->max_mW_per_port;
> +
> +	out->c33_pw_limit_ranges = range;
> +	return 1;
> +}
> +


> +static int rtpse_mcu_discover(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_info *info)
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
> +		if (ret != -ETIMEDOUT && ret != -ENXIO && ret != -EREMOTEIO &&
> +		    ret != -EAGAIN)

For this section sashiko has an opinion:
https://sashiko.dev/#/patchset/20260630105651.756058-1-jelonek.jonas%40gmail.com

> +			break;
> +		msleep(RTPSE_MCU_BOOT_RETRY_MS);
> +	} while (time_before(jiffies, deadline));
> +	if (ret)
> +		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
> +
> +	switch (info->device_id) {
> +	case RTPSE_MCU_DEVICE_ID_RTL8238B:
> +		pse->chip = &rtl8238b_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_RTL8239:
> +		pse->chip = &rtl8239_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_RTL8239C:
> +		pse->chip = &rtl8239c_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_BCM59111:
> +		pse->chip = &bcm59111_info;
> +		break;
> +	case RTPSE_MCU_DEVICE_ID_BCM59121:
> +		pse->chip = &bcm59121_info;
> +		break;
> +	default:
> +		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
> +				     info->device_id);
> +	}
> +
> +	if (!info->max_ports || info->max_ports > RTPSE_MCU_MAX_PORTS)
> +		return dev_err_probe(pse->dev, -EINVAL,
> +				     "MCU reports invalid port count %u\n", info->max_ports);
> +
> +	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
> +	if (ret)
> +		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
> +
> +	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
> +		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
> +		 info->device_id, info->max_ports, ext_config.num_of_pses);

Reduce it to debug level print.

> +	return 0;
> +}
> +

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

