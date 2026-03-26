Return-Path: <netdev+bounces-272278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOIsFeu6xWkeBAUAu9opvQ
	(envelope-from <netdev+bounces-272278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:02:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0333CDD1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A632B300846C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D134216C;
	Thu, 26 Mar 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S+c8kVnG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9E336880
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565759; cv=fail; b=q83Mj2tAwERZIZnzrEMK3U8fUaixmcs1QKsfPtRQxDhd01PECiWOB+/D0A+ScPVpYRpZ6XJ+dr2tov82DZ7Wg44YkmoG9Z9EWWH+/fhvsQh02vEZHPn55vhs1brBAHRpds1kZ1Kut0SuhQ7c66kY4Nrn2ThQJjcoZXdroAOBNqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565759; c=relaxed/simple;
	bh=BdyUGS9qVrZC2M4zs7j3VJuPzuCzCdpvDKaUG3wf5J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5TKORBIHI/IdxBEWLh0Z0btgauVIt4vIQoRIoEzsj5CgWuu7uIpzqwRaskFgkKDQ9jwR0gtjnTk5vAGl5LyFBmXAPlYPUwtweZyNtbllcR2Lx/AzmX9ExxUhD74Rq6uqla8pu3IEPdGr83CBfq5wDFywHeXgFMkW+JukFHs3oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S+c8kVnG; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QIB8F03259024
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gWmaYzOqDIhtbUb8Zs5Nf1ednm4S50xRfwW0Jz6U+w0=; b=S+c8kVnGsspV
	a654lLZZ0b8EsEWQ7eZrMsM3U42hl5QQn43gPcbCwg1iIRVkzVp2dRFBMOENsKwv
	SFukOMCLHJB+BVExRhe9tAQ85TnRLm8BMieG/xu8T5GxAF4nxZYBRBXXNSu81mfz
	72IHHjWgJ7wrMUq4HLUK01uWKkwfjjbYiSew0OJdVYtTd9jpySKJMO9QYnD5wD1F
	hO4pop4o2ClGk5kOI5qvHHOrYSB5X7rKufRQLoSTlAVCrJgs3+MLzJEtviKWKK4E
	rl7jpexzUWHR2QNxm3b2slr+Jfm5udNi6cLbkjrHBtc/MhaQw/bPV2OzMvUx4TNz
	3tP95BR8hg==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d4yjpjasa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-40f09403c56so7159863fac.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774565756; cv=none;
        d=google.com; s=arc-20240605;
        b=VJDVhowsqRy5UsaiA64pu5ihEaypfwkxCHYBpF9YBBNZLTQ/NVRjeIjyw+KvfYFG8J
         XFv2tYM5jss6lv2l4Mu+Ir62uKr7tBTFa+T4MLSsj+jlHeFup80Ejra+nRi9E3Q0oVwA
         pGv/9CWACEPMSbvO2U5QCXu67t9XnnVICTQ50kzq50pdyEh0a0x0hqoIZncuHB+kLzMy
         XD9CTzyRpVmSOZ0mVjlg+WwfrBrgRNlTM14jx4QpvqbZ1qWa9a1vpeW3kZjeF3TB4nMR
         DcBa9b8MloG/OkKtsG7ep4kpOwRAW9udp1NSg8xpIBWedDiiqwWQgmkmWsiAHH/13Ceq
         CGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        fh=eqKjjJbMBMtC5jL9NPI2/uEkO1a6Rqeo4EpRYIET3lA=;
        b=W7bMWoJ3mLNAw0GHB0O5cI0AUoYt3ku3sOhIC14Df6MiFG4xIB9Oc81mmahYvMLIux
         9pwUimCClOoisXlWBpE9B6EWsF9AdWTQClwA9ZkjXI/L3e/PNtdvkFtetOi+hxiJV1LA
         uELrcOe4jpT9xIA6xe05MUzkNlRpiVxg4YsB/GRfKKAJBwj5djBbeIzeMlYZXTo1fn97
         VFz3hjEj5phTVDK7k6nWubsgOcwvtgrWvuo54loh03yOKKvSQe8mL94xbBImUojopsNs
         vDcgAKPlXO4YWuTQ9oBhwLTf/Q3dKsu1T/v95VqhcVjmO6/k6RgXbmloMUsnrDcQxeng
         WX2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565756; x=1775170556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        b=U/jul5FtGCBjDW0Y6WLdzyv9KiAM77nTXNC+ruAMkMKBfz7dA5gEDgPxv7NwpuLRJ4
         DEMuOcogI62YNMwmLu71VmtuoMEOG8kpTUUhWKsVPHHW9TJ3jShQGthf66+JPCRoFa2T
         lKsfuzjz2OhU65DWrTXu576rFiRdCzqnJIzazB2mXTG8WRxn1Ghx+6OkY026ArEcqm8v
         7eumTSrG9dMhpxIJCf6Z/AohcBI224RB2llvPDyDZ8P3mN5BihNbFR21JO0tFWbz5LIN
         0GYbEf1CAhTJcCesEljW6DOOMtntPhKSncl/T10ZYW8SwOvDyoV1TzIgm5yUYPq8PGO7
         Vf7A==
X-Forwarded-Encrypted: i=1; AJvYcCX/JchhY5mgLJ5lCkn8hvwa0VEdPaOLKb0EKvNDfeRY5ccmU/mJzegPy2KVdei/c9Wbdk+d5Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDF0aAka0SIZi7tEJeajWbxYB8r6cCbFcX0nHi7qUQ0eXATKS
	WQu//9wjCkyj7S8xhf5BiXgy0YDdWXpMgW/B87m6TeNiRb+gEIobNZIt/hNot+EE95io/d5GepK
	PTFEHwin3QzN77UmRu4+joPPOGG2aKVUQv5o7ZsrfDt1QQtwRELs21QWxjxZMXpufO4HaDQBdJa
	ObC5VwYT/sp555QwLVnD23VrOib6sFcik=
X-Gm-Gg: ATEYQzywUTEcsKjrqO/89QYKVDfqIY4wARS2xthkS9bO2g+jRWfwyuX5keNBfKplSTt
	T9Z5Aua7vSEbOLRFJKsZUIOVoCcAS8EXjq7vucqqancNpOjr++cxEWJL7ENRZw0Vgfs68W7gU83
	gghWNSZr8jYZb0Xurj6AqR+y97/ODywLMzXkIrm+0/jtUcWRlKE9FvoSEbWo2RAIAHfuFSFUuCd
	zwBGAzGAeUN2L29JwIfPQ==
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id 5614622812f47-46a7aa42abemr1548511b6e.32.1774565756385;
        Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id
 5614622812f47-46a7aa42abemr1548497b6e.32.1774565755966; Thu, 26 Mar 2026
 15:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com> <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 26 Mar 2026 15:55:44 -0700
X-Gm-Features: AQROBzDisNUSNgd3TlIskyBeYU1qigTy8IXoqXl2UWp2Iq9LIcNA3h_mkSfPwow
Message-ID: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NCBTYWx0ZWRfX66srKGqxH20f
 W223qfWNCjD51q1p8gmajOyXwJtP7sLsX4G+D/1h64dL5fDcitvIbEgfWdvlxHAjnkL6q3ri9TM
 9EExQz0vYp1/nzwJG9uM2XGUooS9uvCBn7xYsWyCVm00fS6zYlnnbNGmIDjuXP+/beT5wODoFia
 HKntbOwBs0c0HtAXMRAMdNkH8LaTmenx4dvDKmbOWawpVkK8jokak3kLIb7nTpRYPbyON2hw/99
 jtDRQc/o/Br77JJJEfipJ5gB1ncjfzOeE0zhkqYeQT/NtJ6zPholMmULjHfcBbvFAA23f0myWTx
 jZCREltb11f974Xndm32nEhOo+75Qf47vunWOHd1F0xYotBypHV9jybV4nXRUhCbcsUQNjvsikv
 H8tQH4NQx4ocjvAh8DS6M++0PE/Wl99YkztOjmIPg4i5t/oaYsb/H2HEDn6a8xK5lBpH0GiK0ft
 h7TTyJAi1XwHBth1ilQ==
X-Proofpoint-ORIG-GUID: IaEFJrLnR2H6hY45zyfPfqvsSqgO5QUn
X-Proofpoint-GUID: IaEFJrLnR2H6hY45zyfPfqvsSqgO5QUn
X-Authority-Analysis: v=2.4 cv=a4E9NESF c=1 sm=1 tr=0 ts=69c5b97d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=NFdbOB6VLuGm633tFYQA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272278-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47B0333CDD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 3:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> >
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >     __u32   region_index;
> > >     __u32   open_flags;
> > > -   __u32   flags;
> > > -   __u32   nr_ranges;
> > > +   __u32   flags;
> > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present =
*/
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit)=
 */
> > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering=
 tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> >
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> >
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  =3D 1 << 0
> > }

yes we can do that.

> >
> > > +   __u32   nr_ranges;
> >
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
>
That is what I did in V1, Leon.

> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.
>
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>
if not using the fields in the flag, then we probably have to
introduce a new vfio
device feature.

> > >     struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };

