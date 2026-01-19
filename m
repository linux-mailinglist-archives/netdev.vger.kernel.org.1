Return-Path: <netdev+bounces-251043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B3D3A5B7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F3F3099873
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A343033E8;
	Mon, 19 Jan 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gm+F2q9f"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584E29BDBC;
	Mon, 19 Jan 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819738; cv=none; b=tje+PtUE+yoKm0ynsqa9kwexY5MssdlaTGjk028zl2gKG+D0FAGVVm7sAkNIVqcabl+TGWS0NN3SAaAMaKZYmFcReszYRKXyhMMRgJx0U9RYETZXOUcKkwIcj1ct1VuhxqT4uLTt7btkMFm5x8Smu/BlpLvJ3ybjBYreJtqGGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819738; c=relaxed/simple;
	bh=o66Sb6kFq9J6nv6hGMxrr5SMYq6IbR2q/U3GHVpnxv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSRaFgJC4+jGbaETzAqS+1ngS8mxRg4xpXLoYjJaAO656oQ58fCs9owwuaDWWwPVQwysTkIRpx606utEwSAhRnOgjNExQIVHwdCPlgFk0zI44293Ozbt0CSvVWof4KamdIWjvH1uJgFhIL03sMM2BjAQSXvk6pMNtlBlPetALTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gm+F2q9f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CQCzGvirnWq3rbFNUpMoFLN+1/RvSr/ym1mT9YAMBQ0=; b=gm+F2q9fXdKouscyi3LgHtRFdU
	RjZqHo11YPvngkWZzFEJ0qOq6/VqnMll2pLTwN3NCe17+QXumkE6HKjmOAGzdu6tZWGs2T8T3kGsI
	vfVaAtnRN5wgqMVYORqcth3ls7o3m48fFZjfXFZUjvlXh/tQZEy/TzeB3SumSfqCsei5yEA/pvG8z
	3FJxe8Mwetm9I/ISUz8CCF1m9+f4bMVdZBstuirXnuB7uts2Zn9vU/rxgGANz5lHud5WzsY8a/bat
	PUV5k/oaXCdfHCP3UP1eWyFZIkOfy0wy2Cs+6n+54IIeoccI9bFMR2v9YLf5NcGyXxmLFe8Lh5d0E
	UFz9ttgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35260)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhmoO-000000004tH-2zR9;
	Mon, 19 Jan 2026 10:48:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhmoM-000000006UU-0Omy;
	Mon, 19 Jan 2026 10:48:42 +0000
Date: Mon, 19 Jan 2026 10:48:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Message-ID: <aW4MCTm_u6q8uaet@shell.armlinux.org.uk>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
 <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
 <e04e8bec-a7c5-4e2d-bdd8-fdf79c29deba@lunn.ch>
 <a8ea329c-42b9-4adc-80ad-2f602a5fbf0c@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ea329c-42b9-4adc-80ad-2f602a5fbf0c@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 07:30:20AM +0000, Josua Mayer wrote:
> On 18/01/2026 18:01, Andrew Lunn wrote:
> > On Sun, Jan 18, 2026 at 04:07:38PM +0200, Josua Mayer wrote:
> >> The extended compliance code value SFF8024_ECC_100GBASE_ER4_25GBASE_ER
> >> (0x3) means either 4-lane 100G or single lane 25G.
> > Is there a way to tell them apart?
> The physical connectors are different, so we can know from the
> device-tree compatible string.
> 
> For now sfp driver does not support qsfp.

And likely will never do.

I did look at QSFP support due to the LX2160A SR board, and I did
scratch some code together, but I didn't get far with it:

(a) LX2160A is just not flexible enough to consider the possibilities
    properly to implement support (no run-time reconfiguration of the
    interface mode.)

(b) QSFPs can be used as a single interface, or as multiple interfaces.
    There is no way that the SFP and phylink layers can cope with that
    as they are currently structured.

(c) QSFP EEPROMs have a completely different structure to SFP EEPROMs.

(d) I couldn't see any way that the QSFP EEPROM distinguished between
    e.g. a cable that had QSFP at one end and 4x SFP at the other vs
    a cable that had QSFP at each end, thus making it impossible to
    know whether 100G as 4 25G lanes would be possible.

(e) I'm aware that there's devlink which I believe can deal with some
    of this "single network interface of 4 lanes" vs "four network
    interfaces of 1 lane" configuration, but I've never used it, and
    when I looked at it, it wasn't clear how. I have no hardware that
    makes use of devlink to play with to find out.

Basically, QSFP support is something I have little knowledge of, there
is precious little on the 'net about its use, I have no hardware
experience with, and I don't see how it fits into Linux networking.
So I decided it would be a fools errand to attempt to implement
anything.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

