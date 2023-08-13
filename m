Return-Path: <netdev+bounces-27120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D277A69E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1B1C2091B
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282956FA2;
	Sun, 13 Aug 2023 13:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5D2C9D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 13:49:25 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393521713
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:49:23 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99c3ca08c09so107024266b.1
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934562; x=1692539362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laC9Heu+PxM1xbW39+7mo/8Y5DzPUSwDc3BGUaOBbmw=;
        b=AEYBvcW+rO+coOGWs6Q/IphJ3qn7+BGy8hpcguPxDb67v76M6fOZXqNjPbTKK1iR9c
         HM9zQiO1WsDZUTv9uv0xvg4invV2JSx9CilLd3jyW0nKjyPdRbVOenLIPdTQdjkr28g3
         8ZGBERbCfGmEFzTdhSLhfvKu/H76L/RsTYWUbjkG8GKGw3hzc6363zo6xmUH68xfU3RC
         3CHM7EksBD3d1d77pgcpQSFrovubvAFBWB4yLf04w36f8mUoVh7ZIwG1T9AOoEaeDt1+
         AWG504AGlbzy++26G1ua1JdsR7FnrC/5sb4Mw1mYZwgwNa13S4C+8I6/X0mC+SuyJl07
         GiWA==
X-Gm-Message-State: AOJu0Yz4RilkPG4NHqDwBiZ+ztoyfpdFki5uphrQESXhUWOukQW7mUQ8
	z2DzG+dJZi9arkkC4kI13Dg=
X-Google-Smtp-Source: AGHT+IF7YUIGxUwudcL7olJnfZ7dnFAbfY3wg3aeVc52XCo2hdrzB3VZvXXBiijHMtnvpjFFtlF2Yw==
X-Received: by 2002:a17:906:c1:b0:99b:c845:7917 with SMTP id 1-20020a17090600c100b0099bc8457917mr5731425eji.4.1691934561592;
        Sun, 13 Aug 2023 06:49:21 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906379300b00992b8d56f3asm4563706ejc.105.2023.08.13.06.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:49:20 -0700 (PDT)
Message-ID: <6711898d-915b-b799-e9dd-2b1c1ee3ec34@grimberg.me>
Date: Sun, 13 Aug 2023 16:49:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-10-aaptel@nvidia.com>
 <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
 <253msyzvtph.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253msyzvtph.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 17:48, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> grr.. wondering if this is something we want to support (crc without
>> ddp).
> 
> We agree, we don't want to support it. We will remove it and check it
> doesn't happen in is_netdev_offload_active().
> 
>>> +     req->ddp.sg_table.sgl = req->ddp.first_sgl;
>> Why is this assignment needed? why not pass req->ddp.first_sgl ?
> 
> Correct, this assignment is not needed we will remove it.
> 
>>>    static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>>> @@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>>        size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>>>        int ret;
>>>
>>> -     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
>>> +         test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>>
>> This now becomes two atomic bitops to check for each capability, where
>> its more likely that neighther are on...
>>
>> Is this really racing with anything? maybe just check with bitwise AND?
>> or a local variable (or struct member)
>> I don't think that we should add any more overhead for the normal path
>> than we already have.
> 
> Are you sure test_bit() is atomic? The underlying definitions seems
> non-atomic (constant_test_bit or const_test_bit), are we missing
> anything?

Hmm, no you're right.

This makes me wonder if we have some places to convert test_bit to
test_bit_acquire where we must not make forward progress.

This particular condition is fine I think...

