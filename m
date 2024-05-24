Return-Path: <netdev+bounces-97915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E30078CE02A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 06:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F4B228DD
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 04:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D52231F;
	Fri, 24 May 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KkK7PXhw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E83A27E;
	Fri, 24 May 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523611; cv=none; b=YdwmIr1v5MXK/8XrtEQyttfiZroB2De+DG17Oje0z/FpMVX/c/b/IUkoRzQ88+rJwTuNCYZJBpYNP/EV0+O/7fkfnCASEX8hhVG3ZAdkiWBJnQaSRzkhaqnwj55zOi7Op0YM0txT4GHKFWQQGwObE2devO89c+dBvV1bOmmPM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523611; c=relaxed/simple;
	bh=mvCI9+AspQM7khXp6L5EaPq+WlLu+anOKkiH9By+Tz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trG9eKtj6wp7PrMyK/KQW4LTdhRdhcPSpGSp1JaR7c308lIJQz5d88KvW/Y0q6lmdI6/ZtpHSdGwSy6fJ97/uqYKK0PEJ+BgMcjMzht4UyppIHufMcy5R3dVpQUWWtlj5TQVULzJeYxPlETMenj60ibfClbGkwl7LKSaR3y5KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KkK7PXhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78025C2BBFC;
	Fri, 24 May 2024 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716523611;
	bh=mvCI9+AspQM7khXp6L5EaPq+WlLu+anOKkiH9By+Tz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkK7PXhw4GsQyPaPh4TT1O3Cx7VI0ASmR/NGXB3jMwqgHO6a+BtYv9DEUbKK8p3NV
	 x574jhMQZGuiW1svmw8lD2kIj2yaJTv2vAFDM6IEi2nL8XrNNd9etuBUQmWfQfNBoP
	 UVd8ojb7IF1aBYwa93mKZQp/x24JL8q5sRREIJJk=
Date: Fri, 24 May 2024 06:06:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024052450-spoon-matchbox-e09e@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <20240523083943.6ecb60d9@kernel.org>
 <2024052349-tapestry-astronaut-0de1@gregkh>
 <9a65d299-2c3f-43b4-a3c7-4dca397dafaa@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a65d299-2c3f-43b4-a3c7-4dca397dafaa@linux.dev>

On Thu, May 23, 2024 at 10:06:05PM +0100, Vadim Fedorenko wrote:
> On 23/05/2024 17:26, Greg Kroah-Hartman wrote:
> > On Thu, May 23, 2024 at 08:39:43AM -0700, Jakub Kicinski wrote:
> > > On Fri, 10 May 2024 11:04:05 +0000 Vadim Fedorenko wrote:
> > > > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > > > of serial core port device") changed the hierarchy of serial port devices
> > > > and device_find_child_by_name cannot find ttyS* devices because they are
> > > > no longer directly attached. Add some logic to restore symlinks creation
> > > > to the driver for OCP TimeCard.
> > > > 
> > > > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > > ---
> > > > v2:
> > > >   add serial/8250 maintainers
> > > > ---
> > > >   drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> > > >   1 file changed, 21 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > > > index ee2ced88ab34..50b7cb9db3be 100644
> > > > --- a/drivers/ptp/ptp_ocp.c
> > > > +++ b/drivers/ptp/ptp_ocp.c
> > > > @@ -25,6 +25,8 @@
> > > >   #include <linux/crc16.h>
> > > >   #include <linux/dpll.h>
> > > > +#include "../tty/serial/8250/8250.h"
> > > 
> > > Hi Greg, Jiri, does this look reasonable to you?
> > > The cross tree include raises an obvious red flag.
> > 
> > Yeah, that looks wrong.
> > 
> > > Should serial / u8250 provide a more official API?
> > 
> > If it needs to, but why is this driver poking around in here at all?
> 
> Hi Greg!
> 
> Well, the original idea was to have symlinks with self-explanatory names
> to real serial devices exposed by PCIe device.

Why is that needed?  What is wrong with the normal device topology in
/sys/devices/ that shows this already?

> > > Can we use device_for_each_child() to deal with the extra
> > > layer in the hierarchy?
> > 
> > Or a real function where needed?
> 
> yep.
> 
> > 
> > > 
> > > >   #define PCI_VENDOR_ID_FACEBOOK			0x1d9b
> > > >   #define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
> > > > @@ -4330,11 +4332,9 @@ ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
> > > >   }
> > > >   static void
> > > > -ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
> > > > +ptp_ocp_link_child(struct ptp_ocp *bp, struct device *dev, const char *name, const char *link)
> > > >   {
> > > > -	struct device *dev, *child;
> > > > -
> > > > -	dev = &bp->pdev->dev;
> > > > +	struct device *child;
> > > >   	child = device_find_child_by_name(dev, name);
> > > >   	if (!child) {
> > > > @@ -4349,27 +4349,39 @@ ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
> > > >   static int
> > > >   ptp_ocp_complete(struct ptp_ocp *bp)
> > > >   {
> > > > +	struct device *dev, *port_dev;
> > > > +	struct uart_8250_port *port;
> > > >   	struct pps_device *pps;
> > > >   	char buf[32];
> > > > +	dev = &bp->pdev->dev;
> > > > +
> > > >   	if (bp->gnss_port.line != -1) {
> > > > +		port = serial8250_get_port(bp->gnss_port.line);
> > > > +		port_dev = (struct device *)port->port.port_dev;
> > 
> > That cast is not going to go well.  How do you know this is always
> > true?
> 
> AFAIU, port_dev starts with struct dev always. That's why it's safe.
> 
> > 
> > What was the original code attempting to do?  It feels like that was
> > wrong to start with if merely moving things around the device tree
> > caused anything to break here.  That is not how the driver core is
> > supposed to be used at all.
> > 
> 
> We just want to have a symlink with meaningful name to real tty device,
> exposed by PCIe device. We provide up to 4 serial ports - GNSS, GNSS2,
> MAC and NMEA, to user space and we don't want user space to guess which
> one is which. We do have user space application which relies on symlinks
> to discover features.

Just use the normal serial topology please.

And for your named devices, use the symlinks in /dev/serial/ that are
provided for you already.

> We don't use device tree because it's PCIe device with pre-defined
> functions, so I don't see any other way to get this info and properly
> create symlinks.

Sorry, I didn't mean "dt", I mean /sys/devices/, there should not be
anything "special" about this driver that requires custom symlinks in
sysfs.  That's for userspace to create in /dev/serial/ as it does today.
Please just remove all of this, as it's not a good idea at all.

thanks,

greg k-h

