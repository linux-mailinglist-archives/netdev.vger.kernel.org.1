Return-Path: <netdev+bounces-46281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448AC7E3042
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3E1B20A5A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803962D7B4;
	Mon,  6 Nov 2023 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMybHmxy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67A1CF95
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:59:30 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C5DD78
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:59:28 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc2ebc3b3eso30678445ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699311568; x=1699916368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty0cyfe+Vdfqcpj6+34AODX2kjBa+Pq2AOWiLNF5fCk=;
        b=WMybHmxyqcdSlX+KGYCMv2eSnUJP7D7cNwKBcMwz6fcSKiz9UnBfXECsEQYgjpBfBf
         msskmePJbkQjjXAfUmVTAG7pIvLaNZi2r2Nr4RuKPxsfX6bvoE3dWNLXU6RxSf+WRYNm
         viI3OiC1uvDDvOGSI1DxkKZh08E0aLJSyYorxzFdb9Cz3pkK2PJrAawleuHSRmbX7SEr
         eBxg9vo9RGpPoHWKbDKfApLmCCuCzSKiQ3JnogHYgHrOpZqmPL4yQLWx5PjRfd8qDZNa
         NTmu8TxoKRWu5nsm4ZNdsQLNfh7cXJM5b0Aq9w20gu9PldczqXHBB3YLFwPPUWzoCwIW
         cvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311568; x=1699916368;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ty0cyfe+Vdfqcpj6+34AODX2kjBa+Pq2AOWiLNF5fCk=;
        b=Nthx7Tw4XRO3OOs8dDqi1NbY0pXf3R5sNNgXp+dn4C7+tXcoyERpHEv7l+vQoOUiJM
         T0eNrwXHFJtOpyBYchq72NG5lGy+eQ/ILRvo/VYmfGPV2y+YrdNgctFlYDcCkiQGkurV
         o6CdT0tvqUCU1fdw8iCmtbIZ4kIUyR5eAkGFvB+6bnGuIqMftBxwq5PDXzJYaAAnvdex
         7sfh08Yp72rQqno/zs4dYk9IDFUehhdp1Fg39PSqHetevkRx8KRsGL7HSAPjqBxvU10D
         zbS4wU47fYDUxnCE/zz/0f0G4r+eAwWtpzsA/lHBMJX51sPKtKlR16WBDemd6Fn1EVGn
         gbzw==
X-Gm-Message-State: AOJu0YxJk9lXis2Ja4PD9E9X9OLVXAUdQVCEv1w+XwwnwkNyKbjxM7EY
	4qyqfI0V2x0aNikMRE8iXm97GSw=
X-Google-Smtp-Source: AGHT+IHI7VpzkR1zbFlqsvGksOW2FuNvrPzGHxxYeLg5/v7KL44Nh11FYoBtcp/75evNVWcmQtSD4pU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:3303:b0:1cc:38e0:dbab with SMTP id
 jk3-20020a170903330300b001cc38e0dbabmr475809plb.3.1699311567832; Mon, 06 Nov
 2023 14:59:27 -0800 (PST)
Date: Mon, 6 Nov 2023 14:59:26 -0800
In-Reply-To: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
Message-ID: <ZUlvzm24SA3YjirV@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From: Stanislav Fomichev <sdf@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/06, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 11/06, Mina Almasry wrote:
> > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kernel.o=
rg> wrote:
> > > >
> > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > On 11/05, Mina Almasry wrote:
> > > > >> For device memory TCP, we expect the skb headers to be available=
 in host
> > > > >> memory for access, and we expect the skb frags to be in device m=
emory
> > > > >> and unaccessible to the host. We expect there to be no mixing an=
d
> > > > >> matching of device memory frags (unaccessible) with host memory =
frags
> > > > >> (accessible) in the same skb.
> > > > >>
> > > > >> Add a skb->devmem flag which indicates whether the frags in this=
 skb
