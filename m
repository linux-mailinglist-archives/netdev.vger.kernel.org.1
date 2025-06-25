Return-Path: <netdev+bounces-201280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF0AE8BFE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6723BB397
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7C2D5415;
	Wed, 25 Jun 2025 18:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099D289823
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874809; cv=none; b=KAqKEO+JgRC8176/Pvx6CM8M6Q9e4HoaHXrk1v5zBiiYjmk0vNU3hRJ6jIAvjeUUsBor0gfS7Q50MmLOhJRCMJcEedqLvDVhW+inlo4WLvNFrMl+XFfhnkUpWZClsK1cVURkP6hkg4DO0Ay4YzmbK0nzwtaetYybCzb7N8YKMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874809; c=relaxed/simple;
	bh=yZ3bmJ5oFOTAfYkpkakXUT8e+YKqYTNbuX9Iu5rR8Pw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrnxWXvMf7pR9uhQYHAAOYfiNBy4w3lJRLFnRx9DkTwKXS3tMvqsjNuvnE8hhATJyfRumGPLdKt3+Y2Z5RT8aQgJ3HF8fPwwwWAz9r8HcBwfr8UiZhmvS+/bJf4LYocx58bTnOOehFGEUe157BpzRQ4ZFTl+dvfIOpsyupZCRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1uUUW2-0001i3-Nl; Wed, 25 Jun 2025 20:06:34 +0200
Message-ID: <5a094e3b95f1219435056d87ca4f643398bcb1d3.camel@pengutronix.de>
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
From: Lucas Stach <l.stach@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de,  Russell King <linux@armlinux.org.uk>
Date: Wed, 25 Jun 2025 20:06:32 +0200
In-Reply-To: <20250625124127.4176960-1-o.rempel@pengutronix.de>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Oleksij,

Am Mittwoch, dem 25.06.2025 um 14:41 +0200 schrieb Oleksij Rempel:
> Add support for the Signal Quality Index (SQI) feature on KSZ9477 family
> switches. This feature provides a relative measure of receive signal
> quality.
>=20
> The KSZ9477 PHY provides four separate SQI values for a 1000BASE-T link,
> one for each differential pair (Channel A-D). Since the current get_sqi
> UAPI only supports returning a single value per port, this
> implementation reads the SQI from Channel A as a representative metric.

I wonder if it wouldn't be more useful to report the worst SQI from all
the channels instead.

