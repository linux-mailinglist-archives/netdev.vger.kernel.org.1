Return-Path: <netdev+bounces-100670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF28A8FB846
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDDA1F22B72
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851FD1420C9;
	Tue,  4 Jun 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGDn64fC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22317597;
	Tue,  4 Jun 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516841; cv=none; b=pwuPU1bvbEh0uQ76Rji3PH3smREEOy7ecDeq9sar4HSMZJPNYHQz+p7hg3akkbl1BOEzwaY2pOZqYM8RWcKFccyhcjzQ6N9DdcL6bIUrIZvB73KdQ0GPnkdg3K4pVqIdbu7fcu74xRhY0Amc3VhTK+QvVAKjCfDQeft637gNf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516841; c=relaxed/simple;
	bh=gp43FE8UnfMBOQxc3O/OjKPg9coGoPPXZt0nohMOQhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InrQ9WXA0AP5DMvKkEcPSbWbizzIyuWSSBbE4tzAOUCyuXPv4NPE8iwYbbrBRNhwyntTKkfhYmffp2t7uefNeS3fmLXWTPtKGF/tR3OZn9AW64IThBbzrR9J5nv0cTArScMUcsxaa9pRMqApjs6JyAUOUCF1UMyQRNHxpg7FcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGDn64fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E30C2BBFC;
	Tue,  4 Jun 2024 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717516841;
	bh=gp43FE8UnfMBOQxc3O/OjKPg9coGoPPXZt0nohMOQhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGDn64fCNqbM0ybx/brx8QmU1MO0LnO/D2FunGtgQ/CKZ9xGYjMxBPW4xVKVaN8S2
	 sVYq2OoDZpSS/AiRtQQ998zVoofKeUdR037YL0r7DOx/HAlz131gL7D1nIMXFTII79
	 SVxymlnFOugFa8ZPcxgLmx/lJPkSj4JSKUICHU69PctC4F3h3Jj7CO4PHAzx15Qce6
	 jQbu16hclAgZ4oqoNvMWRF0OXIw+9+A+fWK+b4HuQTeMox7lt2VseflBfUSzEnhS8A
	 bD3zFA1vD6XnRRRFOWz7vMx1Clak6siwAsbOCbknpARlhjF5EnnGHBBiFaiwKYEs1G
	 v/3nrhtyxfjJQ==
Date: Tue, 4 Jun 2024 11:00:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] dt-bindings: dsa: Rewrite Vitesse VSC73xx in schema
Message-ID: <171751683590.1048388.14626435118611937100.robh@kernel.org>
References: <20240530-vitesse-schema-v1-1-8509ad9b03f8@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-vitesse-schema-v1-1-8509ad9b03f8@linaro.org>


On Thu, 30 May 2024 23:53:07 +0200, Linus Walleij wrote:
> This rewrites the Vitesse VSC73xx DSA switches DT binding in
> schema.
> 
> It was a bit tricky since I needed to come up with some way
> of applying the SPI properties only on SPI devices and not
> platform devices, but I figured something out that works.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/vitesse,vsc73xx.txt           | 129 ----------------
>  .../bindings/net/dsa/vitesse,vsc73xx.yaml          | 162 +++++++++++++++++++++
>  2 files changed, 162 insertions(+), 129 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


