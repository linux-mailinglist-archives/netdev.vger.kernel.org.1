Return-Path: <netdev+bounces-36068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C0C7ACE1B
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97B7E2813B6
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9211643;
	Mon, 25 Sep 2023 02:30:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890507F
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:30:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9062D3
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695609012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPJxBbcUUYMfHcOUHqwNDKHgycKbeMx7KXqGoUlCq0E=;
	b=KNSfb7BCzCiVqF++yZt7EdQ/5SNG1laotrhgZZeprn6BWIFV1GBAn0Lzm5tgvGT0iAmEzo
	JxF5Mg/iaR2UuUr4JZWafCUz7oDw1a94noRZ9KFFEVxl8UD21q7bDpAMb0eFGF9pXPurW8
	moIUSHhmVjdgCVhPOAsfFCzp5g7RiYQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-VuBu_DjPN-uyAhjt676OYQ-1; Sun, 24 Sep 2023 22:30:10 -0400
X-MC-Unique: VuBu_DjPN-uyAhjt676OYQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ba1949656bso68903551fa.0
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609009; x=1696213809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPJxBbcUUYMfHcOUHqwNDKHgycKbeMx7KXqGoUlCq0E=;
        b=Awclpwi94o+MnyRSnF/dqyCpFJr1PzYOa3MYoERrNWE/u4pZGpM6KLpb8dBIELfHXy
         1Iz4GsHG0XjoEByxEUYhmh5k0BBLxwRWpWp92h67AuSDUbVvynBn6hlTvvs9gmTZ8vbw
         cODs2AXTMlrOBzztsYaBS3G9cXTbVFUVAJ4SWkfIPiXba6T2HNSfJE3oRZ658ctgg/9z
         kGTvAgebaHW7YkH373K8bQo7TtmT8jJPq7Rl6tZ+2+PZu3Oa1lGbVskQNt4HLAnc+c5A
         rFb8fQf5/E7OPrsSBy46A+YQSWdkJ/SjMbdHl1iabulJziwT9mZsPX/zvdNdr8weDcsh
         OU2A==
X-Gm-Message-State: AOJu0Yxq/Eb9PLedI0ULPxPYk2+CoSS6sItd56sSKtL9by4O2sllNatv
	G8XVHj8UUn0zR3VMmoLsw0xVXx3O4zrzG7e8DMp+dArvrwAiBL5oHqhBnuRZH0ZQTnJggWZwdVV
	CDK6P9kKSsdtq2OeP/F7WiJv/q6/O2Qrl
X-Received: by 2002:a19:7009:0:b0:502:adbb:f9db with SMTP id h9-20020a197009000000b00502adbbf9dbmr4105248lfc.65.1695609009141;
        Sun, 24 Sep 2023 19:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc/R9Qq6Bq0VtxQxiH5ufUuP57xjWU1IvwuFz8n5+CF1xdRlHYwTJnX7/Wqb0dT+dEORXfAW4JE2jOQfoIyVE=
X-Received: by 2002:a19:7009:0:b0:502:adbb:f9db with SMTP id
 h9-20020a197009000000b00502adbbf9dbmr4105238lfc.65.1695609008794; Sun, 24 Sep
 2023 19:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com> <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com> <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
 <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:29:57 +0800
Message-ID: <CACGkMEtU-F4PwfdkN0vrJ3hS-Wc3YsnTb2vY_bLUYXCSnnPb1g@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Gavin Li <gavinl@nvidia.com>, 
	Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 5:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 22 Sep 2023 15:32:39 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Sep 22, 2023 at 1:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > >
> > >
> > > =E5=9C=A8 2023/9/22 =E4=B8=8B=E5=8D=8812:29, Jason Wang =E5=86=99=E9=
=81=93:
> > > > On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.aliba=
ba.com> wrote:
> > > >> According to the definition of virtqueue coalescing spec[1]:
> > > >>
> > > >>    Upon disabling and re-enabling a transmit virtqueue, the device=
 MUST set
> > > >>    the coalescing parameters of the virtqueue to those configured =
through the
> > > >>    VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did=
 not set
> > > >>    any TX coalescing parameters, to 0.
> > > >>
> > > >>    Upon disabling and re-enabling a receive virtqueue, the device =
MUST set
> > > >>    the coalescing parameters of the virtqueue to those configured =
through the
> > > >>    VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did=
 not set
> > > >>    any RX coalescing parameters, to 0.
> > > >>
> > > >> We need to add this setting for vq resize (ethtool -G) where vq_re=
set happens.
> > > >>
> > > >> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg004=
15.html
> > > >>
> > > >> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coal=
esce command")
> > > > I'm not sure this is a real fix as spec allows it to go zero?
> > >
> > > The spec says that if the user has configured interrupt coalescing
> > > parameters,
> > > parameters need to be restored after vq_reset, otherwise set to 0.
> > > vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
> > > parameters,
> > > regardless of whether the command is sent or not. So I think we need
> > > this patch
> > > it complies with the specification requirements.
> >
> > How can we make sure the old coalescing parameters still make sense
> > for the new ring size?
>
> For the user, I don't think we should drop the config for the coalescing.
> Maybe the config does not make sense for the new ring size, but when the =
user
> just change the ring size, the config for the coalesing is missing, I thi=
nk
> that is not good.

How did other drivers deal with this?

Thanks

>
> Thanks.
>
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks!
> > >
> > > >
> > > > Thanks
> > >
> >
>


