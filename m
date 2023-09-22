Return-Path: <netdev+bounces-35644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA047AA740
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E5681281E6F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69019385;
	Fri, 22 Sep 2023 03:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A17FD
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:11:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A14102
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695352315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGvCxDRGdBW7AEbyfXuG9iI8Crk1BrmovItky/Bus/E=;
	b=EeDs7dDMdDzDv/xbbnGERMzh5JzQ1b07nb5O4mUBwE/c+WUY0MXTI6UGYNSTAT+4VKA4Ne
	C9icRWZswAcHKjIYWWU93mr86XcWS+A8HXWPdDrDWx9xsooe1ewN8z0fyVpYxsn3ZHuU4N
	08LgAafUVRQ8R5P0hPdx4ELIMUBhsQM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-PWwcaZDUNWCSsg_F8bG4uA-1; Thu, 21 Sep 2023 23:11:53 -0400
X-MC-Unique: PWwcaZDUNWCSsg_F8bG4uA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5042eca54a4so1576563e87.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352312; x=1695957112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGvCxDRGdBW7AEbyfXuG9iI8Crk1BrmovItky/Bus/E=;
        b=RMexBaLtkPocTjlynNNk4plUhfh5OqkycTIR746jOFB5QFJUL6Y2TKCv0W/2pfTxZr
         FM0nTV41eRNVURVN+rKZsSTqRsmPZuniIFhN1LvPMgW5Cu6UNDHn24NQbNsBTe1dWLwb
         6EOsx1snv+KjfxG5xAIMsV0pdPI/PcDY3mkGHk92ASFiPDwgdcAHAmmwA73o1/eKL7Bt
         tdNVDjf91U14flZojbYyX5PURQt5iFVTM+YpxPyTtUxOv0yeObIzrlNd1jPU7ytGyt+V
         VxBVLoAPG2bVChp19LqTlEai+sPvhqIHYozqCpo3nKgVSP/675a8knBPL84dC4oSYY/K
         m5+g==
X-Gm-Message-State: AOJu0YxKjLPR44EEzQjuXiyuazvDwM9kFckayYSYPFKWgUZehfv6gxnU
	HF9YUGXn4rj5SURBUzL50pED+edwWuFxUM2jvit2ocJEvdBbGDM4Sc7e/XVPtsNYc+wQijuRwsd
	4Bs1xmPz+kVx0wztja5646hkXyDyDNCLC
X-Received: by 2002:a19:384b:0:b0:4fd:c715:5667 with SMTP id d11-20020a19384b000000b004fdc7155667mr5363833lfj.20.1695352312411;
        Thu, 21 Sep 2023 20:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkymRIIEUVWlRbuHxN0yBKASxkd+Z2oy0DIa8UmIa3FFJ/1HeC5Ha4S/ar47CxuUyt7WovwFgE/wDkT4t/Ycg=
X-Received: by 2002:a19:384b:0:b0:4fd:c715:5667 with SMTP id
 d11-20020a19384b000000b004fdc7155667mr5363817lfj.20.1695352312093; Thu, 21
 Sep 2023 20:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-3-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:11:41 +0800
Message-ID: <CACGkMEuSFMSx5GXzw+MFnF7yqaEG3mKpRt1Ohd3aTJDsv6rsGg@mail.gmail.com>
Subject: Re: [PATCH net 2/6] virtio-net: fix mismatch of getting tx-frames
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Since virtio-net allows switching napi_tx for per txq, we have to
> get the specific txq's result now.
>
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce co=
mmand")
> Cc: Gavin Li <gavinl@nvidia.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fd5bc8d59eda..80d35a864790 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3453,7 +3453,7 @@ static int virtnet_get_per_queue_coalesce(struct ne=
t_device *dev,
>         } else {
>                 ec->rx_max_coalesced_frames =3D 1;
>
> -               if (vi->sq[0].napi.weight)
> +               if (vi->sq[queue].napi.weight)
>                         ec->tx_max_coalesced_frames =3D 1;
>         }
>
> --
> 2.19.1.6.gb485710b
>


