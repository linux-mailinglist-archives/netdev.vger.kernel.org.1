Return-Path: <netdev+bounces-39055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B07BD902
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D52815A5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73006156C3;
	Mon,  9 Oct 2023 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFynx6CO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD014F72
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:52:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C4C5
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696848770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjiO4Hvw+fsOPZZWLwNP0lglpX+bcklExOuRO6AMksY=;
	b=JFynx6CO6viz4BkPLqrmfKmFKwTHa8/F1Wmj54WQagA7/HS62W5TfSmlRNX3QyMEkwyg+A
	zYJbASUPrxRk21B3W7pAxQ0NhkxUrGJa50roGhzwNrlLkx6elzzUAsbcs8mZVS0xDygqbY
	vy1gQt3F5QS1tSbiZTl3aBWsUp9Dav4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-gBxPj3CiMg-LcSuFLR_yNQ-1; Mon, 09 Oct 2023 06:52:39 -0400
X-MC-Unique: gBxPj3CiMg-LcSuFLR_yNQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-405917470e8so33430745e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 03:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848758; x=1697453558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjiO4Hvw+fsOPZZWLwNP0lglpX+bcklExOuRO6AMksY=;
        b=lJn35oabiTDM3QEtTdpM7Y03M+poTuF9r2JAqxvdnI8F2k60pREF1FNm7xRsLPg+q/
         SFoiFU/w3aVkEKOmMTD9WFAiyAZ8PlMZeFxLZHjPm0VY1tUmHViEyv3cHYBzvZknzIF0
         ABj/Yy2iuLSh/4R+nNhrYXDm6+apkITqAPbH6NODfAmqkXcIz3fIh4CnlX9XCzFAMbyT
         TUE3NVQH/5RsXoD4MiM4NywpBkCfCdUp9+i3yUWRHEjXz4o83NEqc2m7GATUANMNY7S2
         Ivi519kGTw5yFuaxUudYD0b3JeSGh/KwT3vICyiBIS2HL0kWx1gN/8+ZeAbextrYcEtG
         uK+g==
X-Gm-Message-State: AOJu0YwGJ3Jcm7Dy/XzMtK2LJ5+XKw/Z5BHikACRoyN55qtELW7bDjWP
	SFWjsNUpdSRUS5c2bWg683FRI0qFrGXl2bcLFfHQFHluYWRQc7tYhTUlMd6AhY8dskt2z+ikc8n
	1Ii+OraoUoDR0w193
X-Received: by 2002:a7b:cd8e:0:b0:405:3a3d:6f53 with SMTP id y14-20020a7bcd8e000000b004053a3d6f53mr12910443wmj.3.1696848758033;
        Mon, 09 Oct 2023 03:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgWahkpsmLf/aOwZysFtiHkjovc5aRAyJtzXWyUzsNyUbJBrMocRm41ehhlwu8cg3xsXBpvA==
X-Received: by 2002:a7b:cd8e:0:b0:405:3a3d:6f53 with SMTP id y14-20020a7bcd8e000000b004053a3d6f53mr12910428wmj.3.1696848757617;
        Mon, 09 Oct 2023 03:52:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
        by smtp.gmail.com with ESMTPSA id z3-20020a056000110300b0031c6581d55esm9224958wrw.91.2023.10.09.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:52:36 -0700 (PDT)
Date: Mon, 9 Oct 2023 06:52:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"398776277@qq.com" <398776277@qq.com>
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
Message-ID: <20231009063735-mutt-send-email-mst@kernel.org>
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
 <CACGkMEujvBtAx=1eTqSrzyjBde=0xpC9D0sRVC7wHHf_aqfqwg@mail.gmail.com>
 <PSAPR06MB3942238B1D7218934A2BB8B4E1CEA@PSAPR06MB3942.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR06MB3942238B1D7218934A2BB8B4E1CEA@PSAPR06MB3942.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 02:44:55AM +0000, Liming Wu wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Sunday, October 8, 2023 12:36 PM
> > To: Liming Wu <liming.wu@jaguarmicro.com>
> > Cc: Michael S . Tsirkin <mst@redhat.com>; kvm@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; 398776277@qq.com
> > Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
> > 
> > On Tue, Sep 26, 2023 at 1:00 PM <liming.wu@jaguarmicro.com> wrote:
> > >
> > > From: Liming Wu <liming.wu@jaguarmicro.com>
> > >
> > > Need to insmod vhost_test.ko before run virtio_test.
> > > Give some hints to users.
> > >
> > > Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> > > ---
> > >  tools/virtio/virtio_test.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > > index 028f54e6854a..ce2c4d93d735 100644
> > > --- a/tools/virtio/virtio_test.c
> > > +++ b/tools/virtio/virtio_test.c
> > > @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev,
> > unsigned long long features)
> > >         dev->buf = malloc(dev->buf_size);
> > >         assert(dev->buf);
> > >         dev->control = open("/dev/vhost-test", O_RDWR);
> > > +
> > > +       if (dev->control < 0)
> > > +               fprintf(stderr, "Install vhost_test module" \
> > > +               "(./vhost_test/vhost_test.ko) firstly\n");
> > 
> > There should be many other reasons to fail for open().
> > 
> > Let's use strerror()?
> Yes,  Thanks for the review. 
> Please rechecked the code as follow:
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,11 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>         dev->buf = malloc(dev->buf_size);
>         assert(dev->buf);
>         dev->control = open("/dev/vhost-test", O_RDWR);
> +
> +       if (dev->control == NULL)


???
Why are you comparing a file descriptor to NULL?

> +               fprintf(stderr,
> +                       "%s: Check whether vhost_test.ko is installed.\n",
> +                       strerror(errno));


No, do not suggest checking unconditionally this is just wasting user's
time.  You would have to check the exact errno value. You will either
get ENOENT or ENODEV if module is not loaded. Other errors indicate
other problems.  And what matters is whether it's loaded, not installed
- vhost_test.ko will not get auto-loaded even if installed.


>         assert(dev->control >= 0);
>         r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>         assert(r >= 0);
>  
> Thanks
> 

In short, I am not applying this patch. If you really want to make
things a bit easier in case of errors, replace all assert r >= 0 with
a macro that prints out strerror(errno), that should be enough.
Maybe print file/line number too while we are at it.

-- 
MST


