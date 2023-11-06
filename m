Return-Path: <netdev+bounces-46269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753CA7E2FB8
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8731C209AF
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A32F507;
	Mon,  6 Nov 2023 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rztknBbU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E52EB18
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:19:03 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C16D7C
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:19:01 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba9bd62fdfso1523420241.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699309140; x=1699913940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVe8tsFd38G8mudEItn1e9pUK3iBPROvgvogaV1TSrE=;
        b=rztknBbUbXSOyDwZ6C7H1lXwLoG4e3GVPgRFPgTl6Ou15INJsyIlBBc3a00EyA1L+P
         LrjDrpsgxZVRqpaak7nuW2+O3Nv3SGn5s5pucCQSG3IPQpvy4agM/OcPu1dhCa1C3WVZ
         9G6XlJqgGhtSZIh9+Gh4uBWbTGybODxnEp5PkaCo6czotlkifiDt/+ieHfyCl1wxid3r
         GFWX9Axhpedd3q4kLWWNqWj8PTxWzP9ORQgTWSm7hcprprUcKJBzkGIKcDZ6zQCnj9Ya
         5ruhPo5cN0SaKi/83oj7NOBIy1qYVpwGkBi6emigcnb0VO3bYzS6i7dJ3N64aBXngTLJ
         yu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309140; x=1699913940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVe8tsFd38G8mudEItn1e9pUK3iBPROvgvogaV1TSrE=;
        b=dJfIpoLaxfNdmrZCSsdeWCSF7rEz9GWkrS7aTbYsH9bg1g+BnbMZIElfAWeFY4fWfY
         yu4noj8XnOp3tdq4T0tLx/Zbrc9KA3L8Yh5+6WMs67td8o9u1E3+Klw7Kru2cRAHCA/7
         VxcbzIBZqNuKb92Wt3w0+afoNPOwZQhpDB4jt5YjfvpDYXIyaiGvZOEcExkjYuzPAj1L
         jUodYlPuxi6oeOydHkDY2/snDYXQqbzZswdSVhmCQ69fzmQ0twE1HFSVhMKRXhlfNgBY
         FSAfFZK+uiKnzux8gpMeWOfuIMFSzBlnl7tPlIlZYKuGxslCdxbV0V5lwmZJlzX+nHtT
         uk+A==
X-Gm-Message-State: AOJu0YxA1r3BnFEBnzJwiNn6i1DrA5EySt+6PNozkF8RmmM57SYZyF0H
	f1yfmfrA7onxN34q7Hm/36jhAxPQK4jcciYp5e1jZw==
X-Google-Smtp-Source: AGHT+IETz+GjKs7UxN4zP1XHdksBZh5d6q/RDjmzyDBzuwUW4rr3rEfHXLef56zICeXwbmmbul0YyFrTOhim5/h2TIY=
X-Received: by 2002:a67:e11c:0:b0:452:d9d4:a056 with SMTP id
 d28-20020a67e11c000000b00452d9d4a056mr24216370vsl.26.1699309139903; Mon, 06
 Nov 2023 14:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com>
In-Reply-To: <ZUlhu4hlTaqR3CTh@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 14:18:46 -0800
Message-ID: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Stanislav Fomichev <sdf@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 11/06, Mina Almasry wrote:
> > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kernel.org=
> wrote:
> > >
> > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > On 11/05, Mina Almasry wrote:
> > > >> For device memory TCP, we expect the skb headers to be available i=
n host
> > > >> memory for access, and we expect the skb frags to be in device mem=
ory
> > > >> and unaccessible to the host. We expect there to be no mixing and
> > > >> matching of device memory frags (unaccessible) with host memory fr=
ags
> > > >> (accessible) in the same skb.
> > > >>
> > > >> Add a skb->devmem flag which indicates whether the frags in this s=
kb
> > > >> are device memory frags or not.
> > > >>
> > > >> __skb_fill_page_desc() now checks frags added to skbs for page_poo=
l_iovs,
> > > >> and marks the skb as skb->devmem accordingly.
> > > >>
> > > >> Add checks through the network stack to avoid accessing the frags =
of
> > > >> devmem skbs and avoid coalescing devmem skbs with non devmem skbs.
> > > >>
> > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > >>
> > > >> ---
> > > >>  include/linux/skbuff.h | 14 +++++++-
> > > >>  include/net/tcp.h      |  5 +--
> > > >>  net/core/datagram.c    |  6 ++++
> > > >>  net/core/gro.c         |  5 ++-
> > > >>  net/core/skbuff.c      | 77 ++++++++++++++++++++++++++++++++++++-=
-----
> > > >>  net/ipv4/tcp.c         |  6 ++++
> > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > >>  net/packet/af_packet.c |  4 +--
> > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > >>
> > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > >> index 1fae276c1353..8fb468ff8115 100644
> > > >> --- a/include/linux/skbuff.h
> > > >> +++ b/include/linux/skbuff.h
> > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > > >>   *  @csum_level: indicates the number of consecutive checksums fo=
und in
> > > >>   *          the packet minus one that have been verified as
> > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > >> + *  @devmem: indicates that all the fragments in this skb are bac=
ked by
> > > >> + *          device memory.
> > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > >>   *  @decrypted: Decrypted SKB
> > > >>   *  @slow_gro: state present at GRO time, slower prepare step req=
uired
> > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > >>      __u8                    csum_not_inet:1;
> > > >>  #endif
> > > >> -
> > > >> +    __u8                    devmem:1;
> > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> > > >>      __u16                   tc_index;       /* traffic control in=
dex */
> > > >>  #endif
> > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_mana=
ged(struct sk_buff *skb)
> > > >>              __skb_zcopy_downgrade_managed(skb);
> > > >>  }
> > > >>
> > > >> +/* Return true if frags in this skb are not readable by the host.=
 */
