Return-Path: <netdev+bounces-289194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F3m3E9ydC2p4KAUAu9opvQ
	(envelope-from <netdev+bounces-289194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B11574EBA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F5C30137AB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077CC2BDC0E;
	Mon, 18 May 2026 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFhafiue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA59275B1A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146200; cv=pass; b=PqMEabEVOPFyIKq9+iqJlA4BhueqkJqAETp1NoImnPfMQ73j00CWYEmG8ZJlr2GvLcfGt82NwgWqlWUCoc73MFC6gQ+Zh17DgI8oiBnY3GHHE4emo45iTe7qLuWHqItednoTwzh6ckjuNFUpDbOuICcNvDVFSN83scxR9HIOIKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146200; c=relaxed/simple;
	bh=pAlmgGRCoHZmXItszyHV9jin9BNwDetgzhFJEojDrBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW3ji2DAX1GX/hdw0mhLkz4uE2Ix9zUHIKEkvX5bKkaSImmDdSHHQuQ+tWEsU7+BF9buCb+A46dGdfgqZKNMgCcjFJhiVq1uxAWhsxhNYl85S1AKjVd4EQbqfgNhPrgtgyhzSOFweRJNLHx8bsuZdg3R915SK6EZQgbxZ9hRwzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFhafiue; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8704dc3a8so3185901e87.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146197; cv=none;
        d=google.com; s=arc-20240605;
        b=iVEK0BCXDhJZltrekEZROhMp7eJv8kHU9vt1hN/Eh253MXqXznQvKhj0ZVtXcTriBc
         n6aPO1R6Q1LGLUMODO8VToaWFC7fdkNO6aZh3r4AJNT3ECxjBC/KP800qhqZKKvQyJ1V
         0HsK98wIS3JL6sKJCPzMUGl90p/sSIyh/BDbeEs7EJ1Y7HGhiBLOxISrCShOD2BkSBMM
         2313ZRL6akttliKmlXZTj68ViEBzmNwcxitMiHfSp1+I7jkYoaP0vclgtOIG5vzTRSs1
         RToF6hF0lg0Md1EAOCzDbmZrOO8QuE6SHSBsqlOvlXQmREZYOpPKoDVQxogzVa3Jdq90
         EKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+LjRKZoIJM+5rlXYyW5V5JRhB7f5Coet8hAv1hoUCmw=;
        fh=y2rgdrFO9salx5rlHa+j23rDr7N51SHWC/t1bWgMQwA=;
        b=ARtPL2/eEWp2x6QrpNmNvTqbxkllJJBNJAitECFtx+yFfydwY1sqNV0zYPZx98PVqa
         M9Jxkqrzo6Eb+mk1GCpYo7d729GukOCicdkagUWWU3jKGAZM/ubupJvve/tBMMSq9GVu
         hxZaRwixmzOt4BVeLgaomUHOqhZIzo7rQ/Tu42Pg8wjprztE2QZkwW4A1yzAJL/lc6Xg
         T3iVm6Xz4Mj3QU3Mgd4CB9KA9Z0mlpls7x3ZZKOfNWuMtoymQVDQnHBlUDDIMQBZJfcZ
         tSbH6zVNhHudzh/XRIVLGLANHeWn2KC/24uBMZBR5D7twwXD0rAz6EJkF4hIF6bAOOwT
         mhcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146197; x=1779750997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LjRKZoIJM+5rlXYyW5V5JRhB7f5Coet8hAv1hoUCmw=;
        b=rFhafiueYjyj93kYDcYHTm35jqmdb/HSQHn1dnDHH3aZ2/PLszjr0LAtk9gP25whHk
         2g2gM4RhH2qrtWAEFsAgbiK6Qp6hRM39y8jZAwb5cvvMSu/a22GVeh6Y4AxUFNRwAkuf
         JscegiFrH9RPabai+q09ym8akfiwZm44WjJWxCzmjqWZjbcpT/uC5wse5Q55TbxTxARv
         h6JJzsio0sXtmGKHDFP/702bR+91xb8EqarbSi+ZqQqS4/Fjeg3/Qk1iNTba+cm+FrCc
         iPYu/M3lsKFVaYAL7WpYmYm8zxVj85DR5AiV/bnHfdpEeOYP8uMfu7oNK8yTz5zzGD8o
         OBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146197; x=1779750997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LjRKZoIJM+5rlXYyW5V5JRhB7f5Coet8hAv1hoUCmw=;
        b=gqpOXB3LEqRLLdoNMZa76P7ibuW5xRf+pViLMDOECltsenJDkWyTnqMePLSKVCiXY2
         jw6hBp6CbRJkxRJ34uCOA0Pv2/rybQF3ETTjuSXf7ao0iHKOEIxCzs51mvGb8wycjHri
         ALQ1BU32lkJYuDzOYFeUauCE8zG8xSbL9xJvLE2YRMwbs1nf8sarqSU38lQJbPAFVV5q
         56/7GPb1dfTVpcq0xMVjBflFD5Wl2ybMzR66EhuFqqq/KRIkfFIRiAqNhAFsoVJzPF0b
         7HJIX4uf5IoMGzLu0cc6Jgt3m9vn72SW6F9ma43UVPK9T2bRe+7xzjNWJ/EbYQ1heJ0c
         6GVA==
X-Forwarded-Encrypted: i=1; AFNElJ+hxZecT7bAZBMQvDzSCEBHZrOfkuChSlQrWOIeyGqJXYHSQJYzVEoGNugnJsVUMw4einU38xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7BZ9nMTUOAurOwbW66eZiB7LUSQPXb9y7PE+fye74lZdh88g
	jSpiDoJGNUux9b/fJsT9uynVGT3ytZZaXPr/LH1+5qBRO0Ff5LDdxxPvzZxnw3Nuo51oW1HPvQI
	Xl0nkqPAg6Noy7BnJbW1peWtmVkBN9Sc=
X-Gm-Gg: Acq92OFd3OuWbsXDNUeFpZrSeT7uVz6ado3kF7ELa0SVFL75RIAGl4CCeHZOtaEDqRl
	7sLRMHv8DRQenMQNKZuVWSVMbz9LjqX+2qR1BNAbu09vdN1QOJqFtM0e+PEyMklaOlzfjrJtRtm
	PZwa4lcCNeHJV8GskKQTBHIaypNzL/qxgg1migHaubcxnX5aknhH0HbrawrziFnFCKOsIPyiK61
	RNbSSmXJs9cbnsIiwoVxqoqV+jcswux+G+7M6sXbJ63MezFeDkJCS/Br19SJEPeGeJfbRaSBrCw
	wtidbvSRGPSjtAThUSyXgm9+CZoE7nCsHdAHL6I=
X-Received: by 2002:a05:6512:3a8f:b0:5a8:86a8:2e09 with SMTP id
 2adb3069b0e04-5aa0e733fcdmr5047846e87.7.1779146197102; Mon, 18 May 2026
 16:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com> <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org>
In-Reply-To: <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 07:16:00 +0800
X-Gm-Features: AVHnY4KkGnIA1AVnKV_AWaEp2NjrDm25nHXNyoo6NNpsq6hasT3OVgqbybTidAY
Message-ID: <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289194-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kau.se:email]
X-Rspamd-Queue-Id: A0B11574EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 18/05/2026 15.53, Jason Xing wrote:
> > On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >>
> >>
> >>
> >> On 18/05/2026 10.23, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Add two if statements to accurately isolate bpf timestamping and so
> >>> timestamping. They can work respectively.
> >>>
> >>> As to so_timestamping, only add a loose condition via report flags
> >>> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> >>> and performance impact. If the loose condition is hit,
> >>> tcp_recv_timestamp() is able to handle the exact case and doesn't
> >>> hamper the existing timestamping feature.
> >>>
> >>> Make it work in TCP protocol.
> >>>
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>    net/ipv4/tcp.c | 14 ++++++++++++--
> >>>    1 file changed, 12 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >>> index 21ece4c71612..64c69bb3578a 100644
> >>> --- a/net/ipv4/tcp.c
> >>> +++ b/net/ipv4/tcp.c
> >>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len, int flags)
> >>>        release_sock(sk);
> >>>
> >>>        if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> >>> -             if (cmsg_flags & TCP_CMSG_TS)
> >>> -                     tcp_recv_timestamp(msg, sk, &tss);
> >>> +             if (cmsg_flags & TCP_CMSG_TS) {
> >>> +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >>> +
> >>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> >>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMEST=
AMPING))
> >>> +                             bpf_skops_rx_timestamping(sk, &tss,
> >>> +                                                       BPF_SOCK_OPS_=
TSTAMP_RCV_CB);
> >>
> >> Does this mean I can enable timestamp reading per cgroup?
> >
> > Yes, I think so, but I didn't try. One of the natures of sockopt
> > feature is supporting cgroup attach.
> > cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
> > something that you're looking for.
> >
>
> Sound good
>
> > IIUC, you can attach the prog onto the cgroup where all the sockets
> > are set using the bpf timestamping function. So the current impl is
> > cleaner and has better isolation (to filter out those unmatched
> > flows).
> >
> >>
> >> In Simon's netstacklat[1] tool we are forced process all RX timestamp
> >> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] =
on
> >> the cgroup IDs that we are interested in (which is a significant
> >> overhead, as this is deployed at Cloudflare production scale).
> >
> > I can feel the pain when filtering in this kind of relatively hot
> > path, which is what I'm trying to avoid internally. What I've done in
> > production (to cover those old kernels) is to just let the kernel
> > print the information, that's it, and there is an agent continuously
> > gathering the data, doing the match and computing latency. But it's
> > overall complicated.
> >
>
> I hope you don't mean your internal/old approach was using printk and
> then analyzing this data.

