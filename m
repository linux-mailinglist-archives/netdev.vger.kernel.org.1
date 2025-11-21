Return-Path: <netdev+bounces-240746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A417DC78ECD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D40E728B9B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FF2EFD81;
	Fri, 21 Nov 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnaAjUST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFD1494DB;
	Fri, 21 Nov 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726443; cv=none; b=FJbwd3fVtO1Lcfo6yKt9HFl5ir7TDffkGCXKbXdI9WxzXNQgjL+kg7AlCvGFWiq0I3b/SLooYjcuEme1jtEbltFRWLnDPWh8/dIka2A4j4h0weTiitVRfhSCgX+S00DyLopM9MtqWhwAeXa+51PMupdaAOx1uWX1m7vK9CR1Kbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726443; c=relaxed/simple;
	bh=ExbTU08QuKilLHZWqO5PHLLeHYoNecIov/BpiZeeVMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUiMxCxI/ugNMtn57y+KYNu/NSGlUxgOW2yClmhwcMlXlQsmUL+2+9w/0bPWvbPL580lhNWz6a2f8HH3X5YffxIIgDt4n3r7+iuERlDh9O+cf5lAucq9zzaR62as4tx6KmCSH5b9DKl+veskjHwHglQyRHWs1pzK5tdnAcdGwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnaAjUST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8503C4CEF1;
	Fri, 21 Nov 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763726443;
	bh=ExbTU08QuKilLHZWqO5PHLLeHYoNecIov/BpiZeeVMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnaAjUSTgOpgJpfOBIbXCZVISB4uhddyW+UXk0+CiBPI/ojfeLugrVvJ3Smk9KfDh
	 osGkC8jzTo0TUmAIHJFxJvo3Xnf60zkGu4DoP9iq25WKI/0V8bwwLowxX3QFywn/Vn
	 ilsOxtPpsyEoNFkrpls+ML2pd0ruQSKNg4hXDGJz5KLFeTa/3SMBV9hpd+x4w0aEho
	 3GlG+UDn4DXf0kl8qG69PWLrA7n6lgb5zISOYEpcy9Q1MAxr17wM4or59eScBQgJfb
	 LrN8dLixwHp0v/+6/6Nv6UhBlSiWuR9hDro2Y2HQu1AVUiyTeiRWKoUvutjRNRrPv0
	 EMAze6IVLkS/w==
Date: Fri, 21 Nov 2025 12:00:37 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based
 MDIO drivers to standalone
Message-ID: <20251121120037.GA1117685@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-9-vladimir.oltean@nxp.com>
 <20251120144046.GE661940@google.com>
 <20251120151458.e5syoeay45fuajlt@skbuf>
 <20251120163603.GK661940@google.com>
 <20251120195941.qumgpiwvkxvfjkug@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120195941.qumgpiwvkxvfjkug@skbuf>

On Thu, 20 Nov 2025, Vladimir Oltean wrote:

> On Thu, Nov 20, 2025 at 04:36:03PM +0000, Lee Jones wrote:
> > The canonical answer goes 3 ways: If you want to use the MFD API, move
> > the handling to drivers/mfd.
> 
> Wait, so now it's negotiable? What about "this device is not an MFD"
> from the other patch? Move it to another folder and suddenly it's an MFD?
> https://lore.kernel.org/netdev/20251120153622.p6sy77coa3de6srw@skbuf/

The "canonical answer" is the general answer, the one that applies to
everyone, not just your use-case.  I'm not (yet?) convinced that this is
an MFD, so at the moment, option one is not on the table for you.

> > If it's possible, use one of the predetermined helpers like
> > of_platform_populate() (and I think we authored another one that
> > worked around some of its issues, but I forget where we put it!).
> 
> yay...
> 
> I don't need the code necessarily, just the overall idea if you remember it.

It was an extension to "simple-bus".  Perhaps "simple-mfd"?

Again, it might not work for you, but it's an avenue worth exploring.

> > Or if all else fails, you have to register the device the old
> > fashioned way with the platform_device_*() API.
> 
> Do you realize that by this, you are inviting me to waste time until the
> next reviewer rightfully asks, why didn't you use MFD, then I'll point
> them towards this discussion, but you didn't really answer?

This is still an abuse of the MFD API.  Used outside of the subsystem
for something that isn't an MFD.  I like the idea of not duplicating
code, but the fact remains that this is a hack.

Another more recent avenue you may explore is the Auxiliary Bus.

-- 
Lee Jones [李琼斯]

