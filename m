Return-Path: <netdev+bounces-44398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DC7D7D05
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C61C20E43
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B7C3D68;
	Thu, 26 Oct 2023 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYsB4t1C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E04256C
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:48:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CC3189
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698302929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZhX4iyxXFC0MCsQGeir9FIncGn784C5EIdLY3Kqf/o=;
	b=HYsB4t1CthCJweoeuhpSDdkwHSyA4VyXGjnexazU0LVpaveGj9V6V8HzepdGwXuvPjBm91
	4zP/mzDQO7nH/ML+wAUCQAnvCtvptg8qSTvQSBOQbWSIz67cunmmDh4gIJhrJ1dN8xz6jp
	IhD9rm3xAFZRWysVUDdRLb2anANZROM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-1xUJFmDTPRyMFIHACovJaQ-1; Thu, 26 Oct 2023 02:48:48 -0400
X-MC-Unique: 1xUJFmDTPRyMFIHACovJaQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50798a259c7so507141e87.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302925; x=1698907725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZhX4iyxXFC0MCsQGeir9FIncGn784C5EIdLY3Kqf/o=;
        b=nxFFVeQxa04WQX0WHQMjWw8HOzim9iq19KJT//XtQd2hs8ujHbq1Mf6A0j3MlXfJOS
         jSkNtOitUFsQhU/4oI20S5OzU6+8WUlWg4EdvsdDS36rQ4q/GTvvrWykrpYg4CYirele
         lqE2zAyiQ9CIJCtUMLJUC5iKVkShyP8KnfIEGB4Iar6YqYzjLW8cMf4saIYu2LdBnDsG
         2Gs0BE9CNL6KjCUdF/Ik8FzfrK4h0ApZNVVa5wWGtH5zUwteLrmeSXjX0QuaE/I4Stnw
         /5SZoFfPGMVDTIY3bhoj/mSarD+Mk136ONZQQWFQ9+zmGsTrCQNYLo5PQa7ZIwQ0u+XZ
         1s/A==
X-Gm-Message-State: AOJu0YwJ6CiVh/zPFGCV1aRsbjMuc/WZ5nOyxm7iG8iVc5gcb4Xr8God
	tdow+SoQcCnMlL46uiK+emKdwS2H2pp940gxmNCSmExN1Mrwbns/xUvLazNGVprdI+JFhWvrYM3
	5sFEWJjKA3cs66yV8I66VkigU+TerNmdSttSJyye8
X-Received: by 2002:a19:550f:0:b0:507:bbbe:5287 with SMTP id n15-20020a19550f000000b00507bbbe5287mr12237674lfe.51.1698302925285;
        Wed, 25 Oct 2023 23:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMwwL0RGJDkxIK0JiqAOnmXyEk1qhDXOl4RL0c1Djxza+SUefJr9FuA0rhF/Pzzy+BBAOIL4AIupG/QYhCR5c=
X-Received: by 2002:a19:550f:0:b0:507:bbbe:5287 with SMTP id
 n15-20020a19550f000000b00507bbbe5287mr12237663lfe.51.1698302924964; Wed, 25
 Oct 2023 23:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026024147-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 26 Oct 2023 14:48:07 +0800
Message-ID: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > Hi All
> > Really apologize for the delay, this is the draft RFC for
> > iommufd support for vdpa, This code provides the basic function
> > for iommufd support
> >
> > The code was tested and passed in device vdpa_sim_net
> > The qemu code is
> > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > The kernel code is
> > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> >
> > ToDo
> > 1. this code is out of date and needs to clean and rebase on the latest=
 code
> > 2. this code has some workaround, I Skip the check for
> > iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> > mutex for iommfd operations
> > 3. only test in emulated device, other modes not tested yet
> >
> > After addressed these problems I will send out a new version for RFC. I=
 will
> > provide the code in 3 weeks
>
> What's the status here?
>
Hi Michael
The code is finished, but I found some bug after adding the support for ASI=
D,
will post the new version after this bug is fixed, should be next week
Thanks
Cindy

> --
> MST
>


