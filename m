Return-Path: <netdev+bounces-289198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHMtK8GfC2qkKAUAu9opvQ
	(envelope-from <netdev+bounces-289198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:24:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4D574F4C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252583039C48
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177AB3176EF;
	Mon, 18 May 2026 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h358LR2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF598287E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146684; cv=pass; b=h2sVXFX3rIykcxMlgK/k4pMLHd4QZ5xMoLKW9P5TJbHFCHuDORQRBBSensudpcO1aTAxrw7V0i1SxCfd0LO7EqQpjbdD0BrUULTfRDqPsp6JzD1D3PidwEW5AIyml+NzTMYL0oSMw0Kl/QGSZNyRPWNlqSQIijt1BrUTDerKncY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146684; c=relaxed/simple;
	bh=VipnUx2jbHvuaNIPNdTFNiq04JRHrsVUhe4G9NZFzfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYNJbi3RNmZUKSviiG36H0fn8pPu5BVg64x7VLpej7szXx0cst1kholdXN6p90R1FRBGvql+QpsdHO3SHrYrj61Op1J3U25KKrYhIRc/YPrbzyE5QttUM2FlONwl0yht+078vnIxB+TahgQ1tkbRhNuN2B1dwMustZyurKzugDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h358LR2F; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa0862dda1so3915062e87.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146681; cv=none;
        d=google.com; s=arc-20240605;
        b=HNFZxpeGijPqRUtyEV+3jNiz/iZz+zUepOpD2PR7ISUGa/W5a/kGm0ckP3CQVvmyor
         8BmJCG/f9+ZyWu6vYEllsWUcD6uBvmUxHEcTfn653eFAotu8ab0dQJIo7IiqOUjkywnK
         TIEvQAM5TcHoevEB+NfM52ee2NvdMqYKK8DP2KqWPaN3jzDnSmMfqo3M3ZVOxbgv0/fz
         5M9Xd2jJbNBh3evYhxiNQ/Rbl2jO0iwbBTH2qdvy/d2mC42zMbuAxz39fNqH/uEGLcyo
         NlfN9sZpih3M6ToNUe3sPQjM0lXNPGcGqEr1Jw+TqH8T4SP8/kYL0W+hBkAxzFwW6GH5
         mjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        fh=lERJ3CTj0sgOQMmhAhepRSrszG/V0hMev/d/Fr0Zvp8=;
        b=TP8DLstKqXRT2lKvaq2ZFxGhxogfqt58V2k+UcnYQRC1DYuN/JDAudOXxVWyKO57UT
         wn67fa5cZ1osFrVAF3gFV+4mXB/gmCw2HfjRROWPcIxs62yllbBmbYb2xcoOdocRmhC8
         lFV04OxILBXZ0HgL8aCF3zVQNBfCDvGuWH2VVfLfMqQes6ONzxn1GVNkwPwwzOPcDMoZ
         44IG/U1S58ZB/u9S0zJ1bOT3fM7S27bSq+BdacJasZQL6MqLITmnRWjFflxYbCBV7Kdq
         q0nCxNtf0YrHM/t5+AVjzaScB6iuO7hE1sxSZEeGMIw50RPdbwUsbZj/DeL3PAOdnMkY
         2+FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146681; x=1779751481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        b=h358LR2F8RmXNFEEBwBB1Vuc0F7qHtOp2XK6B9WNBUtK4ToDKJhaRW+jfnFJbMvsqV
         aMPC9ws6p0QBoJLO5dGwMHY7a4n/Vt49FNu619Xd2JYsdSHoA7m8qm2h+5lD48JY19hE
         zZ1kmtyHAQuOgMPuPIDP912iUUuWHoRxIM+ZSabKMbqPYFADGaDKZvrG/UvgQlxqR1Lm
         KHCL4cZMarpzoDg4kOMHFyH1brK9CWqLpvfaXemmPI5r7YEpshtxdtBmQjFmplrtAAoZ
         g4Vr38cLr5HkVRnJxCFzdJX3mTHnVhMRzFft7URD1E5O2cWa9VtRSZdfhzCvVMw7j60G
         tNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146681; x=1779751481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeHXD4ikgoMy/aJKrVC9XPIi5iwc8fhLQ8mqvzdVSo8=;
        b=HScolZo71YnMz0eBTvi1unRutTJ+6sqS7xUZqZ3IInH/QsButM2xfB1Vx+Cp+T+ke/
         NcWYnqfdo6QV5gJ/8VftcYFCmWCugaupo35X7r4eCHXBbdhlST8DarM5qgWzhcJe+77y
         XXRfEMu9H1GPp0EuSNdORToZjgBL3UdjcpDSEsdeepiLRupi4gztDHCA9m9wbSQuOO6G
         9achTPvuBqhYpzeawnNXJ8QQ8TgUKV0OQkQefOClYBw7nc/QLLKnCoTJtyBBcdY9tZW6
         jh60nEjRoWy2y+aVlqgx7uzF7nAyDi7MO4xCjjJkFi6BUx2xvjxTkLfbPMinoivwzY6q
         DD9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+c3jMqez/5cshVILN1ieWPfHIoZSxnTW1YR/IknEoefjgRPlB9qjEVN3WyR6OJOp5Rxr2CGnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKmYF4QalPGQkmJ90puqH/GjbQwWduaLc2pK1znBfCfMVO8mx
	EfHdxCz+LvjQiHKhRg18sa1CaGtMjluVp72CQLz/ySZyHZmjxNHlrz14UqJkmZz8qTQc/j89O2V
	QMDh6lcC5CBarQwNCquUwRvoPXlZHEu8=
X-Gm-Gg: Acq92OE2AksHGc4eQU/cP8pPdOlfNFKeFjWVo14bktGD3z2tU++xzKh8eIyO3bVCm2a
	1xNbN+F2x8Yq8x/PKFCPXBcxhCOesz8f3ycjOHKQDcLkFUavOby8CHwvODgfZD7YYNYHipRPufr
	LO2fpYtEew8c7128NcmF2U+yb5YoamY1BjIjVEWVSDoIU7HfFYEXliJJ5wZ/T3ZTHQY6wPOgyLh
	3RM2EGo+b0LA06LeH2NzUhKZneOkwlbsXOqq3UV7uosqY+XyVlaZSqOK4WVN4mlv7scUApQZQ91
	dsDGK4jNxGZWS6Y/Y/8CerrYWcL/XRYBNTQV7MY=
X-Received: by 2002:a05:6512:1595:b0:5a8:97d7:8c30 with SMTP id
 2adb3069b0e04-5aa0e774304mr4904749e87.40.1779146681318; Mon, 18 May 2026
 16:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
 <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org> <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 07:24:02 +0800
X-Gm-Features: AVHnY4LVZc-R1yRP9brSbuATWXMCmOVNYnH1xgIPBcAKlQwo6Wb-k_4Gwm8CFHk
Message-ID: <CAL+tcoA_VBcXu_2zVXFvsWF7+U=-TZf7bCz0KzNpN=p=82tB=w@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,kau.se,toke.dk,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,tencent.com:email,lpc.events:url,kau.se:email,doi.org:url,diva-portal.org:url]
X-Rspamd-Queue-Id: 26B4D574F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 7:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, May 19, 2026 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >
> >
> >
> > On 18/05/2026 15.53, Jason Xing wrote:
> > > On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk@=
kernel.org> wrote:
> > >>
> > >>
> > >>
> > >> On 18/05/2026 10.23, Jason Xing wrote:
> > >>> From: Jason Xing <kernelxing@tencent.com>
> > >>>
> > >>> Add two if statements to accurately isolate bpf timestamping and so
> > >>> timestamping. They can work respectively.
> > >>>
> > >>> As to so_timestamping, only add a loose condition via report flags
> > >>> to avoid duplicate strict checks that is done in tcp_recv_timestamp=
()
> > >>> and performance impact. If the loose condition is hit,
> > >>> tcp_recv_timestamp() is able to handle the exact case and doesn't
> > >>> hamper the existing timestamping feature.
> > >>>
> > >>> Make it work in TCP protocol.
> > >>>
> > >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >>> ---
> > >>>    net/ipv4/tcp.c | 14 ++++++++++++--
> > >>>    1 file changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > >>> index 21ece4c71612..64c69bb3578a 100644
> > >>> --- a/net/ipv4/tcp.c
> > >>> +++ b/net/ipv4/tcp.c
> > >>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len, int flags)
> > >>>        release_sock(sk);
> > >>>
> > >>>        if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > >>> -             if (cmsg_flags & TCP_CMSG_TS)
> > >>> -                     tcp_recv_timestamp(msg, sk, &tss);
> > >>> +             if (cmsg_flags & TCP_CMSG_TS) {
> > >>> +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > >>> +
> > >>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > >>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIME=
STAMPING))
> > >>> +                             bpf_skops_rx_timestamping(sk, &tss,
> > >>> +                                                       BPF_SOCK_OP=
S_TSTAMP_RCV_CB);
> > >>
> > >> Does this mean I can enable timestamp reading per cgroup?
> > >
> > > Yes, I think so, but I didn't try. One of the natures of sockopt
> > > feature is supporting cgroup attach.
> > > cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
> > > something that you're looking for.
> > >
> >
> > Sound good
> >
> > > IIUC, you can attach the prog onto the cgroup where all the sockets
> > > are set using the bpf timestamping function. So the current impl is
> > > cleaner and has better isolation (to filter out those unmatched
> > > flows).
> > >
> > >>
> > >> In Simon's netstacklat[1] tool we are forced process all RX timestam=
p
> > >> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2=
] on
> > >> the cgroup IDs that we are interested in (which is a significant
> > >> overhead, as this is deployed at Cloudflare production scale).
> > >
> > > I can feel the pain when filtering in this kind of relatively hot
> > > path, which is what I'm trying to avoid internally. What I've done in
> > > production (to cover those old kernels) is to just let the kernel
> > > print the information, that's it, and there is an agent continuously
> > > gathering the data, doing the match and computing latency. But it's
> > > overall complicated.
> > >
> >
> > I hope you don't mean your internal/old approach was using printk and
> > then analyzing this data.
>
> Of course not :)
>
> The internal approach is to cover the old kernels but doesn't mean the
> approach is old :P
>
> Instead, the internal kernel module is super efficient and I'm trying
> to ship bpf with such an ability. The fact is we've already deployed
> in production: 7x24 running, zero sampling.
>
> Please see page 24 where there is a brief introduction on how to deal
> with the log part:
> https://lpc.events/event/19/contributions/2055/#preview:3846
> I believe this is the promising direction (ring buffer + lightweight
> kernel + heavy agent) we're taking.
>
> The headache part is that I need to provide an agent written in BPF to
> do the heavy process.
>
> >
> > > Many thanks here, I'm always interested in hearing more useful and
> > > real requirements and fancy ideas on how to monitor the latency :) No=
w
> >
> > Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on ho=
w
> > to monitor the latency.
> > The netstacklat tool is part of Simon's PhD thesis:
> > - https://doi.org/10.59217/qklv6836
> >
> > And we even gotten a paper accepted on netstacklat:
> > -
> > https://kau.diva-portal.org/smash/record.jsf?pid=3Ddiva2%3A2034009&dswi=
d=3D3032
>
> Sorry, I cannot access this link. Could you give me the title of this pap=
er?

