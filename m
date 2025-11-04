Return-Path: <netdev+bounces-235360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD91C2F36E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 04:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7D54E4119
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7129DB9A;
	Tue,  4 Nov 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="37wmGEZH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572614C5B0;
	Tue,  4 Nov 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228537; cv=none; b=mta1Ebgvsfi5SriQC64RyINQcFJyn2ZNN/lE7pCg4A170sy4xKtxvfQhOSh7bVjiRJ4KFSccnS5IN9ltMMVkyWg8FtBjWLzKzTOb1esHZHYY6f+w1EC/bBKkWGlSJcgbh26GefvkA67zVYwa783NVum3QYY6F+3IvDvyOAiCoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228537; c=relaxed/simple;
	bh=u+n8PffSARt4w1r3LEgpIS9Esd7FM3jmMENFfqojk50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka38IeCtnQKqKcC4Jixo//BIpI/t8RTTA+vZ3DQEe3S4sdrbdCr9HHM6DHyEDwHeje2TaU/QRX9x+We63OokxjKqCOzJQGkD+PyqmOaGqj2SmTh60k0MK7HUYL4XyKDRWFGFAutyP9Z8HLD7/2K33X+119ok+0ZWM14MM4NSIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=37wmGEZH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=idHMrjalzGqAPV1VfgktusSm/NyH50rSWJqFE6LBFhk=; b=37wmGEZHza0JpMy6KrNjpNoaHh
	awWe9G9SC5NDk6DNekv9Zv6eOExuGGa1WVWVa8OPsi4vh4bjDVdiDTyjiHoXT0dYFerj0gctmkD4+
	KxzK8ZGzu0Sca0JELGXqozQK59V/xldtcrbJ7FashfzrGQ0eVnqpLZxP8hg4j3nSBT9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG88d-00CqvP-LY; Tue, 04 Nov 2025 04:55:19 +0100
Date: Tue, 4 Nov 2025 04:55:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <fc3f159a-0919-46d1-9fd8-8dc263391691@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>

> +	rgmii_tx_delay = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> +	if (rgmii_tx_delay >= 32) {
> +		dev_err(&pdev->dev,
> +			"The index %u of TX delay setting is out of range\n",
> +			rgmii_tx_delay);

The index is not really interesting here, it is not something a DT
author uses. It is the delay in ps in the .dts file which is too big.

       Andrew

