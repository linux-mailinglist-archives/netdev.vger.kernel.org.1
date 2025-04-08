Return-Path: <netdev+bounces-180407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97AA8139D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA114A2000
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785923BD1C;
	Tue,  8 Apr 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gug+5dJk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A011D61A2;
	Tue,  8 Apr 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133269; cv=none; b=ut938Oe27ztIxgCAOgc0v+A+/P3byz7VY4yxU/Hy6m1T8p93Ywoslsv2atA/uy9SaI52d17pKGHrMvp2kRyUTdzBgm3NrqsctrzYzcf3uGh264uNIpE+cfge8qFjTist+WkcwT25q2XRHbTNbwMuqjV7pc5WujQyM+tbLKedPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133269; c=relaxed/simple;
	bh=iGs2ZZHWszBkgjha1A2dY+//qUbJ939WmeteH4R9VoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGide0u/aBZ/dtQPqBxkI4et503S5P78DbZYfBr/GbiNy0XdNNhKnDKXbadb+Lun0kUqIQbScDhK8MyjJ+vqMDkUEsIaywjEr072CrYjEoi78j6CCVPjo7laX5UI2byCC1rYNSpsCGsqdzxU01TfQ1Kq/f2z8Evo9W/gCBbRQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gug+5dJk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y8RWM2V6ZnehV9xCG2Wi7D3YFpwSdHlPKuNFJkQ/bqQ=; b=Gug+5dJkFQ2rbCZ5IXZX4osrkc
	z4jCLXuY8M+Deo7TGvO4X3azXzNOY81Pym6BE1wRVtlX0j1A55PWe5bI2sC3crPMPxHw1CeStLy2o
	/V0QKXahJUMiiC0QA75pZ0B71CSfo3v561yu0Dz00hSkJbrLJPo2YlqRoNq7PJUrXxcRgH84YKKRU
	OmVjnaBReXWpYspNTe4XnqnxjIhTFm+dq6EUTbPorz00lCBHEMhGAjD6JCR7I3D0tHI4klOBUjGmX
	WZfuxE+cKAVpE7S62ePuI4c2mcHsgReKBCz99EZlrG7OMoPEVQAv2csuoYJ61Ua+C90ZhC8XailZA
	nZx7znGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51470)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2Cjb-0007pu-0I;
	Tue, 08 Apr 2025 18:27:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2CjV-0001bg-19;
	Tue, 08 Apr 2025 18:27:33 +0100
Date: Tue, 8 Apr 2025 18:27:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>, Joyce Ooi <joyce.ooi@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Robert Hancock <robert.hancock@calian.com>,
	Saravana Kannan <saravanak@google.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v2 00/14] Add PCS core support
Message-ID: <Z_VchfzoKOTvy5TQ@shell.armlinux.org.uk>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250408075047.69d031a9@kernel.org>
 <08c0e1eb-2de6-45bf-95a4-e817008209ab@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08c0e1eb-2de6-45bf-95a4-e817008209ab@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 11:30:43AM -0400, Sean Anderson wrote:
> On 4/8/25 10:50, Jakub Kicinski wrote:
> > On Mon,  7 Apr 2025 19:17:31 -0400 Sean Anderson wrote:
> >> This series depends on [1,2], and they have been included at the
> >> beginning so CI will run. However, I expect them to be reviewed/applied
> >> outside the net-next tree.
> > 
> > These appear to break the build:
> > 
> > drivers/acpi/property.c:1669:39: error: initialization of ‘int (*)(const struct fwnode_handle *, const char *, const char *, int,  unsigned int,  struct fwnode_reference_args *)’ from incompatible pointer type ‘int (*)(const struct fwnode_handle *, const char *, const char *, unsigned int,  unsigned int,  struct fwnode_reference_args *)’ [-Wincompatible-pointer-types]
> >  1669 |                 .get_reference_args = acpi_fwnode_get_reference_args,   \
> > 
> > Could you post as RFC until we can actually merge this? I'm worried 
> > some sleep deprived maintainer may miss the note in the cover letter
> > and just apply it all to net-next..
> 
> I would really like to keep RFC off the titles since some reviewers don't
> pay attention to RFC series.
> 
> Would [DO NOT MERGE] in the subject be OK?

I'd bet that those who have decided "RFC means the patch series is not
ready" will take such a notice to also mean the same, and ignore it.

I think there needs to be some kind of push-back against these
maintainers who explicitly state that they ignore RFC series - making
it basically anti-social behaviour in the kernel community.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

