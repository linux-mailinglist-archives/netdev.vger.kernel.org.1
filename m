Return-Path: <netdev+bounces-100985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FE8FCE5A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E00B1C250D6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A319AA65;
	Wed,  5 Jun 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYjqA5Th"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56219A2B9;
	Wed,  5 Jun 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590149; cv=none; b=qPBVfR8NyBVUPzfBZlqxTw4DxVO5lM0ndveZdzCCidYo7XpIXcQWJzZO45WtxOA0TYV/PnlheUU50q4Q5I+X8MKCJOI+vTc5op2vBNP6JxzMF0HwADDD1spzFTFwu/u/0VXQ3ybY6kIlMX0bQIZ/FFGJPH0bovHm61iLE+1kkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590149; c=relaxed/simple;
	bh=8TYpI0Sc6XL37qpMHuVUCVeU0MMlAF5i9HTwI7oGbHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHd5+3yCjAO4P2dwtPeVudVyiiZPRPEyT0jonu7t/O5skvEZZ6P9CWPfi4bqsdH9d0R76PrGKR3OfkMLlAX6A9eftlroZlbM79IAOEZTVrMeNUhnj7O1YBkMpnAKkiLtuKIiRp0pEDrPYjB9TWwX96Gom8UfjqxtVkmZ5IfRcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYjqA5Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C532C32781;
	Wed,  5 Jun 2024 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717590149;
	bh=8TYpI0Sc6XL37qpMHuVUCVeU0MMlAF5i9HTwI7oGbHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYjqA5Th+RA+f+HXfmD4LmI/DgBE+GFUESMjA8+cmKlO6g9MlxrGiewSKMacJFO4c
	 kqFM9TCmCzLiZENjVewPgCoVREnBIqfyMFccmFe5ALuluOUoq4Tx4ueydy2FI8IUy5
	 /bM2VIn5rcNVKI3pl2REybsJHlk6isrHslOGMUgY=
Date: Wed, 5 Jun 2024 14:22:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024060551-grazing-handling-e9ed@gregkh>
References: <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
 <2024060428-childcare-clunky-067c@gregkh>
 <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>
 <2024060505-expose-crouch-00b1@gregkh>
 <cbcf7cbb-809f-47f8-bd98-e140875bc2d1@linux.dev>
 <2024060514-recess-unblessed-431c@gregkh>
 <15f59e29-ac03-4018-bbc3-c4ac5a2964db@linux.dev>
 <2024060503-subsonic-pupil-bbee@gregkh>
 <f226b16c-e603-409b-a9a7-f1a201da10a0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f226b16c-e603-409b-a9a7-f1a201da10a0@linux.dev>

