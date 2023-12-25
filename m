Return-Path: <netdev+bounces-60160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B481DEA4
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 07:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130852815C7
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4515110E;
	Mon, 25 Dec 2023 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMu8/LGp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4D3D63
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703486711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmtImPcIoJ1LGqQ77I/n9yZ5QbLq+pXgyPpHJK1YtUg=;
	b=BMu8/LGp7FBJGHLly5jwaTmS00TOy/xVDJ16xCzr2/MMUyzUmb7SUz9rpe5p6Rwc+tf9hq
	V29G1hKTIWT350n3HYyltkEumYwwWtKPz+a5Vn3K4cVWepZta54zpjAy6/EXib5Exnzwqq
	3qAVE4BrwHnwqGipGJbkKjzO9fzHVVQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-tVswOJGhNL-gjf753MxOsA-1; Mon, 25 Dec 2023 01:45:09 -0500
X-MC-Unique: tVswOJGhNL-gjf753MxOsA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9fe1a9f16so3975274b6e.3
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 22:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486708; x=1704091508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmtImPcIoJ1LGqQ77I/n9yZ5QbLq+pXgyPpHJK1YtUg=;
        b=WOXMpgvzVI0rfvwWy+XbYTC82uuzbqVNKluuJ8iWi4pUaiI2iATadNCuyvJqeLhYlC
         BqDRD3oQ0ZWswncjWppETVIcQaH/frAV6MOVFb979jdm4L5ZPXNa2xSSjkOiUumwZoTz
         uzdyUyvrOdJsegp0bY4IHB8Zd4fjqKMuY6hXgGl4z54eeUXkzW0pabY+jX2JkBsMBmoA
         ovG6mxqo8EpQ9SRywnpxSmu+RlpxkkRzMSJjwPqKH98RFxxZdnYZAyJeIEHLPVbcnnwS
         682JSDNoWRoJtdkISFBrlCJWTd384d5Aw5g0tNUOe+WpxRMdV7yfxYo297ofHQ4HhMbF
         vlIw==
X-Gm-Message-State: AOJu0Yw1gAPv7JW5fHDLuWkucZixRKoqEYriFB9jMWbmDIZ/OhsWzynI
	pb/bXyX5SLa8tzo0/NwxOuat7UN70cNEEGhwWqdc3qESC6KeRan4V1r+GOhlbjX+3ILV54Qqm17
	zMfWx4CFhs+R7DUjEd3B4bCoP1yTUTKnVh8/EifpeXbbQl5K1h1U=
X-Received: by 2002:a05:6808:2118:b0:3bb:8522:dba0 with SMTP id r24-20020a056808211800b003bb8522dba0mr5969401oiw.112.1703486708371;
        Sun, 24 Dec 2023 22:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDDjdG0E4rbWENM0XwXtvhozKjVakj52ReAo9xKUNnOo1aUueOtsVVgVodGV0+LniXB5cZZmnMx39GWiJ+ylo=
X-Received: by 2002:a05:6808:2118:b0:3bb:8522:dba0 with SMTP id
 r24-20020a056808211800b003bb8522dba0mr5969385oiw.112.1703486708117; Sun, 24
 Dec 2023 22:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com>
 <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com> <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
In-Reply-To: <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 14:44:56 +0800
Message-ID: <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 2:34=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > Hello Jason,
> > > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Heng Qi wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =
=E5=86=99=E9=81=93:
> > > > > > > Heng Qi wrote:
> > > > > > >> virtio-net has two ways to switch napi_tx: one is through th=
e
> > > > > > >> module parameter, and the other is through coalescing parame=
ter
> > > > > > >> settings (provided that the nic status is down).
> > > > > > >>
> > > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > > >> reload the driver or turn off the network card.
> > > >
> > > > Why is this troublesome? We don't need to turn off the card, it's j=
ust
> > > > a toggling of the interface.
> > > >
> > > > This ends up with pretty simple code.
> > > >
> > > > > So try to make
> > > > > > >> this update.
> > > > > > >>
> > > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > The commit does not explain why it is safe to do so.
> > > > > >
> > > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi =
ends and
> > > > > > no new tx napi will be scheduled.
> > > > > >
> > > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack c=
annot
> > > > > > send the packet.
> > > > > >
> > > > > > Then we can safely toggle the weight to indicate where to clear=
 the buffers.
> > > > > >
> > > > > > >
> > > > > > > The tx-napi weights are not really weights: it is a boolean w=
hether
> > > > > > > napi is used for transmit cleaning, or whether packets are cl=
eaned
> > > > > > > in ndo_start_xmit.
> > > > > >
> > > > > > Right.
> > > > > >
> > > > > > >
> > > > > > > There certainly are some subtle issues with regard to pausing=
/waking
> > > > > > > queues when switching between modes.
> > > > > >
> > > > > > What are "subtle issues" and if there are any, we find them.
> > > > >
> > > > > A single runtime test is not sufficient to exercise all edge case=
s.
> > > > >
> > > > > Please don't leave it to reviewers to establish the correctness o=
f a
> > > > > patch.
> > > >
> > > > +1
> > > >
> > > [...]
> > > > And instead of trying to do this, it would be much better to optimi=
ze
> > > > the NAPI performance. Then we can drop the orphan mode.
> > >
> [...]
> > > Do you mean when to call skb_orphan()? If yes, I just want to provide
> > > more information that we also have some performance issues where the
> > > flow control takes a bad effect, especially under some small
> > > throughput in our production environment.
> >
> > I think you need to describe it in detail.
>
> Some of the details were described below in the last email. The
> decreased performance happened because of flow control: the delay of
> skb free means the delay

What do you mean by delay here? Is it an interrupt delay? If yes, Does
it work better if you simply remove

virtqueue_enable_cb_delayed() with virtqueue_enable_cb()? As the
former may delay the interrupt more or less depend on the traffic.

> of decreasing of sk_wmem_alloc, then it will
> hit the limit of TSQ mechanism, finally causing transmitting slowly in
> the TCP layer.

TSQ might work better with BQL which virtio-net doesn't have right now.

>
> >
> > > What strikes me as odd is if I restart the network, then the issue
> > > will go with the wind. I cannot reproduce it in my testing machine.
> > > One more thing: if I force skb_orphan() the current skb in every
> > > start_xmit(), it could also solve the issue but not in a proper way.
> > > After all, it drops the flow control... :S
> >
> > Yes, that's the known issue.
>
> Really? Did you have some numbers or have some discussion links to
> share? I failed to reproduce on my testing machine, probably the short
> rtt is the key/obstacle.

I basically mean it is a known side effect of skb_orphan() as it might
decrease sk_wmem_alloc too early.

Thanks


>
> @Eric, it seems it still exists.
>
> Thanks,
> Jason
>
> >
> > Thanks
> >
> > >
> > > Thanks,
> > > Jason
> > > >
> > > > >
> > > > > The napi_tx and non-napi code paths differ in how they handle at =
least
> > > > > the following structures:
> > > > >
> > > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi th=
is is
> > > > > needed as delay until the next ndo_start_xmit and thus completion=
 is
> > > > > unbounded.
> > > > >
> > > > > When switching to napi mode, orphaned skbs may now be cleaned by =
the
> > > > > napi handler. This is indeed safe.
> > > > >
> > > > > When switching from napi to non-napi, the unbound latency resurfa=
ces.
> > > > > It is a small edge case, and I think a potentially acceptable ris=
k, if
> > > > > the user of this knob is aware of the risk.
> > > > >
> > > > > 2. virtqueue callback ("interrupt" masking). The non-napi path en=
ables
> > > > > the interrupt (disables the mask) when available descriptors fall=
s
> > > > > beneath a low watermark, and reenables when it recovers above a h=
igh
> > > > > watermark. Napi disables when napi is scheduled, and reenables on
> > > > > napi complete.
> > > > >
> > > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls bel=
ow
> > > > > a low watermark, the driver stops the stack for queuing more pack=
ets.
> > > > > In napi mode, it schedules napi to clean packets. See the calls t=
o
> > > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > > > > netif_tx_wake_queue.
> > > > >
> > > > > Some if this can be assumed safe by looking at existing analogous
> > > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > > >
> > > > > But that all virtqueue callback and dev_queue->state transitions =
are
> > > > > correct when switching between modes at runtime is not trivial to
> > > > > establish, deserves some thought and explanation in the commit
> > > > > message.
> > > >
> > > > Thanks
> > > >
> > > >
> > >
> >
>


