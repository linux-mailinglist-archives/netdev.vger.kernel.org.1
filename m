Return-Path: <netdev+bounces-293738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPXyEP98HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FF61F5A8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 427D73010710
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC737B40A;
	Mon,  1 Jun 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoRwrTIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06C3793D2
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317413; cv=pass; b=taEQXeXdoIRoMzxZ5++dE+/j3pmfWS/WtpFPyIW8yYjVnCvFim96ve6L+kPOUa8Ri/7qingkgnk4CSSVK0YJQWS6WHo8vRvbHYxRhfUagh39xVbYm5jkKaZk8rEgG/e/1M8DsE7jAjRJGTckOHNoeSGHs4fyXEnizVJrI8HYFEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317413; c=relaxed/simple;
	bh=nX0cSKYPDYzlavsu/3QhK11Dd6P7lE5yqKAvD5dI/Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqrkVGpYQh69I8JvBcUIFNR09XT0fZxhThTUZTxtSrLgNuKa3Uxs06y/k7K5cfCWQfUfEUkCbxbESA/pm9eM032+LgWCgxK9/H5QMvsk+/xTuAQw1AzjsSAclJ7W+9ncTdJuwnQlJste5+X25XOwPbWDqFXHz32XEX3qfpY0TEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoRwrTIE; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51749fe346cso9307941cf.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 05:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780317410; cv=none;
        d=google.com; s=arc-20240605;
        b=GQ4n3lAWJVGNOVF7m6SlbxDGC0LiFx7Gut30+Kkf9BgWDeFGogKufPICuwueoJVz1E
         8Wj3u8jiubag3pekXZjUGzn4pHX35bEOl3cQzYtlU4mCikgB88m2KrTHQNpMueIIcprd
         DX9iz7y5D42LcpXRbPXIJyXKidPcnL5cIo8zSktrBPPUXI+dw6d6dmjJtF/sgjgUtCsz
         bBCrJgoy2aZoDodk2RWFxPNestKRuYWh+ARnjV6LiCQNXiSR+h3bBdcMwTCYjOG97S4y
         DWJ4588ZJuCtS/R15fecvHo5c/OdZpMI/3Iw0exs7XzBr8eYic3znbpgm6wfu0HNOohq
         MNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        fh=Xh3ZWLWv5IrFTfJdrWu2G2cQvxxIh9yQ18NoAinTjQE=;
        b=UrA8B0bRRt+IH9S7l8gQH87dfDvVahGe5UflDhwCPIYe3vzjU+PEE9P7Prk/oQUX5y
         piHOJ/V9hOO3S8Qc0MuqYyS/Kqq/pz/KIEj5eH8YcscWjbBAhzB0/pY5kfywUZSGM/bn
         6avt64UCb6nrseXashqsTp7lAthOKJ95AyXpjR5zzJGwElOnqaJ+GDy73QEjMWkjsb/2
         Pgf9XWaSOlHEaC9lHvjog7d3Np0icmCcDGtTkQQSYyvNhTzMx/v5AxPMifyEfdRPQGof
         WanU9uwj+4lCoPpYB/ilfk4NRXQPVSorwaON5E0M2KKiAAJNwFkQco5/u0fawTaeJEIh
         Dr4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780317410; x=1780922210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        b=hoRwrTIEHnOlZRv8INSRXAsF9RY6+173lWJYSdGpcSWLesWZVx8MUdZO5MMjqcnMPi
         LamWbJc9LrTyenFL+MMlhY02lYt7qtQ1UK70f+oVVeQ1GCzzncxxxNAI/bLGmnKRQro2
         WjLFJMLen3OjOAqOkaVYaMRbmsaL1KqLH74WDxD5NjvjwggJY5HfoGIPz4mGHZ+gaeFz
         OA/pz95jKZrj3b//S3tL01CzJGSaroQRIgK0fuC5Ns0QKfFVUztS7UQR2II41lLF+cPz
         wz7rapcmpKzLysNMGwCRLIL2/WeSRb3lVYeJ0YBup7h70QlHCSVN3UDWG6bTuxKmsTfb
         UPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317410; x=1780922210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27KaSPnwlRAhBIR1/gGhKzFPuNaUV3K3DKJ6kQM+qr4=;
        b=O0617skc4uWzETXJ+BWar8oiq+Jy9bIEUhVQOkNTEbdcupPagglByBKOn+C3yEP/fE
         /JbMeEopjbBXeEVmy1ZmA3WRKb2DMpxBWz4e+3M+jsOtQ42WthiGbXnlNRKs7VAPrA3A
         s25pUmKKL7Vk8FNMAXeNjEGs+PJKPF2A+zhEWpCRUuUpt5RjeY8Wl5g9wVszd8Gus0mQ
         zGvc/gIZV3rbRYdon3BUV7O+UvdywvuwhKwbXBKJRKzQzzIGnpX9UCaIqa9yL0pTBghI
         AMSd0LAZlYYRs5D7HlkXe9tK5A/1Hz4pMSTcueHQIh+sCyUJhI4Jt65ZAVrEu/3a/BbS
         TB/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9qob8AH8DQUH7kZIn1FddRoEWVu+O8p/gFr1hjoCYFkeGNH8XZTVCEUCJ8zbUD32fH3yMJpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzB+l4ASPYvH0ixAGTBkN40JicZxIbwLem47uU9yhH6GcJ2Tg
	/z+beXCzZNVFY7qK6McX644ukPnrnulzqvP6WA3HetKHP4RhgkLfD0FbnWt+OsD62Ton1y+bt5a
	TcAFA3CgeOfLFyCkiekaa695l6GGxkil97tD+5cuC
