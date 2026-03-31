Return-Path: <netdev+bounces-273641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC/WARvPy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB836A67A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7E0530396AB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395093E716B;
	Tue, 31 Mar 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vK+OoBkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581803E5EC9
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964354; cv=pass; b=tS5bk/eCRWBzlYMEV2RKqo+zOE4P2wgHhtFt+vNVQK3xVYWSQz123y7+VX8qN2lxEHb4O2K0ayxFknenhkNM4K5aDBcvLkjvzxHFVJE5dMV7+OwB2Qsi23sLrQ6MUoskKwjkfnPDgqrfy/YKchK/cq/UqNmvIsBHhid6nCW30OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964354; c=relaxed/simple;
	bh=yEHH/foANJ2Uzhoc8MG+zcT5peoYqwBUVi1hHlud4LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R69t50XwACykT3BUiI7+3+lcHUUK12LNTw2Ej6zhz6dJz5qTrkmuxX39MesySYNyrzr9+YNXh1qeovZKHpQIvp2EElmQpmG8zOhMa5jwtxwxUVrFs8Vk+DP5OTEJSxeMvZwPOJhsGAhiLU9Utq73G0HQgSteD4B6ALvr5Vr09FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vK+OoBkO; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2d6f9d00so51198051cf.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964351; cv=none;
        d=google.com; s=arc-20240605;
        b=cW6Z2oRfknMjMVNfmeWO4Pc6ago509TFaQbAZQRO4+8iBfPA7lDx+lvrIMGQf6IFKe
         UXVKGv/h4u+4wOwvD7zlUPfrdaxbBvY3MCBvMRxb0vzH/W/C6UtvaBKlzPMey+Sz+yJX
         H4qFvGnX4oMMRizea/OtR7fXmM6I+vrOdiq4JUV2/BniKzHrhFr+V/cYq52rxhcO9eY2
         oV/xslPD9HrFYRQBCIDGM8BZ279wInMfyKhXqCDr6YniqKSqYrsZGsKVh3dP0NNBI5HW
         QGPpOAHEnHY3FGIJU0WOO8/ciUY2oWOMqgSUPxXPEHnRCFiR51ShqpfFkT5LSi5t5NDB
         pM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iKtVcJXXLJ/ra0SHhu9ixsONtywEP9uFWu9jAH0+5Nw=;
        fh=NdUYpX7ns3jMl7AO9OWRlZvePaUy/mQS/f9qhvkDDs8=;
        b=c5k6GleXJQL5Og8OtQP8MAKZU1TwYNIfYKpryqKKuZ8wOjqiMgAPqKdAIs99AnBJD5
         dykpSIkUnF6caNo2teMRn2/w04Pw23X1M8kF8bnruqX1asM46pqVPsb/Rnvm+Srizpnq
         GGrDBY1L4NCNpxK2B6cilVEP9GgDZtZc5szavfP55/VJmtcZuCXgfrWW+bwq1cAwk9jp
         9VYgkAWTO0d6uzuIPRgpE2g71WY4xtXTXbVNZyq9Ks6oM/29XJxCANK+N273KIPvbPkR
         SAearzXbp7UDc1ZUFv0aUJVPWLiqebu4KXRqNq+VFd4TqL1FW5H6qVSa+X4wXbwvp63g
         7DJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774964351; x=1775569151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKtVcJXXLJ/ra0SHhu9ixsONtywEP9uFWu9jAH0+5Nw=;
        b=vK+OoBkOzhzQDA+scZ2ZSJi9HAbNZyp8oN+YjVhHktP+/fbEAu53D1QuHre4K0+EJk
         QmIKJP1BHOigrtZ7fpk5L4jrXJrAvqjoSz7Qqgevqtt4DIZT53m7J1cJcYlRE59adlnm
         Wr5m98v3fJUhw5t+ApHeHem2tjVZ98stu4vyCei4yjWF7E6xA55WwEWXaMYC0acaiwky
         vb82tMDQr09OFwj8z/MUJFncOH/Q2tZ8YhrDUYHokru2tCSpchXUWQgqWPMc4IlWLq5k
         M2cAHopGWfJce7V851rwMX9aBNbS1QAwcHJHp3//Rq8UgTWsvaDS5bI63UusD0A2x2Z3
         speA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964351; x=1775569151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKtVcJXXLJ/ra0SHhu9ixsONtywEP9uFWu9jAH0+5Nw=;
        b=PYIk5lYuz/02E9MzKGGTuwNxzEwqVWJugMktoY1C9y0PCye8dRWZ5x6Ja2NCH1MQ3t
         qKeV4W/HJWG9qNE+Wai3/V11ixWlgNXldv6EKTl1RZz46XbGmQJh20phZu5PnjXKIJ4c
         /7HGEpB91z6rvPa40S5Vk74rOcFmkdzYaJPSTKqKu3ZBbcfWhECk6REFj02sOLIageaX
         x2G/ToiBJJw99apm8GSy+3OTXV+ZoI6oqnSng1GmeX3h7PtijX97uQVnnk+yQNUB2Xxh
         TSjZTAcD6ZJGTvUnJHqoTMbiiILBOmz2zheNeYUAHrhga4op4L3eUwn2gH8psQHij7Cl
         Frjg==
