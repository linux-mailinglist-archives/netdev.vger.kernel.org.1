Return-Path: <netdev+bounces-225343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B814B92731
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC51444908
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55E315766;
	Mon, 22 Sep 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujixOvZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D8314B73;
	Mon, 22 Sep 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562437; cv=none; b=I2obEI0nNMj5yfYmnp+CeeUAbjWYWlwE7FjEkdFipiJUEvZyIMGgQ3YNyoRfH+4zU/RH+JvONvKrgk2DBZ8HKwUbzqQ4aahRLFk/iRR55AQB7BmXa2ngIu2kRZwIslOLWGvznsvTaXTarSR5WJP82eHSWrkvnt+ya2s6hX91Ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562437; c=relaxed/simple;
	bh=/VUh7SsvRLqVAoILRJvmLKOwGytnLANEuCYxE2Y6Nsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egn+YfNeZ7HNMwqHawbVZk4FTQLUuT7TAs3AkB233gzxIBg/ImVdrfLy4y35hH5YMGArDgRH3Ur/Y4u75Dl+WRWl3PuxxGSRQqMDYwFSMPwo4MuuIwGLsF8oy35PjILYbqpj87EVPolCp5O9AlA0ErIN9wj5XEPtKemtlRprx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujixOvZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C66C4CEF0;
	Mon, 22 Sep 2025 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562437;
	bh=/VUh7SsvRLqVAoILRJvmLKOwGytnLANEuCYxE2Y6Nsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujixOvZ/cuH76701/N2sz1vu2SRUt38ykB39GGe9k/Rk33d5rK6o+EQQmmQoJwSe+
	 I8ukNEmX0UKxoeNqu2MJmke0E/iGRq0s8/Z3Gr0NodxphpIXyWZpdlWX5371Ddh0Ry
	 2bUjySSfg28fCpFpENGH8mHn142UNaMKIkD8CJtWbyYj6CxuiEAk18m8myXyp+NWas
	 fgQoVUO3qtE77qj+6GZ4RpQOfYcDBeCb0uivQr5Pq7azrWb098WZ8pTMYKEeD2MQ78
	 b88RN+F3xSsTrO75YY96NP4wr+D8OmBnnfgiJW15QEpkNSRDVeWXcW0VylsjlCr1O8
	 XtvCHdxD4ILpg==
Date: Mon, 22 Sep 2025 12:33:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: Add
 reset-gpios property
Message-ID: <175856243558.512098.3904766472489050008.robh@kernel.org>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>


On Thu, 18 Sep 2025 14:19:44 +0200, Jonas Rebmann wrote:
> Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
> reset pin, rendering reset-gpios a valid property for all of the
> nxp,sja1105 family.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


