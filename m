Return-Path: <netdev+bounces-252750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEzpMbhHc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:04:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB973E15
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0563015D20
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06237B415;
	Fri, 23 Jan 2026 09:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1737D111
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162191; cv=none; b=nvOFPDF/1JkN6qNqG4nTPgqJs7CfpjzFZgVDdvsBAZHxnDj4rRSpcbUOpfBxuIPgyA1eu0uspDun0d9qerte+Ucovcn1V9enMNYrmJU3+Y2m/5NVrbqU0R/5YJJlnzOj+Sk/l4ucJs03GnLyRy6XLWp2WrIrWOcaxQEaeE3MRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162191; c=relaxed/simple;
	bh=tx5Wz+a5TLaMtHBcpvkdAn6w2K8YSei6fIc572qMG5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2ntAWuzDb7RMdCrHMkIOump4BCyvp8yp0/oOjkEoZbxxqPvUmPW3UZQzMzRYJ7QZhCSOndXI7lwf3gUi9NmPqsb6kUr5HdGlH9kasTnfQq5pg6Bc8EvCkQ95+Pg0SssMC6gC2BdlN7ZH9B5mOfOo8G3qKmoMpLo6M6zFsCrgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDtV-00027t-MN; Fri, 23 Jan 2026 10:55:57 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDtV-0024QO-2S;
	Fri, 23 Jan 2026 10:55:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDtU-00AteV-3B;
	Fri, 23 Jan 2026 10:55:56 +0100
Date: Fri, 23 Jan 2026 10:55:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	rsc@pengutronix.de
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <aXNFrDOdPanZ_cjk@pengutronix.de>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,vger.kernel.org,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-252750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:url,microchip.com:email]
X-Rspamd-Queue-Id: 3DBB973E15
X-Rspamd-Action: no action

Hi Jens,

On Fri, Jan 23, 2026 at 08:50:55AM +0100, Jens Emil Schulz Østergaard wrote:
> LAN9645X is a family of switch chips with 5 internal copper phys. The
> internal PHY is based on parts of LAN8832. This is a low-power, single
> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
> layer transceiver (PHY) that supports transmission and reception of data
> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> Pair (UTP) cables.
> 
> Add support for the internal PHY of the lan9645x chip family.

Looks like interesting switch for our use cases :)

> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
>  drivers/net/phy/micrel.c   | 142 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/micrel_phy.h |   1 +
>  2 files changed, 143 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 225d4adf28be..7f47f7987067 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -6502,6 +6502,132 @@ static void lan8842_get_phy_stats(struct phy_device *phydev,
>  	stats->tx_errors = priv->phy_stats.tx_errors;
>  }
>  
> +#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN	0x47
> +#define LAN9645X_BTRX_QBIAS_POWER_DOWN		0x46
> +#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT	0x45
> +#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT	0x44
> +#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT	0x43

> +static const struct lanphy_reg_data force_dac_tx_errata[] = {
> +	/* Force channel A/B/C/D TX on */
> +	{ LAN8814_PAGE_POWER_REGS,
> +	  LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
> +	  0 },
> +	/* Force channel A/B/C/D QBias on */
> +	{ LAN8814_PAGE_POWER_REGS,
> +	  LAN9645X_BTRX_QBIAS_POWER_DOWN,
> +	  0xaa },
> +	/* tx low I on channel C/D overwrite */
> +	{ LAN8814_PAGE_POWER_REGS,
> +	  LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
> +	  0xbfff },
> +	/* channel B low I overwrite */
> +	{ LAN8814_PAGE_POWER_REGS,
> +	  LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
> +	  0xabbf },
> +	/* channel A low I overwrite */
> +	{ LAN8814_PAGE_POWER_REGS,
> +	  LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
> +	  0xbd3f },
> +};

It looks like this erratum not publicly documented. At least not here:
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN9645xS-LAN9645xF-Errata-DS80001187.pdf

re there more information about it? Can it be described in the comment?

> +
> +static int lan9645x_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Apply erratas. */
> +	ret = lan8842_erratas(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return lanphy_write_reg_data(phydev, force_dac_tx_errata,
> +				     ARRAY_SIZE(force_dac_tx_errata));
> +}
> +
> +static int lan9645x_suspend(struct phy_device *phydev)
> +{
> +	int aneg_en_state, ret;
> +
> +	/* Software workaround from design to handle SPD. SPD will stop AFE
> +	 * clock from AFE port, which makes the system MAC fifo unable to flush.
> +	 * The workaround is to restart ANEG and wait for flush, before issuing
> +	 * software power down.
> +	 */
> +	aneg_en_state = phy_read(phydev, MII_BMCR) & BMCR_ANENABLE;
> +
> +	ret = phy_restart_aneg(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow time for system FIFO flush data */
> +	usleep_range(8 * USEC_PER_MSEC, 12 * USEC_PER_MSEC);

MAC and PHY power management are not always fully coupled (implementation
specific), are there other ways to sync them with each other, except of
unconditional sleep in the PHY driver. I expect that someone making
changes on the MAC driver may miss this nuance.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

