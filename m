Return-Path: <netdev+bounces-59837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07181C321
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 03:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3441F2500B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220876D6F4;
	Fri, 22 Dec 2023 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIiQm7Mx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875C29A2
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703212522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9z6L6ey7JbOtFUR6jZ6N2AL2ixhO+eS9tFlq+uZiyA=;
	b=CIiQm7MxGro75TvMb8HbblYCFRVTCjp6YZeoHZ1cV+MmiszXkmQdXFa9jzTnP9vowZrSjN
	v9lfd7imlbcaF3nBuIjfZuF2i7SOEIRfsTxzg0dBIn2isiVYmfrE2OhX+W2dHKAXqCHKAb
	smKwDGjlOcW9H+mJu9sLGmX4MFPpAlw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-x-5Noah5MmypGqttQw_gzA-1; Thu, 21 Dec 2023 21:35:21 -0500
X-MC-Unique: x-5Noah5MmypGqttQw_gzA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bb8a2d8df9so246523b6e.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703212520; x=1703817320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9z6L6ey7JbOtFUR6jZ6N2AL2ixhO+eS9tFlq+uZiyA=;
        b=MKjmWyesVPBz83JRqwmfLhd7kwAsoDP+bVl4t/0UZRvIMRaxE6/cMkgmTTUJaMjJo/
         EBK1sqK6A/4NXY9oEuq3qRszZPMQgHIQ3M3KTvY+0ADvP94VaLS7hVwjcUKfE0CL7ZHA
         mInnO7rzG41DjeK9pKTSUbCA5zMw6hks0ZGtcojsYcOIyMp3AN/OSg4alv5EJjtxUILi
         uJSb4SO1qrE3LY6BQVySNbDO0JxS5a9zYzfpQ79xio79m1ISEVKcwhWXhAdRQ9RjVIyL
         SDb7xxXU1pqCU4MpA5D6QG8vwzhXaN+51BIlfCE+ldQJC7AyC8ywLzlxvkg1bzY/fe6j
         DSZg==
X-Gm-Message-State: AOJu0YywbDgw19OPyvOimFiGksMz0+LZIqd9jdjbnru016uWx2rUCDJk
	XWGDQXqTgr73ZL0rqkaMc/gwTI5LYytHGCx/X84etfbRojSAN5h5Yr6nQJa7YnO7ugYkHwuMeLa
	EF8H/nc9+hlzWYcMtVDu59J7eLEZY+qJVc14c66cj
X-Received: by 2002:a05:6808:2dc4:b0:3b9:e537:860d with SMTP id gn4-20020a0568082dc400b003b9e537860dmr918012oib.102.1703212520540;
        Thu, 21 Dec 2023 18:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQ4V1pLjCf0GWjudKMk1QY0eW7XKH0Yj52OXCX7T4cxPR/8rwiBFz6wvwzDgxwJ0hkzr8rnhfQdI0hCMrzBg=
X-Received: by 2002:a05:6808:2dc4:b0:3b9:e537:860d with SMTP id
 gn4-20020a0568082dc400b003b9e537860dmr917994oib.102.1703212520268; Thu, 21
 Dec 2023 18:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2023 10:35:07 +0800
Message-ID: <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Heng Qi wrote:
> >
> >
> > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =E5=86=
=99=E9=81=93:
> > > Heng Qi wrote:
> > >> virtio-net has two ways to switch napi_tx: one is through the
> > >> module parameter, and the other is through coalescing parameter
> > >> settings (provided that the nic status is down).
> > >>
> > >> Sometimes we face performance regression caused by napi_tx,
> > >> then we need to switch napi_tx when debugging. However, the
> > >> existing methods are a bit troublesome, such as needing to
> > >> reload the driver or turn off the network card.

Why is this troublesome? We don't need to turn off the card, it's just
a toggling of the interface.

This ends up with pretty simple code.

> So try to make
> > >> this update.
> > >>
> > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > The commit does not explain why it is safe to do so.
> >
> > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > no new tx napi will be scheduled.
> >
> > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > send the packet.
> >
> > Then we can safely toggle the weight to indicate where to clear the buf=
fers.
> >
> > >
> > > The tx-napi weights are not really weights: it is a boolean whether
> > > napi is used for transmit cleaning, or whether packets are cleaned
> > > in ndo_start_xmit.
> >
> > Right.
> >
> > >
> > > There certainly are some subtle issues with regard to pausing/waking
> > > queues when switching between modes.
> >
> > What are "subtle issues" and if there are any, we find them.
>
> A single runtime test is not sufficient to exercise all edge cases.
>
> Please don't leave it to reviewers to establish the correctness of a
> patch.

+1

And instead of trying to do this, it would be much better to optimize
the NAPI performance. Then we can drop the orphan mode.

>
> The napi_tx and non-napi code paths differ in how they handle at least
> the following structures:
>
> 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
> needed as delay until the next ndo_start_xmit and thus completion is
> unbounded.
>
> When switching to napi mode, orphaned skbs may now be cleaned by the
> napi handler. This is indeed safe.
>
> When switching from napi to non-napi, the unbound latency resurfaces.
> It is a small edge case, and I think a potentially acceptable risk, if
> the user of this knob is aware of the risk.
>
> 2. virtqueue callback ("interrupt" masking). The non-napi path enables
> the interrupt (disables the mask) when available descriptors falls
> beneath a low watermark, and reenables when it recovers above a high
> watermark. Napi disables when napi is scheduled, and reenables on
> napi complete.
>
> 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> a low watermark, the driver stops the stack for queuing more packets.
> In napi mode, it schedules napi to clean packets. See the calls to
> netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> netif_tx_wake_queue.
>
> Some if this can be assumed safe by looking at existing analogous
> code, such as the queue stop/start in virtnet_tx_resize.
>
> But that all virtqueue callback and dev_queue->state transitions are
> correct when switching between modes at runtime is not trivial to
> establish, deserves some thought and explanation in the commit
> message.

Thanks


