Return-Path: <netdev+bounces-204383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC98BAFA38D
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D586A3AC769
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB31DF271;
	Sun,  6 Jul 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wFFIirNL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607381C6FEC;
	Sun,  6 Jul 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751788244; cv=none; b=dPb7Ihb5u1YmKi05DdeHFG+W5dFRL5RiPEshau6l+Ia20XWOkQY9pD91BuqtEh7MRDUtNrIBWEO40rY5vmqjo7sb1IDt/Nvw/LtoQv1y1EoIJHiXaOgrcjOEslFAtAEZGfVHeIKw03nEILmSBcz6mZ2hjG4hbU14XE9NAJ/LnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751788244; c=relaxed/simple;
	bh=Wz3QIftB7ku50zhSA5I8LX3BPYD+n8UHEOY5M4mivbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFDi3trKpYpIaGYkd9lbSIAfk+H3LMoDwhlsoUouIuMhQuMwLEJ9CZnzhUewOLin5OX108n34294NlTimucoF43pM2YlJ8bYF2RA9mDPFOrHik6gSRw1LOVsozQkZBMfcHVs5bHW0fTzHzwIn61vVwyoPfgsu1rjtCw8lVDmCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wFFIirNL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tlI66Bz/sqx9wmUZBx5cdl25FDyXH6zR6tjKJVPWCsg=; b=wFFIirNLE5SoKa0/iKXE1484DW
	r7+gZbf52dzCnHuQfy755y8Q0LISLB/oxnAoxuJ/l6I4++mdjB529Cub/3iLygRFWryyGMtLt0rIr
	sTemlafQ52D04EZIUumCJSSwLUaLw6XexkFuUUbvKJsJXiXTzzMbItrGwT48zkdQOmyU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uYK8s-000X3d-K1; Sun, 06 Jul 2025 09:50:30 +0200
Date: Sun, 6 Jul 2025 09:50:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Message-ID: <0f0ca5ce-8ed2-4e07-a1c3-105d602e8cd1@lunn.ch>
References: <20250628054438.2864220-1-wens@kernel.org>
 <20250705083600.2916bf0c@minigeek.lan>
 <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
 <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
 <20250706002223.128ff760@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706002223.128ff760@minigeek.lan>

On Sun, Jul 06, 2025 at 12:22:23AM +0100, Andre Przywara wrote:
> On Sat, 5 Jul 2025 17:53:17 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> Hi Andrew,
> 
> > > So it's really whatever Allwinner wants to call it. I would rather have
> > > the names follow the datasheet than us making some scheme up.  
> > 
> > Are the datasheets publicly available?
> 
> We collect them in the sunxi wiki (see the links below), but just to
> make sure:

O.K. The point i was trying to make is that some vendors datasheets
are not public, or very restricted, and so names don't matter, since
nobody has the datasheets. But if they are open, names are more
relevant.

I do agree that stuff can be changed when it is in an -rcX
kernel. However, it needs to be well justified, ABI related, or very
broken.

Since this is ABI, it could be changed. But i don't want to make the
decision of if it should be changed.

	Andrew

