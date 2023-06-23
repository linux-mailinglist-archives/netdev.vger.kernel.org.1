Return-Path: <netdev+bounces-13425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9873B8CA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD3281B7F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76868BF0;
	Fri, 23 Jun 2023 13:29:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDF8BE0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:29:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215512696;
	Fri, 23 Jun 2023 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0YzlzbEMB0LPGmu6/QT5FYRqride8jWe0vW5pg1XefY=; b=Zfx3sA42KS6AK+dOCf2Q8Iq9s8
	j7HJKv0u+e4zJ/JJa+rKVTqF3omhAJRN77VwSpMvSX1C4DO/0C+xQAl4t209Efod6+1f7+wg0xo7d
	SwLwwOGoP9kIpXHJLZBicNGxe6j9xlh1VATtC4lvqjah/pT+S+gQfF2ROQRmyKRKWh1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCgqf-00HMO2-Ey; Fri, 23 Jun 2023 15:29:13 +0200
Date: Fri, 23 Jun 2023 15:29:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Revanth Kumar Uppala <ruppala@nvidia.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Message-ID: <9cd7f2bd-20e5-4c4e-8901-3913e4ce5e30@lunn.ch>
References: <20230621165853.52273-1-ruppala@nvidia.com>
 <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
 <DS0PR12MB6464B3A556B045BB35B293BBC323A@DS0PR12MB6464.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB6464B3A556B045BB35B293BBC323A@DS0PR12MB6464.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:28:49PM +0000, Revanth Kumar Uppala wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, June 21, 2023 11:00 PM
> > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > Cc: hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> > Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 21, 2023 at 10:28:53PM +0530, Revanth Kumar Uppala wrote:
> > > Add 10G and 5G speed entries for fixed PHY framework.These are needed
> > > for the platforms which doesn't have a PHY driver.
> > >
> > > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > 
> > This is the second time you have sent me this patch. You have failed to answer
> > the questions i asked you the last time.....
> Apologies for sending twice.
> C45 registers are not defined in the kernel as of now. But, we need to display the speed as 5G/10G when the same is configured as fixed link in DT node.
> It will be great if you can share any data for handling this.
> As of now, with this change we have taken care of providing proper speed log in kernel when 5G/10G is added as fixed links in DT node.

This is architecturally wrong. As i said, swphy emulates a C22 PHY,
and a C22 PHY does not support speeds greater than 1G. To make swphy
really support 5G and 10G, you would need to add C45 support, and then
extend the default genphy driver to look at the C45 registers as well.

However, that is all pointless. As i said, phylink fixed-link is not
limited to 1G speeds. Given what i see in Cc: i assume this is for a
tegre SoC? And that uses a Synopsys MAC? So you probably want to
modify the dwc driver to use phylink.

    Andrew

