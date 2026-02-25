Return-Path: <netdev+bounces-260922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPaFHwDtnmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9804197770
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A87A30008B3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F83AEF5F;
	Wed, 25 Feb 2026 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ymIu1gZD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729CD311587;
	Wed, 25 Feb 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022963; cv=none; b=apgRX/YP2+Hx259QxLCmV66k2wLPS04MKfCKlZS0+wDgw5PkS+mT19f4txQZbtiUstqM8kIXzpc3GRbkRgrdffPNJ6OnENAVGEmzcXPAKS7Szm1TOsTa+Rhg3ETziHmiWSQ3sNM/Om6mw/fmWXXVKeSCqKMoSM0qkajXoP29CyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022963; c=relaxed/simple;
	bh=0vrKvyl/UyiTmkgRc6/o+7DChVOHvAFSb8UlFIQce4Y=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQYay+kYw9hpyDVZJFsr0EyN/9Tjo5vIDYU/TmaYt8XXopLWY9H9VPUrdjpCWzYQM9qVEyYD4em8GzouqUvnxJUeZB/TzSU6qKSpXU5fzxxMaKEX2bnjOp4tdCGXrAQcJWlcJpduY7aoWrnywA+ZAdQR1BKLIApnZbw/UaVpOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ymIu1gZD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772022960; x=1803558960;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0vrKvyl/UyiTmkgRc6/o+7DChVOHvAFSb8UlFIQce4Y=;
  b=ymIu1gZDQQgC7k5jij70llHsnU2dhA2kmAGt6/FWnraaBI4LGB52p6aS
   t+ovvY76J5m7KROAo4Fou2ohTN8DcfIs5lw7IdvhDSHXpFFmC+sTrnO7b
   nECD8DcE/QOSTHeytmLOkY4grCYX/k4eih/iaXz/q+z8bz+VemK2mKI3g
   pCsPbx94ndkk5zXmRoV7q1kRlreNhZMm7BtN3gAbsjnwQ/C7oY5jUCQOY
   fq0sUrh0DS/RHRH65eNCFzfQkrF804UEfw6lORMLH9lZAhPg/iOtt+tSr
   E+aUl0ptAa8+w0sUIC0dILaZk2DIBHgRAMevXH1RHmVNEVaw/aYYisy/y
   Q==;
X-CSE-ConnectionGUID: DOhbDRz4Q+2Xqe/FPaXvDQ==
X-CSE-MsgGUID: hAVYw3OdQb2ksrNbxLpisg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="54266702"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 05:35:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 05:35:21 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 05:35:19 -0700
Message-ID: <5876361bab237e2e1c73395d7e65c93279865f63.camel@microchip.com>
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <o.rempel@pengutronix.de>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 25 Feb 2026 13:35:18 +0100
In-Reply-To: <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
	 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
	 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
	 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
	 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: B9804197770
X-Rspamd-Action: no action

On Fri, 2026-02-20 at 21:50 +0100, Heiner Kallweit wrote:
>=20
> On 20.02.2026 21:38, Jens Emil Schulz Ostergaard wrote:
> > Hi Heiner,
> >=20
> > On Sat, 2026-01-31 at 11:00 +0100, Heiner Kallweit wrote:
> > >=20
> > > On 1/31/2026 7:29 AM, Jens Emil Schulz Ostergaard wrote:
> > > > Hi,
> > > >=20
> > > > On Fri, 2026-01-30 at 10:12 +0100, Jens Emil Schulz =C3=98stergaard=
 wrote:
> > > > > LAN9645X is a family of switch chips with 5 internal copper phys.=
 The
