Return-Path: <netdev+bounces-42280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2307CE081
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC56B21011
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430B374F5;
	Wed, 18 Oct 2023 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWqGE6eg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46050374C5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:58:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768AFA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697641079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=929sHe0GqloPiKWV58z9G1yiEL0iCqJOnGu3b5vkn9k=;
	b=VWqGE6egnaeNtxgR7ddvLXg4e0U5fu09XMXIIZCZomC/bofF9NmlhztGtGRgI4WUUg9NRw
	wzYcQmquz+vCVeMj8PV+bM6TZQebHjoWugl7OcjO/qNS43k7pecE99ThS3yEHuofktXzo7
	l1qDt49mn+i657um/zTq7htntiCXAXk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-DFSc6jbaPe2PVSJ6FZC-dw-1; Wed, 18 Oct 2023 10:57:43 -0400
X-MC-Unique: DFSc6jbaPe2PVSJ6FZC-dw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e7a8fbbdso949018b6e.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641062; x=1698245862;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=929sHe0GqloPiKWV58z9G1yiEL0iCqJOnGu3b5vkn9k=;
        b=p8dpEAJUwivwK1C7oI4NDmPljJkwJnzvjgXI8Y1Bb2/Jip4liFZju7trPAyMbHEcq2
         HDcDTL5R8pkLVD5a9Lh0dO2jCsrwR4kgHDDuf03H8bPcgVUAqaq9xUIdJTnN8Bz2OwD6
         v9muaZy8pOQf0zA1HczGLI5f6/VNXUXeKkXr5hV9x6GbvE8FNHtCUD9KNkLltkWghzLi
         IMXOTN9xXg4Kj+7d7Ug2XlG4dKeF/Fupmr6epdwKJPE5k1PwbyWs/A1VT6UFqAilYKPB
         xIsonLTPnPvgBwXARBiHM3AkTNAaDjSYIFlbZIoyraaTKqBzqbDmaTPhhsD9FGgeq358
         ShLw==
X-Gm-Message-State: AOJu0YxabKqfD0PB6aUps6tUJNaIWa2f2VDV2CC14FLjZq2ESu5QokXf
	uxrsGMhNu315cjzlSZsXxYlkmkVH/0Yq/NLp/bvpZcVQY+S5hkpEx9UvHo2bV6B0fVLACJTNRoj
	l0AuZ4+0O3e9/LMQP
X-Received: by 2002:a05:6808:685:b0:3a9:e8e2:57a7 with SMTP id k5-20020a056808068500b003a9e8e257a7mr5130525oig.53.1697641062537;
        Wed, 18 Oct 2023 07:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlTaAuCZ+WGM/yTbr4Akp0ylPrazS8xDJ9YmXz8Jrm+XLu5qIkNdbRCxoExwzI82bjSJAq2g==
X-Received: by 2002:a05:6808:685:b0:3a9:e8e2:57a7 with SMTP id k5-20020a056808068500b003a9e8e257a7mr5130514oig.53.1697641062140;
        Wed, 18 Oct 2023 07:57:42 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bl31-20020a05620a1a9f00b00767d4a3f4d9sm15800qkb.29.2023.10.18.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:57:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David
 Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
References: <20231016125934.1970789-1-vschneid@redhat.com>
 <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
Date: Wed, 18 Oct 2023 16:57:39 +0200
Message-ID: <xhsmhil74m10c.mognet@vschneid.remote.csb>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/10/23 17:40, Eric Dumazet wrote:
> On Mon, Oct 16, 2023 at 3:00=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>>
>> The TCP timewait timer is proving to be problematic for setups where sch=
eduler
>> CPU isolation is achieved at runtime via cpusets (as opposed to statical=
ly via
>> isolcpus=3Ddomains).
>>
>> What happens there is a CPU goes through tcp_time_wait(), arming the tim=
e_wait
>> timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, caus=
ing
>> interference for the now-isolated CPU. This is conceptually similar to t=
he issue
>> described in
>>   e02b93124855 ("workqueue: Unbind kworkers before sending them to exit(=
)")
>>
>> Making the timer un-pinned would resolve this, as it would be queued onto
>> HK_FLAG_TIMER CPUs. It would Unfortunately go against
>>   ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
>> as we'd need to arm the timer after the *hashdance() to not have it fire=
 before
>> we've finished setting up the timewait_socket.
>>
>> However, looking into this, I cannot grok what race is fixed by having t=
he timer
>> *armed* before the hashdance.
>
> That was because :
>
> 1) the timer could expire before we had a chance to set refcnt to
> a non zero value. I guess this is fine if we use an extra atomic decremen=
t.
>
> OR
>
> 2) another cpu could find the TW and delete it (trying to cancel the
> tw_timer) before
>    we could arm the timer.  ( inet_twsk_deschedule_put() is using
> del_timer_sync() followed by inet_twsk_kill())
>
> Thus the tw timer would be armed for 60 seconds, then we would have to
> wait for the timer to really
> get rid of the tw structure.
>
> I think you also need to change inet_twsk_deschedule_put() logic ?
>

Gotcha, thank you for pointing it out.

>> Keep softirqs disabled, but make the timer un-pinned and arm it after the
>> hashdance. Remote CPUs may start using the timewait socket before the ti=
mer is
>> armed, but their execution of __inet_lookup_established() won't prevent =
the
>> arming of the timer.
>
> OK, I guess we can live with the following race :
>
> CPU0
>
>    allocates a tw, insert it in hash table
>
> CPU1:                               finds the TW and removes it (timer
> cancel does nothing)
>
> CPU0
>    arms a TW timer, lasting
>

Looks reasonable to me, I'll go write v2.

Thanks for the help!


