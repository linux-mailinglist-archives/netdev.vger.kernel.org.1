Return-Path: <netdev+bounces-125024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3E96B9B8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A00B20B94
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58F1CF7A4;
	Wed,  4 Sep 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i2/L1mbC"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF66126C01
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448303; cv=none; b=CI6c+ttC1B6oXNmrnjEkfJykdCa1QeiySTrvTUET9QmS4qDoDlcNUDyBWK4yKHZtOZoWmSj1nwaxfqAFTnnv01ppOmYJ6t5wVNB0SHzwZddSmxsb0PzcmAmm5X+lmh+W5Y4/pPHTtanuc2IPpunOC8P38JnSE1LkA+0jIkDc+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448303; c=relaxed/simple;
	bh=6p/NFo/tFcfm4N94Q16yQt6X8yU/GtpzPyPRA714AqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jws3s04dwFV83XtgpqjqKtshjO4i2bxNhwN2VQkiwdtoyHbSowYwTmWZuZuRjtgcgDch4I+UAtZ+xFHiPZKGaZCQbAzts9j+E2RLencluLdW4a9VBKG3yyA2S96+5V9s+KjHNb4oEg2pj3SPILODe0gCwYWOUUyLsShhFRqGrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i2/L1mbC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc1afd33-c903-46ca-ae4f-4e9a1c037023@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725448299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0lV2xUFA9FxvbBRu83mg1/QrC+Ss19qIVjlT1geGEY=;
	b=i2/L1mbC02gPVhnDAHEINZ4E7ISvPWzp1v/q/oWWrdcQjFI9K83u5qLsGKAR1h4sWlB3MA
	IU8hK6V/ZrfS2E4uy4bDSGSdtzBMZCQG04i58qU7JBW1vo3TnmkEqh4eTjYkpoKe42qIVE
	uY4/LzYhue9fDbqDl6V/trGB2x/GQ2s=
Date: Wed, 4 Sep 2024 12:11:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
To: Martyn Welch <martyn.welch@collabora.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904105143.2444106-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 11:51, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

If there will be v4, please, put yours SoB as the last tag after all
other tags.

Thanks,
Vadim

