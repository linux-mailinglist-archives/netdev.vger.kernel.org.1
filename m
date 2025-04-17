Return-Path: <netdev+bounces-183664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A0A91744
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7EF3AFFEE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B32253F6;
	Thu, 17 Apr 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Z5/G+cB5"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F279320F;
	Thu, 17 Apr 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880747; cv=none; b=VI5azgqGRiEfzHjr23ofvRIWLbDanA8u/S14dA53aUHhOQvirGaClKNs+euzl7hO+P7DK48bQE29JAWgyMnUO7k7YVkrR3GJtkax8VD3wxZXn1yf985i2Wy6nqHufyfSwwq3MCwwFYLBkjhsLzG2WLIVJd0w7Dq1iIyS1pe2aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880747; c=relaxed/simple;
	bh=NJ93hE0pNHs3tknHDpIpsFWqZCH1EoaVWpYGw80fYEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkESPq2n0+vj1wkB7wmttdsKi2NNelMUrFaEn4BO30UogDhAf5z5EWXd8sLqr3JbuA6Z/4voVPs/RHLCuAMXxVTUq0a+vbGLDUhPXPc3xojV0uENhJd0vSc0ja5hbwvdlLJQwfd8tl91HSqCGWPed2kC8/FY47W3fNaZXvdl+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Z5/G+cB5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744880737; x=1745485537; i=fiona.klute@gmx.de;
	bh=JsZLsXBqU1hrO/rpBcRoDI1LcJUbwVsvUaO8Sqt2c/c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z5/G+cB58FKICfv9ut+C7j/7/n/vH3WiiPMm8ttkK8PlyFO95NK+WGc1u1C1rcbU
	 fA1T/dnwlMzQK7klhipyU2D7dZCUf8FvVSQTYxd4p0dkhxSmU7xTiIp2THxszFiBR
	 cWFgvVBvcrw/iKfUup4teIcpkY0l0ESFzXqUFzIhgwjRF9CIUS4UDxuH0fAABzRcJ
	 2s3VFE8cnO6uuGC7UxPMUknxjnSN8PBNAi0ftMEvTeG357AGa3366QjNovPWLZSpG
	 flC07r/CxpoFDVKPfJ1H7hVwK4s+4Q0I4fJttkx+nN0dMPO5nlZTDVbShj9SgifzZ
	 07Np/iMrk5uM0QMd1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.120.83]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1uCWCJ1NiU-0047p0; Thu, 17
 Apr 2025 11:05:37 +0200
Message-ID: <fcd60fa6-4bb5-47ec-89ab-cbc94f8a62ce@gmx.de>
Date: Thu, 17 Apr 2025 11:05:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com
References: <20250416102413.30654-1-fiona.klute@gmx.de>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <20250416102413.30654-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYt+OhYzRRd0+BMbd+86eL3AARv3zWMMxrZNHhkVcO/L6bPcG1a
 PhdFm1GtWIn7/fslheu8OKRH8LM/EmDwyJpzDQAQebW/TUPrBEY54Ka6Jf5NnnDq1c81Zn9
 RKFtQhn65yHXBfi4yweUGZoAlo8G+mS6LzvbZjcKQ2/MfnuQJ7QHayAyT0kmYRH0C+1Nrc/
 0vu4fKyZRYWxw7JeBxmLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oJaBdkiMVHM=;PvBdMLdw6aOP/eGuq9tyIemwdtR
 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

Am 16.04.25 um 12:24 schrieb Fiona Klute:
> With lan88xx based devices the lan78xx driver can get stuck in an
> interrupt loop while bringing the device up, flooding the kernel log
> with messages like the following:
>=20
> lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>=20
> Removing interrupt support from the lan88xx PHY driver forces the
> driver to use polling instead, which avoids the problem.
>=20
> The issue has been observed with Raspberry Pi devices at least since
> 4.14 (see [1], bug report for their downstream kernel), as well as
> with Nvidia devices [2] in 2020, where disabling polling was the

I noticed I got words mixed up here, needs to be either "disabling=20
interrupts" or "forcing polling", not "disabling polling".

Should I re-send, or is that something that can be fixed while applying?

Best regards,
Fiona

> vendor-suggested workaround (together with the claim that phylib
> changes in 4.9 made the interrupt handling in lan78xx incompatible).
>=20
> Iperf reports well over 900Mbits/sec per direction with client in
> --dualtest mode, so there does not seem to be a significant impact on
> throughput (lan88xx device connected via switch to the peer).
>=20
> [1] https://github.com/raspberrypi/linux/issues/2447
> [2] https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-prob=
lem/142134/11
>=20
> Link: https://lore.kernel.org/0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.=
ch
> Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: kernel-list@raspberrypi.com
> Cc: stable@vger.kernel.org
> ---
> v2:
> - add comment why interrupt functions are missing
> - add Fixes reference
> v1: https://lore.kernel.org/netdev/20250414152634.2786447-1-fiona.klute@=
gmx.de/
>=20
>   drivers/net/phy/microchip.c | 46 +++----------------------------------
>   1 file changed, 3 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
> index 0e17cc458efdc..93de88c1c8fd5 100644
> --- a/drivers/net/phy/microchip.c
> +++ b/drivers/net/phy/microchip.c
> @@ -37,47 +37,6 @@ static int lan88xx_write_page(struct phy_device *phyd=
ev, int page)
>   	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
>   }
>  =20
> -static int lan88xx_phy_config_intr(struct phy_device *phydev)
> -{
> -	int rc;
> -
> -	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> -		/* unmask all source and clear them before enable */
> -		rc =3D phy_write(phydev, LAN88XX_INT_MASK, 0x7FFF);
> -		rc =3D phy_read(phydev, LAN88XX_INT_STS);
> -		rc =3D phy_write(phydev, LAN88XX_INT_MASK,
> -			       LAN88XX_INT_MASK_MDINTPIN_EN_ |
> -			       LAN88XX_INT_MASK_LINK_CHANGE_);
> -	} else {
> -		rc =3D phy_write(phydev, LAN88XX_INT_MASK, 0);
> -		if (rc)
> -			return rc;
> -
> -		/* Ack interrupts after they have been disabled */
> -		rc =3D phy_read(phydev, LAN88XX_INT_STS);
> -	}
> -
> -	return rc < 0 ? rc : 0;
> -}
> -
> -static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
> -{
> -	int irq_status;
> -
> -	irq_status =3D phy_read(phydev, LAN88XX_INT_STS);
> -	if (irq_status < 0) {
> -		phy_error(phydev);
> -		return IRQ_NONE;
> -	}
> -
> -	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
> -		return IRQ_NONE;
> -
> -	phy_trigger_machine(phydev);
> -
> -	return IRQ_HANDLED;
> -}
> -
>   static int lan88xx_suspend(struct phy_device *phydev)
>   {
>   	struct lan88xx_priv *priv =3D phydev->priv;
> @@ -528,8 +487,9 @@ static struct phy_driver microchip_phy_driver[] =3D =
{
>   	.config_aneg	=3D lan88xx_config_aneg,
>   	.link_change_notify =3D lan88xx_link_change_notify,
>  =20
> -	.config_intr	=3D lan88xx_phy_config_intr,
> -	.handle_interrupt =3D lan88xx_handle_interrupt,
> +	/* Interrupt handling is broken, do not define related
> +	 * functions to force polling.
> +	 */
>  =20
>   	.suspend	=3D lan88xx_suspend,
>   	.resume		=3D genphy_resume,


