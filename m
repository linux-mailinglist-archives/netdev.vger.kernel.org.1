Return-Path: <netdev+bounces-273413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL0bM0Eay2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:50:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2962362D7B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09D953013C94
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4642E7F0A;
	Tue, 31 Mar 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hmtSJqlW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A523A9BD
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918203; cv=fail; b=jk1nRTdDUSonggHsz422HMW9jUGG4i4sSFtJvxlQ+OVTOfhuv/3KCLSK5+LD3CbPoQTv5YqWB4gzxoLWTxOjnTDsNeUGkFaG8oflljzToVeWTObb/oNO0ZOpXTiVvwKdvvi9oopRxE/QuPm+9jJBAHAFcvpIF7t3AnypnIDa8mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918203; c=relaxed/simple;
	bh=L9wxjJkVn9DCD3Je0oXdQaiq061HikX6e+NC7GqD39M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDnsf9LfdTwL/wXomj2ZIjnab8t0YfMkAMTMys9uqhPjOKAhqZKUkVIFjHj17vzVZM5CsoaYLhQ+RIeVS8FS16C5yNeoBwvFX3ha2fC+oy+SxphjkTmaTQ84aBZXUvPSo55MIy2o1JBIz47afnHSoMIndK8z7DbrvRtOEtm7adI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hmtSJqlW; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UJHVFS3388487
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=G9PUQuU9Xd7OgZlLFFg33R8o/sQFjvSbJ31P2p7vH2c=; b=hmtSJqlWLivr
	FpTCzdmZ1sdgK0lw6T1On9MlFTNr/uNvKi/cXLpsRpNesknsvaBMgIL79u+XmQ4X
	OvONh8klorX+4pLd8y8kkhUDUQTnOoHsKZW+iV8xX7MGNxRD5b2L9dy2O8krlqFT
	T4CSD5bI4B7RrT4qwqBKOb4ybQ//NBf86XefGKXCzg+XsF/ie0yV8UBASZD+WhiY
	gHfb9ugRF/OC6V2rmi2H21Z8NJ7kJVUQ3wl8TD8HczsB5w6HeFYEojFVp/BfWvYQ
	hI+l07YKBq3lwSAlJXh0h1OGR0o8bpFCEz5x3yz03g+scWTCs0skkJpFTqyKTDiT
	LC6Prj3gjA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d730r0vx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d9d60f8e3aso13866031a34.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918200; cv=none;
        d=google.com; s=arc-20240605;
        b=crKbKOqld9YgL+XbwH57fOaj7+zsZWKxR7Jk5w8L5G1v0zxNTp0KU6iodRgid5vyTC
         yUMW2ZrLzN+6ESKhzSiJKWvw2EthU55O0N0FsWHvazpc0oWSMY6qdOxXi2xyZTNb0Oms
         MdEE22TKrjVWWf9nehfhUv7pu2ZhGpwXwi1M4HinCtprJwZZpaAviv4NUJmWcEsbPqjw
         UdwEPA8PQzkRoEXAP0JbnVLgvcyShNZCyMjdKqvRbROWpzV+iLuXawosDYGrErjG0A0l
         eyGH/PILczFo6N7pB9m6NZhY0axnFHrm752VYmi18ltKjJ4vVCCC2huAcv4H61eT8tuz
         tAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
        fh=JG6nfw+jIcM4Pb36/77lEG6l6svML9ut5QuRkPTsC2A=;
        b=IVINs2LW/tYrjEyKaMvNglS9e3Oi9HbE7sHDPeNQOu6BAmqCNHkfBMB30yZ0jJKCzq
         +Isf232CpnxNPrrxLBA7QB4ZdkaA8dGa1xSZFnv448McEahTLCfJb69xsw4pl5sogcSb
         lhXr5Y25irMD5vtdnalvsWISqki6/E+ItPswveH9/XaT1dn9E43oYAQ9L6/QOkAtBVvX
         +15i1aHM49iaHc3BNu29Kouh4br+14aRWZz1LMy1mj8+4Y5QX+VFGOLALlR7e1W55kpn
         2uXK7Q/E57zbITuDURk9NoCPZR78tdBOw6D2Bu6JU1Y23b0+e6MMawv5Ojba8GLxdw83
         LgqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918200; x=1775523000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
        b=ijNeJUIq9IJ9WlP5Qnts4JMAsmer0NggdbgJQk8+XZRBuGeXdUksNiMwUgX8y6ILpS
         L0f3ZIjlNPSQrLtvb03RqoP04zQ1+gA6xWxEkCSSwxNk4cEiYdwSOBxTmwxKvElep0Pj
         Fh+O8CSp3qZmPaok8V8tBsBXJc+Mm3RJA/yvGSH/Dk8ULxydhAyDrfUZOjU3Kf4sOWZ5
         JxoX4FLAAH/kZIjGqXaWTDwCkaHe+Ive7nXJ8cwUowmXZ26bMLmYBnsOUI4OTZU5fsOI
         M8YS+yqpGjKfYJuF0EgbPMnytp/ZcylkpuFXR1leM/t/p1yMgcXFRTrsqb84TAsJZA9d
         SCGg==
