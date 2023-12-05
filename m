Return-Path: <netdev+bounces-53976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0348057E3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1621C21007
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE565ECE;
	Tue,  5 Dec 2023 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nfvNuo59"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEFCA;
	Tue,  5 Dec 2023 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lfxnHu+Bi0iwFhaqZvuue6DCeOGeODkmNEtnuTLsk0c=; b=nfvNuo59MSr8p+SP/ioXzsTPk/
	Q0EM36l5MU7bhMCatc8Y31D+ViSTMtJss3YHAfecCj32JxgqcwotTO46FMtykJlJCfDqiDOhl8qiM
	Kf2oFBxe8UQ+I31Y8/+76VpXP6w7JPoY824CfgXd2kY7dDUZwijviiLdwb0h5Yq2MVqMmhNyNpMpN
	xXJtwwS4HYuyVQ3iEyb8FSH7W5fiHhCfwbuSWrAWc2m1W29ZAERbJvwCJH8ossvCD1040db8rBHpq
	9sY5gOoFrRZhCS5UMne5a73Kh1KbUNamhDqnaxaDUXe6hfWL/CAvlY6fhZVqN3cmiBE90YjpjmznG
	+6eJp0Ug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rAWlI-0006ua-05;
	Tue, 05 Dec 2023 14:51:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rAWlG-0001nZ-P9; Tue, 05 Dec 2023 14:50:58 +0000
Date: Tue, 5 Dec 2023 14:50:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <ZW840qQMbVRto442@shell.armlinux.org.uk>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8ASzkC9IFFlxkV@shell.armlinux.org.uk>
 <rgp33mm4spbpm5tmgxurkhy4is3lz3z62rz64rni2pygteyrit@zwflw2ejdkn7>
 <e1806c15-757e-4af0-a8be-075aa77918c2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1806c15-757e-4af0-a8be-075aa77918c2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 05, 2023 at 02:52:24PM +0100, Andrew Lunn wrote:
> On Tue, Dec 05, 2023 at 02:31:41PM +0300, Serge Semin wrote:
> > On Tue, Dec 05, 2023 at 10:49:47AM +0000, Russell King (Oracle) wrote:
> > > On Tue, Dec 05, 2023 at 01:35:27PM +0300, Serge Semin wrote:
> > > > If the DW XPCS MDIO devices are either left unmasked for being auto-probed
> > > > or explicitly registered in the MDIO subsystem by means of the
> > > > mdiobus_register_board_info() method there is no point in creating the
> > > > dummy MDIO device instance in order to get the DW XPCS handler since the
> > > > MDIO core subsystem will create the device during the MDIO bus
> > > > registration procedure.
> > > 
> > 
> > > Please reword this overly long sentence.
> > 
> > Ok.
> > 
> > > 
> > > If they're left unmasked, what prevents them being created as PHY
> > > devices?
> > 
> > Not sure I fully get what you meant. If they are left unmasked the
> > MDIO-device descriptor will be created by the MDIO subsystem anyway.
> > What the point in creating another one?
> 
> Saying what Russell said, in a different way:
> 
> /*
>  * Return true if the child node is for a phy. It must either:
>  * o Compatible string of "ethernet-phy-idX.X"
>  * o Compatible string of "ethernet-phy-ieee802.3-c45"
>  * o Compatible string of "ethernet-phy-ieee802.3-c22"
>  * o In the white list above (and issue a warning)
>  * o No compatibility string
>  *
>  * A device which is not a phy is expected to have a compatible string
>  * indicating what sort of device it is.
>  */
> bool of_mdiobus_child_is_phy(struct device_node *child)
> 
> So when walking the bus, if a node is found which fits these criteria,
> its assumed to be a PHY. 
> 
> Anything on the MDIO bus which is not a PHY needs to use a compatible.

Right. I'd actually forgotten about the firmware-based walking, and
was thinking more of the non-firmware bus scanning as the commit
message was talking about being _unmasked_ and the only mask we have
is bus->phy_mask.

It seems to me that this is yet another case of a really confusing
commit message making review harder than it needs to be.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

