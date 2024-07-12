Return-Path: <netdev+bounces-111081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BDA92FCB1
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41308281571
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81D172BA8;
	Fri, 12 Jul 2024 14:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0C171670
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794988; cv=none; b=s1DbizGYTFvYXFaqkEQmamPUq5gCgCuwlSCk7Q/O5v90h90Bgy/hZEkjKR90Cn4pBeMlbQ7+pndy5DrcxXh0k12KjZzzU9GJ8qqKntSoTxdCvbnfMFtn2hEYRWTF95Uvzi5EnIMJydElrXu2q0LhNwV5e9/U26wQgUgxOfDMkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794988; c=relaxed/simple;
	bh=svJbA1BekZ2dk739QeaF+Utydr8sR+CxwwHyqT6FHi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2lROEO1mSlR99HWdwOmGRxr1RuMWt91f9f8t+HqiXsnY069q1f09Mbb/kXcvz7ryYAdT/pcklYS/LrAVCod69WcDQuZ0BAQ2JypMWNjHqv6MkgdpE5jKkVfHblyP7bPPXacLm2xTBnQ1EPmilDUv9e8zbEzNgynq57Gh+VUsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sSHNd-0007ws-3Y; Fri, 12 Jul 2024 16:36:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sSHNb-0091M6-Es; Fri, 12 Jul 2024 16:36:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sSHNb-00CKuQ-1A;
	Fri, 12 Jul 2024 16:36:11 +0200
Date: Fri, 12 Jul 2024 16:36:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <ZpE_WwtSSdxGyWtC@pengutronix.de>
References: <20240708140542.2424824-1-o.rempel@pengutronix.de>
 <a14ae101-d492-45a0-90fe-683e2f43fa3e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a14ae101-d492-45a0-90fe-683e2f43fa3e@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Andrew,

On Mon, Jul 08, 2024 at 06:44:22PM +0200, Andrew Lunn wrote:
> On Mon, Jul 08, 2024 at 04:05:42PM +0200, Oleksij Rempel wrote:
> > Implement the TDR test procedure as described in "Application Note
> > DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.
> > 
> > The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
> > cable length was 5 meters more for each 20 meters of actual cable length.
> > For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
> > showed as 50 meters. Since other parts of the diagnostics provided by this
> > PHY (e.g., Active Link Cable Diagnostics) require accurate cable
> > characterization to provide proper results, this tuning can be implemented
> > in a separate patch/interface.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/phy/dp83td510.c | 158 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> > 
> > diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> > index d7616b13c5946..3375fa82927d0 100644
> > --- a/drivers/net/phy/dp83td510.c
> > +++ b/drivers/net/phy/dp83td510.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/ethtool_netlink.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/phy.h>
> > @@ -29,6 +30,42 @@
> >  #define DP83TD510E_INT1_LINK			BIT(13)
> >  #define DP83TD510E_INT1_LINK_EN			BIT(5)
> >  
> > +#define DP83TD510E_TDR_CFG			0x1e
> > +#define DP83TD510E_TDR_START			BIT(15)
> > +#define DP83TD510E_TDR_DONE			BIT(1)
> > +#define DP83TD510E_TDR_FAIL			BIT(0)
> > +
> > +#define DP83TD510E_CTRL				0x1f
> > +#define DP83TD510E_CTRL_HW_RESET		BIT(15)
> > +#define DP83TD510E_CTRL_SW_RESET		BIT(14)
> > +
> > +#define DP83TD510E_TDR_CFG1			0x300
> 
> > +/* TX_TYPE: Transmit voltage level for TDR. 0 = 1V, 1 = 2.4V */
> > +#define DP83TD510E_TDR_TX_TYPE			BIT(12)
> 
> This does not appear to be used, so it is not too important. But i
> generally encode this as
> 
> #define DP83TD510E_TDR_TX_TYPE_1V		(0 << 12)
> #define DP83TD510E_TDR_TX_TYPE_2V4		(1 << 12)
> 
> You can then OR in DP83TD510E_TDR_TX_TYPE_1V which does nothing, but
> does document you are using 1V for the test.

Ack.

> > +#define DP83TD510E_TDR_CFG2			0x301
> > +#define DP83TD510E_TDR_END_TAP_INDEX_1		GENMASK(14, 8)
> > +#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF	36
> > +#define DP83TD510E_TDR_START_TAP_INDEX_1	GENMASK(6, 0)
> > +#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF	3
> 
> Does this correspond the minimum and maximum distance it will test?
> Is this 3m to 36m?

No. At least, i can't confirm it with tests.

If I see it correctly, this PHY is using SSTDR instead of usual TDR.
Instead of pulses it will send modulated transmission with default
length of 16ms

I tried my best google foo, but was not able to find anything
understandable about "Start/End tap index for echo coeff sweep for segment 1"
im context of SSTDR. If anyone know more about this, please tell me :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