Of course not :)

The internal approach is to cover the old kernels but doesn't mean the
approach is old :P

Instead, the internal kernel module is super efficient and I'm trying
to ship bpf with such an ability. The fact is we've already deployed
in production: 7x24 running, zero sampling.

Please see page 24 where there is a brief introduction on how to deal
with the log part:
https://lpc.events/event/19/contributions/2055/#preview:3846
I believe this is the promising direction (ring buffer + lightweight
kernel + heavy agent) we're taking.

The headache part is that I need to provide an agent written in BPF to
do the heavy process.

>
> > Many thanks here, I'm always interested in hearing more useful and
> > real requirements and fancy ideas on how to monitor the latency :) Now
>
> Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on how
> to monitor the latency.
> The netstacklat tool is part of Simon's PhD thesis:
> - https://doi.org/10.59217/qklv6836
>
> And we even gotten a paper accepted on netstacklat:
> -
> https://kau.diva-portal.org/smash/record.jsf?pid=3Ddiva2%3A2034009&dswid=
=3D3032

Sorry, I cannot access this link. Could you give me the title of this paper=
?

>
>
> > I'm still struggling to port the internal functions to bpf
> > timestamping.
> >
>
> Good luck, feel free to get inspired by our netstacklat tool.
> Key point is to let BPF store latency histograms and then let userspace
> periodically consume these - as heatmaps.

Thanks. I'll dig deeper into it.

>
> We are proposing to add 'netstacklat' as a new libbpf-tools utility
> - https://github.com/iovisor/bcc/issues/5510

Great!

Thanks,
Jason

>
>
> >>
> >>
> >> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat
> >>
> >> [2]
> >> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/nets=
tacklat.bpf.c#L484-L488
> >>
> >>
> >>> +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> >>> +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> >>> +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> >>> +                             tcp_recv_timestamp(msg, sk, &tss);
> >>> +             }
> >>>                if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
> >>>                        msg->msg_inq =3D tcp_inq_hint(sk);
> >>>                        if (cmsg_flags & TCP_CMSG_INQ)
> >>
>

