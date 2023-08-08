Return-Path: <netdev+bounces-25450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02037774174
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A3E1C20E32
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDE14AA3;
	Tue,  8 Aug 2023 17:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14D14A9C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:21:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290263F4F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691514542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
	b=avwz/xZMkjdLbjhGmTA4m/bbUD6FSABrHrPpr1qJwl91lhReX4yIkgoG8k4OXfCuxKv81x
	pT+vvDC847wEfN9vSslLj2ETskkSi70Qsmya4lrJ0vBbI/jGvgo2MO2BLiobc7yGXjk7rU
	dbwfqkG6zGEyi+twya95HnWWAiOrakY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ydm-quCBNS2GYFRRtv4rxg-1; Tue, 08 Aug 2023 08:01:08 -0400
X-MC-Unique: ydm-quCBNS2GYFRRtv4rxg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bc711a20eso418348166b.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691496067; x=1692100867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
        b=b9kUeYzxr9MvLURT4Hos4VntgN6vgrIhiQann3xmCeioPtNXGfnTRP5BNhSakgY5Ol
         3YlwpFOWfM+0B9kuPnp1eT09lV+7ESJ/VtVxMgRPQDCjySG/JX+dwusMJcUnLTFLU8tv
         0BSECnKrZKW/m9ADwO1pqCYGVhJyh8Z8N8jSaFWRvvQZEbwte+ObLtInDU4n2TZ1GxrX
         p/O2iZ5hGaKtb/WFrFbjgVJVbtV7VxzdlDOcVJavWbBNzRwGpcZpdqZ4qTwq/HAom3Br
         7yjtpSr8KFTVuwHM+b3DqjYCx1SCIV1BsZwalJqdL8ot2JMfZnMTaIt6PR6W/h0RITpi
         nplQ==
X-Gm-Message-State: AOJu0YxZNGEDFiEiMWz5hSpjYwaV6PUPUFehnmfJbiK31c1cr7+KtAt1
	i8NTP/anAZgTRWay8cJ3JyBZDo9SjjGYnXKb/WzwCoDgdvEgSnl3mc1Yls7qktjINcuraiFJc9Q
	yN7ylGBv5RmgkAypD
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542749ejv.40.1691496067598;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExprTRWssJI7svYIKpAk9QD7eZgNMMaCHszU1opQzSkcMk4JdoidE7FYhHnoUzGicOwYlHMA==
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542716ejv.40.1691496067077;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm6538145ejb.97.2023.08.08.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:01:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C9617D255EA; Tue,  8 Aug 2023 14:01:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Kees Cook <keescook@chromium.org>,
 Richard Gobert <richardbgobert@gmail.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC v3 Optimizing veth xsk performance 0/9]
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Aug 2023 14:01:04 +0200
Message-ID: <87v8dpbv5r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Albert Huang <huangjie.albert@bytedance.com> writes:

> AF_XDP is a kernel bypass technology that can greatly improve performance.
> However,for virtual devices like veth,even with the use of AF_XDP sockets,
> there are still many additional software paths that consume CPU resources. 
> This patch series focuses on optimizing the performance of AF_XDP sockets 
> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
> Patch 5 introduces tx queue and tx napi for packet transmission, while 
> patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
> add support for AF_XDP tx need_wakup feature. These optimizations significantly
> reduce the software path and support checksum offload.
>
> I tested those feature with
> A typical topology is shown below:
> client(send):                                        server:(recv)
> veth<-->veth-peer                                    veth1-peer<--->veth1
>   1       |                                                  |   7
>           |2                                                6|
>           |                                                  |
>         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>                   3                    4                 5    
>              (machine1)                              (machine2)    

I definitely applaud the effort to improve the performance of af_xdp
over veth, this is something we have flagged as in need of improvement
as well.

However, looking through your patch series, I am less sure that the
approach you're taking here is the right one.

AFAIU (speaking about the TX side here), the main difference between
AF_XDP ZC and the regular transmit mode is that in the regular TX mode
the stack will allocate an skb to hold the frame and push that down the
stack. Whereas in ZC mode, there's a driver NDO that gets called
directly, bypassing the skb allocation entirely.

In this series, you're implementing the ZC mode for veth, but the driver
code ends up allocating an skb anyway. Which seems to be a bit of a
weird midpoint between the two modes, and adds a lot of complexity to
the driver that (at least conceptually) is mostly just a
reimplementation of what the stack does in non-ZC mode (allocate an skb
and push it through the stack).

So my question is, why not optimise the non-zc path in the stack instead
of implementing the zc logic for veth? It seems to me that it would be
quite feasible to apply the same optimisations (bulking, and even GRO)
to that path and achieve the same benefits, without having to add all
this complexity to the veth driver?

-Toke


