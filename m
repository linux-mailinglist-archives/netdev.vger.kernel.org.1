Return-Path: <netdev+bounces-59864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F332C81C652
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AB1F26017
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91257C154;
	Fri, 22 Dec 2023 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHaElf/J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CFC8CA
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703232872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYt+vp9cI2zldDXVJVhhtrTRhB+2Gs2gvyvghl82FwI=;
	b=LHaElf/JVNJ/U8AkXic3xxJq/24FykvMSNXtlrUagbHkLLElKeZL73QjH5TpY958+Jr0Nv
	HuC7GhG/ZMOxCeFthK4ii7gFXmfCsLYpsa1of3ajtY8k2y1lIpgvOiL1mj3nRp9r5GAlmO
	aOLUvb97IdcsmNaAqwKA8q+6yqll1ag=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-cZrgShzdNtKU2XKRpEyyzQ-1; Fri, 22 Dec 2023 03:14:29 -0500
X-MC-Unique: cZrgShzdNtKU2XKRpEyyzQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-336974655ddso94679f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 00:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703232868; x=1703837668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYt+vp9cI2zldDXVJVhhtrTRhB+2Gs2gvyvghl82FwI=;
        b=dQCKbObdCfurEe8lFdfX5hzcdru9RTG6j8Wah5zLv+SUPibpYVQRT42NO8j3SQ/RnU
         cOdDRWz2poexHgwqpRZ9rFpEcVFh8IrYK/wtAcxyWrCkJ/fj8o6o4f6Y91GhUunrE+hF
         3eMslRZRXTFEBZQNbez0AQY57a0HrV281frK/9uiD0vJz8s5iYNrhL6jyttHa0dYGCyM
         PUwF+AoKu3jZs2dzTX1frp6zKmi4HKHe9Fb/jqVVa6aByYmt+7sBcf6yP3eVvv8oOKnF
         EkAjGfJI+3XmiYVoFT21xsceXokDZgzZSMo7phqjJbUvMlRbsc5NLEE4Cu9EGF2tc9+H
         q7iA==
X-Gm-Message-State: AOJu0YzughX87O/C4flBo2yX4YVJ2w76n6aItwCPWo5oJDx9zdd2ieG6
	jHKfPVt2R3Zze+DOzBzio1TG0F5PMGl4XAZY69iPtee+87zRVS7RPvlzHnVIqWDTyeLAi22t8Yr
	KrfMkPBCV+HGa0XblkDe8rFZ1
X-Received: by 2002:a7b:cbd0:0:b0:40b:5e56:7b44 with SMTP id n16-20020a7bcbd0000000b0040b5e567b44mr421681wmi.141.1703232868129;
        Fri, 22 Dec 2023 00:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV3WtDkqPgvfDOIZCUSjLH1E2hRCsCiUvHhJkQr9ie7p17mzKWPDc8k5Yx2v2DIeZvEyrjhg==
X-Received: by 2002:a7b:cbd0:0:b0:40b:5e56:7b44 with SMTP id n16-20020a7bcbd0000000b0040b5e567b44mr421669wmi.141.1703232867761;
        Fri, 22 Dec 2023 00:14:27 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c138a00b0040b45356b72sm13840236wmf.33.2023.12.22.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:14:26 -0800 (PST)
Date: Fri, 22 Dec 2023 03:14:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Message-ID: <20231222031024-mutt-send-email-mst@kernel.org>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
 <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
 <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>

On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> On Thu, Dec 21, 2023 at 11:06 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Heng Qi wrote:
> > >
> > >
> > > 在 2023/12/20 下午10:45, Willem de Bruijn 写道:
> > > > Heng Qi wrote:
> > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > >> module parameter, and the other is through coalescing parameter
> > > >> settings (provided that the nic status is down).
> > > >>
> > > >> Sometimes we face performance regression caused by napi_tx,
> > > >> then we need to switch napi_tx when debugging. However, the
> > > >> existing methods are a bit troublesome, such as needing to
> > > >> reload the driver or turn off the network card.
> 
> Why is this troublesome? We don't need to turn off the card, it's just
> a toggling of the interface.
> 
> This ends up with pretty simple code.
> 
> > So try to make
> > > >> this update.
> > > >>
> > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > The commit does not explain why it is safe to do so.
> > >
> > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > > no new tx napi will be scheduled.
> > >
> > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > > send the packet.
> > >
> > > Then we can safely toggle the weight to indicate where to clear the buffers.
> > >
> > > >
> > > > The tx-napi weights are not really weights: it is a boolean whether
> > > > napi is used for transmit cleaning, or whether packets are cleaned
> > > > in ndo_start_xmit.
> > >
> > > Right.
> > >
> > > >
> > > > There certainly are some subtle issues with regard to pausing/waking
> > > > queues when switching between modes.
> > >
> > > What are "subtle issues" and if there are any, we find them.
> >
> > A single runtime test is not sufficient to exercise all edge cases.
> >
> > Please don't leave it to reviewers to establish the correctness of a
> > patch.
> 
> +1
> 
> And instead of trying to do this, it would be much better to optimize
> the NAPI performance. Then we can drop the orphan mode.

"To address your problem, optimize our code to the level which we
couldn't achieve in more than 10 years".  That's not a reasonable
requirement. Not getting an interrupt will always be better for some
workloads.


> >
> > The napi_tx and non-napi code paths differ in how they handle at least
> > the following structures:
> >
> > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
> > needed as delay until the next ndo_start_xmit and thus completion is
> > unbounded.
> >
> > When switching to napi mode, orphaned skbs may now be cleaned by the
> > napi handler. This is indeed safe.
> >
> > When switching from napi to non-napi, the unbound latency resurfaces.
> > It is a small edge case, and I think a potentially acceptable risk, if
> > the user of this knob is aware of the risk.
> >
> > 2. virtqueue callback ("interrupt" masking). The non-napi path enables
> > the interrupt (disables the mask) when available descriptors falls
> > beneath a low watermark, and reenables when it recovers above a high
> > watermark. Napi disables when napi is scheduled, and reenables on
> > napi complete.
> >
> > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > a low watermark, the driver stops the stack for queuing more packets.
> > In napi mode, it schedules napi to clean packets. See the calls to
> > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > netif_tx_wake_queue.
> >
> > Some if this can be assumed safe by looking at existing analogous
> > code, such as the queue stop/start in virtnet_tx_resize.
> >
> > But that all virtqueue callback and dev_queue->state transitions are
> > correct when switching between modes at runtime is not trivial to
> > establish, deserves some thought and explanation in the commit
> > message.
> 
> Thanks


