Return-Path: <netdev+bounces-27437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8877C015
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB091C20357
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9399CA49;
	Mon, 14 Aug 2023 18:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF9C12F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 18:55:04 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214DE13E
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:55:01 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so1472683a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039299; x=1692644099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+qKVj0zyb+cMjwfKts43jRjzbPhOnXRRnm1WB8T/Sc=;
        b=B3+J3oR0kYW370tNkXjjraLe2sPAYsbJqoicvvRq4nCfFSZP1PeNfH6Aqj6p5uZ+sO
         ER6tUi7t+mNwnTWKyBLGc3L2ZlKDsZzpmwit+Dl+eAqHsIEzJFTerFzeCWOSH+z0SD/W
         hxnn4q3DI6YEltfhw4/0r4boPXQssmXNRQPbTpINShx/W+HfYVSpjB0ilJMLh9VrEB5s
         DROqQuglpCQFatK43uzQpic3x4xqK1UZGqOV0ezdzEXNbySsFNIWntGWMdGl4L/1JWPD
         qgzEOZcPWLKpisWRrKbo8sWkV8MJk6wwUJV9lvwQUXeP3ms2nI/dZWW1Bsh1Eb5Lpoiy
         TptA==
X-Gm-Message-State: AOJu0YzgYgqibrga3taPf4sVOowcGg5N2sEVUJOQ93PyZNSWwpU8rFnY
	TGQJdHviJ6SeudBH416svCIAAXe4LRY=
X-Google-Smtp-Source: AGHT+IEsV/Ma7ErD8/OwpIaIfxrg++/AWri2zomsw6MDz7IIINax/NOrcKnDF9+jea+aaujaf2Vi0w==
X-Received: by 2002:a17:906:116:b0:99b:d594:8f89 with SMTP id 22-20020a170906011600b0099bd5948f89mr7662340eje.0.1692039299190;
        Mon, 14 Aug 2023 11:54:59 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170907766300b0098e2eaec395sm5970389ejc.130.2023.08.14.11.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 11:54:58 -0700 (PDT)
Message-ID: <bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me>
Date: Mon, 14 Aug 2023 21:54:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <fa07042c-3d13-78cd-3bec-b1e743dc347d@grimberg.me>
 <2538radwqm3.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2538radwqm3.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> +static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>>> +                                             struct nvme_tcp_queue *queue)
