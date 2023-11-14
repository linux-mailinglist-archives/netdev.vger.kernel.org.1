Return-Path: <netdev+bounces-47833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878F7EB7F9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CFC1F25C81
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0197D35F18;
	Tue, 14 Nov 2023 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="eB/0hjPw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB382FC34
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 20:39:49 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E2F7
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:39:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso9090976a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1699994385; x=1700599185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuVQebN5hxvIZX7atKh4d87IvO94zQMZO9flZQ6A/B0=;
        b=eB/0hjPwl0loS6mvx1RRaPT1Q00fAiwUpgObvab1mpA0DQzVZumJoMiFEX39D1/VPn
         9WJJrfV8AQBB+NS2RW/Zyfcugqyi55sJW0UYKmA7LE0xoXOLTIqTnsYf9PFXu6VNor6P
         E647+Q6JGiFkgsVt2oBUyCL63Dj8fVCF/46VWdreby7g9MAd4PERrEHwudM/+6C+6rHu
         Vop8QsNbVU+QPYrjSuAZ03XahZ7/XnjXCBGogcQ+IB57x197FX1mpsyAjcmR7VqtXQS4
         giFfeRhkKBpjtVln4JnUWylutG9aIXVpUYlUS+7UtReC7uOaAmSAt0FMxYYaSF985Xq4
         TtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699994385; x=1700599185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuVQebN5hxvIZX7atKh4d87IvO94zQMZO9flZQ6A/B0=;
        b=CAYAhoDxjcBpi4r5BRiGuvVMVNE/gYnr7FR4ijBXiPc8WAXX269ARNgSgBjY69/ewf
         P8san/rPHga0XhTSRT/f5cEOfIoIBt3ddqWtg3aJrBnLPdf86/8RFMbq53V9EGYLIw0z
         dwY3PFMWQ8ySLjGNE9CfA3uo7tUKT9003Fx3HFKOzbAyfK2RNffN+CmEdb67lZdJjMl2
         uj+NqaMWYNriZnu3S/ItdKmXtLDMlM5hTmRdabpr6M2vXIWwf5U6jB7QJ6zJfje9Qb/1
         uUcn1H2O308aXBQdzCNPMhBCpWrzG7hSCGdSQyZ9dupAThRg20xMg6tYkdkDfrk48yr1
         oyvw==
X-Gm-Message-State: AOJu0YwEz7EIggd1F+avIhUTl08jsyK8u2JZ3ME1ZSPSPGvLid4PLVdr
	T0l5b8QUcvmICwBYffiulHqvfWgkdp+0v9B3dd/zUTzCOKc36Jci+VQ=
X-Google-Smtp-Source: AGHT+IGmzhnBroSlAxKf7N8qbGsZx8t3AJl2XW3aRFDKhn0+MImAHNYyac754+Q38xVB7qph6pbDVjog64MUIIDwSjY=
X-Received: by 2002:a50:fb14:0:b0:53d:eca8:8775 with SMTP id
 d20-20020a50fb14000000b0053deca88775mr8145167edq.26.1699994385337; Tue, 14
 Nov 2023 12:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
 <CANn89iKhboBst+Jx2bjF6xvi1UALnxwC+pv-VFaL+82r_XQ9Hg@mail.gmail.com>
In-Reply-To: <CANn89iKhboBst+Jx2bjF6xvi1UALnxwC+pv-VFaL+82r_XQ9Hg@mail.gmail.com>
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Tue, 14 Nov 2023 15:39:09 -0500
Message-ID: <CAFYr1XMRLx_ZsJDxjZh5cv5Nx3gSWiiY76VZE0610gw284-Wcg@mail.gmail.com>
Subject: Re: Potential bug in linux TCP pacing implementation
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your response.

Yeah, I think for the currently deployed CCAs, the current pacing
implementation works fine.

I wanted to clarify, the issue is caused due to temporal change in
sk_pacing_rate and is independent of pkt sizes or network parameters
(bandwidth, rtt, etc.). If the sk_pacing_rate goes from r1=3D0.1 pkt per
ms (~1.2 Mbps for ~1500B MTU) to r2=3D10 pkts per ms (~120 Mbps), then
opportunity to send 99 pkts (=3D(r2/r1)-1) is missed. This is because
tcp_wstamp_ns was computed as =3D10ms using r1, even though
sk_pacing_rate changed to r2 (immediately after tcp_wstamp_ns
computation) and a pkt could have been sent at 0.1ms.

The ratio of the new and old rate matters, not the pkt sizes, or other
network params. Typical CCAs perhaps only change rate by ~2 times so
only 1 pkt (=3Dr2/r1-1 =3D 2-1) worth of sending opportunity is lost. This
is why I guess the issue has not been observed in practice.

Yeah I did see there is an option to specify "skb_mstamp_ns", that
might allow CCAs to enforce rates better. I don't know how easy or
difficult it would be for CCAs to set skb_mstamp_ns. Because CCAs may
not look at individual skbuffs and also given tcp_congestion_ops only
has callbacks on ACK events and not pkt send events. I guess BPFs are
to be used? (https://netdevconf.info//0x14/pub/papers/55/0x14-paper55-talk-=
paper.pdf)

