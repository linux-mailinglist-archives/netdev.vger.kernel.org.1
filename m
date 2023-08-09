Return-Path: <netdev+bounces-25766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F777561E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2A281AB7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB611CB1;
	Wed,  9 Aug 2023 09:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9553B7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:06:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA61BD9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691571990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+ifxhNKhk14FO/57ss8DAi+XyDazgPuAzrxHmHxo+E=;
	b=Yj+3O+HuMz7HyjQRSINbutcNFSHjvNPDY3NWp+JtF11nxZyWNaSs04ue6z9JM4OpvGfVOH
	ra0dg9JHDgYMkK2SLh1CKUlRYEOg7Y7OYfXYyNtEEHk8Jf2UjxuUql7g8hAzifuSSSARYU
	hWtmhtUF82qjpMG+nmgMqBk5UMcnWr8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ylsYPoquP7CAU6goWKf6Yg-1; Wed, 09 Aug 2023 05:06:28 -0400
X-MC-Unique: ylsYPoquP7CAU6goWKf6Yg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51866148986so4413430a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571986; x=1692176786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+ifxhNKhk14FO/57ss8DAi+XyDazgPuAzrxHmHxo+E=;
        b=kK4O6HRMLLpvU7n1iZLwJFhhZx5BptXxdFCyQ306DE29ueoLTWrLBhwv4AFBTW4mCf
         xvRlTRUKbU1VuZHIcdjuJzAK5X2M5el44FUEeGOpN7WNnzYfQ4oaMtyLaDEkxAiqF0FQ
         MAAd9++TeyS8Uu1WyrrGzB3T0puum2aJAdBRkY5VggA0Scw9LeCbIVvdVAd1m/E0zpuU
         4yskZ3OueU6BBQsvYY9v5EYKK9jWiQA4QlXBdDmJFhz4uQiTYzFthCg+ZbG7ibRYdthm
         zmoyEcDjg1BmjoT3lY2/vcVKM3PYvm6avzMB2YFIUo4yN7aL+DsiAPA1O/AJ/g8OP5+z
         IXLQ==
X-Gm-Message-State: AOJu0YyMwVoEI6h/+AW1Alz7eVJug7MTxD99zrzZBnOw5AaGJgfqx5LF
	kPCmxvAfU8fC6DTQ6ByTOKDB9yStL+0S237XXIcM3HupzCqRaWZXgLnQ0jIEWs7BrAASKIUSLja
	7JiJOR4KQtK7EuDpw
X-Received: by 2002:aa7:d690:0:b0:523:1ce9:1f49 with SMTP id d16-20020aa7d690000000b005231ce91f49mr1373698edr.42.1691571986472;
        Wed, 09 Aug 2023 02:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVbQ3DEm5V5ln3ovucAIdVoeJOsVSeoFvG4UKIvfJKCFuIw6wJnfpmnnUu0zIEpl21wlXrw==
X-Received: by 2002:aa7:d690:0:b0:523:1ce9:1f49 with SMTP id d16-20020aa7d690000000b005231ce91f49mr1373684edr.42.1691571985950;
        Wed, 09 Aug 2023 02:06:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05640200cc00b00523653295f9sm485845edu.94.2023.08.09.02.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:06:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0DC13D3B5D7; Wed,  9 Aug 2023 11:06:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Kees Cook <keescook@chromium.org>, Richard
 Gobert <richardbgobert@gmail.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: Re: [RFC v3 Optimizing veth xsk performance 0/9]
In-Reply-To: <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
 <87v8dpbv5r.fsf@toke.dk>
 <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 09 Aug 2023 11:06:23 +0200
Message-ID: <87msz04mb4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> =E4=BA=8E2023=E5=B9=B4=
8=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 20:01=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Albert Huang <huangjie.albert@bytedance.com> writes:
>>
>> > AF_XDP is a kernel bypass technology that can greatly improve performa=
nce.
>> > However,for virtual devices like veth,even with the use of AF_XDP sock=
ets,
>> > there are still many additional software paths that consume CPU resour=
ces.
>> > This patch series focuses on optimizing the performance of AF_XDP sock=
ets
>> > for veth virtual devices. Patches 1 to 4 mainly involve preparatory wo=
rk.
>> > Patch 5 introduces tx queue and tx napi for packet transmission, while
>> > patch 8 primarily implements batch sending for IPv4 UDP packets, and p=
atch 9
>> > add support for AF_XDP tx need_wakup feature. These optimizations sign=
ificantly
>> > reduce the software path and support checksum offload.
>> >
>> > I tested those feature with
>> > A typical topology is shown below:
>> > client(send):                                        server:(recv)
>> > veth<-->veth-peer                                    veth1-peer<--->ve=
th1
>> >   1       |                                                  |   7
>> >           |2                                                6|
>> >           |                                                  |
>> >         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>> >                   3                    4                 5
>> >              (machine1)                              (machine2)
>>
>> I definitely applaud the effort to improve the performance of af_xdp
>> over veth, this is something we have flagged as in need of improvement
>> as well.
>>
>> However, looking through your patch series, I am less sure that the
>> approach you're taking here is the right one.
>>
>> AFAIU (speaking about the TX side here), the main difference between
>> AF_XDP ZC and the regular transmit mode is that in the regular TX mode
>> the stack will allocate an skb to hold the frame and push that down the
>> stack. Whereas in ZC mode, there's a driver NDO that gets called
>> directly, bypassing the skb allocation entirely.
>>
>> In this series, you're implementing the ZC mode for veth, but the driver
>> code ends up allocating an skb anyway. Which seems to be a bit of a
>> weird midpoint between the two modes, and adds a lot of complexity to
>> the driver that (at least conceptually) is mostly just a
>> reimplementation of what the stack does in non-ZC mode (allocate an skb
>> and push it through the stack).
>>
>> So my question is, why not optimise the non-zc path in the stack instead
>> of implementing the zc logic for veth? It seems to me that it would be
>> quite feasible to apply the same optimisations (bulking, and even GRO)
>> to that path and achieve the same benefits, without having to add all
>> this complexity to the veth driver?
>>
>> -Toke
>>
> thanks!
> This idea is really good indeed. You've reminded me, and that's
> something I overlooked. I will now consider implementing the solution
> you've proposed and test the performance enhancement.

Sounds good, thanks! :)

-Toke


