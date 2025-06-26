Return-Path: <netdev+bounces-201402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FAAE9511
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E51C26FC6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89541DE8BE;
	Thu, 26 Jun 2025 05:11:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DC38FB9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914712; cv=none; b=JEo3biYmkfq8DDZt7XMU7ZyhB7W5CeQsHnm04qzBWsTHaC/3cW+6VMNO8MZscs0W8N8VLMrUmGcAG1orfOhq2waiTKgtYeVTSYnC1U1xDQJGm5rEbs5+HQlxESSVCnCa8UPNpAuDXLM13ALIq7kNZo7BhkyRhJVWdfeumpQdpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914712; c=relaxed/simple;
	bh=yiyJi7OAXIRkgvzmslOVi4SXkRGJb0a6ChnFNVnTl7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esIuDY5bO/Q7fIFSjYIBpEDFhOnt6xjtFT+hcqO+FbcEb1RxsfMzTpFymueV7bg/g9xqfFU9l7JBvvOYq34F7IQO+FhT7bje35wApWD11pfKwm192I/7bGDN6NWaJ2WjUGPZuWWd725lwo5oI+EzX9N9qHCpbH2yQNLC8dHntvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUetf-0007Lc-LV; Thu, 26 Jun 2025 07:11:39 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUete-005Ofk-0K;
	Thu, 26 Jun 2025 07:11:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUetd-001Sfn-38;
	Thu, 26 Jun 2025 07:11:37 +0200
Date: Thu, 26 Jun 2025 07:11:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <aFzWiZ9ohbE_Unuz@pengutronix.de>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
 <5a094e3b95f1219435056d87ca4f643398bcb1d3.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a094e3b95f1219435056d87ca4f643398bcb1d3.camel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jun 25, 2025 at 08:06:32PM +0200, Lucas Stach wrote:
> Hi Oleksij,
> 
> Am Mittwoch, dem 25.06.2025 um 14:41 +0200 schrieb Oleksij Rempel:
> > Add support for the Signal Quality Index (SQI) feature on KSZ9477 family
> > switches. This feature provides a relative measure of receive signal
> > quality.
> > 
> > The KSZ9477 PHY provides four separate SQI values for a 1000BASE-T link,
> > one for each differential pair (Channel A-D). Since the current get_sqi
> > UAPI only supports returning a single value per port, this
> > implementation reads the SQI from Channel A as a representative metric.
> 
> I wonder if it wouldn't be more useful to report the worst SQI from all
> the channels instead.

It was my first idea too, just to report the worst SQI from all
channels. But this makes it impossible to report SQI for each pair
later. If we ever want to support SQI per pair, the current code would
suddenly start to show only SQI for pair A, not the worst one, so the
SQI interface would change meaning without warning.

There is another problem if we want to extend the SQI UAPI for per-pair
support: with 100Mbit/s links, we can't know which pair is used. The PHY
reports SQI only for the RX pair, which can change depending on MDI-X
resolution, and with auto MDI-X mode, this PHY doesn't tell us which
pair it is.

That means, at this point, we have hardware which in some modes can't
provide pair-related information. So, it is better to keep the already
existing UAPI explicitly per link instead of per pair. This matches the
current hardware limits and avoids confusion for users and developers.
If we want per-pair SQI in the future, the API must handle these cases
clearly.

