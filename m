Return-Path: <netdev+bounces-304587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HfuNHDPR2qAfgAAu9opvQ
	(envelope-from <netdev+bounces-304587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:04:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AAC703B0E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:04:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=G8mMPqyP;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304587-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA487300DDE8
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CE3D953C;
	Fri,  3 Jul 2026 14:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4537204C3B;
	Fri,  3 Jul 2026 14:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090763; cv=none; b=nIntH8tktBdik3vPl0fLtPtNup3Hd+qBm2ueh1mq/a91FkVkmTatoIbvHnh/gw7/O7d1G0F4m3YpR8PCoD8h71SdHSjH7sPY2WgpUcT0mikr4SHKxprgH+r6VkqQ/Y+v7frGsDXROfhOGfROA5NWSJWp0DBSF+w+LriiOD+0w4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090763; c=relaxed/simple;
	bh=BMEG83xy6oFcTohasSOkt8nfHoEI/v2bH00aywoH5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3rne9ZzdSSC1vNLvTwR94ULrVvtN2Su5MJe4TB88oRnUZzVcc0kQQdEordIAYtw+CxC6haljceY0CA15zdxx5/ZZVUYeWgKVw52x4VNCmVDppCdAkVjDcamZLrJus/rciDE1Z6U+5jLdmjYtJoR1Cfjhh0mNpN4lhY+9ANVQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G8mMPqyP; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2u2+9T4TXUi4ap9zkaJY4zlHGdv4WGPet1SrcguPmO0=; b=G8mMPqyPWF0dDAeH90aZhryXaU
	54doguZf7Eynmc+iZflkVeYphy/Pnf3MyywgRcpat77y+bNHFynzmi5vQlY+paduk1WzvqRJ5qRp9
	VD89JnZCMZpMt9YtDma8//7GEE91RvMbR32IhW8cdhrZuj8RbblSi+71fkjw9CNW0TPs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wffME-00AZ2c-Ms; Fri, 03 Jul 2026 16:59:10 +0200
Date: Fri, 3 Jul 2026 16:59:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shaoxul@foxmail.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: usb: move exported code to usbnet
Message-ID: <6901757d-327a-4676-bd1f-408f76441005@lunn.ch>
References: <20260702143142.890654-1-oneukum@suse.com>
 <ea92d680-39f6-4dde-b558-4008ffbee587@lunn.ch>
 <c3d3c7a0-5d47-4e73-a46b-2fd610f4cd59@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d3c7a0-5d47-4e73-a46b-2fd610f4cd59@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07AAC703B0E

On Fri, Jul 03, 2026 at 12:16:20PM +0200, Oliver Neukum wrote:
> On 02.07.26 20:15, Andrew Lunn wrote:
> > On Thu, Jul 02, 2026 at 04:25:29PM +0200, Oliver Neukum wrote:
> > > Some drivers are reusing common code originating in other drivers.
> > > This means that two drivers need to be loaded for one device.
> > 
> > Maybe consider using 'framework' or 'library', rather than driver,
> > when referring to the shared code?
> > 
> > I tend to think of a driver as the leaf node which probes based on
> > enumeration of a bus. But usbnet.c itself is never probed.
> 
> Yes, I also think of a leaf node when a "driver" is referred to.
> That is the very point. Currently you need _two_ drivers and
> usbnet for some devices.
> Should I reformulate? If so, how exactly?

Maybe give examples? List the two drivers used for one device?
cdc_ether.c is being used both as a driver and a library? The
EXPORT_SYMBOL_GPL() make this clear, a driver would normally not need
exports. The patchset starts to make cdc_ether.c a pure driver, moving
some of the shared code into the usbnet library.

Just to be clear, i think what you are doing is correct, i just had
problems understanding the commit message.

     Andrew


