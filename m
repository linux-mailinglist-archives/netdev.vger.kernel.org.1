Return-Path: <netdev+bounces-13975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F351A73E3B0
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD155280944
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AEC2CE;
	Mon, 26 Jun 2023 15:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A71111B4
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:41:55 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F861BDF;
	Mon, 26 Jun 2023 08:41:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so16784251fa.3;
        Mon, 26 Jun 2023 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687794075; x=1690386075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfYjtj1R9OBqs+dVmgnQu3/n0GQzqWIXlWSAYyCQgfE=;
        b=ZC4tdxELBaEzsmkyrCDXSO4zrWdOHRW66r1aH4EZlhpnkAAIXHH6JHFNZgMHV97kLH
         WOuPG/Z/LMu4Jx40e2mXYXuNlsp8pGN7Mr9cjtCijXBsWURhkgTn1yMVbUCXv+mAsvTj
         EDc3zwgKi0AfwDX8md+tia3QCxgpDyVEQ39x/fixcn/aqfps8qdjVfFPbBy7fpqpx87m
         tFfrzz+Gomg3ypUedSrjtmiK3UCI5V2/KEs+Udwqmgj9lHEV33Qbs5PxXO5iP3ETt8vn
         4ns2G4yK0bQpMAkRLSgB/LKumhHwl80LtXN9zFUf3Nxj5ZY3O+Bp5C1NWf1RYm7HaWVr
         6KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794075; x=1690386075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfYjtj1R9OBqs+dVmgnQu3/n0GQzqWIXlWSAYyCQgfE=;
        b=WfaW+MVgVsLlpdFC+L2vafK+Wz7OG6FKqVB/dWeO8SsVuHWbZl7s+3m8mvqXrFakJv
         5hUy9/E6wRrCH/DISJPqbixhlHJZhWeMbLA7aqyazIjhW7+hiYBYz3duq7jow0X7WC5x
         tRX0G/kKvB8NAcKnqlPeh6w9FnVYYRRRIy2y6N/Z195ymN0CADYQEj64t0kZ2R0q/mI9
         RgvrCHp2PO3CVGT5ihkAXvLDHTp0wgRFmwM2/JZJtm3y6N50dahsKhXdxcG5Ds+Jf1Sp
         SWC6vSUhztwwk+E4Z2/4FpoEwMFoSn4IFp+3vj6f8lbjcU8P+uDOplNYbRWaO/ifbDAm
         9YwA==
X-Gm-Message-State: AC+VfDwcSMHc8XAdunc1aJZQ19J0Akm1ZDKPqr8JxrYH/itG3W+xKbxL
	xm7I2nIQ4/aKYDF/oq6p/LhfJ6rP/KmMpA0JI28=
X-Google-Smtp-Source: ACHHUZ7VE+8iZfotd1r+SiAoEv3NvBloeBmppqXFsMvjW04FYaybsoeMhBTGyEWcgQXFE0Lrufy5XWjXJ5HBl9IL5ik=
X-Received: by 2002:a05:651c:207:b0:2b4:7d01:f174 with SMTP id
 y7-20020a05651c020700b002b47d01f174mr15122288ljn.13.1687794075146; Mon, 26
 Jun 2023 08:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-4-dhowells@redhat.com>
 <CAOi1vP9vjLfk3W+AJFeexC93jqPaPUn2dD_4NrzxwoZTbYfOnw@mail.gmail.com> <3068221.1687788027@warthog.procyon.org.uk>
In-Reply-To: <3068221.1687788027@warthog.procyon.org.uk>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 26 Jun 2023 17:41:03 +0200
Message-ID: <CAOi1vP8AyL=nsqDw-QKjPsC8wMsEnq+hSh29PobADYLm-L9ZNg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/16] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 4:00=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > Same here...  I would suggest that you keep ceph_tcp_sendpage() functio=
n
> > and make only minimal modifications to avoid regressions.
>
> This is now committed to net-next.

This needs to be dropped from linux-next because both this and
especially the other (net/ceph/messenger_v2.c) patch introduce
regressions.

> I can bring ceph_tcp_sendpage() back into
> existence or fix it in place for now if you have a preference.

I already mentioned that I would prefer if ceph_tcp_sendpage() was
brought back into existence.

>
> Note that I'm working on patches to rework the libceph transmission path =
so
> that it isn't dealing with transmitting a single page at a time, but it's=
 not
> ready yet.

That is a worthwhile improvement now that sock_sendmsg() can take
advantage of multiple pages!  It would be pretty invasive though so
I think ceph_tcp_sendpage() is better to remain in place until then.

Thanks,

                Ilya

