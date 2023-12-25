Return-Path: <netdev+bounces-60156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE481DE10
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 05:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D180C1C20B30
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EAA51;
	Mon, 25 Dec 2023 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6ixUz8j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C367489
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703477582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFoTY6b03xbq0VaHKBl1A88a4qKRBJ1TFj0E7CCdM8Y=;
	b=M6ixUz8jkAkJboKmR1cwvqPfVlFw6GTKT3nW0XIKXTCYLQICoyzDe7pb83D/U8MabyUKrs
	84f0MU4AKBnKf8tUg/twcFzwkGGxiepOUvh+H/zUT3lzkgbkwfDSZOpjXPr1E4TOBQVXDU
	Lg5KeaS3fKWpXmRvY5AXwboJmhUA7T4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-_0rxLhjdO5SVPXrzAmGN2w-1; Sun, 24 Dec 2023 23:13:00 -0500
X-MC-Unique: _0rxLhjdO5SVPXrzAmGN2w-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20426695791so4481005fac.2
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 20:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703477580; x=1704082380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFoTY6b03xbq0VaHKBl1A88a4qKRBJ1TFj0E7CCdM8Y=;
        b=Y3LonSl71sTGu/HytLyKgL6byDuVPTKfSP4dr43Ss9qDJF40TcbPUSugBsDRXHNyK3
         zkJff3aKd4qw6biLxevIUrAoHKfOveWXgKQMq428V7GuKdFbWyk621J5LJ9H1mx9zuRd
         Zrn8G99AHfnT2kIRmKxy/2DiDzUk11RbvudKHBvDBDv8LjfImFPyCmZsA9U/xXvA6BMJ
         1x23XD41hCO/N7o/8XrXWKbFRqykwb+lAPjkjqC+eu2PD72WLImMhjS7+kxBH4BdECXc
         LzQP7xORjxhvhWfqkKeq5xdo+OhYlXjVPcuIk2PV0+NgJyK73RWbKCRv8YdLl3xhV0JB
         tG5Q==
X-Gm-Message-State: AOJu0YyMDa870B1+dwUAAiSOC1ghJO1MwE04mwfpD5kmKPXcEFYWom1k
	P7M+LZo4drUbx9iG2hatkntBuaB2FuqMHeScI5pwkgnTyKwAbi4fI82SazNRUgOOBxDP+KkXGDR
	HquO/LUs6eZiHX8SLqCK1avCwGFE/t71qp03Y6V5J
X-Received: by 2002:a05:6870:a70a:b0:204:4160:6634 with SMTP id g10-20020a056870a70a00b0020441606634mr5612928oam.46.1703477580072;
        Sun, 24 Dec 2023 20:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEMNp5s++3ahd6zEyAbh/zOppG/O9KQ0VVCKhianOFO2YTK2NCpYDEVmZYR9tk8u33FMCCDHDZVl9vacTWGfk=
X-Received: by 2002:a05:6870:a70a:b0:204:4160:6634 with SMTP id
 g10-20020a056870a70a00b0020441606634mr5612919oam.46.1703477579781; Sun, 24
 Dec 2023 20:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <20231222031024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231222031024-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 12:12:48 +0800
Message-ID: <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 4:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Heng Qi wrote:
> > > >
> > > >
> > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =E5=
=86=99=E9=81=93:
> > > > > Heng Qi wrote:
> > > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > > >> module parameter, and the other is through coalescing parameter
> > > > >> settings (provided that the nic status is down).
> > > > >>
> > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > >> then we need to switch napi_tx when debugging. However, the
> > > > >> existing methods are a bit troublesome, such as needing to
> > > > >> reload the driver or turn off the network card.
> >
> > Why is this troublesome? We don't need to turn off the card, it's just
> > a toggling of the interface.
> >
> > This ends up with pretty simple code.
> >
> > > So try to make
> > > > >> this update.
> > > > >>
> > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > The commit does not explain why it is safe to do so.
> > > >
> > > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends=
 and
> > > > no new tx napi will be scheduled.
> > > >
> > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack canno=
t
> > > > send the packet.
> > > >
> > > > Then we can safely toggle the weight to indicate where to clear the=
 buffers.
> > > >
> > > > >
> > > > > The tx-napi weights are not really weights: it is a boolean wheth=
er
> > > > > napi is used for transmit cleaning, or whether packets are cleane=
d
> > > > > in ndo_start_xmit.
> > > >
> > > > Right.
> > > >
> > > > >
> > > > > There certainly are some subtle issues with regard to pausing/wak=
ing
> > > > > queues when switching between modes.
> > > >
> > > > What are "subtle issues" and if there are any, we find them.
> > >
> > > A single runtime test is not sufficient to exercise all edge cases.
> > >
> > > Please don't leave it to reviewers to establish the correctness of a
> > > patch.
> >
> > +1
> >
> > And instead of trying to do this, it would be much better to optimize
> > the NAPI performance. Then we can drop the orphan mode.
>
> "To address your problem, optimize our code to the level which we
> couldn't achieve in more than 10 years".

Last time QE didn't report any issue for TCP. For others, the code
might just need some optimization if it really matters, it's just
because nobody has worked on this part in the past years.

The ethtool trick is just for debugging purposes, I can hardly believe
it is used by any management layer software.

> That's not a reasonable
> requirement. Not getting an interrupt will always be better for some
> workloads.

So NAPI has been enabled by default for many years. And most of the
NIC doesn't do orphans. Orphan has known issues like pktgen and
others. Keeping two modes may result in tricky code and complicate the
features like BQL [1]. We would have interrupt coalescing and dim
soon. Admin can enable the heuristic or tweak it according to the
workload which is much more user friendly than orphaning.

I don't see a strong point to keep the orphan mode any more
considering the advantages of NAPI.

Thanks

[1] https://lore.kernel.org/lkml/20181205225323.12555-2-mst@redhat.com/



>
>
> > >
> > > The napi_tx and non-napi code paths differ in how they handle at leas=
t
> > > the following structures:
> > >
> > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this i=
s
> > > needed as delay until the next ndo_start_xmit and thus completion is
> > > unbounded.
> > >
> > > When switching to napi mode, orphaned skbs may now be cleaned by the
> > > napi handler. This is indeed safe.
> > >
> > > When switching from napi to non-napi, the unbound latency resurfaces.
> > > It is a small edge case, and I think a potentially acceptable risk, i=
f
> > > the user of this knob is aware of the risk.
> > >
> > > 2. virtqueue callback ("interrupt" masking). The non-napi path enable=
s
> > > the interrupt (disables the mask) when available descriptors falls
> > > beneath a low watermark, and reenables when it recovers above a high
> > > watermark. Napi disables when napi is scheduled, and reenables on
> > > napi complete.
> > >
> > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > > a low watermark, the driver stops the stack for queuing more packets.
> > > In napi mode, it schedules napi to clean packets. See the calls to
> > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > > netif_tx_wake_queue.
> > >
> > > Some if this can be assumed safe by looking at existing analogous
> > > code, such as the queue stop/start in virtnet_tx_resize.
> > >
> > > But that all virtqueue callback and dev_queue->state transitions are
> > > correct when switching between modes at runtime is not trivial to
> > > establish, deserves some thought and explanation in the commit
> > > message.
> >
> > Thanks
>


