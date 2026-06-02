Return-Path: <netdev+bounces-294056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHmhAyiEHmrQkQkAu9opvQ
	(envelope-from <netdev+bounces-294056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:20:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460D629859
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD87830BA1AF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB973377560;
	Tue,  2 Jun 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OQZ6oiRN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFC3A9D94
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384500; cv=fail; b=PWHSOHgW1wPfxLD3VCb2WoJi0oi8h8tTFuT+fwOILgJt/f5oEJ7MmpiphWmefFgTc+R45lGCHRLYQ5UCzpeprlnsF0hiUzHy273UPD5u+fdkvDApMeWhe4Ydemyn0p+GnOZVi+l3RaPumaIcSQHtpVr6gOtCgIdG4fHtGlFKeM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384500; c=relaxed/simple;
	bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKIQ/CKYuWi4/9aUIiL6CVu/qVUGIyYzTNagcQcaGwP7ZOjrVTBFyw74o31nUrm9s8XRJ57+pvMbMEdZwHVhXe3s994cbpR0NnxHODEwP7xTD8rlFaeRsHXJ7WvKtqXpJy43JZwLjMngWGPpJPFNz5VYMqN7ckzF41HbOjPS/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OQZ6oiRN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Ks5FE1573610
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 00:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=; b=OQZ6oiRNKfXF
	HFDFBWZ8BdlnmCUnJoqopQ8ht44IyIcRngTo5vzbD9eE3PHci7hw9MS25fO/+eto
	Ufhbzh5w0syuQ2ggQfOY2tYEThW6kK0fREz6MbHOgTTfppfQkpqdfn+SQPXexuAD
	Ie6ANRJ+b1YRc1xewkyhZx2bIIsI7MRe/jwOSfdaywuF9473KLIHfYoKIPRCh2Y8
	WWdocGE13zKd1J50r3VdsLTAZO5pqjzJkcYBoHjogiZO27cQxUvXRQ3zUmWXlq15
	g0ZF1xKWkn2Pxg3MqRPI0HmbFBBYIOMYNp9JoPpIzHq9+nA8JFAN2q0RoJ8mT7O6
	eVDAMsqcKQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4efw06y7h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b5c2bcc8so3400963a34.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780384494; cv=none;
        d=google.com; s=arc-20240605;
        b=ApEHq3zAMTo745dtRg5agVxM7HZpdZKgqZVh/uelpT+Cl42gyqCHm2pEnWVGjEwVPL
         eF7+WQppG31CcBF0UkZ84d8jyOq3l3PwD4rXL21kU/rN02BX6M9xcBxM5/oItcn1V07B
         B26qfZSpSwrXxGQV2MYPJMGa5aDTVwZlp2L+SePw+pIUDGq893uCssHkje4AlJXYvIDs
         q8AZ73nbDnNcg24Yg1fXmJdDloQ2yVF8uR6HFZTw9BaaqTBJDEjvUv/EMDtwnvaNVPFl
         TxwIsmZtnuU9pxjCfwk1E5ii+XSr55lP5I3JcTl5RNcjwsEY7tHmHrKolSgeji/Fcsms
         ovpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        fh=oSoULY37JZISe/TY+8OtBbX1u6/5QXF6FKexNQOlNEQ=;
        b=CTZq5f8Euypy83n+VOVOlORp7UOMVuij9Yo3gwVhwC/FXLs4YffOWDiHKjU5qiSWH2
         GzH5Ql9kALiL6VE4I9pKhkI1TJ5zng/yJz5Mj+021tOmfbm5ftsIX0YuDG9ZVk2jIsnb
         VFkK8DcHPU1FFIanNN+QdVZXhEzSmdHycKrIfi0soPrcWd0sTdysGhWxEBwnVXi/XBld
         0IvleBGFsl373X7AmCm1k9yAPZXiPv5ksbH4tnoX59UWeAw2+ODWNRIatiGBGlF4SsRq
         iKiLjizDfQiCdp53x8RrhSuHJLPJWzSvAKdCWNqTe8bF7H8iRYMvYoI9dY5MaroGD1KH
         2mxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384494; x=1780989294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        b=EvGLXyvJaqM4vVgdtjFrYM59T8kt6yDiybjr4/NviAs2BYzAz5s5jmZvYPhSX6qb2O
         S6snU3puNDq9l5cK1yU1ehM7UIhUEgGR1WAk/moJrJKLdB572nDZRPFAywn2T9P07Dtx
         xpLqMRvd5dEP/4WlNxGpWVvYqBb3l4dNy5TarSfw0KiFOeYFuyKRdVq7K4uJl/86/Fz1
         ygPfK5UGEMtNM67HDoAqnuAv5Z+olG7XhVILS+otVc5oCJ4npCZSZZzEqvQeKfGRzzPH
         ALp+ukgDfDzAHQBTkGvFjFmnOQzVcTf5M9c+Za5FHDVJl1bl4a+Di70W2QRQzMyFPdRF
         7/Mw==
X-Forwarded-Encrypted: i=1; AFNElJ/bBjWjn143UziToZkcXuki/slHXK607F52Vef048G2QwxJUEc1ELk4BEJ3fIl5xa1ol/AvWaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLeF8FdqJ5Oj7uQXEC4RbS5A0xq0mwqiMfUIt6Insh4PDHzuV
	PkISMd3FZ6bJf35fBXoBDWymmk5vpvm+b7lV0lQHVNlPes5O+MzwJrvQBnXGw25+pkj5F600KCH
	kEG7UzrhkZWWf2gzaITyLLpB1Vyk0++1l8s6S8ts4mqyUBjZ5pwa/qPd8fkpi8GzQlYqrZfion3
	HjHMN3LOJ/kg+MwMQe9MojwWXIXTK4e64=
X-Gm-Gg: Acq92OFfXsTHBHMix/2n6DFuesZcCALUEWIbLRQGexnqsS7Ew/yHZP/OCEHZU8RfIUK
	Dqs9xQv/amcPxmYTervHtAARRa8X3ZWku1f3W1WxM5IXOT0fqfLqJ3WZNw8SMD4l5u+r6quJBHt
	Bj+zHxottAfGfPSPyXao2qhiMfUOir+ykAGoY9zhYIK7PZEMhZgYxXDVOCgPRSPReJlldue7lLg
	l9yJsOeKIWFoJzD2zSGz5gNTQaTppsd237MsTAmJQc0raHRmbE=
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e6d22714f0mr1524752a34.8.1780384494173;
        Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e6d22714f0mr1524729a34.8.1780384493717; Tue, 02 Jun 2026
 00:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com> <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com> <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com> <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com> <20260601184838.GE2487554@ziepe.ca>
In-Reply-To: <20260601184838.GE2487554@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 2 Jun 2026 00:14:42 -0700
X-Gm-Features: AVHnY4Is8GEC0NoEl3YOomYHVUTID0QdEceI4eqR8x2YX12M9DU2UU8lLqhKsf4
Message-ID: <CAH3zFs0Lz=oe4coFS=Ws14rKsY_Wi0=ueT1DGx+YpaSvt=DkAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfXyWZRLnJmLjfa
 Uz3HuXixgnqeXo/rHqmAuZbVULGFCPzU9iHewlCqi017VH/rKe9U+NUlWEYPPiICQX1fGUE6TNM
 KsqY3OUFMAc+PD1U74ADG1LwXaBK8+VPBKBbG77NEPiNsfVG0X/bNu7oc+mYSN592a/35Df7BNd
 vOG+Ua5xsN08Nrv6Ebuq6EaMY+JJ5xpqlqAyFd8HWNF5pVRUdeJic6ZOPqzJi9nnDS1H/OQtVJH
 601RRnw0zPZvPw0KocsAAN0raPZ5eg05MLjSKUuM8M62my9BbzkT3gLZzK+lklHJd8f3Lba4WWO
 lZeGE13bQIEzMZW08fomJctlnBDs+SYqo2DgMvc94osUPcQMSLfgMMTlsMR0ab0yhyhGHcBW+sG
 ABFEBXK95g7Jjj2qAI/V6sXkwgA/e/MOle5emXtwxwJgiMFuUBwx3+V67ooW/P1vzD9EZV3aBF7
 xg6q+48B/BzUSydxgXw==
X-Authority-Analysis: v=2.4 cv=IKYyzAvG c=1 sm=1 tr=0 ts=6a1e82ef cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=9jRdOu3wAAAA:8 a=80MmiaoySdvbWJADnQkA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: 6msglKCCNBg0cqWyV4hZcNV91NjB_7HF
X-Proofpoint-ORIG-GUID: 6msglKCCNBg0cqWyV4hZcNV91NjB_7HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6460D629859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks everyone for the feedback.

For v6 I plan to improve the cover letter to explain what the
Steering Tag concretely does on the completer side and why it
applies to P2P - the ST is consumed by the endpoint's ingress
block, not the root complex, so it's orthogonal to cache snooping.

I'll also include test results showing ST's functional effect on
P2P writes. In our case the ST is used to select in-flight data
operation.

Is there anything else you'd want to see addressed before v6?

Thanks,
Zhiping


On Mon, Jun 1, 2026 at 11:48=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian K=C3=B6nig wrote:
> > On 6/1/26 19:47, Jason Gunthorpe wrote:
> > > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian K=C3=B6nig wrote:
> > >>>> When you have a complete open source driver stack which utilizes
> > >>>> VFIO passthrough as the interface to communicate with the kernel
> > >>>> drivers then we can eventually talk about that.
> > >>>
> > >>> That decision is not up to dmabuf
> > >>
> > >> Yes it is. This is the DMA-buf API which is added here.
> > >
> > > It is a DMA-buf kernel API that is added, I think it is overreaching
> > > to try to veto a VFIO uAPI that calls it..
> >
> > Well as long as that is a private interface between VFIO and mlx5 I
> > have no objection at all.
>
> Well, as you know, we are using dmabuf to mediate many of these
> connections now.
>
> I don't mind a "private" interface as a starting point, but it does
> need to discoverable and negotiated without weird module dependencies
> or symbol_gets.
>
> > But when it starts to affect DMA-buf I need to make sure that it
> > works for everybody. And without even being able to test it that
> > becomes really tricky.
>
> They should have an argument how it can be used for CPU backed memory,
> IMHO.
>
> > > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > > VFIO uAPI that can be re-used by any other device that happens to
> > > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > > based around the PCI spec.
> >
> > That it's implementing an official PCI spec is a good argument.
> >
> > But on the other hand looking at the spec it's not really specifying
> > much since everything is architecture specific.
>
> Yeah, spec doesn't say what TPH does when it is received. It is
> intended as an opaque channel between the source and target.
>
> Even on the CPU DRAM side we make an opaque call into ACPI and the
> BIOS returns back the right value to use for the CPU. The whole thing
> is agressively opaque as to what the values mean to any particular
> device.
>
> So I don't have an issue with VFIO supplying a value for MMIO it
> owns, it fits the general architecture.
>
> > > Anyone can repeat the demonstration Meta outlined in their cover
> > > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > > VFIO uAPI says they should be set.
> > >
> > > There is nothing uniquely tied to Meta's device here, or unusable by
> > > someone else's devices. Arguably this is actually a mlx5 feature to
> > > allow VFIO to control its TPH generation HW.
> >
> > Would it be possible to demonstrate the functionality with some FPGA
> > implementing an PCIe endpoint?
>
> Sure, you don't even need a special endpoint, any endpoint that
> doesn't explode when it receives a TPH is fine to illustrate that mlx5
> is emitting it correctly.
>
> A fpga reference board with an out of the box PCIe IP demo is likely
> entirely sufficient, and you can use a FPGA logic analyzer to inspect
> the packets.
>
> Though keep in mind mlx5 is formally supporting TPH in a growing
> number of kernel contexts, so we do test and verify our device is
> working properly as an initiator. So I wouldn't advocate anyone
> actually use their time on FPGA :)
>
> > Doesn't needs to be anything funky, just the ability to exercise
> > this for basically everybody who can spend a few $ on the HW.
>
> Topologically you also probably need a PCIe switch as the CPU P2P
> likely discards the header.
>
> Jason
>

