Return-Path: <netdev+bounces-298407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jdLCGyhJK2r35gMAu9opvQ
	(envelope-from <netdev+bounces-298407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:47:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4277675D9C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:47:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="C/D5WLO0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298407-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298407-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE883306455
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1483E316F;
	Thu, 11 Jun 2026 23:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712283DDDB0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:45:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221562; cv=fail; b=k1maKOp5ALpF77O93VqVuj4yrnekXJX3/jUndYAnEvOb6EosxoUMZy6z91lFcB0MMBgkzYTRmY9SsUHo3Kx9cwTPRwVf33QFz14TbYNMHAw7CreEOCULdKAARE1YJ7RYGT3onUHfGRPHoITc4ulCQG4UYJFSb3n4P6ZtbLcgu4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221562; c=relaxed/simple;
	bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVkTZgoIESYK1EERC93b1KBUVaHOSGarTBMxPLlpxNR2LgLiVbTIrBXO8ceNvENHGyiKBosZtaQihbUlm5O3g/JExsRTNjHtwAWVGESOkyu3LyK6QqDcVeP7X5Io2TzESL+O5+MWZZPr76Y6wgN5XUIW2Sm+LAX9wDkFfC5tj+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C/D5WLO0; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BEVm5B1112499
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=; b=C/D5WLO0mmbA
	Ud0JqF5B+NiRYogOXFY27nmYpBJEirm9IRllvwozXjgx8OIFD5ZV8faeqTA3bkPS
	QQWZkebPb05AEUyMH8P16H5UX/fEBtNpeSpSliXT4oXjzyno6ILLCxFInu9/96z5
	1EJj/KLr2YVNpfd/nUoJ5mhagh5nM7sa5TvPfzFUJ71l8C1p7W0tPydae6CxTcqV
	tYwT6puC45+P6mMcS1ezBsA7Os1dhZQGhyxQyH3i47tvMD+VBY2zLGJ1L2IC/Muy
	9fS62yBoiRy7/k9VAoZ+zz+a3YlY8q3mXa4pSOy8Nssbs4fwqZWQUMQUW7GP/2Hm
	q3IRLexocQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a9w3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e713779405so919395a34.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781221553; cv=none;
        d=google.com; s=arc-20240605;
        b=NQ331UtKiJo/xvkhSy5bJPRf4XBE2vYOh1BeXs2utffiaaWmmbL6kAbqyfC3pWdFbn
         iTb6rwqYtbTfNSKWMJg7ohRW+s3WOs6IVaqI/WkkuASPPazgVVP5mmG+fhOBZQd6KpXw
         e/1ptccMvaq8Z3Nwl1Fo0pgkvc8VTwFl4TkQpV3NhbuU97cYef5QHxQ0WtKpZ509UFpY
         rkBpta4o3XVaRPfMtplsom78fL3AVluyMnONt4SPYZt4wQEaN9qvp0yGAXi4wdvLyGX2
         9CYPy/9Ddy1x1GnTS1Jd8L1AkdLeAW727l++KIMZl861X0xuTm+t4UnepO7OhQ2DcPAo
         AUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        fh=VFtLhVcj611LMti5jI4ETpB+wKu8K2BgtlGH4w19N5Q=;
        b=UgyY17LDL2N5bgJPUlSi9BdbmNC4A+hY6oB8+e5KP4ACfq5xHbF8vfw3mA138OsckY
         dbTYDMwTRvDgUP5EcU012iOdblQr3MSRI/nO02lyT6NExv614sjkrOz17r6Gi5biSVU6
         H45xxYBpjnY6uEK29nXnbjQrddCFyb7lQFMi5y9gATYCz2/1a3U2zUjP0I7fMyPBjb19
         3hZ4mW/ZHg07gy60xmZrMD81GT6jqesAqmJn2Fdqjl5UImJX5REpsaoOByxVNlqmsauu
         Y1eXUARISc4VQx8fbUVpS7dZ1IwnJ1wzORozNyYHKTaM8amuRchW+hnIMHfhLXfi3SVi
         JMUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221553; x=1781826353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        b=apbWyCT2VA3CvtHW7dRkZR/+YHKe/2dJYIdVozEXi7n7BfZVGDtY6toTDW1emHukv8
         Lj6kXn6HDGPzyklZrlC+0kfM8QCd+HcsU3E+u/DleC5c/saRwQ2eFT7dHurQXcSnyO38
         Q4N5Wl+IQB89/sgcq/q+w3dM/YAtWwdBvmbUE/5UGDXqfVlDI8yhprwmRHzF6CpUkbHR
         rnG5jO0wQEv4Mp3NEBWjSSFnJsjF6c5JiXVjW+6LxcLz4hpC/B7f8FhrNiQryWMFb9DR
         +j6bZ+2m7We1FiqB8Io5P6v9WPli6AGH2FC26f3zZ055B2zxOujPLhfQoOC1czDzlfWB
         pDPw==
X-Forwarded-Encrypted: i=1; AFNElJ+7ORmIHbWgTlxB5n4A6gSuoMI3SmkJoJSU4wCJT2TrN5YoVmt35ripA7WShOeUam0iW7c/unU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MwDtQxBb1sDnMmcpEUJYkLFJpngXVwKTtKXLfDxJyeQvDR85
	RsOFbhvD+w5cY3wVL2XUtZ+hQQsl4DSPE1jj4WvcNsifuSmsKexndIv4asYFklCVeXUDYyliks/
	Cka7B/J2x4drtYS604g8DlP7kXqnxO3c1aeBDn9M0jH33YhzbLTtxk5Hf7ExTi7UAx8IzfsQPV1
	oqidU64WfFh32DVooNlKXePPEnLydhyTw=
X-Gm-Gg: Acq92OHGe9XlxWEGsmdsDGnog9SGp56QwV8uOd1BYF3nV7bAQtqo/wL4nZFW6uj9khR
	HSdkbQoJM+Qgr1y1rddD8ihGgqmSJ8YIEt/JIQsyO4EzVnFThzmuc+YJpHn7OZXMyw5h51BW5fD
	YRjco+T2QOWHJndhM+2/rxZ4uR13r56PpkcmQASm1DtRmE3uKtD/JbjPV8a42qTzFO3m5C6F3Yj
	JjihuLz0ghPIpWlgdFZ6A==
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id 46e09a7af769-7e784871fe1mr152179a34.20.1781221553606;
        Thu, 11 Jun 2026 16:45:53 -0700 (PDT)
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152160a34.20.1781221553208; Thu, 11 Jun 2026
 16:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com> <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
In-Reply-To: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:45:41 -0700
X-Gm-Features: AVVi8Cfn8yu04sl-GzuR397tWS6RCJ76opDbk_4XDQqGmuG536f9nq5T-lNoRa0
Message-ID: <CAH3zFs21OjkJtYKSqV5rjnEqOU=221LQLY2qXo9pMb79kRSQgQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
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
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX6MySb4Z3d6j4
 ustG10XeCCeodP9cIabyhzFCmO4jfwI+V38w+lh11JlCsnvmNrf5HKpW52sLlDPjBlX/ZkBrXDG
 XsPBqCFVGV5IQtqUgwvVVP/CPX/2wZiwSM2aj1XRiNONL8e0N1suXQYHBU1whhtoRIChAcGOQ0v
 Zfmh79GPyrwBJzXpR6nkwWcX+6FNDC8jgyt94QgFXFlCN0N311iMAHzSsUTua/2hXLFSJMFAci6
 mMSJifGy1dclZgMw5E4pcFl5I5j9pG7DdL+SD2HdPfDPsJEdOx8htzwUD0crj8QKmYa0pdNc8Z0
 C1rizmUTKNAz2DJWVDrrQBOpnxwLmROhsgLQet3KIephGAzVvsWxssbKKObF3GKApEDUAUEw4Ik
 K5ZCF3dJe6pzRaK5Uv4Aji33Y/Muqo+c6rikOLMSB318U2lHom6RmGLDtphk2TAmCA/18qONLww
 5U3Dv3+LhOP19pNd0RA==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2b48b2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=iziE14hG8lcdKKJlCxoA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: tScf1hYYm2Gbyn3zHdtSulWjhmy4wkHw
X-Proofpoint-ORIG-GUID: tScf1hYYm2Gbyn3zHdtSulWjhmy4wkHw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX8D3nXOA0uuSR
 PukRj6uetIw9Ql+La0HwA9RcZJ7pueLYiokN+TRGSRqJAOVsNywlUrs9h4OjC32Lp4R8MJJtwos
 Mhh5lF4lZQfRXE99hvf/os8DFj8lQME=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email,meta.com:dkim,meta.com:email,meta.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4277675D9C

On Thu, Jun 11, 2026 at 3:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > > >
> > On 6/10/26 21:31, Zhiping Zhang wrote:
> > > When the last reference to an ST table entry is dropped,
> > > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > > therefore accumulate one struct mlx5_st_idx_data per cycle.
> > >
> > > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > > struct matches the lifetime of the ST entry it tracks.
> > >
> > > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > Since this is an obvious bug fix I think it shouldn't be part of this p=
atch set and go upstream completely independent.
> >
> > Regards,
> > Christian.
> >
>
> Sure, Michael replied that he has made a patch to fix it, i will rebase o=
n top.

Never mind, it seems Michael's patch did not contain the fix, let me
submit a separate set.

Thanks,
Zhiping

