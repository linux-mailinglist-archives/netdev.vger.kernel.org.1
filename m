Return-Path: <netdev+bounces-143266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0929C1C0B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E381C21F4E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77F1E3DE4;
	Fri,  8 Nov 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LxUG45Y3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3841E0E0F;
	Fri,  8 Nov 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064712; cv=none; b=uab/Zh3Mm6nnXFU9kGhJGXZwyGX4JQnOp368ivvZKOuhQtT+yrVcWYG7MhskOqAMhhQeYJ+15rS6bpEV8GTe3XRAdH5OB74XnWmGEQstwmtkf0uXUraw2Fe685wZn74n+jN2AsxxR5uFIyBoymvjItnnwLDJI5IJU0IBKbAcSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064712; c=relaxed/simple;
	bh=o7n+bwD0RpsOsPJ/gpHm+G0z7G438qSoutWYaRtgFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhct7vwggozjpLGRlV145B3Gg1/5uPXU1lnZ7ATgHKrM7GH5ItY232Xd1SiRowu0yh2k92FXqF4WUnN+Inds24I1MJH+FyrYXrMjXvTnsxPCrBypDYFO6O+ZEtDXFFQ9TowplOXbq/696IY22sc3PDhayaDEuTKM8lMoeywUico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LxUG45Y3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2cN7+fcpq3L63jt/AUpS+68YG4k7E+yUvX7PUc285Ew=; b=LxUG45Y3Ffi4l5fcCIrMKlrw3M
	K9rdAx2D4MGTnQ5lkz3+bbl7gvCfHNo0TB362aYnbroGPD59UBkAML01r9y3iQm9YHmrxI4/wsG/U
	S9r1FmljlDiTFw0E7YNDmNtJB7dQgDDCMDFMpLwoDgZ6e+ZgrFnGwumZRgiUm3cmzWcnyB/c2rCfz
	/OMcWwjb8xdbv8BwjrCYLj3hsJBFm6cSJ7Lfj6XUhi/DCjGJmYTpjFmFNPEwYU0Js44CV4K7AGsPY
	hbPcY0DLsMZVGSHgfdUmNrzz7WIeBH5mUKqkO2pQ41rlzrXvYvzDlaVsUiRrxGJOsHIAQEJLYDpvj
	CAJMnrYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43430)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9N0L-000501-1E;
	Fri, 08 Nov 2024 11:18:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9N0J-0002Ed-2L;
	Fri, 08 Nov 2024 11:18:15 +0000
Date: Fri, 8 Nov 2024 11:18:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/7] net: sparx5: do some preparation work
Message-ID: <Zy3zd12CoUp6dC2q@shell.armlinux.org.uk>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-1-f7f7316436bd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-1-f7f7316436bd@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 06, 2024 at 08:16:39PM +0100, Daniel Machon wrote:
> @@ -134,6 +134,9 @@ enum sparx5_feature {
>  
>  #define SPARX5_MAX_PTP_ID	512
>  
> +#define SPX5_ETYPE_TAG_C     0x8100

Maybe at some point consider using ETH_P_8021Q which is defined in
uapi/linux/if_ether.h ?

> +#define SPX5_ETYPE_TAG_S     0x88a8

Maybe also consider adding ETH_P_8021AD to uapi/linux/if_ether.h ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

