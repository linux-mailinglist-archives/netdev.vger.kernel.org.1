Return-Path: <netdev+bounces-251527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHmwEeiob2kZEwAAu9opvQ
	(envelope-from <netdev+bounces-251527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04D47210
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19EF450E6EB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CB32E13E;
	Tue, 20 Jan 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yktCWCHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2832B9BE
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923697; cv=pass; b=SdmWu08xfvFu9k+1URkRcmBCzy5n3cngtiGpHRMH7pJoZ1IfdsJULU8F8UYHUwdsaNkwXpZY+mM9MbAXKOOxNA15pQI8ELGY/8PV2792Rwwhebzr/Sns1vQW99n6j3opCylIbpgiaAbqlLM/E+RIF/1U0JVXr4mBtgDeSbK37Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923697; c=relaxed/simple;
	bh=Fluxb/WbD/JJZE4JUd4fxNTtxOC2Fm+ZRwi6K7z/+x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIgWye9/5L9TfIiSBz2ca1zZ+/6H/43jXqHrC/yjdI2jQ7OhzCL/pmbLg01fgPUrLlHO4FYtNQ10ND6U9JY2PWMzC09vzieSn0/ZsLBkM/s3HgDROphTrafP8IpnBl96l0Tos0WIjusKLW2DoMe0lUWCxaiD5fudphqFgd5M6kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yktCWCHQ; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6aaf3cd62so449863385a.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:41:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768923694; cv=none;
        d=google.com; s=arc-20240605;
        b=f+jMxudjkEKwkCbk2aWu4Pq4AC30AXdxIyXy3lEXubr+fhsSPfEYEMgD2evWNqMWBH
         vndxWntj1rPNn/LR+dh7kwkpGEnUAI3SxdcDcRSQTDLE8JsAoRt5LKFmCithDFeUEHyt
         iFA9EQDsdtJ4Yn3ziZ8UeP/C8dMTX8w9pZKvUCqXiwobadATXLkaYFw24SHNXCZdj/Rb
         rLDGQ6UMkTv1ZDrc0SOcw1kp3usLPGKi92kZ3wO27fGu1QmmfyuFxoNL9pQoAO9VDORI
         XUkxioWEjxynVRVHAnE0dMydVNHkkNPqdeqzkCACCPpWJyrhEflmD7OxpexLquATeSVD
         AJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWu4y7/zpK5Cmgzt2Qcn88dqo/y5xHK+1+dmR8ssiJs=;
        fh=o2AY5SU8dOwopWqVEhadDRb45wcuxnc0b6BG6dj676E=;
        b=DdkWEsX33pSlDLKcxGkYRiYLQj+fXNcIbwbRuzXSM3l1q7tmnKBNJyjqcW1lt7oyBz
         frf9v1dWG6tq7NHpwMTZT3yKkodMRRaA01qVEP7Nd0xprWXJnuPUFqMyMYdqArazdcGK
         XBoi2X7uh/1wnn8YoG917rNrnjoyAvSk8ifybXKcjdtXlVRuU1TJw8xUd5lSeNeG+Oq1
         JHH/K0vAoQJj5nM3Qv6K0G62fjK19ii++3DeER1M6Zn8Int4Tx7R9Ud4lcEr9fXIkshJ
         MIDNAI+DNFxQKu4hh/mketp0PMyc/NuMejGaRPFibtsg+bcxzeE29chah2EqeKhoq0cw
         xE7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768923694; x=1769528494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWu4y7/zpK5Cmgzt2Qcn88dqo/y5xHK+1+dmR8ssiJs=;
        b=yktCWCHQGRWGPcBkueXZ/7KGxqYmspHChLrLkMdc1WlqO3IeIbvdGlldng4frSmC3w
         lE6GLGrocItpqbVodiuPQQaBg1dobiwboE6Cc5270SwtKZ+8ZAvSTjyQCyqZUFTS44jb
         kthr0Lt5OO1UiK+ZwVpF1TP3q6dUwtb11Y1UkwKlaTxcsr1kAblRMl7gQq/Iueir0XVo
         Q5XFbKZpWJrA2MlPp/R/R+WJTCXlefbCesVYywTZIDltkMAakx+MS2KGv9LAsuFKrtyg
         ulF4HC538kNXX71XUYBr4QRgBWaIkpIcpq5667swnWdTRcbSqKT0b6R8kdLtskvkYfMk
         xNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923694; x=1769528494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWu4y7/zpK5Cmgzt2Qcn88dqo/y5xHK+1+dmR8ssiJs=;
        b=gHBn6DeQqcbviOesxO5bSMmbWadZP0uh5CNKitHB7+S5PgHzfQaErx1WkT4+97tb5G
         lZ+Mq9VX0mtGczGWXxajXZZ7J41xT+81Fnk0jN77Ei1iVToKV6RyrTDx6ZTo/ZszI2BS
         pFj4nFMjEQMKH3JkONdoX7H285yC+bEsxde/wyHE2QVQ4ErZ5utR3OvrF/trtGpF8aSZ
         Z9cZuX135WCXxyDuMPWbDZirJWo7sB94NIsSZx+6U5KV1tcNvkSCeyp3RGmPGRQ8uOcw
         k3utYq5AZDQHTt4kQZdIjzTP6X0vh8+LVRwQ/Ei/HuGEvATM67GXmSQLQPl4CIG/+DcR
         1JFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTL47IKTxPChme/JkMt3d3j1QWjtl9NmUouylC24ugbuNg2tRWB6RKAQOSbu1E/qJIHkaRES4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZK/qVnWriIRjfbSvWZdAk4T0nDWVKiOsJYQJmWRoIL4KmT7QN
	C2ENgSvgcCh6lQmP5/3HSW1xCqMaQRLw3LrY+WWIq6/cVNEk/t/6DbQW9oI5jG9kLotvM6ebqGw
	Ypu6K5JuGNIrh10yfP1UJBppjmDPMrGAsB3racFvz
X-Gm-Gg: AY/fxX6PrLCCnLJhs9wZQsphI/Z3GERoDiIpR1W8fHxSazuwnf+y4SG76ZyyWoc+iAq
	+3U4nJ7U0O4ZqeLEm3/Ugi+23oSTPezFi2dCxgGnNNkjdx4m75SNSqSeXMot3+Rrjt/QSX4rLMU
	ewNHUmjesWjXyoVQGHs4mmnOnFxehA6RoEnAbedoH4HilTziGmswMPqUSyDsBEHf6Kjig7efsJi
	gELt1Ix7NUhch5DkOacj+LLUNG6kgb83iyYqnBQB0jjTbclRzTNhcnxMlHLvp8ifM7J7cJzq1R8
	dQnZm74=
X-Received: by 2002:ac8:598d:0:b0:4f4:de04:2434 with SMTP id
 d75a77b69052e-502d84b0bdfmr25784171cf.11.1768923694258; Tue, 20 Jan 2026
 07:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com> <20260120073057.5ef3a5e1@kernel.org>
In-Reply-To: <20260120073057.5ef3a5e1@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 16:41:23 +0100
X-Gm-Features: AZwV_QiVuLRNYYgv4V8HfqtP9vG3l-gtsnc33EhOe-DORfIA6NqeikO-gMB3EfY
Message-ID: <CANn89iL-w7ES=OsNQhLTZjxVdfOJxU2s7wRXJF6HkKSAZM2FBg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9C04D47210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 4:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 18 Jan 2026 17:52:12 +0000 Eric Dumazet wrote:
> > On some platforms, GRO stack is too deep and causes cpu stalls.
> >
> > Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
> > (32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10=
,000 flows)
> >
> > We can go further by inlining ipv6_gro_{receive,complete}
> > and take care of IPv4 if there is interest.
> >
> > Note: two temporary __always_inline will be replaced with
> >       inline_for_performance when available.
> >
> > v2: dealt with udp6_gro_receive()/udp6_gro_complete()
> >     missing declarations (kernel test robot <lkp@intel.com>)
> >     for CONFIG_MITIGATION_RETPOLINE=3Dn
>
> Still not good?
>
> net/ipv6/udp_offload.c:136:17: error: static declaration of =E2=80=98udp6=
_gro_receive=E2=80=99 follows non-static declaration
>   136 | struct sk_buff *udp6_gro_receive(struct list_head *head, struct s=
k_buff *skb)
>       |                 ^~~~~~~~~~~~~~~~
> In file included from net/ipv6/udp_offload.c:16:
> ./include/net/gro.h:408:17: note: previous declaration of =E2=80=98udp6_g=
ro_receive=E2=80=99 with type =E2=80=98struct sk_buff *(struct list_head *,=
 struct sk_buff *)=E2=80=99
>   408 | struct sk_buff *udp6_gro_receive(struct list_head *, struct sk_bu=
ff *);
>       |                 ^~~~~~~~~~~~~~~~
> net/ipv6/udp_offload.c:168:29: error: static declaration of =E2=80=98udp6=
_gro_complete=E2=80=99 follows non-static declaration
>   168 | INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb=
, int nhoff)
>       |                             ^~~~~~~~~~~~~~~~~
> ./include/net/gro.h:409:5: note: previous declaration of =E2=80=98udp6_gr=
o_complete=E2=80=99 with type =E2=80=98int(struct sk_buff *, int)=E2=80=99
>   409 | int udp6_gro_complete(struct sk_buff *, int);
>       |     ^~~~~~~~~~~~~~~~~

Oh well, I thought I tested this stuff.

