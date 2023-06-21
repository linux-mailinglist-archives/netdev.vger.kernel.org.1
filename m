Return-Path: <netdev+bounces-12528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264A737F2C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B241C20C7A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415FD53F;
	Wed, 21 Jun 2023 09:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99CC2DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:49:54 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94422121
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:49:26 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f8680d8bf2so764568e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340965; x=1689932965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44X6+99pKlgwHZH+ZkAUyRImkhjgPyBaJGQeUhSa7hM=;
        b=V5KuQGJ1F4aBgEvylhp8SP061QAb92k6uuhLmffwif3zWQzclmAVR7qHDXfstkrR/X
         MPrbCYHFdmkiq8kcBVKkyvw+b3j0fmaqO4xTNu8oLc295m/tfLQ3BkA+mVnpDKnwb+LP
         CJAyYlh+UViOQuGodtEIbgxXopsEKMjqfC0KtVoYmkdbv7u5TcQa7IX5jiCSaZt21Aep
         qyIWMmijmmotjg3ZgUIj1jiRstTCMRHdxu6XYCF7eEOWY28zeHMNqXkDQXp9UKz94OQ5
         RpHCfrqrGUM4ptQhKuXhpUeQBs8PgIpMK2/++Mr0di6rmXOVw3trHsSWjF+3aNYLw0hJ
         8bLQ==
X-Gm-Message-State: AC+VfDykwfIfv/oTAJTlhHf1Dhk/nn/R1+yuphd9Vtus7nfE54LB6jk1
	Vsl/gksjso5/6YMVhWxry8w=
X-Google-Smtp-Source: ACHHUZ48SDABBYYHanFBWPROk5HEzhNFkjXhp5Ub5ZA/qllIjUqca5di7Z6eyOGlnTyCs81qJTcF5w==
X-Received: by 2002:ac2:544b:0:b0:4f5:1cfb:18df with SMTP id d11-20020ac2544b000000b004f51cfb18dfmr7170890lfn.4.1687340964706;
        Wed, 21 Jun 2023 02:49:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q4-20020adff784000000b0030aec5e020fsm4021939wrp.86.2023.06.21.02.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:49:24 -0700 (PDT)
Message-ID: <476d2cd9-ae32-a4e6-4549-52c3863d4049@grimberg.me>
Date: Wed, 21 Jun 2023 12:49:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
 <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
 <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
 <f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/21/23 12:08, Hannes Reinecke wrote:
> On 6/21/23 10:39, Sagi Grimberg wrote:
>>
>>>> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>>>>> +    err = tls_rx_reader_lock(sk, ctx, true);
>>>>>> +    if (err < 0)
>>>>>> +        return err;
>>>>>
>>>>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>>>>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>>>>> how is this not a deadlock?
>>>>
>>>> Yeah :|
>>>>
>>>>> I'm not exactly clear why the lock is needed here or what is the 
>>>>> subtle
>>>>> distinction between tls_rx_reader_lock and what lock_sock provides.
>>>>
>>>> It's a bit of a workaround for the consistency of the data stream.
>>>> There's bunch of state in the TLS ULP and waiting for mem or data
>>>> releases and re-takes the socket lock. So to stop the flow annoying
>>>> corner case races I slapped a lock around all of the reader.
>>>>
>>>> IMHO depending on the socket lock for anything non-trivial and outside
>>>> of the socket itself is a bad idea in general.
>>>>
>>>> The immediate need at the time was that if you did a read() and someone
>>>> else did a peek() at the same time from a stream of A B C D you may 
>>>> read
>>>> A D B C.
>>>
>>> Leaving me ever so confused.
>>>
>>> read_sock() is a generic interface; we cannot require a protocol 
>>> specific lock before calling it.
>>>
>>> What to do now?
>>> Drop the tls_rx_read_lock from read_sock() again?
>>
>> Probably just need to synchronize the readers by splitting that from
>> tls_rx_reader_lock:
>> -- 
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 53f944e6d8ef..53404c3fdcc6 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1845,13 +1845,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
>> tls_prot_info *prot,
>>          return sk_flush_backlog(sk);
>>   }
>>
>> -static int tls_rx_reader_lock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> -                             bool nonblock)
>> +static int tls_rx_reader_acquire(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> +                            bool nonblock)
>>   {
>>          long timeo;
>> -       int err;
>> -
>> -       lock_sock(sk);
>>
>>          timeo = sock_rcvtimeo(sk, nonblock);
>>
>> @@ -1865,26 +1862,30 @@ static int tls_rx_reader_lock(struct sock *sk, 
>> struct tls_sw_context_rx *ctx,
>>                                !READ_ONCE(ctx->reader_present), &wait);
>>                  remove_wait_queue(&ctx->wq, &wait);
>>
>> -               if (timeo <= 0) {
>> -                       err = -EAGAIN;
>> -                       goto err_unlock;
>> -               }
>> -               if (signal_pending(current)) {
>> -                       err = sock_intr_errno(timeo);
>> -                       goto err_unlock;
>> -               }
>> +               if (timeo <= 0)
>> +                       return -EAGAIN;
>> +               if (signal_pending(current))
>> +                       return sock_intr_errno(timeo);
>>          }
>>
>>          WRITE_ONCE(ctx->reader_present, 1);
>>
>>          return 0;
>> +}
>>
>> -err_unlock:
>> -       release_sock(sk);
>> +static int tls_rx_reader_lock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> +                             bool nonblock)
>> +{
>> +       int err;
>> +
>> +       lock_sock(sk);
>> +       err = tls_rx_reader_acquire(sk, ctx, nonblock);
>> +       if (err)
>> +               release_sock(sk);
>>          return err;
>>   }
>>
>> -static void tls_rx_reader_unlock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx)
>> +static void tls_rx_reader_release(struct sock *sk, struct 
>> tls_sw_context_rx *ctx)
>>   {
>>          if (unlikely(ctx->reader_contended)) {
>>                  if (wq_has_sleeper(&ctx->wq))
>> @@ -1896,6 +1897,11 @@ static void tls_rx_reader_unlock(struct sock 
>> *sk, struct tls_sw_context_rx *ctx)
>>          }
>>
>>          WRITE_ONCE(ctx->reader_present, 0);
>> +}
>> +
>> +static void tls_rx_reader_unlock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx)
>> +{
>> +       tls_rx_reader_release(sk, ctx);
>>          release_sock(sk);
>>   }
>> -- 
>>
>> Then read_sock can just acquire/release.
> 
> Good suggestion.
> Will be including it in the next round.

Maybe more appropriate helper names would be
tls_rx_reader_enter / tls_rx_reader_exit.

Whatever Jakub prefers...

