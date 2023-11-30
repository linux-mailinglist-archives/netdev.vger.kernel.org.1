Return-Path: <netdev+bounces-52441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E57FEBF3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF6C2823F9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFA38F8E;
	Thu, 30 Nov 2023 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8EMU7jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A6374FE
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BADC433C8;
	Thu, 30 Nov 2023 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701337031;
	bh=TdOMiWgyf8Im0dkTqa/TXaHjrcnnjfKxi4zDQeu8+8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8EMU7jUbwgCbd9sdgx3sVwy8g9KsWO5wOasU7nsXMqXyeYd8c66rjSu/J//XxUmV
	 b6gyp3odI0KhsnhJoQ2FvWrnVMun1E2MqMyu5bRyZL4YPhZ0wWBaRhV0mjfhGw8x2f
	 GuFdad8fvw/EpxIfRhtoYjKHWem7WuuO2Hc8jbP9L9SwXP44nXPZ0abupc7opXlPKQ
	 iIqwxOGV8b7bXsJRAX9pU1mOVwK2hARObwTMJD/xx9i20mbF8cxK5IpigW3vbbtKsJ
	 cFjJui6UGTocX5FOOE8oI2NE72+HjBe2UafQx+jDVPU4Lq0L4THPVeQfXKml//8YFY
	 lL44ZrG7NwyUw==
Message-ID: <83430eb6-256b-4247-9dc8-9e5c68ce76a8@kernel.org>
Date: Thu, 30 Nov 2023 11:37:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] net: ethernet: ti: am65-cpsw: Convert to
 platform remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 kernel@pengutronix.de
References: <20231128173823.867512-1-u.kleine-koenig@pengutronix.de>
 <20231128173823.867512-2-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231128173823.867512-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/11/2023 19:38, Uwe Kleine-König wrote:
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
> Replace the error path returning a non-zero value by an error message
> and a comment that there is more to do. With that this patch results in
> no change of behaviour in this driver apart from improving the error
> message.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

