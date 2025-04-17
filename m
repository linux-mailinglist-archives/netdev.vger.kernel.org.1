Return-Path: <netdev+bounces-183863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA24A923F8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B57A441D99
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA142550DB;
	Thu, 17 Apr 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dj6uC8D1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42A25523B
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910846; cv=none; b=h4hRxSdzz4hSYwZQl2P3jzQ22rYapWbhcGI0lBcIqjdNAI5ZF6NIeINKUHY43pgkyhLauoSvfrJZ/vc3jCSAA4XpNrnw2T3cOZ9YFWZ+uBz290opzybKmc3g2eNf4HJrhyYKR/5B1ps4vvGyxQYmL9wSLqBz6ruS6xJur1WJ/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910846; c=relaxed/simple;
	bh=J0wQq9qXkFocdttGzOq0s517gL8mwXo/gWjEtWmm+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCJF0hjnmWuu4DNQQhczrvLlMS0FdDkAPjDNNi3joh5TXcWNHvDzI+yjAfXD8eSCHdZDkG/rTbElaPd0aK+2ukabln7ggD+i6ekbB8F1n68jLu67VN7MeJ8av0fRHGDldd4syj90NNg0XQLFJes+D3CylJuSpMaCeVyb7We289E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dj6uC8D1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o9STfED8h7hpebfGwjsOJF1PCgQ9TXhL2eOkwXz72CE=; b=dj6uC8D12jbxNQTbuZapVGH/YR
	7iQGDpR3outJ/bdMIfH94PmpspeQtLgCVcSSNhSyXcytiWqS29HH4+XWxV880eJ1EG3Af9m6oQpbM
	PuvmWzjrsavmedDNgxbYZ4bCDbZT4vDtynfJDxkP92R+iUVRV3whUyCrsOKdjJZf3Q9CGnp9mCrYw
	UwSpLzVfCUXPtdu4PULgbr9yx9Zd4eXPT2r7LCqIbXuzz59J2VVTb6xyTw7OtslLfr1OyteB0td/g
	ux6fuf/7EJ9U5aBrYnnOPuJui8eYmIit2D/7qfsf+uKj6FYjDCcLAMFBanwIAVkJfxUfq1r9EWFjK
	N12Eiv2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5T1D-0007jC-0g;
	Thu, 17 Apr 2025 18:27:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5T1B-0002cu-1J;
	Thu, 17 Apr 2025 18:27:17 +0100
Date: Thu, 17 Apr 2025 18:27:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
 <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 10:06:45AM -0700, Alexander Duyck wrote:
> On Thu, Apr 17, 2025 at 8:23 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Apr 17, 2025 at 03:35:56PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Apr 17, 2025 at 07:30:05AM -0700, Alexander H Duyck wrote:
> > > > This is the only spot where we weren't setting netif_carrier_on/off and
> > > > old_link_state together. I suspect you could just carry old_link_state
> > > > without needing to add a new argument. Basically you would just need to
> > > > drop the "else" portion of this statement.
> > > >
> > > > In the grand scheme of things with the exception of this one spot
> > > > old_link_state is essentially the actual MAC/PCS link state whereas
> > > > netif_carrier_off is the administrative state.
> > >
> > > Sorry to say, but you have that wrong. Neither are the administrative
> > > state.
> >
> > To add to this (sorry, I rushed that reply), old_link_state is used when
> > we aren't bound to a network device, otherwise the netif carrier state
> > is used. Changes in the netif carrier state provoke netlink messages to
> > userspace to inform userspace of changes to the link state.
> >
> > Moreover, it controls whether the network stack queues packets for
> > transmission to the driver, and also whether the transmit watchdog is
> > allowed to time out. It _probably_ also lets the packet schedulers
> > know that the link state has changed.
> >
> > So, the netif carrier state is not "administrative".
> 
> I have always sort of assumed that netif_carrier_on/off was the
> logical AND of the administrative state of the NIC and the state of
> the actual MAC/PCS/PHY. That is why I refer to it as an administrative
> state. You end up with ifconfig up/down toggling netif carrier even if
> the underlying link state hasn't changed. This has been the case for
> many of the high end NICs for a while now, especially for the
> multi-host ones, as the firmware won't change the actual physical
> state of the link. It leaves it in place while the NIC port on the
> host is no longer active.
> 
> > It isn't strictly necessary for old_link_state to remain in sync with
> > the netif carrier state, but it is desirable to avoid errors - but
> > obviously the netif carrier state only exists when we're bound to a
> > network device.
> 
> From what I can tell this is the only spot where the two diverge,
> prior to this patch. The general thought I was having was to update
> the netif_carrier state in the suspend, and then old_link_state in the
> resume. I realize now the concern is that setting the
> phylink_disable_state is essentially the same as setting the link
> down. So really we have 3 states we are tracking,
> netif_carrier_ok/old_link_state, phylink_disable_state, and if we want
> the link state to change while disabled. So we do need one additional
> piece of state in the event that there isn't a netdev in order to
> handle the case where "pl->phylink_disable_state &&
> !!pl->phylink_disable_state == pl->old_link_state".
> 
> > > > > -         /* Call mac_link_down() so we keep the overall state balanced.
> > > > > -          * Do this under the state_mutex lock for consistency. This
> > > > > -          * will cause a "Link Down" message to be printed during
> > > > > -          * resume, which is harmless - the true link state will be
> > > > > -          * printed when we run a resolve.
> > > > > -          */
> > > > > -         mutex_lock(&pl->state_mutex);
> > > > > -         phylink_link_down(pl);
> > > > > -         mutex_unlock(&pl->state_mutex);
> > > > > +         if (pl->suspend_link_up) {
> > > > > +                 /* Call mac_link_down() so we keep the overall state
> > > > > +                  * balanced. Do this under the state_mutex lock for
> > > > > +                  * consistency. This will cause a "Link Down" message
> > > > > +                  * to be printed during resume, which is harmless -
> > > > > +                  * the true link state will be printed when we run a
> > > > > +                  * resolve.
> > > > > +                  */
> > > > > +                 mutex_lock(&pl->state_mutex);
> > > > > +                 phylink_link_down(pl);
> > > > > +                 mutex_unlock(&pl->state_mutex);
> > > > > +         }
> > > >
> > > > You should be able to do all of this with just old_link_state. The only
> > > > thing that would have to change is that you would need to set
> > > > old_link_state to false after the if statement.
> > >
> > > Nope.
> >
> > And still nope - what we need to know here is what was the link state
> > _before_ we called netif_carrier_off() or set old_link_state to false.
> >
> > I somehow suspect that you don't understand what all this code is trying
> > to do, so let me explain it.
> >
> > In the suspend function, when WoL is enabled, and we're using MAC-based
> > WoL, we need the link to the MAC to remain up, so it can receive packets
> > to check whether they are the appropriate wake packet. However, we don't
> > want packets to be queued for transmission either.
> 
> That is the same as what we are looking for. We aren't queueing any
> packets for transmission ourselves. We just want to leave the MAC
> enabled, however we also want to leave it enabled when we resume.
> 
> > So, we have the case where we want to avoid notifying the MAC that the
> > link has gone down, but we also want to call netif_carrier_off() to stop
> > the network stack queueing packets.
> >
> > To achieve this, several things work in unison:
> >
> > - we take the state mutex to prevent the resolver from running while we
> >   fiddle with various state.
> > - we disable the resolver (which, if that's the only thing that happens,
> >   will provoke the resolver to take the link down.)
> > - we lie to the resolver about the link state, by calling
> >   netif_carrier_off() and/or setting old_link_state to false. This
> >   means the resolver believes the link is _already_ down, and thus
> >   because of the strict ordering I've previously mentioned, will *not*
> >   call mac_link_down().
> > - we release the lock.
> >
> > There is now no way that the resolver will call either mac_link_up() or
> > mac_link_down() - which is what we want here.
> 
> The part that I think I missed here was that if we set
> phylink_disable_state we then set link_state.link to false in
> phylink_resolve. I wonder if we couldn't just have a flag that sets
> cur_link_state to false in the "if(pl->phylink_disable_state)" case
> and simplify this to indicate we won't force the link down"

Then how does phylink_stop() end up calling .mac_link_down() ?

> So fbnic_mac_link_up_asic doesn't trigger any issues. The issues are:
> 
> 1. In fbnic_mac_link_down_asic we assume that if we are being told
> that the link is down by phylink that it really means the link is down
> and we need to shut off the MAC and flush any packets that are in the
> Tx FIFO. The issue isn't so much the call itself, it is the fact that
> we are being called in phylink_resume to rebalance the link that will
> be going from UP->UP. The rebalancing is introducing an extra down
> step. This could be resolved by adding an extra check to the line in
> phylink_resume that is calling the mac_link_down so that it doesn't
> get triggered and stall the link. In my test code I am now calling it
> "pl->rolling_start".

You're not addessing the issue I've already stated here.

If the link was up, and we *don't* call mac_link_down(), we then *can*
*not* call phylink_mac_initial_config(). It's as simple as that. The
MAC must see link down before being configured.

So, if the link was up, and we don't call mac_link_down() then we must
also *not* call phylink_mac_initial_config(). I've no idea what will
break with that change.

> 2. In phylink_start/phylink_resume since we are coming at this from a
> "rolling start" due to the BMC we have the MAC up and the
> netif_carrier in the "off" state. As a result if we end up losing the
> link between mac_prepare and pcs_get_state the MAC gets into a bad
> state where netif_carrier is off, the MAC is stuck in the "up" state,
> and we have stale packets clogging up the Tx FIFO.
> 
> As far as the BMC it isn't so much wanting to hit the big red button
> as our platform team. Basically losing of packets is very problematic
> for them, think about ssh sessions that suddenly lock up during boot,
> and they can demonstrate that none of the other vendors that have the
> MAC/PCS/PHY buried in their firmware have this issue. I was really
> hoping to avoid going that route as the whole point of this was to
> keep the code open source and visible.

The problem I have is not the idea, but the implementation. You want
to change the phylink behaviour in a way that affects *all* existing
users. I don't want that because of the guarantees of that contract
I've previously stated that I've given to existing users.

As things currently stand, you have a currently unique new case, and
you're trying to force your solution on all users potentially breaking
them. I have no real issue with supporting the new case, but *not* at
the expense of regressing existing phylink users.

Yet, when I point out this, you seem to be dead against *not* affecting
other users. This is where the problem is, and where we fundamentally
disagree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

