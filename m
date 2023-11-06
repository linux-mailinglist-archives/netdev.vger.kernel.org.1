Return-Path: <netdev+bounces-46248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BB7E2CD6
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 20:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53FCB20A12
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3040228E33;
	Mon,  6 Nov 2023 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqlReyfq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DA2F41
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 19:29:50 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5FF3
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 11:29:48 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45d88053c24so1637385137.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699298987; x=1699903787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Si+k3SGcxGf6sJGMI/kj5eJZ6V+SjfPyFVm8vGoBA=;
        b=LqlReyfqOi5hTdMQbb+YXa8+g7KEHgzvrOt4dBaC2f3Fn1pp1kl+nekse8KlFM49ll
         k1tuf0NyoOUYtWmrTR/FzHfuh9VczuBtD4kwQ1iPmv4fzL4mguF1IZCyYtvZem/8ddqQ
         Vp7G1IGaHYgyO4r1YsHBD9G/4lN++Lcdrk907s0ZKDP0GdV4EgmL6mtDEx9g+Q6KZtKn
         cIcjMsIBNHNOhO3WChRAcKEWGKwbu0zQQHrgrmtiu+h1ugFZ8MsydbCgufcarunRAtQL
         O4WVSSFCdSmKRZ1XOdS2X+FDURpiHUl9/AYVD5GnqLQFqX2zWDQdnZUPySVTzzd8RQu5
         nVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298987; x=1699903787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7Si+k3SGcxGf6sJGMI/kj5eJZ6V+SjfPyFVm8vGoBA=;
        b=Hj2zz92o/YlcZwjMSlpbEyjgAGL9N9sFDZ3cjpSRnCs4FjeUJZFXCm49CU8sV3/U1W
         xqSY3BxBGe6wFF20XFCctSFdazhJqtgSYf00ubmmZdDyhYjqF1ceRJTmvM8+2U2Gkcyx
         WBvuMZAe+Qwn9fNOYNugwpaiE+LoVLQJNn/hbewN6dTCyuae5Hx6mD9DPt3Q8C/LbJVu
         0hn0Qqm30XYp5aSgH5CoT40RTIvF+Yfo/jncd0n9DRevqXg+jx8i9QGB6LyPfAg0RB4Z
         zTBCIqNot1YcvCcWUyNeIrQjeVl0UufKhb7GQ7hDnIPhXfVWThfv++OK3+0f5/lDOJIl
         omfg==
X-Gm-Message-State: AOJu0Yy9rVcoot4Zs7cxJgiTgGZvl/nkzV1roXogfJfoNNCXWkee/teQ
	fZZHQDwirIuuIQRoN50aFlljIp3gvXROMhcybCVvEw==
X-Google-Smtp-Source: AGHT+IG22F7RZ7INsRT61We/dhQuubrTDUtrXNKt9IRXUitWz7JbG7ca/qoY3u3vM4us0jqLVC7nFfmA8VO3BFOqiRY=
X-Received: by 2002:a67:a247:0:b0:45d:9083:f877 with SMTP id
 t7-20020a67a247000000b0045d9083f877mr7751422vsh.5.1699298986878; Mon, 06 Nov
 2023 11:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
In-Reply-To: <ZUk0FGuJ28s1d9OX@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 11:29:33 -0800
Message-ID: <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 10:44=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 11/05, Mina Almasry wrote:
> > In tcp_recvmsg_locked(), detect if the skb being received by the user
> > is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVME=
M
> > flag - pass it to tcp_recvmsg_devmem() for custom handling.
> >
> > tcp_recvmsg_devmem() copies any data in the skb header to the linear
> > buffer, and returns a cmsg to the user indicating the number of bytes
> > returned in the linear buffer.
> >
> > tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> > and returns to the user a cmsg_devmem indicating the location of the
> > data in the dmabuf device memory. cmsg_devmem contains this information=
:
> >
> > 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> > 2. the size of the frag. 'frag_size'.
> > 3. an opaque token 'frag_token' to return to the kernel when the buffer
> > is to be released.
> >
> > The pages awaiting freeing are stored in the newly added
> > sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> > This reference is dropped once the userspace indicates that it is
> > done reading this page.  All pages are released when the socket is
> > destroyed.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > RFC v3:
> > - Fixed issue with put_cmsg() failing silently.
> >
> > ---
> >  include/linux/socket.h            |   1 +
> >  include/net/page_pool/helpers.h   |   9 ++
> >  include/net/sock.h                |   2 +
> >  include/uapi/asm-generic/socket.h |   5 +
> >  include/uapi/linux/uio.h          |   6 +
> >  net/ipv4/tcp.c                    | 189 +++++++++++++++++++++++++++++-
> >  net/ipv4/tcp_ipv4.c               |   7 ++
> >  7 files changed, 214 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index cfcb7e2c3813..fe2b9e2081bb 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -326,6 +326,7 @@ struct ucred {
> >                                         * plain text and require encryp=
tion
> >                                         */
> >
> > +#define MSG_SOCK_DEVMEM 0x2000000    /* Receive devmem skbs as cmsg */
>
> Sharing the feedback that I've been providing internally on the public li=
st:
>

There may have been a miscommunication. I don't recall hearing this
specific feedback from you, at least in the last few months. Sorry if
it seemed like I'm ignoring feedback :)

> IMHO, we need a better UAPI to receive the tokens and give them back to
> the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> but look dated and hacky :-(
>
> We should either do some kind of user/kernel shared memory queue to
> receive/return the tokens (similar to what Jonathan was doing in his
> proposal?)

I'll take a look at Jonathan's proposal, sorry, I'm not immediately
familiar but I wanted to respond :-) But is the suggestion here to
build a new kernel-user communication channel primitive for the
purpose of passing the information in the devmem cmsg? IMHO that seems
like an overkill. Why add 100-200 lines of code to the kernel to add
something that can already be done with existing primitives? I don't
see anything concretely wrong with cmsg & setsockopt approach, and if
we switch to something I'd prefer to switch to an existing primitive
for simplicity?

The only other existing primitive to pass data outside of the linear
buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
preferred? Any other suggestions or existing primitives I'm not aware
of?

> or bite the bullet and switch to io_uring.
>

IMO io_uring & socket support are orthogonal, and one doesn't preclude
the other. As you know we like to use sockets and I believe there are
issues with io_uring adoption at Google that I'm not familiar with
(and could be wrong). I'm interested in exploring io_uring support as
a follow up but I think David Wei will be interested in io_uring
support as well anyway.

> I was also suggesting to do it via netlink initially, but it's probably
> a bit slow for these purpose, idk.

Yeah, I hear netlink is reserved for control paths and is
inappropriate for data path, but I'll let folks correct me if wrong.

--=20
Thanks,
Mina

