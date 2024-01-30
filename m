Return-Path: <netdev+bounces-67247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253984277C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F631C20B61
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB560ED9;
	Tue, 30 Jan 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dpkzXTht"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25C7CF08
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626979; cv=none; b=sx4DEZODsPtXyT8/3ILuskzGdh9hL53CnJwTjKKkZY50wZsnFyF77btG+5sFzdiYWbT2VK3WGP29rj71n8ddUSjcd+zkHdAX4YqE52E9ceNgoMRQ9/fMu6LgVhJ2PZLFNt5ifkBUZVnp7vAq0qQFqCpPhQTTgZCbtQJqQXjurrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626979; c=relaxed/simple;
	bh=ekhS35aTtIRuYnh1gdo6mGpL/s1t6jkFHW2ZHUQFpnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V83Gkop3PWTXKQ2kJmqu77AbWJlEfBa4DTTrp56zciPeKc5Pix1GuhUuldGrpd+Xl1iAeeakDeJV/jfdFvioJkvuas8zKtl1G3znYiFQYE1EPPouBi/5QQhlt1apta4zsPXoSQu37jlCooQ5BCuCnyAPGfVVs01uM5rQf88xKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dpkzXTht; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vywR6FZxwGLiiVFuwjMUW7E3nmDQ7HTBIPMCNkMGrM8=; b=dp
	kzXThtw9e4ioHba+DNuvhEzVedflxSHeV44XkHMQQHgRdWTHugjPVROTP3lh1jztYV6aNqcNVRr9C
	Wdz4UMQXlpv85MJMhCeVAuGQ1RXTeuN4DnnfC5s6qUaAnZfKyrDK9ZSLZt+cHOEyJfv5mLB0OYBip
	llwd59xrSiJwKEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUpdT-006VGq-Aj; Tue, 30 Jan 2024 16:02:51 +0100
Date: Tue, 30 Jan 2024 16:02:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linus.walleij@linaro.org,
	alsi@bang-olufsen.dk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Message-ID: <9657a15e-7c60-4244-9c27-327d96b7b76b@lunn.ch>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf>
 <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
 <a50ca71f-e0b9-43ad-a08f-b4ee8a349387@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a50ca71f-e0b9-43ad-a08f-b4ee8a349387@arinc9.com>

On Tue, Jan 30, 2024 at 05:40:26PM +0300, Arınç ÜNAL wrote:
> On 29.01.2024 19:22, Florian Fainelli wrote:
> > 
> > 
> > On 1/29/2024 8:15 AM, Vladimir Oltean wrote:
> > >  From other discussions I've had, there seems to be interest in quite the
> > > opposite thing, in fact. Reboot the SoC running Linux, but do not
> > > disturb traffic flowing through the switch, and somehow pick up the
> > > state from where the previous kernel left it.
> > 
> > Yes this is actually an use case that is very dear to the users of DSA in an airplane. The entertainment system in the seat in front of you typically has a left, CPU/display and right set of switch ports. Across the 300+ units in the plane each entertainment systems runs STP to avoid loops being created when one of the display units goes bad. Occasionally cabin crew members will have to swap those units out since they tend to wear out. When they do, the switch operates in a headless mode and it would be unfortunate that plugging in a display unit into the network again would be disrupting existing traffic. I have seen out of tree patches doing that, but there was not a good way to make them upstream quality.
> 
> This piqued my interest. I'm trying to understand how exactly plugging in a
> display unit into the network would disrupt the traffic flow. Is this about
> all network interfaces attached to the bridge interface being blocked when
> a new link is established to relearn the changed topology?

The hardware is split into two parts, a cradle and the display
unit. The switch itself is in the cradle embedded in the seat
back. The display unit contains the CPU, GPU, storage etc. There is a
single Ethernet interface between the display unit and the cradle,
along with MDIO, power, audio cables for the headphone jack etc.

When you take out the display unit, you disconnect the switches
management plain. The CPU has gone, and its the CPU running STP,
sending and receiving BPDUs, etc. But the switch is still powered, and
switching packets, keeping the network going, at least for a while.

When you plug in a display unit, it boots. As typical for any computer
booting, it assumes the hardware is in an unknown state, and hits the
switch with a reset. That then kills the local networking, and it
takes a little while of the devices around it to swap to a redundant
path. The move from STP to RSTP has been made, which speeds this all
up, but you do get some disruption.

It can take a while for the display unit to boot into user space and
reconfigure the switch. Its only when that is complete can the switch
rejoin the network.

Rather than hit the switch with a reset, it would be better to somehow
suck the current configuration out of the switch and prime the Linux
network stack with that configuration. But that is a totally alien
concept to Linux.

	Andrew

