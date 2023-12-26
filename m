Return-Path: <netdev+bounces-60293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163581E772
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FB41C21E59
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0428A4E63C;
	Tue, 26 Dec 2023 12:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE204E631
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzHfN--_1703594627;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzHfN--_1703594627)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 20:43:48 +0800
Message-ID: <1703594592.3934712-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/1] virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings
Date: Tue, 26 Dec 2023 20:43:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20231226114507.2447118-1-yanjun.zhu@intel.com>
 <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
In-Reply-To: <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 26 Dec 2023 19:53:58 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> The warnings are as below:
>
> "
>
> drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> drivers/net/virtio_net.c:4551:48: warning: =E2=80=98%d=E2=80=99 directive=
 writing
> between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=3D]
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~
> In function =E2=80=98virtnet_find_vqs=E2=80=99,
>  =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98init_vqs=E2=80=99 at drivers/ne=
t/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4551:41: note: directive argument in the range
> [-2147483643, 65534]
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> drivers/net/virtio_net.c:4551:17: note: =E2=80=98sprintf=E2=80=99 output =
between 8 and
> 18 bytes into a destination of size 16
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> drivers/net/virtio_net.c:4552:49: warning: =E2=80=98%d=E2=80=99 directive=
 writing
> between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=3D]
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> In function =E2=80=98virtnet_find_vqs=E2=80=99,
>  =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98init_vqs=E2=80=99 at drivers/ne=
t/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4552:41: note: directive argument in the range
> [-2147483643, 65534]
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> drivers/net/virtio_net.c:4552:17: note: =E2=80=98sprintf=E2=80=99 output =
between 9 and
> 19 bytes into a destination of size 16
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>
> "
>
> Please review.

Please put this to the git msg.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.



>
> Best Regards,
>
> Zhu Yanjun
>
> =E5=9C=A8 2023/12/26 19:45, Zhu Yanjun =E5=86=99=E9=81=93:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >
> > Fix a warning when building virtio_net driver.
> >
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> >   drivers/net/virtio_net.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 49625638ad43..cf57eddf768a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> >   {
> >   	vq_callback_t **callbacks;
> >   	struct virtqueue **vqs;
> > -	int ret =3D -ENOMEM;
> > -	int i, total_vqs;
> >   	const char **names;
> > +	int ret =3D -ENOMEM;
> > +	int total_vqs;
> >   	bool *ctx;
> > +	u16 i;
> >
> >   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> >   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed =
by

