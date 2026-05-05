Return-Path: <netdev+bounces-284170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YyYuIENW+WkK8AIAu9opvQ
	(envelope-from <netdev+bounces-284170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 135244C5FE2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A8F3008D7F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22A35F5FE;
	Tue,  5 May 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgzbTG6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0A17AE11;
	Tue,  5 May 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948224; cv=none; b=MXge4LOXreiJesdDIm/mQah72Ji+weUrkF7TcIZjxCWtdtygskDmroXaJcNv80bxKZPokqAiTrVZZXLSzGrVIdyzvDne/AF3kmCSfMf7r8OuiMVQ9hvjAVS1CxLgzDeA3nMXxrVX8TnjImGjVbMKRe0z+QjgdM8q0mlg4kY5T/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948224; c=relaxed/simple;
	bh=YOM6rXiRYEUqkGpYEpmHf091AiABk15vO+zV8+XSaak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzfkKZgeuVQjTZDCys1/43swKoI18AyclFbrC1TPWELDDuR67+Dm4Ji0YHkF6izcBOa4xDcnEkERd3utCjjeQI+6vqh5NCVzmM+xnlYk/efrZlk7IXqG9lu1wo/Cn8tItjO6G8yTx9Ur/6KCiWy6/t7pyOYZcf3CTqBd9fuMan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgzbTG6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F2BC2BCB8;
	Tue,  5 May 2026 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948224;
	bh=YOM6rXiRYEUqkGpYEpmHf091AiABk15vO+zV8+XSaak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgzbTG6oQGdiOnyYu84DqDC8jEGZlPcO3eR0TzDFz/tK6xk7Fv391z33nkC0xLQZ2
	 /T8ipv6Vq93yJ+DCRlMC9milo4NYa47Tq2c8bcK3QpYRmFnF2IMBOWyAAfCzymWXPx
	 qUALrZSN0yvEqFk3BgGw0YkUziUfdtQCOhYtSocERlmvXgDsSRILRzS1LkyF7stQgp
	 EBAkqPy9a5FTtKHvZsMgor0Out8wVunz2ZHOSrD3JP7aLZAZjgUCppNOzOhFf8i65T
	 hTqktGEK9m/hgMxHkPso4ftjv+xWORq9/BKOLQRwUaMPvPJn2kx1J2Xr31YAw+rzit
	 QoUE6VcJrY77g==
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hsu.chih.kai@realtek.com,
	olek2@wp.pl
Subject: Re: [PATCH net-next v3 2/3] r8152: Add support for the RTL8159 chip
Date: Mon,  4 May 2026 19:30:22 -0700
Message-ID: <20260505023022.877676-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502-rtl8159_net_next-v3-2-12c895d46cd6@birger-koblitz.de>
References: <20260502-rtl8159_net_next-v3-2-12c895d46cd6@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 135244C5FE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,realtek.com,wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-284170-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: Add support for the RTL8159 chip

This patch adds support for the RTL8159 chip as RTL_VER_17, reusing the
RTL8157 initialization and USB power management paths. The bulk of the
new code lives in r8157_hw_phy_cfg() to configure the RTL8159 PHY, and
the USB product ID 0x815a is added to the device table.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 05abfab1df94..a2cdd57558c7 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -7996,7 +8005,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	/* Advanced Power Saving parameter */
>  	ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1));
>  
> -	/* aldpsce force mode */
> +	/* Disable ALDPS force mode */
>  	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
>  
>  	switch (tp->version) {
> @@ -8120,6 +8129,190 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
>  		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
>  		break;
> +
> +	case RTL_VER_17:
> +		/* Disable bypass turn off clk in ALDPS */
> +		 ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
         ^

Is the leading space before ocp_byte_clr_bits here intentional?  The rest
of the switch statement uses a single tab for indentation.  checkpatch.pl
should catch this.

> +
> +		/* Power level tuning
> +		 * test mode power level
> +		 */
> +		sram_write_w0w1(tp, 0x8415, 0xff00, 0x9300);
> +		/* normal link power level 10G, 5G, 2.5G */
> +		sram_write_w0w1(tp, 0x81a3, 0xff00, 0x0f00);
> +		sram_write_w0w1(tp, 0x81ae, 0xff00, 0x0f00);
> +		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
> +		/* nomal link TX filter */
              ^^^^^

Small typo, "nomal" -> "normal".

> +		sram2_write_w0w1(tp, 0x83b0, 0x0e00, 0);
> +		sram2_write_w0w1(tp, 0x83c5, 0x0e00, 0);
> +		sram2_write_w0w1(tp, 0x83da, 0x0e00, 0);
> +		sram2_write_w0w1(tp, 0x83ef, 0x0e00, 0);

[ ... ]

> +		/* Slave about EC mu of datamode AAGC  and DAC BG */
> +		sram2_write_w0w1(tp, 0x88ac, 0xff00, 0x2300);
> +		/* improve UBE */
> +		ocp_reg_set_bits(tp, 0xbf0c, 0x7 << 11);
> +		/* close Sparse NEC, improve connect 5EUU calble performace */
                                                      ^^^^^  ^^^^^^^^^

Two typos here, "calble" -> "cable" and "performace" -> "performance".

> +		sram2_write_w0w1(tp, 0x88de, 0xff00, 0);
> +		/* 5G slave compatibility issue (will include in v10) */
                                                 ^^^^^^^^^^^^^^^^^^

Is this "will include in v10" comment a reference to an internal Realtek
source-tree revision?  It does not appear to have meaning in the upstream
tree and could be dropped or rephrased.

> +		sram2_write(tp, 0x80b4, 0x5195);

[ ... ]

> +		sram2_write_w0w1(tp, 0x88d5, 0xff00, 0x0200);
> +		break;
> +
>  	default:
>  		break;
>  	}

