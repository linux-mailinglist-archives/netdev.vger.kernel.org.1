Return-Path: <netdev+bounces-12903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A67396E2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BA62817E8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3441FC6;
	Thu, 22 Jun 2023 05:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFC17E0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:37:21 +0000 (UTC)
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 22:37:18 PDT
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBAB1BC3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:37:18 -0700 (PDT)
Message-ID: <f6670c07-e74c-5a08-aca9-4fe9b0df1b6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1687411667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3cuEUtIKpAwkocZiKXgxM2cGh8M3wkSOHpMOxpe36I=;
	b=qtIvtezbJ9Q3ZCP98FmxaORDc5/91HWUcpafIMUicDY95cBFaFfVwiSxEO0wu2rhdaH3UG
	rRyQanJfxdlGl0H1DA3DhW2Uhpx90bRviXBz+j4QEL4KSlvS8PxrtJId2dubuWXMraMxiR
	JVxxCzFY5T9DTyGCioFGIusiK6ioTWg=
Date: Thu, 22 Jun 2023 13:27:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] RDMA/rxe: fix comment typo
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Kalle Valo <kvalo@kernel.org>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <20230622012627.15050-2-shamrocklee@posteo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230622012627.15050-2-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/6/22 9:26, Yueh-Shun Li 写道:
> Spell "retransmitting" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Thanks.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 26a20f088692..aca0f4c7a5cd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -237,7 +237,7 @@ struct rxe_qp {
>   	atomic_t		skb_out;
>   	int			need_req_skb;
>   
> -	/* Timer for retranmitting packet when ACKs have been lost. RC
> +	/* Timer for retransmitting packet when ACKs have been lost. RC
>   	 * only. The requester sets it when it is not already
>   	 * started. The responder resets it whenever an ack is
>   	 * received.


