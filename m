Return-Path: <netdev+bounces-47836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BD7EB824
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E035E281070
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363712F878;
	Tue, 14 Nov 2023 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="kB0pUe/T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B72C1B6
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:05:11 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5997
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 13:05:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso9379454a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1699995908; x=1700600708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MvtN6IL4P3DjHe3YP3lGhn6DdJIPJ9Qo0JTpiBmuaM=;
        b=kB0pUe/TKYE0SXPV057Og2b+HIobcFNISyng8votnngvsYiWYEJaR1sIkuP+k1pWaY
         RDQC6G4Toi390Za1ikqf6CVmMlc+kFISo96IpRMvK/1xaoBAqakU7ZFd6SFC7toACn/k
         Nlvs2MKWTzXMFb7giU0a5FWzmjqhi23YzueUvHL8vziN9xCd5nmtEI53Fi7tcpzi1fW8
         2XV+Y+f+zMV22QTI6e8/RbYhmaoefym86k0UHF0ORUqYVY+4A6uusJaCBvJtNOeLPU1z
         6DrIz72yvgZTzk9Fnf2EtzlnbBvmHOBqJqPiTLWiAB1xsIaC1Q7i3beBfl+0RD2FVaGq
         gjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699995908; x=1700600708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MvtN6IL4P3DjHe3YP3lGhn6DdJIPJ9Qo0JTpiBmuaM=;
        b=fosRRYXOEDr+OhK4cG3cFaSq/vP1dFaxY1AGkxGXeVzGf3cwo2AbUCp26vINUTAxf0
         3HkZMfyQiomLK4Vpko8F71F+xlalsTPSjaFETovUGoeW4otUP+G3Rek8Mz5+08irTqtx
         YltoZV2FyYwOdSNwaABq0W8/29UNQE9BowAZkHAkMd50ZsinBOyuxvZySgAA5hXUN4Xh
         W6TRgwi/DuBBghIYClXN8XX19uxwP6h2Ex3jkIeg8ZpIwAmFSF9na6cTkIRQJvqI+nUR
         yPmN3MUOTGxwyf8yZYJihEZJ4QCmpMoYzpmAnv8onF3BFbKhq0RP1DazWcRu9EX3/Q5I
         drSQ==
X-Gm-Message-State: AOJu0YxApuuYQC1BakKHrQyUbvEr5xZn+K1za89YLQXlnQskoEu9msm/
	dBNvCmsluBWE/SeV6YtYL4HzxGApeCMfq5nxeP7zVOJxszPzXZPr
X-Google-Smtp-Source: AGHT+IH3gHTUAdYHgnoejQy7waQdhY7RWC9bfU63Qecxaci1cOJNQ+1MIMmxldpGfSuwGByuhoGLp7+sWWhHS+j7fQw=
X-Received: by 2002:a05:6402:6c3:b0:543:4fdb:de84 with SMTP id
 n3-20020a05640206c300b005434fdbde84mr8491987edy.7.1699995908153; Tue, 14 Nov
 2023 13:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
 <CANn89iKhboBst+Jx2bjF6xvi1UALnxwC+pv-VFaL+82r_XQ9Hg@mail.gmail.com>
 <CAFYr1XMRLx_ZsJDxjZh5cv5Nx3gSWiiY76VZE0610gw284-Wcg@mail.gmail.com> <CANn89iLDFvTZP05Jhf5LDrmAsoDQ_w9qkjOmb5s0pr4-Xh+w3g@mail.gmail.com>
In-Reply-To: <CANn89iLDFvTZP05Jhf5LDrmAsoDQ_w9qkjOmb5s0pr4-Xh+w3g@mail.gmail.com>
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Tue, 14 Nov 2023 16:04:32 -0500
Message-ID: <CAFYr1XOWwUmmGbZEwE9jXWjELy4WAJuUODs=umerZROFJg-ueA@mail.gmail.com>
Subject: Re: Potential bug in linux TCP pacing implementation
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. Thanks.

On Tue, Nov 14, 2023 at 3:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 14, 2023 at 9:39=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.ed=
u> wrote:
> >
> > Thanks for your response.
> >
> > Yeah, I think for the currently deployed CCAs, the current pacing
> > implementation works fine.
> >
> > I wanted to clarify, the issue is caused due to temporal change in
> > sk_pacing_rate and is independent of pkt sizes or network parameters
> > (bandwidth, rtt, etc.). If the sk_pacing_rate goes from r1=3D0.1 pkt pe=
r
> > ms (~1.2 Mbps for ~1500B MTU) to r2=3D10 pkts per ms (~120 Mbps), then
> > opportunity to send 99 pkts (=3D(r2/r1)-1) is missed. This is because
> > tcp_wstamp_ns was computed as =3D10ms using r1, even though
> > sk_pacing_rate changed to r2 (immediately after tcp_wstamp_ns
> > computation) and a pkt could have been sent at 0.1ms.
> >
> > The ratio of the new and old rate matters, not the pkt sizes, or other
> > network params. Typical CCAs perhaps only change rate by ~2 times so
> > only 1 pkt (=3Dr2/r1-1 =3D 2-1) worth of sending opportunity is lost. T=
his
> > is why I guess the issue has not been observed in practice.
> >
> > Yeah I did see there is an option to specify "skb_mstamp_ns", that
> > might allow CCAs to enforce rates better. I don't know how easy or
> > difficult it would be for CCAs to set skb_mstamp_ns. Because CCAs may
> > not look at individual skbuffs and also given tcp_congestion_ops only
> > has callbacks on ACK events and not pkt send events. I guess BPFs are
> > to be used? (https://netdevconf.info//0x14/pub/papers/55/0x14-paper55-t=
alk-paper.pdf)
> >
> > Also, to clarify, the reason for the conscious choice is that the fix
> > would require more state in TCP socket? Or are there more reasons, any
> > pointers? I imagine, for the fix, the state would increase by ~2-3 u64
> > values, e.g., credits in units of bytes, the time the credits was
> > updated, and the time the credits expire). Is this too much? Or will
> > the fix require more state than this?
>
> It is too much, yes, and not needed currently.

