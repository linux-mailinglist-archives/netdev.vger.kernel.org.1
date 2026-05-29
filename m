Return-Path: <netdev+bounces-293149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKgGH4moGWruyAgAu9opvQ
	(envelope-from <netdev+bounces-293149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A8604039
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0943078F6D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874833EB81C;
	Fri, 29 May 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h/aTaK3K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370473DD50F;
	Fri, 29 May 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065544; cv=none; b=bM2RnaEHivB1u8tNMtX4V6MTyhi63NYN/MFWuOw+cw9hJb3oF9vEYf26yF0IT0vCvNAqVUEM4nS8/KNdfhvH15LZErGqViJOEcBfv1jlYYZu2r7aS73bYFBmgA9Kn3COsFLpHPzGE+zwXP01yD+5F5GUT8JG09VjsenQWwfIBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065544; c=relaxed/simple;
	bh=6At2CY0yjcocOFYPs+oOt8u8JYZk1aiWw1m2b5h2XGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My9L+dFcDDXEXl65cD/RbIEHKreUPDKSpeBCjxJRbVdsRB72uNDKiO9VzxLx0CMt8uhzvARo+xekoxKkCTxWUGjhV+djPRCYx+x6HHxNKHk8LxLCz9VHDQw2B4+a4u8UdZturtOf2coGLuem6bY/XR+FfhkuA4dLFjU/82NfY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h/aTaK3K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TqJWMm9QvXhkJuSxo0yc7jo+D1QJaDAYTrixupcHnUw=; b=h/
	aTaK3KtsNdPQztqejr5pztvR+mtfle6vG7Lo36Ogolkve8VVxkEteZPEciPjgIzQK0e6ihaLEM+8r
	IVG9WTRgLZX7jYB8Of2N15XqK9Im1oHSgbwb9JWaYC7QEsNAkQfk8Sqhhk1xntYuDSXUAgfH22DzH
	28XFT/ElQhUCwDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSyMH-0056Uq-8s; Fri, 29 May 2026 16:38:45 +0200
Date: Fri, 29 May 2026 16:38:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Luke Howard <lukeh@padl.com>, cedric.jehasse@luminex.be,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <921845db-734b-4241-9c87-9f035bcb6bb2@lunn.ch>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
 <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
 <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
 <793226E0-82B1-464E-9A18-969F773B70D4@padl.com>
 <6040cfca-0af7-41cf-b7d0-00bd8be837bb@lunn.ch>
 <rqvaiyu7qm2il4vhdhgwschodlw77fqd6hiszuwmffjvdthtkc@do7mmsdz77qf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rqvaiyu7qm2il4vhdhgwschodlw77fqd6hiszuwmffjvdthtkc@do7mmsdz77qf>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293149-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[padl.com,luminex.be,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: C28A8604039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 04:32:15PM +0200, Cedric Jehasse wrote:
> On Fri, May 29, 2026 at 03:28:56PM +0200, Andrew Lunn wrote:
> > > > That's not the same logic.
> > > > If one of the two function pointer is NULL, the other can still be executed
> > > > (Maybe not that likely as that's probably a mistake in the driver)
> > > 
> > > True, but agree also that it shouldn’t happen (would be a driver bug).
> > 
> > However, a kernel splat because you have jumped through a NULL pointer
> > makes a good bug report. It is much more obvious what is wrong than a
> > report that somebody tried to configure TC, but nothing appeared to
> > happen.
> >
> 
> Removing !avb_ops->port_qav_write || !ops->port_set_scheduling_mode won't make
> it jump to a NULL pointer. mv88e6xxx_port_qav_write and
> mv88e6xxx_port_set_scheduling_mode will still return -EOPNOTSUPP.
> Do you prefer removing the NULL pointer checks in those functions?

No, leave them. Its just people have an aversion to kernel splats, but
they can actually be useful if they highlight a bug.

     Andrew

