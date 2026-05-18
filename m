Return-Path: <netdev+bounces-289080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHffNykbC2o2DgUAu9opvQ
	(envelope-from <netdev+bounces-289080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690E56E318
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A539430599A7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62992371045;
	Mon, 18 May 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzKagooh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB100481226
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112444; cv=pass; b=vA0obTB2Ls1oqDatGmrLEjQROuPQzrbbko+yoCrjXFpS3OLxl/pRgxNCT4secwQh1qWV1njMmSMXxCqzOFgZmvkWSJmVO0BuIQNBOVMA/NHabhdySvKpk9F99r4gW8nb3hCqFMGMYU/S0jn2QS4ntCWB7pfYDBNzR+DWYWqghYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112444; c=relaxed/simple;
	bh=TmD28ZM4swHtfnvSp7BEh2wcnOTb7f4zOQZTyYX2jGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EspyRkr4Q54cRJFqnmf+pas82d6TP6CJ3Sjmbom21ZLhMubfu3/tqwL2XAmKW0ifS+mheW0Prw+TqRfE1YVGoiLxN8RXN5PPHvrw/VmFbEN8w/Aiy99tE+vVn9BGgCgVrWNhFaFljlGeAo0o+GZK5lkQJFQ1JOgllhGTunQEqic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzKagooh; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so2206629e87.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779112441; cv=none;
        d=google.com; s=arc-20240605;
        b=cshgOgZtLzz+gduOmMTqOJh2SFCJIfm4faQFX0gJfPqBQfytGpFVvcSPJZCrG6eUCE
         yzzQXGU0CDRHCX7InoRJLnseaKpU4Xvz8Jq8loEN7Z+cDOySCjqNhfpzwqzKVSl8b05j
         VkDajunpt1lOLPrAcgt+S4XOsruUMm8ePLJlrro+0L7nED7nYW05K5HWr/gd3KngtDth
         pezWkDZ2fyM6qFlEBpL5xM0XWxXiLt1cAAzdrvQ9cN7nE67Pco/cOkSKCpovHRPUgYgq
         AfDDFj9uQ+/MWD9PrwQvbA0ceOnNtSnv26W8IOkldRxmcDCaT2pIwe/ww7NdlKvUHy2c
         SwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        fh=vk19+ITFaUffH6mAj+0858R+qKZ5yR/UnqaU9H3I5Rc=;
        b=AdEC0Uo14CbqvA4ikrB+GhddvRukiIYYyxhSqinv8Cb7FT/vBGp/9mf2g1YAvNJrmt
         rtNbGwhi2FKo4ZHzhph3lAoanWtbMC52Q14VZMWJU705U7Ays1+aA4uCdy/l8u6fCQFP
         ymm8twM9OalFpitSZulOV9m22OzAx81jtFY/VgJMCSzRnfo9HaOGung7rojfspr8qfGU
         lVDqAp/w4VZ3hClQJpjLxJqbf+MsVIAvu1IeEVOTOFqqC+ArrL4WLIqBDH1GXWGJQmyY
         G0JTC8F64djse12jtmyaOZ9tDBM7u1Rti4+ETetd3RixATWDU9pOlV/rPKEUL9/vetsT
         voXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112441; x=1779717241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        b=bzKagoohnB1y/ezP83W/3ILMs/mUsKluFV4HwNPYfwvdUavWnm+JlYMpx9/2x6pR9q
         RIRHHE1AseLklgY1PGLani02Y4wuxHaJqXrjW7HhkqrtAMWSRwkSdOh9MS568hRekp2C
         eV8IX2cC7hnPe13jS0TLrmYj8p54Ca01zb86IRvkMV6rvK4Z4bFHRL0uR4pOYXqCRgzC
         ErIxZGC/cTuRmdU1L3iv4bVbl59kKUFL1Hljt4EEeZwBEuSnnGcb9hVCMNRHNfMQYMnp
         0WTFnzwVI6jBcRWbeJI5+OrCqxnVsTd4wc5L9Gc05g4j5fdWdpwwShEzFd5QmNeNBrxf
         R7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112441; x=1779717241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        b=WX5jsMNg0xre0N9SN+//bVn29cPtlgO2fPnW/ISKmypJFD6z7HUkYEAlj3WJAAmT9R
         BqjX6jHYLDMaoWdTQu9rfUW+JEmt6N1IhotnzG+b+5pzPJfMKNPjb27GQx4ebLIjYilK
         P1GfU/OFAVfwdZhE1ml7X1XDjYemAJYnjmqWZeqXg5N7Ru70edq7E+uI28CqvIDjXMzd
         v24A7cu04eI5jnu9WH04OiIqE6r/W+KDRG4dcT9rWajHgU6d7d7Az/TlyadJ454dmu3o
         E4TywA8OpZFGgku3GKoVZeA0FLy7EmAaQ7YfrLRvmglnwitM8OqfbLgghMxS0biU2Wya
         0qLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/RWvUmYOQpSOBJ6THY8lIs5EzW6Y3mrt5DjiNUc0wTKJJzSht8sFLz8L3esnCOF12aA4/iMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfZokR+Vy21ba+L8ejFcTBUhrRYs8fM5guWnJ4PUr1dce7w+J
	IGZBJMds5sdFPyZav6ao4peB5p1WEMBH+5dgS34PyXiUiP1eXKeGH0UfXuTeE9x4i/2eFnBfQyC
	ZwXgdKZRyTyN23lfnAvyZa/c1bVv4328=
X-Gm-Gg: Acq92OEp7wYKcHlDWJIXhWAu0zzgy7Uqiwi1VRt2KnrSD2S9xNfkmrgT72XEwEDJKOp
	UYkVpkF7D7A0Eh2Lw2mK+dwteiaFC/byVZUStR6SHheDIZqFo/eXqJ3/gFKtKweD5ZTqtQLPlV2
	tuFsYBClGoa5ZfBzuemHYqDzRgyeOCi7yW4QKVm7+M6wfes40t/ZIWbWhHgEDrluhkZrcrkB99k
	ecdpFlwR2FVOtB9RJt2mZVb3VSNfVx9jCcirwxhXEqwsoYbmSRbdgVzQlcl2BLJN3hZY0egL5+T
	C0qtNOf0TQ+XnsSIwAJ6Re1qSC3C9ULhJrsgee0=
X-Received: by 2002:a05:6512:10c9:b0:5a8:6f10:799c with SMTP id
 2adb3069b0e04-5aa0e7305demr4625853e87.21.1779112440555; Mon, 18 May 2026
 06:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
In-Reply-To: <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 21:53:22 +0800
X-Gm-Features: AVHnY4K-swb5msmI4aJefZbnvwlj0XzxaGYnWrFJPaZmGuIjZQLaUMRdNs14Qig
Message-ID: <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289080-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8690E56E318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two if statements to accurately isolate bpf timestamping and so
> > timestamping. They can work respectively.
> >
> > As to so_timestamping, only add a loose condition via report flags
> > to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> > and performance impact. If the loose condition is hit,
> > tcp_recv_timestamp() is able to handle the exact case and doesn't
> > hamper the existing timestamping feature.
> >
> > Make it work in TCP protocol.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   net/ipv4/tcp.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..64c69bb3578a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len, int flags)
> >       release_sock(sk);
> >
> >       if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > -             if (cmsg_flags & TCP_CMSG_TS)
> > -                     tcp_recv_timestamp(msg, sk, &tss);
> > +             if (cmsg_flags & TCP_CMSG_TS) {
> > +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +
> > +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAM=
PING))
> > +                             bpf_skops_rx_timestamping(sk, &tss,
> > +                                                       BPF_SOCK_OPS_TS=
TAMP_RCV_CB);
>
> Does this mean I can enable timestamp reading per cgroup?

