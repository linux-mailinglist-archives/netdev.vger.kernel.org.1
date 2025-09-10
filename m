Return-Path: <netdev+bounces-221515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F601B50B0E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476271B27ED2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969023E335;
	Wed, 10 Sep 2025 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKdRxd5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDF2153E7;
	Wed, 10 Sep 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471561; cv=none; b=hsUOClmR2OPAyzalvZZkG1Yd2ucPGOfpVLHW2brpbk9YmJ0goch8W+IGxBOiVsU9xXeuNl22KSpHhIivDTHcv8Ug9cjmnjmcr11R4WKPvi/ZVVKnJrZdPvD6eZDIR19hDT67lcEFyiWlOfbywXO0LuvyZ09OyzbiclvwZz/bmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471561; c=relaxed/simple;
	bh=uKnWLcPvL4FL5EbVfXRQWAlwJ32gTk07l7dEO35EovM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSBNfdSr25LqqCpDqMfCEe3cagyqfPEI5QUKEKZW2tLC0Vy9A8Fp2NCR8rMxL6onfwMEw60FGRaFA74j9XSwGoIlSHT9sRG19mRMoxHK52O0oRSWgf7l7lJZM3MOc9zxueoLEIuP8sRhZMgiHtOmBLLK+kJcacOTB9qzi3/dZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKdRxd5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45600C4CEF4;
	Wed, 10 Sep 2025 02:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471560;
	bh=uKnWLcPvL4FL5EbVfXRQWAlwJ32gTk07l7dEO35EovM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKdRxd5VDS70ED1efdOfAA+1WTSHm5aVv3nvZkgwDzJ1qge/g9SFe1s2Lm/LkMKti
	 sGuVA1Pa6LNdzURqcUX/UrsrEWL09J14dUHCqn4PovezuTHer/JRKSV1ozJgCzjVAl
	 0OoxEanJ1Bd17pUgBTBHHwDqk3xUBvU5lYRgnHKdOZA1gUeqdKhRNCuilljCO8DSJQ
	 Dd4UAKiGbyJd8dZqW9ZwRvTiY9cuPRtwuRTuVlRp6CY1z6TvbqS7+I4yvw2r6CJiwm
	 F6wktYr8fPrRPAALKahxTh/KGOSkMYb5UCJEwZEhz8idVEmOpOZpAAyz2Ne9Ca3NrL
	 VzAL2x5ECk0tg==
Date: Tue, 9 Sep 2025 21:32:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Lee Jones <lee@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [net-next PATCH v16 02/10] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <175747155888.3660326.7601418632786886363.robh@kernel.org>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909004343.18790-3-ansuelsmth@gmail.com>


On Tue, 09 Sep 2025 02:43:33 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