X-Gm-Gg: Acq92OE351Tmqg4/JhS987r3m3rQOfX/6xK8K7OZBDwK9hYeCZo7KbyqpgHHIu4+4TF
	g+LOMENIDkDv+uXcJMau+3IjHwWesImp7kKYL1UBZ9AX6TRQtH9vHqwUBusjm56GKVpcy83jVbY
	KefaAXDyA0ztqanfQjcLu9SalVst80SJaCMpu+vUiyI3lyDcrxfp33DhDaKrSZqhHr8bvplX8j3
	o/sKZsKA8TDFQ9Ztd/3vt+1ojiDCZ8ZEnXVP49WSxRvYtGHv3uavMSObecx1/L1IsEJsW+EpqGV
	CFGfz7hEXTWyOrn2OhlSWz6V1JE1aKwfNSvNHjU83sH9RKZNuQ5AnLPcakmr9cN6hchBWN63ydB
	3m7Eldh/jPRn90ezr1vzCxbMzLJwE
X-Received: by 2002:ac8:59c4:0:b0:50f:ba44:ce4e with SMTP id
 d75a77b69052e-5173a6197bamr168555841cf.6.1780317409230; Mon, 01 Jun 2026
 05:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn> <20260601132245.4be1b32a@pumpkin>
In-Reply-To: <20260601132245.4be1b32a@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 05:36:37 -0700
X-Gm-Features: AVHnY4KlUnijWv5Pkux0oZHHU1PNs3xf3C1pnizY3mYdP6D5as5poIPKX1sCnmo
Message-ID: <CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
To: David Laight <david.laight.linux@gmail.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,seu.edu.cn:email]
X-Rspamd-Queue-Id: 384FF61F5A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 31 May 2026 23:39:46 +0800
> Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
>
> > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > while writers update them through proc_dou8vec_minmax(). These checks
> > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> > KCSAN-visible data races and can make the policy checks observe stale o=
r
> > inconsistent values.
> >
> > The race can be reached on a running system by toggling
> > /proc/sys/net/ipv6/flowlabel_consistency and
> > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeatedly
> > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > state-ranges flow label.
> >
> > This issue was first flagged by our static analysis tool while scanning
> > lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN by
> > concurrently flipping the two sysctls while TCP reflect and UDP
> > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> > reported races between proc_dou8vec_minmax() and the two plain-load
> > sites in ipv6_flowlabel_get().
> >
> > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproducer
> > also hit the inline ip6_make_flowlabel() reader through
> > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > fixed in this tree by commit ded139b59b5d
> > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> > plain readers in this tree are both in ipv6_flowlabel_get().
> >
> > Use READ_ONCE() for those remaining sysctl reads so they follow the sam=
e
> > lockless reader contract already used by other IPv6 sysctl readers.
> >
> > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> >
> > Representative QEMU/KCSAN reports from the two target reader paths:
> >
> >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> >   write: proc_dou8vec_minmax+0x206/0x220
> >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> >          do_ipv6_setsockopt+0x873/0x2220
> >          tcp_setsockopt+0x72/0xb0
> >
> >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> >   write: proc_dou8vec_minmax+0x206/0x220
> >   read:  ipv6_flowlabel_opt+0x129/0xd20
> >          do_ipv6_setsockopt+0x873/0x2220
> >          udpv6_setsockopt+0x21/0x40
> >
> > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > ---
> >  net/ipv6/ip6_flowlabel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > --- a/net/ipv6/ip6_flowlabel.c
> > +++ b/net/ipv6/ip6_flowlabel.c
> > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, stru=
ct in6_flowlabel_req *freq,
> >       int err;
> >
> >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) {
>
> That can't actually fix anything.

It fixes a KCSAN splat.

If you think you can fix KCSAN instead, please do so.

> If the value can be written concurrently it will still be zero or non-zer=
o
> even if the write gets split.
> So it can only ever be the same as the write happening a bit earlier or
> a bit later.
>
> There might be a real bug if the code looks at
> net->ipv6.sysctl.flowlabel_consistency again.
> But a READ_ONCE() in an if won't fix anything.
>
> >                       net_info_ratelimited("Can not set IPV6_FL_F_REFLE=
CT if flowlabel_consistency sysctl is enable\n");
> >                       return -EPERM;
> >               }
> > @@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, stru=
ct in6_flowlabel_req *freq,
> >
> >       if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
> >               return -EINVAL;
> > -     if (net->ipv6.sysctl.flowlabel_state_ranges &&
> > +     if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) &&
>
> Ditto.
>
> >           (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
> >               return -ERANGE;
> >
>
> -- David
>

