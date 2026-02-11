Return-Path: <netdev+bounces-258290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHH9FJaMjGn5qwAAu9opvQ
	(envelope-from <netdev+bounces-258290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A351250D0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49EF0300C248
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694229BD89;
	Wed, 11 Feb 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yXBArCCX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52929993E;
	Wed, 11 Feb 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818702; cv=none; b=Praour+2Bu4giqCuLKa/og622ToUzv+JHhKysS0MEIm1ip/sGQ3zPpVt3rsKumYDmIXFJeuLoMREY+BIxmqTDhdQyRoGWBWDc+5rCZ5ivHTXhOsMD2yP2CrI+Nl3UUqYsHuT31DBqSOWssM8ci6VJON2vz5iYbgCvaGVKyp9G5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818702; c=relaxed/simple;
	bh=6D4INZaMdeljtfKkSegaqRYyuz4jDJMZcc/4/M+19Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmBdVvFWlqeFJ3DekFlbe5qHfGd5USesUP5jMiMSfZxLeA9I82ZKDf9vSrXS1V6gbLCCYCXqsc31YNifS/r8aojIuUspyDZJadca4unZQlP5OtuebvkCwkcK2hreqGa/jYPQrsLSfW7ipBLwzrpiwa8VJniF0lW4/I5AjXbF6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yXBArCCX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=goJkCgqmhNLw0pIAnPED82g9oHuiqbn/RWVxFtVCoTk=; b=yXBArCCXcQn4duj1qTf5aY+0ZS
	jmR6Yf/40AdXLkuq3kvzXZlhXLpyB1We839Hy4kk88QRjWw9aj7uXYOWk0Rg7OdTnY+VrrrfXXemU
	45FGbbH0GoTXQLZkAxf2N6vWTQGsDyNOIW9JlZiI3i3fjeRDUccNF8NgJJw1Tz74UZmfw7/x35roc
	B5fIAXhstwkqa7wLqMlORKY/ix81x/gxnXFbKPP36FmTX7LABp6c5AF/5e35TKyExTxyC1mL6X0u+
	csehbSEy8Ovbv8usRCOc0aAP/2tSMHOwFuslKQbvXDsLOhAEiSpj2d0zwS27xNqZxU2UVByyLGaS7
	pfTHcA7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vqApn-000000003UG-3NRf;
	Wed, 11 Feb 2026 14:04:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vqApk-000000003p6-3ZAV;
	Wed, 11 Feb 2026 14:04:48 +0000
Date: Wed, 11 Feb 2026 14:04:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, hkallweit1@gmail.com, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
Message-ID: <aYyMgK73UtBd6vqc@shell.armlinux.org.uk>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <aYyDkaynWEm-WJdg@shell.armlinux.org.uk>
 <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,ti.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B0A351250D0
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 07:23:12PM +0530, Meghana Malladi wrote:
> Hi Russell,
> 
> On 2/11/26 18:56, Russell King (Oracle) wrote:
> > On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
> > > When using DP83869 in force 100Base-Tx mode, the PHY is required
> > > to have robust Auto-MDIX feature enabled from register 1Eh.
> > > Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
> > > 
> > > [1]: https://www.ti.com/lit/ds/symlink/dp83869hm.pdf
> > > Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> > > ---
> > >   drivers/net/phy/dp83869.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> > > index 1f381d7b13ff..70d759c45c6a 100644
> > > --- a/drivers/net/phy/dp83869.c
> > > +++ b/drivers/net/phy/dp83869.c
> > > @@ -110,6 +110,7 @@
> > >   /* CFG4 bits */
> > >   #define DP83869_INT_OE	BIT(7)
> > > +#define DP83869_CFG4_ENABLE_AUTO_MDIX_100FD	BIT(9)
> > >   /* OP MODE */
> > >   #define DP83869_OP_MODE_MII			BIT(5)
> > > @@ -900,6 +901,23 @@ static int dp83869_phy_reset(struct phy_device *phydev)
> > >   	return dp83869_config_init(phydev);
> > >   }
> > > +static void dp83869_link_change_notify(struct phy_device *phydev)
> > > +{
> > > +	int cfg4;
> > > +
> > > +	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
> > > +	 * to have robust Auto-MDIX feature enabled
> > > +	 */
> > > +	if (phydev->autoneg == AUTONEG_DISABLE &&
> > > +	    phydev->speed == SPEED_100 &&
> > > +	    phydev->duplex == DUPLEX_FULL) {
> > > +		cfg4 = phy_read(phydev, DP83869_CFG4);
> > > +		if (cfg4 >= 0) {
> > > +			cfg4 |= DP83869_CFG4_ENABLE_AUTO_MDIX_100FD;
> > > +			phy_write(phydev, DP83869_CFG4, cfg4);
> > > +		}
> > > +	}
> > 
> > Shouldn't this kind of configuration be done via .config_aneg() ?
> > 
> 
> AFAIK, in case of fixed mode, auto-neg might not be triggered all the time.
> In the phy_ethtool_ksettings_set() function, auto-neg is initiated only if
> the PHY hasn't started. PHY drivers are new to me, please do correct me if I
> am wrong.

In phy_ethtool_ksettings_set():

        /* Restart the PHY */
        if (phy_is_started(phydev)) {
                phydev->state = PHY_UP;
                phy_trigger_machine(phydev);
        } else {
                _phy_start_aneg(phydev);
        }

If the PHY is started, then the state machine is triggered. That
will result in phy_state_machine() being called.

This calls _phy_state_machine(), which, as phydev->state is set to
PHY_UP, will set state_work = PHY_STATE_WORK_ANEG. This will then
result in:

        if (state_work == PHY_STATE_WORK_ANEG) {
                err = _phy_start_aneg(phydev);
                func = &_phy_start_aneg;
        }

which also results in _phy_start_aneg() being called, and thus the
.config_aneg() method.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

