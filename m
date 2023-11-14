Return-Path: <netdev+bounces-47834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201A67EB809
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0382812FE
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF0179A4;
	Tue, 14 Nov 2023 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdT4cSiC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707492FC25
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 20:58:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6243102
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:58:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so655a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699995483; x=1700600283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frPlbTPao9b150KTq30hf1oJDM4K9yy4mI/YoIL88n8=;
        b=EdT4cSiCMjEyQ/4v1MO+2LAfhdKL2HZ4S48bu2nIXD3QGtKAs14U+TtK4q4E6eYWMR
         swsemJTzTJ6ba53REuKa0/LTGigQm7AwyEflifXzQVx8xVmqoDUBwa35CgENFpSNv3ke
         Vwi8jSXRU9N5iAw89zOyx1xDoxoVxWxPUAWG6UkgCe9I+7gT0j0O+hEhl6DAeDnjKJkV
         LOlC2E7NRfTEP9ZiikLXNkQSGx/02M+sp+dZ+RYAIx2TfCIHa5HuqA9K/xr+QEmirB6l
         ha99f0tgkP9tIwyJ/S0a76sD4ZlxtBbYtPAowwyCgYKDx9C6iIGS7ciOihHQ0lFItT6f
         xFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699995483; x=1700600283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frPlbTPao9b150KTq30hf1oJDM4K9yy4mI/YoIL88n8=;
        b=bKF8lTG67sk/YJATgYts0b5vpnyg/NFNf34+WcwcEIToEScKlASezuKELbZaN9oM+v
         /CbCUyXpIqXQos94fYfjkS1TgTO7RnlASclRH5zGYDkPMbAemUPCjWIA5PBVzvwf+hLY
         q2gi5LKX8BKV8pLClte1V9maRwuqWbuDcNZv/nnaXLAIKqXIGjMv6dULez3mdGcz7X8j
         uG0GAKZlNdQ43/9J6vKmL3VQljp4/q3Y1757L/IhK/eIXosrPBjPiu4Cz2W3xFykXBXo
         LsDgCk2VUXsWFyVjve9DEPI5FWiavU+8yUHSmFQlePSi8ewcXPZ0povh9UtCUdLCxrwT
         vb6g==
X-Gm-Message-State: AOJu0Yxeg8yV4L/ikIrn3z77y90pFfMYL2XM2pFmzYceCd19ejJ87Oji
	IORNivHBNpT7Sk/4bc51WKRArjvB47rcjdUujEuVvZjGzgn1L3VHDqw=
X-Google-Smtp-Source: AGHT+IFcUI3eX3zI9/RWsdCWNzDMU1F+/G+l7KIj7X6rtfGgJO1x8XiMSrQQ06EeaQ/4iWHtEsOjxsb7WQaUVxFwMXU=
X-Received: by 2002:a05:6402:f0e:b0:544:e249:be8f with SMTP id
 i14-20020a0564020f0e00b00544e249be8fmr6790eda.1.1699995483111; Tue, 14 Nov
 2023 12:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
 <CANn89iKhboBst+Jx2bjF6xvi1UALnxwC+pv-VFaL+82r_XQ9Hg@mail.gmail.com> <CAFYr1XMRLx_ZsJDxjZh5cv5Nx3gSWiiY76VZE0610gw284-Wcg@mail.gmail.com>
In-Reply-To: <CAFYr1XMRLx_ZsJDxjZh5cv5Nx3gSWiiY76VZE0610gw284-Wcg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Nov 2023 21:57:49 +0100
Message-ID: <CANn89iLDFvTZP05Jhf5LDrmAsoDQ_w9qkjOmb5s0pr4-Xh+w3g@mail.gmail.com>
Subject: Re: Potential bug in linux TCP pacing implementation
To: Anup Agarwal <anupa@andrew.cmu.edu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 9:39=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.edu>=
 wrote:
>
> Thanks for your response.
>
> Yeah, I think for the currently deployed CCAs, the current pacing
> implementation works fine.
>
> I wanted to clarify, the issue is caused due to temporal change in
> sk_pacing_rate and is independent of pkt sizes or network parameters
> (bandwidth, rtt, etc.). If the sk_pacing_rate goes from r1=3D0.1 pkt per
> ms (~1.2 Mbps for ~1500B MTU) to r2=3D10 pkts per ms (~120 Mbps), then
> opportunity to send 99 pkts (=3D(r2/r1)-1) is missed. This is because
> tcp_wstamp_ns was computed as =3D10ms using r1, even though
> sk_pacing_rate changed to r2 (immediately after tcp_wstamp_ns
> computation) and a pkt could have been sent at 0.1ms.
>
> The ratio of the new and old rate matters, not the pkt sizes, or other
> network params. Typical CCAs perhaps only change rate by ~2 times so
> only 1 pkt (=3Dr2/r1-1 =3D 2-1) worth of sending opportunity is lost. Thi=
s
> is why I guess the issue has not been observed in practice.
>
> Yeah I did see there is an option to specify "skb_mstamp_ns", that
> might allow CCAs to enforce rates better. I don't know how easy or
> difficult it would be for CCAs to set skb_mstamp_ns. Because CCAs may
> not look at individual skbuffs and also given tcp_congestion_ops only
> has callbacks on ACK events and not pkt send events. I guess BPFs are
> to be used? (https://netdevconf.info//0x14/pub/papers/55/0x14-paper55-tal=
k-paper.pdf)
>
> Also, to clarify, the reason for the conscious choice is that the fix
> would require more state in TCP socket? Or are there more reasons, any
> pointers? I imagine, for the fix, the state would increase by ~2-3 u64
> values, e.g., credits in units of bytes, the time the credits was
> updated, and the time the credits expire). Is this too much? Or will
> the fix require more state than this?

It is too much, yes, and not needed currently.

