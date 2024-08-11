Return-Path: <netdev+bounces-117502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABE94E22A
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515A42812EC
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18414F9F4;
	Sun, 11 Aug 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lur7aODh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473D14A624
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392697; cv=none; b=miphcoRp1lLl/TMUc6JJzJDDfmB16bnMQcnzt2cA4E7ayC7J0xSNriQ2YUDO/sn98BvLVBGOuGU2N72ib+thSBiXB1AMQogWa9TZjhfz2yABD4y+sawmp5R2+MGe6A+bjo+rtY/po/XNEoClSzB1aD77w+csusc79ByQeUUm8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392697; c=relaxed/simple;
	bh=ENqMDsZJ2LF9PCWUkTfYgRdmqEOfmcPyuAmT6IDmid8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt/6p9de5lE650OodfoAkdvIwYkiG1O1a23imDc5xlPz5v74+SftVB4XaOEWJ1o9ZFNGNHx/snI2IYhvBBFjY0m1CrEGbZ6ANEwiLnlr0kpKGd+ZGrx1jp0mNQFEQABjg2w+5PtH1kjL47XWF6cg9OopVJW5ppLgyHrpSVdmg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lur7aODh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Od3zlEbHgdbfOlNf0rebb4sP85fQG1XfX+jJiTZVv4=; b=lur7aODhIPvHLy/NpmkuQHGZws
	lzYbhCdY5pknGmDNjLW8Q16L8fihTKWKn70kNONXiGvgZf2J2PmVBDefEgaYLbV6dYPczVOMMiGpq
	C2zXRpUKlx9C3eqVQHouAeKqwt427ih3kAVs6166KE/8BrpzgVpIhGNfBjZJBvPacHoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdBAG-004VbD-IH; Sun, 11 Aug 2024 18:11:28 +0200
Date: Sun, 11 Aug 2024 18:11:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: mii: constify advertising mask
Message-ID: <98e93acd-983c-4af1-a928-f02a6d8a9650@lunn.ch>
References: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
 <E1sc1W9-002Fud-23@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sc1W9-002Fud-23@rmk-PC.armlinux.org.uk>

On Thu, Aug 08, 2024 at 12:41:17PM +0100, Russell King (Oracle) wrote:
> Constify the advertising mask to linkmode functions that only read from
> the advertising mask.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