Waiting at the Front Door - Continuous Monitoring of Latency in the
Host Network Stack

Oh, I guess it hasn't been officially published right? This is the
reason why I have no way to know the content.

Thanks,
Jason

>
> >
> >
> > > I'm still struggling to port the internal functions to bpf
> > > timestamping.
> > >
> >
> > Good luck, feel free to get inspired by our netstacklat tool.
> > Key point is to let BPF store latency histograms and then let userspace
> > periodically consume these - as heatmaps.
>
> Thanks. I'll dig deeper into it.
>
> >
> > We are proposing to add 'netstacklat' as a new libbpf-tools utility
> > - https://github.com/iovisor/bcc/issues/5510
>
> Great!
>
> Thanks,
> Jason
>
> >
> >
> > >>
> > >>
> > >> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstackla=
t
> > >>
> > >> [2]
> > >> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/ne=
tstacklat.bpf.c#L484-L488
> > >>
> > >>
> > >>> +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > >>> +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> > >>> +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> > >>> +                             tcp_recv_timestamp(msg, sk, &tss);
> > >>> +             }
> > >>>                if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) =
{
> > >>>                        msg->msg_inq =3D tcp_inq_hint(sk);
> > >>>                        if (cmsg_flags & TCP_CMSG_INQ)
> > >>
> >

