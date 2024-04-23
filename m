Return-Path: <netdev+bounces-90675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A548AF7A0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868681C2268C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300881411F4;
	Tue, 23 Apr 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz3kFoAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7881411F3
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901980; cv=none; b=UTvUzqaqZOuAEWCX7d141xIeGeS+RWybvXtrBmgbaPVPNg8sIyKytxKa7eQxdPnJysYoh0WLj6bTSeoD+Xs14UFuo7n4bxibdwnBLl8ZhVlboYHoBhozCYHdaaNgsmKHc49lCX4LBvTev0nAdk2STLj5V1k3gzchv5bu5wp9nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901980; c=relaxed/simple;
	bh=0u5P1AEa6EpO/KPyG/AA96BerwGzkXfXipd7DqevwJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZXfhi2xneqX4QcHbIFi2laRfyqg00ZpjRtGBcg5Ysa95qotKlzX9oaiyhUmQCBxjjHPqfkp3YFzNORAtcJxc8OuNt6E02HM4GjVOUr254SKPDkmY0A32JSnSfBsl6++FtankSUOUOq6NqHjKOs/w3QWKSwH/spmQsZJ6/0EnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz3kFoAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8930DC116B1;
	Tue, 23 Apr 2024 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713901979;
	bh=0u5P1AEa6EpO/KPyG/AA96BerwGzkXfXipd7DqevwJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wz3kFoAtPgYpc+HlC1h3MvwZwTNhmbqjA1PNKW4ME5yfmVMJZoB0VjX9dffBg41Yw
	 TEhc1f/Qmf1JZwm3pVaGfyPOf6ED1xZxQpUpGRy+rlWhin9fXwTk1pq+j6umS8rCI/
	 GPNUT35o8293s5NMmCk+BJOeCxL2Ry+35S4ZpHWxRXJUH/Gi99hRHFhm/n4+Ks1VMp
	 U8dpBKSVefRASGIMnPKGE8N/PCbzYnnn0uipU2xP1fy6hDvMUX1Zq4Q0+8Rg2Kf+EH
	 0BBZ3vDGoTTcJQGz5IuNRvQEvDaq+JYcTXabtK5RZxrjDsRjwCxUkfR0tLunThuClq
	 rCCfo5LClAg9g==
Date: Tue, 23 Apr 2024 20:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <20240423195254.GA42092@kernel.org>
References: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>
 <d667834a-476b-4f33-9c94-10b3672b6edb@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d667834a-476b-4f33-9c94-10b3672b6edb@moroto.mountain>

On Mon, Apr 22, 2024 at 01:40:01PM +0300, Dan Carpenter wrote:
> On Fri, Apr 19, 2024 at 01:17:48PM +0100, Simon Horman wrote:
> > Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> > busses") mv88e6xxx_default_mdio_bus() has checked that the
> > return value of list_first_entry() is non-NULL. This appears to be
> > intended to guard against the list chip->mdios being empty.
> > However, it is not the correct check as the implementation of
> > list_first_entry is not designed to return NULL for empty lists.
> > 
> > Instead check directly if the list is empty.
> > 
> > Flagged by Smatch
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> > I'm unsure if this should be considered a fix: it's been around since
> > v4.11 and the patch is dated January 2017. Perhaps an empty list simply
> > cannot occur. If so, the function could be simplified by not checking
> > for an empty list. And, if mdio_bus->bus, then perhaps caller may be
> > simplified not to check for an error condition.
> > 
> > It is because I am unsure that I have marked this as an RFC.
> > 
> > diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> > index e950a634a3c7..a236c9fe6a74 100644
> > --- a/drivers/net/dsa/mv88e6xxx/chip.c
> > +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> > @@ -131,10 +131,11 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
> >  {
> >  	struct mv88e6xxx_mdio_bus *mdio_bus;
> > 
> > +	if (list_empty(&chip->mdios))
> > +		return NULL;
> > +
> >  	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
> >  				    list);
> > -	if (!mdio_bus)
> > -		return NULL;
> 
> The other option here would have been to use list_first_entry_or_null().

Thanks, I guess that is nicer than the open-coded approach I suggested.


