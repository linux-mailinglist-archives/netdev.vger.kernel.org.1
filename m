Return-Path: <netdev+bounces-48888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EA7EFED1
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7412C281007
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCD101D0;
	Sat, 18 Nov 2023 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnhxdUey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7410948
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 10:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A807AC433C7;
	Sat, 18 Nov 2023 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700302013;
	bh=D20eX3kAOzsYMVmXN55tMS6aMwqF1t9X07PsAzLwSnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pnhxdUeyyMevW6TjVYlxtHrbGX8cc1gAAXEl9G5Gw5Ht1QmHnWDbO5auzF2e5EiKh
	 pruSqHwm/9IlBB0Fj0wmzSrmWsIgQyJ8YIUGpTzm3UDD5FoBx/hAl1n6Hoc/EqkrHg
	 vE9OPcFQwpZEL0voDlI63bSG9TRo6WqCps+ymdz2umCxcqh1eFxXuKFXJjxCkX6sPD
	 eW+S/6OfrU7iZL7akW29L18NisU0Y8ayENproyilBIL0vgh7jFfgDjJ9d53rXA0lEs
	 0f4DDvCcpLQ7GEZYJ4RtGYXO6gl8cyKoAoEKmETSHP5R/hYA+Twz9qokirPqToBDck
	 0gS7Lnn1pk0uQ==
Message-ID: <24c7b507-f5f5-4b67-8bc3-d70f781c21c8@kernel.org>
Date: Sat, 18 Nov 2023 12:06:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] net: ethernet: ti: cpsw-new: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Marek Majtyka <alardam@gmail.com>,
 Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
 netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-7-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231117091655.872426-7-u.kleine-koenig@pengutronix.de>
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

