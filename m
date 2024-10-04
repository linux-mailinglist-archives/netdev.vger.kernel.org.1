Return-Path: <netdev+bounces-132232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D59910C3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC302841D2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83291231CBB;
	Fri,  4 Oct 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tMfovk4o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8C1E51D;
	Fri,  4 Oct 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074627; cv=none; b=nlsmvB4UemQMYeK2e3EN2Jy5HY1JuwV5KZnGZH8P/VVk2kzJeq520FcHnZ26s1roYzOQVj9ssHVsBN7disshAEDOEjpLhLe8lbsP8/wCXLsoJdI80itEiQG0pvSXCsHkFlmEsQJJ0QQzUoISpy3qbODqbv0C2CNFAqxO31//WO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074627; c=relaxed/simple;
	bh=BpFqTNGy/c/14vgtgcDPG9JOB1qDqSIziWAtaMlZWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC7dCo0AJ8Sqis+7J8fCQY67JZ6jroVkAeRMcnu8vGtjf3WLJkoX0BGajWXhNbUwyBjhsQXrpzbWrHIJqu6BapPZSLuybdk1eP37mnzd8uRmnuZssIwXkPkfcXXSxt1vQ2jYLD/bGJA/A3PUFtGGsETxHKrHrcxui0BjdC9KSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tMfovk4o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AbUN7Y6Wm090VHfzdRRBj3YSQn2/kybqtzK+wpXzXjA=; b=tMfovk4o/cYNJzHNzW3ErM4tvG
	Yo4T91T2jv0py0jhPAMUnPn4UnFUzu2DGtB+UN7GmrCBuYVqUrRmRrutarodBcLEsvgzEfMsZWtPC
	FHQQB8hBOgOU1DGm+0q1Meuvu/oLrF7gYz+3NlghQV9ZYuSDLXsmzXbsCt5gmaq28ht8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swp9E-0095kI-3C; Fri, 04 Oct 2024 22:43:36 +0200
Date: Fri, 4 Oct 2024 22:43:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: phy: microchip_t1: SQI support for
 LAN887x
Message-ID: <cc5eec63-54ae-4789-b9b9-21024d0ecd91@lunn.ch>
References: <20241003162118.232123-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003162118.232123-1-tarun.alle@microchip.com>

On Thu, Oct 03, 2024 at 09:51:18PM +0530, Tarun Alle wrote:
> From: Tarun Alle <Tarun.Alle@microchip.com>
> 
> Add support for measuring Signal Quality Index for LAN887x T1 PHY.
> Signal Quality Index (SQI) is measure of Link Channel Quality from
> 0 to 7, with 7 as the best. By default, a link loss event shall
> indicate an SQI of 0.
> 
> Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