>>> +{
>>> +     if (!netdev || !queue)
>>> +             return false;
>>
>> Is it reasonable to be called here with !netdev or !queue ?
> 
> The check is needed only for the IO queue case but we can move it
> earlier in nvme_tcp_start_queue().

I still don't understand even on io queues how this can happen.

>>> +
>>> +     /* If we cannot query the netdev limitations, do not offload */
>>> +     if (!nvme_tcp_ddp_query_limits(netdev, queue))
>>> +             return false;
>>> +
>>> +     /* If netdev supports nvme-tcp ddp offload, we can offload */
>>> +     if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
>>> +             return true;
>>
>> This should be coming from the API itself, have the limits query
>> api fail if this is off.
> 
> We can move the function to the ULP DDP layer.
> 
>> btw, what is the active thing? is this driven from ethtool enable?
>> what happens if the user disables it while there is a ulp using it?
> 
> The active bits are indeed driven by ethtool according to the design
> Jakub suggested.
> The nvme-tcp connection will have to be reconnected to see the effect of
> changing the bit.

It should move inside the api as well. Don't want to care about it in
nvme.
>>> +
>>> +     return false;
>>
>> This can be folded to the above function.
> 
> We won't be able to check for TLS in a common wrapper. We think this
> should be kept.

Why? any tcp ddp need to be able to support tls. Nothing specific to
nvme here.

>>> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>>> +{
>>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>>> +     struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
>>> +     int ret;
>>> +
>>> +     config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
>>
>> Question, what happens if the pfv changes, is the ddp guaranteed to
>> work?
> 
> The existing HW supports only NVME_TCP_PFV_1_0.
> Once a new version will be used, the device driver should fail the
> sk_add().

OK.

>>> +/* In presence of packet drops or network packet reordering, the device may lose
>>> + * synchronization between the TCP stream and the L5P framing, and require a
>>> + * resync with the kernel's TCP stack.
>>> + *
>>> + * - NIC HW identifies a PDU header at some TCP sequence number,
>>> + *   and asks NVMe-TCP to confirm it.
>>> + * - When NVMe-TCP observes the requested TCP sequence, it will compare
>>> + *   it with the PDU header TCP sequence, and report the result to the
>>> + *   NIC driver
>>> + */
>>> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>>> +                                  struct sk_buff *skb, unsigned int offset)
>>> +{
>>> +     u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
>>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>>> +     u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
>>> +     u64 resync_val;
>>> +     u32 resync_seq;
>>> +
>>> +     resync_val = atomic64_read(&queue->resync_req);
>>> +     /* Lower 32 bit flags. Check validity of the request */
>>> +     if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
>>> +             return;
>>> +
>>> +     /*
>>> +      * Obtain and check requested sequence number: is this PDU header
>>> +      * before the request?
>>> +      */
>>> +     resync_seq = resync_val >> 32;
>>> +     if (before(pdu_seq, resync_seq))
>>> +             return;
>>> +
>>> +     /*
>>> +      * The atomic operation guarantees that we don't miss any NIC driver
>>> +      * resync requests submitted after the above checks.
>>> +      */
>>> +     if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
>>> +                          pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
>>> +                          atomic64_read(&queue->resync_req))
>>> +             netdev->netdev_ops->ulp_ddp_ops->resync(netdev,
>>> +                                                     queue->sock->sk,
>>> +                                                     pdu_seq);
>>
>> Who else is doing an atomic on this value? and what happens
>> if the cmpxchg fails?
> 
> The driver thread can set queue->resync_req concurrently in patch
> "net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload" in function
> nvmeotcp_update_resync().
> 
> If the cmpxchg fails it means a new resync request was triggered by the
> HW, the old request will be dropped and the new one will be processed by
> a later PDU.

So resync_req is actually the current tcp sequence number or something?
The name resync_req is very confusing.

> 
>>> +}
>>> +
>>> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>>> +{
>>> +     struct nvme_tcp_queue *queue = sk->sk_user_data;
>>> +
>>> +     /*
>>> +      * "seq" (TCP seq number) is what the HW assumes is the
>>> +      * beginning of a PDU.  The nvme-tcp layer needs to store the
>>> +      * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
>>> +      * indicate that a request is pending.
>>> +      */
>>> +     atomic64_set(&queue->resync_req, (((uint64_t)seq << 32) | flags));
>>
>> Question, is this coming from multiple contexts? what contexts are
>> competing here that make it an atomic operation? It is unclear what is
>> going on here tbh.
> 
> The driver could get a resync request and set queue->resync_req
> concurrently while processing HW CQEs as you can see in patch
> "net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload" in function
> nvmeotcp_update_resync().
> 
> The resync flow is:
> 
>       nvme-tcp                           mlx5                     hw
>          |                                |                        |
>          |                                |                      sends CQE with
>          |                                |                      resync request
>          |                                | <----------------------'
>          |                         nvmeotcp_update_resync()
>    nvme_tcp_resync_request() <-----------'|
>    we store the request
> 
> Later, while receiving PDUs we check for pending requests.
> If there is one, we send call nvme_tcp_resync_response() which calls
> into mlx5 to send the response to the HW.
> 

...

>>> +                     ret = nvme_tcp_offload_socket(queue);
>>> +                     if (ret) {
>>> +                             dev_info(nctrl->device,
>>> +                                      "failed to setup offload on queue %d ret=%d\n",
>>> +                                      idx, ret);
>>> +                     }
>>> +             }
>>> +     } else {
>>>                ret = nvmf_connect_admin_queue(nctrl);
>>> +             if (ret)
>>> +                     goto err;
>>>
>>> -     if (!ret) {
>>> -             set_bit(NVME_TCP_Q_LIVE, &queue->flags);
>>> -     } else {
>>> -             if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>>> -                     __nvme_tcp_stop_queue(queue);
>>> -             dev_err(nctrl->device,
>>> -                     "failed to connect queue: %d ret=%d\n", idx, ret);
>>> +             netdev = get_netdev_for_sock(queue->sock->sk);
>>
>> Is there any chance that this is a different netdev than what is
>> already recorded? doesn't make sense to me.
> 
> The idea is that we are first starting the admin queue, which looks up
> the netdev associated with the socket and stored in the queue. Later,
> when the IO queues are started, we use the recorded netdev.
> 
> In cases of bonding or vlan, a netdev can have lower device links, which
> get_netdev_for_sock() will look up.

I think the code should in high level do:
	if (idx) {
		ret = nvmf_connect_io_queue(nctrl, idx);
		if (ret)
			goto err;
		if (nvme_tcp_ddp_query_limits(queue))
			nvme_tcp_offload_socket(queue);

	} else {
		ret = nvmf_connect_admin_queue(nctrl);
		if (ret)
			goto err;
		ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
		if (nvme_tcp_ddp_query_limits(queue))
			nvme_tcp_offload_apply_limits(queue);
	}

ctrl->ddp_netdev should be cleared and put when the admin queue
is stopped/freed, similar to how async_req is handled.

>>> +                     goto done;
>>> +             }
>>> +             if (is_netdev_ulp_offload_active(netdev, queue))
>>> +                     nvme_tcp_offload_apply_limits(queue, netdev);
>>> +             /*
>>> +              * release the device as no offload context is
>>> +              * established yet.
>>> +              */
>>> +             dev_put(netdev);
>>
>> the put is unclear, what does it pair with? the get_netdev_for_sock?
> 
> Yes, get_netdev_for_sock() takes a reference, which we don't need at
> that point so we put it.

Well, you store a pointer to it, what happens if it goes away while
the controller is being set up?