On Wed, Jun 05, 2024 at 12:25:26PM +0100, Vadim Fedorenko wrote:
> On 05/06/2024 12:07, Greg Kroah-Hartman wrote:
> > On Wed, Jun 05, 2024 at 11:59:30AM +0100, Vadim Fedorenko wrote:
> > > On 05/06/2024 11:41, Greg Kroah-Hartman wrote:
> > > > On Wed, Jun 05, 2024 at 11:14:28AM +0100, Vadim Fedorenko wrote:
> > > > > On 05/06/2024 11:05, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Jun 05, 2024 at 12:53:13AM +0100, Vadim Fedorenko wrote:
> > > > > > > On 04/06/2024 12:50, Greg Kroah-Hartman wrote:
> > > > > > > > On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
> > > > > > > > > On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
> > > > > > > > > > On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
> > > > > > > > > > > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > > > > > > > > > > of serial core port device") changed the hierarchy of serial port devices
> > > > > > > > > > > and device_find_child_by_name cannot find ttyS* devices because they are
> > > > > > > > > > > no longer directly attached. Add some logic to restore symlinks creation
> > > > > > > > > > > to the driver for OCP TimeCard.
> > > > > > > > > > > 
> > > > > > > > > > > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > > > > > > > > > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > > > > > > > > > ---
> > > > > > > > > > > v2:
> > > > > > > > > > >       add serial/8250 maintainers
> > > > > > > > > > > ---
> > > > > > > > > > >       drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> > > > > > > > > > >       1 file changed, 21 insertions(+), 9 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > > > > > > > > a patch that has triggered this response.  He used to manually respond
> > > > > > > > > > to these common problems, but in order to save his sanity (he kept
> > > > > > > > > > writing the same thing over and over, yet to different people), I was
> > > > > > > > > > created.  Hopefully you will not take offence and will fix the problem
> > > > > > > > > > in your patch and resubmit it so that it can be accepted into the Linux
> > > > > > > > > > kernel tree.
> > > > > > > > > > 
> > > > > > > > > > You are receiving this message because of the following common error(s)
> > > > > > > > > > as indicated below:
> > > > > > > > > > 
> > > > > > > > > > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> > > > > > > > > >        older released kernel, yet you do not have a cc: stable line in the
> > > > > > > > > >        signed-off-by area at all, which means that the patch will not be
> > > > > > > > > >        applied to any older kernel releases.  To properly fix this, please
> > > > > > > > > >        follow the documented rules in the
> > > > > > > > > >        Documentation/process/stable-kernel-rules.rst file for how to resolve
> > > > > > > > > >        this.
> > > > > > > > > > 
> > > > > > > > > > If you wish to discuss this problem further, or you have questions about
> > > > > > > > > > how to resolve this issue, please feel free to respond to this email and
> > > > > > > > > > Greg will reply once he has dug out from the pending patches received
> > > > > > > > > > from other developers.
> > > > > > > > > 
> > > > > > > > > Hi Greg!
> > > > > > > > > 
> > > > > > > > > Just gentle ping, I'm still looking for better solution for serial
> > > > > > > > > device lookup in TimeCard driver.
> > > > > > > > 
> > > > > > > > See my comment on the other patch in this thread.
> > > > > > > > 
> > > > > > > > In short, you shouldn't need to do any of this.
> > > > > > > 
> > > > > > > Got it, thanks. I'll try to find another way.
> > > > > > 
> > > > > > Wait, no, please just remove all that, it should not be needed at all.
> > > > > 
> > > > > Do you mean remove symlinks from the driver? We have open-source
> > > > > user-space software which relies on them to discover proper devices. If
> > > > > I remove symlinks it will break the software.
> > > > 
> > > > the symlinks should be done in userspace in the /dev/serial/ directory,
> > > > why would userspace need to know the symlink of the serial device in
> > > > a sysfs tree?  What exactly are you trying to represent here that
> > > > requires this to be a custom thing?
> > > 
> > > Well, the hardware exposes up to 4 different serial ports for different
> > > functions. And only driver knows which feature is attached to which port
> > > because of differences in the HW. There is no way for user-space to get
> > > this information on it's own.
> > 
> > The serial ports have a specific parent, why aren't those parents
> > described differently in userspace?  Why not tell userspace those
> > functions?
> 
> There is only 1 parent for the serial ports - the pci device driven by
> ptp_ocp. The physical devices behind these serial ports are not able to
> do proper pci function.

Then make those "physical devices" on the aux bus, splitting the PCI
device "apart".  That's what the aux bus is for.

> > > And one more thing, some HW versions
> > > expose special attributes in sysfs consumed by the same software.
> > > And there are setups with several boards in the system. Currently we
> > > separate them by providing different sysfs entries only, the software
> > > then figures all details automatically.
> > 
> > Again, export that info to userspace and have it choose, don't create
> > random symlinks in sysfs for your specific policy, that is not what
> > sysfs is for at all.
> 
> Yes, that's what I'm thinking about now - export serial ports as another
> attributes of the device.

Or use the aux bus :)

thanks,

greg k-h

