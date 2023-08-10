Return-Path: <netdev+bounces-26468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16C777E7B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD08282286
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E131FB3B;
	Thu, 10 Aug 2023 16:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACAC1E1DA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:40:46 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC19C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:40:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1080250f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1691685644; x=1692290444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epYEpBUgtETJSNy8PNB2Kfzmm6EHCakHcxvtmtgnuZg=;
        b=jbE3fw5Ku34OflOLZ4ytj1QJJBgGF6jCJyNJh1Hy4D5ucAoiJ+gC0pKSQbIRGJPisl
         50RpxsOURQvwAVoQ/ArmultmavFN+R2NNeXcDYR21xYvMo2YWQP2EfE2TfR7+D1wyQpy
         /DEA4S6rHILPLi7C8Z3H1X+5XaTHr3pBElvrzMXuePfo32nwCnypDRfbyCcy481/Lmok
         vnqrECjFtYKLkSH3mdr45TqcDdYTRHkM5doKn051HA3k4Q8QjgvsNP3iN+DJ4kRosVX0
         GuXcJ5LcKAVIWSjn9MFEXBnF9kUbazsaaifPoBZ/bYT2eNyDblc38v8mxZ0wGPhNkULn
         exUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685644; x=1692290444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epYEpBUgtETJSNy8PNB2Kfzmm6EHCakHcxvtmtgnuZg=;
        b=jcwPZWlQFtftsFMolIS7UZ7b2I99YbgHxZZxajmmPFEGwTGnbheL4wA7kRShMMo006
         vFK1Mc9NLkd2t83Rt2KdSkYAu803vnnHV6a9hXeumTH2m1hgVLRgNS/DOn+z+1Ft72YZ
         y/vLBiXtj1CgxEu2y4QW3UpESFSS3m639f6ZPAX2b5I8DWSw/X5dmae8ua/bjIgOd9x7
         8SO/uzylKIMzDxw2RjcfHo8LOXA12YjPfd2jjM1coD8YRj1yj+RTRkf+5P3d381GLUBZ
         3+a3CXryhFTWTRWdjR54jsNNLi9JkgRms3hTuavJt1EIND30B2n4s3EisI/GWcqdjjoq
         wGfg==
X-Gm-Message-State: AOJu0YwE3/vkTldSADI9z+dw1uTHNKF9tFLevUlDI6sv6MjemxCIsJur
	pHZkoJa2hAIZnJh2760qb3W6pw==
X-Google-Smtp-Source: AGHT+IFTiOImpkReDt/CngINBkpyx28lr/NDG9vWL6le9vl7MmWb6Le1GUOnhKCl1w/wdU4OG8aNAg==
X-Received: by 2002:a5d:63c6:0:b0:313:fd52:af37 with SMTP id c6-20020a5d63c6000000b00313fd52af37mr2571788wrw.4.1691685643878;
        Thu, 10 Aug 2023 09:40:43 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm2663826wrt.24.2023.08.10.09.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:40:43 -0700 (PDT)
Message-ID: <48e4d7b6-d02b-f1c5-26d0-92ff3ca4df2e@arista.com>
Date: Thu, 10 Aug 2023 17:40:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 net-next 16/23] net/tcp: Ignore specific ICMPs for
 TCP-AO connections
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Salam Noureddine <noureddine@arista.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230802172654.1467777-1-dima@arista.com>
 <20230802172654.1467777-17-dima@arista.com>
 <CANn89iKjT3i-0rZLu8WE_P94aN65rj8uBAw3MyMPhsnMKWSs_A@mail.gmail.com>
 <d84888b2-8b5a-103c-3e8a-1be5e5833288@arista.com>
 <CANn89i+eUrn6tzQBNQjywyS-rsqm_uamJRdfP0-o_Pz2Dv1t8A@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+eUrn6tzQBNQjywyS-rsqm_uamJRdfP0-o_Pz2Dv1t8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 17:36, Eric Dumazet wrote:
> On Thu, Aug 10, 2023 at 6:27 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> On 8/8/23 14:43, Eric Dumazet wrote:
>>> On Wed, Aug 2, 2023 at 7:27 PM Dmitry Safonov <dima@arista.com> wrote:
>> [..]
>>>>
>>>> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
>>>
>>> const struct sock *sk ?
>>
>> Well, I can't really: atomic64_inc(&ao->counters.dropped_icmp)
> 
> I think we could, because this would still work.
> 
>  struct tcp_ao_info *ao; // This is rw object

Yeah, right, had not enough coffee today.

> ao = rcu_dereference(tcp_sk(sk)->ao_info);
> 
> This helper looks to accept unlocked sockets, so marking them const
> would avoid mistakes in the future.

I see, will make it `const', thanks!

-- 
            Dmitry


