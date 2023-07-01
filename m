Return-Path: <netdev+bounces-14948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23684744837
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407421C2089C
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39C5669;
	Sat,  1 Jul 2023 09:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8B5666
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 09:25:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34649B7
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688203542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nM2gJH27BA1TX1GMcZ4aVIIbGI0tWJqJTUWx2rBsc7Y=;
	b=SDqNKL3VogUNUe2kve6IUzARwtyTImauBH8aMZBSJOMJ+YpJz7SgxuGS3/cI7aCixYHM2i
	mfJ6dHr0om3tBzByT7UrhGJUgFZMgcwNJRA8LaMWhs04CBn10aJ6PtID92YIUs9gsrvS4i
	tairWStGz3gPzZzMAHf9Noc6/Mk9THA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-4Ial6gZsP8e_LaERQAz-fw-1; Sat, 01 Jul 2023 05:25:41 -0400
X-MC-Unique: 4Ial6gZsP8e_LaERQAz-fw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb18e9bd9so12683205e9.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 02:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688203540; x=1690795540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM2gJH27BA1TX1GMcZ4aVIIbGI0tWJqJTUWx2rBsc7Y=;
        b=Xc7I4p7ZdELkbgdhezZoD2dRwFVeKX9p7zucs4/WC4mE02Vk2MDu+lxIEZdWL8cgGN
         gVQtwqIo6BVunCnyd+LAwRYpMXt9ho4LKSvijZ7zXcLJ/oykW4aJi/HJfLBO+glt3sw0
         Pi8PQnJnE89GxVXHOFNpl4vEU7q8r9cK/O9mf1vN0nqou7PVLqnWajsxh+sRMxwsqFsi
         fmfkk9xH947QDww88Tw9elB5ZEhI0n1cJ2hq3tA4F0WjlxrTwnTR2SxVzCr41kC0V3Pv
         6wul6HIevu65Bp1pIyTX5DlUrrwvEsmfZqXS86qVO67THF5GOz5kMNcX32k6JqhZ2Wbx
         AGsw==
X-Gm-Message-State: AC+VfDwq0TuZqZNEuMy00IuZzsIcB9ztl2kKMEOk/vvO3mc92ekenyiu
	yEkCArlbB6CB4yzThEuocWNiMkrwOxdtVpj+dysCKC/M2lgjhZS/yomYSX0QZCFC1ehBNXqGT+5
	6OtzZ1XYAIrIgFqaNGL89diTgsf84Aprm
X-Received: by 2002:a1c:7704:0:b0:3f7:e7a2:25f6 with SMTP id t4-20020a1c7704000000b003f7e7a225f6mr4603083wmi.17.1688203540068;
        Sat, 01 Jul 2023 02:25:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KzgKvHpVpKm2J9bTSz5FU00R9I8bsGrKxINJmgolQkkcaBACIb7a7IhgcPxRbwrkEM1Oxeq1bSGVq3ZuXx0s=
X-Received: by 2002:a1c:7704:0:b0:3f7:e7a2:25f6 with SMTP id
 t4-20020a1c7704000000b003f7e7a225f6mr4603078wmi.17.1688203539779; Sat, 01 Jul
 2023 02:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-2-lulu@redhat.com>
 <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com>
In-Reply-To: <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 1 Jul 2023 17:24:57 +0800
Message-ID: <CACLfguWx2hjNyyVC_JM1VBCGj3AqRZsygHJ3JGcb8erknBo-sA@mail.gmail.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 4:04=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Your Name <you@example.com>
>
> It looks to me your git is not properly configured.
>
> >
> > this struct is to save the reconnect info struct, in this
> > struct saved the page info that alloc to save the
> > reconnect info
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 26b7e29cb900..f845dc46b1db 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -72,6 +72,12 @@ struct vduse_umem {
> >         struct page **pages;
> >         struct mm_struct *mm;
> >  };
> > +struct vdpa_reconnect_info {
> > +       u32 index;
> > +       phys_addr_t addr;
> > +       unsigned long vaddr;
> > +       phys_addr_t size;
> > +};
>
> Please add comments to explain each field. And I think this should be
> a part of uAPI?
>
> Thanks
>
Will add the new ioctl for this information
Thanks
Cindy
> >
> >  struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> > @@ -106,6 +112,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> > +       struct vdpa_reconnect_info reconnect_info[64];
> >  };
> >
> >  struct vduse_dev_msg {
> > --
> > 2.34.3
> >
>


