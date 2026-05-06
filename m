Return-Path: <netdev+bounces-284988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OXzINCE+2nXcAMAu9opvQ
	(envelope-from <netdev+bounces-284988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:13:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6564DF2BC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7667D3021D0C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16294A2E0A;
	Wed,  6 May 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WohxvzDB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D53ED5C8
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091211; cv=fail; b=Gt1vkmPpwDXQoSqUxA8Z/ptHg4aD9CotWzwS+Bb+bIJsd7fer8GE5iqedZK3RXJHA4Ot8NYIQ7PI3+6RndwA9pN+7Gb9XavLcfgwzZUVImRplplxL/cHN+G0X49IKVNk34SphA/PFTMSbzHVyqa2+GJk+zi5UCIzNY6RPhQUtJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091211; c=relaxed/simple;
	bh=iwJF8kNlzSONi72wttB9cdvYDDohgwHHTCevGMN+7M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l490v7BdGu5+e75dzdCzOgvnqRj3Kk39LAQ/z7AzVkgV3f8DM5B1agHlz+XWxceuVR/xMQP1Mp4FUF5rklOBY1oqmCwRd0YL3c6Y5AdzAADOeckiCzr/vQpoUlUg2iIUOhOQA/vHgbEfbJvs3eQ2N625qwsoOm5HxzmOfzoLCYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WohxvzDB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6466tnCk2489734
	for <netdev@vger.kernel.org>; Wed, 6 May 2026 11:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bsbBvRMYnEJLwO6vFciq2lgaf49YRFfLC0382/bbMDg=; b=WohxvzDB7qU8
	o2wqk7WXisIZ2+qX8jjaoaehtsTVUyToiY5UVloN7qizzETPowd5S4Zb8nsC9EMl
	ULfRCe+eyS5F3L7XFUvewUEdAC5eCpjIHy/fSU0RKXCPBgxqLmVKOK5uz4d1xyua
	Eke9sevlGUcg5bDSN2idKRVF5h0mP8Krj1GJ0bk7ZFEuvrRJTHCQyy6EslL8rHDc
	eY2QYB8+Y7raLFdBngjmOlFSqJJ7pt4TUuOaX0mcx7wJ+l1lJ5lGdJpHSXCX+lte
	R3HEpqoAP35QuGsNrP9kQzHI0fvkMtoI/VDJafYjIWur8zAzA/LlV1Ml+TglKNA0
	ju/vhonoEw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwck1tg3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7de442b3402so7998a34.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091208; cv=none;
        d=google.com; s=arc-20240605;
        b=V/1DqbnA7PHcqvb15WG3p9H/UqNUSZ+ZiOOdyeYQ9MyTnzYyuYCSe0sVJF2+U/4+h5
         RLGmJLtD2h/mWViBiImu57T0uy+iURLVaBmOt92UWlVDK2YIvT6bKs4pRDRh3fl0k+Bk
         yMi/CwNw6eflu3p0FEHZdN7bobBlT9JYmPfy8+GBMkeTuz8sehEp3qABgJtRJOoi6OpD
         EhazyODudOBx+rflYaIWAdQC8AJCSHLISgcXiElQjXy9hKPkGEGtpGUfoPPz0iFf9wEk
         Eur34cEbFNQpMIVcCNBrPM7cCPW07kUVrKCFz2SlFbrEKgcK6mr5iBsicgYNL9yBpl1v
         u7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        fh=dlj0lRvBubJOIhE3kJgOaxduP0yIxOpMVs8F1/Nf49E=;
        b=YDpgF9d64KjxRNeFPyLI20a7XJL14STFtaEb8qEgVuFVYW7oQ3KUGHdVsPijf9c+id
         5CTMMFmCNWDkYkXPRxQZrrHAeDTZdy8cmcxRKtST+qxlKcDjpv+iy7i9rkL85yo/gdVs
         9r3klOCHZuli3fnXx9WUH1wB6v2I9++zjtT2ry7+NwJOLFtKruwW0WTlXtb6htqGsfRu
         EmTXvKsYHa/s65LyuyzT/uej8MepraUKkEWcIMSY5+MUVhddFIxbC1RlrlaJt7IdCyMK
         gzBebVx2TxRQ+/m5nP8DUgt1cZ9TKMAT+LT5aMW+eoAhQR9cDQsaLudclpz07bk8IkFN
         g09w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091208; x=1778696008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        b=EF2Qao7VkpXqFXdvDKTRxll0Wd4mbcJPapw1B0P0Lv5Toc7vWbDdaYhKN+sRXXOP1S
         iITM4gVJ9qNVnT/YQ92Hv0FRzRp725O2zhz3X2IjvWQCLAQ8pkqpwD3F0x8QR6fDloWi
         52FzQdCp8w21jn8lKlexxrwu3EAY2ZvqgCkj1HcBlyW3D646kQ4HLYtatf8nnzKMedxP
         PaIrn//FZIYG+uhPmp9lO79s/7I2CNJW1pFuWNb5KmxMswshnaErK0byJ8hzhjjU7x6e
         xewbdx8LX8Z1sZSev/wcx1aGf96WObe2L5twTN7sUY1Xskuy8cx9Zz5Gt+BkkXVVDyRc
         mj+A==
X-Forwarded-Encrypted: i=1; AFNElJ/lW9sWjIHlOdGIlNEIbjEt7eARpqMN+Fjm6lkC4XqM2h+fgPaeIm6vxyD5igOjUrXBPNYhED8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraVNq0Yb8kNK9Jo263g740C2D5YB1jOK6V5FrT/kaYuJYhPdO
	TcZiNiYOuiDtA4mllI9t65c7G+Y9X5ouR6FTb2H6MNOeO8cRSRuOqbMaOeqIIVmtpUPOd5ToQ4R
	MNj2mwJXKZfmwRFzdfSAYFG2Sk/fNNLPYbiTvhieJDfjxM5L484C12TjnhPDhI+FtUfS2+7Bv5Y
	/PswM/QOmnJxu8M6kLjXV0DeT1tGBv2b0=
X-Gm-Gg: AeBDietBlcPrImrDLlssklA5FZmjedba+8MZvZ8R66o2fHxppkVhpf5oMuZ6KGUqg13
	CIB6kFo4+Wq/bE5yfJOrAUwiHaXtiZ6tEcfI54+UdQ8eA+Hx63WJqcEU0vinhCCVHp3L9K/BTUS
	fRB2yigOctpLxX3U/SH2//t6QPdIg9TzDysqXwsmNW+ifdiwAqTFqDNfIwnyxhGE5RZYS9UT2cW
	ygLjqS2Bcl7nj+cDCDv6JheiXoZkAYr
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id 46e09a7af769-7e1df2863femr2542395a34.28.1778091208387;
        Wed, 06 May 2026 11:13:28 -0700 (PDT)
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7e1df2863femr2542358a34.28.1778091207771; Wed, 06 May 2026
 11:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-3-zhipingz@meta.com>
 <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
In-Reply-To: <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:13:16 -0700
X-Gm-Features: AVHnY4IkP9FyuA_XByk4LxkXqiqZTgspyYe5GlY8B_-IOTQbxE0OcjjDWm1D7Xc
Message-ID: <CAH3zFs0zAf0=kxxMfyxuBF0Mw+0FTFANHDG5C9d7-vQ9dFO0Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LcZzMVBd5UfRc283rh3TjXo6HmVNyB3S
X-Proofpoint-GUID: LcZzMVBd5UfRc283rh3TjXo6HmVNyB3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OCBTYWx0ZWRfX1LuEvSlte8gs
 4hNxlVKb638P6ZmEo2Cqbqu3DEwLOOFoWFeYSIS3FAeC1gfZThuC7DwSkPSZAXoNdn37hsYc9or
 gF18/k9h8k8mKvh8QyKFy5IjHhr+dlytWk/Ylw6QWvZbiCoowDE8fCAfv9f7LbjPE8nkDjKze05
 58CU5F7pPd7AXiZ1Ax7/IxO4BglOt+9aOvhFvw4Q9XxjjV8/0L00dCCDJVlma6u5pycJcCj1GGM
 XYGp7TVJD1/6G0GQB10HYwNjo9orYzVSdCefsTCK8q9Jxipn/ZGNl8+Va7xsnwjIDQL8+DxEWMP
 W9DkbEMFhxluOhpjFQn6COiKDaiWty5gVkjViVmtIOrmT//+bGjcwe2VR4CmYbMZ+a9F9nZn1eX
 FtzI+8TNI9/qJrf3yfnZLm2sYZ8m2tA36A+2FNbMC4jMV5bOyh1veY9OIINAYcGsevaJWr2T+KT
 8fqYbBnPHAxj9h0jt4g==
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69fb84c9 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=kFoJLRxUVyBjw7Himy0A:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: ED6564DF2BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:dkim,meta.com:email]

