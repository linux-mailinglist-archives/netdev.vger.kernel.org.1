Return-Path: <netdev+bounces-295476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kKrEImAIImokRwEAu9opvQ
	(envelope-from <netdev+bounces-295476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DD643EF1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:21:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=SBh7qegl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295476-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAB80301DCE6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720753314B9;
	Thu,  4 Jun 2026 23:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5C3BBFBD
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:20:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615259; cv=pass; b=cqfqhLmvaoeYnPfffoPSSXZtUn42fa4V64pchATZ52vs70JU3yaJfTuF39No5E0qvpd2D21ogSr2L0YkpCHbljL5BFgTUIjKyoGUJwsw3Q/Ym2paEPCm/ifhj5lEtxRZXRAjhm9cL9rR+x6k40la2OIulG8zrFcQQu5G/2QJIdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615259; c=relaxed/simple;
	bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfSW5j2GRcUkHsJ1Jr4dPPWWCvQKFmqn4Ex81aXvDVRcdnK1hAUKTAoBKXSSKoF+c9VtJE433K24ff5YHJEu1lQXV4mkb9XCf0xYHf2iVM5WmzDs1TdfPx9n2PqwuJW4bpuTUH9HQFx3UbTSZBBilldGBJyGGN/JsouJcKpyM0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SBh7qegl; arc=pass smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654DuS321033467
	for <netdev@vger.kernel.org>; Thu, 4 Jun 2026 16:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=; b=SBh7qeglgGEf
	r3ONU/1vr/H0gJZDF+E8Zn3Jn0GdhYuVoZDSXDfbAGx8p7FXSmVrWDpg+XZA6lgI
	f+Vu8eerayshDWcHy4T5n3/9zv0i49DqV6HrltqvRziWlwltKKuQlAZR4KnUN7Jr
	FoFrtra60G0de593WbU4bT3tOlEj1w2qObiIb14Ww//p6HH4w0P6/N1NYLK92jox
	k1gO4GxHJ0kWUOhDXQMP7PSQXijBpiCmwKcUfFcdlmyRtGs6xO8r/K+ed5irjEk9
	5/GnorUn/zal7AoS2zbKhTG8MbmAA3cQs7FMmjK7csKBvlnEQkjtMi8aAyMSORTd
	ANWQvS6DTQ==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej6qcftem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:20:57 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-68b479cb98bso1492052a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780615256; cv=none;
        d=google.com; s=arc-20240605;
        b=Qml1n5k5qiX1cyk0V7smOflWlU1FwzNdwlg+FPxWRYR6z9e8pcmCYuUygStx8RJkcy
         eRGZov5D83NNp61togn3sWuzo0D2+e+jO8n1OKIntKxOnsIgCGhnZ/ef2Vy0mXfNYC3s
         ZAa042jfhcGECVNqVxG76j6Ti3KswejTZvv/NaFa+MGxUp4OvctraWk+mqmOh18up7C9
         vzjhfJyG8O49EdmTgTQ3CwIMzxiFIlMcBUAjR4YBmDDmktlM3Mo/4/1Qyo8DwT49X592
         Eyc9er2V+LUji7WI/gbAzonES98SBd12TKdNBPPQ1BEym+bngluBFFzW/JDtkntJVRFX
         YTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
        fh=lU7o8WrRwVym5G7aXXOAs423LIwWZwWLE735L1n3n0A=;
        b=b1gQibioL1rKIBIzjg/vGNBPFP1+yw+P5/di9YeAM0gR6s1VZKV6Cw8PAR3NRNRsqt
         ll7OB0X9AgrnfPMMUSXvnk72IXJPGIPGYJvClr0Oys8C+QGkBzXKgGn5VwooiIPkJYmA
         EXJ0zx5dZGFxWwujrpWC8xorTX+a8kH5rT6cHgsn3rOvopVzHFqTGfdkm24DtvEXsu7F
         X/1F09blHo6E9e17hErQujiC9hr7AxloCBensADer+Vb4vdTn1vLOa04URhR1zk4bIZP
         nwPA6JGr65dRjKbIwYEN0ZDahcKioDgj/jrd2A4NuStJ75VP9+Cg1wsQX75or8RSiKmu
         tATA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615256; x=1781220056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVAdGx0OYN/G/oOouYKf8DS9jfQogpyH1IY5YEFBhdk=;
        b=Z9TVKfGuLuFRh1c9OYZZm3a9IDo06mvWuX+St6eDDfap5oSZyqqxYktIEgebuiBaxK
         V0Y43xx9/Y7BiL8HovISUsFR9k0vBxFq4r62rNLXi27RnbEqSE68F00jLERq+TPwpJ00
         pfDDywu5X47eOnqyrv4fn9gFzeaIpSvqCLV+8NdsM/OJLZmc+siaimcuiu0wUkSGQE9b
         PILOSFHlulf6rr0hRks6CBFzRan+en07RkleXhRmnAWf1gdMAOXvBHBwRxbH7LgAe/MM
         xmVJAPfNQoxan/MTN4KZiuEi3ZN8Wy/VgGd2OfAPlTriQo9beZcxqE1dTYCu0hugnmth
         KjCA==
X-Forwarded-Encrypted: i=1; AFNElJ/IwFL+kXbDrXSabEcQTyYa8tGkdxLXTjCBCaCvQwIAsx9ZvGbU494TLSi/NTdqwT6PkC3CcSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZF+5V2QDdP8a1Myw+RnVT+SSgL69PHytvwkDQ+uVeZDsYJMe
	qlX4BrFSfAU5jRNGFyXtEb0PrC3HWto9/K8bdYWJTVulNUkKOOFG5L+KpfqmlFYvTImJaXWGxQo
	rexZdP+eo+OvCr80Rj0YLwiFajM0Oa1EnzWuhI9kA4bNkMbnO0uMzLLwFYmtGtNysIvvfvJZgnE
	M6D18plzQMxzk9csHM1hrrJ5R7k2fliRo=
X-Gm-Gg: Acq92OEUGSf0OOsEvmmtrFIrZG0BzDJAHWN78priiDT+LBnGW0EDrzSP/8JZTPJQUqo
	he1HFFuz9Mld+t33VF2yiEAHe+XyjN2GkP7cCUSj0JBtiCsm1h97p99eJB+8XfByGR4n3Zkhsa2
	Mg/KRJiWCrb8F1SFA5ijR4tkHZz7piPB3cI6KhXJbMebM2/LxSDW/8M2Y/DqI0+2FFSdZ4YjNH2
	jyPVUbjRiCmFXoY
X-Received: by 2002:a05:6402:26d4:b0:689:9d82:bb60 with SMTP id 4fb4d7f45d1cf-68fa4c0f174mr512678a12.6.1780615255937;
        Thu, 04 Jun 2026 16:20:55 -0700 (PDT)
X-Received: by 2002:a05:6402:26d4:b0:689:9d82:bb60 with SMTP id
 4fb4d7f45d1cf-68fa4c0f174mr512671a12.6.1780615255671; Thu, 04 Jun 2026
 16:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-1-ameryhung@gmail.com> <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
In-Reply-To: <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Thu, 4 Jun 2026 16:20:43 -0700
X-Gm-Features: AVVi8Ce0WFW9gMUWNHasTlWWw6IfUPQ4uso6eoFelhGkfIql_5gHa5D0A8xF8uc
Message-ID: <CAP17u3OUn6-tvV6jLEjknCJN4MNjD4JJxxNeXu57FOpPuuaKvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Object relationship refactor followup
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@kernel.org, mykyta.yatsenko5@gmail.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: i1E2nzD32L57to0tRLruC8wrDqeYaNOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIyOSBTYWx0ZWRfXxvDpyb++eh8n
 F1PZF0ZtSREpUbuXbC2NwYF0q6Xv5eJg3QUnKZFodB8wdvZ7Vx1eyYI1VVZLHfEyBHECqQbE4kA
 hRDmAd7hBM0BWy2BelT4gqdbpfm02Rs6U2Krfq/CmsHWSylfA26XcJTxFkYArNNZtTmxt25YSg4
 leT8FkeLxdk7FkhhFdohYOuHCtG3qcfIc9VFLi1rrvsDevAl0jGu64uBMHZpKZ+HDgrgIEcXidd
 tSqXS38OoXslAd7UKEI+/75PCGarHXKQUxYOG66Fwl16JYIMGzpnlfR2kV8W+A6tiReubYdy+hz
 IHRecDHdUXkhcMHBzopmQjQ/s9sEA9DUumITx5yWFwkMNDM7TJLzfuDxvhDQ1cPOJd5npqk/2pt
 VWqz1DOsUuXSFOkTI2jab7hlgRSTSumcsvj7fj3PXqHKWO/zsuwOaIjTCVQvqJRgGWs6smKE77+
 6Hc7Beh38TS360V9iag==
X-Authority-Analysis: v=2.4 cv=IbC3n2qa c=1 sm=1 tr=0 ts=6a220859 cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=BgfoZ7BIgC5YM88rzDIA:9 a=QEXdDO2ut3YA:10
 a=22KAYETGZJnyhCxlFjxL:22
X-Proofpoint-ORIG-GUID: i1E2nzD32L57to0tRLruC8wrDqeYaNOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:memxor@gmail.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ameryhung@meta.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB1DD643EF1

On Thu, Jun 4, 2026 at 3:15=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Fri, 5 Jun 2026 at 00:09, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Hi,
> >
> > The main patchset refactoring object relationship tracking in the
> > verifier has landed and this is a followup that addresses the remaining
> > feedback in v6 [0].
> >
> > [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmai=
l.com/
> >
> >
>
> bpf-next makes sense, but Fixes: tag looks missing?

I will add fix tags to both patch 1 and 2 and respin.

