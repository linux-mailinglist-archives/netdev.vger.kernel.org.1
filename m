Return-Path: <netdev+bounces-202044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A9AEC110
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C31C472C9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8C22AE76;
	Fri, 27 Jun 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbApkXqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A012288F9;
	Fri, 27 Jun 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056578; cv=none; b=QsNbgnandjp3uSrkjZgzQeRAsh5DZYI2MQMQItle9YdFT5GeJNlU55v15yMaopVhQtk5MWaB7i4MhaR48+A0+Z3dZKK09d3iBObLxKxqhKUcEPGWoRW1Q1nll1J5ocIbD19IDW89Eg9St0pVYJ/xkhLK4KzdkXnfw3QZi9Ym9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056578; c=relaxed/simple;
	bh=5l4MrqzY/w00DxX/j43QPz0+uFoFDnC0jcI95pMk1Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcwgNu+puxBLKdzxVsVuIs7UhbnhBGMWAyVQm5GSQ16rE6NEVP2zKD3mJNStCqQDtMq4oXqVNMly8XwvocjSMrkt1fJ+lE1+nZH2NJGetLlMe4AGqe88prG8Yc4I1Ix499OTnCN/ZNLjuS4yZeYAthh2PdRp5jkuTzs4nNi/jlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbApkXqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03904C4CEF0;
	Fri, 27 Jun 2025 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751056578;
	bh=5l4MrqzY/w00DxX/j43QPz0+uFoFDnC0jcI95pMk1Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbApkXqmzDRKsU9xP1Bb6q5qILTb8U2F3CoJdRUfezWXMOP7kPgSpb1bCm5Koq473
	 R4Cxq4vZYT24Qy4Y7BUbfvfnWQEc1hfBxr1F/XNlq1FhXXScnee5+APGsieqcS2Nme
	 FPmp2Gn29oqi0ds6Ry1eoEmYSJV6vwFEcdF+J1NeC4F2hY67WRG7M8YQ/W1L7tpMqQ
	 0ukZcXg2fIhveOz7SZJq0a92ZR48Mj1Hmn4Nbed0uJ+1XFk2jyNHXjn1VvmCD5A0x/
	 dWS+S5yBviRYTnR8bCskI0F6A8rThWjmiYvFz/o5sPFZ2v3IEsgipcIBoROn4jxuMW
	 frAe0F2kKAKfw==
Date: Fri, 27 Jun 2025 15:36:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Frederic Lambert <frdrc66@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: dsa: Rewrite Micrel KS8995
 in schema
Message-ID: <175105657688.40268.11899758401266363285.robh@kernel.org>
References: <20250625-ks8995-dsa-bindings-v2-0-ce71dce9be0b@linaro.org>
 <20250625-ks8995-dsa-bindings-v2-1-ce71dce9be0b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-ks8995-dsa-bindings-v2-1-ce71dce9be0b@linaro.org>


On Wed, 25 Jun 2025 08:51:24 +0200, Linus Walleij wrote:
> After studying the datasheets for some of the KS8995 variants
> it becomes pretty obvious that this is a straight-forward
> and simple MII DSA switch with one port in (CPU) and four outgoing
> ports, and it even supports custom tags by setting a bit in
> a special register, and elaborate VLAN handling as all DSA
> switches do.
> 
> What is a bit odd with KS8995 is that it uses an extra MII-P5
> port to access one of the PHYs separately, on the side of the
> switch fabric, such as when using a WAN port separately from
> a LAN switch in a home router.
> 
> Rewrite the terse bindings to YAML, and move to the proper
> subdirectory. Include a verbose example to make things clear.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/net/dsa/micrel,ks8995.yaml | 135 +++++++++++++++++++++
>  .../devicetree/bindings/net/micrel-ks8995.txt      |  20 ---
>  2 files changed, 135 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


