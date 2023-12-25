Return-Path: <netdev+bounces-60157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E781DE12
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 05:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253CB1F2122C
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 04:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C345ED1;
	Mon, 25 Dec 2023 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOcll6ev"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B8EA6
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703477699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33FAc0WEwTbg2UMGsuBoi+7e1xe2LV80bB+5hU/sZPA=;
	b=EOcll6ev63aHPhT8NOqAVNXT8dNZNPAoXdSTw3KGr42TXKmrKruaMZwTzyWXNXi+FH4tgr
	EViZekyqS3Sn1uqTirJUnp84h1NGGvXRfnWDPfLcrJ0csk/mR9crM+nSvtYlqEzrjaKn/3
	bPixaEzKP8BBoHeSJkJcUPIDMVGTGRo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-8mlryjLAPTGwr_Vb-ghDEQ-1; Sun, 24 Dec 2023 23:14:58 -0500
X-MC-Unique: 8mlryjLAPTGwr_Vb-ghDEQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce10b4cea9so570455a12.1
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 20:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703477697; x=1704082497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33FAc0WEwTbg2UMGsuBoi+7e1xe2LV80bB+5hU/sZPA=;
        b=WiOyFTSyLyW3Hi4A3gq4DAweYl6vcnzzEMTUFvIXW+4E7eptY2j0qX5FaoGgAHF/Zo
         pKGGUypv8c4h/OKL7Ecrbsh2k2tb1sGTxYfpy8gsZrEToPHmmp6t+RS9iWLSGDA4Zbpw
         zoIH616WLWr3UUtCR/gNFc83xsaSKKxlmVBsnt/nX9PMD0LWkOQ5fDw1VqXUtvBuYh1/
         L8RUR7YAD3+iVbdbBpK93WtbA8nZBXUWrdqTb9H7g8J95ZenUHstRJxIAyOdhzA43fvX
         p6ZrgNmo0gKbTZynXKZHOq3fPGSS5eUIoOgrw4PIlWiaW5rTgWiPWHKYmIccepoBFAHa
         vN8w==
X-Gm-Message-State: AOJu0Yz1duHgyObSvK8UyXrMbQHRGoqbDOuZtZ2j/PO8MAOK1AaLLwY3
	ZFEtv1QAHMQmXh6GU0nRx8ds7ax9OEVUkO/xhPG1ObfTJlwA5GmZ8AxsUhNKYtn1VbcFacY9O0t
	1nQUHayskCtxza1p57S7YgYg0a2bltqxNnpwjj0aN
X-Received: by 2002:a05:6a20:109f:b0:195:fd1:104a with SMTP id w31-20020a056a20109f00b001950fd1104amr4326565pze.24.1703477697040;
        Sun, 24 Dec 2023 20:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHWZqen9JynZ2YTW9WAokGJQ4DxOKyRJ+nBVloh6rApg8yD3xhSDxgCCagmqs+lZu0swvTqExINEkW/NZqUUY=
X-Received: by 2002:a05:6a20:109f:b0:195:fd1:104a with SMTP id
 w31-20020a056a20109f00b001950fd1104amr4326557pze.24.1703477696748; Sun, 24
 Dec 2023 20:14:56 -0800 (PST)
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
In-Reply-To: <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 12:14:45 +0800
Message-ID: <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Jason,
> On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
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
> [...]
> > And instead of trying to do this, it would be much better to optimize
> > the NAPI performance. Then we can drop the orphan mode.
>
> Do you mean when to call skb_orphan()? If yes, I just want to provide
> more information that we also have some performance issues where the
> flow control takes a bad effect, especially under some small
> throughput in our production environment.

I think you need to describe it in detail.

> What strikes me as odd is if I restart the network, then the issue
> will go with the wind. I cannot reproduce it in my testing machine.
> One more thing: if I force skb_orphan() the current skb in every
> start_xmit(), it could also solve the issue but not in a proper way.
> After all, it drops the flow control... :S

Yes, that's the known issue.

Thanks

>
> Thanks,
> Jason
> >
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
> >
> >
>


