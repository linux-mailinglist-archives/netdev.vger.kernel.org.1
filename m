Return-Path: <netdev+bounces-15138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348E745E11
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668EF280C4F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA30F9E9;
	Mon,  3 Jul 2023 14:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C5F9E8
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:01:27 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B81E51
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:01:26 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3141a9f55ceso1120225f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688392885; x=1690984885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw/ZYjT4Lt79DlrXwSlXjlTb8p9RxjOuV//IiTZBw00=;
        b=NewC5KJ5htsbqxRu9Gluq2GgtMVPuHgJb7UtamKBSlsQpnhUqUHsV8y/g6VVqYgqmj
         Y3LyYr9D8YKvSI0C0Cn6LIvAS2/UR5TH6dM+HTCg4MisQxMYy8QFWCcIQ96Tabk892dT
         /Pas1K7403LLHu7gUDlaycsvvOTjGa5q2b3BDpeItXQFCtqAXksSgRR4GQj9kZpHaYHd
         40Z6Sw4gJCadVzHtt/1o2anxBMT6IDoqInMhyiTNXC+ef5A6MK9CKTmLGSP58T47xh13
         FyShhc5C2Ml70Vf8mqrQ1K/lMoC55/mRzL7le9sUYMFX/g0rtr5RmD99C8uUnzASHY0f
         IclA==
X-Gm-Message-State: ABy/qLazOVKy0a0oDxyK/zFpV01RehUpr3vygVe70jJbs1YjorDuokt8
	7c8f6bJxw4pGVv4DYrvoVFeqaPI4MnI=
X-Google-Smtp-Source: APBJJlHh2SWxK7oXSwEwBZFEWy4sb+V1UKdMt8EibjmcvnW2h+PTXyycEFdv7tQzg+qyoLgyT7qqIg==
X-Received: by 2002:adf:fc4f:0:b0:314:f14:c24f with SMTP id e15-20020adffc4f000000b003140f14c24fmr8242224wrs.0.1688392884413;
        Mon, 03 Jul 2023 07:01:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4145000000b00314145e6d61sm11776621wrq.6.2023.07.03.07.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:01:23 -0700 (PDT)
Message-ID: <d8289263-2284-a229-75dd-cb1b771a00be@grimberg.me>
Date: Mon, 3 Jul 2023 17:01:22 +0300
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
 <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


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
>>> But it brought up yet another can of worms: what _exactly_ is the 
>>> return value of ->read_sock()?
>>>
>>> There are currently two conflicting use-cases:
>>> -> Ignore the return value, and assume errors etc are signalled
>>>     via 'desc.error'.
>>>     net/strparser/strparser.c
>>>     drivers/infiniband/sw/siw
>>>     drivers/scsi/iscsi_tcp.c
>>> -> use the return value of ->read_sock(), ignoring 'desc.error':
>>>     drivers/nvme/host/tcp.c
>>>     net/ipv4/tcp.c
>>> So which one is it?
>>> Needless to say, implementations following the second style do not
>>> set 'desc.error', causing any errors there to be ignored for callers
>>> from the first style...
>>
>> I don't think ignoring the return value of read_sock makes sense because
>> it can fail outside of the recv_actor failures.
>>
> Oh, but it's not read_actor which is expected to set desc.error.
> Have a look at 'strp_read_sock()':
> 
>          /* sk should be locked here, so okay to do read_sock */
>          sock->ops->read_sock(strp->sk, &desc, strp_recv);
> 
>          desc.error = strp->cb.read_sock_done(strp, desc.error);
> 
> it's the ->read_sock() callback which is expected to set desc.error.

Then it is completely up to the consumer how it wants to interpret the
error.

>> But to be on the safe side, perhaps you can both return an error and set
>> desc.error?
>>
> But why? We can easily make ->read_sock() a void function, then it's 
> obvious that you can't check the return value.

but it returns the consumed byte count, where would this info go?