> > > > >> are device memory frags or not.
> > > > >>
> > > > >> __skb_fill_page_desc() now checks frags added to skbs for page_p=
ool_iovs,
> > > > >> and marks the skb as skb->devmem accordingly.
> > > > >>
> > > > >> Add checks through the network stack to avoid accessing the frag=
s of
> > > > >> devmem skbs and avoid coalescing devmem skbs with non devmem skb=
s.
> > > > >>
> > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > >>
> > > > >> ---
> > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > >>  include/net/tcp.h      |  5 +--
> > > > >>  net/core/datagram.c    |  6 ++++
> > > > >>  net/core/gro.c         |  5 ++-
> > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++++++++++++=
+------
> > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > >>  net/packet/af_packet.c |  4 +--
> > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > >>
> > > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > >> --- a/include/linux/skbuff.h
> > > > >> +++ b/include/linux/skbuff.h
> > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > > > >>   *  @csum_level: indicates the number of consecutive checksums =
found in
> > > > >>   *          the packet minus one that have been verified as
> > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > >> + *  @devmem: indicates that all the fragments in this skb are b=
acked by
> > > > >> + *          device memory.
> > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > >>   *  @decrypted: Decrypted SKB
> > > > >>   *  @slow_gro: state present at GRO time, slower prepare step r=
equired
> > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > >>      __u8                    csum_not_inet:1;
> > > > >>  #endif
> > > > >> -
> > > > >> +    __u8                    devmem:1;
> > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> > > > >>      __u16                   tc_index;       /* traffic control =
index */
> > > > >>  #endif
> > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_ma=
naged(struct sk_buff *skb)
> > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > >>  }
> > > > >>
> > > > >> +/* Return true if frags in this skb are not readable by the hos=
t. */
> > > > >> +static inline bool skb_frags_not_readable(const struct sk_buff =
*skb)
> > > > >> +{
> > > > >> +    return skb->devmem;
> > > > >
> > > > > bikeshedding: should we also rename 'devmem' sk_buff flag to 'not=
_readable'?
> > > > > It better communicates the fact that the stack shouldn't derefere=
nce the
> > > > > frags (because it has 'devmem' fragments or for some other potent=
ial
> > > > > future reason).
> > > >
> > > > +1.
> > > >
> > > > Also, the flag on the skb is an optimization - a high level signal =
that
> > > > one or more frags is in unreadable memory. There is no requirement =
that
> > > > all of the frags are in the same memory type.
> >
> > David: maybe there should be such a requirement (that they all are
> > unreadable)? Might be easier to support initially; we can relax later
> > on.
> >
>=20
> Currently devmem =3D=3D not_readable, and the restriction is that all the
> frags in the same skb must be either all readable or all unreadable
> (all devmem or all non-devmem).
>=20
> > > The flag indicates that the skb contains all devmem dma-buf memory
> > > specifically, not generic 'not_readable' frags as the comment says:
> > >
> > > + *     @devmem: indicates that all the fragments in this skb are bac=
ked by
> > > + *             device memory.
> > >
> > > The reason it's not a generic 'not_readable' flag is because handing
> > > off a generic not_readable skb to the userspace is semantically not
> > > what we're doing. recvmsg() is augmented in this patch series to
> > > return a devmem skb to the user via a cmsg_devmem struct which refers
> > > specifically to the memory in the dma-buf. recvmsg() in this patch
> > > series is not augmented to give any 'not_readable' skb to the
> > > userspace.
> > >
> > > IMHO skb->devmem + an skb_frags_not_readable() as implemented is
> > > correct. If a new type of unreadable skbs are introduced to the stack=
,
> > > I imagine the stack would implement:
> > >
> > > 1. new header flag: skb->newmem
> > > 2.
> > >
> > > static inline bool skb_frags_not_readable(const struct skb_buff *skb)
> > > {
> > >     return skb->devmem || skb->newmem;
> > > }
> > >
> > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in this patc=
h
> > > series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.
> >
> > You copy it to the userspace in a special way because your frags
> > are page_is_page_pool_iov(). I agree with David, the skb bit is
> > just and optimization.
> >
> > For most of the core stack, it doesn't matter why your skb is not
> > readable. For a few places where it matters (recvmsg?), you can
> > double-check your frags (all or some) with page_is_page_pool_iov.
> >
>=20
> I see, we can do that then. I.e. make the header flag 'not_readable'
> and check the frags to decide to delegate to tcp_recvmsg_devmem() or
> something else. We can even assume not_readable =3D=3D devmem because
> currently devmem is the only type of unreadable frag currently.
>=20
> > Unrelated: we probably need socket to dmabuf association as well (via
> > netlink or something).
>=20
> Not sure this is possible. The dma-buf is bound to the rx-queue, and
> any packets that land on that rx-queue are bound to that dma-buf,
> regardless of which socket that packet belongs to. So the association
> IMO must be rx-queue to dma-buf, not socket to dma-buf.

But there is still always 1 dmabuf to 1 socket association (on rx), right?
Because otherwise, there is no way currently to tell, at recvmsg, which
dmabuf the received token belongs to.

So why not have a separate control channel action to say: this socket fd
is supposed to receive into this dmabuf fd? This action would put
the socket into permanent 'MSG_SOCK_DEVMEM' mode. Maybe you can also
put some checks at the lower level to to enforce this dmabuf
association. (to avoid any potential issues with flow steering)

We'll still have dmabuf to rx-queue association because of various reasons.=
.

