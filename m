Return-Path: <netdev+bounces-100549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EC8FB1AA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E5282F67
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A76145FFD;
	Tue,  4 Jun 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oo+2jigT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3225145FF9;
	Tue,  4 Jun 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502423; cv=none; b=Z4Uffl+/iqBbmGPnpTBwG4X8njKM9VO6iN2qh2YhqJxLOKR8DV6RArelf5gQkIA1KkaE5javDs4aHX5HC38wd/lCcoyZxC3EgekMbJer8xaVhRxUK/7pEHo3qQeVK4oDRKhgCHVmWiJ35CXTRN8T9BeyoKr6O1iltOG3M9o/pLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502423; c=relaxed/simple;
	bh=w5mWNUL5jxIc30HBPwzkBv4ciJQ19LBfMfB+svf/32g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQqxJPckoj1mF7DSy8wi87efz+laZ3F2zytx5NhGxXxxRrKizNyP+FexaOT17lYnmUFXMRPRxuBi2BtYdYPgZQj9X3FI8X7xZYnDGe6f7W4PbTFQNSyN8BVZTZmnzkZgJ9rWXCleA7d2waMwcKVOQE0GofUlJkKYKkCY6d1PORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oo+2jigT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B30CC4AF0A;
	Tue,  4 Jun 2024 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717502423;
	bh=w5mWNUL5jxIc30HBPwzkBv4ciJQ19LBfMfB+svf/32g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oo+2jigT2TIcmpgLRq94ZgWSlilujMupc2xbKaYIKojG0fcRgyk6TxmzLotRwy1Hi
	 GUR1EK4KZAun7Bu9v3YF2erlv9+2LXyhBK6E0tJw+T4DJzJ8RuFIYVyws2BxYC+e+m
	 JSsUxpoZz6F2KYj5lEtkCOJ4daY6r/ZnScBc0w00=
Date: Tue, 4 Jun 2024 13:50:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024060428-childcare-clunky-067c@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>

On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
> On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
> > On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
> > > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > > of serial core port device") changed the hierarchy of serial port devices
> > > and device_find_child_by_name cannot find ttyS* devices because they are
> > > no longer directly attached. Add some logic to restore symlinks creation
> > > to the driver for OCP TimeCard.
> > > 
> > > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > ---
> > > v2:
> > >   add serial/8250 maintainers
> > > ---
> > >   drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> > >   1 file changed, 21 insertions(+), 9 deletions(-)
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >    older released kernel, yet you do not have a cc: stable line in the
> >    signed-off-by area at all, which means that the patch will not be
> >    applied to any older kernel releases.  To properly fix this, please
> >    follow the documented rules in the
> >    Documentation/process/stable-kernel-rules.rst file for how to resolve
> >    this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> 
> Hi Greg!
> 
> Just gentle ping, I'm still looking for better solution for serial
> device lookup in TimeCard driver.

See my comment on the other patch in this thread.

In short, you shouldn't need to do any of this.

thanks,

greg k-h

