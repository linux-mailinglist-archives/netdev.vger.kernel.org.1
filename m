Return-Path: <netdev+bounces-137759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE89A9A53
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B41F22859
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9D3146A71;
	Tue, 22 Oct 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy9jfMmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46676811F1;
	Tue, 22 Oct 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580278; cv=none; b=oN9jQkNfFImN/3QyI+/kCj0Bj+dH4bZghxUsVJU12g3djxqbeLJpDcYpJBlERCzRTUc7mLbgFXkIuOVXWJra6x801WUDE5ipN6SpXRZr1yj2E1KIYTjN/IUOxbW2YQx3c1ZrH+5xSbSwBR2nYiYwbeTPWA/hVfEZjUqCgYcx50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580278; c=relaxed/simple;
	bh=/0oTRbbCrRR3m3IvTcP6qR4M0URH8MiqgGhT9X/zdAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7urCFemlchkqH8Ws7+TJdtstjAkfbGiRF0Y13vt8733swDlzsl/q0RHi/ULNehmxpeY1TNqVCPoNa0UmZMtC578PbvIsowCNtbLsD7EKsCdJuGcZsyTYwUfoY7Zlrg3oHyIjRh8e0fClle0n7zmzekzVNKZu+JHR+yf1bUNmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy9jfMmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C067C4CEC3;
	Tue, 22 Oct 2024 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729580277;
	bh=/0oTRbbCrRR3m3IvTcP6qR4M0URH8MiqgGhT9X/zdAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fy9jfMmbR6rjhFUuxvoRx2g1TemkpeB/NHM4Hr91jmHdE+lnUNo3fxdl6QFFImy1M
	 HTYeaMeduvjzUoeChSkVspz0dH9SGRQKceUnzmFPu0CeRtg6ZjxW7VReUMLo9nk4wq
	 dnkbVDM/LH2YRjnf6F9VdzcZEoSHjwsK7T0cBKvv1GlAzjqREXWw+38LtCOGtbhh6e
	 bEDCbARaMjExVH/P6tVKPLdmFWDzvNcFIHRokEsw5L1W0HhUHFZOFh9seyFXs9H5n+
	 m0GMpkIUxWClPSQ7hhoCIg5Pad0n8yHAjeuvskakIRbIBDdfvUVzoSJKe8Fmx2df1F
	 liujSehUEh+fQ==
Date: Tue, 22 Oct 2024 07:57:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2] net: ftgmac100: refactor getting phy device handle
Message-ID: <20241022065753.GN402847@kernel.org>
References: <20241021023705.2953048-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021023705.2953048-1-jacky_chou@aspeedtech.com>

On Mon, Oct 21, 2024 at 10:37:05AM +0800, Jacky Chou wrote:
> The ftgmac100 supports NC-SI mode, dedicated PHY and fixed-link
> PHY. The dedicated PHY is using the phy_handle property to get
> phy device handle and the fixed-link phy is using the fixed-link
> property to register a fixed-link phy device.
> 
> In of_phy_get_and_connect function, it help driver to get and register
> these PHYs handle.
> Therefore, here refactors this part by using of_phy_get_and_connect.

Hi Jacky,

I understand the aim of this patch, and I think it is nice that we
can drop about 20 lines of code. But I did have some trouble understanding
the paragraph above. I wonder if the following is clearer:

  Consolidate the handling of dedicated PHY and fixed-link phy by taking
  advantage of logic in of_phy_get_and_connect() which handles both of
  these cases, rather than open coding the same logic in ftgmac100_probe().

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - enable mac asym pause support for fixed-link PHY
>   - remove fixes information

I agree that this is not a fix. And should not have a Fixes tag and so on.
But as such it should be targeted at net rather than net-next.

  Subject: [net-next vX] ...

The code themselves changes look good to me. But I think the two points
above, in combination, warrant a v3.

-- 
pw-bot: changes-requested

...