> > This can be extended to provide per-channel readings once the UAPI is
> > enhanced for multi-channel support.
> > 
> > The hardware provides a raw 7-bit SQI value (0-127), where lower is
> > better. This raw value is converted to the standard 0-7 scale to provide
> > a usable, interoperable metric for userspace tools, abstracting away
> > hardware-specifics. The mapping to the standard 0-7 SQI scale was
> > determined empirically by injecting a 30MHz sine wave into the receive
> > pair with a signal generator. It was observed that the link becomes
> > unstable and drops when the raw SQI value reaches 8. This
> > implementation is based on these test results.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v2:
> > - Reword commit message
> > - Fix SQI value inversion
> > - Implement an empirically-derived, non-linear mapping to the standard
> >   0-7 SQI scale
> > ---
> >  drivers/net/phy/micrel.c | 124 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 124 insertions(+)
> > 
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index d0429dc8f561..6422d9a7c09f 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -2173,6 +2173,128 @@ static void kszphy_get_phy_stats(struct phy_device *phydev,
> >  	stats->rx_errors = priv->phy_stats.rx_err_pkt_cnt;
> >  }
> >  
> > +/* Base register for Signal Quality Indicator (SQI) - Channel A
> > + *
> > + * MMD Address: MDIO_MMD_PMAPMD (0x01)
> > + * Register:    0xAC (Channel A)
> > + * Each channel (pair) has its own register:
> > + *   Channel A: 0xAC
> > + *   Channel B: 0xAD
> > + *   Channel C: 0xAE
> > + *   Channel D: 0xAF
> > + */
> > +#define KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A	0xAC
> > +
> > +/* SQI field mask for bits [14:8]
> > + *
> > + * SQI indicates relative quality of the signal.
> > + * A lower value indicates better signal quality.
> > + */
> > +#define KSZ9477_MMD_SQI_MASK			GENMASK(14, 8)
> > +
> > +#define KSZ9477_SQI_MAX				7
> > +
> > +/* Delay between consecutive SQI register reads in microseconds.
> > + *
> > + * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> > + * The register is updated every 2 µs. Use 3 µs to avoid redundant reads.
> > + */
> > +#define KSZ9477_MMD_SQI_READ_DELAY_US		3
> > +
> > +/* Number of SQI samples to average for a stable result.
> > + *
> > + * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> > + * For noisy environments, a minimum of 30–50 readings is recommended.
> > + */
> > +#define KSZ9477_SQI_SAMPLE_COUNT		40
> > +
> > +/* The hardware SQI register provides a raw value from 0-127, where a lower
> > + * value indicates better signal quality. However, empirical testing has
> > + * shown that only the 0-7 range is relevant for a functional link. A raw
> > + * value of 8 or higher was measured directly before link drop. This aligns
> > + * with the OPEN Alliance recommendation that SQI=0 should represent the
> > + * pre-failure state.
> > + *
> > + * This table provides a non-linear mapping from the useful raw hardware
> > + * values (0-7) to the standard 0-7 SQI scale, where higher is better.
> > + */
> > +static const u8 ksz_sqi_mapping[] = {
> > +	7, /* raw 0 -> SQI 7 */
> > +	7, /* raw 1 -> SQI 7 */
> > +	6, /* raw 2 -> SQI 6 */
> > +	5, /* raw 3 -> SQI 5 */
> > +	4, /* raw 4 -> SQI 4 */
> > +	3, /* raw 5 -> SQI 3 */
> > +	2, /* raw 6 -> SQI 2 */
> > +	1, /* raw 7 -> SQI 1 */
> > +};
> > +
> > +/**
> > + * kszphy_get_sqi - Read, average, and map Signal Quality Index (SQI)
> > + * @phydev: the PHY device
> > + *
> > + * This function reads and processes the raw Signal Quality Index from the
> > + * PHY. Based on empirical testing, a raw value of 8 or higher indicates a
> > + * pre-failure state and is mapped to SQI 0. Raw values from 0-7 are
> > + * mapped to the standard 0-7 SQI scale via a lookup table.
> > + *
> > + * Return: SQI value (0–7), or a negative errno on failure.
> > + */
> > +static int kszphy_get_sqi(struct phy_device *phydev)
> > +{
> > +	int sum = 0;
> > +	int i, val, raw_sqi, avg_raw_sqi;
> > +	u8 channels;
> > +
> > +	/* Determine applicable channels based on link speed */
> > +	if (phydev->speed == SPEED_1000)
> > +		/* TODO: current SQI API only supports 1 channel. */
> > +		channels = 1;
> > +	else if (phydev->speed == SPEED_100)
> > +		channels = 1;
> > +	else
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * Sample and accumulate SQI readings for each pair (currently only one).
> > +	 *
> > +	 * Reference: KSZ9477S Datasheet DS00002392C, Section 4.1.11 (page 26)
> > +	 * - The SQI register is updated every 2 µs.
> > +	 * - Values may fluctuate significantly, even in low-noise environments.
> > +	 * - For reliable estimation, average a minimum of 30–50 samples
> > +	 *   (recommended for noisy environments)
> > +	 * - In noisy environments, individual readings are highly unreliable.
> > +	 *
> > +	 * We use 40 samples per pair with a delay of 3 µs between each
> > +	 * read to ensure new values are captured (2 µs update interval).
> > +	 */
> > +	for (i = 0; i < KSZ9477_SQI_SAMPLE_COUNT; i++) {
> > +		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
> > +				   KSZ9477_MMD_SIGNAL_QUALITY_CHAN_A);
> > +		if (val < 0)
> > +			return val;
> > +
> > +		raw_sqi = FIELD_GET(KSZ9477_MMD_SQI_MASK, val);
> > +		sum += raw_sqi;
> > +
> > +		udelay(KSZ9477_MMD_SQI_READ_DELAY_US);
> 
> This ends up spending a sizable amount of time just spinning the CPU to
> collect the samples for the averaging. Given that only very low values
> seem to indicate a working link, I wonder how significant the
> fluctuations in reported link quality are in reality. Is it really
> worth spending 120us of CPU time to average those values?
> 
> Maybe a running average updated with a new sample each time this
> function is called would be sufficient?

Hm. Good point. I'l try it. We already have proper interface for this
case :)

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

