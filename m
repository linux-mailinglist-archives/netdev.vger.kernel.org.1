Return-Path: <netdev+bounces-257018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGt+N19KhGk/2QMAu9opvQ
	(envelope-from <netdev+bounces-257018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:44:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA4EF8AE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD62330013A3
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869835D61E;
	Thu,  5 Feb 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JD9cFskb"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF43587DA
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277467; cv=none; b=ji6vINT41Sk5PALXdBMpd0BUhKwpnLA3+9DAVKN+VrKUlNh6BOsMSjw5aaywIDbGBOlwMQS/fCwX+O3Qe3cKPhFWPG/0//AmNGweVGyX8S7NlV8hpkmWsdmymxAdj4pCcALlDWfgoK+vPksrmezuZRNBrfQpN+X+yJTpWIdJFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277467; c=relaxed/simple;
	bh=HO7q8hapxk1EsSc01u8FLAeUcBFfjRAQQBvPSZbCTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYaluvIjkK8zlgGUPAsaKcSPfMTic1d2KfpxrPVFBCfEyLkFYK6lOwIaoX9JOyqFknpw0oF2SlEuF8JmYSQgsKyMFScfxu4KAOei2yfc3qKya76jvXuFtSNuv3zeE3q4lL4E/sSDvd954EuNCDl2f8jAoyE+6JqQWOHHuWR0AWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JD9cFskb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Ntdpc/kmU25S8F1eDNB57650TuUB4jKAVLcNz3WP428=; b=JD9cFskb0ndPxsKG6mTXNaig4G
	AjzKOFM/uI2N0j2aUVwUgcC3SwPYbKsfsc1pabUNvUYnLLVx209LS6nhZAnvXY5BX8ICUrdVb19fB
	wewmjBHYAs1usCTPHRkN+XodwpBydq99GjSElbGrZ60yAKYLCsDkDcI2lDDLpJbL4ceI7O3CDkc9e
	gcwDxAN6xJeO50QVSckVR8cfFj13SswOLKmnJ2uunwIVKPVIny+RCf1Dqu85I4ryNCdQe+UbEhdnH
	/3DMcq2+DuBck+ZT3iQb9/jkiVArfTRJLr/lktcrqnP/yb2Z08mPU/+Yf0zqn1Ed+RylgHGgzBWXu
	ch73Pyqg==;
Received: from i53875afe.versanet.de ([83.135.90.254] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnu28-0074Ju-66; Thu, 05 Feb 2026 08:44:12 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 5/6] net: stmmac: rk: use rk_encode_wm16() for clock
 selection
Date: Thu, 05 Feb 2026 08:44:11 +0100
Message-ID: <3561842.ZfL8zNpBrT@diego>
In-Reply-To: <aYPHjS0wrtXlRb1a@shell.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk> <20297648.sWSEgdgrri@diego>
 <aYPHjS0wrtXlRb1a@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257018-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sntech.de:email,sntech.de:dkim,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 34BA4EF8AE
X-Rspamd-Action: no action

Hi Russell,

Am Mittwoch, 4. Februar 2026, 23:26:21 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> On Wed, Feb 04, 2026 at 11:03:51PM +0100, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 4. Februar 2026, 10:14:38 Mitteleurop=C3=A4ische Normalzei=
t schrieb Russell King (Oracle):
> > > Use rk_encode_wm16() for RMII clock gating control, and also for the
> > > io_clksel bit used to select the transmit clock between CRU-derived
> > > and IO-derived clock sources.
> > >=20
> > > Both of these were configured via the "set_clock_selection" method in
> > > the SoC specific operations, but there is no requirement to change the
> > > io_clksel except when enabling clocks.
> > >=20
> > > It is also possible that we don't need to ungate the RMII clock if we
> > > are operating in RGMII mode, but this commit makes no change there.
> > >=20
> > > Split up the configuration of these as separate functions, and remove
> > > the set_clock_selection() method. Since these clocking bits are in the
> > > same register that we call the "speed" register, move the logic for
> > > writing that register into rk_write_speed_grf_reg().
> > >=20
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 174 ++++++++--------=
=2D-
> > >  1 file changed, 75 insertions(+), 99 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > index 4099cbc5d0de..ed9adac70f0a 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > @@ -27,8 +27,17 @@
> > >  struct rk_priv_data;
> > > =20
> > >  struct rk_clock_fields {
> > > +	/* io_clksel_cru_mask - io_clksel bit in clock GRF register which,
> > > +	 * when set, selects the tx clock from CRU.
> > > +	 */
> > > +	u16 io_clksel_cru_mask;
> > > +	/* io_clksel_io_mask - io_clksel bit in clock GRF register which,
> > > +	 * when set, selects the tx clock from IO.
> > > +	 */
> >=20
> > nit: comment stile does not seem to follow the kernel coding style
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst#n622
>=20
> netdev has historically had this style which is separate from the rest
> of the kernel. The file already uses this comment style, so it is
> entirely correct to keep to the style which already exists in this
> file, rather than mixing styles and turning it into a mess.

thanks for the clarification. Then the comment style is obviously fine.

Regards
Heiko


> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588
>=20
>=20





