Return-Path: <netdev+bounces-246289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EECE858B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 00:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F913300214D
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480B26CE1E;
	Mon, 29 Dec 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsO+JXlf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB521CC60;
	Mon, 29 Dec 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051353; cv=none; b=poA6/qu64adyV1Wi92UiARkLto9kt1I0+emejPG74jQfzhcgDxOVN6K1IrMF0aBfWvAYh5x6WzSDo52B70mpppHxmkJsvEpc8nECBQrEGX3k1dcf3EdSeUNDr8AoxVYNv8dpFh0FCIAcONvNawiEvGIYw1RJcAbTjo327bpJjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051353; c=relaxed/simple;
	bh=SnbjmuGKdPhQGT3UsQ381fqZ4/2f2Z0beUvzGjoXWHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNf0D7bykozemgQ1JTaCNCg02TrtAFPL2Y9meJTrCtdPYLgkT+k+mX8+uPgHLDtL1hKuqBz3+u61VyAEW1gmDWXgNvcg3rfOiZPDDZxTurAvzLARmxi8BlquWYuVDI7u+slaEI+TRacbWges79cd7M+f/p7xPcVBNH9gF6KEpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsO+JXlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC460C4CEF7;
	Mon, 29 Dec 2025 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767051353;
	bh=SnbjmuGKdPhQGT3UsQ381fqZ4/2f2Z0beUvzGjoXWHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsO+JXlfIgWasmyd8OiLJ3LMaIAUU1vVvSUWuo2T0S6SwIjEVMb/wEs0U8zOStvB3
	 pscXDZbJpOj2b/3WmYBPceM5TJtlzYMwv/8UmUCVlpRHo+eZc6mVyzghLlgDg6P0RA
	 W6lYE/YREV71R5e+Haci3idd42QOagJirDplO4Bkslmcki3YiyH0brY7G0MBAI4h5e
	 pEXTenYBe6z3a24lXXh/eTAUWEkMJ2mW0hngyFHAJ+b1H0fXcjqCo1csYUijgznPwX
	 f/WUx/pd1Ng056AQwBK1fFjuSV0LF3PxSS62Tz8w0YuKESAzjvy8KXNWe6W5uUmIFs
	 MI6E2yZHcRx9A==
Date: Mon, 29 Dec 2025 17:35:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next,PATCH v3 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
Message-ID: <176705135005.2796637.3826726486129502668.robh@kernel.org>
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218173718.12878-1-marek.vasut@mailbox.org>


On Thu, 18 Dec 2025 18:36:12 +0100, Marek Vasut wrote:
> Sort the documented properties alphabetically, no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Ivan Galkin <ivan.galkin@axis.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: No change
> V3: No change
> ---
>  .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


