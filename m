Return-Path: <netdev+bounces-13429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E273B92A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3977281BD5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7F8F5D;
	Fri, 23 Jun 2023 13:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BA8F4A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:55:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60C83;
	Fri, 23 Jun 2023 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZmHKaPZANja9gMDDIDUivy8OiBcMC9KZ3mP0QZjw4Fw=; b=d4IxQE7UMriFZv3z/q1y023/SZ
	9/oPfozKGCXr6tGYHOV1QsJBfh2TBf1zRlHWahqSJn2KcmNne0itT4+9QU9yHOF8ksJiYWBo1UjOz
	DDGpIKJcW8w7x3Kom4qncjnSxXBVvRHryPzRVOO7Xjs2E4VsAOVgp67euRIcweGJBQOHImDcKeSle
	BM/+At20brqeYe08bif//nGBS0PFs4OHPIinv4s8DsPYXUxkAH+GAnFDaDYpqXYKA/jXwjfeepYK6
	vsZu+zCVHNoOmrmkFVbYlbRTXz0a2TB5t8fGBVVKL3A5XGHrbPI3vdZcNd3hf+49Wxgfx/tXLy5vW
	jAdLBtzg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qChG3-0005MV-46; Fri, 23 Jun 2023 14:55:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qChG1-0001Vs-QF; Fri, 23 Jun 2023 14:55:25 +0100
Date: Fri, 23 Jun 2023 14:55:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Revanth Kumar Uppala <ruppala@nvidia.com>,
	Narayan Reddy <narayanr@nvidia.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Message-ID: <ZJWkTTI5CY8rJmhT@shell.armlinux.org.uk>
References: <20230621165853.52273-1-ruppala@nvidia.com>
 <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
 <DS0PR12MB6464B3A556B045BB35B293BBC323A@DS0PR12MB6464.namprd12.prod.outlook.com>
 <9cd7f2bd-20e5-4c4e-8901-3913e4ce5e30@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd7f2bd-20e5-4c4e-8901-3913e4ce5e30@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 03:29:13PM +0200, Andrew Lunn wrote:
> On Fri, Jun 23, 2023 at 12:28:49PM +0000, Revanth Kumar Uppala wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Wednesday, June 21, 2023 11:00 PM
> > > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > Cc: hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > > tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> > > Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
> > > 
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Wed, Jun 21, 2023 at 10:28:53PM +0530, Revanth Kumar Uppala wrote:
> > > > Add 10G and 5G speed entries for fixed PHY framework.These are needed
> > > > for the platforms which doesn't have a PHY driver.
> > > >
> > > > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > > 
> > > This is the second time you have sent me this patch. You have failed to answer
> > > the questions i asked you the last time.....
> > Apologies for sending twice.
> > C45 registers are not defined in the kernel as of now. But, we need to display the speed as 5G/10G when the same is configured as fixed link in DT node.
> > It will be great if you can share any data for handling this.
> > As of now, with this change we have taken care of providing proper speed log in kernel when 5G/10G is added as fixed links in DT node.
> 
> This is architecturally wrong. As i said, swphy emulates a C22 PHY,
> and a C22 PHY does not support speeds greater than 1G. To make swphy
> really support 5G and 10G, you would need to add C45 support, and then
> extend the default genphy driver to look at the C45 registers as well.
> 
> However, that is all pointless. As i said, phylink fixed-link is not
> limited to 1G speeds. Given what i see in Cc: i assume this is for a
> tegre SoC? And that uses a Synopsys MAC? So you probably want to
> modify the dwc driver to use phylink.

Absolutely correct. I seem to recall having had this come up before,
and I think it was explained at the time, but I don't seem to find
anything in my "sent" mailboxes for the start of 2022 to present.

(To nvidia)

The classical swphy/fixed-phy offers a software emulated clause 22 PHY
so that phylib can be re-used to make a fixed link work without needing
special code paths in phylib nor in MAC drivers.

However, clause 22 PHYs do not support speeds in excess of 1G, so this
places a hard ceiling on the speed that can be supported with this
method. PHYLIB's clause 45 support is specific to vendor PHYs, and
the "generic" implementation only supports 10G speed. Emulating a
specific vendor PHY to achieve this old way of supporting fixed links
when we have a better way is really a waste of effort.

The "better way" is phylink, which makes fixed links work without
needing to resort to PHY emulation, and thus it can support any speed
that a MAC happens to support. This is the modern way.

We (the phylib and phylink maintainers) will not entertain extending
the old now legacy method using swphy/fixed-phy for fixed links to
include any faster speeds.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

