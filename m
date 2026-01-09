Return-Path: <netdev+bounces-248305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A100BD06B9E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25B630318DB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0B223DE5;
	Fri,  9 Jan 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0gZqiPH6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410FC8CE;
	Fri,  9 Jan 2026 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921616; cv=none; b=EI/mpHhx0HX5AMmLr5yZ7DpTw3e2tCg5Jdwvp//T5sQG07n4uFMr3LKOqW+U7wghQVaWuhcRocZ3oMIEubMK9GKNA7NvW2Vs5Rm1VV+nTGKp8TLGMtUBhLY/wXaX88ADtJNV5lnkkAZzBb/y3cC8zr0FxHL9/4bDlj/cY40iTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921616; c=relaxed/simple;
	bh=RXo2LTmSx/aMiRuwkgve9xKt/UT2J20iEvQCqtoFZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyZv83RMhOTGW6VnWWO3HoYDHk4/CO2rfCwpoFFbYbK7g6kycYThMlmaTqwH1rj/ndC8LqB7z4m86rlcKGAtnBkGbR+XGbuUAczuJ0eA53i/u1uOQ7k433so0ZJ295LIcR8vUsBgiDo+avEvnteqvF6bUdJ7C5Zws+vikMaiuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0gZqiPH6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tDSWb0Pfjh/hKJqVsAxcoUQ1zE4bf/GTYhKaDLn5N1A=; b=0gZqiPH6kAnaypnDIeHjrCdffR
	49jtlUe086EHNDeVruJgiu9cFa4Vqw4A7MJe+SIa7HKm3kdq2of6fNSbutY4ZCoAWt8UyrPY4x8PX
	rnCYgjpn+ZSiiW8VHzq8P4Rgo7dWgQNwpxOBJjqzbgET12bifL+d+UV51VKVYfr07t2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ve1AY-0022N8-Cb; Fri, 09 Jan 2026 02:20:02 +0100
Date: Fri, 9 Jan 2026 02:20:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ethernet: ave: Remove unnecessary 'out of
 memory' message
Message-ID: <a67e37be-62bd-49c5-8978-3dff792fb4e1@lunn.ch>
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
 <81841486-b0c2-4f12-b4d5-08fe214f18d9@lunn.ch>
 <34aaa094-daff-4045-b830-1687488c3e8e@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34aaa094-daff-4045-b830-1687488c3e8e@socionext.com>

On Fri, Jan 09, 2026 at 09:27:03AM +0900, Kunihiko Hayashi wrote:
> Hi Andrew,
> 
> On 2026/01/09 3:32, Andrew Lunn wrote:
> > On Thu, Jan 08, 2026 at 03:46:40PM +0900, Kunihiko Hayashi wrote:
> > > Follow the warning from checkpatch.pl and remove 'out of memory'
> > message.
> > > 
> > >      WARNING: Possible unnecessary 'out of memory' message
> > >      #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
> > >      +               if (!skb) {
> > >      +                       netdev_err(ndev, "can't allocate skb for
> > Rx\n");
> > 
> > Please take a read of
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> > 
> > You tagged this for net, not net-next. I would say this is not a fix.
> 
> Thank you for pointing out.
> I thought this was a "fix" for the warning, however, it's not a logical
> fix. So I'll repost it as net-next.

You might want to read:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

One key thing in that document is:

   It must either fix a real bug that bothers people or just add a device ID

Multiple messages that the system is out of people does not bother
people.

	Andrew

