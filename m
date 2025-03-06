Return-Path: <netdev+bounces-172623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB664A558F4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002F5173D53
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CC2135A3;
	Thu,  6 Mar 2025 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mWBugUuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2096249E5;
	Thu,  6 Mar 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297267; cv=none; b=SvdlwCVXFM2YzgBKrgzJwERcSEQ0YFBJnsPyjrJQZ6DrYwy5Zb7UKfPIx4nMjaR6bQ5k/jQVonQZZh8RT1n7LMFuxZDSIa3ZG9r2ThbXovBsn5Bg4HBSBCN91ZAUoTacY7y2jFru9DpOeDLvt8T7lJL7Lwz+ErPFLgGB27F2ZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297267; c=relaxed/simple;
	bh=Gb8LX0FDsLupGyOUwSvKzXTC0OHMDI948YPUXXrpV7k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HTKQ6ED0e8ST0tDFYQnAByAHZeNfJXNsRv6RxvMFkegFtL9yjHQoAs3xq4Pga1pZ3tjKWx5v9M/2dl+m3ZZEd7aZBLh9IvxgCtweH5EhJZQIxEkXxLP/JQPTCLnS57kAnkYXRpf2e4CuU2C3K/xCHrwKKTC2hdzmkzo+JTYqTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mWBugUuD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741297263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogLZAuYeTK3/4DxQxKpS5NhtK0uL51zVQoxAkrY1bR8=;
	b=mWBugUuD92cKAZA0g1fWhmejy6D+0gx+j1JkJJNyP7AZqdfO+gC1rD6xbKped/eNbIufKf
	rEv8Ou+aL2CUSWmiKN5mrd0No3l4TVFv7UwCMH/pJ8josaFzXztiiuWwGxEWgpeSgNtsbV
	DNAq0m4+EzHbCMT4CUNoysz7LNDrSyFo3RhVtpy5hkP3HskAuDzJFyYXXxEtAe7xKtgBUv
	8bh84TgqT65ytOhqqfTBOfV9CwvMx6A2tZ4V42WlQJst30nkG3pyp3XOWv0pD8u/rhLzS6
	CDE3Ah/+COdJw3ETzBPp3221mqy6DXbuWjdmlTe+/oOO7hqaGbYwBQaSa5TGeA==
Date: Thu, 06 Mar 2025 22:41:03 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Use DELAY_ENABLE macro for RK3328, RK3566/RK3568 and
 RK3588
In-Reply-To: <20250306203858.1677595-1-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
Message-ID: <41bb2c8d963e890768bceb477488250e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2025-03-06 21:38, Jonas Karlman wrote:
> Almost all Rockchip GMAC variants use the DELAY_ENABLE macro to help
> enable or disable use of MAC rx/tx delay. However, RK3328, 
> RK3566/RK3568
> and RK3588 GMAC driver does not.
> 
> Use of the DELAY_ENABLE macro help ensure the MAC rx/tx delay is
> disabled, instead of being enabled and using a zero delay, when
> RGMII_ID/RXID/TXID is used.
> 
> RK3328 driver was merged around the same time as when DELAY_ENABLE was
> introduced so it is understandable why it was missed. Both 
> RK3566/RK3568
> and RK3588 support were introduced much later yet they also missed 
> using
> the DELAY_ENABLE macro (so did vendor kernel at that time).
> 
> This series fixes all these cases to unify how GMAC delay feature is
> enabled or disabled across the different GMAC variants.
> 
> Jonas Karlman (3):
>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3328
>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3566/RK3568
>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

As far as I can tell, the RV1126 GMAC should also be converted to use
the DELAY_ENABLE macro, which the vendor kernel already does. [*]  
Perhaps
that could be performed in new patch 4/4 in this series?

BTW, it would be quite neat to introduce the DELAY_VALUE macro, which
makes the function calls a bit more compact. [*]

[*] 
https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develop-5.10/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

