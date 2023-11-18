Return-Path: <netdev+bounces-48887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A47EFECF
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A32C1F2341F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C0101D0;
	Sat, 18 Nov 2023 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAMKSIou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDA6AA7
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 10:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFC5C433C8;
	Sat, 18 Nov 2023 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700302006;
	bh=D20eX3kAOzsYMVmXN55tMS6aMwqF1t9X07PsAzLwSnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QAMKSIounrcGRZfu7U8O3VKjD9wxPNDmotzRLTdv9ezx63FeUlFweY14bFhb2iEig
	 IZ8aK8SBrEQv9v4NE9vKVys8zqMuNW7vZMqXqbv+vy8z2PNVMD/SXXTv8/21n26KFZ
	 yCwbVz8anmy+4RepD2CM/tahH67F+9uTaE0uJbAwTTeSCbQSLvwR4XQl34F4tGJ/83
	 V9JWtJ7aEkPdsbSeewbnt9Yyi3f6ab2MM5G2/oahiu8jnIB4sTgg9rIi1HOjN+pLmv
	 K7FVNnxjhU3uMbu98sPzzk4xNbmSudwWYbiE4oKKyE9ONU5jrZcyAKCUGZKM85sXxO
	 +aE7uROGF89hQ==
Message-ID: <ffdd3f62-de0b-449b-ac2c-1ed9e9e3070e@kernel.org>
Date: Sat, 18 Nov 2023 12:06:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] net: ethernet: ti: cpsw: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Rob Herring
 <robh@kernel.org>, Marek Majtyka <alardam@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, linux-omap@vger.kernel.org,
 netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-6-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231117091655.872426-6-u.kleine-koenig@pengutronix.de>
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