[ ... ]

> @@ -8155,6 +8348,18 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	set_bit(PHY_RESET, &tp->flags);
>  }
>  
> +static int r8159_wait_backup_restore(struct r8152 *tp)
> +{
> +	u32 ocp_data;
> +
> +	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> +	if (!(ocp_data & PCUT_STATUS))
> +		return 0;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> +			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
> +}
> +
>  static void r8156_init(struct r8152 *tp)
>  {
>  	u32 ocp_data;

[ ... ]

> @@ -8201,6 +8407,11 @@ static void r8156_init(struct r8152 *tp)
>  			return;
>  	}
>  
> +	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
> +		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
> +		return;
> +	}
> +

On timeout this returns early from r8156_init() and skips the remainder of
the init sequence, including r8157_u2p3en()/r8157_power_cut_en(),
r8156_ups_en(), r8153_queue_wake(), rtl_runtime_suspend_enable(),
r8156_mac_clk_spd(), the rx aggregation / 16-byte Rx descriptor
configuration, r8156_mdio_force_mode(), rtl_tally_reset() and the
tp->coalesce assignment.

r8156_init() is void and rtl8152_probe_once() does not check init status,
so probe continues and register_netdev() runs after this early return.

Should this path also set RTL8152_INACCESSIBLE on tp->flags, or should the
init callback be changed to return an error that probe can honor, so that
a half-initialized device is not exposed to userspace?

>  	data = r8153_phy_status(tp, 0);
>  	if (data == PHY_STAT_EXT_INIT) {
>  		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));

[ ... ]

> @@ -8274,7 +8485,10 @@ static void r8156_init(struct r8152 *tp)
>  	set_bit(GREEN_ETHERNET, &tp->flags);
>  
>  	/* rx aggregation / 16 bytes Rx descriptor */
> -	if (tp->version == RTL_VER_16)
> +	if (tp->version == RTL_VER_17)
> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
                                                                 ^^^^^^

What does BIT(11) in USB_USB_CTRL correspond to here, and is it
RTL8159-specific?

The commit message says the RTL8159 "reuses hardware features of the
RTL8157 (RTL_VER_16)", but this path clears an extra bit that the
RTL_VER_16 path does not.  Since there is no symbolic name or comment,
it is hard to tell whether RTL_VER_16 is missing this clear, whether
RTL_VER_17 should not be clearing it, or whether it really is an
RTL8159-only quirk.

Could a named define and/or a short comment be added to describe what
this bit does?

> +	else if (tp->version == RTL_VER_16)
>  		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
>  	else
>  		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_ZERO_EN);

[ ... ]

