Return-Path: <netdev+bounces-116898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62794C029
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E1D1F2AA88
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2918F2D0;
	Thu,  8 Aug 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="glczqEpj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6218EFE8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128250; cv=none; b=JQoigE8G66viQhzdvuSmsbSUXH/SJ2xAfXSEDDYCYrdNGYjk9/lcLzwq8ctkha6VTIRtGRix3whlWPDBxntFMO6zqd7f3is2r7Fv1ynTh4gv9HahctGnSBBx5NZmPkU6x+Ee/r/avaXXAroRb+AiHaoDyaRUijACkp/Wu0jHyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128250; c=relaxed/simple;
	bh=FEylQA1eODzZItXhZkn2pihOoNqcDXko092xFBY12Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVvJkgRlED70CmRLVLMqaIih1KsSpt2LZZ+eSXMArCI51D4VonIrhPcZv7WDcJwd0CK+r8st/72Cyve6YofJ9SSKXt9Fbm2bL6MCi/q3UxUGxX3KDMzNkcx9fMPq7+76TugQZ7V1F0LsdOM1LK8qwxCgVNRuNeXA6tlAOXJCz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=glczqEpj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kiODRjD2Kxwqjr0wnS2/ta255IkVg5IGiISFP21/lVE=; b=glczqEpjFkxYYYmX5fBlw040S/
	jqBgbUX50hux9dW/rUzlCnF5A2jRH4ykg4Esw+0fOvEZe518pCNByjx7faDV8Ekm4Jil1xeZJhkRT
	g8PYIEzH1O1L43fZBTro3G8OQVx0KMcqGFuhInnsSDruqcXcUPkycxlSrtcEJnFZ4C7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc4N4-004ITC-MJ; Thu, 08 Aug 2024 16:44:06 +0200
Date: Thu, 8 Aug 2024 16:44:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ag71xx: use phylink_mii_ioctl
Message-ID: <229aa2d4-890f-488f-8054-4927f7e77257@lunn.ch>
References: <20240807215834.33980-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807215834.33980-1-rosenp@gmail.com>

On Wed, Aug 07, 2024 at 02:58:27PM -0700, Rosen Penev wrote:
> f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
> ndo_eth_ioctl and used the standard phy_do_ioctl which calls
> phy_mii_ioctl. However since then, this driver was ported to phylink
> where it makes more sense to call phylink_mii_ioctl.
> 
> Bring back custom function that calls phylink_mii_ioctl.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

In future, please use ./scripts/get_maintainer.pl to determine who to
Cc: the patch to.

    Andrew