X-Gm-Message-State: AOJu0Yz/sOYK+fXDeLsDhLAQxGwOc2FqPkMYOhPo/swTEf041crrgtoN
	MHhDbfhknaclUmTf0cN0PxMB/ixgrGB2C0ynlUEnJrLzF3UaVi2u6HVGCdSbskZP+RYdUGuAU2g
	sjQEwmzi287WKDkmnpFNdVtXHpNq4huapWERu+biv
X-Gm-Gg: ATEYQzwSddRUVZXBpcUp1UlMZzlC3HCvDsGDwSv/hccvef8R/6pBUxvLQ+dmJnQ+QY1
	qM/9Xw7XCrO96A1CLA6QbpGIdrvSXzErAie8/3BupN4xI3luABgavaLNhPxYjU1UDBYL6KpMO4b
	/cMatLgkGZ+3nupIhR1dB7/rqe6OV9I9t1A5x0qW8ZxCNEE5VSqUd5MQi6X1WrPMQaR8UgfiU9N
	HHbKwYXdyyEAtMbCn+7A6j8fyFtyj8J5bHgVjZXfSF65ESt1L0ki9V+rNHmY1WxyZA9d7ZUzo9r
	+zivYQ==
X-Received: by 2002:ac8:5a49:0:b0:509:2677:68f7 with SMTP id
 d75a77b69052e-50ba380a897mr218833071cf.5.1774964350324; Tue, 31 Mar 2026
 06:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331115943.10404-1-fmancera@suse.de> <CANn89iLJUi+cA4fFr7XQESkT+5ckY6+MGg7QEM-G123RzuD5RQ@mail.gmail.com>
 <9aaf6dc6-3c21-4cec-9f16-5d76cb40dc80@suse.de>
In-Reply-To: <9aaf6dc6-3c21-4cec-9f16-5d76cb40dc80@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 06:38:57 -0700
X-Gm-Features: AQROBzCHd49wKcamXPB4JuYTo7UWfxNM9-CelrMXFuJILvay3bqRXqHT3bws8fI
Message-ID: <CANn89iJ12g+AEr-9o1xbFEcSoTMYYYB4yXQW7pNRH0tei=KZug@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	Yiming Qian <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-273641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 0CCB836A67A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 5:50=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 3/31/26 2:13 PM, Eric Dumazet wrote:
> > On Tue, Mar 31, 2026 at 5:00=E2=80=AFAM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currentl=
y
> >> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> >> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> >> allocation fails for large nexthop groups like 512+ nexthops.
> >>
> >> This results in the following warning splat:
> >>
> >>   WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU=
#19: rep/9282
> >>   [...]
> >>   RIP: 0010:rtm_get_nexthop+0x176/0x1c0
> >>   [...]
> >>   Call Trace:
> >>    <TASK>
> >>    rtnetlink_rcv_msg+0x168/0x670
> >>    netlink_rcv_skb+0x5c/0x110
> >>    netlink_unicast+0x203/0x2e0
> >>    netlink_sendmsg+0x222/0x460
> >>    ____sys_sendmsg+0x35a/0x380
> >>    ___sys_sendmsg+0x99/0xe0
> >>    __sys_sendmsg+0x8a/0xf0
> >>    do_syscall_64+0x12f/0x1590
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>    </TASK>
> >
> > I find these stack traces without symbols not very useful.
>
> Hi Eric,
>
> sure, here is the decoded trace:
>
>   WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0,
> CPU#20: rep/4608
>   RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395 (discriminator 2))
>   Call Trace:
>    <TASK>
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>    netlink_unicast (net/netlink/af_netlink.c:1319
> net/netlink/af_netlink.c:1344)
>    netlink_sendmsg (net/netlink/af_netlink.c:1894)
>    ____sys_sendmsg (net/socket.c:721 (discriminator 16) net/socket.c:736
> (discriminator 16) net/socket.c:2585 (discriminator 16))
>    ___sys_sendmsg (net/socket.c:2641)
>    __sys_sendmsg (net/socket.c:2671 (discriminator 1))
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1)
> arch/x86/entry/syscall_64.c:94 (discriminator 1))
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>    </TASK>
>
> >
> > Any reason you have not used scripts/decode_stacktrace.sh ?
> >
>
> Not really, in the past I checked other commits with `git log --grep
> "Call Trace"` and found out that most of the traces did not have symbols
> so I decided to attach the raw trace.
>
> I do not really have a personal preference here. If trace with symbols
> is preferred I will do it like that in the future. I could also send a
> V2 of this patch if needed.

Please send a V2 (after the ~24 hours delay) as we prefer this
whenever possible.

