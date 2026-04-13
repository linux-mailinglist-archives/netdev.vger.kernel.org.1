Return-Path: <netdev+bounces-278177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO7eEuM23WkmawkAu9opvQ
	(envelope-from <netdev+bounces-278177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D866D3F217A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0086730164D5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC8361DC3;
	Mon, 13 Apr 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BhCoaxeI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECB36897F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105183; cv=fail; b=sIFx8FtVrUW/kluBM0V77WN0NiZAmrd9H49B/EM4m6VRdtyG9sQH3EYyK5+nDYF2XU7Ms9renYCX75/lxV3S3icf5LEYKJsfd9OH54DcTFQZds3sZuvQjd+uIwM3OstthzgydrCZdxGeEpgQs6HmhRISuaHdJqrJkripfFTLLPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105183; c=relaxed/simple;
	bh=cBpXrkihGcjGQcaYRaWShDZmky7Cxex9eGcodqpepCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STCW1/3bnPFxgDMf6xvoi2UWUMzfON2B9YWIxVZ2L4ERWi13fG9OzjPYyU9i2Xw2mVGyeqCNcN+rvmhleb+yxqnHOLucHY7cd+aEwpR+06yh9iPclTQGcdKBgq+d3QTMpmjvmDpBCOfIOYLaM3U0FfXheCDBNp2gUlKJcuFTUNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BhCoaxeI; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63D46HRO665597
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zG1i4GOJI0Qqxhx6X/y+OYVi9v31A3eEgoxO9M8dGo8=; b=BhCoaxeIAUTn
	YJ7JhPz3Cx4IihaBsBpITr2/1JYDB8qkbM1UsOnx6Hz7lD9+VdcpE1EJyypDO/KG
	WCuinBHxBNAbk1fqrW0/uMUNq3AFMFBcyij842gJXDxEArbnbnSFlkWcDzkkpHJw
	93uzWR86iB/Yoqf4nv/24SWhVkPlWjvuAPhNCj2eGDalRmeGG5B83FBpS4No7Y7L
	joGCbmbGXSXrXvzc89j++TyvF2Kco6Mo2SyFjdP79qHqn/VKxxhWFXQ309Ujk0O2
	ZWUwUErBjTlmgcLhxUNhmB9eD3sRs8I5KPtN+ckqJ0rrQA5u0slfiHH3Lke5SO3z
	mic2S/rLnA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dfhssjs69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d7e995a87cso27444a34.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776105180; cv=none;
        d=google.com; s=arc-20240605;
        b=S9sINkD13HribKQb/Ya/Qxk9n9BC/mLJTcw66FUWNZzxXCm5QYIO8ipLnu3yYJjyPb
         nle9mFfXngvosoppfbn3FmlUkb5M9e2G9+eygWoEq0QxFeg/FY36kt62Qv4GIDEDtozt
         UhNODAGzi3uz+Og1Vq1XSW53ZARa/3ODWiSUyXS2eHVTS8K5xt0w/cywYt7XBNWV9Ftx
         /5RpbDqrLr4Y9QtZQLwq1HMp/S17kBPFbZVjqDagyp3Ygyw4JCSQ/bEy37ZSWqTJHlUT
         Ik4EPMqk3aZA4Zsnp1gsHBzd4p9Y+YMal4VifXHI9r+wjEDkYSYLyOMrOIJenDdDgJyW
         09dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        fh=usF0mWYGWELhuRUGxAHPU/VJgjUGtw77tL7q2l0WCD8=;
        b=HTjQH8vjKQ3/gzkmOdISr+228yRrkVqoxeIO407oD5a+KYk7/sWwzGV5mxoguyIty8
         DkUVUb9WORJwiDzsfxh+X/vneDDnatS1FsXXwTkIeeMWl20x+I/nfN+p9P3DtErmOFf3
         b1GlIgdG1IaWMjyaY+ne6KnP/gI9I9XYMaeqUWsySQ+dtEuxNkAMjUzIQddyOIRi5P7b
         CtddsQrROtLqiyKT5EVCi6CskF0T/0w6ti/B6ZXRWczcTA6OPWwxUSi1xChhxN6a9te6
         n/ceI107fSTZx+ln4ItwnGNafNJR9uqF/unWQAweikgeosGEfRwp+k9YcwCIlag2QL0f
         1JIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776105180; x=1776709980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        b=erwHKlOAh3045MydTqe0hIL2srKogexv610EwOW0osvuxp8cuMPqtzFfZSOOaaZM8D
         8gq3n3tcEWdNGu+7PbE58clnC728aPJ9kdNLeE88TzZHUIJNqyJWEh063Px7EXnQlJYc
         jwGZg7rhrHjEGBpcHEI4yyZBB5ilgEmAK4BfXG9ZKLI1cZm65Cr6P/Zu0boNluvqhpqS
         MoGfnoe6iyYR01b4dQWTB6PFTXC6KGIXdnGuWXOzwJr5huR6NMGtMobcLVVNajUpMLro
         E36Vpm7RJvTg5AmzDik5O/ABbbIon7Q3OwozqMff91xJy0vDHXHltdjazI/9cwHbGd13
         7S6Q==
X-Forwarded-Encrypted: i=1; AFNElJ86kPSymTc9T72ARu1aUS0071MAvdlN22IrrBVyBoflt8WqrCX2XJMPboLlTerrKqF2hebTYzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwag0cRj+dQBEM+WNEXzWwulUinMu34pMujTCVNWsXSpslR55V
	5A8VzNOTjVCnlSmA8n943wP8K+6S1ATwtB65lihu9O6YLk0bXwans7x4TkJZn5NueBn5gAVbNCU
	NBXQwxBcMgR+tkPdUDMxMR+fosCKPWzNNzor0wOr+G/ne5+O+ROeHsYWmVdqdlnKcvF3YP11Udj
	Dv5+QXLjTCNP7OwsQn3OsMhNnikBfjpEc+ZfDvB1A=
X-Gm-Gg: AeBDieuhg0/Jcex71Bo0mKcN9ZHbaq3oc66MauyKagOrpuJp8rsJq28dVVnd6HXWoIW
	DRpmCXx+PVsPjWPtIpWTXpbqvVwSwWTfZIFXj23dif+fFUAnqRVX9rY18Gj6/Iqz5U4186nd2jX
	Y9mwcKDvJJj6d73Rbm8g/lKd3kZVhv/kqNkotsyR3dkJ+TG2thJsK412dEdCt2jfz52LJ77qW3j
	Xu4knwgY3qEutIugBIL+WykbyQUfdj+
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id 46e09a7af769-7dc27e1ca9cmr8189338a34.24.1776105180124;
        Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id
 46e09a7af769-7dc27e1ca9cmr8189318a34.24.1776105179660; Mon, 13 Apr 2026
 11:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal> <acwkAo2k41xaxdTS@kbusch-mbp> <20260409120415.GF86584@unreal>
In-Reply-To: <20260409120415.GF86584@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 13 Apr 2026 11:32:48 -0700
X-Gm-Features: AQROBzDIIpZEN3aiHYPi89ixDuzK7SpFChCr2JMeXAVEQc6s_3ctAex9jcSvckQ
Message-ID: <CAH3zFs0hx_-3LetSUaPRMg=0jaL=GD7Mop3pEUhJ3O3qkaJrQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8caBfPd9AyqpW2Tf3XE3luvEiP9oUKF1
X-Authority-Analysis: v=2.4 cv=Ye2NIQRf c=1 sm=1 tr=0 ts=69dd36dc cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=f99BUTzuh9MxvKowt8oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8caBfPd9AyqpW2Tf3XE3luvEiP9oUKF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MiBTYWx0ZWRfX8Ml06RvUKBNm
 cZDdl2zTVdOGNyfD9YvbSTNzCg5YpkWaEQehS3LBhq12aAM/gffRN9VNGJhr5N5zvQUuFa5I8BF
 lthdkNRR5k8DWv08OGcbEhHYkEDxN7tE6f8zVgjZdQhnLApk4+U7xDHOJq0gE1MigcTbvO/ZqQf
 meGmqiIlrN4qQMBPvSP5O6rHM5iE865uuF297BY3+ORxCWyGtApwbLuZOI6mH9NHdyZ7Xxs9Mty
 Au7nJmWvQoN6YdfupH0ERmeoHPY2vchaS9j+3tX1DjVax9USvpo+DENQfvupgHAj1goAqJRt3iV
 1z8VN+zoH2LwW8CAh06GflO9Fu3UAqrjNnOJABiY7ACVzti9tsZenzxif8z4n1YN8+ZeUn4mvoa
 qui7m06SFjRFOP8Pde7zBVpYnyX6ft5R59yRuobuivt/h1ClqvYZH/hF3382wYtPYF889WGDSaO
 UI7TyF/lDJcp/ETTCcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-278177-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+]
