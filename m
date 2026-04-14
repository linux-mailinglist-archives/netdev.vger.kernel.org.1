Return-Path: <netdev+bounces-278503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPKeCsBc3mlfCQAAu9opvQ
	(envelope-from <netdev+bounces-278503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:26:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C17EE3FBC71
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D4DE300D0ED
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33A3EAC61;
	Tue, 14 Apr 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD/7PG9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5543E9F96
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180412; cv=pass; b=cxlYngteqhXoFhHJeuO0ypldOyQWnkXO68ozRj1qE324XC4PUlCENixJcmKBqGqh2EhH9HwEUBbwmn77XN1Vgn47NpKvnQPiveJpmfFKgu+mBy1hVHkuW+dAgWHJHduI9Ter6Fg9+baSK7Nvo8cMO11OV2TtH/3s+aHmh+BLvRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180412; c=relaxed/simple;
	bh=APWIwVBnWud2KUvQ25ixi8qabDa/mYdNMgVhu6CyJ84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IirNNAR0x2Kg3+rR6E6owMdFOaiIXjdR9BfxhIk/EnJFut4FZTc1z79j0CK5CiqbwhqJX+h/M8AFs1zl27QrPfiI7lQIsGIyeQUTSYprG2ntdfY9ajfKlhiVH+NOa1AJMu8Vm8O8wSAaGmKSlt5J/JDa4YpX3nzzThWWH0dhUak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD/7PG9o; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso24204a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180407; cv=none;
        d=google.com; s=arc-20240605;
        b=Wsq6H2IS7tdLu/C3n/lcwkov+CiywDMFybd9WLylRoXQnNQnY9qN0c/sfb7WwB8Q1W
         7QMNlrOyGztdkOG1Kd1s6JMKomuj6LmQx+edN85OjYFOwiBW4Syeqdt/xrkn6ydx9NVH
         3K3+JW2YBggp8dMGDN03or0xravxp1au00ceweTiwBYHF19ZyjbMl3KEHe1YPueSZqbB
         32AUc7UTH+N+HH0dqEozHLj5gAiJ7jFxR6BGCEyQ3LHSoPhGavppjMses5IDD0rEScU8
         q4H4HOF/o2KmIlfZuOrQnDHcGlnxWn9Sl9fd6lFRN0DcbwRErHOapVlCIlP3fHhDvKPp
         ieMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fQXR7gdbIrzBizqHW19/U2t0vIGTDBFHKNlzynsMqxE=;
        fh=jCSeCQN0nOiZue2LcwAPQ2CuM2dFknmU7sNl1BoM5xA=;
        b=QwMPXetzlX9rZvyKCRTARy49nhSAa3kehi6CsL7PLIgPNijaYYVyfR53+wTzdn/CNC
         /0ObUdoGD+Hd0fZZgkWttpCcTT3Dfhh7gFjPxzSmnhb99zeHJxaIoiqkHxSDB0zUvW2j
         t7Mpj4fVvx6ENd2423oyyEE+j9cQ3zIGkr27PP3PiXLmM/PUPfwogvLJH8knQ+1MgRxl
         IVwuHFZCtRCTjR27BMiGVqIA3AUfpoaXWytPkiDFDcq0TTBFTMGR8n5xVen7vpPQvDma
         hDX5HkFkTVOwfYW+9rpPj4lVJRSgdxWkC8L0TLny4QpDro6lf8JIKvv1FMC2hcYwdEch
         +vng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776180407; x=1776785207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQXR7gdbIrzBizqHW19/U2t0vIGTDBFHKNlzynsMqxE=;
        b=fD/7PG9ofgeHkiJp0U1XSND0UYUX1M5/cAJXltMT6jD8smjhDEMVluc/XUSQ3N0WKs
         M0HIs9LSubUrv/TkITLWO2YboVE9YuvPEu3rNY4Xo14+VChPkeL95AWTRXAow0c1/Pji
         YiOimreGKVDJEj1TWraoO9qTOp9kKTwCLKhDiak1B9DS2IB2oSU/SxTvJQlzpJ5p9ruR
         Ym2uM99AncS5Tq+Jm1TaML9T9oHVd7LG0v/JknVC1MSpX+Pd8ln/hGMG89uifu3MT9vk
         yF7o8pHT0hkz4Rf7+9iy7jdsS8C/rDThbT0J5IkpmJHIh/88RHKdqiMW5RscgqnFNm2u
         16IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180407; x=1776785207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQXR7gdbIrzBizqHW19/U2t0vIGTDBFHKNlzynsMqxE=;
        b=T0GY9M6G1H3ZMR5RCtuxibrl8QFxoyyWMX0KSv5ly33o09HSjswOk2AYZZRny6xnO1
         IYBYWxcdmtfaiRTAcIFmwdwIqbT2XDu9DLb6kPSfWtjtkAOkz6yvqFHLTdcYCWDOTURf
         Qw1YargpneCCyrsVZHdUedgAr19vsXr7STVSoZcYL3nLlsRc9fRTzoIr7AOyapSUimKW
         cZK4FD4GtImz9k0uGseycTHLbeEBS64bBTt7pVDYqdb3uxhH3JU8TRc97Vt41OtXqaIl
         4zL0437cpYj2LWm/5pIynEN7UbldGt0pJ2/nf+SqTdt2BuASpacizPzQln3PCIHnosKQ
         Ur7A==
X-Forwarded-Encrypted: i=1; AFNElJ9VZ+BydEbHZyhC+20sJJkXKHCQIETmu6mFh7mIJdjt3cubnVVQeKQYooI217PMQTEkOuruw34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXgKa8Ck3/pv4tlIHmpbryQTsyzTkFTWDcINIsu9YL/u8ivHL
	HWf4eaH2uLS+yqHfuNJzLd6dnLGXrHeNbxp1nuG+EUNZjdeUwzRgpg1QUUiFoHdJPz2ZovWv9hU
	HxHgfibv5OU5SAQq+pCkd2GwiyqWm0zSOFcOpW94vWmKWovOrzJvba/Do8uY=
X-Gm-Gg: AeBDievJFASHPNkOZ2oP1MAsxI8hv7a2maQ1d2NWLt9gewzH6GVFVKNhwa+TbRdKyL3
	ZR4hiB9Dog3P9mGHSixNQMcskEHU7DB1oljomVRe1xdatN25fz4pgxS2bj6IdMuEAGHbaGmEiSh
	yfAly8hp7vlLTTUsanUksPsEci3BQwCF0m5oF8mqrnC8xZZQLzNDb2/qIyBZjPDCwyl8iUVGWnv
	etXSALFwRvazYc62qnjpk3GmjxyTiM8Iv7vh6QSqWMGpkjAB1uKXF1gBY2CcLLjUg7aV0wwKIje
	XuLmr60Nv7Z2xZDLfEhboH/8CBLKVAz2YAhKnAT8cDF1+ZJku69y9MTyh5I8D3iW5HilAq65Su/
	nQKO3ewa1xurfxLVUsQ==
X-Received: by 2002:aa7:db56:0:b0:671:e8f2:580f with SMTP id
 4fb4d7f45d1cf-671e8f259c9mr37537a12.7.1776180406305; Tue, 14 Apr 2026
 08:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adIUY2N6HOKZNzSJ@volt-roccet-vm> <CADVnQymmsispHew4-frsuBBfObZHdSbH+jfP-9aSW1HguK_N4A@mail.gmail.com>
 <1bce4c38-3bc3-4d59-bf36-6aa47c7a5c77@ikt.uni-hannover.de>
In-Reply-To: <1bce4c38-3bc3-4d59-bf36-6aa47c7a5c77@ikt.uni-hannover.de>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 14 Apr 2026 11:26:26 -0400
X-Gm-Features: AQROBzAKHQtPeDVf3ZlLda6Oa_sST1TJHAfrF4UqiWUw0DpK1ZdKa7MDj5PjoBU
Message-ID: <CADVnQy=+j3-Nkjn7hHax=GUcPrfJiM2iYbwgPa38aAZgL1BuQw@mail.gmail.com>
Subject: Re: Re: [PATCH,net-next] tcp: Add TCP ROCCET congestion control module.
To: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Cc: Tim Fuechsel <t.fuechsel@gmx.de>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arxiv.org:url,acm.org:url]
X-Rspamd-Queue-Id: C17EE3FBC71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 7:23=E2=80=AFAM Lukas Prause
<lukas.prause@ikt.uni-hannover.de> wrote:
>
> Thanks for the very detailed review of our code.
> We will incorporate your comments regarding documentation and variable
> usage into a new version of our code.

