Return-Path: <netdev+bounces-297087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c9EPHE8nKGq6/AIAu9opvQ
	(envelope-from <netdev+bounces-297087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D46614FA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=bofmRsKL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297087-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297087-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 148F3320384C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADE3403F7;
	Tue,  9 Jun 2026 14:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924F32E757
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:39:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015963; cv=pass; b=Y0qWV2P5FOcja/YMxmtTRC2rYd84uM0gXmnCMABKAlYDWkp6kiOlt+h2w/oh4S2WREGa0SJBaLLA17HjrykuQaiLab/QajpZQMlkB9GXlgKOz55hVzgGwO33QJ7wKrd3yQInEyWxjMJpV948dE7LX64C2LFwp9dcPomAND6EHY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015963; c=relaxed/simple;
	bh=FbYR/k8DLxlAf8kVof4hhiKT8ECF5Pd8+LC9O69NXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKiYVSy/0lN2no60hVGryzMHsOa8bmhYS6g5fowyqCIpfVLCb7+LCT/dB0f7x0MGHuHL8li4gTjvbVI7pq5noYAOT9O16awIMtOTrUG6vVBddpw8LgcJl6zoI3c/00EDeCXUPOCrBHGctYO/rgrKd4bE2rIAPH3DskwAqtU+Uj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bofmRsKL; arc=pass smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658KZ4or1892443
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 07:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=kNeH4tXtKNJiFBFWJPRK
	N1EPfU64g+YPkV/H/UdFhBs=; b=bofmRsKLK4osQcAFWiwXbtpr69w36y9aEPuV
	DGBeGSJClR6Iux5v8lxlgpMiVzO5x2Rc7XvV3WDDGERk1A0vudeYRpxUQTgVJ8FP
	Vp24tp6sGkRRtgnEWh5ISlm3X8w10Fv5cHFadx3zazkv3Puh6lk2WAALivP4RcaP
	osrasMZGfR98HjII9TAhAiRWO3neAxrV6MDSF+gSO8eKfKkKXqCwiEoRahlhPycg
	4+6EMm9OA50YdVt23PeVBTNs8CTpAfdAPGVGJTNzDE3Lz+aVd4fRXAzpSV2n29Ro
	DBqbIiI7haSoaEF0q5UsONLcNWq3+7vIqLg83UvH33HJ3kZ2gw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en85kcupk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b5976d74so10386290a34.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015960; cv=none;
        d=google.com; s=arc-20240605;
        b=TZYi6C9eqJadrolDvo6D+pYPLCiX0LLkNLuYAQA+kED901gDD0DSexVstCHuH3D6Ty
         1eMHiIJOgN2BJKb3FNOBjKe8PfKxJ7DqzZcwP0fZvK3uGCQ9NeUxZNrL77EOc669mTDP
         Fft1pKqfS9XujEsbCXJ+pbWx5zaYhWu339oSMAJ84OOIq4o4rve0KsEJcjj5TdbiSudI
         NjB7bkgbL/XbPqNJ53lNKDx9OJ5ZWIEsfVJg7bj8Ha6MhcpT6dmY3Gb3+Yc9NrNKluSI
         L9ggOD8hsH9UDLLRjDyGPKkCNhQWR5azisb+ekFYAYxrXm1/xTsir9fKr0pGY9qTvi1U
         7CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        fh=NbcNlgsChzYLBss8ZPv96Rx6dKw/nCsueUDt/UgvTU4=;
        b=EjDcnm7BSTBaWj47ERF+W9cMDCG2FPEqP5ohS9x3CKrhTJwDwC+uyXEgJ+6lRmOGHx
         oDWQl62HQ8MPuDEQHUq7Q6MtSEmU/YCopsUckgtpCHygslju4NFWeRMlBNxczteQTSlc
         XNWjwocg06k3pElzHlZYqgztfadPOlj6uIIJJhKUHx3wKxPgAJ59qtzn4i2qpVKUcurX
         QIAp9KGV92bTgrgYWINZX7PGMJ1yDF0aTw4bnFYg7vixlbrS2cvca9j1o3yIj/32jR0Z
         lgvJy0ShyyZuY7PWKUX3Kh4m7h3sibfRSzYgZt4or1pCEEQ2ED0YX1XhL/lZ3JYTTi5L
         lqcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015960; x=1781620760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        b=SYthkCXI5pb+7WDTY588O4sNxGxR8I67KIDcvMWLaWgCZbslMSvm1lgiMZ1O6361e+
         AiELSxjjWDlTNpyNMixWoFrrB7L489nZwZkC+SwjCeBZFeSXzwVcLRqNBidtV8gQWv3c
         WXziPrY8XFtbKIXhP0qEG4j3HQsNZLPY1GPsHegzrbw9pWRj0ESmHwmYNPL4pEgV8WBR
         4B8p4oZW4xavPuENDmzP1kG8O3pvclWhygufFyigynE8pWSKnhQa0qqhMwBn2yRpBYP7
         ZDedfabKPvkptSJ1YY8u8S7T2dbk+YFwFQNZQewXt+FRodRVE5AuuVm5JTiLN9Ffsgeq
         uEOA==
X-Forwarded-Encrypted: i=1; AFNElJ91Z5JtNjqat1rDghfNmqA4q5yNJ5iji6oqIfoc8GLbKP0dYw81GBRCuYchBgCGh5ty5VpUdVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLVFbyptxvjX3m0Y9eLoJYyKUcSCbF+ac/Otqz3Z72zyXn3gs
	joOZYumhU08uP4zGWk1jCHts7F3EEw99GTEyBI1hITY6ErpzwfVOmVQ4cikMEncYtxzTglVrotW
	EHxbk4uKEBqfwrre7fE5z41wYEOEU6ZkFi+GMDpDZVh0EQxCJrGV21vSNwHEpXKKtQdHXt7wkW+
	Jf/qLEcTFOn7yNopHPdNaPBEv0eeJAflLpUJdu/H0=
X-Gm-Gg: Acq92OF8dL68D5z6vhyH7+wm2ABw5VfinC1oJeZlL1DnW5ohDQi29yV0NaZmTVsdz83
	ApqgLuum4ZZ1w4vy44YfUGJNG/2NbsXtlEP9Sk1NtxH0W/oOqwsXzp2TsR+h+1+o/ON4AfD28Y2
	XK7fj85z2q87jPkEb31Q560viadjjXuKszx4C0rSWGF2+GifRwmYbhK8gyjVPsDC8ByxSipVJMp
	1tWEGEvfeTge6/Dyug9JbGhUFgEjPBQy5t/6owtR61k7hq1CT0=
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id 46e09a7af769-7e70ca3ef99mr13168174a34.19.1781015959834;
        Tue, 09 Jun 2026 07:39:19 -0700 (PDT)
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168142a34.19.1781015959353; Tue, 09 Jun 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
In-Reply-To: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:39:08 -0700
X-Gm-Features: AVVi8CcZCg6NF1_DYHadZzneoVcOoxTF9hqIosFI2rLUJBAF8tno0qEb8k4EdV4
Message-ID: <CAH3zFs2FtVN9LZw487ei6cs3AMwh-30jRHenn3X87PAkZ8CmRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: bh-3T_vlephDYJL11cIDvEdNAeOqgTHD
X-Proofpoint-ORIG-GUID: bh-3T_vlephDYJL11cIDvEdNAeOqgTHD
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=6a282598 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=zMbl56DWmGmIhi6d5aIA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX3mo3euYhjyBF
 lAkyPm9pf4rS06sTdlHPLyCJPhdCaD7ig5QlDOClTo+3f/EcK6nIjX63v/CcRKA7FyWVryixxwH
 qAX9kwvKBx19eryCsDKQwYf/wueATtTQbFu29PAAACn5AWqxMnDIJDjuTegFtPu/VRNPmCMSnL+
 MhgXxulEBljva4kLKUznrA6sO5RibLoaFfTmSzmSoEPoj2N2m6MJMJGVZGUcjxfO6YDrCDZTPjR
 wziZnBV1J7udwEi6qKKo05+v/CZcahMIKoXbbdNo+SF++rnttD9keKlV1uO9+bwM4iz7t7NYieD
 ghVKQQurPSA/UXA74i5DTCd7O3r7n43Sy9N69PQ1VfB42tkRFFQ8qSUFZXPcNQ7FU7L3A7PTFPz
 Bi4eCFPNYQPbQfbn87JhRQXBNCLDEg6fORdvW1Jatei6tQYx7qfPhAN+NPWQL053UUdJWSWI4tq
 FtW2BzRImvVIjtJXvQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297087-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:dkim,meta.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2D46614FA

> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 45 +++++++++++++++
> >  4 files changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 1a177ce7de54..dd11a7db6b41 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -2,7 +2,9 @@
> >  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
> >   */
> >  #include <linux/dma-buf-mapping.h>
> > +#include <linux/mutex.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
>
> > +     /* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> > +     struct mutex tph_lock;
>
> Clear NO-GO.
>
> When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.
>
> Christian.
>

Understood, will fix in next revision.

Thanks,
Zhiping

