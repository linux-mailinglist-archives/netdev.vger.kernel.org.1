Return-Path: <netdev+bounces-220807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1CB48D9D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824FC3C8035
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2342FE580;
	Mon,  8 Sep 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c1RQLK5h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7AE2FC036;
	Mon,  8 Sep 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334868; cv=none; b=hYKIYBk8ZcROUja0lIaPbTF0nOY1nOHl7SBNWZ2Ou8H+ealWgDxgLtb7g81mGMnCRgavltIKZMVpT55KJzWPVQ2yI2whV/1zgQ+fakIVqGgK2VGAbL2bGqLZWHka50Jw6BMPaXL5qb0kifMtyT2L4yze8y2awwfNmsJvMNOtTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334868; c=relaxed/simple;
	bh=8EBd8OpKW6LLv0TeO/TalFwYHS1UNc9bmRYqNAOmOYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh6ND+P7rp/0conv9hFN0vMdDqJ4iDQTLq5o3Dt0bQDvYl5kY2Anya99WqlGLSbUjaC7L8XHz5FfGqNRMCo1plrtyqrATMu2/fCiTmPY1hONUbCvaxtVnDz6dwrxeWt57Knd5g7FsgOf9N3OVSBNXQDKnJEQjL9b5IZxRDXuZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c1RQLK5h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FggtHGPQVy710Ns+O2k7GfEqxXjowS7RNJbEdepk3Dk=; b=c1RQLK5hoPPEshy8G4nnRL4hhW
	DaRYEi5RTNFAoFTy97qXxlt2EdjE1IgOwQ37f6HiQPw5R5d79oNHyt0zE9GUBE8xtMuVq1c3oLQOE
	aB+N5vtsn9lAJKgWucbB1CeZupkVLEv10uhYuRCkvF42nayeRLqLlAUXwL6jKS3bN/O8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvb4c-007fct-I5; Mon, 08 Sep 2025 14:34:18 +0200
Date: Mon, 8 Sep 2025 14:34:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v7 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
Message-ID: <589389af-0089-4fcd-a1c1-4175528dea5e@lunn.ch>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
 <20250905181728.3169479-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181728.3169479-2-mmyangfl@gmail.com>

> +                /* if external phy is connected to a MAC */
> +                port@9 {
> +                    reg = <9>;
> +                    label = "wan";
> +                    phy-mode = "rgmii";

"rgmii" is likely wrong. It should probably be "rgmii-id"

https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L264

Otherwise, this looks good.

	Andrew