> This can be extended to provide per-channel readings once the UAPI is
> enhanced for multi-channel support.
>=20
> The hardware provides a raw 7-bit SQI value (0-127), where lower is
> better. This raw value is converted to the standard 0-7 scale to provide
> a usable, interoperable metric for userspace tools, abstracting away
> hardware-specifics. The mapping to the standard 0-7 SQI scale was
> determined empirically by injecting a 30MHz sine wave into the receive
> pair with a signal generator. It was observed that the link becomes
> unstable and drops when the raw SQI value reaches 8. This
> implementation is based on these test results.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - Reword commit message
> - Fix SQI value inversion
> - Implement an empirically-derived, non-linear mapping to the standard
>   0-7 SQI scale
> ---
>  drivers/net/phy/micrel.c | 124 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index d0429dc8f561..6422d9a7c09f 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -2173,6 +2173,128 @@ static void kszphy_get_phy_stats(struct phy_devic=
e *phydev,
>  	stats->rx_errors =3D priv->phy_stats.rx_err_pkt_cnt;
>  }
> =20
> +/* Base register for Signal Quality Indicator (SQI) - Channel A
> + *
> + * MMD Address: MDIO_MMD_PMAPMD (0x01)
> + * Register:    0xAC (Channel A)
> + * Each channel (pair) has its own register:
> + *   Channel A: 0xAC
> + *   Channel B: 0xAD
> + *   Channel C: 0xAE
> + *   Channel D: 0xAF
> + */
> +#define KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A	0xAC
> +
> +/* SQI field mask for bits [14:8]
> + *
> + * SQI indicates relative quality of the signal.
> + * A lower value indicates better signal quality.
> + */
> +#define KSZ9477_MMD_SQI_MASK			GENMASK(14, 8)
> +
> +#define KSZ9477_SQI_MAX				7
> +
> +/* Delay between consecutive SQI register reads in microseconds.
> + *
> + * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> + * The register is updated every 2 =C2=B5s. Use 3 =C2=B5s to avoid redun=
dant reads.
> + */
> +#define KSZ9477_MMD_SQI_READ_DELAY_US		3
> +
> +/* Number of SQI samples to average for a stable result.
> + *
> + * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> + * For noisy environments, a minimum of 30=E2=80=9350 readings is recomm=
ended.
> + */
> +#define KSZ9477_SQI_SAMPLE_COUNT		40
> +
> +/* The hardware SQI register provides a raw value from 0-127, where a lo=
wer
> + * value indicates better signal quality. However, empirical testing has
> + * shown that only the 0-7 range is relevant for a functional link. A ra=
w
> + * value of 8 or higher was measured directly before link drop. This ali=
gns
> + * with the OPEN Alliance recommendation that SQI=3D0 should represent t=
he
> + * pre-failure state.
> + *
> + * This table provides a non-linear mapping from the useful raw hardware
> + * values (0-7) to the standard 0-7 SQI scale, where higher is better.
> + */
> +static const u8 ksz_sqi_mapping[] =3D {
> +	7, /* raw 0 -> SQI 7 */
> +	7, /* raw 1 -> SQI 7 */
> +	6, /* raw 2 -> SQI 6 */
> +	5, /* raw 3 -> SQI 5 */
> +	4, /* raw 4 -> SQI 4 */
> +	3, /* raw 5 -> SQI 3 */
> +	2, /* raw 6 -> SQI 2 */
> +	1, /* raw 7 -> SQI 1 */
> +};
> +
> +/**
> + * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
> + * @phydev: the PHY device
> + *
> + * This function reads and processes the raw Signal Quality Index from t=
he
> + * PHY. Based on empirical testing, a raw value of 8 or higher indicates=
 a
> + * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
> + * mapped to the standard 0-7 SQI scale via a lookup table.
> + *
> + * Return: SQI value (0=E2=80=937), or a negative errno on failure.
> + */
> +static int kszphy_get_sqi(struct phy_device *phydev)
> +{
> +	int sum =3D 0;
> +	int i, val, raw_sqi, avg_raw_sqi;
> +	u8 channels;
> +
> +	/* Determine applicable channels based on link speed */
> +	if (phydev->speed =3D=3D SPEED_1000)
> +		/* TODO: current SQI API only supports 1 channel. */
> +		channels =3D 1;
> +	else if (phydev->speed =3D=3D SPEED_100)
> +		channels =3D 1;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Sample and accumulate SQI readings for each pair (currently only one=
).
> +	 *
> +	 * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> +	 * - The SQI register is updated every 2 =C2=B5s.
> +	 * - Values may fluctuate significantly, even in low-noise environments=
.
> +	 * - For reliable estimation, average a minimum of 30=E2=80=9350 sample=
s
> +	 *   (recommended for noisy environments)
> +	 * - In noisy environments, individual readings are highly unreliable.
> +	 *
> +	 * We use 40 samples per pair with a delay of 3 =C2=B5s between each
> +	 * read to ensure new values are captured (2 =C2=B5s update interval).
> +	 */
> +	for (i =3D 0; i < KSZ9477_SQI_SAMPLE_COUNT; i++) {
> +		val =3D phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
> +				   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A);
> +		if (val < 0)
> +			return val;
> +
> +		raw_sqi =3D FIELD_GET(KSZ9477_MMD_SQI_MASK, val);
> +		sum +=3D raw_sqi;
> +
> +		udelay(KSZ9477_MMD_SQI_READ_DELAY_US);

This ends up spending a sizable amount of time just spinning the CPU to
collect the samples for the averaging. Given that only very low values
seem to indicate a working link, I wonder how significant the
fluctuations in reported link quality are in reality. Is it really
worth spending 120us of CPU time to average those values?

Maybe a running average updated with a new sample each time this
function is called would be sufficient?

Regards,
Lucas

> +	}
> +
> +	avg_raw_sqi =3D sum / KSZ9477_SQI_SAMPLE_COUNT;
> +
> +	/* Handle the pre-fail/failed state first. */
> +	if (avg_raw_sqi >=3D ARRAY_SIZE(ksz_sqi_mapping))
> +		return 0;
> +
> +	/* Use the lookup table for the good signal range. */
> +	return ksz_sqi_mapping[avg_raw_sqi];
> +}
> +
> +static int kszphy_get_sqi_max(struct phy_device *phydev)
> +{
> +	return KSZ9477_SQI_MAX;
> +}
> +
>  static void kszphy_enable_clk(struct phy_device *phydev)
>  {
>  	struct kszphy_priv *priv =3D phydev->priv;
> @@ -5801,6 +5923,8 @@ static struct phy_driver ksphy_driver[] =3D {
>  	.update_stats	=3D kszphy_update_stats,
>  	.cable_test_start	=3D ksz9x31_cable_test_start,
>  	.cable_test_get_status	=3D ksz9x31_cable_test_get_status,
> +	.get_sqi	=3D kszphy_get_sqi,
> +	.get_sqi_max	=3D kszphy_get_sqi_max,
>  } };
> =20
>  module_phy_driver(ksphy_driver);


