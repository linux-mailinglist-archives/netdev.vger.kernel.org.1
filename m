Return-Path: <netdev+bounces-48886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFF7EFECD
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A79280FF1
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9B4A1B;
	Sat, 18 Nov 2023 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkGuM98T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606F6AA7
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 10:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B32BC433C8;
	Sat, 18 Nov 2023 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700301993;
	bh=D20eX3kAOzsYMVmXN55tMS6aMwqF1t9X07PsAzLwSnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KkGuM98TNKtju+irvRf6WQf1qcFTtsU4JjjQ6URIL/Ya4g94/9rRy1itlFCNMm+fO
	 5JX9+OiN59Y5eDvsjM31w0mkwfUB/sAgeQ+ZVi7uRvyM9EXEwDV6wI1zJgBAg8M9Os
	 km+rTKL71joVqa9I5Z/rju8SXCJE3jWZZzc0xxPanrcxkdRssUqtwJVtMG+KkTCgPI
	 tQZ7kUneSNvXSP1DSU4M2BmcrWMi+i0OM/wtgL06yfD5nc0BS45Uc/yoBSrX+/+6Ft
	 oNqmvWjmaABCwRPb6UggjQppjFPOKcInOq0kO/zRLp3Gsu7upbssPzavKH1QnAND0p
	 P6hNbgPg5E33Q==
Message-ID: <e109e873-04d7-4f78-ad0b-69077e158ebd@kernel.org>
Date: Sat, 18 Nov 2023 12:06:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net: ethernet: ti: am65-cpsw: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 kernel@pengutronix.de
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-5-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231117091655.872426-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/11/2023 11:17, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

