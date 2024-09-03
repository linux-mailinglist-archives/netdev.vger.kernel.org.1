Return-Path: <netdev+bounces-124424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38B196967D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B401C239A7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F028200124;
	Tue,  3 Sep 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDOsb0hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F81DAC5B;
	Tue,  3 Sep 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350799; cv=none; b=D49qD+stCvRdv0KJvU3dnfa9vcygr57eoW969XT6Emw+qjX8KACU5yhh70HFzR2JrwBpRt7Ue2wzIFAFAg1h1lC0iA87c6P+Hwrk90SIxJblZFeZ9nAfMWuDUWm7k8nQLLtRzyjGXnAYsk8ykFhmjBrYs8aqTVrBdEvbpIEs0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350799; c=relaxed/simple;
	bh=FPSKdzfJFcqTa4RBOmYYXszLYpG//OaNcdYMYKMrJ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl5JHVeRQw6/I09zlpBVKRv/ZIPPu289XbN/9kDookR5ujJ5Xe78OnwkDMazGjMtheQPxlk1FhJj3MdMX1BIqGXI/QG2UVNhr+I8W/1WLGFFF1Yp+QMM39FmKYfnFhfUOgYmqKHpxuu2PgZvUyBfwuN/NyV0OpHMsffC9GKn79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDOsb0hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A17C4CEC5;
	Tue,  3 Sep 2024 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350798;
	bh=FPSKdzfJFcqTa4RBOmYYXszLYpG//OaNcdYMYKMrJ6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDOsb0huZ3T2hhVkwI4fJn63/Xj+iDbwtQS473eKXvmbVDnkBzpo+ZKoCxz4F0tkN
	 iC7LSxcZGYqH/l19XebLPLErZKmMvpZlSTcPpJPPJ2yvtlD8dsjHWg1kEf4xWy1xK9
	 1hPpsmLolCCJKDP11AkCEA2i2eozDn+2JkbFwiuONJUCVmwQ6LbF8wtJtrBSn+OUpC
	 aDmXCg6OnP20MhphLVYObhiHShyUq5HFqkSYmho5sx/dSvVJfnwMF9LBKTG21SxGHV
	 XBLUAR+jaFcpPCeCH/JBslnAzTHbDKWvhAD25nBHsczO28BCJqI2azBGmXP3z/tKs/
	 0mKdJ1EGwxOMw==
Date: Tue, 3 Sep 2024 09:06:34 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yang Ruibin <11162571@vivo.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
Message-ID: <20240903080634.GP23170@kernel.org>
References: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>

On Mon, Sep 02, 2024 at 06:36:10PM +0200, Krzysztof Kozlowski wrote:
> This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
> introduced dev_err_probe() in non-probe path, which is not desired.
> 
> In general, calling dev_err_probe() after successful probe in case of
> handling -EPROBE_DEFER error, will set deferred status on the device
> already probed.  This is however not a problem here now, because
> dev_err_probe() in affected places is used for handling errors from
> request_firmware(), which does not return -EPROBE_DEFER.  Still usage of
> dev_err_probe() in such case is not correct, because request_firmware()
> could once return -EPROBE_DEFER.
> 
> Fixes: bf4d87f884fe ("net: alacritech: Switch to use dev_err_probe()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Update commit msg (Simon).

Thanks for the update, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

...

