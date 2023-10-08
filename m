Return-Path: <netdev+bounces-38844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0E7BCC11
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0411C20503
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32F15C1;
	Sun,  8 Oct 2023 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0rcXVD+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660C10E6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 04:35:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2202C5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 21:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696739750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
	b=G0rcXVD+F16MIIren/ulpDip94qj+rvtqECCq81PrZhye2OjRKnjrvrvkEgy3wc2A9r8ak
	hplhXg8kldlAD9wsSCmEhn1PV5LcAshiLhmv2xftp3H0OR5gFjFGylw0Q9/HzcaRZEUT6R
	YYEhIuc84pBv/aDYwr6S6/IBPB1/zL8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-m8eWalbXPHCRRy8MAgQR3g-1; Sun, 08 Oct 2023 00:35:43 -0400
X-MC-Unique: m8eWalbXPHCRRy8MAgQR3g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5041a779c75so3003675e87.2
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 21:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739742; x=1697344542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
        b=ItM+mcCsMm3Cdoi3ymnnCW3rNFuZyU/pK14jVxB1xnLgsPBm+PMjmMBRyhU7WDLcGp
         i5Onlx1SGTb2dI08rq2EyLWrKFz3ehtsns3rNp5zhBGS66oYFUU9BHddipISTvuDoZM+
         vbIpnln0gVld1DHkoxQpmsNPO4gtXHOrdEryIEQ9sFnsV5c3X6x/1jwZCSJAiQo7hVZs
         vdHYA/7y/I23YbpGOg5gq2bNahJczGbGuoqLh5WpgPHXYGIwEO5DLhUVLjeigTwfFL5j
         o2XvgxPYSrq5eD6Zu2HQMEJjtBFmPdMONsXCmm56jMuBIIhIZapLm0Qwse3Q/Gt2JSCu
         6gLA==
X-Gm-Message-State: AOJu0YwP9CltRL07fl2lCER6J/5oSyq9F98B5KPAsA8OAdwigGfKZceb
	KT6MnmmmRWC+5fFPaGuLkyjfeI570pwFzB+YXTMg4uPlUGuCuBdH9LrTLBXsXpBvua4/BDNgHAQ
	YZrhoR9yyWVJ4c/KYCXqNJoWvUc7Rf3FE
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id m28-20020a19435c000000b0050091c19642mr10346147lfj.21.1696739741947;
        Sat, 07 Oct 2023 21:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEesW3+LqZnNyyPWhlp2aUtbUAkF/QV4pVuw/g7/p5xHxM6btq/MV1uwbCGf05M1pAxvqEdVbSQyK8H6pYHRZo=
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id
 m28-20020a19435c000000b0050091c19642mr10346138lfj.21.1696739741529; Sat, 07
 Oct 2023 21:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com> <20230926050021.717-2-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:35:30 +0800
Message-ID: <CACGkMEujvBtAx=1eTqSrzyjBde=0xpC9D0sRVC7wHHf_aqfqwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 398776277@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 1:00=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Need to insmod vhost_test.ko before run virtio_test.
> Give some hints to users.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  tools/virtio/virtio_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a..ce2c4d93d735 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev, un=
signed long long features)
>         dev->buf =3D malloc(dev->buf_size);
>         assert(dev->buf);
>         dev->control =3D open("/dev/vhost-test", O_RDWR);
> +
> +       if (dev->control < 0)
> +               fprintf(stderr, "Install vhost_test module" \
> +               "(./vhost_test/vhost_test.ko) firstly\n");

There should be many other reasons to fail for open().

Let's use strerror()?

Thanks


>         assert(dev->control >=3D 0);
>         r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
>         assert(r >=3D 0);
> --
> 2.34.1
>


