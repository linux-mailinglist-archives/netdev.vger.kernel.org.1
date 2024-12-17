Return-Path: <netdev+bounces-152657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCC9F5124
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B92163D85
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B614A0A3;
	Tue, 17 Dec 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/HJ9a1x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00C13D891;
	Tue, 17 Dec 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453343; cv=none; b=QwA2MvwnBoMy0F+COMvGwLmJJgWvmmFC+WTIAs4FLyGCWnAGw1fXjqFvfhuL/cYBJQG0x62dlP1j2P4P7DDHT1fnz1M1IJ8lDwMRaUlYWuA2IpCdK4tzqFjpYA70OL3J9sghuWaRKDgKsF+SEP09LSYhPnFnMM53v1oF1yiwRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453343; c=relaxed/simple;
	bh=/dZtUTdnhLYhG2L/43KFiQTEBTs+21tdyBzFD6hhoH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVumrk9Tl3fHI6MgE9/xcFv9EPLMeiZl+kBGeqf6YiqoCyYGFChVMheyeHOIyOVfem36b0axqHyU5oq4+ZSSzNqIj9zKp3BF08ruIW1iDp2yi5rVlFS47JixO8O5zkEGWnOEoLtao6M8UlO8MjQeBbx8/eD9AQO3A6AfQBeacS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/HJ9a1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79154C4CED3;
	Tue, 17 Dec 2024 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453343;
	bh=/dZtUTdnhLYhG2L/43KFiQTEBTs+21tdyBzFD6hhoH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/HJ9a1xQl8pF07zs+jiCgA6Ufn65F22qQK2hTSdMKozssSiT1/9snJXgjLg6HMg4
	 IWS2JUmyPB0Rq0waxl552ll3jjafAXmFEeXgfUZrT3sdkzDpLfSEMbVNy1F+TVr3e3
	 NqzfanoZS0C8SS9IHKCwlFdJ8w11F+5xfX+tKWhyZRxs6l9rQixJrbU5oEugFTPUHK
	 n90ZUuKrGQLZVs1eqjts+B5w1WY97NEG6hoTf5vL3u4JLLv29nQfQbg+Df/wnKcsg4
	 B8NUl8T6kkv1TSH58s6VgEzaetgMO89x6TTzuKhFwfuGW0S3SCbSuUzE7gaP1XTCev
	 MtYElsT79HriA==
Date: Tue, 17 Dec 2024 16:35:38 +0000
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net v1] net: stmmac: Drop useless code related to ethtool
 rx-copybreak
Message-ID: <20241217163538.GU780307@kernel.org>
References: <20241217091712.383911-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217091712.383911-1-0x1207@gmail.com>

On Tue, Dec 17, 2024 at 05:17:12PM +0800, Furong Xu wrote:
> After commit 2af6106ae949 ("net: stmmac: Introducing support for Page
> Pool"), these code turned to be useless and users of ethtool may get
> confused about the unhandled rx-copybreak parameter.

Hi Furong Xu,

I think it would be useful to explain why the change cited above
renders the copybreak implementation unnecessary.

> 
> This patch mostly reverts
> commit 22ad38381547 ("stmmac: do not perform zero-copy for rx frames")
> 
> Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")

Based on your description this feels more like an enhancement
for net-next, without a Fixes tag, than a fix for net.

> Signed-off-by: Furong Xu <0x1207@gmail.com>

...