X-Rspamd-Queue-Id: D866D3F217A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 5:04=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> >
> On Tue, Mar 31, 2026 at 01:44:02PM -0600, Keith Busch wrote:
> > On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> > >
> > > Right, what about adding TPH fields to struct vfio_region_dma_range
> > > instead of struct vfio_device_feature_dma_buf?
> >
> > You might have to show me with code what you're talking about because I
> > can't see any way we can add fields to any struct here without breaking
> > backward compatibility.
> >
> > If we can't claim bits out of the unused "flags" field for this feature,
> > then my initial reply is the only sane approach: we can introduce a new
> > feature and struct for it that closely mirrors the existing one, but
> > with the extra hint fields.
>
> Something like that, on top of this proposal:
>
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 3961afa640391..70d5ee1e3ef7b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -241,9 +241,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
>                 return -EFAULT;
>
>         if (!get_dma_buf.nr_ranges ||
> -           (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> -                                  VFIO_DMABUF_TPH_PH_MASK |
> -                                  VFIO_DMABUF_TPH_ST_MASK)))
> +           (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
>                 return -EINVAL;
>
>         /*
> @@ -300,13 +298,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
>                 ret =3D PTR_ERR(priv->dmabuf);
>                 goto err_dev_put;
>         }
> -       if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> -               priv->steering_tag =3D (get_dma_buf.flags &
> -                                     VFIO_DMABUF_TPH_ST_MASK) >>
> -                                    VFIO_DMABUF_TPH_ST_SHIFT;
> -               priv->ph =3D (get_dma_buf.flags &
> -                           VFIO_DMABUF_TPH_PH_MASK) >>
> -                          VFIO_DMABUF_TPH_PH_SHIFT;
> +       if (get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH) {
> +               priv->steering_tag =3D
> +                       dma_ranges[get_dma_buf.nr_ranges + 1].tph.tag;
> +               priv->ph =3D dma_ranges[get_dma_buf.nr_ranges + 1].tph.ph;
>         }
>         /* dma_buf_put() now frees priv */
>         INIT_LIST_HEAD(&priv->dmabufs_elm);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e2a8962641d2c..a8b8d8b1a3278 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1497,20 +1497,30 @@ struct vfio_device_feature_bus_master {
>   */
>  #define VFIO_DEVICE_FEATURE_DMA_BUF 11
>
> +struct vfio_region_dma_tph {
> +       u16 tag;
> +       u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -       __u64 offset;
> -       __u64 length;
> +       union {
> +               __u64 offset;
> +               struct vfio_region_dma_tph tph;
> +       };
> +       union {
> +               __u64 length;
> +               __u64 reserved;
> +       };
> +};
> +
> +enum {
> +       VFIO_DMABUF_FLAG_TPH =3D 1 << 0,
>  };
>
>  struct vfio_device_feature_dma_buf {
>         __u32   region_index;
>         __u32   open_flags;
>         __u32   flags;
> -#define VFIO_DMABUF_FL_TPH             (1U << 0) /* TPH info is present =
*/
> -#define VFIO_DMABUF_TPH_PH_SHIFT       1         /* bits 1-2: PH (2-bit)=
 */
> -#define VFIO_DMABUF_TPH_PH_MASK        0x6U
> -#define VFIO_DMABUF_TPH_ST_SHIFT       16        /* bits 16-31: steering=
 tag */
> -#define VFIO_DMABUF_TPH_ST_MASK                0xffff0000U
>         __u32   nr_ranges;
>         struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };

Sounds good, thanks! We will follow up and move this RFC to a formal patch.

Zhiping

