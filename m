Return-Path: <netdev+bounces-256832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KYrD1bCg2mbuAMAu9opvQ
	(envelope-from <netdev+bounces-256832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:04:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B9ECEA1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0340B300D155
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105C2EA168;
	Wed,  4 Feb 2026 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QX8FJnsw"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAF262A6
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242643; cv=none; b=nqFQtNzC08IXIdKWK/+9BFcba937V3QjQBAf3oDNlV3Csp+B2G2rYw/9Sd0aIZ6z8ecl/UgfBABPhblgOXGJEj0x57TGTcn6mVcMCoNXbbEVf22b/wpMKZOqFoBHeufpQCxGLSXWG9GUqKkVbKb6Hj3pv/iQTJsKC4t4jl1vS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242643; c=relaxed/simple;
	bh=jDFqO+g2OcpArkcwt6C1iHwflk+ZmD+tFdd5a1y0Tn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWxxfsMsPsqleOCJBVqNPxnr3eIEZwPOpP/5G3xkGH3doCu0k1AQNOD++N604XtK6EK74ux5czMZlniTKHI8PH7mO5hL7S73Gftgl3tIjEvxYUPHmGY6iZwUf889m68fYgOgQWBksBveaxfpyZ1KAo27jDyM0x4YbpUp9e27QL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QX8FJnsw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=sjPwyNGA9xy8POgiuW0Tq0QzH0cSNVPVKMgCL48PxsA=; b=QX8FJnswsoHYefLJ2uxQ9cSJdv
	Ct7M/Ce3CQEZOx/pMyy8ZhYfHLFD5QUUNGFRvi3xXcRIFiN1o8D0V1cOhCKgfc31bzbLOxMRiM0cv
	rNEgb3KmbBBE+QrZtzh6+pVAoW5d43BCoKPCc+dni1OQfT7Kd+/jro0rbIt8ZNSvrebbDjIyVVX6y
	Q9MpyLZo95PnPlSFE3bePul4W5Uo+DZ0v+3AQqyIXgkGYpclY4FgxQBEMkhQOj5hjQ/Gi7NvaKneT
	FKh93TtRfz00xQZY6kCekx9qcI3QW/pyqyCtMRvNX3jtbc+5AC5+LPgtv7LGGYj9B+M0Ouq+2Nu47
	pTQ5b9FQ==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnkyV-0071Wm-Sl; Wed, 04 Feb 2026 23:03:52 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 5/6] net: stmmac: rk: use rk_encode_wm16() for clock
 selection
Date: Wed, 04 Feb 2026 23:03:51 +0100
Message-ID: <20297648.sWSEgdgrri@diego>
In-Reply-To: <E1vnYy6-00000007hp9-1AJM@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYy6-00000007hp9-1AJM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256832-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 910B9ECEA1
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:38 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> Use rk_encode_wm16() for RMII clock gating control, and also for the
> io_clksel bit used to select the transmit clock between CRU-derived
> and IO-derived clock sources.
>=20
> Both of these were configured via the "set_clock_selection" method in
> the SoC specific operations, but there is no requirement to change the
> io_clksel except when enabling clocks.
>=20
> It is also possible that we don't need to ungate the RMII clock if we
> are operating in RGMII mode, but this commit makes no change there.
>=20
> Split up the configuration of these as separate functions, and remove
> the set_clock_selection() method. Since these clocking bits are in the
> same register that we call the "speed" register, move the logic for
> writing that register into rk_write_speed_grf_reg().
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 174 ++++++++----------
>  1 file changed, 75 insertions(+), 99 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 4099cbc5d0de..ed9adac70f0a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -27,8 +27,17 @@
>  struct rk_priv_data;
> =20
>  struct rk_clock_fields {
> +	/* io_clksel_cru_mask - io_clksel bit in clock GRF register which,
> +	 * when set, selects the tx clock from CRU.
> +	 */
> +	u16 io_clksel_cru_mask;
> +	/* io_clksel_io_mask - io_clksel bit in clock GRF register which,
> +	 * when set, selects the tx clock from IO.
> +	 */

nit: comment stile does not seem to follow the kernel coding style
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-style.rst#n622

> +	u16 io_clksel_io_mask;
>  	u16 gmii_clk_sel_mask;
>  	u16 rmii_clk_sel_mask;
> +	u16 rmii_gate_en_mask;
>  	u16 mac_speed_mask;
>  };

[...]

> +	/* The io_clksel configuration can be either:
> +	 *  0=3DCRU, 1=3DIO (rk3506, rk3520, rk3576) or
> +	 *  0=3DIO, 1=3DCRU (rk3588)
> +	 * where CRU means the transmit clock comes from the CRU and IO
> +	 * means the transmit clock comes from IO.
> +	 *
> +	 * Handle this by having two masks.
> +	 */

nit: same as above

Other than these 2 nits, this looks good to me.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588




