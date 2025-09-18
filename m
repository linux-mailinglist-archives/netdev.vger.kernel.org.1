Return-Path: <netdev+bounces-224599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F223B86B29
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE26C7C6C86
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6532D640A;
	Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sZoliRZB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546326B74A
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224053; cv=none; b=BglyWlQn7L5vwcrTTDoLICgMa/QysgjKDBX6K63+dtj7AWB68p/WHxN/hjb6zd3KA7vDMFTtbHdjrmC64SJYS56aWo/3w23KzT1LCR955xr+5gNarJOKM5lCm5XfBT+Bx9DhVnp4sDa2htYsSner0nIIjtG2fRuNqCqL3/ZD2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224053; c=relaxed/simple;
	bh=GdlgwqMGHAkqFM4s3sgrWCC1UZEL1jLlf1IDKSom7/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McZSToBQ+C0PLtVonF3ql+nKR56xnJu1fZmx9ENFySXrkcDRfav8QRDL6n6AcbxDKJkVJ0eESWxeCbScGSeoiAFL0hMnGahCggs0TA/qPvv29MwH6XbgIia0Yy8cE3sQVfEAk+1rhMUmHqPupxv9OWjH1sQKWybI9zdkFzOExBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sZoliRZB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+blSQ3udHbrBwj5PqMH0rUrFZg2Jh4P15llci0SunOo=; b=sZoliRZBx4GSzmRtzekulSFA2/
	3zIc3FUGV29wpZv9lz0vKM0A94ik1o4EkWpFt/s0vTYdt0Gj+IJwGQZ51Ab+kqifs83Rq40PLi2gf
	Sk8lHJVliyxu9MNOd4G6kWjJyru2/YL5vntuWnu1m3QxOV4L/XFU1uvyOzoZJ0f9YvuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzKOM-008s1D-Hb; Thu, 18 Sep 2025 21:34:06 +0200
Date: Thu, 18 Sep 2025 21:34:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	richardcochran@gmail.com
Subject: Re: [PATCH net-next] net: phy: micrel: use %pe in print format
Message-ID: <47644026-ef7c-490e-be85-07a4063c846b@lunn.ch>
References: <20250918183119.2396019-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918183119.2396019-1-kuba@kernel.org>

On Thu, Sep 18, 2025 at 11:31:19AM -0700, Jakub Kicinski wrote:
> New cocci check complains:
> 
>   drivers/net/phy/micrel.c:4308:6-13: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/net/phy/micrel.c:5742:6-13: WARNING: Consider using %pe to print PTR_ERR()
> 
> Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

