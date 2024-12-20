Return-Path: <netdev+bounces-153822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4E9F9C84
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B7E1891E6A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FA1B0F0B;
	Fri, 20 Dec 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccldjYSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BA19D88B;
	Fri, 20 Dec 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732102; cv=none; b=OW88Z6/q8vcza6fwDvGbsDDOZk7v5CLsEq93UkhraFOFpCsz1OHcscJXLp1vZkQK4s9oqmVAePxQJU2Z0FsYxVDFbCOUT8KtqRaINAQ/my5gw4fSCn+q198otZdxH7R4EnxNOi0/81uEacKFp5olLkOBVC4a8irR26ok4H5Z1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732102; c=relaxed/simple;
	bh=AkFDAdGYAZwPeNowaJnnrFIGrNYl4SvJvDqNGrtVyz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNZLmfLRw1UL8+S5ICLeaGryPDX4oYzHteXdFytIVtt3NmE0S72xH3w/z4KN6Ak9V8ak74IQQMHXfzMeGtzJQBNoUbLNk7IuGoJo08gZ58D1olXFw+a6I+jwFBRbHQGsqkysTWNt6DuwHcNOIDCT1PbiRSZ6UdzVcU4ZvNRyt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccldjYSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D1C4CECD;
	Fri, 20 Dec 2024 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734732101;
	bh=AkFDAdGYAZwPeNowaJnnrFIGrNYl4SvJvDqNGrtVyz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ccldjYSCWo3h4pBQ/H2a51CJtIf7U6/juaE7A2hALoReQSwu5EewRZmcj8/HW+h+1
	 QouWXU1V1ojauyov52If7lyWaUeLy43qTd/8IubpqdihyLgI6yrGjNQsYdu6/YCMU7
	 7qE4KdHk2Lbjw9OMTCAlA9q2ShVYBtUJBHviN8eIXr6JjIXP/Ij/G3IQazvgzf/RV5
	 km7LKxoAwVflzPFfDl4h8gkdZlrMkA/52bQOKYQcAyGEAjaiJ/wHGs+0TBuvfD97ft
	 sD8tQCiRYGfDGDhTIaqyEUL0w7p5mZQGow/mSZz3RPPGBnKPjyJuAHc/+y+O2G24RJ
	 F5LHN29NQ0iLw==
Date: Fri, 20 Dec 2024 14:01:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwmac-imx: add imx93 clock input support in RMII
 mode
Message-ID: <20241220140139.5c0cee2f@kernel.org>
In-Reply-To: <20241217084942.4071-1-othacehe@gnu.org>
References: <20241217084942.4071-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 09:49:42 +0100 Mathieu Othacehe wrote:
> +			ret = regmap_update_bits(dwmac->intf_regmap,
> +						 dwmac->intf_reg_off +
> +						 MX93_GPR_CLK_SEL_OFFSET,
> +						 MX93_GPR_ENET_QOS_CLK_SEL_MASK,
> +						 0);

nit: regmap_clear_bits() ?
-- 
pw-bot: cr

