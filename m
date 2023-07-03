Return-Path: <netdev+bounces-15139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5717745E33
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F06F280C6A
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65FF9EE;
	Mon,  3 Jul 2023 14:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91164F9E9
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:10:31 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854EE6F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:10:07 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso13076855e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 07:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393405; x=1690985405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehUXf2LNnInGH0Vqogp/lrUNeW1dVzwZ4KWyqlQvQjw=;
        b=QVnuZjIqZ9+XF8TaKmIXoW1wEgchzta32D7IIhRL16EPvb3GbRh4mHADbo69yprfbT
         YDOC+8ELcFdNVpytNwq1deYzKCc5PBVlzgGY1oLmKmUBpjOkqg3rTb5K/lr+D/lNlnXy
         tx+d3NF8Xtds7RiR6QFiXIshe4FFsnMSv8p5F/B7C4aGfPwspizmVYzzxTcmEsu+J4f7
         Cs74fFgWNrgqp5gZgIrhu/JSxoiWC4y/CWExY8klOxIfzBcMMFU2pNrZpU8IZrwDUTro
         QQ+YfUWcjOk8QxpGS8RpxJWbRe/1eHLaPb3AVDlSNjN70Skm2jpx0owanslkacQNQIW2
         9ALA==
X-Gm-Message-State: ABy/qLbFhCGIHzQAKU0LEimtrwnTFzcV2jOosvko8BGngvi4NEusaVCZ
	pYRx2ZJjNgMOMzJ9F1RJCrzOWuGaUdM=
X-Google-Smtp-Source: APBJJlEbzcp+DsLfYrf5pTIlP/GB3g8HY7MTBgbpx9cZ7Hoofv7LOlgy5ET3UYJql70nVsK3BwaBPg==
X-Received: by 2002:a05:600c:1c0a:b0:3fb:a982:8f41 with SMTP id j10-20020a05600c1c0a00b003fba9828f41mr6654288wms.3.1688393405189;
        Mon, 03 Jul 2023 07:10:05 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r3-20020a056000014300b00314398e4dd4sm1812292wrx.54.2023.07.03.07.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:10:04 -0700 (PDT)
Message-ID: <40509bb4-3ca4-3bb1-3c28-1b0e90aa92be@grimberg.me>
Date: Mon, 3 Jul 2023 17:10:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
 <0ceb62b7-c310-cc4a-6b90-651e6b0c09ae@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0ceb62b7-c310-cc4a-6b90-651e6b0c09ae@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/3/23 16:57, Hannes Reinecke wrote:
> On 7/3/23 15:42, Sagi Grimberg wrote:
>>
>>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>>
>>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>>
>>>>> Can you be more specific about the crash?
>>>>
>>>> Hannes,
>>>>
>>>> See:
>>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>>
>>> Ah, right. That solves _that_ issue.
>>>
>>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>>> your suggestion). Investigating.
>>
>> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
>> does not interpret this as a transient status and simply returns from
>> io_work?
>>
> Unfortunately, yes.
> 
> static int tls_rx_reader_acquire(struct sock *sk, struct 
> tls_sw_context_rx *ctx,
>                                   bool nonblock)
> {
>          long timeo;
> 
>          timeo = sock_rcvtimeo(sk, nonblock);
> 
>          while (unlikely(ctx->reader_present)) {
>                  DEFINE_WAIT_FUNC(wait, woken_wake_function);
> 
>                  ctx->reader_contended = 1;
> 
>                  add_wait_queue(&ctx->wq, &wait);
>                  sk_wait_event(sk, &timeo,
>                                !READ_ONCE(ctx->reader_present), &wait);
> 
> and sk_wait_event() does:
> #define sk_wait_event(__sk, __timeo, __condition, __wait)              \
>          ({      int __rc;                                              \
>                  __sk->sk_wait_pending++;                               \
>                  release_sock(__sk);                                    \
>                  __rc = __condition;                                    \
>                  if (!__rc) {                                           \
>                          *(__timeo) = wait_woken(__wait,                \
>                                                  TASK_INTERRUPTIBLE,    \
>                                                  *(__timeo));           \
>                  }                                                      \
>                  sched_annotate_sleep();                                \
>                  lock_sock(__sk);                                       \
>                  __sk->sk_wait_pending--;                               \
>                  __rc = __condition;                                    \
>                  __rc;                                                  \
>          })
> 
> so not calling 'lock_sock()' in tls_tx_reader_acquire() helps only _so_ 
> much, we're still deadlocking.

That still is legal assuming that sock lock is taken prior to
sk_wait_event...

What are the blocked threads from sysrq-trigger?

