Return-Path: <netdev+bounces-139083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB89B014B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE7AB23E27
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7461206971;
	Fri, 25 Oct 2024 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz6rKB7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C9201019
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855528; cv=none; b=csXbFTPeJMxOZYkaAgSaubTeYBBp90IF7BsA0TTBioPLTMVnlbqIcdNEq09H5uS7F5yCo7cFDQdI7oh83PbQBsA8RlRSsIMPDAX5BSG6v++gaXWqr1LiEQcI6on2vDl57oqR/J97XGqU9aOekCMj1oVEcxB+DGJ3p82ipVn4yWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855528; c=relaxed/simple;
	bh=kKl4uyoJyO8HF7Pp2IPqDXA6zmsTZxpHVg68f+2r084=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icuSMhEginEPZ8ixRwiFknBu38w/IfVtV1WXHElVzDysEvpiEuE3ybDei/TyhKUyvsjEh7Rs0MUDgjwguheCidupiVgc4XaHD+JIFXox+9Vy5sunP4TmkQTLLqgXNBWMhSmQa5Z5IfzbKWKXJyd36wXtFMSerApj7wkKMwEtO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz6rKB7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ED4C4CEE7;
	Fri, 25 Oct 2024 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729855527;
	bh=kKl4uyoJyO8HF7Pp2IPqDXA6zmsTZxpHVg68f+2r084=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zz6rKB7Hquug7HmZsm2q4xGnCqSkPpUSqTYYui4K+iMJ7QzmMZ0vihvreCHhKickr
	 1gkAW8ftVpayUT9X0eQg6U8E1G+CESxfvLCdEWqHBoy/ANTdNwiWk02374o8nM7EQB
	 QWm1S1vXkFGjrxw7NW2u/EGaAMqDZlQhxOwCXYaghBLXMf7hF74kbM6NTln2LTitKP
	 Al2uH+wQg3RUmDrampR6c+GZZWirjAh1Dyr0vATGBcoh9dAh6dXmjDtAmKhobCfG2f
	 Ux3+8Z5yVgGBWBkPIUno7tykbSaQxzz9fwGHHsdInj/0LsBCuOJKe4IEF8YYRRGbDk
	 5rflShsRZVIRA==
Date: Fri, 25 Oct 2024 12:25:23 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for RTL8125D
Message-ID: <20241025112523.GO1202098@kernel.org>
References: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>

On Thu, Oct 24, 2024 at 10:42:33PM +0200, Heiner Kallweit wrote:
> This adds support for new chip version RTL8125D, which can be found on
> boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
> for this chip version is available in linux-firmware already.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c

...

> @@ -3872,6 +3873,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
>  	rtl_hw_start_8125_common(tp);
>  }
>  
> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
> +{
> +	rtl_set_def_aspm_entry_latency(tp);
> +	rtl_hw_start_8125_common(tp);
> +}
> +
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)

Maybe as a follow-up, rtl_hw_start_8125d and rtl_hw_start_8126a could
be consolidated. They seem to be the same.

...

