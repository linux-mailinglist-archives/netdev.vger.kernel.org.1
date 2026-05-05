Return-Path: <netdev+bounces-284237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI8oGyGU+WnV9wIAu9opvQ
	(envelope-from <netdev+bounces-284237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:54:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B64C75CB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B424230221D9
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC433CFF48;
	Tue,  5 May 2026 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IhXflBOe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68B3C2779
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964061; cv=fail; b=BVwKeO4ty25j+v8GpEGnPyZRH5xKFsvV0efl7eT+Lk6St68SFmQv6z8esvWG0vXc0jtsRMHwDHyFDyYm0fdh8YeNNR3i0WJuP7vyDfps/we3HQVvGGtgB84ArGZ6yNbeuTJVL8LVM0TkXPWgJPc0HwwLZea6tttvdCQsYb8/wJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964061; c=relaxed/simple;
	bh=GnOs6zrMZZDdRu2gdB9Y7jzSPOwey5UzAT8kxViXCiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcCkX2D1aWwy5E+nNnkZVaXq7C8Y9aFhd0eqcypl5r/jmuUaxRXF4GzqzLDt3efNBLVFFSDytrHH+Nl1a/zOzFSxYecf1Jen+cOhGeqdkPi0bvGJ3hiWlsSrx2k7eLclbMPYO9+t212HdvlYvqZkF0+KEH+f7LaSPUyiTYukSf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IhXflBOe; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644HUxSk386305
	for <netdev@vger.kernel.org>; Mon, 4 May 2026 23:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=D1mf9Znv8+ZNWIl/62MdhJpFIl6cZ0E08irrbj6h/RE=; b=IhXflBOemPK3
	U8Z15qfbXAtar3VVsStb8w8V6wh1lL2Ws0tmFDXc99BVDS7Lo21exksx9//XQMUo
	DBuksD73qntJ+bIuhKGsMusUX8KD2Z6Q1vueNAPDNMzQiBh8DAxMOo/GYY+gLh8K
	cmxuT+sv/xGOvDt99IP0ecrA6vErAQe5cN6jEUwhzHS2o2nb5mFKdUeCvXQbtTUK
	Eja7bMB/foB8yPMA2nUogQvg0I/LLcJxjf7s1hxBfoDxtmnD+lRAAgDGEL9fOx+R
	YQykJpmeDb9fGCDSBTOeJdine5TdaUnpHeOn9c53exrV+NGMQyBxtSB076wdHsTj
	X96BUp0ASw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwgjgp7h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 04 May 2026 23:54:18 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7de44ba64e7so6979741a34.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 23:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777964058; cv=none;
        d=google.com; s=arc-20240605;
        b=i8klKnVcxi171oxb8j4D0RLcv+QMtAISugxYnlXLGG1eNFqKd2zBwYaC+QmWDWhims
         a+uOF+kotBZ8dmIobDbzw4a3Fo2kFxMAFolVltNNtowXFwMN3K/hFoWD08Oc2RlWA3Ex
         7m4OGUEvctjNJsJuifvlYlR9vgiRfeup23jRfJFOFAEpSASAxS0B0cpQ7vpxZikwFiVZ
         Xxd3wPufVJJyiGFTnlU6Oy6IkpY6qSiAur1HMVniWCJmTxKdBGya47FxXzmCBtqfZq3d
         5rjQ+D1C6XF1oZZgo1Uq1e3eEKztRIjPEFZjqMoXMEStIKiikooE0Vieuqe1wrb+qor4
         TRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=uhzg8pVh5XZoijloMRfkO2ATqnu2chpe+p7ocg9d4tw=;
        fh=G7BzPYf51hYdL4b6Rjq5z/VZu1ttIzuhVCcz5SjVCgs=;
        b=D+mgWa7nfMfo6NUyp7P/DFzA6v/J/81bLwpVJc3/zYMEuZGStHiq+ukdpwM3b18CUh
         usvD4V+RgzrxWHLbGXXEf0PQ31DsPwI1IHSaYmrnfwdivdbrDU6ulNGDIXbmtiAgakXF
         v+9J182nXIwvHx0vEABfsL0813GnX0GTmPCsMk1ER9Ec86fimwJzub34Vf9zKJALztxA
         pnPyWFQ40sX3QeyqjQlMCSoI1EptxhEsRiqxTRfbOiW2O5pKAa/ppVvIAk14Yvn1EdwA
         ooOzzJus3s0l10+7TI13cj5PhIoSny5RmGZbpYHVRIM5OJC5NXK5RyFGa3hIXgIeSxP5
         hviQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964058; x=1778568858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhzg8pVh5XZoijloMRfkO2ATqnu2chpe+p7ocg9d4tw=;
        b=PldFep27WFPFlPDg0vOQv2m2PQvz8kCM8uKuM3eH6GeofnT2PbrvxlaBkf/wXZUw5O
         2WJZUK9iseQo0C6CE8sMFfc8dEnyzlvqPW04wnAd5UtS8Sd/pmwcOncYO/fr/i44ZsMc
         bFSttfvd4LW4d108migO5jfRiDhlL9K80Cm1grFIrCR6H8L+Mh7yxzOSVX8zyZXQxuW+
         9Tr4NkggqRbMkx361oc4gC48JhFn8B4oYQ7RqbaRKCPU5jnfWCAkH/H1Fkc17t9BqbVj
         aS9r6HotiIL7by7NGspl42Jnjkje/JfX7okrnISnwvUi1dArjqCayxixTDrI1bzD3z9E
         zq4w==
X-Forwarded-Encrypted: i=1; AFNElJ9W76zcP18a1pjO0E6bYPT6osg6JjqmPDxwRwhiM74Gd9UD6TtD9r1X5v0RYFRrYd1+UuEVx98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkmrLIyaFdbgrEvR3vhXSObWjpIQvJvmh3XTzmwjRQ11FVQyw
	nrF8wP1dsUhOMe951rngBeCYfeSWadKhMUWZEZXNA+OmQnZbmSLmOiTgC7btAm6JXvUaYWLK6Ic
	jO+ScE+yYLTNJp7f3l16f8lVFpJTXDcFdgkVS/74JWe2jYj+HVTyvaKEoT5z0ua690qeJAdBxNs
	nYF6V/ASTNYmlOtRakR2s+jF5QYRaDwFs=
X-Gm-Gg: AeBDievjDLrchI0sNtROSLAYsgYDNujZV9IhJNIF+g/pmMzvCNb80nLhAAIHYYj8RWU
	yXxAnVFej9tdNW89Gg+cypA5nb+DQGfBAOfKUw43zRYIXyHvoOwnURTa0R4PaoOrXdIxRoyiRcH
	X0kWNOLwLpQsXGzJjVrktmPfU5w/4eLn8j3uLuuEEBN7yoQeFrcVmLJarEjWEF1Mb0JGryBmtIB
	2vbHYMEXhp3L5W8tFbSEvZpeC+nlrY5rnYCBcaMC3/q7i2bqEo=
X-Received: by 2002:a05:6830:6e1b:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7e1cbe3be7emr251850a34.0.1777964057798;
        Mon, 04 May 2026 23:54:17 -0700 (PDT)
X-Received: by 2002:a05:6830:6e1b:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e1cbe3be7emr251833a34.0.1777964057130; Mon, 04 May 2026
 23:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <20260504154459.77b8153d@shazbot.org>
In-Reply-To: <20260504154459.77b8153d@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 4 May 2026 23:54:06 -0700
X-Gm-Features: AVHnY4LnfRqtsa29br_gywqWSmKi9XQx9-UD43AecyJJP1ECdfbRFsjVzAPHTkA
Message-ID: <CAH3zFs3ZEAjsy_8nq4EHGbNWzXVVfJeRynEdVNYu9_j8N24s8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69f9941a cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=VwQbUJbxAAAA:8
 a=YLhAehpVo6qmETfym2AA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: Fbk9rPy00NWw-6ReqHsM7kmRVsBPixME
X-Proofpoint-ORIG-GUID: Fbk9rPy00NWw-6ReqHsM7kmRVsBPixME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MiBTYWx0ZWRfX6OhJRlSG9Z0F
 4/RzUMPyhSHzrTzp31eUNlp28eMdQ2auG6UrzUfN1Y3lV+6JkQnenE20Tl2OBwQK5tx3cGEa8HA
 qnY129QJzAW83vdoTDYkmZcfWK+7VNNJ9fcA8wDnyFfWntxgv7oKAHSPFHcY6qwe4A0x+Q1hr/v
 oy8mRV7VZGmsJog5spj3NKwkCtT1qRsGsVxicAKv11rEZP+yGnZ437Lgiqj8zBpgdbff8WMpo56
 UaxiG2nVwjC8JsW325GaXVpd+V5+1nDswPUXy9JgxQDZx9BvItCYEtDNqkUfjja2LSh40cf1krQ
 /KzaqZXyoH+Xr0d4cXwjTtvTvfi0xK1yJqzPJqGAS7rqpE2psDL4KQaIDrQs1Zvw4Wt/fsdcv6A
 Mxuuvxp2nltFkbjSIXE+7eav0uWbmD5xbrNRiGMC6YxoYs9WUBR2LP6nty5CR5PytDb/ZrmLMhh
 w9OkhuN+Hdiuv7jHT3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 054B64C75CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.com:url]

