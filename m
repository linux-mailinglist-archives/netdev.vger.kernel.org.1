Return-Path: <netdev+bounces-154636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66069FEFCE
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC855161EF4
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2E19CC1F;
	Tue, 31 Dec 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rChqezVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D05789D;
	Tue, 31 Dec 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735652136; cv=none; b=qtPc6Oyb5zRg7X7iHCyjpsuX724Sm+F6zm9LCoOKlliqfXn3Gbo/p/PDdb1jq1+dZkjH/g0awwfaDPKHkypbhZcuuel9uXP6o4shseE9mufUloLSHUAxXlxGLiFX13vaF2ceZFglkP+zVy6u2GUXzL1QxHtQIekUHxYK68KFlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735652136; c=relaxed/simple;
	bh=VOVughPCfOBry+Q7AArs348w5Cwi0dur4jcvglLPagI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAQmnDD7FYs7MqcDAVOkVVQGeKCJm+2rWoIYNrik4ZizPJW67PZpPn8A+jenfXQTwnEAaU9MzoL1tgWpLT5/VVdVnIFMi6mweKrTEyVF4Q40qFh0wrG/Hw41P0EJfS05xMUFEeraf+XMoCXIr29OdIZqGaM3qv1pf0HZpx5HTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rChqezVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2201C4CED2;
	Tue, 31 Dec 2024 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735652136;
	bh=VOVughPCfOBry+Q7AArs348w5Cwi0dur4jcvglLPagI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rChqezVKiSWpiIx7yDFUHseQ49i9T8vy7I7vJNga4Qcc/CYO6I3q0PKBr0uldauaA
	 xBdtTUYThzoOPezoUIdRN64+slFGPNhUVPOPyaLuhuzI/uDucRl8+yOVhyhLDUVguX
	 QTRwI1M23LR1Y8+RjjChVBTEuidvM4uY13j2UaxrWJ09TBOFF04HVgfgqfTw//KfdM
	 A9KIucyUZdsrZeA0c7DuE/Q5c1sWZ5QM9U4reuLSX1dG3RrL4DY65qM9rgYACG1c5G
	 0BC9M3tc38Wspl79cwCl1R9T7eZZujAUcXfnSga6Uq9Bk8jSaBcAZwj9+RsrKWFZeK
	 Ltim9Xfa17jYA==
Date: Tue, 31 Dec 2024 07:35:33 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: ethernet-controller: Add mac
 offset option
Message-ID: <20241231133533.GA50130-robh@kernel.org>
References: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
 <20241220-net-mac-nvmem-offset-v1-1-e9d1da2c1681@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220-net-mac-nvmem-offset-v1-1-e9d1da2c1681@linaro.org>

On Fri, Dec 20, 2024 at 08:17:06PM +0100, Linus Walleij wrote:
> In practice (as found in the OpenWrt project) many devices
> with multiple ethernet interfaces just store a base MAC
> address in NVMEM and increase the lowermost byte with one for
> each interface, so as to occupy less NVMEM.
> 
> Support this with a per-interface offset so we can encode
> this in a predictable way for each interface sharing the
> same NVMEM cell.

This has come up several times before[1][2][3]. Based on those I know 
this is not sufficient with the different variations of how MAC 
addresses are shared. OTOH, I don't think a bunch of properties to deal 
with all the possible transforms works either. It will be one of those 
cases of properties added one-by-one where we end up with something 
poorly designed. I think probably we want to just enumerate different 
schemes and leave it to code to deal with each scheme.

Or we could just say it is the bootloader's problem to figure this out 
and populate the DT using the existing properties for MAC addresses. 
Though bootloaders want to use DT too...

Rob

[1] https://lore.kernel.org/linux-devicetree/20230509143504.30382-4-fr0st61te@gmail.com/
[2] https://lore.kernel.org/linux-devicetree/20211123134425.3875656-1-michael@walle.cc/
[3] https://lore.kernel.org/linux-devicetree/20200919214941.8038-5-ansuelsmth@gmail.com/


