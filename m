Return-Path: <netdev+bounces-122858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4A962D49
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3901DB2146D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3771189B91;
	Wed, 28 Aug 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmnBeSl4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60213BC1E;
	Wed, 28 Aug 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861252; cv=none; b=oYJJwqgYjOX3HlTw2h3abvZhT/uDQZwqVKRW4W/UR0J32YbSfE8SVyODg1j6fHshNUplt7CMn63J5gADJkmaQzgSAKGLCYr5US+jlU2oTq/DUSEDoBNVSw6dT1E4DD+wj+pRQT6nBXwptomgNc2h1cUrNx+R/+s9cFhBCsTqbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861252; c=relaxed/simple;
	bh=IWfBclkonLHDcbTq6BLRBAov6Ps+vyKmUnlxChd+4/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SK3j6EQsq8sI1vjTNKWVpiXCYgkh33M+yprkvZhaRIJS5y1iNakDE7m7uC5fYcBxWtFJ4wVMKD33cw+/R1i7JvRApTedA69TRfOC4QBXT6+Vc4kfStGhtOnDhRmm3sKsFMY9u41GJwVqrOCjXR9YnpfLBohD7udC1JkKvs7ANVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmnBeSl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5865BC4CEC1;
	Wed, 28 Aug 2024 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861252;
	bh=IWfBclkonLHDcbTq6BLRBAov6Ps+vyKmUnlxChd+4/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XmnBeSl4C6MlhftrenyXGJ9W+bcKtzXNB+r99+nCOWmMWT8lQ3pyr33RdGuVfkaw9
	 Y1CHZgxxoTl0ZauIiwDpSEcgYMp7yhlXlmSyeyY4wnUs1wXdzTgtc3iZvxyvzLRhwX
	 u7fEaF2mtFT44XVQtSajad4ZPlL6rvpN3PW868OcI+IfIC4fpZMaLJ5snSS2nGa2Hg
	 SpLWHsVzJM32Ux3NykRbZFKhgcsun7bkU2JrJyM4C5cwJt9D0bZ/Rv0V6SNvPBT+Gf
	 v6atsDBVMWID0ISalAVnD5mCi83hGEG8S7i6WkgWYD7YGvB9MtWY/ZT363jYJc1RXT
	 ePZHPR1SFUqzA==
Date: Wed, 28 Aug 2024 17:07:28 +0100
From: Simon Horman <horms@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>, Hongbo Li <lihongbo22@huawei.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
Message-ID: <20240828160728.GR1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828121551.3696520-1-lihongbo22@huawei.com>
 <20240828084115.967960-1-liyuesong@vivo.com>

On Wed, Aug 28, 2024 at 04:41:15PM +0800, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>  drivers/net/ipa/ipa_power.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 65fd14da0f86..248bcc0b661e 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>  
>  	clk = clk_get(dev, "core");
>  	if (IS_ERR(clk)) {
> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
> -
> -		return ERR_CAST(clk);
> +		return dev_err_cast_probe(dev, clk,
> +				"error getting core clock\n");
>  	}
>  
>  	ret = clk_set_rate(clk, data->core_clock_rate);

Hi,

There are lot of clean-up patches floating around at this time.
And I'm unsure if you are both on the same team or not, but in
any case it would be nice if there was some co-ordination.
Because here we have two different versions of the same patch.
Which, from a maintainer and reviewer pov is awkward.

In principle the change(s) look(s) fine to me. But there are some minor
problems.

1. For the patch above, it should be explicitly targeted at net-next.
   (Or net if it was a bug fix, which it is not.)

   Not a huge problem, as this is the default. But please keep this in mind
   for future posts.

	Subject: [PATCH vX net-next]: ...

2. For the patch above, the {} should be dropped, as in the patch below.

3. For both patches. The dev_err_cast_probe should be line wrapped,
   and the indentation should align with the opening (.

		return dev_err_cast_probe(dev, clk,
					  "error getting core clock\n");

I'd like to ask you to please negotiate amongst yourselves and
post _just one_ v2 which addresses the minor problems highlighted above.

Thanks!

On Wed, Aug 28, 2024 at 08:15:51PM +0800, Hongbo Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/ipa/ipa_power.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 65fd14da0f86..c572da9e9bc4 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -242,11 +242,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>  	int ret;
>  
>  	clk = clk_get(dev, "core");
> -	if (IS_ERR(clk)) {
> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
> -
> -		return ERR_CAST(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_cast_probe(dev, clk, "error getting core clock\n");
>  
>  	ret = clk_set_rate(clk, data->core_clock_rate);
>  	if (ret) {

-- 
pw-bot: cr



