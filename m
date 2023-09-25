Return-Path: <netdev+bounces-36067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EA7ACE19
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 88DECB2095C
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13A1117;
	Mon, 25 Sep 2023 02:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D911116
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:29:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47744C2
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695608971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQji8DpwSIIsw+eDXmlvEKwYU33m0WIJJqnq5qT3Suc=;
	b=G8wQIBvNwUmGpWoDh8zb+Q0y5chDeG9yr2mfjq3/tuBPDzQnwftZS2Xj5UWLI0/tD5yd/B
	2arthAUx9M4EwV/QREkvVptFhGTd5b06jrcwjBjYQ7bbvzbbEHQ3ufQvp3sqKZoDmzK0Zy
	u1oLo6WQpqrGEWXJocC5RS80ThZUwdQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-IOnXxcl0PTyHSXL34ZIbWg-1; Sun, 24 Sep 2023 22:29:29 -0400
X-MC-Unique: IOnXxcl0PTyHSXL34ZIbWg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5041bddcedaso7056953e87.3
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695608968; x=1696213768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQji8DpwSIIsw+eDXmlvEKwYU33m0WIJJqnq5qT3Suc=;
        b=fjZZftLXWX+smNS8lLO+JDVj/YWVFv8Y4Zb4dFyAZul78E8TN8NEc66SLyFWcQeW5T
         HdRL0Ylhdn0Qqb08oztj2RAkv5CVPsBUMDNXHm+O3bfRpx8z2rXPMhpOj/HFpPJEdZL2
         VcMk21anp24XhGor6Ikqxj5zDEc3BBcgmjNhsAZYPtRo561qLDZvqkOv+zX6hHOJRq/C
         Iy5Gn+gJKOC3MvlmVlllHTCyGZqxLWb9SWm/kNEAAf+vEZOMRvznuZc/l4HPSXLF7l5x
         40hM0d/WrUqkZPNGD3cUXUUR8x4gtnd2h6PmCu3iDQqNq6kqrpz+4DGgx2cgem27u0WH
         MfuQ==
X-Gm-Message-State: AOJu0YyUPCkLxh5ND7TpasaRmVoN+qJrw+7e6pgZLSVEmUjADhP+g7u/
	IdNLWk3F9PelJpvT8XJPXz526jrT0zNMvpuDCUWeryC1VmYc0mQtg3uu+cGtgbLsrfH2bCVOyTd
	ZiBQ2yFWU22OmdRYcR7twQQKhMhXpB4Qt
X-Received: by 2002:a05:6512:2343:b0:503:38fe:4590 with SMTP id p3-20020a056512234300b0050338fe4590mr5336850lfu.60.1695608968392;
        Sun, 24 Sep 2023 19:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMMV42sNZlyWoIXBLG6Ym2vUy9Ev7e/8KiM0YW/RYCoVUR2vamIuZj3LPvNqLgK5FfVXmLps3t7aECzG5gmCQ=
X-Received: by 2002:a05:6512:2343:b0:503:38fe:4590 with SMTP id
 p3-20020a056512234300b0050338fe4590mr5336832lfu.60.1695608967966; Sun, 24 Sep
 2023 19:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com> <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com> <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
 <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
In-Reply-To: <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:29:17 +0800
Message-ID: <CACGkMEtbCSxOQDmrEySgdEWG49SOi3UFYkLMjmjF6=5m8F93xg@mail.gmail.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 3:58=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/9/22 =E4=B8=8B=E5=8D=883:32, Jason Wang =E5=86=99=E9=81=93=
:
> > On Fri, Sep 22, 2023 at 1:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/9/22 =E4=B8=8B=E5=8D=8812:29, Jason Wang =E5=86=99=E9=
=81=93:
> >>> On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>> According to the definition of virtqueue coalescing spec[1]:
> >>>>
> >>>>     Upon disabling and re-enabling a transmit virtqueue, the device =
MUST set
> >>>>     the coalescing parameters of the virtqueue to those configured t=
hrough the
> >>>>     VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did =
not set
> >>>>     any TX coalescing parameters, to 0.
> >>>>
> >>>>     Upon disabling and re-enabling a receive virtqueue, the device M=
UST set
> >>>>     the coalescing parameters of the virtqueue to those configured t=
hrough the
> >>>>     VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did =
not set
> >>>>     any RX coalescing parameters, to 0.
> >>>>
> >>>> We need to add this setting for vq resize (ethtool -G) where vq_rese=
t happens.
> >>>>
> >>>> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415=
.html
> >>>>
> >>>> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coales=
ce command")
> >>> I'm not sure this is a real fix as spec allows it to go zero?
> >> The spec says that if the user has configured interrupt coalescing
> >> parameters,
> >> parameters need to be restored after vq_reset, otherwise set to 0.
> >> vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
> >> parameters,
> >> regardless of whether the command is sent or not. So I think we need
> >> this patch
> >> it complies with the specification requirements.
> > How can we make sure the old coalescing parameters still make sense
> > for the new ring size?
>
> I'm not sure, ringsize has a wider range of changes. Maybe we should
> only keep coalescing
> parameters in cases where only vq_reset occurs (no ring size change
> involved)?

Probably but do we actually have a user other than resize now?

Thanks

>
> Thanks!
>
> >
> > Thanks
> >
> >> Thanks!
> >>
> >>> Thanks
>


