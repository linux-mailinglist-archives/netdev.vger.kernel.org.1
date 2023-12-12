Return-Path: <netdev+bounces-56555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B380F5AD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D58B20D95
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DD7F547;
	Tue, 12 Dec 2023 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USdyD2jj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE0210FB
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A6C433C8;
	Tue, 12 Dec 2023 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702406895;
	bh=UQ8sRE4qQ4n3OeWeQ/x2EijHj4zYvZuf5iO56KaYMYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USdyD2jjP4yLtkFomWlwuqeB16OP1NFH0y8en3wYXly3blUxasIjop5aSKBQClcMy
	 7TEHzV1KpNlBCEXV5OyJ2IeSSYgMtwZioUQczT+/Ki2WC+urZD4zn03bLxXaaLHTW9
	 IZhZIqGFUsdvnAawqVuuVFK7wS71SnwP+LmNWYOxSid5xLQrEVK71TvyRgkhThsY28
	 INaElF8vnTYJPDMifK73H9UtxGnB9YqgzHCT6rhmrhpsaZGwQSfe9/DseSbPPKoFJb
	 jEHA/jemjJMx1/hTgoPRf4uUdN43QstmbUE6ks4X/o0MtQSJiTPU/HbzrWlwYgUgvn
	 cyRaw9O+rUbxg==
Date: Tue, 12 Dec 2023 18:48:09 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Andrew Lunn <andrew@lunn.ch>, Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <20231212184809.GA5817@kernel.org>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>

On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")

nit: the tag above is malformed, there is a '"' missing before 'net:'.

  Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")


> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

...