> > > >> +static inline bool skb_frags_not_readable(const struct sk_buff *s=
kb)
> > > >> +{
> > > >> +    return skb->devmem;
> > > >
> > > > bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_r=
eadable'?
> > > > It better communicates the fact that the stack shouldn't dereferenc=
e the
> > > > frags (because it has 'devmem' fragments or for some other potentia=
l
> > > > future reason).
> > >
> > > +1.
> > >
> > > Also, the flag on the skb is an optimization - a high level signal th=
at
> > > one or more frags is in unreadable memory. There is no requirement th=
at
> > > all of the frags are in the same memory type.
>
> David: maybe there should be such a requirement (that they all are
> unreadable)? Might be easier to support initially; we can relax later
> on.
>

Currently devmem =3D=3D not_readable, and the restriction is that all the
frags in the same skb must be either all readable or all unreadable
(all devmem or all non-devmem).

> > The flag indicates that the skb contains all devmem dma-buf memory
> > specifically, not generic 'not_readable' frags as the comment says:
> >
> > + *     @devmem: indicates that all the fragments in this skb are backe=
d by
> > + *             device memory.
> >
> > The reason it's not a generic 'not_readable' flag is because handing
> > off a generic not_readable skb to the userspace is semantically not
> > what we're doing. recvmsg() is augmented in this patch series to
> > return a devmem skb to the user via a cmsg_devmem struct which refers
> > specifically to the memory in the dma-buf. recvmsg() in this patch
> > series is not augmented to give any 'not_readable' skb to the
> > userspace.
> >
> > IMHO skb->devmem + an skb_frags_not_readable() as implemented is
> > correct. If a new type of unreadable skbs are introduced to the stack,
> > I imagine the stack would implement:
> >
> > 1. new header flag: skb->newmem
> > 2.
> >
> > static inline bool skb_frags_not_readable(const struct skb_buff *skb)
> > {
> >     return skb->devmem || skb->newmem;
> > }
> >
> > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in this patch
> > series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.
>
> You copy it to the userspace in a special way because your frags
> are page_is_page_pool_iov(). I agree with David, the skb bit is
> just and optimization.
>
> For most of the core stack, it doesn't matter why your skb is not
> readable. For a few places where it matters (recvmsg?), you can
> double-check your frags (all or some) with page_is_page_pool_iov.
>

I see, we can do that then. I.e. make the header flag 'not_readable'
and check the frags to decide to delegate to tcp_recvmsg_devmem() or
something else. We can even assume not_readable =3D=3D devmem because
currently devmem is the only type of unreadable frag currently.

> Unrelated: we probably need socket to dmabuf association as well (via
> netlink or something).

Not sure this is possible. The dma-buf is bound to the rx-queue, and
any packets that land on that rx-queue are bound to that dma-buf,
regardless of which socket that packet belongs to. So the association
IMO must be rx-queue to dma-buf, not socket to dma-buf.

> We are fundamentally receiving into and sending from a dmabuf (devmem =3D=
=3D
> dmabuf).
> And once you have this association, recvmsg shouldn't need any new
> special flags.


--=20
Thanks,
Mina

