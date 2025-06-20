Return-Path: <netdev+bounces-199923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F495AE233D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E507016CF09
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B782224B12;
	Fri, 20 Jun 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCB6Fm1o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15283A14;
	Fri, 20 Jun 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449940; cv=none; b=BHlxyClTY4Wp8DOsE7rngfSMZBeWyE8rdo1vlldG5qIPhelHAOzPhsTGkA5SEjLwPW4TKtmf2uQ180beS00yLO+ano2Pn2HrtrGwUGCYkcv/FoT0Pdu+saUAhE8J3m2S2KAFqsdzQQfVPj7W3P+C7ch5tl1kCnPv1hQ+FT5ucto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449940; c=relaxed/simple;
	bh=HOxYtJiJhp46YLvbFulkT1F/asJMDlxZP1IWVBEjXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nycpIAdYsoMGK1easiIBn6nmtGWUX6vwpdSOQ8eHVo1bjrlP3bf/cAg+Ofl63ag5iFpQjK4wnUt+qtF6fFP1Yt+JvoU8aqtUaGa3PIBVGA+G6bAR45PFZG6vAMAQ4avHrntFcXIiPBcOGYFtXfLklWNyshnxurK5m7Cskg1WGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCB6Fm1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E66C4CEE3;
	Fri, 20 Jun 2025 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449939;
	bh=HOxYtJiJhp46YLvbFulkT1F/asJMDlxZP1IWVBEjXfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCB6Fm1oTrMy2LPUNC4qXipFbuoKfd1jGJegQFU8E6ZUoSbDeoDAxdCxkj8X0mQmP
	 5alX7XpBFWIWNl74FpcP8/ICcOq8LqiTu69KMq2xgE9PWS2YmGdPyNeD07TueXdOW5
	 E1JklMx94VxyYK2/53uxZYeftv7fwlBdVHeJjNdroH3xaLo2X55iWOBYqlCxwQFfAj
	 8Qr1QAKEtp5argWqeGAbaJdJdIq6IVWTRzK0iRkwpSP1DqzO3742sl/0tlmRshf1qx
	 JH/vETnciESzAQREioUx0WGnNpH3dCpzb8VZtmvXXZtwIcQ3NLlm5S8UHPT1WLbIOF
	 8sXpY+9UIKSQg==
Date: Fri, 20 Jun 2025 21:05:34 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v6 4/4] net: ethernet: mtk_eth_soc: only use legacy
 mode on missing IRQ name
Message-ID: <20250620200534.GE9190@horms.kernel.org>
References: <20250619132125.78368-1-linux@fw-web.de>
 <20250619132125.78368-5-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619132125.78368-5-linux@fw-web.de>

On Thu, Jun 19, 2025 at 03:21:24PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> If platform_get_irq_byname returns -ENXIO fall back to legacy (index
> based) mode, but on other errors function should return this error.
> 
> Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Simon Horman <horms@kernel.org>