Yes, I think so, but I didn't try. One of the natures of sockopt
feature is supporting cgroup attach.
cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
something that you're looking for.

IIUC, you can attach the prog onto the cgroup where all the sockets
are set using the bpf timestamping function. So the current impl is
cleaner and has better isolation (to filter out those unmatched
flows).

>
> In Simon's netstacklat[1] tool we are forced process all RX timestamp
> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] on
> the cgroup IDs that we are interested in (which is a significant
> overhead, as this is deployed at Cloudflare production scale).

I can feel the pain when filtering in this kind of relatively hot
path, which is what I'm trying to avoid internally. What I've done in
production (to cover those old kernels) is to just let the kernel
print the information, that's it, and there is an agent continuously
gathering the data, doing the match and computing latency. But it's
overall complicated.

Many thanks here, I'm always interested in hearing more useful and
real requirements and fancy ideas on how to monitor the latency :) Now
I'm still struggling to port the internal functions to bpf
timestamping.

Thanks,
Jason

>
>
> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat
>
> [2]
> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/netstac=
klat.bpf.c#L484-L488
>
>
> > +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> > +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> > +                             tcp_recv_timestamp(msg, sk, &tss);
> > +             }
> >               if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
> >                       msg->msg_inq =3D tcp_inq_hint(sk);
> >                       if (cmsg_flags & TCP_CMSG_INQ)
>

