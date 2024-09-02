Return-Path: <netdev+bounces-124120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF296828A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15EC1F23212
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDF18732D;
	Mon,  2 Sep 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwqhrfbt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F17186E29;
	Mon,  2 Sep 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267422; cv=none; b=b8PvJ79iyf/TiaE3X3QeDSyfjrUvqOUvci/78r/t7YqYG5jUhWLNGlC2H4mWwqIxjZnXzOtr/JzxgK0D7kCNEk16CAohmDxoD81KefZglwr9FgPYXriYBQ2yz5/aA0f7QCewgxYxtMV/uP/7D5wOCIkjDotI03fAe4jic5hoPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267422; c=relaxed/simple;
	bh=NBrqVYyIOngsPMawBZmknoPAorbszVTUH1n0VupmjMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8lpTHqseF/e+Kx6vHq+baMyp14VQp+Uc+6PzuvWhW4OJ5V/A/bGxalaANnfE59hPR85KwTq/7x3ebqhxZ0509TZRQ9ETCY8cQOtgVgWQyFIwc/1Sd6BZQDMAjmhOCrfm3hbbiLAS9PUakMi7+2OxNhXUnkqye+6J99HL0b9T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwqhrfbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FB2C4CEC8;
	Mon,  2 Sep 2024 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725267421;
	bh=NBrqVYyIOngsPMawBZmknoPAorbszVTUH1n0VupmjMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwqhrfbtCs2cSbf6Pcp64+4zcmntyPN6qUIbfyxxTVjP/UvhJ3mnB06+X30RoLLXO
	 sf+Ls+xnfP9iwMgqHlDjAntNdg8dBmZDI3DGQX2KopIUsPFyT4wEYot64hevIfZGvI
	 d6AG/YnaIALJ3Gam9egnBRe1UXrHud9VodJEVjCaPLWH+8lxZiXgpN1pEHhwnjvZWM
	 7BgM4/yBM7+UFBaEE3nAhkWbK9fO4W8e7rlYtGpI6gZfF8ZcgDQxTO79tVD1sUeOVH
	 cTnHw1ibp9l0O+DtB4KB8H5x/c1izvK2JCz8tKlyrSURD+qRb3Vsm4NG5VBoTpde+e
	 SVUFJUDubgmDg==
Date: Mon, 2 Sep 2024 09:56:57 +0100
From: Simon Horman <horms@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lihongbo22@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v2] net: ipa: make use of dev_err_cast_probe()
Message-ID: <20240902085657.GE23170@kernel.org>
References: <20240829030739.1899011-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829030739.1899011-1-liyuesong@vivo.com>

On Thu, Aug 29, 2024 at 11:07:39AM +0800, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> v2: https://lore.kernel.org/all/20240828160728.GR1368797@kernel.org/
>   - fix patch name
>   - drop the {} and fix the alignment

Thanks for hte updates.

I note that this code is in a probe function,
so this patch is an appropriate use of dev_err_cast_probe() [1].

I also see that it addresses the feedback on code style from v1.

Reviewed-by: Simon Horman <horms@kernel.org>


[1] [PATCH] net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"
    https://lore.kernel.org/netdev/20240830170014.15389-1-krzysztof.kozlowski@linaro.org/

...

