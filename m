Return-Path: <netdev+bounces-123801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094299668EC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB480282D8F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A51BC063;
	Fri, 30 Aug 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlZ853rd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976171B86E2;
	Fri, 30 Aug 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042528; cv=none; b=GHUaqcahzJ6VoMUJkTa8VPgh3GfzJXuH6rSFjns/5ca7ng0dJig9MEhaPcEIuMALppNFXge6HFyFAHnaUOBeWaRzmyXnOrz3SK+DVoCje3kNKsh8feBlhYKcbxBWL/EXFnG+NgAQDa+mYsXKdOdr7muWDhDVDo5LMXpUXd7zNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042528; c=relaxed/simple;
	bh=E6fwCzsXSX0livYyQ0XkLN3faqcNqRK4JJ7TXEsqspw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2LTbDKQAUr4xvnnAyKJ1njhQZx717nZ9zAdzpMAjbTsEqO8xx+yaqjNRS1hM9A8YKdilEvDpwOJwKcnrF+RqYCeQnwT9rz2fvvV+hv+ldn7Y2NmK1x3pnn9FuLnXcpYQusYE9FYcub1JmYVYpJiP+Z0gXpNCwCVQ486xpCz2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlZ853rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5C3C4CEC2;
	Fri, 30 Aug 2024 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042528;
	bh=E6fwCzsXSX0livYyQ0XkLN3faqcNqRK4JJ7TXEsqspw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlZ853rdFrP5RUKiEFsUsgZ+J3FeEBxzKjbjsAmRIm5LVm9f0a2nY7msuqut6XfX/
	 0cGvS8D/VfMQ2WcETdYtlcsNU3ZdsjcUWWvdGlE+o2cK0XI/wi2OaqEl+tWxoYz1EM
	 MNXRAJGHaBO4IlK/V/a2p3k340ZQlsHMyKof/aVoLPEII4hiiR4OkG33wl4vRTp8MK
	 LYJ70LxgygnJceVQscM/shHAtYScQ20mO7HhzD9Z2pxZkzcGZj+eNd5v/z8GK57Zie
	 Tp/9gfXPAfgtBz8hiGHZe1DXLdGqm4VhmC9pg1li3WZ7YYwPS44egq3J0BpcJedQmD
	 JIQkeZRWnTuAA==
Date: Fri, 30 Aug 2024 19:28:44 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yang Ruibin <11162571@vivo.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
Message-ID: <20240830182844.GE1368797@kernel.org>
References: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>

On Fri, Aug 30, 2024 at 07:00:14PM +0200, Krzysztof Kozlowski wrote:
> This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
> introduced dev_err_probe() in non-probe path, which is not desired.
> Calling it after successful probe, dev_err_probe() will set deferred
> status on the device already probed. See also documentation of
> dev_err_probe().

I agree that using dev_err_probe() outside of a probe path is
inappropriate. And I agree that your patch addresses that problem
in the context of changes made by the cited commit.

But, based on my reading of dev_err_probe(), I think the text above is
slightly misleading. This is because deferred status is only set in the
case where the err passed to dev_err_probe() is -EPROBE_DEFER. And I do
suspect that is never the case for the calls removed by this patch.

> Fixes: bf4d87f884fe ("net: alacritech: Switch to use dev_err_probe()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

...

