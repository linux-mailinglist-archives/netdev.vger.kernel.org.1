Return-Path: <netdev+bounces-54832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417380874F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26B21F221C6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EBF39AE1;
	Thu,  7 Dec 2023 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W1tmbvh6"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA1A9
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:04:49 -0800 (PST)
Message-ID: <9d6ea286-0301-4bd9-8c67-790a12a7198b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701950685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugDhUqiMhHXg7FOyCTGZjVpconkGe6k6hfHc+Gvozvs=;
	b=W1tmbvh61rg9dYQNhUvjJC0nzFGFqw+3gVIq2jSK8sbYLSyPv/DzDK0QUgvU8GV0DHvr87
	CyKQBo+PT+CE1AUSmVFsueg8TOzmhicc6ndhnSFNNhWwEbQoPHsPzxL1n/0Oux51cKy69C
	vVJzUdusAXJqWYjGeTAIc2bDl8D9kc0=
Date: Thu, 7 Dec 2023 12:04:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 0/4] bnxt_en: Misc. fixes
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gospo@broadcom.com
References: <20231207000551.138584-1-michael.chan@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231207000551.138584-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/12/2023 16:05, Michael Chan wrote:
> 4 miscellaneous driver fixes covering PM resume, SKB recycling,
> wrong return value check, and PTP HWTSTAMP_FILTER_ALL.
> 
> v2: Fix SOB tags in patch 1 and 3.
> 
> Kalesh AP (1):
>    bnxt_en: Fix wrong return value check in bnxt_close_nic()
> 
> Michael Chan (1):
>    bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Hi Michael!

What about reconfiguration part? I thought this fix was the only
blocker to remove bnxt_close_nic/bnxt_open_nic logic.

> 
> Somnath Kotur (1):
>    bnxt_en: Clear resource reservation during resume
> 
> Sreekanth Reddy (1):
>    bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 ++++++++++++++++++-----
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h |  8 ++++++-
>   2 files changed, 29 insertions(+), 6 deletions(-)
> 


