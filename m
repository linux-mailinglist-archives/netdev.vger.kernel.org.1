Return-Path: <netdev+bounces-162178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB343A26069
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ABD1656BC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9120B1FC;
	Mon,  3 Feb 2025 16:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253E2036EC;
	Mon,  3 Feb 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600934; cv=none; b=GZ/ZzJXTLHSuZ/z88yjybcazCvRMhzOP0kkGQkHxi9i5aDniGnMyzLXBL0U8BxypHKNRjPQ8JyphxBd5/35setShzVgdzAIoOQZlArekgaTFkRvlst6BUFcxtlpCqjP5+FkCSslfRB8KMPQVidkyFKx/tx4Yllc6WvpSEluHO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600934; c=relaxed/simple;
	bh=xqV6i7J6tISl7E32MSFLSk/tQrtqPimolcbti7y4dYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMRpAEB4miVp0xgTunuA1Cgs7z0oIIyVlgxgN8tHnqx871oN+NtHv63pFzn80LxpF5TbZ2YZlNKBehAMQ2O+cctDJIeg30cv9TVuBVrKXCsvc2W3xQw4WfA3Lzs8j/hXytZRs1DAx+VnFc2eh6fT1CFE68ppDsWoYAuNazdalBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.10.14] (dynamic-176-000-013-018.176.0.pool.telefonica.de [176.0.13.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C83C061E6478A;
	Mon, 03 Feb 2025 17:41:15 +0100 (CET)
Message-ID: <32579b22-a213-4e97-a816-66d0bb301f92@molgen.mpg.de>
Date: Mon, 3 Feb 2025 17:41:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] net: e1000e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250202170839.47375-1-piotrwejman90@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250202170839.47375-1-piotrwejman90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Piotr,


Thank you for your patch.

Am 02.02.25 um 18:08 schrieb Piotr Wejman:
> Update the driver to the new hw timestamping API.

Could you please elaborate. Maybe a pointer to the new API, and what 
commit added it, and what tests were done, and/or are needed?

> Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
>   drivers/net/ethernet/intel/e1000e/netdev.c | 52 ++++++++--------------
>   2 files changed, 20 insertions(+), 34 deletions(-)


Kind regards,

Paul

