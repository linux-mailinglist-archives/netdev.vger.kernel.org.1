Return-Path: <netdev+bounces-225602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53865B960FA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6823B2BB1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982217A2FB;
	Tue, 23 Sep 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJBOZiSx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62714A0BC;
	Tue, 23 Sep 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635216; cv=none; b=M2woT86PvnTg5BFrhaB2PvaXV1dY0E26DYy1TnuNSUz+7fDy2OSs+NM6nUZvxE6cCwheRqqrVPON6xdY50FIS68l0pI8bduTP4YuF/sDyeSxqhEOJa9W9ZAZxgSBAie5vAD5fluGUCvBTsNfyjKuBDNZPX3ICbVasNu9jZDf1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635216; c=relaxed/simple;
	bh=OgZ0pbAqVKoLygYHlcZc+xjZI561oD6mNLG3UgQhZAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebXbTm7M6r0LQsaxsxwnJq+ngDkimbktaUUEhcD+6G7zdvqU1CFrh3SHBUHG5sC40xQovEOvA8W4EYZn5e75L2lE8VZ3PoAob/eHx6rwCGCSxWUuWnOT+6wk7wIBfCMg5cuStRxSw1NbatR8+yLio69bsa4k9uz1Pd4YbjDTxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJBOZiSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CCFC4CEF5;
	Tue, 23 Sep 2025 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635216;
	bh=OgZ0pbAqVKoLygYHlcZc+xjZI561oD6mNLG3UgQhZAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJBOZiSxaJRWl5IfBG23P0dPb0tq+CDetKZH5g7nQU/LObESmg7kfzg+fH11jXPt1
	 g82vBuknH6V4zH2Xr9mev3rtDgpba/+OfGSBoEWcKSFPIe6LagEqWBigrFx7DyAV5+
	 J18eOfwxvI4Oj98ymyypIIuSgEaApTGePKptcLXscgqcSCt/lr8gfokJe92VT0NV1V
	 EHbWrsoiMEr9xFxNQ8z0JBIzocTnLR70erjSv2MWvlwmEw5B5rPn4/6LOyeJSt2tBT
	 BrHjyZD4kd27TpuoRfiiA3oMA8L8QpGXtg2jVGPhz/9S35RbWb2RK187FnPBpxrw5y
	 ZAriLoAvbY3Fw==
Date: Tue, 23 Sep 2025 08:46:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v11 1/5] dt-bindings: ethernet-phy: add reverse
 SGMII phy interface type
Message-ID: <175863521338.3081646.17503929586282997630.robh@kernel.org>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922131148.1917856-2-mmyangfl@gmail.com>


On Mon, 22 Sep 2025 21:11:39 +0800, David Yang wrote:
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


