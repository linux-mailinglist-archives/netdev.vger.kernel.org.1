Return-Path: <netdev+bounces-268729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGoDChSwuWkkMQIAu9opvQ
	(envelope-from <netdev+bounces-268729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:48:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB552B1B99
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E04D309346F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED2224B12;
	Tue, 17 Mar 2026 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pj1Q9f9w"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E02E63C
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776860; cv=none; b=G7xL6kP5t4EnXtxkNH974+qZTX9saN3BBct2kDSKZEgh4u7Jugva9AaOyh/PUg8QrElrqFQOlR4eqAHw3s53AwghIXq1w/c7uX8VuEG8M53y/B3ZPr0Uq0O/X/biYcngUFcSEzQATXUQm5fG9OKf+p3Snmx75rV+t56sN+39BLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776860; c=relaxed/simple;
	bh=xYv0xqs3+9USAFVei455S/EcEP+wqvEeUil/BTOu1Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLQYjoch0Nw4jwcNsb9Y3hw41mbLt+/GzFd2zNqvxiR9u4uVeen9MMOkdYrCUc+WSGint+3OEC2NbF1FI4GnNFBr2MrO/dDLJQzlLLnHGG06zauH7bCRXFpw3Ava1qa1lKOa+Cx2wuW6E34Dk2ZQOk8R83zWJAafI0FOgUD7Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pj1Q9f9w; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9EMEp5pXTyokoyVdYIERbnTmtWSEqXwvJeKfT+BSW0=; b=pj1Q9f9w6uNj5xWSeV+WXMo3z/
	XzUQd1E/FMAt0Y7sVSJ8LXWlaSDN5uCsivWFCeRNn9trGX1a0VXYn7BdNUWPLYv50hXeuET2Iw4a0
	Du1khXw/r8W3Rn1bD4I1Q9IKKcgURvpYhg2vO5Fv0Ty2Jvt481pOhiyC8obTDlO3fWm0K71SwQBwz
	p8pw/4z6FzpkXD9Prom++HsNWHiRdW5BMb39y7rtv71ahWZvLB5wAgjbFJ31TVq626dsrVlg9Cf01
	+H0XDvGT2hdFM2/4uRpOvt1C1B8GdXTCf42ebGQFbQoolhGWuJrqMVQZqULzqiTr6g+SaH7uC9+/s
	A3xY8t8A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2aO4-0037SO-GE; Tue, 17 Mar 2026 19:47:31 +0000
Date: Tue, 17 Mar 2026 12:47:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Message-ID: <abmvax5GU9KdFBli@gmail.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <abmtcI4NX_zFyAwA@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abmtcI4NX_zFyAwA@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAB552B1B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:42:04PM -0700, Breno Leitao wrote:
> On Mon, Mar 16, 2026 at 10:27:20AM +0100, Nicolai Buchwitz wrote:
> > macb_change_mtu() currently returns -EBUSY if the interface is running,
> > requiring users to bring the interface down before changing the MTU. This
> > is unnecessarily restrictive.
> > 
> > Instead, close and reopen the interface around the MTU change so that RX
> > DMA buffers are reallocated for the new MTU. This is the same approach
> > used by many other network drivers (e.g. igb, tg3, stmmac).
> > 
> > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> > ---
> >  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index 5e27e0e87a55..8dd01031250d 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
> >  
> >  static int macb_change_mtu(struct net_device *dev, int new_mtu)
> >  {
> > -	if (netif_running(dev))
> > -		return -EBUSY;
> > +	bool was_running = netif_running(dev);
> > +
> > +	if (was_running)
> > +		macb_close(dev);
> >  
> >  	WRITE_ONCE(dev->mtu, new_mtu);
> >  
> > +	if (was_running)
> > +		return macb_open(dev);
> 
> Would you like to keep the new_mtu set, even if macb_open() fails?

Looking a bit further, I found that macb_set_ringparam() doesn't return
failure if macb_open() fails. Should it be fixed also?

Should we have something similar to your code above?

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd2..3c43fc85af79d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3516,7 +3516,7 @@ static int macb_set_ringparam(struct net_device *netdev,
        bp->tx_ring_size = new_tx_size;

        if (reset)
-               macb_open(bp->dev);
+               return macb_open(bp->dev);

        return 0;
 }


