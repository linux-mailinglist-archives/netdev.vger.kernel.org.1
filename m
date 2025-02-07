Return-Path: <netdev+bounces-163959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6BA2C283
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1989188CF55
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD011F4E48;
	Fri,  7 Feb 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unIvZXNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DD1E0DEA;
	Fri,  7 Feb 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930723; cv=none; b=gz9y4uonTghCcZLfxj9txDua5b6Ze71oAp/LSMO5dUnXP+JvMvL56vUP+dxglc2+RUpHYLip0U3+YzdROZ77uG18PV0hiPLcoV576p3CZiuu94MJG3of7xWTMRI60eCOBJqqXWxLunIsfGCb3Qo8LDzk/c0J71sXT6fT3JiXEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930723; c=relaxed/simple;
	bh=4GtazkZ/UKVoFswHzv50P6e8W1a2j5cChdeToedyCJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFzzu2Ib2NZVIGeKj8j34IY2yHh1Uh93xwkgF1XfV9AN67L0wqYv9zzIE+217M30GxzxmHxbR52HbI6mgloEpDloWh46qhZKj9GiI9kbO4BGoWn3qDtr0tAokPuiGxhbDzosw6rJ9eS+2NB7ji6hfmyLjvVYPde/lFfjwdUWZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=unIvZXNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A405AC4CED1;
	Fri,  7 Feb 2025 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738930723;
	bh=4GtazkZ/UKVoFswHzv50P6e8W1a2j5cChdeToedyCJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unIvZXNUfYel4NAlHTaX8yblkjwj5wdnkgct8BSJu7TwzvKQsY//gmbvgofS5Migo
	 TQxs9AWK0AFoROWH0U0+6fueK1TLVDnXaKK15gZ0bZabJag9HnGQ4qcgVOm4+Wq/Ay
	 efUMEEjsLIEc7OQPKLi6VETqvglvryyq+GfXLZv8=
Date: Fri, 7 Feb 2025 13:18:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
Message-ID: <2025020731-malformed-pendant-e283@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
 <2025020657-unsubtly-imbecile-faf4@gregkh>
 <912d59eb611448ed9da16ef82b79f77d6fa0c654.camel@codeconstruct.com.au>
 <2025020716-dandruff-slacked-f6b1@gregkh>
 <f670c97228b7ae8ac1efd426f83438825e800625.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f670c97228b7ae8ac1efd426f83438825e800625.camel@codeconstruct.com.au>

On Fri, Feb 07, 2025 at 05:45:33PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> > > > > +               dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n",
> > > > > +                       __func__, status);
> > > > 
> > > > This could flood the logs, are you sure you need it at dev_err()
> > > > level?
> > > > 
> > > > And __func__ is redundant, it's present in dev_*() calls already.
> > > 
> > > am I missing something then?
> > > 
> > >    [  146.130170] usb 2-1: short packet (hdr) 6
> > > 
> > > emitted from:
> > > 
> > >     dev_dbg(&mctp_usb->usbdev->dev,
> > >             "short packet (hdr) %d\n",
> > >             hdr->len);
> > > 
> > > Seems like we get the driver name, but not the function.
> > > 
> > > I'm happy to remove the __func__ output either way, but I will also
> > > make the logs a little more descriptive for context, if we don't have
> > > func data.
> > 
> > Please read Documentation/admin-guide/dynamic-debug-howto.rst, it shows
> > how to get the function information from the dev_dbg() lines at runtime.
> > 
> > In short:
> >         $ alias ddcmd='echo $* > /proc/dynamic_debug/control'
> >         # add function to all enabled messages
> >         $ ddcmd '+f'
> 
> Your original comment was on the dev_err() call though (sorry, I've
> complicated the discussion by using a dev_dbg() example).

Sorry, I got confused here too, I saw it on dev_dbg() calls in my
review.

> Looks like only dev_dbg (and not _err/_warn/etc) has provision for
> __func__, is that right?

Yes.

> I've since removed the __func__ references anyway, and replaced with
> better context on the messages, but keen to make sure I have the correct
> understanding in general.

That sounds better, avoiding __func__ wherever possible is usually a
good idea.

thanks,

gre gk-h

