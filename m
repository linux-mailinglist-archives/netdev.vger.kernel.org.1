Return-Path: <netdev+bounces-155010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C3A00A41
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7170F3A04BC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FA14D2BD;
	Fri,  3 Jan 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="clgTguvx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BE17FE;
	Fri,  3 Jan 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913157; cv=none; b=rbG769nagEGXpT7+/H5PVMzfcIvpBTPtzWAQlNsx2arZwcyNvgpk7WNwzAUxB29ZeEGDFygZgCNKXuYJ5VcsHPchw4PBh2bvukW15HFMlTu+tecKEUKRtoRTeWlds0ZJZ0nurJLBjYkKhZ3jfTtdFJ8is0Z1N/FSi4ymyeKXzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913157; c=relaxed/simple;
	bh=jl0KcrsyfcWz5AgFrT1zgyErWmIMdw3WpZdyILgO+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prn1QhIFa90B9iZFjBBi5yHarWktauMoHgzWmsFPmK/vMi/5oYD/R15oRDR/Ru+DSPaurP4EVkSIT5ArRNJ/8okipa2LpuL8ogwPJMWu6fFuSwzbe8rL7gW33aqs1D7INfbKXrOr0/0CR0Ik77pXFHnkXnmgMHioIhbQ9zg3YCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=clgTguvx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oyFAdRKi5tZiQLh5G2xVdCYo8pgZnf0uR/7u6F9IOz8=; b=clgTguvxFNPlYwIJiXXNWJAdKh
	47ku75pEK8mofPCPCr1mo+7X8n3nwJC+HMi3BXcGImOGWpJhob9MUsvLEjnNU/o8iHTOPNKP5p4wk
	gp9juT1kbbJU6/5uMvwXMiZRfWWb9um73gft5RXf0FVxkLZSZuzBzKueYq7rnNu1T4Oc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTiIw-0013W4-D7; Fri, 03 Jan 2025 15:05:34 +0100
Date: Fri, 3 Jan 2025 15:05:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 2/3] net: phy: microchip_t1: Enable GPIO pins
 specific to lan887x phy for PEROUT signals
Message-ID: <0c121fff-a990-46e5-b250-8948b717f816@lunn.ch>
References: <20250103090731.1355-1-divya.koppera@microchip.com>
 <20250103090731.1355-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103090731.1355-3-divya.koppera@microchip.com>

On Fri, Jan 03, 2025 at 02:37:30PM +0530, Divya Koppera wrote:
> Adds support for enabling GPIO pins that are required
> to generate periodic output signals on lan887x phy.

Do the GPIO have other functions? Can they be used as additional LEDs?

I'm just thinking about resource allocation...

	Andrew