On Mon, May 4, 2026 at 2:45=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> >
> On Thu, 30 Apr 2026 13:06:56 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer.
> >
> > Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> > hint, validates the fd is a vfio-exported dma-buf belonging to this
> > device, and stores the TPH values under memory_lock. This keeps the
> > existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> >
> > The user sequences setting TPH on the dma-buf before the importer
> > consumes it.
> >
> > Add an st_width parameter to get_tph() so the exporter can reject
> > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> The uAPI is better, but sashiko has some review comments[1] for you.
>
> Please also copy the kvm list for vfio related development.  Thanks,
>
> Alex

Got it, thanks Alex. let me check sashiko's comments and post a new
revision. i also copied kvm@vger.kernel.org and will include in future
revisions.

Zhiping

>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260430200=
704.352228-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!7glmqoMRhcdDwOgCAQuuEVqlhFJ=
rh9bAYHXvicXPAO2M-k-NPwE_wFeUjVhe7EXbkXMd6g7eOe13$
>
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > +     u16 steering_tag;
> > +     u8 ph;
> > +     u8 tph_present : 1;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     if (!priv->tph_present)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> > +             return -EINVAL;
> > +
> > +     *steering_tag =3D priv->steering_tag;
> > +     *ph =3D priv->ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -101,6 +120,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -331,6 +351,55 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.reserved)
> > +             return -EINVAL;
> > +
> > +     dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> > +             ret =3D -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv =3D dmabuf->priv;
> > +     down_write(&vdev->memory_lock);
> > +     if (priv->vdev !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     priv->steering_tag =3D set_tph.steering_tag;
> > +     priv->ph =3D set_tph.ph;
> > +     priv->tph_present =3D 1;
> > +     ret =3D 0;
> > +
> > +out_unlock:
> > +     up_write(&vdev->memory_lock);
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev =
*pdev)
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u=
32 flags,
> >                                 struct vfio_device_feature_dma_buf __us=
er *arg,
> >                                 size_t argsz);
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz);
> >  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked);
> >  #else
> > @@ -128,6 +132,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core=
_device *vdev, u32 flags,
> >  {
> >       return -ENOTTY;
> >  }
> > +static inline int
> > +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u=
32 flags,
> > +                               struct vfio_device_feature_dma_buf_tph =
__user *arg,
> > +                               size_t argsz)
> > +{
> > +     return -ENOTTY;
> > +}
> >  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_devic=
e *vdev)
> >  {
> >  }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,23 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag
> > +      * @ph: Returns the TPH processing hint
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer. Exporters that do not provide TPH metadata should =
return
> > +      * -EOPNOTSUPP. If the steering tag exceeds @st_width bits, return
> > +      * -EINVAL.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +                    u8 st_width);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,28 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + * steering_tag and ph are the raw TPH values that importing drivers s=
hould use
> > + * when accessing the buffer.
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u16   steering_tag;
> > +     __u8    ph;
> > +     __u8    reserved;
> > +};
> > +
> >  /* -------- API for Type1 VFIO IOMMU -------- */
> >
> >  /**
>

