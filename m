Return-Path: <netdev+bounces-110357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962292C197
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C5228974A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8D1B11FF;
	Tue,  9 Jul 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr9I/Dzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01419DFAE;
	Tue,  9 Jul 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542755; cv=none; b=l2CiRXSawEIKXdZTzoDmxN2Ly7DD69ykNu7CqgUQgyhm/kyXPvg0C9Nbcvv/S1RTLx6hxphhFmtKwDDrPwFeUm1KwfqcrgZR0ntXrurBNaEUMO147muc2rozc879tY3MFIYwOs1rg8Tspyjlon4cryTB/FEEia5snE+DJYoOP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542755; c=relaxed/simple;
	bh=9CdFFJLTkats5q8OxSt2AUni+1qaGnQD5LEHNU0IIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrMcELof8C1qcP9ipDaCHOR/ujKWfImbITrGFZV9SI3w5Os04Rcn3rRyxJAEYGgwAdqDmp8uLePGqMUityZHq3jp1h0WElMRYwwlWMe1iVt0mP4JObVxJJPQLajjFimyPkURmN3sdjEIqDATkaqlCViy/6Cr2A9lp/+Q4grr4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr9I/Dzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84518C32782;
	Tue,  9 Jul 2024 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542754;
	bh=9CdFFJLTkats5q8OxSt2AUni+1qaGnQD5LEHNU0IIjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nr9I/DzkDNnpPEdSyLj3eLG5bFxlW/N5SPytRMEP+pS4FfcT2Vpfl8E8WcSbtuyC9
	 PboNXYjZhkVmAZn9u7zWtiDTm7i1CFEo0Rnk6tIBkgN2KfindEYG3vBZKgQjG7BJy8
	 TElA0OvwZ+wN4q9bUEN9SrQ5aSsM1gZxsquLHd70+rS1r/aep5sw5PyUH+PmvARQE6
	 qV00TTA+HqicRVpXCajR+s4tbC0qOjNFyX1UMUPZmr8a9y07pAUbCwoBCtjSU50erb
	 4CICzrARgVqG5vwyWcqa/Z84Xg3MQLBWFUCYu5uk1Bs2UFV961NwHRXSH03auvSIJ9
	 Y0PrdeWxieJLw==
Date: Tue, 9 Jul 2024 10:32:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>, kernel@dh-electronics.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 RTL8211F LED support
Message-ID: <172054275189.3771990.8455212352576271958.robh@kernel.org>
References: <20240708211649.165793-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708211649.165793-1-marex@denx.de>


On Mon, 08 Jul 2024 23:16:29 +0200, Marek Vasut wrote:
> The RTL8211F PHY does support LED configuration, document support
> for LEDs in the binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: Invert the conditional
> ---
>  .../bindings/net/realtek,rtl82xx.yaml           | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


