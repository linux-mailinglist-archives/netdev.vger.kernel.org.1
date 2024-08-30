Return-Path: <netdev+bounces-123851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5E966AC1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61401F234DD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344E1BDAA8;
	Fri, 30 Aug 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pcNSW/bU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AD6026A;
	Fri, 30 Aug 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050276; cv=none; b=L21klzhwhjTKCKzdSiNDmiN15hsjl/Ja4UvOG5jN4m0/N+zVm7dm4qcJcVAIQX/fyKN27Zrux7OqTqlPDs9svyaLAZ6yD3k8dBv5d/nAQrYK/nt2jjLjr2cnDvgsx8HIQ2n8gVZSNiKrzkntRsbD2t7XjLIBPJWP4TXtS/ntcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050276; c=relaxed/simple;
	bh=ezl1IoVRKWzsp4pTDRmeO434a3tD5Tz5LMAhKhLI6Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9A9W+eZgF67Qq0GEFh4kqlkMpTaAGVRMzN5jCk1LNxBWn2zcZxOzunlWD0eZszW5UKo4691ZiTP+U07lgCSK01fFYtzh30gpm+TIzjLJi2jUBfQzFLq55b2x0yNFA+YMhQbY8cVn2k3nD+3jWpQqijyqgFitEhS7AQ9DH78qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pcNSW/bU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S3as/TbL7oCPIyfayJUlYsN7QNULpTuaU7qxLfDmGs4=; b=pcNSW/bUX/fNOHF/KqNrBHAemX
	hoTNxogtdVA8NEpXdM3Sr0km93zCrgl9L5fpysKgAln6OphdwYDODJ0/P/21rLE8fJRbEzUuCC67z
	kkPWQdMz+JoYoOcwTJU2y+HDzr8Xufo4rG1W9lcuH4nYwAJK7fmluzSh/vCUPb141JOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8NL-006A8v-8N; Fri, 30 Aug 2024 22:37:43 +0200
Date: Fri, 30 Aug 2024 22:37:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, Bryan.Whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V4 1/5] net: phylink: Add
 phylink_set_fixed_link() to configure fixed link state in phylink
Message-ID: <02820cac-6020-48c4-bddf-745ca5586f0a@lunn.ch>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
 <20240829055132.79638-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829055132.79638-2-Raju.Lakkaraju@microchip.com>

On Thu, Aug 29, 2024 at 11:21:28AM +0530, Raju Lakkaraju wrote:
> From: Russell King <linux@armlinux.org.uk>
> 
> The function allows for the configuration of a fixed link state for a given
> phylink instance. This addition is particularly useful for network devices that
> operate with a fixed link configuration, where the link parameters do not change
> dynamically. By using `phylink_set_fixed_link()`, drivers can easily set up
> the fixed link state during initialization or configuration changes.
> 
> Signed-off-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

