Return-Path: <netdev+bounces-305674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sykxK6sGTmp1BwIAu9opvQ
	(envelope-from <netdev+bounces-305674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:13:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF9723049
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ew.tq-group.com header.s=default2602 header.b=k8JGePCW;
	dmarc=pass (policy=quarantine) header.from=ew.tq-group.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305674-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B49302AD17
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C73F823A;
	Wed,  8 Jul 2026 08:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438983ED10B;
	Wed,  8 Jul 2026 08:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497667; cv=none; b=tOxqmhCC5XAV6u/tZG07DSdQEGu2DR5PYY3on9LW5Y1a9YUDgLg1TMosSKXMTunZYyF8lTlKs8vX7UJhfo9H/XNJ3Z2aOv8f4eC1nUQimwqpc1EDXi5y3OXadjmhmLXNfQUpzJ37tf6dqBBwavlt0BqM6+QA+sn6LMyrw9DFD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497667; c=relaxed/simple;
	bh=8knlzjJe0MQcmpC57a8nsqaHD/xG0BAdLV+qwY2UBnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnjvqOkWxN42NZ6vWqS5F1tnMFy+ndaEID8gmSvR2z4JyS/pYT/lyeqKGz116cV827gMCCs5fEtNiO09xMuyN8m4LMwJ0zXiBzTMreXjxGYXe3nJEoVD6ySgy/MbvAoiZ3iqZ1ugW97wyUQjtzQJLTlUG45GVmeytJMgF5AilzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=k8JGePCW; arc=none smtp.client-ip=188.40.3.216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZORe/+VwOmTKCnEN5Tm3BfvX4hAqdI2noG2Lc0f2jfY=; b=k8JGePCWEmP9lewiLETUuZkBzQ
	CWE/AxtZe1AN3MG+/zZ6MoVwMbbNJTDpsssebY9AQnnjKsvwEoKq+2tstg/ItaopZe8i0KyzZ1nQ1
	K4FJA0A4SQJ/QSg0B30NIT2jcfyNDXk8FDc4SczxBbfHqgPWBMM6+EN4kHpzteI+8Wcjy+w2P/nB8
	IiU4upvt4Hr++wiiCezCOcZzC/NB5r9AUhOgL16fq3qv/KZ7r0VpNnf33QHVvIbZa1LpiQ2QQ2M9d
	d0hK2OR63mQohnqWI3o2aJ7aQdRSwUSopZjcsakaMuGgkBMibqMB1YPaFr+zh3AHY9KllbOd4uSZp
	LTnyClRg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1whNDE-00086x-1w;
	Wed, 08 Jul 2026 10:00:56 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1whNDE-000Pap-30;
	Wed, 08 Jul 2026 10:00:56 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Stefan Agner <stefan@agner.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev,
 Stefan Agner <stefan@agner.ch>
Subject:
 Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup when opening
 the interface
Date: Wed, 08 Jul 2026 10:00:55 +0200
Message-ID: <5162542.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260707195425.405989-1-stefan@agner.ch>
References: <20260707195425.405989-1-stefan@agner.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305674-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,agner.ch];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:stefan@agner.ch,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:ovidiu.panait.rb@renesas.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:regressions@lists.linux.dev,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tq-group.com:url,tq-group.com:email,ew.tq-group.com:from_mime,ew.tq-group.com:dkim,agner.ch:email,steina-w:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04BF9723049

Hi Stefan,

thanks for the patch.

Am Dienstag, 7. Juli 2026, 21:54:25 CEST schrieb Stefan Agner:
> Since the referenced commit, changing the MTU on a running interface no
> longer disconnects and reconnects the PHY; __stmmac_release() merely
> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
> is not enabled. __stmmac_open() then performs the DMA software reset in
> stmmac_hw_setup() before phylink_start() resumes the PHY again.
>=20
> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
> powered down, and stmmac requires a running receive clock for the DMA
> software reset to complete (the phylink config sets mac_requires_rxc).
> On such setups, e.g. the RK3566-based Home Assistant Green with an
> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
> leaves the interface dead:
>=20
>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initi=
alization failed
>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface af=
ter MTU change
>=20
> In the field this is triggered by NetworkManager applying an MTU while
> activating the connection, breaking networking entirely.
>=20
> Resume the PHY in __stmmac_open() before the hardware setup, making it
> the counterpart of the phylink_stop() in __stmmac_release(), like
> stmmac_resume() already does for the same reason. phylink_start() also
> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
> moved before the hardware setup since it may bring the link up
> immediately from a workqueue, racing with the initialization (see the
> comment in stmmac_resume()). For the regular ndo_open path the PHY has
> just been attached and is not suspended, in which case
> phylink_prepare_resume() does nothing.
>=20
> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open=
()/release()")
> Link: https://github.com/home-assistant/operating-system/issues/4858
> Signed-off-by: Stefan Agner <stefan@agner.ch>

=46WIW imx8mp based platforms (TQMa8MPxL in my case) are also affected, see=
 [1].

This patch fixes the problem here as well, so:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

[1] https://lore.kernel.org/all/8409022.LvFx2qVVIh@steina-w/

> ---
> Changes in v2:
> - Move the PHY resume from stmmac_change_mtu() into __stmmac_open() so
>   that it also counters the PHY suspend caused by __stmmac_release()
>   (suggested by Andrew Lunn), placed before stmmac_reset_queues_param()
>   to match the ordering used in stmmac_resume()
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4147,6 +4147,15 @@
>  			dma_conf->tx_queue[i].tbs =3D priv->dma_conf.tx_queue[i].tbs;
>  	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
> =20
> +	/* The PHY is suspended when the interface is reopened without
> +	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs
> +	 * to stop their receive clock while powered down, but the DMA
> +	 * software reset in stmmac_hw_setup() requires a running receive
> +	 * clock, and phylink_start() below resumes the PHY only after the
> +	 * hardware setup. Resume a suspended PHY here first.
> +	 */
> +	phylink_prepare_resume(priv->phylink);
> +
>  	stmmac_reset_queues_param(priv);
> =20
>  	ret =3D stmmac_hw_setup(dev);
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