Sounds good. Thank you.

> > Please reference figures in the paper and mention specific concrete
> > numerical examples of latency reductions to quantify these statements.
>
> Figures 5 and 6 show the performance of ROCCET in stationary and mobile
> scenarios (https://arxiv.org/pdf/2510.25281). In the analyzed scenario,
> we have observed a lower sRTT with ROCCET than with BBRv3 and CUBIC. The
> observed throughput was marginally lower than that of BBRv3, but still
> on a similar level. A detailed quantitative evaluation can be found in
> the paper in sections VI and VII.

In https://arxiv.org/pdf/2510.25281 zooming into the Figure 6 sRTT
box-and-whisker-plot seems to show that BBRv3 actually has a lower
median sRTT value than ROCCET. So that statement seems misleading?

I would recommend using numerical examples in the commit message to
quantify the gains from ROCCET and avoid potential issues from visual
interpretation of graphs.

> > Can you please elaborate on this statement here? AFAICT from figures 7
> > and 8 in https://arxiv.org/pdf/2510.25281 it seems ROCCET is
> > essentially starved by CUBIC when sharing a bottleneck with CUBIC when
> > the bottleneck has 2*BDP or more of buffering. AFAICT it sounds like
> > ROCCET does have "fairness issues when sharing a link with TCP CUBIC"?
>
> Our main use case is a connection where the bottleneck link is in the
> cellular network, where the bottleneck queue is typically not shared
> between flows. "Fairness" between flows is being implemented by the base
> station's scheduler. In this scenario, ROCCET achieves its objective to
> not "bloat" its own queue.
>
> We have performed additional fairness experiments in non-cellular
> networks (figures 7 and 8). Here we show that even when used in other
> types of networks, ROCCET does not cause harm (see
> https://dl.acm.org/doi/10.1145/3365609.3365855) to other congestion contr=
ol.

I do not see you objecting to my statement, "it seems ROCCET is
essentially starved by CUBIC when sharing a bottleneck with CUBIC when
the bottleneck has 2*BDP or more of buffering." So I guess you agree.

IMHO it's important to keep in mind that a congestion control that
starves in the presence of CUBIC may have limited deployment. This is
a key reason why Vegas was never deployed at scale.

> > Please specify what side effect or side effects ROCCET is claiming to
> > solve (presumably bufferbloat?).
> The side effect we observe in cellular networks is that, in particular,
> for loss-based congestion control, the cwnd often gets 'frozen' at a
> size that is too large for the BDP of the current link. This effect is
> caused by the TCP cwnd validation, which at some point stops increasing
> the cwnd because it assumes that the sender is application-limited.
> However, this often leads to a cwnd size that is too large for the link,
> but too small to cause a congestion event by overfilling the buffer. The
> result is a standing queue that causes permanently high RTTs. Figure 2
> in the paper (https://arxiv.org/pdf/2510.25281) shows the described
> behaviour for a single TCP CUBIC flow.

OK, so that sounds like you are describing the standard bufferbloat
problem. So you could replace the phrase "solves an unwanted side
effects of CUBIC=E2=80=99s implementation"  in your comment with something
like: "avoids the bufferbloat problems inherent in CUBIC."

> > Expressed in isolation like this, that sounds potentially dangerous.
> > Please mention what signal(s) ROCCET uses to exit slow start if it's
> > not using loss.
> >
> > In addition, from reading the code AFAICT the connection does use loss
> > to exit slow start (see my remarks below in this message). So AFAICT
> > this summary seems inaccurate, or at least misleading?
> You are right, the summary is misleading. In the code we submitted,
> there are three conditions for exiting slow start:
> The first one is packet loss (as you already mentioned, without a cwnd
> reduction) Second is if the srRTT calculated by ROCCET exceeds an upper
> bound and ACK rate, sampled in 100ms time intervals, differs by 10
> segments. The third one is when the growth of the cwnd is stopped by the
> TCP cwnd validation  (which considers the connection as
> application-limited).

OK, thanks for clarifying.

> > If no lower RTT is found for 10 seconds, the algorithm interpolates
> > the `min_rtt` upwards towards the current RTT.
> >
> > +  If the path is persistently congested (e.g., a large buffer is
> > constantly full), the `min_rtt` baseline will drift up.
> >
> > +  This makes the algorithm less sensitive to queueing delay over
> > time, potentially defeating the purpose of reducing bufferbloat in the
> > long run. Contrast this with BBR, which actively drains the queue
> > (using the ProbeRTT mechanism) to try to find the true physical
> > minimum RTT.
> >
> > Can you please add a comment explaining why the ROCCET algorithm takes
> > this approach, and how the algorithm expects to avoid queues that
> > ratchet ever higher?
> We added this functionality for the edge case of long-lived fat flows,
> which are experiencing routing changes, to detect a higher base RTT.
> Since this functionality is disabled by default and can also cause
> problems with min_RTT detection, we have decided to remove it.
> The measurement results in our paper have been obtained with this
> functionality disabled.

Again, thanks for clarifying.

> > Here, `cnt` is incremented by `1` on every call, regardless of the
> > `acked` value (number of packets ACKed in this event).
> You are right, we will change this.

Great. Thanks.

> > +  With the default `ack_rate_diff_ca` of `200`, this condition will
> > become true for $sum_cwnd * 100 / sum_acked >=3D 200$, i.e.
> > $num_acks_per_round * 100 >=3D 200$. So AFAICT we expect this condition
> > to be true if there are 2 or more ACKs in a round trip. This makes
> > `bw_limit_detect` effectively a no-op or always-on trigger rather than
> > a true detector of queue growth or bandwidth limits.
> The purpose of this part of the code was to detect an increasing queue
> by monitoring data sent and acknowledged in combination with an
> increasing sRTT over 5 RTT time intervals. In the steady state of a TCP
> connection, the sending rate of the TCP sender should be equal to the
> receiver's ack rate, due to TCP self-clocking. The idea behind this code
> was to check if the cwnd is still correlated to the sending rate. If
> this is not the case and we also observe increasing RTTs, we assume the
> TCP sender is filling a buffer. However, we have made a mistake when
> calculating sum_cwnd:
> We are accumulating the cwnd on each ack event, instead of each RTT,
> which, as you mentioned, would make more sense. Because this leads to
> the erroneous behaviour that you described, we will remove this part of
> the code for now until we have evaluated the intended implementation.

Sounds good. Thanks.

> > Did the experiments in the paper use the approach documented in the
> > paper, or the approach documented in this code? They are very
> > different, AFAICT.
> The experiments were performed using the submitted code. This means that
> the mentioned code snippet always evaluates to true, so that ROCCET only
> reacts to changes in latency, which is different from what we described
> in the paper.

Got it. Thanks.

> > Having a module parameter to ignore loss in this way makes it too easy
> > for users to cause excessive congestion. I would urge you to remove
> > that module parameter. Researchers can add that sort of mechanism in
> > their own code for research.
> That is true, we will remove this part of the implementation.

Sounds good.

Thanks!

neal

