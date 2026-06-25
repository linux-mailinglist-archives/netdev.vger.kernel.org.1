Return-Path: <netdev+bounces-301983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSN5IJ89PWrrzwgAu9opvQ
	(envelope-from <netdev+bounces-301983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5516C6BC8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="QZvSV4k/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7960F30214FA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C038B7BD;
	Thu, 25 Jun 2026 14:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24832BF44
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:34:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398060; cv=pass; b=PklsC2oFYPxo5cfCBJShumEbWPCU0JfNh96iX433OT2EnkzNXyBeOE7vRj/N7fE95CYRWODuBK6CTyOE2DNkMtsBAHKNPb+HhVywXseMl4ny/LwzHh9LuMhQoxoOqg3F3/A8yk9tz7RkEcHqVnKOD7asiC+QA5AFxS2d21/ZUkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398060; c=relaxed/simple;
	bh=WsA7OPYzkgtA14PGketL7yxso3PH42bxWNj+EXE3DDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP7r1PLFbxLoP4X6ExD7ZE2kbN8bV8B9pzo7WsqKS6kMuVfLslPqkOMpR7WhmKqSoPHK7Kpl0RfnpNwnHa0r9vByYkqVtaY0E4+v0bGYsAAjM1cuoliJSiaDYfEWO2naX+FE38LBluY8uIrSSLpXMGLBS5yHCKzdi2aockNI/Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZvSV4k/; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51a14efe25fso24083331cf.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782398058; cv=none;
        d=google.com; s=arc-20260327;
        b=VC5tmQ+JXbpVaeGNCTX7wxIPqohIIstjtW/X+QHRY2HxnR2MbFuRNSvBOhFWcRUsBs
         Rhtb9Qy58T188Mz9fqWmRsOnN1PxFoLYm2/NIgYi2mrkUgJ6WCztVNooQi9uY83A0fqk
         88air3y2befA+6/RRiYiS7TKcbIZDUu8+HyKp9NG4HsH8YJB3geO3dlTnzyWLAAHZzPO
         IE9sTaW8gEIHP8eYJEi+Tl3IghI+iG+FMOJRkWk8lCd1XPuab/77pXcQoOMMi4ALfBr4
         slfXv1ez/Q9QiO/kQIo+dehEKGXd5XaIwJFzrN7MZoR5Um36foGncPzhsEo0eiPRGbcD
         1RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FrFjHtA0chqKSe+nCS9g/LRt3dP2mFp715gwQj5DXHE=;
        fh=l5vrOnIohiU9WIN1ItA+iMcrcNajuP9W5cTdF9Rtgw8=;
        b=LDhKqcd+XUuLe/86T0pxdMTvUKvzOYFQlGVt2GT7h41YHCy6DCZCBREOlgzaTifWkW
         bBbI941WGvbH9tLI7xIatU1SNU1edywCMBDB1igIz1fpFqEwgfrOzZn/Ai/zNX2lluRP
         UZrh31+cMKudsHWr81v0xePw1g2bCMT7rrdNSO5IoHdalZl/2opQkdRho68vaSmrkMnT
         9933IWlxhrZi1mifwoUrIUarfL9kGzc58IAb0mB9W+oyTFcwr8uHKuxIhbHDyiKKqBKP
         B9DUo0mbh/ceP3iMItSF9jl+r8oo/l0yTsjCXWpT8thFeNko2omcA9ckrJdjGwHoorXg
         voZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782398058; x=1783002858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrFjHtA0chqKSe+nCS9g/LRt3dP2mFp715gwQj5DXHE=;
        b=QZvSV4k/BeBq69Q1VmZGxib9topOklLpNtKAcv+QKhY8yS12ZOUzpxJdDtHcHPRFq4
         iypR4esGNHVHTXc2HWZnqI8ToXmJcZoPrim4JDMY0eTKFLbfxnI4UYOp7wIjk6hSrrBY
         Ev0vl8RL4qFvApKsqF5Zqm01iMetMsO1Hpcfa8cwhYFV715i2+8mBIGYoJ01EVS1CD1Z
         08E5e1mBKH7anQC86FiQwXZHjYYjGBaL1h2dxuDrpE+A3GogPNqwwlfSiWN43rz6HyZO
         bTjVGdpK5bcb1hHAVVcvFujgdP04nOqrlz08URn4R+d+7oljFnh4GeQjrHlKhj6tf46Y
         mm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782398058; x=1783002858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrFjHtA0chqKSe+nCS9g/LRt3dP2mFp715gwQj5DXHE=;
        b=GE13+SMTvH0n3CXlCP3/JLExMK0W42oNJWvAxUJcZXA6RI9JzhyoVkMldwHN57S/Cd
         z95I8vK0E2T/B2NRALSrFjuLxlXji8Nr8ELn2bnqUXUsry89dRI382HCqchpXV0MNIhz
         iDNWq4f3fYnjrOyhlwHXpJG7Wtt+8CF1wusD0a1U9VM4VoZM20kaAZu/wfxRsRGMhJEg
         yjU3Uztuo2kPZTbttQw2+amM3DmMHdUrx5D7uCOj+B4WfWmsH8ugKHPTwDyPeGszIFW4
         o93O9AKHRIEbLXA1hLjib+zGV+0ykuLggiFIZ0650Vh/arVOOhiH2ITcQ1paSFprCZFm
         CZBg==
X-Forwarded-Encrypted: i=1; AFNElJ+c9+pcstrjiZ8+gyybsceZZjbJygFrFFWP0ITXw8wwCZz6JsXRO19otQ2wkrHHr8L0XWEGlcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudeH90gi+r2FBRBJ5ZuM+wZ8jrrm3fxkYfgRYeZr4hxk9HvHX
	1+xeotf0Isfj+Ca0EH3jGlgbbItw2Is1sW7/GMdX/s1mI4WHjMSyI76juqOQtkx5im5biKyoHLX
	8FCdKHDK69GmLg/915pdsNobgg3XDD64zaup0S60m
X-Gm-Gg: AfdE7clSp69KxsZ7KtoMMRn8IWzONMWCItYe2j9DE1hoWuTH0MyU5+Sr0ZoxwCOX0X5
	+cBVnDGNC6e6v8C5g7H522dEvmhK6Z5AB8KEa8P50NuyfOb7BjNrZQW4MMnRp1iz9H+X1l0Tchp
	jcKcuPlR3nzGhmRgtVi0u/R2Gcp1dDLt9E4DhbYKIrGXtrXnTnOc2JfpQKnVa8EfTrE/6oAhNdN
	Hv+vzlcsT4FuTGv/CvxekpRhPC7vjCD3asx8J8/G3M+/xBmeJWdet0ew54K3eL00yzn9VKa5J+Y
	se/gMQsX1nXYlngMkiMUtjUAcU1BxX9RJNsiUCQCimqiqXMk5lnLck4hjUf8QX9PQV9GgwxtzFF
	qIyfjww==
X-Received: by 2002:a05:622a:118d:b0:517:75d8:b956 with SMTP id
 d75a77b69052e-51a72a55f94mr35042641cf.40.1782398057675; Thu, 25 Jun 2026
 07:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8a3b4eb-b75d-4cbd-ac1c-9b0a606a932a@yeah.net>
 <g7DvITFWSiW9AoI49uyghw@linux.dev> <585bc5ca-8348-49e6-bbce-acbf6b99d912@yeah.net>
In-Reply-To: <585bc5ca-8348-49e6-bbce-acbf6b99d912@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jun 2026 07:34:06 -0700
X-Gm-Features: AVVi8CdMK9ifFlVShql3gXoH9QgqZUCoEjyMoW8L33KggkXHJo_TDbTsPiEr7Gg
Message-ID: <CANn89iJkmTwbHkTJ0LgHvhF8PN3zkXmK7A8bydXh-B7yE4K6Rw@mail.gmail.com>
Subject: Re: [BUG] TCP connection deadlock under simultaneous bidirectional
 ICSK_ACK_NOMEM (OOM)
To: xietangxin <xietangxin@yeah.net>
Cc: Menglong Dong <menglong.dong@linux.dev>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jmaloy@redhat.com, menglong8.dong@gmail.com, 
	kuniyu@google.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@yeah.net,m:menglong.dong@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:jmaloy@redhat.com,m:menglong8.dong@gmail.com,m:kuniyu@google.com,m:horms@kernel.org,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stable@vger.kernel.org,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yeah.net];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-301983-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE5516C6BC8

