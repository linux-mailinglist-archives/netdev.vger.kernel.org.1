Return-Path: <netdev+bounces-100924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDCC8FC8A0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E93287961
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBF190069;
	Wed,  5 Jun 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I57wmE86"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2A19004E;
	Wed,  5 Jun 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581940; cv=none; b=rT9UBABMmOMh3uJh1pz/UeLRxGDDhGOljm2b6pyfii6NTlxdFkWM39Ror9r4PfolkXcEwtPg7xHVQe21ZIE8tZMSsRnON/kHSF4JeT6azEoJDG5wFxSPX0HJ1nmfXPT928JpIbIzdledQIUB7042yar5gb3ZA89r9aKDj+uHYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581940; c=relaxed/simple;
	bh=gF+QkYDC+x+YHW8RbZvwoGI0oop2AgIErhowEkH9LVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei1yfK31162TI/BkrdPyE6wjm8c/QMUr+mdsDNVjXCbvoc/g61UsCxfFCws07F1dGo9Apdwb50OmtAHgVtpZ7tWuLX/xYW0XNANJK+Bl6hWE/LLPxiLsxx816w6r/YpO7It+KNAKahVgQwme5JdyXErOFl8dCGSVBWDazmuqSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I57wmE86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E62C3277B;
	Wed,  5 Jun 2024 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717581939;
	bh=gF+QkYDC+x+YHW8RbZvwoGI0oop2AgIErhowEkH9LVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I57wmE86QdbVV2DlPDTCv/f4eJ34FOOkR/MmvCAdUq10dseRtNtVnUEgjUH2Ak7EB
	 auQVICdpVNQBqn0JlaJg/gnjO6+glqDvnecmQ3jt3EwCCFJyhTfZHLHbgXfHyanPHw
	 +WLZG/ROs/ACK13d0dgSpImTB1IpxC5fhLOc9Duo=
Date: Wed, 5 Jun 2024 12:05:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024060505-expose-crouch-00b1@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
 <2024060428-childcare-clunky-067c@gregkh>
 <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>

On Wed, Jun 05, 2024 at 12:53:13AM +0100, Vadim Fedorenko wrote:
> On 04/06/2024 12:50, Greg Kroah-Hartman wrote:
> > On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
> > > On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
> > > > On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
> > > > > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > > > > of serial core port device") changed the hierarchy of serial port devices
> > > > > and device_find_child_by_name cannot find ttyS* devices because they are
> > > > > no longer directly attached. Add some logic to restore symlinks creation
> > > > > to the driver for OCP TimeCard.
> > > > > 
> > > > > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > > > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > > > ---
> > > > > v2:
> > > > >    add serial/8250 maintainers
> > > > > ---
> > > > >    drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> > > > >    1 file changed, 21 insertions(+), 9 deletions(-)
> > > > 
> > > > Hi,
> > > > 
> > > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > > a patch that has triggered this response.  He used to manually respond
> > > > to these common problems, but in order to save his sanity (he kept
> > > > writing the same thing over and over, yet to different people), I was
> > > > created.  Hopefully you will not take offence and will fix the problem
> > > > in your patch and resubmit it so that it can be accepted into the Linux
> > > > kernel tree.
> > > > 
> > > > You are receiving this message because of the following common error(s)
> > > > as indicated below:
> > > > 
> > > > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> > > >     older released kernel, yet you do not have a cc: stable line in the
> > > >     signed-off-by area at all, which means that the patch will not be
> > > >     applied to any older kernel releases.  To properly fix this, please
> > > >     follow the documented rules in the
> > > >     Documentation/process/stable-kernel-rules.rst file for how to resolve
> > > >     this.
> > > > 
> > > > If you wish to discuss this problem further, or you have questions about
> > > > how to resolve this issue, please feel free to respond to this email and
> > > > Greg will reply once he has dug out from the pending patches received
> > > > from other developers.
> > > 
> > > Hi Greg!
> > > 
> > > Just gentle ping, I'm still looking for better solution for serial
> > > device lookup in TimeCard driver.
> > 
> > See my comment on the other patch in this thread.
> > 
> > In short, you shouldn't need to do any of this.
> 
> Got it, thanks. I'll try to find another way.

Wait, no, please just remove all that, it should not be needed at all.

