Return-Path: <netdev+bounces-250697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21034D38E08
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E755300CB8B
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B33043D5;
	Sat, 17 Jan 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JMeggK56"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EB3128DF;
	Sat, 17 Jan 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768648204; cv=none; b=Qyvnofn90lp/RmSOtQlFCjcr6B91jQmF23t5XcWVHMRdd/VnPwF+17KN41IiajLa3gAXUkTuFj5toPAB9jfiPmysL585MHjqRqRNK0ciIBVwjfl31LmXz3hoEdGm039o395xA3ZUa4Gct1oNXEdvLbdLmqwJ8h3L7aNT6Y3lShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768648204; c=relaxed/simple;
	bh=7poodvKUuzOVou6yy26C68DYDDTn3cRpsimnGL1nDDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2vkfEpIHKDsHKAn31Tq52uenocQu9rbFK6NjFiVRGKml+fLnHQtY8yLA7ovFVHRUBQNXaUmfYUXTvpsY5sIzpFRdQr1zG+PEQx85tNHa7JsLu/mQEwyA9cEtEouaF8p4kwZMNRZzgVrJtbkJO158tjwckyKxFQGLVt1d+Hmt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JMeggK56; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jOPle7CQdmTssFXDdVFhSB4QqaOxmM9CxYXqpbVKQco=; b=JMeggK56xm6oep9ztPotoQPnYu
	ThsH19MPem4x4BSprEfAOw7ogoLTdjB+IXSkIxP0MAYtfINEyat8lqs9U4Ntc++2zi2nvv45s3VsF
	C4HXnUmI1Xl1DeMMD1vaYz2cPeF2Q36J/9UQb722UgKWhOzKpz+8WMo0S6PFcBFX1MKP6PQgM8x4W
	e9IEJDp1AGnchrawCPf2KNgh4niOs9m1kXkevcid9NzkRTRCxKwEaeabDqcZb1ixYx/Chd1QbJSwo
	6lwm9Q523lSsaPLX0oc1/gUAVodsgM9iVw648qg5A7Xv9osyISoUzqYnAU+mducfXoJbcw5zK3kal
	LzpVQG6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49136)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vh4Be-000000003Yr-0IBH;
	Sat, 17 Jan 2026 11:09:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vh4BX-000000004XG-0FzH;
	Sat, 17 Jan 2026 11:09:39 +0000
Date: Sat, 17 Jan 2026 11:09:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v3] net: stmmac: fix transmit queue timed out after
 resume for tso
Message-ID: <aWtt8hlsqWVF1tYz@shell.armlinux.org.uk>
References: <aWrJvrpIAZHQS2uv@shell.armlinux.org.uk>
 <20260117075926.128979-1-tao03.wang@horizon.auto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117075926.128979-1-tao03.wang@horizon.auto>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 17, 2026 at 03:59:22PM +0800, Tao Wang wrote:
> > Rather than using tx_q->tx_skbuff_dma[].last_segment to determine
> > whether the first descriptor entry is the only segment, calculate the
> > number of descriptor entries used. If there is only one descriptor,
> > then the first is also the last, so mark it as such.
> 
> This is a good idea. tx_q->tx_skbuff_dma[].last_segment no longer carries
>  much meaning and can indeed be removed altogether.
> 
> > +       is_last_segment = ((tx_q->cur_tx - first_entry) &
> > +                          (priv->dma_conf.dma_tx_size - 1)) == 1;
> 
> Since tx_q->cur_tx may wrap around and become smaller than first_entry,
> the following statement is more concise:
> is_last_segment = (tx_q->cur_tx == first_entry);

That's incorrect. We advance tx_q->cur_tx by at least one by this
point:

        first_entry = tx_q->cur_tx;

... fill descriptors ...

        /* We've used all descriptors we need for this skb, however,
         * advance cur_tx so that it references a fresh descriptor.
         * ndo_start_xmit will fill this descriptor the next time it's
         * called and stmmac_tx_clean may clean up to this descriptor.
         */
        tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);

...

        /* If we only have one entry used, then the first entry is the last
         * segment.
         */
        is_last_segment = ((tx_q->cur_tx - first_entry) &
                           (priv->dma_conf.dma_tx_size - 1)) == 1;

So, replacing this with a check for tx_q->cur_tx == first_entry
would always be false here, unless we completely filled the ring
with a single TSO.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