On Thu, Jun 25, 2026 at 6:22=E2=80=AFAM xietangxin <xietangxin@yeah.net> wr=
ote:
>
>
>
> On 6/8/2026 7:55 PM, Menglong Dong wrote:
> > On 2026/6/4 16:22 xietangxin <xietangxin@yeah.net> write:
> >> Hi all,
> >>
> >> We have observed a TCP connection deadlock on stable 6.6 under heavy s=
tress testing.
> >>
> >> 1.Both Peer A and Peer B enter the ICSK_ACK_NOMEM branch in tcp_select=
_window().
> >> After commit 8c670bdfa58e ("tcp: correct handling of extreme memory sq=
ueeze"),
> >> Both peers freeze their rcv_nxt and set rcv_wnd =3D 0.
> >>
> >> 2.Prior to freezing, both sides had already sent out flight data.
> >> Since both sides are dropping incoming data packets due to OOM, rcv_nx=
t stops advancing,
> >> but the peer's seq of subsequent packets continues to grow.
> >>
> >> 3.When Peer A receives Peer B's Zero Window ACK,
> >> the packet's seq is far ahead of Peer A's frozen rcv_nxt.
> >> Both peers drop each other's packet, also no Zero Window Probes are tr=
iggered
> >> because snd_wnd is never updated to 0.
> >>
> >
> > Hi,
> >
> > The problem you addressed is already fixed in this commit:
> > 0e24d17bd966 ("tcp: implement RFC 7323 window retraction receiver requi=
rements"),
> > which hasn't been picked to the 6.6 branch.
> >
> > That patch doesn't have the Fix tag, so I'm not sure if it will be pick=
ed
> > to the 6.6 branch. Just CC the linux-stable :)
> >
> > Thanks!
> > Menglong Dong
> >
> >>
> >> Simplified Packet Trace:
> >>
> >> Assume Peer A's rcv_nxt =3D 1000, and Peer B's rcv_nxt =3D 5000 initia=
lly.
> >>
> >> Time  Dir      Type        Seq   Ack   Win  Len  Status
> >> ----------------------------------------------------------------------=
--
> >> T1:   B -> A   [PSH, ACK]  1000  5000  3000 100  (A hits OOM, rcv_nxt=
=3D1000)
> >> T2:   B -> A   [ACK]       1100  5000  3000 200  (Dropped due to A's O=
OM)
> >> T3:   B -> A   [PSH, ACK]  1300  5000  3000 200  (Dropped due to A's O=
OM)
> >>
> >> T4:   A -> B   [PSH, ACK]  5000  1000  3000 100  (B hits OOM, rcv_nxt=
=3D5000)
> >> T5:   A -> B   [ACK]       5100  1000  3000 200  (Dropped due to B's O=
OM)
> >> T6:   A -> B   [PSH, ACK]  5300  1000  3000 200  (Dropped due to B's O=
OM)
> >>
> >> -- Both sides are now in OOM. B's Seq is 1500; A's Seq is 5500 --
> >>
> >> T7:   B -> A   [ZeroWin]   1500  5000  0    0    (Dropped: Seq 1500 !=
=3D 1000)
> >> T8:   A -> B   [ZeroWin]   5500  1000  0    0    (Dropped: Seq 5500 !=
=3D 5000)
> >> T9:   A -> B   [WinUpdate] 5500  1000  20   0    (Dropped: Seq 5500 !=
=3D 5000)
> >>
> >> Should we relax the sequence check in tcp_sequence() for zero window A=
CK?
> >>
> >> Any feedback or guidance would be greatly appreciated.
> >>
> >> --
> >> Best regards,
> >> Tangxin Xie
> >>
> >>
> >>
> >
> >
> >
>
> Hi,
>
> We observed a throughput regression (dropping from ~1GB/s to 100MB/s)
> in our test environment after commit 0e24d17bd966
> ("tcp: implement RFC 7323 window retraction receiver requirements").
>

Could you provide instructions on how you/we can deterministically
reproduce this issue?

> When the rcv_buf reaches the pressure triggers tcp_clamp_window().
> then rcv_ssthresh is strictly capped to 2 * advmss.
> Subsequently, even after the user completely consumes the data and releas=
es
> a massive amount of free_space, tcp_select_window() is still heavily
> suppressed by the clamped rcv_ssthresh. As a result, the receiver adverti=
ses
> an extremely small window (Win=3D23) to the peer.
>
> The sender cannot transmit any new data segments, until the sender's RTO =
timer
> expires and triggers a slow-start recovery. This 200ms silence window sla=
shes
> our bandwidth by 90%.
>
>
> No.   Time           Source       Destination  Info
> -------------------------------------------------------------------------=
----------------------
> 1045  08:16:06.8005  192.168.1.9  192.168.1.10  [TCP ZeroWindow] 57334 ->=
 6666 [PSH, ACK] Win=3D0
> 1052  08:16:06.8013  192.168.1.9  192.168.1.10  [TCP Window Update] 57334=
 -> 6666 [ACK] Win=3D23
> 1055  08:16:06.8036  192.168.1.10  192.168.1.9  6666 -> 57334 [ACK] Seq=
=3D2999704568 Ack=3D2416286095
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D 200ms  SILENCE (RTO WAITING) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1088  08:16:07.0056  192.168.1.10  192.168.1.9  [TCP Retransmission] 6666=
 -> 57334 Len=3D1448
> 1090  08:16:07.0060  192.168.1.10  192.168.1.9  [TCP Retransmission] Len=
=3D2896
>
> --
> Best regards,
> Tangxin Xie
>