X-Forwarded-Encrypted: i=1; AJvYcCX96o+M9c7LUGNVI0DGMOHWbw73WYEVN2KDEia5XfuY1SvAFTTWufQpIOj2cSZvWCaG2hXyz8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1N59DzuF7eOHWUdWURB2lLI6ZnWMj5ZeC6FZMe0//4ypMK6j
	W98m3VhJMYUIuwS7pbsZiX72VgAaLBRWyISZ4Zs7SJ+zMVzaLto6aoxK5MbsXVq6uixehp3xRwc
	kLZcHG67M14M49SJf4xbt3rpoREt6l/OFyHtA4XlMR1o/JiPaL1cyS48QE562HYgbbGH5uD/MKM
	SLeEf58h/Swhw/gKhdP3NsbinliGbQZE8=
X-Gm-Gg: ATEYQzx12O9FPPDQOpBwYA4g8k2qWPhkgbdZ47zlZ/QqMNpeE+Vk2NXcQn+VrEPKyUU
	EC8tKGDtoOgOIG/0yQgR3fya8PgdxSkQg4PXvq10GSWV30+CciSvJC1sYDgxlo50/SLN8FC6WRg
	ot/sTbRCt6wHTlKjdI874GC5tPAXpc+kmgNIiYRjXcM/uxAIgikbX/RPngbWtd/2DcsdFn/pbPx
	M4xy9RfXwJVUttfDmU=
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id 46e09a7af769-7d9faebd4e9mr8218632a34.21.1774918200495;
        Mon, 30 Mar 2026 17:50:00 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7d9faebd4e9mr8218613a34.21.1774918200006; Mon, 30 Mar 2026
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com> <20260324234615.3731237-2-zhipingz@meta.com>
 <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
In-Reply-To: <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 30 Mar 2026 17:49:49 -0700
X-Gm-Features: AQROBzDnJHaZAUclxmUw4Fi3GhjHKGCAE6QyCPHZcIf2necy4jORB1gzd3l2wJA
Message-ID: <CAH3zFs2ia80jkLRTUdExd4wQM4tK_FSgGTgZumDWpL-gjoDERg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: P5eeVC2A1C9p65WpRklP9lylZ-472I1I
X-Authority-Analysis: v=2.4 cv=d6n4CBjE c=1 sm=1 tr=0 ts=69cb1a39 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=o_g7sp7U41fvUp2KB-EA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: P5eeVC2A1C9p65WpRklP9lylZ-472I1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAwNSBTYWx0ZWRfXy5i7ztZoH3aR
 +rDbnnNPqyAEBvaYRbzQHR5bBDlgUamhogQTrhom5rhDht1rH0PVv6DPbTTfAfDK7bQOnEHdz0/
 fZKHO+r+5vP5YHjiv183uOkxNxLFn9yBhmwMbZ/ZTkAwtDmA9VexqNcnPrrkV75F2FNIusJKpy8
 SeTQQpM7+fIxt97rsU0ic5zmTTYW2tyfsjw92eTOOldD7/JtCwm4RtRbcEcXYETvxoPI2CDGeMc
 hCajbCFVNvbhxKY9qRngpdI0cLQLDQbJryDoK8rIUzQlz0Mx195AI/8U4S43mZVXfK1IEmTzJo/
 loa/8BMRmsbfPlKurIWVmv4awyxvmnVoQsfZuFMw1tnyRXx/GJmpN/askz1TruekPFvMSqwZgWJ
 VcDHADseiIsCkyiFaWPyTerDXmdgAL1BnU7RtF0O/btTLK5qLv/aAoRhK793pH3jmwUMyKrjsB+
 qLW3wztCbUpLhz4fBRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:dkim,meta.com:email,mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: D2962362D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 7:22=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 3/25/2026 7:46 AM, Zhiping Zhang wrote:
> > This patch adds a callback to get the tph info on DMA buffer exporters.
> > The tph info includes both the steering tag and the process hint (ph).
> >
> > The steering tag and ph are encoded in the flags field of
> > vfio_device_feature_dma_buf instead of adding new fields to the uapi
> > struct, to preserve ABI compatibility.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
> >  include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h          |  9 +++++++--
> >  3 files changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 478beafc6ac3..c45cb3884b85 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
> >       struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> >       u32 nr_ranges;
> > +     u16 steering_tag;
> > +     u8 ph;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -60,6 +62,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >                                      priv->size, dir);
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     *steering_tag =3D priv->steering_tag;
> > +     *ph =3D priv->ph;
>
> If the dmabuf exporter don't provide st&ph, this ops should return error

