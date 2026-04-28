Return-Path: <netdev+bounces-282042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D+PJWD+8GnubgEAu9opvQ
	(envelope-from <netdev+bounces-282042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7AD48AB91
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC92F301A2E1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90F466B70;
	Tue, 28 Apr 2026 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FDPnQiqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB43C9EF6;
	Tue, 28 Apr 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399846; cv=none; b=JHgschIr4BSWacCnipjLlz/3m24FgHsrubtfk+vVb7HF7XEeCz/+BIPK38FUaOTk5l0pFYZ0ufJ/2NTRrbXghVhjZMJM/hhehHZ8MSUVoG+TWkE84Hdtlc8rhU0FAX7gza+b25+zY0U0LfWufttG+zcLGZjxTiocNTF/y5GEYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399846; c=relaxed/simple;
	bh=uPIvzTXGP1xuIWu52yMnQ/vaSXy8yZGCapJP1eXUtd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzKNNW2D41GnHlZyqb/Y1Rq3IqdOUjWCCEFEV6Hh2E5qNdYdg0X++Lmrv6QmOkkOwlse26caHw7lkiO1UNwIuohtEj0oIzIJaNEuy47KN8/zqvTPkj+15nr2spS5u5oaws/vTyiWlrRCgIiPkeH5ZWjHt1CiRcXUBJ5/xgIYabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDPnQiqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B3EC2BCAF;
	Tue, 28 Apr 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777399845;
	bh=uPIvzTXGP1xuIWu52yMnQ/vaSXy8yZGCapJP1eXUtd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDPnQiqx7KPAM/ifS5aV5e81A/8SHkMkVLn6GYTh7iYTy/EXGRA3+jElU+7MSC68q
	 yc8XY43JUyD5E81i+lfNbRUIS8LzdCPvnor0bZJ3HibYH/lIOuKGW5QaE7sgOsm99M
	 /QI5l2pbglsg79VgYq1MGmQ7QUt0ATQjx/yL9mes=
Date: Tue, 28 Apr 2026 12:10:08 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <2026042854-reburial-extinct-e16d@gregkh>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <2026042848-cubical-penalize-807c@gregkh>
 <20260428120314.GR557136@black.igk.intel.com>
 <2026042802-bobsled-envy-8e56@gregkh>
 <20260428141148.GS557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428141148.GS557136@black.igk.intel.com>
X-Rspamd-Queue-Id: AD7AD48AB91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282042-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.847];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 04:11:48PM +0200, Mika Westerberg wrote:
> On Tue, Apr 28, 2026 at 07:54:51AM -0600, Greg KH wrote:
> > On Tue, Apr 28, 2026 at 02:03:14PM +0200, Mika Westerberg wrote:
> > > On Tue, Apr 28, 2026 at 05:57:37AM -0600, Greg KH wrote:
> > > > On Tue, Apr 28, 2026 at 09:22:09AM +0200, Mika Westerberg wrote:
> > > > > Introduce USB4STREAM protocol and Linux implementation. This allows two
> > > > > (or more) hosts to transfer data directly over Thunderbolt/USB4 cable
> > > > > through a character device without need to go through the network stack.
> > > > > 
> > > > > Any application that supports read(2) and write(2) in some form should
> > > > > be able to use the device without changes. The data is sent out to the
> > > > > other side over a tunnel inside Thunderbolt/USB4 fabric. The character
> > > > > device is called /dev/tbstreamX where X is the minor number starting
> > > > > from 0.
> > > > > 
> > > > > All stream devices need to be configured first. This is done through
> > > > > ConfigFS interface. There can be multiple streams at the same time (this
> > > > > depends on number of DMA rings and available HopIDs) and a single stream
> > > > > supports traffic in both directions. For example there could be an
> > > > > application that uses one stream as control channel and another one as
> > > > > bi-directional data channel.
> > > > > 
> > > > > A real use-case for this is to take a backup as a part of recovery
> > > > > initramfs tooling (no need to setup networking or have ssh or similar
> > > > > tooling as part of the initramfs). Say we want to backup the disk of
> > > > > host1 to host2. First Thunderbolt/USB4 cable is connected between the
> > > > > hosts (there can be devices in the middle too) then the receiving side
> > > > > configures the stream:
> > > > > 
> > > > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0
> > > > >   host2 # mkdir /sys/kernel/config/thunderbolt/stream/0-1.0/backup
> > > > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/in_hopid
> > > > >   host2 # echo -1 > /sys/kernel/config/thunderbolt/stream/0-1.0/backup/out_hopid
> > > > > 
> > > > > We use automatic HopID allocation (writing -1 to HopIDs) for simplicity.
> > > > > >From this point forward the /dev/tbstream0 can be used pretty much as
> > > > > regular file:
> > > > > 
> > > > >   host2 # dd if=/dev/tbstream0 of=/tmp/host1.nvme0n1.backup-$(date +%F) bs=256k
> > > > > 
> > > > > The host that is being backed up then configures the stream accordingly:
> > > > > 
> > > > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0
> > > > >   host1 # mkdir /sys/kernel/config/thunderbolt/stream/0-503.0/backup
> > > > > 
> > > > > Here we take advantage of the fact that host2 also announces the active
> > > > > streams through XDomain properties so the name "backup" gives us the
> > > > > HopIDs. It is also possible to configure them manually in the same way
> > > > > we did for host2.
> > > > > 
> > > > > Then it is just a matter of copying the data over:
> > > > > 
> > > > >   host1 # dd if=/dev/nvme0n1 of=/dev/tbstream0 bs=256k
> > > > > 
> > > > > Similarly it is possible to transfer parts of the filesystem. For
> > > > > example copy contents of mydir over to the host2:
> > > > > 
> > > > >   host2 # gunzip < /dev/tbstream0 | tar xf -
> > > > >   host1 # tar cf - mydir | gzip > /dev/tbstream0
> > > > > 
> > > > > Other end of the spectrum use-case is "borrowing" laptop (host1) camera
> > > > > to desktop (host2):
> > > > > 
> > > > >   host2 # gst-launch-1.0 filesrc location=/dev/tbstream0 ! jpegdec ! videoconvert ! \
> > > > >                          autovideosink
> > > > > 
> > > > >   host1 # gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw,width=1920,height=1080 ! \
> > > > >                          jpegenc quality=90 ! filesink location=/dev/tbstream0
> > > > > 
> > > > > Once the streams are no longer needed they can be removed:
> > > > > 
> > > > >   host1 # cd /sys/kernel/config/thunderbolt/stream/
> > > > >   host1 # rmdir -p 0-503.0/backup
> > > > > 
> > > > >   host2 # cd /sys/kernel/config/thunderbolt/stream
> > > > >   host2 # rmdir -p 0-1.0/backup
> > > > 
> > > > Very cool, but shouldn't the above be in some documentation somewhere so
> > > > that people know how to use it?
> > > 
> > > Sure, I can add it part of the Documentation/admin-guide/thunderbolt.rs for
> > > example.
> > > 
> > > > And why do you need a whole major for this, why not just use a misc
> > > > device that it dynamically created for every new dev?
> > > 
> > > We do use this:
> > > 
> > >        ret = alloc_chrdev_region(&tbstream_devt, 0, TBSTREAM_DEV_MINORS,
> > >                                   "tbstream");
> > > 
> > > that should be dynamically allocated, no?
> > 
> > Yes, but you are using up a whole major number for this, and in reality
> > there's only going to be 1-2, maybe 4, different devices needed at once,
> > right?  So just use the miscdev interface instead?
> 
> There could be 11 per host controller in Intel hardware (we have 12 DMA
> rings, one of which is reserved for control traffic), and we have 2 host
> conrollers in recent systems. Due to the dedicated flow control we use now
> that's not possible but we are planning to make it to use shared flow
> control instead which allows more.
> 
> Not sure if anybody ever will create that many, though.

Yeah, that's not many, and a bit of a waste of a full major number.

> Second thing is that we use cdev_device_add() to manage the char device and
> the stream device as they are part of the same structure. I don't think
> that can be done with miscdevice.

Not yet, but see the patches on the list for how to do that properly.
You will have issues with disconnect/open/close that you need to handle
very carefully, especially as you are a dynamic device.  See this
thread:
	https://lore.kernel.org/r/20260427134659.95181-1-tzungbi@kernel.org

thanks,

greg k-h

