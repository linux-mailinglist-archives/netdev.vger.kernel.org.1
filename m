Return-Path: <netdev+bounces-30883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE7789988
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 00:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8953C2810BC
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 22:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBE1094F;
	Sat, 26 Aug 2023 22:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378B100B3
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 22:00:56 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000510D7
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 15:00:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d4dbc7bso1347330b3a.2
        for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693087255; x=1693692055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7azz3BaWWu+Ou6snFanU3MwCuJ71hI8EHjpQM1cE4IE=;
        b=GSeB/sW0UoYLUApkNCvvfK0cJRWinGTGqHVBKVZdcST3cMu3U1ZyVh3m0n0ZGsmoOp
         LRQBDbtxxaWx4g0JsZnMLYnkUYt8pSw8Z1da7sUaCCu8vCGIzoHM+/kNpsYsgZOy/Dys
         AUhH6WddMwh22kMyI2oUqWhbUwKoQOFkk4ujr4KQfRNhCnaJnPBvwCvEJLL6KiTSi3Z/
         7uCLR51BI54rC8HJo1uvhSDl65fUITmmS6axX34Mn6QmqBS2bmgxmXfvQi1anZSGpbKa
         zkfpwXXJqq6SGrjO8imCnleUnZA/Lt+cbe6iv/VliUzIwAb+iQWQb5VjSuZifec6U3Un
         ViUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693087255; x=1693692055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7azz3BaWWu+Ou6snFanU3MwCuJ71hI8EHjpQM1cE4IE=;
        b=YiYlmxIv0OY59Nfp2JDRd3fCJOq8yJLJVlLUaHaQJtQeLttTuW1qX0C3b4JBVO9pMW
         GyoA6MRElF+L89Qrl7Yjzhs8vWMwA1Ggx/x1svoRoUzjpk0clAS7wA0t9ZAlr5hg7DM5
         KbLmnLMULUgryK/vFayhYCn0R1jTirH3k7nZvJ8oLUsmtd3dPGEuYXUWWv9+CaeOQgJ5
         wt0bBPw8iWfcsa2BrPapy/oWc6GVhXJitdQwuvilotfmoHqbG37N3C+ZJCsXGiucPNOC
         GxAvMOPTHGjOTaJtBXlmqRN9TKAmEJlTnjbnFMAfYgNZLLoaKepWNBNpTgsQNJG00e3O
         Mvxg==
X-Gm-Message-State: AOJu0YzvMJae8GSih/QAGL1mWFdnrN3ebjWbbK/B880t/F930nX8rUOS
	VlThLPzt0KUGeoVh5VflpyRdlHinxcmDhMVW3+za+Wyr
X-Google-Smtp-Source: AGHT+IG/m5rR/TeDxkCRcB4UktHPQmER3sjvPuJ2GnXZQmT9g0N72yIOzYo5x5wCyoENyIkJu0ckbw==
X-Received: by 2002:a05:6a00:84f:b0:68b:e801:e34d with SMTP id q15-20020a056a00084f00b0068be801e34dmr11354968pfk.29.1693087255036;
        Sat, 26 Aug 2023 15:00:55 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::176d? ([2620:10d:c090:400::5:17f])
        by smtp.gmail.com with ESMTPSA id m9-20020a637d49000000b0054fd46531a1sm4118630pgn.5.2023.08.26.15.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 15:00:54 -0700 (PDT)
Message-ID: <32b0e155-ce85-609e-8b1f-108f4b1bf59e@davidwei.uk>
Date: Sat, 26 Aug 2023 15:00:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] io_uring: setup ZC for an RX queue when registering
 an ifq
To: David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230826011954.1801099-1-dw@davidwei.uk>
 <20230826011954.1801099-5-dw@davidwei.uk>
 <d307c2a5-3d30-3e86-c376-e1c5faf19683@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <d307c2a5-3d30-3e86-c376-e1c5faf19683@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/08/2023 19:26, David Ahern wrote:
