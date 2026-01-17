Return-Path: <netdev+bounces-250742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C885ED3915A
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B783016709
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424928030E;
	Sat, 17 Jan 2026 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="shDWFC/j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473D2AD0C;
	Sat, 17 Jan 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768688327; cv=none; b=H9KH61TojbmVkQeMUv49DE/iLFggxjnZB0tIjzwldgR11fqvHAdefPoJRioxqHnSgjB1ipat4kl6krshcquu1eDGihMCrX1e5GyntmRQlMfKqH+1PMnjyy3kMlKGxszWU88TQOpyUXSeucTlbfDpKsuM/WyxaWm9+xHCQM/fC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768688327; c=relaxed/simple;
	bh=gVimsqiopFJ3WnCfzMkwNVn34WxHiyhIwDxwRI4VtBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJU5uh9bLas0XUDS3+o7tUik3enrSeftWSznqtOwEiyQNNbnhzG4e0LPhb66i7kKCyBk+v8H9vPTINBbTdn5fUCRmP27q4LMhBJTYV4+8+yYCZS+k4NY4N5V5fqfAAbN2Qtg3oeWQjnCK2+DqaLF2Lkw1pq0DHc7aD7aoIlT9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=shDWFC/j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kgw4BVFnePM/0mIVJpR9dLoyHods82vVO/5jAlQl624=; b=shDWFC/jxIS90nsHE82y9XVXeO
	Dz6fi7Zllpw98ScdUTLxGMycleoz3ab9ehFnuPy2lMM2DtbH3+jut5U6A67wfkXeawZrZ3uRlWTdq
	n3Led52P0xD3yponWtchsV6ctTmjWLnXZRxxVyu0FkL8wVZytTWAb36qI8AuaBDHKb5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhEcn-003GDV-It; Sat, 17 Jan 2026 23:18:29 +0100
Date: Sat, 17 Jan 2026 23:18:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
References: <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
 <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch>
 <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWvMhXIy5Qpniv39@lore-desk>

> Airoha folks reported the NPU hw can't provide the PCIe Vendor/Device ID info
> of the connected WiFi chip.
> I guess we have the following options here:
> - Rely on the firmware-name property as proposed in v1
> - Access the PCIe bus from the NPU driver during probe in order to enumerate
>   the PCIe devices and verify WiFi chip PCIe Vendor/Device ID
> - During mt76 probe trigger the NPU fw reload if required. This approach would
>   require adding a new callback in airoha_npu ops struct (please note I have
>   not tested this approach and I not sure this is really doable).

What i'm wondering about is if the PCIe slots are hard coded in the
firmware.  If somebody builds a board using different slots, they
would then have different firmware? Or if they used the same slots,
but swapped around the Ethernet and the WiFi, would it need different
firmware?

So is the firmware name a property of the board?

If the PCIe slots are actually hard coded in the NPU silicon, cannot
be changed, then we might have a different solution, the firmware name
might be placed into a .dtsi file, or even hard coded in the driver?

> What do you think? Which one do you prefer?

I prefer to try to extract more information for the Airoha folks. What
actually defines the firmware? Does the slots used matter? Does it
matter what device goes in what slots? Is it all hard coded in
silicon? Is there only one true hardware design and if you do anything
else your board design is FUBAR, never to be supported?

     Andrew