On Wed, May 6, 2026 at 12:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering tag
> > index. Factor mlx5_st_alloc_index() so callers that already have a raw
> > steering tag can allocate the corresponding mlx5 index directly. Keep t=
he
> > DMAH path as the first priority and only fall back to dma-buf metadata =
when
> > no DMAH is supplied.
> >
> > Pass the device's supported ST width (8 or 16 bit, derived from
> > pdev->tph_req_type) to get_tph() so the exporter can reject tags that
> > exceed the consumer's capability. Initialize ret in mlx5_st_create() so=
 the
> > cached steering-tag path returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -46,6 +46,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st=
_index,
> > +                           u8 *ph)
> > +{
> > +     struct pci_dev *pdev =3D dev->mdev->pdev;
> > +     struct dma_buf *dmabuf;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16=
 : 8;
>
> The tph_req_type is defined under CONFIG_PCIE_TPH, how about add a wrap f=
unction
> to query it.
>
Good catch!
so the direct dereference here will break the build when TPH is
disabled. I'll add a small
wrapper in include/linux/pci-tph.h alongside the existing helpers, e.g.:

  #ifdef CONFIG_PCIE_TPH
  u8 pcie_tph_get_st_width(struct pci_dev *pdev);
  #else
  static inline u8 pcie_tph_get_st_width(struct pci_dev *pdev) { return 0; }
  #endif

  with the implementation
in drivers/pci/pcie/tph.c returning 16 for PCI_TPH_REQ_EXT_TPH and 8 otherw=
ise.
Then get_tph_mr_dmabuf() becomes:

  st_width =3D pcie_tph_get_st_width(pdev);
  if (!st_width)
      goto end_dbuf_put;

which also gives us a clean early-out when TPH isn't supported on the
device. Will fix in v3.

Thanks,
Zhiping

