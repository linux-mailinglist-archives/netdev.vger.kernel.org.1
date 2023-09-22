Return-Path: <netdev+bounces-35692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37567AAA49
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C921A28319B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD018B10;
	Fri, 22 Sep 2023 07:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320EC179B7
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:32:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA8C2
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695367974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tzr3g+o0PnLeNXLEdamJy2Bw5jLEtdPdZyLAQvEL1xg=;
	b=bBD/A3GBGSJ/r/oLnZ9NOR+CPbZwmdwcQ4JZzlQYRcmZKfoBjg1RfPhXx/E7oEW6dVKDgD
	i6YRdS7UuZYihwrDwxDtg3Hf89U7PYG7rkFF0ij6BBNtCHWDa0AUgnHUvuFxn3Es5iaKSi
	RSXyGroB4XCtYyytlFaHGsxxa31XXLo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-3H_ingipNRSA1tI_aoLtwg-1; Fri, 22 Sep 2023 03:32:52 -0400
X-MC-Unique: 3H_ingipNRSA1tI_aoLtwg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5041a779c75so2330349e87.2
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 00:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367971; x=1695972771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzr3g+o0PnLeNXLEdamJy2Bw5jLEtdPdZyLAQvEL1xg=;
        b=CZM69ckUei9ubjm7WgGoinraMuqpHoBNplcJt1NNfIf5LqbEu/Jpf5V02YyvOqmT6K
         UEdQKogKRo0iFzAfQDUsKVCr0O5bmaaqK+5rfaZpkDWI81dvVRMdtQ5OGIgGfuSmB6A/
         8+7zLitPOlQ3k0AFgOqIRdCv9Vf5eM+70cLfmVYq741sJmR5+zsHfYGl41LeGdA8Y6bw
         N7Uzf8bkeW5yY7RFxs8x5wfsJjqPinzXYb3SZBlE0tV8z0Zz2FcRvvrwG9oWZ6NHoNvw
         mTf4MoYQyBAMo/afc1SRXRnFuDRWyrjLfZ0K4CYHiMi6QULHby7YULmDxpKj+NaWQagU
         PPOg==
X-Gm-Message-State: AOJu0YxTK1U/SY4nmTQCdVH4bU45S7paSZAB0WK90K8PR0N4DDlekkz8
	b12x5C+nTBbsLU7Ym3IyvHn944/MMtb5kHNlVMJlpEfEJ209LZPLabRrWPGAB6CjLAvkMJTCstH
	NVWnjwfbfYEDdXf7EaK5Jx+JtPxrAoNZt+Ezhot+YNT8=
X-Received: by 2002:a19:2d07:0:b0:500:b287:36df with SMTP id k7-20020a192d07000000b00500b28736dfmr5361695lfj.13.1695367971011;
        Fri, 22 Sep 2023 00:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy16pWqgvltN1cDWNjeFFE3BiZ1KvAGSDhVysKhX9y39Onk7+lmcv4zcetBWCyZHAvhyRWEncU3uPULogttdM=
X-Received: by 2002:a19:2d07:0:b0:500:b287:36df with SMTP id
 k7-20020a192d07000000b00500b28736dfmr5361663lfj.13.1695367970673; Fri, 22 Sep
 2023 00:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com> <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
In-Reply-To: <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 15:32:39 +0800
Message-ID: <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq resize
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Gavin Li <gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 1:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/9/22 =E4=B8=8B=E5=8D=8812:29, Jason Wang =E5=86=99=E9=81=
=93:
> > On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> According to the definition of virtqueue coalescing spec[1]:
> >>
> >>    Upon disabling and re-enabling a transmit virtqueue, the device MUS=
T set
> >>    the coalescing parameters of the virtqueue to those configured thro=
ugh the
> >>    VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not=
 set
> >>    any TX coalescing parameters, to 0.
> >>
> >>    Upon disabling and re-enabling a receive virtqueue, the device MUST=
 set
> >>    the coalescing parameters of the virtqueue to those configured thro=
ugh the
> >>    VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not=
 set
> >>    any RX coalescing parameters, to 0.
> >>
> >> We need to add this setting for vq resize (ethtool -G) where vq_reset =
happens.
> >>
> >> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.h=
tml
> >>
> >> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce=
 command")
> > I'm not sure this is a real fix as spec allows it to go zero?
>
> The spec says that if the user has configured interrupt coalescing
> parameters,
> parameters need to be restored after vq_reset, otherwise set to 0.
> vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
> parameters,
> regardless of whether the command is sent or not. So I think we need
> this patch
> it complies with the specification requirements.

How can we make sure the old coalescing parameters still make sense
for the new ring size?

Thanks

>
> Thanks!
>
> >
> > Thanks
>


