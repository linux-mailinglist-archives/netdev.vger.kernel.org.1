Return-Path: <netdev+bounces-215575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B662BB2F4F6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CEF686D4A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870882F0C5B;
	Thu, 21 Aug 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sa1Tb74T"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF2264F99;
	Thu, 21 Aug 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771259; cv=none; b=OPK5PfD3DJnJ0UVVcqwSfQibBQ5mnHu5Xj9/nlbNE4OtcEedIKoVmwPIPT/0ED7FdinhK7MRjIhnIlRI/9j++5JH/lcbXFsLM2cvE4uW6Us2gkDJvjI7aPtge1JfSsjTHWEdNZSwUblkWfuZdgHtYVOU0PK7usESjgRnJoHHplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771259; c=relaxed/simple;
	bh=cM1YyM6yYa+RXccBpuLDpkZ6GribivREOwjxc1lSsYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaR9FqQEW9Ol+20V9rNAye7EG4Ow+bkYHrg9QDbc1vP/ptRa3lH3wQPc88Ty2Nkl6pPJI7Z273sHMfIBzv0EQiqPmBVy3GiSuC/cLrx4H1JEzT1xDvaYASCRplu9vkX4ICGEJba4MAHtUX5orfLcJROPVM6XY6F7rSwgFJdL8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sa1Tb74T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xwbnmilUfefNilKkhDbCSq1WdkxVj2w6J1wxm3ypUeo=; b=Sa1Tb74TcVeI48mk0D7etjkPmT
	/XwwnzzlPnizwBDMQZuztD9nAVDIBux9SKp1iehpl1mfi7sFRCP7mgxcbnrxGlVctgQiLG0WPcpkf
	1zzOkLC6i9LWVvKphMqv2pPPdoDz6iy9q6NBNpGlvnHBJCp6S80YG7CuMkibhoDs0ELIUptnpWbud
	QeTdCNwimGza4HPEmvSNaSWw6kDjxT28eS8RWDztdy9OsP9kKFIm2Uk/1RwIZ2XwbUItSUEj0Dh/B
	jpnyNtgkcPyRGfKsL96mhPfDo3SiNMN22XmjXkffk3L/f93y56FRFxNfxlmItW8yMQKrtyw8naSqE
	v6IWCS5Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33696)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1up2JD-000000000zI-0BCu;
	Thu, 21 Aug 2025 11:14:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1up2JB-0000000010g-2pb6;
	Thu, 21 Aug 2025 11:14:13 +0100
Date: Thu, 21 Aug 2025 11:14:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <aKbxdaDFMe2Fqnxu@shell.armlinux.org.uk>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-4-mmyangfl@gmail.com>
 <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk>
 <CAAXyoMMGCRZTuhYG0zxTgKdDdgB1brU7BAUiCVR_MheFK-n5Yw@mail.gmail.com>
 <aKbuQ7MCbq1JL9sw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKbuQ7MCbq1JL9sw@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 21, 2025 at 11:00:35AM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 21, 2025 at 05:25:46PM +0800, Yangfl wrote:
> > On Thu, Aug 21, 2025 at 4:30 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > Someone clearly doesn't believe in reading the documentation before
> > > writing code. This also hasn't been tested in any way. Sorry, but
> > > I'm going to put as much effort into this review as you have into
> > > understanding the phylink API, and thus my review ends here.
> > >
> > > NAK.
> > 
> > Sorry I'm quite new here. I don't understand very clearly why a
> > different set of calls is involved in dsa_switch_ops, so I referred to
> > other dsa drivers and made a working driver (at least tested on my
> > device), but I would appreciate it much if you could point it out in
> > an earlier version of series.
> 
> This isn't dsa_switch_ops, but phylink_mac_ops, which are well
> documented in include/linux/phylink.h. Please read the documentation
> found in that header file detailing the phylink_mac_ops methods.
> You'll find a brief overview before the struct, and then in the #if 0
> section, detailed per-method documentation.

Also, the reason I state that it hasn't been tested is because when
your mac_config method is invoked, and print debug information which
includes state->speed and state->duplex, and then go on to use these.
Phylink's sole call path to mac_config() does this:

        /* Stop drivers incorrectly using these */
        linkmode_zero(st.lp_advertising);
        st.speed = SPEED_UNKNOWN;
        st.duplex = DUPLEX_UNKNOWN;
        st.an_complete = false;
        st.link = false;

        phylink_dbg(pl,
                    "%s: mode=%s/%s/%s adv=%*pb pause=%02x\n",
                    __func__, phylink_an_mode_str(pl->act_link_an_mode),
                    phy_modes(st.interface),
                    phy_rate_matching_to_str(st.rate_matching),
                    __ETHTOOL_LINK_MODE_MASK_NBITS, st.advertising,
                    st.pause);

        pl->mac_ops->mac_config(pl->config, pl->act_link_an_mode, &st);

and you would've noticed in your debug print that e.g. state->speed and
state->duplex are both always -1, and thus are not useful. Note also the
debugging that phylink includes.

Note that no other mac_config() implementations refer to state->speed
and state->duplex. The only time drivers _write_ to these is in the
pcs_get_state() method if they support a PCS.

Therefore, I think your code is completely untested.

I'm also concerned about the SMI locking, which looks to me like you
haven't realised that the MDIO bus layer has locking which guarantees
that all invocations of the MDIO bus read* and write* methods are
serialised.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

