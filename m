Return-Path: <netdev+bounces-15029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F3E745577
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D40280C3D
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E980E;
	Mon,  3 Jul 2023 06:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE267E3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:25:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BCC4
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688365540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tpk/m1ehmImz7zaLy3aO5+IqtB88CsrdqBSdTDk04so=;
	b=L21xEHAP78Z+Silct1kf4hjqkR84vUVrWJUGwlcdxBAyj60v54e8ckZr2T55Bc+74RHRVI
	0Ix2naKtmyVvsVyBdGbKfdnqNAk5yVLtuJjnd0ItoCtEEXu0r87tCNiS6DKrcWABTgjHYo
	T4UUMqitC2DoJJwKU8SHB02HP3MiDLY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Omr-6U3gO7qNRt22tWfNjQ-1; Mon, 03 Jul 2023 02:25:38 -0400
X-MC-Unique: Omr-6U3gO7qNRt22tWfNjQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6a5ceddcdso35472021fa.1
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 23:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365537; x=1690957537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpk/m1ehmImz7zaLy3aO5+IqtB88CsrdqBSdTDk04so=;
        b=awY6rURr1TArR2Pe6Bs7NbTr3jt7WL/VtgoLpFFEAK6s7fC9hJ8DHvYbSFOo2ZLywT
         KPZu0vbhp8eU/jUl3tF3usW3+9rQ4mNhB9q005LnGJNTQiqB9Fh482sWnnjmmRQxsqso
         vZqJ7uBCTEyW2BpOvaNaw1sYwWkWiHANivsEqQBEzniJnETgBdf8WkUqTcRdKvBIqzKP
         mE3R0q5cnb359aoVfdDyT2zatioRNdSObtlFGQHqW0MjaqVz2o6roc2uazADoNhPYD1t
         EUTburVwQicv8lBhjp8IUvZcW4VMLSz0dAnO03ivf3qhkctnhYZQCpZyz8YPdwXdRsjS
         bTrQ==
X-Gm-Message-State: ABy/qLYveTDwx2I+eKkqcki9Zq0SaTYdKlKl21i6x3c/xoA/IkgZcPhE
	WVcpCkiRfCC/hQrJEztvAMVpM8sPv8BqBNTtRrcYxGhgkm1VRIowrODE+PvZeGzoCWU/dyRfWzD
	msB0Bxg68QjzDjheIGEiMOrC02GzcaWsI
X-Received: by 2002:a2e:3a0f:0:b0:2b6:decf:5cbf with SMTP id h15-20020a2e3a0f000000b002b6decf5cbfmr2575350lja.32.1688365537528;
        Sun, 02 Jul 2023 23:25:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtiFAUSLVKli3ZwlIzEtafXVEMpeIGVKp2Qav8LglWDEDQNJ63BHWuk/72EPyDX1VfTOgZd7pUWMPp5sL01kw=
X-Received: by 2002:a2e:3a0f:0:b0:2b6:decf:5cbf with SMTP id
 h15-20020a2e3a0f000000b002b6decf5cbfmr2575331lja.32.1688365537255; Sun, 02
 Jul 2023 23:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-2-lulu@redhat.com>
 <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com> <CACLfguWx2hjNyyVC_JM1VBCGj3AqRZsygHJ3JGcb8erknBo-sA@mail.gmail.com>
In-Reply-To: <CACLfguWx2hjNyyVC_JM1VBCGj3AqRZsygHJ3JGcb8erknBo-sA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:25:25 +0800
Message-ID: <CACGkMEtowYUowpsBvkYe3AUADwYgOcxbHW=-f=45u2vNTz9CUA@mail.gmail.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
To: Cindy Lu <lulu@redhat.com>
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

On Sat, Jul 1, 2023 at 5:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 4:04=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > From: Your Name <you@example.com>
> >
> > It looks to me your git is not properly configured.
> >
> > >
> > > this struct is to save the reconnect info struct, in this
> > > struct saved the page info that alloc to save the
> > > reconnect info
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 26b7e29cb900..f845dc46b1db 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -72,6 +72,12 @@ struct vduse_umem {
> > >         struct page **pages;
> > >         struct mm_struct *mm;
> > >  };
> > > +struct vdpa_reconnect_info {
> > > +       u32 index;
> > > +       phys_addr_t addr;
> > > +       unsigned long vaddr;
> > > +       phys_addr_t size;
> > > +};
> >
> > Please add comments to explain each field. And I think this should be
> > a part of uAPI?
> >
> > Thanks
> >
> Will add the new ioctl for this information

I may miss something but having this to be part of the uAPI seems more
than enough.

Or what would this new ioctl do?

Thanks

> Thanks
> Cindy
> > >
> > >  struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > > @@ -106,6 +112,7 @@ struct vduse_dev {
> > >         u32 vq_align;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > > +       struct vdpa_reconnect_info reconnect_info[64];
> > >  };
> > >
> > >  struct vduse_dev_msg {
> > > --
> > > 2.34.3
> > >
> >
>


