Return-Path: <netdev+bounces-222893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EDB56D33
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 02:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D9E3BD585
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD21F5F6;
	Mon, 15 Sep 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U44cO0PU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98535158545;
	Mon, 15 Sep 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895154; cv=none; b=oGhZ1aUts1gdTh/0trh7tmpqoJ5v8rGmAOb3E/CE3Mx2BRepYSwMPDZ40itwaxctKWT4u0QptqMTgktK3rvBATCsIjqcbbmfxLYRgUI4rTTLojpgfwjIj2M3L++fWB7PsPxJ39a+qITQi2tYkwF0aodftaksD9aIZlAeD+aXHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895154; c=relaxed/simple;
	bh=UbiiW95aQkxFo3IVZ6BYSGYhMqA/n8zEEIb5wb50uts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaN+5WB8IvoGXlLl+f0E91rLhZ/ocmrmB20H6T0Ctspa+2anc8Z9uY9mk5Oz8coeyM1VCCnNBy7phaBZP8+qbqbVACj5t+qa+VHbQGa0MLAWcESlyT/+P5yBT8YdaxaDOW5sZticw4qcIJwfpxd0JtBFXM7o2BJSetzAyxDsqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U44cO0PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AECC4CEF0;
	Mon, 15 Sep 2025 00:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757895154;
	bh=UbiiW95aQkxFo3IVZ6BYSGYhMqA/n8zEEIb5wb50uts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U44cO0PUxNY01mFS2Jti1eqVALemOF50c3VaOKUC5xbCNlAQjVV/ygpBjc60AcKKt
	 FMQoBif5NPmfyoH7LuaUdZyMtklATc9S9hx5Gw5o7EygUN8i2q291C4qLDrQb9Xrj6
	 dMVKCKQ1mMvXq/FshFhZE9fSMJCfWkt/GBDiDW+1MyK1nQRznAlRIR+nOSZZZCpSLv
	 Z4dQQPw6w4lY8e8xzi26hYOsjXvQV4EmvZGnwuTkxbKMZWGToppz2g9Ybu9bT3gIv4
	 0vNx7ENyBIpf2Uzyqpg0b1YXhI8tljqJJqDxzW1YEMXyPXTeRS9DZt53YsWLWcSOPJ
	 pc7UW9rNtUdkA==
Date: Sun, 14 Sep 2025 19:12:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: fsl: Add Protonic PRT8ML
Message-ID: <175789515239.2294687.11215788946792312657.robh@kernel.org>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-3-fd04aed15670@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-imx8mp-prt8ml-v1-3-fd04aed15670@pengutronix.de>


On Wed, 10 Sep 2025 14:35:23 +0200, Jonas Rebmann wrote:
> Add DT compatible string for Protonic PRT8ML board.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


