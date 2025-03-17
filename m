Return-Path: <netdev+bounces-175428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB3A65E44
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EBF189C035
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBD1EB5C0;
	Mon, 17 Mar 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJY6pWHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6AF9DA;
	Mon, 17 Mar 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240595; cv=none; b=F1fvXAvyLvSmE2coiwpfH+jjFMbsihlzyMXKyvjPDgUr4Cpncs5GbTmf/56jTKp5P17ttyBqhNvSksFY999iCQP6SMJWccJGQjiVscSTByFl55s5ivbi1zUHqyynRII/r0YqhR8+p3TzdiuipHvFQrOWxP0ec9rUKHqrC4x7ifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240595; c=relaxed/simple;
	bh=t//6P/q0t8jIMHBT9W/8mr8iVb+RwiE/dM2UG+3+3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhyzWqlRKHjzRMFgQUYnIbLFml0PRVe0DoXt39pkX793WhV+14MvJuz4XOdAZKDG+Eiu/Q85RL12/HKVbQvekSmLnpzTSWPQausjPYUyHJTkeIBulEXPG5JP0bXBe3o+VMIH1QqsU/TQcK43o0qCsAHIOpQerKd9JX/2ICbSpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJY6pWHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D6DC4CEE3;
	Mon, 17 Mar 2025 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240595;
	bh=t//6P/q0t8jIMHBT9W/8mr8iVb+RwiE/dM2UG+3+3rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJY6pWHAHjA8xrZ/5+VUjB1jqkwWQCAceb0D2Kx7WuOa/IeJcN7gAg8gWrxfY0F1U
	 SQZR5hMLDYoUm3n3eaILBNSY9qtWVg0N9pX7wa3so9kHRslCGuR3KWEY0Pk9v6L4/R
	 Pk6sPCllY/LZHOwZiQshkmDf7C6W+czCc5B5pWBzEyKE66h+B/12eIcXSNG7gQ02OX
	 m2Mkk7MVV+5O3/at5i9/MO48RkGLWyWcXIActOkWOt1ZX2GuZnQTGMx4OaiF4GThWu
	 Mt3ks+Uhjwnvj62d3ra1dt7drBybKMgcoW1xBqFO77B66t/jFOTmo0LhKw1uDI72XB
	 HUCK9E2oZZBOQ==
Date: Mon, 17 Mar 2025 19:43:09 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] net: stmmac: dwmac-rk: Add GMAC support for RK3528
Message-ID: <20250317194309.GL688833@kernel.org>
References: <20250309232622.1498084-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309232622.1498084-1-jonas@kwiboo.se>

On Sun, Mar 09, 2025 at 11:26:10PM +0000, Jonas Karlman wrote:
> The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
> used with the integrated PHY and a second 1000/100/10 MAC to be used
> with an external Ethernet PHY.
> 
> This series add initial support for the Ethernet controllers found in
> RK3528 and initial support to power up/down the integrated PHY.
> 
> This series depends on v2 of the "net: stmmac: dwmac-rk: Validate GRF
> and peripheral GRF during probe" [1] cleanup series.
> 
> 
> Changes in v2:
> - Restrict the minItems: 4 change to rockchip,rk3528-gmac
> - Add initial support to power up/down the integrated PHY in RK3528
> - Split device tree changes into a separate series
> 
> [1] https://lore.kernel.org/r/20250308213720.2517944-1-jonas@kwiboo.se/

Hi Jonas,

This patchset looks reasonable to me. However it will need
to be reposted once it's dependencies ([1]) are present in net-next.

And on the topic of process:

* As this is a patch-set for net-next it would be best to
  target it accordingly:

  Subject: [PATCH net-next] ...

* Please post patches for net/net-next which have dependencies as RFCs.

For more information on Netdev processes please take a look at
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: deferred

