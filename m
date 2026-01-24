Return-Path: <netdev+bounces-253091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF1zENARdWnUAQEAu9opvQ
	(envelope-from <netdev+bounces-253091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:39:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4307E7E7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCAA33011135
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70420B7ED;
	Sat, 24 Jan 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R0j8q10y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E73EBF12;
	Sat, 24 Jan 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769279948; cv=none; b=PqplnllRNRG6gKMXWkVU3TQm5ByeRq0Qpd8f8ROip1HP0lkm+RUgOeTxu4qxN1vqc2nu0k4piGuuIgg23AiprU+r++/YpgY4gEpje7ZweGQForuJ/LoUJqXYBrCBY7TgBt/cp6eH2aUlM9VH4142cYKAUOtZTSpDtpWA37sI8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769279948; c=relaxed/simple;
	bh=7huXFNPGwXGGEVNTyhKd7aQRYyI9bhCgUp5ybXGmMNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzqUE5m5/MJ/20pRuFYeUAuAggUQyNiXQiroa/fDK5g+EONeR2w8ipI8E/vho7BBYMDtYAYlYvFrTpHydGCy/M8mfKshP9EMhM4XlPbzuhtvyYltvXQtb0ublAwrPINKGc3dDT1woRd9ngx1tjMncUsWhyS6QkFXAQ3fHkEVZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R0j8q10y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Nr2k/EZEvxbh1CPsLcorQXpA5oe65WwTQZxlQjOHphU=; b=R0
	j8q10yWUsbCIjGFmXfqDIha2P/SAOTNPmhH+8U2ZfSU/JN+VzJHIzCOJR2m1bqtjK0hYrWzVtepbe
	t9uVH4ASv/0q7Ajr3rEx+2+zWgcXlisbnaSKP0dpPpRUIW1qpg1jk3ZP6Sc4a/4EZGIhNBqaz+2sE
	90dlAYotHBfweEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjiX7-004V5z-Li; Sat, 24 Jan 2026 19:38:53 +0100
Date: Sat, 24 Jan 2026 19:38:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out
 shareable code
Message-ID: <af7daf2e-7a8a-4a83-902a-28c9375daea3@lunn.ch>
References: <20260123075817.1162068-1-bjorn@mork.no>
 <20260123075817.1162068-2-bjorn@mork.no>
 <9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch>
 <87a4y3j6hi.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4y3j6hi.fsf@miraculix.mork.no>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A4307E7E7
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 05:55:05PM +0100, Bjørn Mork wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> -static int en8811h_read_status(struct phy_device *phydev)
> >> +static int en8811h_get_lpa(struct phy_device *phydev)
> >>  {
> >> -	struct en8811h_priv *priv = phydev->priv;
> >> -	u32 pbus_value;
> >> -	int ret, val;
> >> +	int ret;
> >>  
> >>  	ret = genphy_update_link(phydev);
> >>  	if (ret)
> >
> > This call to genphy_update_link() means this function is doing more
> > than en8811h_get_lpa() would imply.
> >
> > It is hard to see from just the patch, but it also seems to set the
> > state in phydev back to unknown defaults, and read the master/slave
> > status?
> >
> > So i think it needs a better name.
> 
> Yes, that was my feeling too. Just couldn't think of any.  So I took the
> lazy route.  You wouldn't happen to have a suggestion?

Maybe a different strategy. Most of read_status is generic, it appears
just reading lpa is specific to the device. So have a generic
read_status() function, and then use phy_id_compare() to call the
needed device specific function.

       Andrew

