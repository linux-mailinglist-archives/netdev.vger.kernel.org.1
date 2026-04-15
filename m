Return-Path: <netdev+bounces-278671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOo8Lnor32nOPgAAu9opvQ
	(envelope-from <netdev+bounces-278671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:08:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BD400BD3
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 275F4301917B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3D351C0B;
	Wed, 15 Apr 2026 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="U2rZcQR6"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261140DFCB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233336; cv=none; b=C+PqKCixZ7W8nJTDHA+9dApFBfdtPD8I6uKI0zwoTZXSte9XQcy7VwFGMmzGFuGK3jiGoK1z6IZJuTOh8zBWsMhTfZWqWbSWeUvPam0l/aH5bFIm899762OJbSg220hsjyzIq2On3LU1i+VQJ6XOplNyoSGrgxtgPyhmfX01u/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233336; c=relaxed/simple;
	bh=3UcVF6gWmXzGJfs3sVJ2M5uPYqiYKBpnqRjyXWzpxB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaSDdyf8ry9TsNYkY60iks6vj/DZFj9T8FXxPEZ3ZSNPIDoxnC4aGRPA52m9v49ZYSprZyKXwx+Cc3zN2UeobTHQSTlpPjZurk6p703vCD9vS9kpnjfUn4S//w6U28OlPBFe2BluzwsAoGIjlzphrAEh+FCJ7TE4BslfBUFPg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=U2rZcQR6; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+ypCQYb5z2PZvIzS0gw2ULN0rjsWR7QSr55MLlXIZUs=; b=U2rZcQR6HMY/i/VBmz284fF8wv
	K7/JWqg2h4tNV4DIHyw1lwN7pzAT0uikIQ+qeybZ4UbJooIKTPttoJQPkhDR2EJr90sl1H8ggF3D2
	b6e/ytUR1FwI1dbx89qnWjjavatDJgcRxV8DVrikX7B/VM9th8tWpyU7MdzJEKJWvvc+Ce3Y2u3o3
	KbWSS70kDPh0wp3YSXvBpu0RHrndvdAn0714vAMMz78KrOoix5Sajz4e+bi+8n8v2xzsv2UY3ar/z
	puTv3aVkWXWdUu6eHr8JFlDXtHToxFLrqZVHjcZBubSH8foYL9ouYFZM6Dt9C7CusqEYqZ2dCxTdV
	bR3S9Awg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wCtQY-000C07-1D;
	Wed, 15 Apr 2026 08:08:42 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wCtQX-0008Pj-03;
	Wed, 15 Apr 2026 08:08:41 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Date: Wed, 15 Apr 2026 08:08:40 +0200
Message-ID: <8409022.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <E1v11A3-0000000774G-3PKY@rmk-PC.armlinux.org.uk>
References:
 <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <E1v11A3-0000000774G-3PKY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27971/Tue Apr 14 08:24:44 2026)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278671-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 2F4BD400BD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King (Oracle=
):
> Move the PHY attachment/detachment from the network driver out of
> __stmmac_open() and __stmmac_release() into stmmac_open() and
> stmmac_release() where these actions will only happen when the
> interface is administratively brought up or down. It does not make
> sense to detach and re-attach the PHY during a change of MTU.

Sorry for coming up now. But I recently noticed this commit breaks changing
the MTU on i.MX8MP. Once I simply change the MTU I run into some DMA error:
$ ip link set dev end1 mtu 1400
imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
imx-dwmac 30bf0000.ethernet end1: Link is Down
imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initializatio=
n failed
imx-dwmac 30bf0000.ethernet end1: __stmmac_open: Hw setup failed
imx-dwmac 30bf0000.ethernet end1: failed reopening the interface after MTU =
change

Using the command above bisecting was straight forward.
=46or some reason detach and re-attaching the PHY seems necessary on this p=
latform.
There already too much changes for simply reverting this commit.

Best regards,
Alexander

>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4acd180d2da8..4844d563e291 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3937,10 +3937,6 @@ static int __stmmac_open(struct net_device *dev,
>  	u32 chan;
>  	int ret;
> =20
> -	ret =3D stmmac_init_phy(dev);
> -	if (ret)
> -		return ret;
> -
>  	for (int i =3D 0; i < MTL_MAX_TX_QUEUES; i++)
>  		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
>  			dma_conf->tx_queue[i].tbs =3D priv->dma_conf.tx_queue[i].tbs;
> @@ -3990,7 +3986,6 @@ static int __stmmac_open(struct net_device *dev,
> =20
>  	stmmac_release_ptp(priv);
>  init_error:
> -	phylink_disconnect_phy(priv->phylink);
>  	return ret;
>  }
> =20
> @@ -4010,18 +4005,28 @@ static int stmmac_open(struct net_device *dev)
> =20
>  	ret =3D pm_runtime_resume_and_get(priv->device);
>  	if (ret < 0)
> -		goto err;
> +		goto err_dma_resources;
> +
> +	ret =3D stmmac_init_phy(dev);
> +	if (ret)
> +		goto err_runtime_pm;
> =20
>  	ret =3D __stmmac_open(dev, dma_conf);
> -	if (ret) {
> -		pm_runtime_put(priv->device);
> -err:
> -		free_dma_desc_resources(priv, dma_conf);
> -	}
> +	if (ret)
> +		goto err_disconnect_phy;
> =20
>  	kfree(dma_conf);
> =20
>  	return ret;
> +
> +err_disconnect_phy:
> +	phylink_disconnect_phy(priv->phylink);
> +err_runtime_pm:
> +	pm_runtime_put(priv->device);
> +err_dma_resources:
> +	free_dma_desc_resources(priv, dma_conf);
> +	kfree(dma_conf);
> +	return ret;
>  }
> =20
>  static void __stmmac_release(struct net_device *dev)
> @@ -4038,7 +4043,6 @@ static void __stmmac_release(struct net_device *dev)
> =20
>  	/* Stop and disconnect the PHY */
>  	phylink_stop(priv->phylink);
> -	phylink_disconnect_phy(priv->phylink);
> =20
>  	stmmac_disable_all_queues(priv);
> =20
> @@ -4078,6 +4082,7 @@ static int stmmac_release(struct net_device *dev)
> =20
>  	__stmmac_release(dev);
> =20
> +	phylink_disconnect_phy(priv->phylink);
>  	pm_runtime_put(priv->device);
> =20
>  	return 0;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