> > > > > internal PHY is based on parts of LAN8832. This is a low-power, s=
ingle
> > > > > port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physi=
cal
> > > > > layer transceiver (PHY) that supports transmission and reception =
of data
> > > > > on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> > > > > Pair (UTP) cables.
> > > > >=20
> > > > > Add support for the internal PHY of the lan9645x chip family.
> > > > >=20
> > > > > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > > > > Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> > > > > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzo=
stergaard@microchip.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Check write errors in lan9645x_config_intr.
> > > > > - Added more comments for the erratas which are not yet documente=
d in
> > > > >   the datasheet.
> > > > > - Change workaround in lan9645x_suspend from ANEG restart and sle=
ep to
> > > > >   asserting Software Soft Reset and poll for self-clear.
> > > > > - Return IRQ_NONE when IRQ is not handled in lan9645x_handle_inte=
rrupt.
> > > > > - Link to v1: https://lore.kernel.org/r/20260123-phy_micrel_add_s=
upport_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com
> > > > > ---
> > > > >  drivers/net/phy/micrel.c   | 152 +++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  include/linux/micrel_phy.h |   1 +
> > > > >  2 files changed, 153 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > > > index 225d4adf28be..fe77ad899f10 100644
> > > > > --- a/drivers/net/phy/micrel.c
> > > > > +++ b/drivers/net/phy/micrel.c
> > > > > @@ -6502,6 +6502,142 @@ static void lan8842_get_phy_stats(struct =
phy_device *phydev,
> > > > >      stats->tx_errors =3D priv->phy_stats.tx_errors;
> > > > >  }
> > > > >=20
> > > > > +#define LAN9645X_CONTROL_REGISTER           0x1f
> > > > > +#define LAN9645X_CONTROL_REGISTER_SOFT_RESET        BIT(1)
> > > > > +
> > > > > +#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN    0x47
> > > > > +#define LAN9645X_BTRX_QBIAS_POWER_DOWN              0x46
> > > > > +#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT  0x45
> > > > > +#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT   0x44
> > > > > +#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT   0x43
> > > > > +
> > > > > +static const struct lanphy_reg_data force_dac_tx_errata[] =3D {
> > > > > +    /* Force channel A/B/C/D TX on */
> > > > > +    { LAN8814_PAGE_POWER_REGS,
> > > > > +      LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
> > > > > +      0 },
> > > > > +    /* Force channel A/B/C/D QBias on */
> > > > > +    { LAN8814_PAGE_POWER_REGS,
> > > > > +      LAN9645X_BTRX_QBIAS_POWER_DOWN,
> > > > > +      0xaa },
> > > > > +    /* Tx low I on channel C/D overwrite */
> > > > > +    { LAN8814_PAGE_POWER_REGS,
> > > > > +      LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
> > > > > +      0xbfff },
> > > > > +    /* Channel B low I overwrite */
> > > > > +    { LAN8814_PAGE_POWER_REGS,
> > > > > +      LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
> > > > > +      0xabbf },
> > > > > +    /* Channel A low I overwrite */
> > > > > +    { LAN8814_PAGE_POWER_REGS,
> > > > > +      LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
> > > > > +      0xbd3f },
> > > > > +};
> > > > > +
> > > > > +static int lan9645x_config_init(struct phy_device *phydev)
> > > > > +{
> > > > > +    int ret;
> > > > > +
> > > > > +    /* Apply erratas from previous generations.  */
> > > > > +    ret =3D lan8842_erratas(phydev);
> > > > > +    if (ret < 0)
> > > > > +            return ret;
> > > > > +
> > > > > +    /* Apply errata for an issue where bringing a port down, can=
 cause a few
> > > > > +     * CRC errors for traffic flowing through adjacent ports.
> > > > > +     */
> > > > > +    return lanphy_write_reg_data(phydev, force_dac_tx_errata,
> > > > > +                                 ARRAY_SIZE(force_dac_tx_errata)=
);
> > > > > +}
> > > > > +
> > > > > +static int lan9645x_suspend(struct phy_device *phydev)
> > > > > +{
> > > > > +    int ret, val;
> > > > > +
> > > > > +    /* Force link down before software power down (SPD), by doin=
g software
> > > > > +     * soft reset. This resets the PHY, but keeps all register c=
onfiguration
> > > > > +     * intact. The bit self clears.
> > > > > +     *
> > > > > +     * This is needed as a workaround for an issue where perform=
ing SPD on a
> > > > > +     * port can bring adjacent ports down, when there is traffic=
 flowing
> > > > > +     * through the ports.
> > > > > +     */
> > > > > +    ret =3D phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
> > > > > +                     LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1);
> > >=20
> > > Any specific reason why you use a vendor-specific register here inste=
ad of BMCR
> > > via genphy_soft_reset()?
> > >=20
> > >=20
> >=20
> > Sorry I missed your mail. genphy_soft_reset() will do a software (hard)=
 reset via
> > bit 15 (BMCR_RESET). In particular it will reset the registers. We want=
 to do
> > a software soft reset, which resets the PHY without changing register v=
alues.
> >=20
> No, BMCR_RESET usually doesn't reset configuration registers. That's why =
the
> function is called genphy_*soft*_reset. In case your PHY behaves differen=
t,
> which configuration registers does it change?
>=20

Ok I tought that was the usual behavior. The register spec says BMCR_RESET =
will reset
the PHY and all its registers to their default state.


