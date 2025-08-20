Return-Path: <netdev+bounces-215082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C4B2D14B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF31B725FED
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFE148FE6;
	Wed, 20 Aug 2025 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyTHEKlR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD835334D;
	Wed, 20 Aug 2025 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652761; cv=none; b=WSpvOiJTsYyFptTl0hILAVgP5ZF9wbgdNlVkQFU9S7gWRqrQo4LXVGXUfTVtmWqiYnd1/1lZdfgHsKy6LXMSBR1th7VbgfyOTDSJxVcEaUbpghgyJp0U/of7p+sHyfhGHzmyEBmJrhZzbMLReR/V7/ntxe2lAskvrEGJiloj1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652761; c=relaxed/simple;
	bh=cjJRLW2sV4cFnb5HNArK4xCSZg33FLuESJ6vc/T4y5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYJ4Ob/q8ECiYMEenhFKx8s1FA6Nm40ex6DTrsOvU7sEp4bujfzvz2Yu7p2Q7xWkcRxdG3nu5fyaeGYUOb0ZtqFn6zFLAKHbjZvCE7RwB6VoEaOAYoMsTZeSD3CfUJTT7aiNh9IsIerhFIMQHMoJ3A4cNnguYRIXslR6CpzpoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyTHEKlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D35C4CEF1;
	Wed, 20 Aug 2025 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652761;
	bh=cjJRLW2sV4cFnb5HNArK4xCSZg33FLuESJ6vc/T4y5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cyTHEKlRrdRQ1N62AOX3gs/46KVqddCnuOs/wFLM1W2Ng02c/2X0CX1eEbIgERXSQ
	 /E53XK7ba39bRFUSW00l6LIpj/mlbgGXq5Aw7hRGZQVP7w0cY5tvTMQGCr3eTgHNNI
	 yrrd7/Sux6QF8j8Me2YfV8qIwzgN+5Apuj93J2ym6b3FHC4wlPvvK3Hj/VN6DQ3fWQ
	 p4RO7C/6MVu0GvXEeXRlbxaT3yLah8MOg1wpI0vOEnd6ZljHocO1a2qKQKLI7G1NRR
	 I0jzZeE6ATgraaBHKp4jvExUeEd7bWGBub4U01XW+4q+xQ3ucUtjnm3MT8KH3uFPoi
	 acdnyFpkpu0Qw==
Date: Tue, 19 Aug 2025 18:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin
 <fancer.lancer@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: xgmac: Correct supported
 speed modes
Message-ID: <20250819181920.275f2827@kernel.org>
In-Reply-To: <20250816-xgmac-minor-fixes-v2-2-699552cf8a7f@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-2-699552cf8a7f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 00:55:24 +0800 Rohan G Thomas via B4 Relay wrote:
>  {
>  	u32 hw_cap;
>  
> +	struct stmmac_priv *priv = container_of(dma_cap, struct stmmac_priv,
> +						dma_cap);
> +
>  	/* MAC HW feature 0 */

nit: no empty lines between variable declarations and longest to
shortest, so:

 {
+	struct stmmac_priv *priv = container_of(dma_cap, struct stmmac_priv,
+						dma_cap);
 	u32 hw_cap;

