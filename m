Return-Path: <netdev+bounces-298399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tg80FzdAK2qV5AMAu9opvQ
	(envelope-from <netdev+bounces-298399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8789675C4B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=USTVjs2G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298399-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5723209CDD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C36388E57;
	Thu, 11 Jun 2026 23:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B8175A7C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:09:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219379; cv=fail; b=bl/71sZlE4HCpVJRamoN3d9edUJi1BQa2pGVb9+OXrBRx//8fyoZ/khRKibEZT+JjKsFtURbRGxIaBEPeksUaShTwTaVzEyHo+LYtaYYF3xx/ZgfdEr7hp3wIyUyNW32ViTNowtdIjz2k+4p1YoSWg8xSJd/D6WaJNVLVH1jTCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219379; c=relaxed/simple;
	bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDIa1zl8pVts2jKbOz/847V3RODuOaCn4SmOzCfPRDPABNH646way2rx+a5HFy/XdOBTV4Z57zVVYJJoTWuWwR5OH3W9nXes80fghXB6JHsnS0sB4QXu/O5QfU5nFwJbBQGBNvaXaMQSMIlIV079fhGcUFCX0+uveBc848P6cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=USTVjs2G; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BK5FTL3758767
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=; b=USTVjs2GSY6c
	zWNomSf5E8qjahkAqgjmiQDPFbjEPZsjQeJ/b94zb0GF9NeM8mlmXX9Gk+kwYdrj
	cTftYVPuOSFB/1Nr+8gqaK6p3IfQ3KYjnHVtCfJwHBjSmm33QENUybqoFyJiQ/fu
	n4EJcipp1CqI7B0zNUDMYv+OiLaw5YrOS8y/AuI2CPHIovD+hq3X3/vXm3tTqiTy
	HHxPhprLBQNWDBST0hkTSIsZqY1y3fvMFa5eDd8O3gaW+GcwgHrjI92X6wE8vhNV
	AHzq3kcWmOiBGIroHAC2qW3JwOJCgC75sMNCqZsKh1VQyolLrORLN0mB76o4eHEv
	+bQz7LwmGQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe791e7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6f45ce9ceso578884a34.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219376; cv=none;
        d=google.com; s=arc-20240605;
        b=GhVJ4X0S/FI+exwjEH+t0IcJmjlxah7F47joNjJo3VybooPsGFuhlF1Kge0N1xogRS
         ggzpt+H7OpvOsmBSsRSj+PSAv+R/JY/JkwSupf43OpZLt+yxSQpi5Fv8Re954Oze27WV
         8UWg3lp6cvCpav9MIiX38n1o2HfH91cacsB2Gi3XX8QSF68SW3HSQkopM6UBkHE2MNRF
         P9XJ820mdnwrLEFurURUDyX8MROSG/5gcDzX8Ed8H07sxusF5SgXS2WzVllukKN0OxDE
         lFIb2lBtIWsKNZX469Xrgmp2aRz0NAcHRCtv39G9eiC74pHQiuhi4EqAZunI/zqUrpBE
         sEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        fh=MqxH49szsXHq8r1Q/L+lR31Fk9FTEgn/SBTDdfaNa9I=;
        b=ShH/StIFA5vdBTG7aDVV7S752/B1uRGBkclxAIAMp2Gx65aF2JKH4r5iSamWh4Xypq
         QwAOGbOGJmsh6ziTinG+Un5orhHLJ7OI8dmN7rVFaSlrUf+M2kL7FLFSs1PqrQqZS5Ad
         44b0Dvw9CeCdGnGhqYW5wp4QZAc+1EpRra8lX/dArxvEpJvD677GrDU+nG7KCDFvVOaq
         8Uq4ACgFafCtjGf+xx5UETL3JkcrDqfhRChLCMULv56PeLovEwd/fTO5cD2LrP5BhMF/
         gP3C4oVKx/LwRZ0Nj4HsyvFMi486xkvlgOOB5/uIRsCVDYw3H28HQtD6xKkk488kTRFR
         RKCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219376; x=1781824176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        b=Axis1JUwCcqOPswvvEb7qvsbL4Y8h4sY1tSKujfmEj2V0mIcOAadiLwZ9EJNzSySdO
         Rm7xbXKBuuBPz7X4ZYo1DklMKSKAzN3lZVJPa5EPwIHmmaoUTSK6UwFlxC2UEpy1iN++
         5fekoKG29CT7nj2CDbgfWcvuM/rroFt9zdYr89TYsr4ocLab3XeEh2U+ikxpLAULvHNe
         H0kXwd5zFFKMGJWYZip3XLAoXv7atRoWJq+IUnPzEYHu40jW84MdJMsIkkA/8RVeXfba
         diOggWaSfDDcfQwJvzCZBZmfcDTVPBZjZI8kEd1BlpfjsWFoUp+5TsaqkH0EOzmwTeWT
         2bbw==
X-Forwarded-Encrypted: i=1; AFNElJ//cIUSPtSl32XDcrNSK72uujgdb7jOdGcwoU1L9OOSJWLudFCICKxL9Qk68dYGtZtdVzxldEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3q4p5bXvOZEmEtKNdN9kOwC9gHu9YSsJrKZAdhEYomINAWULE
	CYeASWFI7I2ldJg6l07UU8sYZYpBlsxvtNa1viLT9BHO3flNA7zGdAyGe/0IGeNiFrm//XfCdSj
	0reL1oPXvfCmjFRxEgpW8QyPw/wm7e3HkdR85Mm+zOyc457E4c2q9Af0NUoZ054416Sgq1d2Dml
	Q2MvQbr/+KlTIRfqyMIThX5AE2qe+o/pE=
X-Gm-Gg: Acq92OESasuPtsKxV/lUnWK1vsJAz5fCyj0RkVyOqr+wNA6tAeF1DttjRX/0GlvNsg5
	9IDL2oTxqLPILa6NZYCvb9LkzQ70SfVhpZH+lH0MtVtlOdOfvvlHnjd3Q+9gfdRkdLkGmdBHxp6
	MSUGVgOv0EoH5hOm7oOLjtnAcC3R2cF9WBmlVL6uq9tJpSDM5dAB//DknafbwMzbYc5pevM6LFZ
	9HntXWjRliH6FoE2chPkQ==
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e78473ec89mr120371a34.16.1781219376577;
        Thu, 11 Jun 2026 16:09:36 -0700 (PDT)
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120344a34.16.1781219376083; Thu, 11 Jun 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-6-zhipingz@meta.com>
 <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
In-Reply-To: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:09:25 -0700
X-Gm-Features: AVVi8CeB8nmACAn2v-1nCwadZsgAxPl-ide5TeaDE88hJZn8TEKcdfaG5LmdPSE
Message-ID: <CAH3zFs3ngOXvA5DRzur-_gQ2e0N+-3Az2KmwxZTYczqw34n_Xw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX/nAh15T13mg6
 +nrk9WWmO4Wi6VNPFwNeZ3OZmmb2OritBbdnt2gGNDVqgV4hO3Tz5NJGelP1NzVFIHbKLp1HCE7
 ohUaOSr5Wc3Lc6B7fk31Tnngx7VEuTcDe8EXyPUvTRTsYJPY8xA2WdlhNtSs2IffHatZ3EGp94W
 DxH/ZupmrCZXCZp+OMlWI0QArrZmTgvNgm0kSkvKcOa21/FVXZROKGNvSVtmh7dsbcnhoSwxN9t
 QrC2KWLeyCQCvoqIV079CF8R1I/aB/m/WLmDHaFX5EVa7qRbM03i6yB7qGyMO60BWSgEMW1181d
 l+CXTC8lyPDxz6F8u9nkBQ9O51HTbZezSKcBs7OKSI77rT0p0hIVrOUOcEjQMVl2eEqAyIHXy82
 PqHtB5X21wqFUqSu64bOasgcZw/DRF/pPiwIJJhu+5q50vGNJ1Wesg2TMDCpVcWXns6gE3PWTjw
 vG3o3LKlRbGuO9UKxmA==
X-Proofpoint-GUID: dev3st3evQRc8CF1tbhtu-1hExxECibh
X-Authority-Analysis: v=2.4 cv=ZsLd7d7G c=1 sm=1 tr=0 ts=6a2b4031 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=Ikd4Dj_1AAAA:8 a=G2Tmg7Ww-o-apaxFWtcA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX2kJf9IsO9msW
 s3UxfQV+frV6fAOQg64RYHDVVBWtMbLzvFlIakIY7/U/82JDqyjIh5+ofXDoYkcHXdaFKaSCmAt
 nqhxUUUzvVlOBhDcNtkZPfPOyrzxt7U=
X-Proofpoint-ORIG-GUID: dev3st3evQRc8CF1tbhtu-1hExxECibh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-298399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michaelgur@nvidia.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:dkim,meta.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8789675C4B

On Thu, Jun 11, 2026 at 5:44=E2=80=AFAM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access to a PCIe endpoint and use it to program requester-side TPH
> > on the outbound mkey. If the exporter has no metadata, fall back to the
> > existing no-TPH path.
> >
> > For TPH-backed FRMRs, make the extra ST-table reference belong to the
> > hardware mkey handle rather than the transient MR object. Extend the
> > FRMR pool API so reuse and final destroy can transfer and drop that ref
> > at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> > a ref on an already-known ST index.
> I'd keep the ST reference tied to MRs, where the ST is actually in use.
> There's no functional need to couple ST refcounting to mkey lifetime.
> Once an MR is destroyed and its mkey revoked, the mkey can no longer
> generate traffic, it's just an idle entry in the FRMR pool waiting to be
> aged out or reused.
> This lets us drop all FRMR pool changes from this patch and keep a
> simple flow of 'acquire on MR create, release on MR destroy'.
> > Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> > the requester hint matches the pool key.
> I've fixed that in a series I've sent earlier this week, please rebase
> next version on top of it.
>
> Thanks,
> Michael

ack, thanks!

