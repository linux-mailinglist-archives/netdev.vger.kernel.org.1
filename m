Return-Path: <netdev+bounces-297358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LGNHNNqqKGolHwMAu9opvQ
	(envelope-from <netdev+bounces-297358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:07:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E9664E5A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EjQ72vWb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297358-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F9E73019317
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E147081E;
	Wed, 10 Jun 2026 00:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B124B28;
	Wed, 10 Jun 2026 00:07:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050051; cv=none; b=T3BheX4QKJIzQ4qt7FRTZWaC6HM178nfwEdeXQwPktisjURRsI+lT5yyrYQZwgt1SO1wCVYqvuHgJSDFveMaZtMfZYZFj3xRGTp992LlOUTOpra/ChQVPoOfKO6yYS80EsnDiAWMEdOFw7Vq+tZ3i0nCAkm9i0twz3e/xGY1Kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050051; c=relaxed/simple;
	bh=EC9iAqLp8Y1SIBMzjZSESHZAitgXGgj0j/WwDwWogWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAiX3Qtf1tOoFuRimCdfDAp5CKRHZS53oJEvu8gpcn06cA2iE7Tkmhg6sZF0CWzKO8JVMU+Y7BWniGp4VYr9r/VyfE+i1saIwrCJzum3bG+y//HOK5LDDo8E5+UmvhWDO7mnFmrTSrMMxKpQEP+VgLAI8Y56VwfutT+ES4W5l68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjQ72vWb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA35E1F00893;
	Wed, 10 Jun 2026 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781050050;
	bh=ZzVYRLecZ/jmciy7WoL3aQ59H4ARVsOcTxLeNyB2lK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EjQ72vWbxaU4EJhuC+9l21Ve6hpAWiOcAiwvaC4avBRB2uDNSi+ZKcWQrj86Hj4RA
	 UajRtUO51XJSIVJH6838PS+VIiRrb1BfcrLDA7DJ+gUx6tQM7qqWG6V1+AxokPeI6l
	 PS2VFXUb9iLC0M9Qemzywrm94oo7SNErDBX283c6hzKyPRf7RqmmuipvWq2jkJeJOC
	 nq1R86mocmhWB7fJ3OT6Hv7QVtkXpqltVva9oJ5gmqNfSpug+4q2qFqzr9o6AcncQ0
	 nK95TZFKWjmqAt28oh2J7vz5Zd5gcUXUHXKxDG4X24JELnjfnKhXchyUuhp/RDxWPS
	 5BKAdhs/cTNLQ==
Date: Tue, 9 Jun 2026 17:07:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Greg Patrick <gregspatrick@hotmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
Message-ID: <20260609170728.38132421@kernel.org>
In-Reply-To: <20260604151614.3310544-1-gregspatrick@hotmail.com>
References: <20260604151614.3310544-1-gregspatrick@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[hotmail.com,armlinux.org.uk,lunn.ch,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-297358-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA5E9664E5A

On Thu,  4 Jun 2026 15:16:14 +0000 Greg Patrick wrote:
> An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
> GPIO currently falls back to sff_gpio_get_state(), which unconditionally
> reports the module as present. An empty cage therefore fails its probe and
> is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
> there is no REMOVE event to recover the state machine, so a module inserted
> after boot is never detected, and empty cages spam -EIO at boot.
> 
> This affects boards that route none of the cage presence signal to a
> software-readable input. On the NicGiga S100-0800S-M (RTL9303, 8x SFP+) the
> cage I2C bus is the switch's SMBus master; TX_DISABLE is driven via a
> PCA9534 I/O expander, but no MOD_ABS/MOD_DEF0 line reaches a readable GPIO
> (the RTL9303 gpio0 lines read stuck-low, the single PCA9534 is fully
> consumed by TX_DISABLE, and there is no RTL8231).
> 
> For such an SFP cage, derive presence from a throttled single-byte I2C read
> of the module EEPROM instead: an ACK asserts SFP_F_PRESENT, two consecutive
> failures clear it (to ride out a transient error on a live module). The
> existing poll then emits SFP_E_INSERT / SFP_E_REMOVE normally, giving
> working hot-plug and silencing the boot-time -EIO spam on empty cages.
> 
> A soldered-down module (compatible "sff,sff") has no presence signal and is
> genuinely always present, so it continues to use sff_gpio_get_state(); the
> new path is gated on the cage type advertising SFP_F_PRESENT.
> 
> Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>

Hi Maxime!

I think both Russell and Andrew are (semi-) AFK.
Would you be able to review this patch?

> v2:
>  - Keep sff_gpio_get_state() and gate the new I2C-probe presence on the
>    cage advertising SFP_F_PRESENT (an "sff,sfp" cage), so a soldered
>    "sff,sff" module keeps its always-present behaviour. (Andrew Lunn)
>  - Reword the commit message to state precisely that no presence signal
>    reaches a readable input on the affected board, and that the cage bus
>    is the RTL9303 SMBus master. (Andrew Lunn)
>  - On using a 0-byte read like i2cdetect: not available on this board --
>    the cage master advertises only I2C_FUNC_SMBUS_BYTE_DATA (no
>    I2C_FUNC_I2C, no SMBus Quick Command), so sfp_i2c_configure() selects
>    sfp_smbus_byte_read() and a 1-byte read is the lightest presence
>    primitive; it also works through sfp->read on both raw-I2C and
>    SMBus-only adapters, whereas a zero-length transfer does not. (Andrew Lunn)
> 
> v1: https://lore.kernel.org/netdev/20260602235528.2795028-1-gregspatrick@hotmail.com/
> 
>  drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 376c705a9..056bbe6de 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -206,6 +206,11 @@ static const enum gpiod_flags gpio_flags[] = {
>  #define T_PROBE_RETRY_SLOW	msecs_to_jiffies(5000)
>  #define R_PROBE_RETRY_SLOW	12
>  
> +/* Interval at which sfp_i2c_get_state() re-probes the I2C bus for module
> + * presence on boards without a MOD_DEF0 GPIO (see sfp_i2c_get_state()).
> + */
> +#define T_PROBE_PRESENT		msecs_to_jiffies(2000)
> +
>  /* SFP modules appear to always have their PHY configured for bus address
>   * 0x56 (which with mdio-i2c, translates to a PHY address of 22).
>   * RollBall SFPs access phy via SFP Enhanced Digital Diagnostic Interface
> @@ -249,6 +254,13 @@ struct sfp {
>  
>  	bool need_poll;
>  
> +	/* I2C-probed presence, for boards without a MOD_DEF0 GPIO.
> +	 * Access rules: st_mutex held (updated from the poll/state machine).
> +	 */
> +	bool i2c_present;
> +	u8 i2c_present_nak;
> +	unsigned long i2c_present_next;
> +
>  	/* Access rules:
>  	 * state_hw_drive: st_mutex held
>  	 * state_hw_mask: st_mutex held
> @@ -863,6 +875,44 @@ static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
>  	return sfp->read(sfp, a2, addr, buf, len);
>  }
>  
> +/* Probe whether a module is physically present by attempting a single-byte
> + * I2C read of the EEPROM identifier (an empty cage NAKs). Used as the presence
> + * source on boards that do not wire MOD_DEF0 to a GPIO.
> + */
> +static bool sfp_module_present_i2c(struct sfp *sfp)
> +{
> +	u8 id;
> +
> +	return sfp_read(sfp, false, SFP_PHYS_ID, &id, sizeof(id)) == sizeof(id);
> +}
> +
> +/* get_state variant for boards without a MOD_DEF0 GPIO. Instead of assuming
> + * the module is always present, derive SFP_F_PRESENT from a throttled I2C
> + * probe so that hot-insertion and removal are detected. A single ACK asserts
> + * presence; two consecutive failures clear it, to ride out a transient I2C
> + * error on a live module.
> + */
> +static unsigned int sfp_i2c_get_state(struct sfp *sfp)
> +{
> +	unsigned int state = sfp_gpio_get_state(sfp);
> +
> +	if (time_after_eq(jiffies, sfp->i2c_present_next)) {
> +		if (sfp_module_present_i2c(sfp)) {
> +			sfp->i2c_present = true;
> +			sfp->i2c_present_nak = 0;
> +		} else if (sfp->i2c_present && ++sfp->i2c_present_nak >= 2) {
> +			sfp->i2c_present = false;
> +			sfp->i2c_present_nak = 0;
> +		}
> +		sfp->i2c_present_next = jiffies + T_PROBE_PRESENT;
> +	}
> +
> +	if (sfp->i2c_present)
> +		state |= SFP_F_PRESENT;
> +
> +	return state;
> +}
> +
>  static int sfp_write(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
>  {
>  	return sfp->write(sfp, a2, addr, buf, len);
> @@ -3168,9 +3218,30 @@ static int sfp_probe(struct platform_device *pdev)
>  	sfp->get_state = sfp_gpio_get_state;
>  	sfp->set_state = sfp_gpio_set_state;
>  
> -	/* Modules that have no detect signal are always present */
> -	if (!(sfp->gpio[GPIO_MODDEF0]))
> -		sfp->get_state = sff_gpio_get_state;
> +	/* An SFP cage with no MOD_DEF0 GPIO has no hardware presence signal.
> +	 * Assuming the module is always present traps an empty cage in
> +	 * MOD_ERROR and never detects hot-insertion, so derive presence from a
> +	 * throttled I2C probe and poll for changes instead. sfp_i2c_configure()
> +	 * has already set i2c_max_block_size; seed i2c_block_size so the
> +	 * presence read does not issue a zero-length transfer before the first
> +	 * EEPROM read. Seed i2c_present_next to jiffies so the first probe
> +	 * happens immediately (a zero value would be in the past relative to
> +	 * the negative INITIAL_JIFFIES at boot and delay detection).
> +	 *
> +	 * A soldered-down module (sff,sff) has no presence signal and is
> +	 * genuinely always present, so it keeps the always-present behaviour;
> +	 * the I2C probe is gated on the cage type advertising SFP_F_PRESENT.
> +	 */
> +	if (!sfp->gpio[GPIO_MODDEF0]) {
> +		if (sff->gpios & SFP_F_PRESENT) {
> +			sfp->get_state = sfp_i2c_get_state;
> +			sfp->i2c_block_size = sfp->i2c_max_block_size;
> +			sfp->i2c_present_next = jiffies;
> +			sfp->need_poll = true;
> +		} else {
> +			sfp->get_state = sff_gpio_get_state;
> +		}
> +	}
>  
>  	device_property_read_u32(&pdev->dev, "maximum-power-milliwatt",
>  				 &sfp->max_power_mW);