Also, to clarify, the reason for the conscious choice is that the fix
would require more state in TCP socket? Or are there more reasons, any
pointers? I imagine, for the fix, the state would increase by ~2-3 u64
values, e.g., credits in units of bytes, the time the credits was
updated, and the time the credits expire). Is this too much? Or will
the fix require more state than this?


On Tue, Nov 14, 2023 at 2:09=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 14, 2023 at 7:59=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.ed=
u> wrote:
> >
> > Hi Eric,
> >
> > Sorry for the duplicate email. I am sending again as I got an
> > automated response from netdev@vger.kernel.org that my email was
> > rejected because of using HTML formatting. I have resent a plain text
> > version. Hopefully this email goes through.
> >
> > I saw that you are the maintainer for the linux networking TCP stack
> > (https://www.kernel.org/doc/linux/MAINTAINERS), and wanted to report a
> > potential bug. Please let me know if I should be reaching out to
> > someone else or using some other method to report.
> >
> > Based on my understanding there is a bug in the kernel's pacing
> > implementation. It does not faithfully follow the pacing rate set by
> > the congestion control algorithm (CCA).
> >
> > Description:
> > For enforcing pacing, I think the kernel computes "tcp_wstamp_ns" or
> > the time to deliver the next packet. This computation is only done
> > after transmission of packets "tcp_update_skb_after_send" in
> > "net/ipv4/tcp_output.c". However, the rate, i.e., "sk_pacing_rate" can
> > be updated when packets are received (e.g., when the CCA gets a
> > "rate_sample" for an ACK). As a result if the rate is changed by the
> > CCA frequently, then the kernel uses a stale pacing value.
> >
> > Example:
> > For a concrete example, say the pacing rate is 1 pkt per second at
> > t=3D0, and a packet was just transmitted at t=3D0, and the tcp_wstamp_n=
s
> > is then set to  t=3D1 sec. Now say an ACK arrived at t=3D1us and caused
> > the CCA to update rate to 100 pkts per second. The next packet could
> > then be sent at 1us + 0.01s. But since tcp_wstamp_ns is set to 1 sec.
> > So roughly 100 pkts worth of transmission opportunity is lost.
> >
> > Thoughts:
> > I guess the goal of the kernel pacing is to enforce an upper bound on
> > transmission rate (or lower bound on inter-send time), rather than
> > follow the "sk_pacing_rate" as a transmission rate directly. In that
> > sense it is not a bug, i.e., the time between sends is never shorter
> > than inverse sk_pacing_rate. But if sk_pacing_rate is changed
> > frequently by large enough magnitudes, the time between sends can be
> > much longer than the inverse pacing rate. Due to not incorporating all
> > updates to "sk_pacing_rate", the kernel is very conservative and
> > misses many send opportunities.
> >
> > Why this matters:
> > I was implementing a rate based CCA that does not use cwnd at all.
> > There were cases when I had to restrict inflight and would temporarily
> > set sk_pacing_rate close to zero. When I reset the sk_pacing_rate, the
> > kernel does not start using this rate for a long time as it has cached
> > the time to next send using the "close to zero" rate. Rate based CCAs
> > are more robust to jitter in the network. To me it seems useful to
> > actually use pacing rate as transmission rate instead of just an upper
> > bound on transmission rate. Fundamentally by setting a rate, a CCA can
> > implement any tx behavior, whereas cwnd limits the possible behaviors.
> > Even if folks disagree with this and want to interpret pacing rate as
> > an upper bound on tx rate rather than tx rate directly, I think the
> > enforcement can still be modified to avoid this bug and follow
> > sk_pacing_rate more closely.
> >
> > Potential fix:
> > // Update credit whenever (1) sk_pacing_rate is changed, and (2)
> > before checking if transmission is allowed by pacing.
> > credit_in_bytes =3D last_sk_pacing_rate * (now - last_credit_update)
> > last_credit_update =3D now
> > last_sk_pacing_rate =3D sk_pacing_rate
> > // The idea is that last_sk_pacing_rate was set by the CCA for the
> > time interval [last_credit_update, now). And we integrate (sum up)
> > this rate over the interval to computing credits.
> > // I think this is also robust to OS jitter as credits increase even
> > for any intervals missed due to scheduling delays.
> >
> > // To check if it is ok to send pkt due to pacing, one can just check
> > if (sent_till_now + pkt_size <=3D credit_in_bytes)
> >
> > Please let me know if you have additional thoughts/feedback.
>
> This was a conscious choice really. More state in TCP socket (or in
> FQ) means higher costs.
>
> For conventional CC, difference between pacing P1 and P2, and usual
> packet sizes (typically 1ms of airtime)
> make the difference pretty small in practice.
>
> Also, pacing is offloaded (either in FQ qdisc, or in timer wheel on
> some NIC hardware).
>
> With EDT  model, you probably can implement whatever schem you prefer
> in your CC module, storing extra state in the CC private state.

