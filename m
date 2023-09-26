Return-Path: <netdev+bounces-36237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700697AE783
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 82B1D1C20382
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954C11CBB;
	Tue, 26 Sep 2023 08:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4411CB1
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:10:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611EE4
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695715822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tq+OwDsnhYOE9KHhY3J8xr/2sMS7VG1riTR0pXydwI=;
	b=hXH089R6jTM375fqTvyndnOiBTGi6ZtGakcqzDpWy0neVX4gPVhzxpw+xvPZY6PLryHpUu
	1v8GIcZDyOtgdQz7VHY+SANf9V3LeJHNO7M6zARLRhg6FieJSKZlCV/hAcHxS1NIwVjRAy
	BWyuA/v9N63h6WtaXuHDRxBrT121yMs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-i2IVhABPNgOiirSJLSBh3A-1; Tue, 26 Sep 2023 04:10:20 -0400
X-MC-Unique: i2IVhABPNgOiirSJLSBh3A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31f3cfe7269so6141443f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695715819; x=1696320619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tq+OwDsnhYOE9KHhY3J8xr/2sMS7VG1riTR0pXydwI=;
        b=YYeeIDvr6NrK+hZjdLvQ01dBSXiXhW99+kMk7duDlYcQI/ILPl5An7QDVZHcMnvxYx
         zjHRWUCkA2XiQQQIRWawGyqDziEdkLYFfwNwTNMT+aRF/GjJxuRE3QZJ97FVDOPT6jy/
         zEC8jLLVbrFJvm7NAoj3hfjnBtFQD+H+EA5pphiNd1GLhf8wzfpKL9P+3KmFpCZ+JuIH
         PiJU/cHeWWQhwp3PFwUrxaDIJzRiwod1JgaRb9BqX99Kmua4n1vFNQv01LeDFVNdJwnD
         YzZ31iEvA5AvsYr77XrL9HRSVUKu49IF83wTmBiniYh0wavoFvnonDuQ9Sn4E1CqMmbT
         42Mg==
X-Gm-Message-State: AOJu0YxBASub+MXL3bJHVa+/Q/3ZyK3GrtC9rIzNfnXiUYdQFkWiDnBN
	Uvprq+yqMrRvSzumTK+kWtSRMXItBOPYaMFtjMKdy8fxiFNqffy2ix3CrhGUK4by8HxmgzPwSzN
	8Kk8WinBvCrxxbGNFSGlCl4XXdOC0btTa
X-Received: by 2002:a5d:6b51:0:b0:31f:d95d:20a6 with SMTP id x17-20020a5d6b51000000b0031fd95d20a6mr7586934wrw.12.1695715819478;
        Tue, 26 Sep 2023 01:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsySNQKHkzRI2VVmJVtLzzf6l2Gixg5d681v+zNxkMLCHHomxDLUT0bVYKaTVsw5KZ4Y9yy5vzw8aqY5rOrtY=
X-Received: by 2002:a5d:6b51:0:b0:31f:d95d:20a6 with SMTP id
 x17-20020a5d6b51000000b0031fd95d20a6mr7586924wrw.12.1695715819194; Tue, 26
 Sep 2023 01:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-5-lulu@redhat.com>
 <20230925134506.GB13733@nvidia.com>
In-Reply-To: <20230925134506.GB13733@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 26 Sep 2023 16:09:41 +0800
Message-ID: <CACLfguUVK20JpSkqq0MybnVSqpBS6SbL=DazZscCiwU=q_SQ1A@mail.gmail.com>
Subject: Re: [RFC 4/7] vdpa: change the map/unmap process to support iommufd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 9:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sun, Sep 24, 2023 at 01:05:37AM +0800, Cindy Lu wrote:
> > Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
> > then will use the Legacy iommu domain pathway
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 91da012084e9..8d1ad89d4671 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -981,6 +981,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, st=
ruct vhost_iotlb *iotlb,
> >       } else if (ops->set_map) {
> >               if (!v->in_batch)
> >                       r =3D ops->set_map(vdpa, asid, iotlb);
> > +     } else if (!vdpa->iommufd_ictx) {
> > +             /* Legacy iommu domain pathway without IOMMUFD */
> > +             r =3D iommu_map(v->domain, iova, pa, size,
> > +                           perm_to_iommu_flags(perm));
> >       } else {
> >               r =3D iommu_map(v->domain, iova, pa, size,
> >                             perm_to_iommu_flags(perm));
>
> Um, why is the 2nd else the same as the new one?
>
the code here seems not in a good logic=EF=BC=8C I will try to optimize it =
in
the next version
Thanks
Cindy

> Jason
>


