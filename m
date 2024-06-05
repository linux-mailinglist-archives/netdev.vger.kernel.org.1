Return-Path: <netdev+bounces-100944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9248FC947
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49EC1F245F2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F9719147B;
	Wed,  5 Jun 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0C2F5kl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC6191476;
	Wed,  5 Jun 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584118; cv=none; b=e6Qs9Ossg9HFZAXXPKLMQLgvJEte9HzgOAS5gmZLBDT2lQ9vYCi/yZIovNf6uTjLBXtkbb6OrP0F/OhFe8kOZXqQX0wR9PRNDUK3iaQizeS9ifhqGECoznnu7yESQZIsR397Qnaq0nWAaKV+NMltHD3IuhY7HwiDTsLp9mdhX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584118; c=relaxed/simple;
	bh=rGhup8bCOLIVHgwdwvVVB0PlbwYepa87+vKda9cyoNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkcPYaW5jdhVfy6WyAawo0xjf/o4Iaw+5TePJBl6l+zay8SyCeejH9noiDU7ZefCG20dvWsUM4VnDzclGgNw2govyWFC43kjwX+0OZtm8FfaDmFS9COc1vhJv9Y8ZDNrqnAeEUf6Y55eGFZ0/0En5s/i2hFLSDdQuYMcxvC2Vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0C2F5kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78387C3277B;
	Wed,  5 Jun 2024 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717584117;
	bh=rGhup8bCOLIVHgwdwvVVB0PlbwYepa87+vKda9cyoNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0C2F5kluRrYLS2AwIPdw4lOkwFu2Us0FQHKps0pwQkQftu2rC3BGhOtoW5uVayOm
	 pZ56XOyljVAXxOMb5z+UX1/S726dIkwjSdkInS0HhXHCRbHgz9OQefMuS1h3v2vbph
	 c/4TdBEHxyCMlWr5A8ufoo8GSoy/X9sgATvvppwk=
Date: Wed, 5 Jun 2024 12:41:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024060514-recess-unblessed-431c@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
 <2024060428-childcare-clunky-067c@gregkh>
 <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>
 <2024060505-expose-crouch-00b1@gregkh>
 <cbcf7cbb-809f-47f8-bd98-e140875bc2d1@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbcf7cbb-809f-47f8-bd98-e140875bc2d1@linux.dev>

On Wed, Jun 05, 2024 at 11:14:28AM +0100, Vadim Fedorenko wrote:
> On 05/06/2024 11:05, Greg Kroah-Hartman wrote:
> > On Wed, Jun 05, 2024 at 12:53:13AM +0100, Vadim Fedorenko wrote:
> > > On 04/06/2024 12:50, Greg Kroah-Hartman wrote:
> > > > On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
> > > > > On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
> > > > > > On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
> > > > > > > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > > > > > > of serial core port device") changed the hierarchy of serial port devices
> > > > > > > and device_find_child_by_name cannot find ttyS* devices because they are
> > > > > > > no longer directly attached. Add some logic to restore symlinks creation
> > > > > > > to the driver for OCP TimeCard.
> > > > > > > 
> > > > > > > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > > > > > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > > > > > ---
> > > > > > > v2:
> > > > > > >     add serial/8250 maintainers
> > > > > > > ---
> > > > > > >     drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> > > > > > >     1 file changed, 21 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > > > > a patch that has triggered this response.  He used to manually respond
> > > > > > to these common problems, but in order to save his sanity (he kept
> > > > > > writing the same thing over and over, yet to different people), I was
> > > > > > created.  Hopefully you will not take offence and will fix the problem
> > > > > > in your patch and resubmit it so that it can be accepted into the Linux
> > > > > > kernel tree.
> > > > > > 
> > > > > > You are receiving this message because of the following common error(s)
> > > > > > as indicated below:
> > > > > > 
> > > > > > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> > > > > >      older released kernel, yet you do not have a cc: stable line in the
> > > > > >      signed-off-by area at all, which means that the patch will not be
> > > > > >      applied to any older kernel releases.  To properly fix this, please
> > > > > >      follow the documented rules in the
> > > > > >      Documentation/process/stable-kernel-rules.rst file for how to resolve
> > > > > >      this.
> > > > > > 
> > > > > > If you wish to discuss this problem further, or you have questions about
> > > > > > how to resolve this issue, please feel free to respond to this email and
> > > > > > Greg will reply once he has dug out from the pending patches received
> > > > > > from other developers.
> > > > > 
> > > > > Hi Greg!
> > > > > 
> > > > > Just gentle ping, I'm still looking for better solution for serial
> > > > > device lookup in TimeCard driver.
> > > > 
> > > > See my comment on the other patch in this thread.
> > > > 
> > > > In short, you shouldn't need to do any of this.
> > > 
> > > Got it, thanks. I'll try to find another way.
> > 
> > Wait, no, please just remove all that, it should not be needed at all.
> 
> Do you mean remove symlinks from the driver? We have open-source
> user-space software which relies on them to discover proper devices. If
> I remove symlinks it will break the software.

the symlinks should be done in userspace in the /dev/serial/ directory,
why would userspace need to know the symlink of the serial device in
a sysfs tree?  What exactly are you trying to represent here that
requires this to be a custom thing?

thanks,

greg k-h