> On 8/25/23 6:19 PM, David Wei wrote:
>> diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
>> index 6c57c9b06e05..8cc66731af5b 100644
>> --- a/io_uring/zc_rx.c
>> +++ b/io_uring/zc_rx.c
>> @@ -10,6 +11,35 @@
>>  #include "kbuf.h"
>>  #include "zc_rx.h"
>>  
>> +typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
>> +
>> +static int __io_queue_mgmt(struct net_device *dev, struct io_zc_rx_ifq *ifq,
>> +			   u16 queue_id)
>> +{
>> +	struct netdev_bpf cmd;
>> +	bpf_op_t ndo_bpf;
>> +
>> +	ndo_bpf = dev->netdev_ops->ndo_bpf;
> 
> This is not bpf related, so it seems wrong to be overloading this ndo.

Agreed. I believe the original author (Jonathan) was inspired by
XDP_SETUP_XSK_POOL. I would also prefer a better way of setting up an RX queue
for ZC. Mina's proposal I think uses netlink for this.

Do you have any other suggestions? We want to keep resource registration
inline, so we need to be able to call it from within io_uring.

> 
> 
>> +	if (!ndo_bpf)
>> +		return -EINVAL;
>> +
>> +	cmd.command = XDP_SETUP_ZC_RX;
>> +	cmd.zc_rx.ifq = ifq;
>> +	cmd.zc_rx.queue_id = queue_id;
>> +
>> +	return ndo_bpf(dev, &cmd);
>> +}
>> +
>> +static int io_open_zc_rxq(struct io_zc_rx_ifq *ifq)
>> +{
>> +	return __io_queue_mgmt(ifq->dev, ifq, ifq->if_rxq_id);
>> +}
>> +
>> +static int io_close_zc_rxq(struct io_zc_rx_ifq *ifq)
>> +{
>> +	return __io_queue_mgmt(ifq->dev, NULL, ifq->if_rxq_id);
>> +}
>> +
>>  static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
>>  {
>>  	struct io_zc_rx_ifq *ifq;
>> @@ -19,12 +49,17 @@ static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
>>  		return NULL;
>>  
>>  	ifq->ctx = ctx;
>> +	ifq->if_rxq_id = -1;
>>  
>>  	return ifq;
>>  }
>>  
>>  static void io_zc_rx_ifq_free(struct io_zc_rx_ifq *ifq)
>>  {
>> +	if (ifq->if_rxq_id != -1)
>> +		io_close_zc_rxq(ifq);
>> +	if (ifq->dev)
>> +		dev_put(ifq->dev);
>>  	io_free_rbuf_ring(ifq);
>>  	kfree(ifq);
>>  }
>> @@ -41,17 +76,22 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
>>  		return -EFAULT;
>>  	if (ctx->ifq)
>>  		return -EBUSY;
>> +	if (reg.if_rxq_id == -1)
>> +		return -EINVAL;
>>  
>>  	ifq = io_zc_rx_ifq_alloc(ctx);
>>  	if (!ifq)
>>  		return -ENOMEM;
>>  
>> -	/* TODO: initialise network interface */
>> -
>>  	ret = io_allocate_rbuf_ring(ifq, &reg);
>>  	if (ret)
>>  		goto err;
>>  
>> +	ret = -ENODEV;
>> +	ifq->dev = dev_get_by_index(&init_net, reg.if_idx);
> 
> What's the plan for other namespaces? Ideally the device bind comes from
> a socket and that gives you the namespace.

Sorry, I did not consider namespaces yet. I'll look into how namespaces work
and then get back to you.

> 
>> +	if (!ifq->dev)
>> +		goto err;
>> +
>>  	/* TODO: map zc region and initialise zc pool */
>>  
>>  	ifq->rq_entries = reg.rq_entries;
> 
> 

