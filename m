Return-Path: <netdev+bounces-195440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BAAAD02DF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC8E3AD888
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE7288C81;
	Fri,  6 Jun 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFtvROfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E3288C3D;
	Fri,  6 Jun 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215553; cv=none; b=FoWSRCbUOIn94Ef+Dx95epRRFo5KRfPaNYEenRFJHF/pRU0t97HoqBxoegv2OQm1nMayhBXAY3ufRYBkuVmCPUrsqtH2PWUJXgEZNRWntAhyzxnFKtytiwq5ImO313Bn4s+RPgVna5cjOnaFg81Q/35Hm6TcaZq7p/EvOfENm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215553; c=relaxed/simple;
	bh=iBdr1CS6YlWDK+sb2MOzhqb9yTlPeul/8XqyzdJDR54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqV1ocIeHGxUNjt8uwSQTBDQbYMZEf1yDwNEc+OgNWsfNMG0q/bE+yDHPHwmdc31GJaBnewuxHDPdZ+MgMs3a1vPKFZDWsc2xftD+/F97jO1iGIUAmEFTwPqdpQ5sogeDizJnWqtPyB3/mmenJ/D1bKFPA5ItisODpOmzfIAW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFtvROfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F9AC4CEEB;
	Fri,  6 Jun 2025 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749215551;
	bh=iBdr1CS6YlWDK+sb2MOzhqb9yTlPeul/8XqyzdJDR54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFtvROfnor7bJSbNy7B6qOPNLgMJ53kWkzw2rtijpZQzhLKtAdeuf9SGyO0HWo5Ee
	 j1Moji54b1Q06HKRkJwgpTr54o5W4BrFBZZ4ad7L7aOGeMKm0CfAoU57tKbIfmSsoI
	 bO9HuvaWmVwtjoLIUNRkW4jCufUkrgRnlTD/raSxH9vv+u9tzYr+LGLkzWvVgIwaEb
	 ShyRg9+L4roANY1+u3OSmVC+riz0Nl9st8TUYG4wvrSws/cuhUVKPbfLLOcZWTHmkr
	 qk7rYNpZZnh920jFTxknLAE6V+JCmTZf885dSDCzfD8bMX9yerwhUkZ6pu5v4iHIWQ
	 KxODHBa0cwE9A==
Date: Fri, 6 Jun 2025 14:12:27 +0100
From: Simon Horman <horms@kernel.org>
To: "Xandy.Xiong" <xiongliang@xiaomi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: add support for platform specific config.
Message-ID: <20250606131227.GF120308@horms.kernel.org>
References: <20250606114155.3517-1-xiongliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606114155.3517-1-xiongliang@xiaomi.com>

On Fri, Jun 06, 2025 at 07:41:55PM +0800, Xandy.Xiong wrote:
> This patch adds support for platform-specific init config in the
> stmmac driver. As SMMU remap, must after dma descriptor setup,
> and same mac link caps must init before phy init. To support these feature,
> a new function pointer 'fix_mac_config' is added to the
> plat_stmmacenet_data structure.
> And call the function pointer 'fix_mac_config' in the __stmmac_open().
> 
> Signed-off-by: Xandy.Xiong <xiongliang@xiaomi.com>

Hi,

I think that there needs to be an in-tree user of this callback
for it to be added. And that such a user should be included
in the same patch-set that adds the callback.

Moreover...

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

-- 
pw-bot: changes-requested

