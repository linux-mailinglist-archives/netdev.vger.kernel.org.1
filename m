Return-Path: <netdev+bounces-235106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C737DC2C0CB
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B630F4E32E6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288A229B12;
	Mon,  3 Nov 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A94DluXu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2292248B4;
	Mon,  3 Nov 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175956; cv=none; b=RWL1HyAmek3qXOZBaGsfvcIXmTADqieowl2Q5VJ3ut80xrkkPzAM9V2Uhs4FmP4ZU2pdu+LUi1/E52Dhi7OK/PPETCVfBa543cbJqVSHmSxxmWuLO7Mmw4nIt8fbeYJ4jntBzqcvlFUJ+1opw7tvrAIDAU8PBwnM9pRfR2dpdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175956; c=relaxed/simple;
	bh=MgsvOCYdGrKHVHF8qLHEX9CrTPApSK4T8/EU6opZtic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjNeO/Q4TfJ7q6oEkXvJ1Xpo4ksEG5+eb7ufouo8TMmv3WKE5CJPA+EisFrV+jrSaGgVH0xqUvA3fWk7zmKoDsjkFbyeDcrjx93Jn4Bm2APmdf6xvEX0fzmiMZzOJppr4UryyCYlLdTXigy16fwoVQaR61c/eV7pyCynbbhSrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A94DluXu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U2vPZtG6pTMf2RXO8sZfzEz/4QzpCuVNN4jCYQL/TRY=; b=A94DluXuIWFxl5JkOYTkd76nYv
	qKT3TiGoDtgD0mC0N28ueW5N9bOtynh/EbQytpUHPVqa+38sb2X0J8mFVpFb8U6haYt8Sd8/bOP66
	OSIMKxmYVPWPVwQrXDiUL5KRYcTSIj4yaVfNX8uHS1B4kt5t2ROglqvuXYOWb4P/M+7Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFuSb-00CmYS-RF; Mon, 03 Nov 2025 14:19:01 +0100
Date: Mon, 3 Nov 2025 14:19:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: net: ethernet-phy: clarify when
 compatible must specify PHY ID
Message-ID: <a16259c4-b27b-4260-b99c-aed888b99f13@lunn.ch>
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
 <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>

On Mon, Nov 03, 2025 at 09:13:42AM +0100, Buday Csaba wrote:
> Change PHY ID description in ethernet-phy.yaml to clarify that a
> PHY ID is required (may -> must) when the PHY requires special
> initialization sequence.
> 
> Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
> Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Please always start a new thread for each version of a patch. The CI
probably just sees this as a comment made to the previous version, and
so has probably not tested it.

Given that you have only changed some DT binding text, it is however
likely safe.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

