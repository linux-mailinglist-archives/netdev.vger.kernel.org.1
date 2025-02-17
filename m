Return-Path: <netdev+bounces-166917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B670A37DD5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974E63AD883
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB719ABAC;
	Mon, 17 Feb 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZeuqWps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA2155316;
	Mon, 17 Feb 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782966; cv=none; b=fZ9ZMMKu7bVCLNMkAu/x3NtREtqorvqBEJO2qF6C9ccIW1i3lPBacCEJYAXX8dxjv4jxpp68ZLm3/ydFOCR6n71AZ2Qr82aSlyJ8CbmQYqN2qr+DIyfibJ5/887Bvtv5/o1KkpxyKtcqS898Mq9IQe00Q7W1DxvD+g6vviQj2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782966; c=relaxed/simple;
	bh=E7ozwNZOZtMRGn9GNFnShpqaxPkGZgbRvZoEXEH03yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lif6dJmB94Nkp4lHjHj+VQyWTDBA/Tp1C+kD+E1LO1izXsRwvr8moL4row2n3K0zmQhCegMR1WfX79Kv9t6huHbvZX69muZ+WPWYGSfvm6qUtSVAWjgP7K3SCyNcxTpSOf09R1BnPOqAGa+pJr2OjXx/h2QpmuLq+HvzJv3Nt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZeuqWps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E490C4CEE2;
	Mon, 17 Feb 2025 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739782965;
	bh=E7ozwNZOZtMRGn9GNFnShpqaxPkGZgbRvZoEXEH03yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZeuqWps5jaDWDnY5qzTeNMWGBgBZ3CRTNBz3Tn5LCFvfzV37kY6bFFWm9EqRin3H
	 x22LHEywRCwOZdcH/nO+O61Etb3/GB0ZJAY3jJOnoNth9zP8rZnD3BvRyxxiB/5Jg4
	 KCaiw55N1D1sLUDXyJ83se+LjCH8hXSELwhBrKYo=
Date: Mon, 17 Feb 2025 10:02:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next v2 1/2] usb: Add base USB MCTP definitions
Message-ID: <2025021758-negate-entwine-5d40@gregkh>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
 <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
 <2025021240-perplexed-hurt-2adb@gregkh>
 <20d5843de6629036ce67420be9d2d2b5907c3261.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20d5843de6629036ce67420be9d2d2b5907c3261.camel@codeconstruct.com.au>

On Mon, Feb 17, 2025 at 04:55:59PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> > > --- /dev/null
> > > +++ b/include/linux/usb/mctp-usb.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > 
> > I missed this the last time, sorry, but I have to ask, do you really
> > mean v2 or later?  If so, that's fine, just want to make sure.
> 
> I'm fine with 2.0+, but I figure the preference is consistency here. So,
> since I'm doing a v3, I will send that out with GPL-2.0.
> 
> > Whichever you pick is fine with me, so:
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks! v3 will have the __u8s changed to u8, as Jakub has requested.
> Would you like me to keep the Ack on that?

Yes, that's fine.  But to be fair, "__u8" is correct here as that's what
the endpoint variable is as well (it is coming directly from hardware),
but I'm not going to complain about that as it really doesn't matter :)

thanks,

greg k-h

