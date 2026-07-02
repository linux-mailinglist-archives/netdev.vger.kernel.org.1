Return-Path: <netdev+bounces-303915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NpQ/ImDRRWraFgsAu9opvQ
	(envelope-from <netdev+bounces-303915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A196F318B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:47:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JS1CZaP9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303915-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303915-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82FF301FD51
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585F2DA775;
	Thu,  2 Jul 2026 02:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D1181334;
	Thu,  2 Jul 2026 02:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960478; cv=none; b=fHBxxnXJ6NhSXDZUjyjM73dHOc+MEBIjBnrAqjkZcvrwMgwtIQPUP6pAE33JkxiXBEP1jXlcOMBqf9auJ2j/HYJ7POnAYLbydgVo/KHZBI5p4n4YwHDOLEk6plqMJSXAwL4Ah7W7Hjq3aqrcOyGNIKFbXxXY5YwibXxT1PokVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960478; c=relaxed/simple;
	bh=hMW9OFC1YmhnysZNwHbuMeHIlhAbFx1GB5PK95bLaD8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRVi0IVX16nr0j9TglyroW3PPzS2/sGdKLKwSBTNUihtVJlzfykx1naiGiRDDjF4KHOkoY27JRskFCSKMr0GXMkm/1d8Y4uI8BhbT+7vvIQpeg6MCAvyqVoAGlZHlq6sohtiCvP57fjo5c+asBIbXgJ9BOOLob2x1kJDTiLqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JS1CZaP9; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MSPL205440;
	Wed, 1 Jul 2026 19:47:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=H2zsb8iX/UR5QSiYRo4J8G0uX
	ed3SOvrXaCXrE6ESA8=; b=JS1CZaP9k1SE95+ESyMZtAkyKjEfguCWba8DuP3Sh
	mjRfOUmG3St3BuQpDkoDqHAoBQKT8DnNjQR820dzNNrrwKgh6Ie72/Z7yiJ0OBe9
	ZmjcyEhznbb+U450ecAM/yp79GhoA/n2w0VBaF5BpcMB2YGSIk+S2TUZA4vyrTRF
	goeuS5mBbO3a30wR8JpXow1E3twbS2e2NRjbD7gYnq6U9HjUfYbv641kP/gX8fD5
	UlhRAS/ShBLWMVFoMvMbBRXN3GDEe5Q9auhewde/FsVD1Ko6hyVlGo31k+nqHigl
	t94E+nSFMA7j4wRAX/T2GvPP8ZDtmBOgXYP9lkgMVatMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f512737tr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 19:47:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 19:47:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 19:47:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5ACA53F708A;
	Wed,  1 Jul 2026 19:47:25 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:17:24 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jiri@resnulli.us>
Subject: Re: [PATCH iproute2-next v2 2/2] devlink: support u64-array values
 in devlink param show/set
Message-ID: <akXRPNxtdVAzoxLF@rkannoth-OptiPlex-7090>
References: <20260630015012.3728870-1-rkannoth@marvell.com>
 <20260630015012.3728870-3-rkannoth@marvell.com>
 <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
 <akR7g8aWfws3h2jx@rkannoth-OptiPlex-7090>
 <87f24e1e-4167-432b-b73c-0fc0c4b7d532@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87f24e1e-4167-432b-b73c-0fc0c4b7d532@kernel.org>
X-Proofpoint-ORIG-GUID: IdATO2RZXA18PLFRYF42dauRsMs0PSbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX9CTDeNVVS4fX
 OflDzPIeZt3Zl3dxH2ConBkmq0HQTH8yG5Ls23D91r1CMwNvv9bl8itqjopS7Zbfe0seHaEGNOr
 vemrXsorJaaPeJFLBx/VbeYOb5MG+f/bUYak4Kx/VG+MX37Qj9C6HIsEFdcDmy+YsM4K5ta6j1c
 q8kotwfHlh5cA2fcR2zY6yHJmmxIh6xNJiEnsYLL2nOwFhpZCNO5zAIeLYb6S12Y1M6dK9qm4/+
 N0AadBJOpIhnsGeAwjCLa5PqcwGYMUZvJn1iDYR/RR7PRmR0RWfqDYXoRfJkHev8sMAhd6AZejx
 UJ4Inke/L7hWsS4IybVUmxaWgNAG++WZDB+dx8nOs4sKEf5yeSoQ6rhZcgJr0s24zGwUy3lKQT0
 flh/YL4AcqDFkU1fzjGGKHiWmNEdggrHIS/6sMHBDUhgMKG609g/00KCHmDLpa/wZZQftzGo/6y
 PQ2I8sCGaS9yu4iH2ow==
X-Authority-Analysis: v=2.4 cv=HZkkiCE8 c=1 sm=1 tr=0 ts=6a45d147 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=rzd6dds-UicYx-ywJxkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: IdATO2RZXA18PLFRYF42dauRsMs0PSbs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX9hNr+cuqlzBi
 OMioZ0OdVnnDpIGY6zsX764X0puOb4VdH5S0QNggTz98ZMvNjNztvcgjkUsbCGWT1oH8N+Ko2qu
 h6MbT2cLfT7e0QbcbrhGm0ff34qSFkY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2A196F318B

On 2026-07-01 at 20:04:56, David Ahern (dsahern@kernel.org) wrote:
> On 6/30/26 8:29 PM, Ratheesh Kannoth wrote:
> > On 2026-06-30 at 20:06:17, David Ahern (dsahern@kernel.org) wrote:
> >> On 6/29/26 7:50 PM, Ratheesh Kannoth wrote:
> >>> diff --git a/devlink/devlink.c b/devlink/devlink.c
> >>> index 9372e92f..3c29601d 100644
> >>> --- a/devlink/devlink.c
> >>> +++ b/devlink/devlink.c
> >>> @@ -3496,13 +3496,115 @@ static const struct param_val_conv param_val_conv[] = {
> >>>  };
> >>>
> >>>  #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
> >>> +#define DEVLINK_PARAM_MAX_ARRAY_SIZE 32
> >>
> >> Why 32? Is that based on current code?
> > Yes, this aligns with the current kernel-side limits. See:
> > https://lore.kernel.org/all/20260609040453.711932-5-rkannoth@marvell.com/
> >
> >> How does the kernel side handle
> >> the number of parameters? What happens if the kernel sends more than 32
> >> parameters - from a user's perspective, not this code and processing the
> >> output?
> > The kernel strictly validates and restricts the number of parameters. To be safe, this patch
> > adds an explicit bounds check to prevent userspace issues if that threshold is ever crossed.
> >
> > Ideally, since "union devlink_param_value" is omitted from the UAPI, we have to define
> > DEVLINK_PARAM_MAX_ARRAY_SIZE here. Moving the underlying structures to the UAPI in the
> > future would allow us to share a single definition and avoid this hardcoded value in userspace.
>
> iproute2 needs to be backward and forward compatible. As it stands, a
> new kernel can allow more than 32 entries and an older iproute2 will not
> display all of them. That is wrong.
>
> Let's make the limit part of the uapi. If you do not want to do that
> now, then iproute2 code needs to handle a larger size.
ACK.

