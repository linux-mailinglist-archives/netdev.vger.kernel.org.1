Return-Path: <netdev+bounces-225360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17349B92C21
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D364E2A5172
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB553164D0;
	Mon, 22 Sep 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWhkh865"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B32D739F;
	Mon, 22 Sep 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568683; cv=none; b=f+5mKKydtPkwIbXgzEN0k4PBI5M9TuSyh1DTAdW5xVnhTfq2Ah9Tr5Y7VKvUeQoyCIBpiNk3j63L3qSJ5u+XYgl0T1hQNBJCQ6XFHfQB6lK5MpQHGtRhINYpO0/jTsPFg7B0SKHfCSHuz9meJSbCcTsLO8/xda58cIG9VVfxzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568683; c=relaxed/simple;
	bh=zCc9tNG1q472U6/8gOeRaAEy7Q3tksNlUbazLFehR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFf+mh2RgtApK+IT4W6V4nAlIuAAWnYBAkvxghgy90qdrt6UyDK/y4OhdCTYwJJC15SqYdeeNHAAQAzhU82UG5W5WRRxdx/nPN+emAJg3JXPjsr6zQ8l3DFi6aZCLXOGbhuiQcE04HHu2cQy9geyYS1UOeKwn3ubWRQjabABCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWhkh865; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBFC4CEF0;
	Mon, 22 Sep 2025 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758568682;
	bh=zCc9tNG1q472U6/8gOeRaAEy7Q3tksNlUbazLFehR+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWhkh865UFh80V8VI//H0GWPdPaSpAvOnQ2i1FEOgSy5NadL3MfiHV49Rpkt/+nbJ
	 hLct6KggwAgo2X7kIj44Z62PYQo2SaepyOy7nVwVdDPNlQRs0GKFo9C+i3Bw/tYDSL
	 x4bt3ZnwBWma8vpVSr67k7eLThE2p42zKVJK24Mps8Eg8bfaUweyaDWZW8AHW10IOM
	 qjcZ11ZoHhJ4P7N0xebWV6ecpvoDJW4/jvadswqXNKarTvKTyll9lvhVJd5Dz5xYOY
	 bC87E547PWU7zzo0xwjmplafPSzclp02UNZfcQC5/MpUJGWbDJpJgYlVEjsrgHf3B6
	 q/X9voTgzbwQw==
Date: Mon, 22 Sep 2025 14:18:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v10 1/5] dt-bindings: ethernet-phy: add reverse
 SGMII phy interface type
Message-ID: <175856868047.835812.3464607742164476820.robh@kernel.org>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
 <20250919094234.1491638-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919094234.1491638-2-mmyangfl@gmail.com>


On Fri, 19 Sep 2025 17:42:26 +0800, David Yang wrote:
> The "reverse SGMII" protocol name is a personal invention, derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


