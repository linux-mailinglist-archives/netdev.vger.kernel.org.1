Return-Path: <netdev+bounces-166488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18ACA36239
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6542165092
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8C266F19;
	Fri, 14 Feb 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p+i7l12c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498F25A2C2
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548172; cv=none; b=PULCGaImOGcJsWBLlEH79Nus3+0yidfEiZ3dYfYdzqwH0dPUhrU11MsVylqalDzhiXIFHeOAdYaeN9181+bYlgvgUdOPQ+bS41cwFSWE5hDnuW9qSNTMe+4Yg19FMgDhIfxx3PAm9IS1GNAQRbQsFc7McwBl0C8C8p8paGPaecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548172; c=relaxed/simple;
	bh=+NDVTWBh16IdVm++1kwTQBrJUDIOEa0DfMHjrRvw6FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O06j5IRiC7sHcdxz/OuGzx1mnDiDhcPnct7gBlqcS5oUHHsxJ1ITw0eaXcQAFuZ1PymA2VH4tC8/w3UQmkeX02MF9CyFix9G9YbiCTKuc1KKw5IDLaRkhZwQI3/S3Ae0zekEuu3r6+b54R0Plz9zlWpr4PJNgRQpUtQKdO4Fvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p+i7l12c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uWr5aL3n/UJ8pvNvCv68/ixvP8tVjiWsiUBzbbG4T3A=; b=p+
	i7l12c8IJyDN0cEpcGMw+VQHK4NgemOgsTnV5HuBbslbIvE0pW+H/JL0hidKc/vXcIh8/I1parmDy
	aA0Pe68e+zcBs8C0DZ4OjtkqoM/VWSUtpYa5I9v5mmSQE/BIBCF2qBvicUsNa+UYXRjmGJXuUnpjP
	ViFuuL9uMdHAfCI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tixwP-00E77i-JE; Fri, 14 Feb 2025 16:49:21 +0100
Date: Fri, 14 Feb 2025 16:49:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] net: phy: remove fixup-related definitions
 from phy.h which are not used outside phylib
Message-ID: <1be1ef1f-9f8f-4e91-9ec2-1ad19914bb93@lunn.ch>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
 <fa4d7341-7e88-46d1-befb-1c18bd689701@intel.com>
 <be779825-b17c-4f72-a442-9371fdf05c2a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be779825-b17c-4f72-a442-9371fdf05c2a@gmail.com>

On Fri, Feb 14, 2025 at 12:11:09PM +0100, Heiner Kallweit wrote:
> On 14.02.2025 11:59, Mateusz Polchlopek wrote:
> > 
> > 
> > On 2/13/2025 10:48 PM, Heiner Kallweit wrote:
> >> Certain fixup-related definitions aren't used outside phy_device.c.
> >> So make them private and remove them from phy.h.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>   drivers/net/phy/phy_device.c | 16 +++++++++++++---
> >>   include/linux/phy.h          | 14 --------------
> >>   2 files changed, 13 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> >> index 9b06ba92f..14c312ad2 100644
> >> --- a/drivers/net/phy/phy_device.c
> >> +++ b/drivers/net/phy/phy_device.c
> >> @@ -45,6 +45,17 @@ MODULE_DESCRIPTION("PHY library");
> >>   MODULE_AUTHOR("Andy Fleming");
> >>   MODULE_LICENSE("GPL");
> >>   +#define    PHY_ANY_ID    "MATCH ANY PHY"
> >> +#define    PHY_ANY_UID    0xffffffff
> >> +
> > 
> > Overall looks like a nice cleanup but I am not sure about this space
> > between #define and PHY_ANY_ID or PHY_ANY_UID...
> > 
> There's a tab, which effectively equals a space. Maybe it's just the
> diff which is misleading. At least checkpatch didn't complain.

So long as it is a straight cut/paste from the old location, this is
fine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

