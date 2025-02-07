Return-Path: <netdev+bounces-163881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CBA2BED9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE0B188B89D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26F235BE5;
	Fri,  7 Feb 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQJm8tfh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59A235379;
	Fri,  7 Feb 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919462; cv=none; b=azQnpR92obCMW5kKiwrCI68eHMDeu1GHOKopdJIAPYOGji8TDafSjm3fCtiMFqe1saqUYztJ2ciovbVjzrqZcp1DSh3HRdYCvkSn+a62WFdGWhMjEJTk3MXliiSJlBlUXsC+qohTtXKJNj5EOdWl541fwHT/0plCPxpEQi/YgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919462; c=relaxed/simple;
	bh=3CrkUkwGfMhpX+uau3akz2gYZiSsurjxNQzB7mH33y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2iwWAD8WAYFwP9WVpb1n6dW3BUf3oVHWr8/c6C2j0vrYwSlh37MdxrWl9MId2qa7Ujm2/nFdiX1Q+mFvzVuES8kofG3H02GQrjibBsOw1sZmwIwU+i0uELDcgJY09Wnr/d+lDM0oDgquN/1OVu8vcb0ePFk/Cmv8LlFNMlCLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQJm8tfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DFBC4CED1;
	Fri,  7 Feb 2025 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738919461;
	bh=3CrkUkwGfMhpX+uau3akz2gYZiSsurjxNQzB7mH33y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQJm8tfhKvZ8YIAG03kmxXtfU2zZDS/va7mcQD8rnzIVMNKBEHvHz5AujFPXkm4jG
	 dainc1uSdPW/vImmUIPG1T42g8M/IAw0KrrhBgcTbHy5OmIXhQMwwfMV0FuhjRnce6
	 BkSVAt5e+Sm8teweFr4v/jL3aHRy7ZPGglwd4uho=
Date: Fri, 7 Feb 2025 10:10:57 +0100
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
Message-ID: <2025020716-dandruff-slacked-f6b1@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
 <2025020657-unsubtly-imbecile-faf4@gregkh>
 <912d59eb611448ed9da16ef82b79f77d6fa0c654.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <912d59eb611448ed9da16ef82b79f77d6fa0c654.camel@codeconstruct.com.au>

On Fri, Feb 07, 2025 at 04:49:05PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> Just a check here:
> 
> > > +               dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n",
> > > +                       __func__, status);
> > 
> > This could flood the logs, are you sure you need it at dev_err()
> > level?
> > 
> > And __func__ is redundant, it's present in dev_*() calls already.
> 
> am I missing something then?
> 
>    [  146.130170] usb 2-1: short packet (hdr) 6
> 
> emitted from:
> 
>     dev_dbg(&mctp_usb->usbdev->dev,
>             "short packet (hdr) %d\n",
>             hdr->len);
> 
> Seems like we get the driver name, but not the function.
> 
> I'm happy to remove the __func__ output either way, but I will also
> make the logs a little more descriptive for context, if we don't have
> func data.

Please read Documentation/admin-guide/dynamic-debug-howto.rst, it shows
how to get the function information from the dev_dbg() lines at runtime.

In short:
	$ alias ddcmd='echo $* > /proc/dynamic_debug/control'
	# add function to all enabled messages
	$ ddcmd '+f'

hope this helps,

greg k-h