That is a good call, let me address that in the new revision.

>
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -90,6 +101,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =
=3D {
> >       .unpin =3D vfio_pci_dma_buf_unpin,
> >       .attach =3D vfio_pci_dma_buf_attach,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> >  };
> > @@ -228,7 +240,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
> >               return -EFAULT;
> >
> > -     if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> > +     if (!get_dma_buf.nr_ranges ||
> > +         (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> > +                                VFIO_DMABUF_TPH_PH_MASK |
> > +                                VFIO_DMABUF_TPH_ST_MASK)))
> >               return -EINVAL;
> >
> >       /*
> > @@ -285,7 +300,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >               ret =3D PTR_ERR(priv->dmabuf);
> >               goto err_dev_put;
> >       }
> > -
> > +     if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> > +             priv->steering_tag =3D (get_dma_buf.flags &
> > +                                   VFIO_DMABUF_TPH_ST_MASK) >>
> > +                                  VFIO_DMABUF_TPH_ST_SHIFT;
> > +             priv->ph =3D (get_dma_buf.flags &
> > +                         VFIO_DMABUF_TPH_PH_MASK) >>
> > +                        VFIO_DMABUF_TPH_PH_SHIFT;
> > +     }
> >       /* dma_buf_put() now frees priv */
> >       INIT_LIST_HEAD(&priv->dmabufs_elm);
> >       down_write(&vdev->memory_lock);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 133b9e637b55..26705c83ad80 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,36 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      *
> > +      * Get the TPH (TLP Processing Hints) for this DMA buffer.
> > +      *
> > +      * This callback allows DMA buffer exporters to provide TPH inclu=
ding
> > +      * both the steering tag and the process hints (ph), which can be=
 used
> > +      * to optimize peer-to-peer (P2P) memory access. The TPH info is =
typically
> > +      * used in scenarios where:
> > +      * - A PCIe device (e.g., RDMA NIC) needs to access memory on ano=
ther
> > +      *   PCIe device (e.g., GPU),
> > +      * - The system supports TPH and can use steering tags / ph to op=
timize
> > +      *   cache placement and memory access patterns,
> > +      * - The memory is exported via DMABUF for cross-device sharing.
> > +      *
> > +      * @dmabuf: [in] The DMA buffer for which to retrieve TPH
> > +      * @steering_tag: [out] Pointer to store the 16-bit TPH steering =
tag value
> > +      * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
> > +      *
> > +      * Returns:
> > +      * * 0 - Success, steering tag stored in @steering_tag
> > +      * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
> > +      * * -EINVAL - Invalid parameters
> > +      *
> > +      * This callback is optional. If not implemented, the buffer does=
 not
> > +      * support TPH.
>
> It seemed already impl...

Yup, it's supposed to be implemented.

>
> > +      *
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index bb7b89330d35..e2a8962641d2 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
> >  struct vfio_device_feature_dma_buf {
> >       __u32   region_index;
> >       __u32   open_flags;
> > -     __u32   flags;
> > -     __u32   nr_ranges;
> > +     __u32   flags;
> > +#define VFIO_DMABUF_FL_TPH           (1U << 0) /* TPH info is present =
*/
> > +#define VFIO_DMABUF_TPH_PH_SHIFT     1         /* bits 1-2: PH (2-bit)=
 */
> > +#define VFIO_DMABUF_TPH_PH_MASK      0x6U
> > +#define VFIO_DMABUF_TPH_ST_SHIFT     16        /* bits 16-31: steering=
 tag */
> > +#define VFIO_DMABUF_TPH_ST_MASK              0xffff0000U
> > +     __u32   nr_ranges;
> >       struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> >  };
>
> Another question:
> 1\ PCIE protocol define 8bit and 16bit ST
> 2\ In host-device ST impl, the ACPI will provide 8bit and 16bit ST, the c=
hoice of which
>    one to use depends on the minimum supported range of the device and th=
e RP.
> 3\ So in this P2P scene, although exporter (e.g. GPU) support 16bit ST, b=
ut the consumer
>    (e.g. RDMA NIC) only support 8bit this may lead to mis-match
>

Hmm, let me check how we can address this mis-match issue. One option
is to add an
additional parameter and fail the get_tph call when a mis-match is found.

> >
> > --
> > 2.52.0
> >
> >
> >
>

