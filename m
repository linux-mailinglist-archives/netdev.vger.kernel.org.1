Return-Path: <netdev+bounces-292497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFlELXORF2oUJggAu9opvQ
	(envelope-from <netdev+bounces-292497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8B5EB695
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53538300F150
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E901EEA3C;
	Thu, 28 May 2026 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnRUg0lW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C01940B0
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929457; cv=pass; b=DK19rc/e+3C90urirolrLX7rS3TfWILhY+ktzs7LYyjzDSIJWrhk/UJNpcWu7LwbWJtOQ+ukHJNk/WRGM+yPtwU3E9VrVkZEEz0iC7dgFC3MOd3TJ5Wqep5KhrszaAilbmQA7yBclL2vBY4SRRAglztx5shcZ1HG9PZeRjg/lPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929457; c=relaxed/simple;
	bh=giW7cE2Ul2827hcqIcTdpNfD7jsVV5kq3POoqaLjUfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo0GQ6vjYuD5eOkQX1tzGaQ1NQzBaagBXhAkL/N+MxPkGmSYI7LrwwHCU6JwwnK7+RrAG6Fq4NnfJRzAe0sScr8qIN6oIuhcOEGWYpGhMeXQGyppdKU4WCuhXsKFOat/PxOp5oLYKhyK80hWQOCBh3r9d0QZ9XXP0UqKVLcp3Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnRUg0lW; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa2691db86so12616991e87.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929454; cv=none;
        d=google.com; s=arc-20240605;
        b=KD0bGjOQKUDPVggrgUMM5qSpNQ9ZG1Se2cd2SzI5+5PF3d4sE5oQ8L5+/TfqcHt2fr
         9kBVsidKL0v6a+CKS2k8Or1cAEUAEw0ByCk3aJfCQhs3GPN4OZNt5gQLR8NmqGWeQUsa
         1F+WLcpfRw8zKZ9BYket/MIgdTobw69vc8Wc9U5ZuutmdpsFGDu0yf5GEKKh2uWoJSqF
         qyWKf0OEhp2rPWyvjuHLsvOvi3JDrWZITjDmy2IcvcI3JTkT7l8iDLsFp03i0A/DnPGQ
         NGCcL1HaoIYnHdO674g1mXXbAAXz2lu/nlIrk591AvosZHQrjT0Q4qWCsF7jQV6m2wBG
         FmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        fh=t3EeOO4yQBdWog6PEjFFdUsNwE4EXd/80N7IKDFieO4=;
        b=K8J6ErIqy8KE/H7h8UnvrJF3NWzeD1iStbNn5gMB3va3ehtwDNoSpqV1dXSqvEhW3z
         dYMmqIyx9+a2fjTPtnCU9L98iTBJLGyji0Dc+TMf0UtAU9hORTGHTpk8sFOBONCPEVMC
         eyC6Yq5JiK5kqyd10wC5cN6fHFnfBVX7fM2WJEUmzb/1TkLbwG24nykZrNnsYdgGz5/k
         E/zeKX+U7Q35O2XpVJi+zk0BRoelO73WSUJQ4zkMAgnHVOli9aDKDbpjZonNNVax7LK5
         y4+97uccGOfuTv/J662mDLW6kRhNwVEWhGbA0IgAzZDNhryvTHqB2ftrN8HgpE9OvJ/3
         hePg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929454; x=1780534254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        b=NnRUg0lWgvcmeDKtcUNIPH6r3mE6H+tpcHzMq4S2zJOTXQzvotaAP64KbUMF9jwCp6
         XCvNrJ3kFBs0umwwGx4xQVz4fxPYVcuuxztA3vY3jTy7vdz9ph1F6hPmYwdpfkqjdwCa
         xpPdxnFa+K9X/7oG6nNA/sMNqx24x540MqZm371sE+Qpg2y4NT/uPDtdqMRvQth/x1t2
         8RPK5NedmNMjARr4VzRkmEYUK4sTSd1lwyiDsUWMAqsWobIn+jXZo4j9TStkfJDme8vR
         SqPFQHpUWFsp84tn2Cm+geC5bBiHU50ysiKUGwYneKHIQ2fNXhcyrHTZRk8maLcDtiXg
         yCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929454; x=1780534254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        b=NZobEWYrGpDG0s5p/2ECs55pcSM31YWsoSTU0ftjHCX3VpG/6HhfAhmRE5rSp0YhEV
         ACZUIs19egAEzapN5ybR/k9gvIIDCHcNxmyadHKC70/YO/s91GPcubUMg9ekgBkOOQAU
         nwJhSBAioa6F76C96eyeD7s1nN/1wrx6CBAWzljytN3NEZoLc2JjlgRsljp8H0HEURUw
         wE7NkvjDmpYT1JQqEzQ6xAMCvqipDDNgSptUrV6ykr7RpctL9hJRcpwCDVRu7r3gfo1y
         6nfygvzJ3pxhNsRyPgeWpEix7OWEoX7FOavLaGd6iVgGkFakgJSexY6A9of0iKkluNcX
         uNAw==
X-Forwarded-Encrypted: i=1; AFNElJ/BURSi5xcihwSPbdpjVc62MtTa+5wr06tjCIeBbgJeYLbHHbahc6cbF4sXd2yPJUfTLWGlMgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehEDm220IS6WEpQbOYSNeYa0YcsD/VSyRHfsf8zAaLe/3mdcU
	E8JL6IE+RAPlHl9D01pL1DnN6F1bplFgDVZqRR/JOsLIIqmK9eQ9SwgCOv4xivJz7Ur8yfa3EW7
	aQbUvX5+lEIZVxOQfQF+KAh0CHhlxZKQ=
X-Gm-Gg: Acq92OF+y87eUrk2nYVLZMh8tSqF3V4VHF/7gjqe02JDecpdiY9ZOnOAQjgI3rEvQTT
	1/RM1uY04USIK7TakYDTgDIVpp7raO5mWgQ+hYWzePhl9sTQQN0+7cOCasaOQtGqAjzWQZsZ1LV
	xEkcszKn1rGSOAmSM1XSgpEcyRKGZiejy45rKGFNLZnfV/Eh4aTzXRY4838OacqGJr9YlES9sWw
	ncixvEWqi6u6bQOjTE7eX5dgMBpj+uuyBwbz8pt1g8hIspbhKHa9olAl4LILkp93n7eHqKaQQ/N
	abPeC0+3TIfiBGZnmjJzbiPyG7rurkJeua/D+8ogefPHENNRw3UOszmTn9wZ
X-Received: by 2002:a05:6512:38c5:b0:5a8:9b6a:5749 with SMTP id
 2adb3069b0e04-5aa323a9f51mr4812397e87.28.1779929454248; Wed, 27 May 2026
 17:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
 <20260521135244.40869-6-kerneljasonxing@gmail.com> <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
In-Reply-To: <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:50:13 +0800
X-Gm-Features: AVHnY4JtxR6v6tEHKgUcEj2YPTM0SwOnxyZSTt214CNsHr2ghH9-fOy5Tz9QpJE
Message-ID: <CAL+tcoDmc5eOTPT1BWqagS6tcTZn-pfJuwrsPJ5dvq3ZJd=eGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 51B8B5EB695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 11:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
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
> >  net/ipv4/tcp.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..7ad3561dc8cd 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, cons=
t struct sock *sk,
>
> Simply drop const from here rather than casting to
> non-const for bpf_skops_rx_timestamping().
>
> sk in all callers of tcp_recv_timestamp() is not const.

Will do that. Thanks.

>
>
> >         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> >         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >
> > +       if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +           SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> > +               bpf_skops_rx_timestamping((struct sock *)sk, tss,
> > +                                         BPF_SOCK_OPS_TSTAMP_RCV_CB);
> > +
> > +       if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
> > +           !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > +           !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
> > +               return;
> > +
> >         if (tss->ts[0]) {
> >                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> >                         struct timespec64 tv =3D ktime_to_timespec64(ts=
s->ts[0]);
> > --
> > 2.43.7
> >

