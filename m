Return-Path: <netdev+bounces-182775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4262A89E45
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCE91900BFE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38392750F2;
	Tue, 15 Apr 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BXjaLMCY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D731F3FE3
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720598; cv=none; b=uurfdycuevNAJPHOPwFG0gnjWJQMjyJ+KOw2fZRNBkxbanrSCkwjN+5yrtH61LtopyIsIfA7BJnyYS4Wdplva8rzAUk5mOVhAP/CHYYAXZLaHUSzM90j5worpOLFJJLqN/4l7NSB6AeqVI39i15wH3AuGE/YMVrHUG7ic0/FisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720598; c=relaxed/simple;
	bh=iPMfXaie4zx6SCwnBGUkkkdz4S+VJc04O9xZyNVsGKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmvZgV+gz4w2vlPwn1FSkF2wZwsMnxMePSKJuvPeJWoYhWldEdVJNHU4YQw3xbxmmnPXpHDl+Z8kopeccqQKZmZGDzkliRqc9sjNF3m5+jT1P7RhX8hntI53SmOMnpYi1OoKdxQGpJoyWDwNQlQ3qmfBGDF0flfSxc1XRutTjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BXjaLMCY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+wFGXyrj9LUB+jbNenNh9uv+nrfuQyXsxG1vPz8UJg=; b=BXjaLMCYDOlU4Sruz2awQYW7u8
	6op6wAFOd02+kwH08V74+MmiFGnRQeLtZUaaL6xjBxDrumw427il/zrJSUNmCxavHzKw3QKaeaI/U
	57SFRaKdXErRjCYcDV80ER4o+v7SdB2rLvUU+mtbtLKZoCGPewIMo/aku0cb+O/iKo5I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fWL-009RAR-46; Tue, 15 Apr 2025 14:36:09 +0200
Date: Tue, 15 Apr 2025 14:36:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: intel: remove unnecessary setting
 max_speed
Message-ID: <bd0eeaa3-9500-41e6-967d-0d7a8fd64201@lunn.ch>
References: <E1u4dIh-000dT5-Kt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4dIh-000dT5-Kt@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 11:13:55AM +0100, Russell King (Oracle) wrote:
> Phylink will already limit the MAC speed according to the interface,
> so if 2500BASE-X is selected, the maximum speed will be 2.5G.
> Similarly, if SGMII is selected, the maximum speed will be 1G.
> It is, therefore, not necessary to set a speed limit. Remove setting
> plat_dat->max_speed from this glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

