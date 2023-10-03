Return-Path: <netdev+bounces-37707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E59C7B6B16
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 33EF4B20959
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246B30F8E;
	Tue,  3 Oct 2023 14:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629811548D
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:09:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C3AF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696342169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X44Tq6ZQyKHpf85+uPUYtu3C07cLcK5Yop9qoiVlU4Q=;
	b=JggIQBwdpS21kiWUvER8rAYPlshA4iybXJOZCrAzGX4EueSKYlf1a2Tg6T43fXABJXXs1z
	YvcBVZeMbMTjsceYa89CInfdQohjMZlIWEcvEgM6rk92IylQYzcivDR3PeERdKz3/HYf9D
	ZGK4u3MI0v9dhfJp1zZb9Ptn1HGvUes=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Qc8DbPULMA-h33cCNlFK6g-1; Tue, 03 Oct 2023 10:09:28 -0400
X-MC-Unique: Qc8DbPULMA-h33cCNlFK6g-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-49d0ef50930so332175e0c.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 07:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342168; x=1696946968;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X44Tq6ZQyKHpf85+uPUYtu3C07cLcK5Yop9qoiVlU4Q=;
        b=NvtBjDRvTJZLazWg5rixVS2Cea5UwVsJEsrGMKGUBbwqF8c4EwykALg1ujCc307sN6
         NP3QY5iT+YPQOZUeKF3ThoVAW2fXLEt3zgsahhRX5wtBZtwSahZi6f5MO7er+2J/T2S3
         hLXDgx28NlM/MKiC3GPj0LPaZTdENaCnmoCIZFzcghZI0dF701JIpFkwiz3AwB3wmjEN
         Bmks/4/CZcliJnGT8p115ZVvJ3APlEioVDCZjycLE+3A2nlOhyvv2njiLKtt+ozcOglc
         pR3JU1bKH3sN0n6FCmS6z95mKXYy9UPbHaFQ2pQNh0VBrvZtcx/akNnJ81zSAboxDbnF
         4b9A==
X-Gm-Message-State: AOJu0YzCKn5tWK3xoJojrAlr8tdpBwv6Ddzp5HrhquOFzzq/xvnWKmRr
	+w8qt8dfCm8iyqsXiM7GG2IYXNg4d/Rgj+BJ5VP4vu5X23be8sobSo1daEOrMp83Pw7Qh/sOKFF
	HRJK/GTlerb9zIvAv+rC8kjzdFOG0RUd2lcZ+KGCXixDrUwYjqcfGTidIiG+jJGEGI+y4cbv6iB
	fT
X-Received: by 2002:a1f:e203:0:b0:49d:3e4c:6168 with SMTP id z3-20020a1fe203000000b0049d3e4c6168mr5577725vkg.7.1696342167840;
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE51CWMMcL1xIGhPy1qwOpsEeNOmhrlSsl8Pun0ZXJxi4IsgC97mbRzcHjfWR+66hBRo6sgqQ==
X-Received: by 2002:a1f:e203:0:b0:49d:3e4c:6168 with SMTP id z3-20020a1fe203000000b0049d3e4c6168mr5577694vkg.7.1696342167414;
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a0c8c09000000b0065b11053445sm516960qvb.54.2023.10.03.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
Subject: Re: Question on tw_timer TIMER_PINNED
In-Reply-To: <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
References: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
 <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
Date: Tue, 03 Oct 2023 16:09:24 +0200
Message-ID: <xhsmhwmw3ol0r.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 06/09/23 14:10, Eric Dumazet wrote:
> On Wed, Sep 6, 2023 at 1:58=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com>=
 wrote:
>>
>> Hi Eric,
>>
>> I'm bothering you with a question about timewait_sock tw_timer, as I
>> believe you are one of the last persons touching it sometime ago. Please
>> feel free to redirect if I failed to git blame it correctly.
>>
>> At my end, latency spikes (entering the kernel) have been reported when
>> running latency sensitive applications in the field (essentially a
>> polling userspace application that doesn't want any interruption at
>> all). I think I've been able to track down one of such interruptions to
>> the servicing of tw_timer_handler. This system isolates application CPUs
>> dynamically, so what I think it happens is that at some point tw_timer
>> is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
>> 60s timeout) such CPU is 'isolated' and the latency sensitive app
>> started on it. After 60s the timer fires and interrupts the app
>> generating a spike.
>>
>> I'm not very familiar with this part of the kernel and from staring
>> at code for a while I had mixed feeling about the need to keep tw_timer
>> as TIMER_PINNED. Could you please shed some light on it? Is it a strict
>> functional requirement or maybe a nice to have performance (locality I'd
>> guess) improvement? Could we in principle make it !PINNED (so that it
>> can be moved/queued away and prevent interruptions)?
>>
>
> It is a functional requirement in current implementation.
>
> cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
> changelog has some details about it.
>
> Can this be changed to non pinned ? Probably, but with some care.
>
> You could simply disable tw completely, it is a best effort mechanism.
>

So it's looking like doing that is not acceptable for our use-case, as
we still want timewait sockets for the traffic happening on the
housekepeing (non-isolated) CPUs.


I had a look at these commits to figure out what it would take to make it
not pinned:

  cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")

and I'm struggling to understand why we want the timer to be armed before
inet_twsk_hashdance(). I found this discussion on LKML:

  https://lore.kernel.org/all/56941035.9040000@fastly.com/

And I can see that __inet_lookup_established() and tw_timer_handler()
both operate on __tw_common.skc_nulls_node and __tw_common.skc_refcnt, but:
- the timer has its own count in the refcount
- sk_nulls_for_each_rcu() is (on paper) safe to run concurrently with
  tw_timer_handler
  `\
    inet_twsk_kill()
    `\
      sk_nulls_del_node_init_rcu()

So I'm thinking we could let the timer be armed after the *hashdance(), so
it wouldn't need to be pinned anymore, but that's pretty much a revert of
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
which fixed a race.

Now this is the first time I poke my nose into this area and I can't
properly reason how said race is laid out. I'm sorry for asking about such
an old commit, but would you have any pointers on that?

Thanks