> >=20
> > > > > +    if (ret)
> > > > > +            return ret;
> > > > > +
> > > >=20
> > > > AI review pointed out an error here. I will fix in the next version=
.
> > > >=20
> > > > > +    ret =3D phy_read_poll_timeout(phydev, LAN9645X_CONTROL_REGIS=
TER, val,
> > > > > +                                !(val & LAN9645X_CONTROL_REGISTE=
R_SOFT_RESET),
> > > > > +                                3000, 100000, true);
> > > > > +    if (ret)
> > > > > +            return ret;
> > > > > +
> > > > > +    return genphy_suspend(phydev);
> > > > > +}
> > > > > +
> > > > > +static int lan9645x_config_intr(struct phy_device *phydev)
> > > > > +{
> > > > > +    int err;
> > > > > +
> > > > > +    /* enable / disable interrupts */
> > > > > +    if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> > > > > +            /* This is an internal PHY of lan9645x and is not po=
ssible to
> > > > > +             * change the polarity of irq sources in the OIC (CP=
U_INTR)
> > > > > +             * found in lan9645x. Therefore change the polarity =
of the
> > > > > +             * interrupt in the PHY from being active low instea=
d of active
> > > > > +             * high.
> > > > > +             */
> > > > > +            err =3D phy_write(phydev, LAN8804_CONTROL,
> > > > > +                            LAN8804_CONTROL_INTR_POLARITY);
> > > > > +            if (err)
> > > > > +                    return err;
> > > > > +
> > > > > +            /* By default interrupt buffer is open-drain in whic=
h case the
> > > > > +             * interrupt can be active only low. Therefore chang=
e the
> > > > > +             * interrupt buffer to be push-pull to be able to ch=
ange
> > > > > +             * interrupt polarity.
> > > > > +             */
> > > > > +            err =3D phy_write(phydev, LAN8804_OUTPUT_CONTROL,
> > > > > +                            LAN8804_OUTPUT_CONTROL_INTR_BUFFER);
> > > > > +            if (err)
> > > > > +                    return err;
> > > > > +
> > > > > +            err =3D lan8814_ack_interrupt(phydev);
> > > > > +            if (err)
> > > > > +                    return err;
> > > > > +
> > > > > +            err =3D phy_write(phydev, LAN8814_INTC,
> > > > > +                            LAN8814_INT_LINK | LAN8814_INT_FLF);
> > > > > +    } else {
> > > > > +            err =3D phy_write(phydev, LAN8814_INTC, 0);
> > > > > +            if (err)
> > > > > +                    return err;
> > > > > +
> > > > > +            err =3D lan8814_ack_interrupt(phydev);
> > > > > +    }
> > > > > +
> > > > > +    return err;
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t lan9645x_handle_interrupt(struct phy_device *=
phydev)
> > > > > +{
> > > > > +    int status;
> > > > > +
> > > > > +    status =3D phy_read(phydev, LAN8814_INTS);
> > > > > +    if (status < 0) {
> > > > > +            phy_error(phydev);
> > > > > +            return IRQ_NONE;
> > > > > +    }
> > > > > +
> > > > > +    if (status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
> > > > > +            phy_trigger_machine(phydev);
> > > > > +            return IRQ_HANDLED;
> > > > > +    }
> > > > > +
> > > > > +    return IRQ_NONE;
> > > > > +}
> > > > > +
> > > > >  static struct phy_driver ksphy_driver[] =3D {
> > > > >  {
> > > > >      PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
> > > > > @@ -6740,6 +6876,21 @@ static struct phy_driver ksphy_driver[] =
=3D {
> > > > >      .set_tunable    =3D lan8842_set_tunable,
> > > > >      .cable_test_start       =3D lan8814_cable_test_start,
> > > > >      .cable_test_get_status  =3D ksz886x_cable_test_get_status,
> > > > > +}, {
> > > > > +    PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X),
> > > > > +    .name           =3D "Microchip LAN9645X Gigabit PHY",
> > > > > +    .config_init    =3D lan9645x_config_init,
> > > > > +    .driver_data    =3D &ksz9021_type,
> > > > > +    .probe          =3D kszphy_probe,
> > > > > +    .soft_reset     =3D genphy_soft_reset,
> > > > > +    .suspend        =3D lan9645x_suspend,
> > > > > +    .resume         =3D genphy_resume,
> > > > > +    .config_intr    =3D lan9645x_config_intr,
> > > > > +    .handle_interrupt =3D lan9645x_handle_interrupt,
> > > > > +    .get_tunable    =3D lan8842_get_tunable,
> > > > > +    .set_tunable    =3D lan8842_set_tunable,
> > > > > +    .get_phy_stats  =3D lan8842_get_phy_stats,
> > > > > +    .update_stats   =3D lan8842_update_stats,
> > > > >  }, {
> > > > >      PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
> > > > >      .name           =3D "Microchip KSZ9131 Gigabit PHY",
> > > > > @@ -6838,6 +6989,7 @@ static const struct mdio_device_id __maybe_=
unused micrel_tbl[] =3D {
> > > > >      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
> > > > >      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
> > > > >      { PHY_ID_MATCH_MODEL(PHY_ID_LAN8842) },
> > > > > +    { PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X) },
> > > > >      { }
> > > > >  };
> > > > >=20
> > > > > diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_ph=
y.h
> > > > > index ca691641788b..9c6f9817383f 100644
> > > > > --- a/include/linux/micrel_phy.h
> > > > > +++ b/include/linux/micrel_phy.h
> > > > > @@ -33,6 +33,7 @@
> > > > >  #define PHY_ID_LAN8804              0x00221670
> > > > >  #define PHY_ID_LAN8841              0x00221650
> > > > >  #define PHY_ID_LAN8842              0x002216C0
> > > > > +#define PHY_ID_LAN9645X             0x002216D0
> > > > >=20
> > > > >  #define PHY_ID_KSZ886X              0x00221430
> > > > >  #define PHY_ID_KSZ8863              0x00221435
> > > > >=20
> > > > > ---
> > > > > base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
> > > > > change-id: 20260114-phy_micrel_add_support_for_lan9645x_internal_=
phy-6ef9a782cb8b
> > > > >=20
> > > > > Best regards,
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Emil
> > > >=20
> > >=20
> > >=20
> >=20
>=20


