Return-Path: <netdev+bounces-294080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A6ADMiRHmodlAkAu9opvQ
	(envelope-from <netdev+bounces-294080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:18:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82362A617
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1979F3015454
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0093B961B;
	Tue,  2 Jun 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0a5ISYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98F2798F8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387864; cv=pass; b=OKlhMGc3mz5TgjGPBRtD3GuuAi7iTfctYHefLKLTGfXbktCaQxNEyq0Y8/9MddnUlpyw289diGBB/Pk47hc6k5FDlQ/v/37AHu6TnMWC74UDbyQf8RkZEv0ffj6TENREcVdE5Gl9Eu3C7Y/esMGvmI3OX5fCPrtGLwS5iX38wpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387864; c=relaxed/simple;
	bh=A3mR+iXVh3aOXVYw2xIWqsEP1lq/3bB4I6ut/MByTZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPMS8wpu//GDlcxjrQBa6WGIAk4JKvRFQLtc5MWpk6JMYFcqyDrqCOs8P34wJsUf5I0br5BCTPbwJhvX1UI9k8Z43pXngZ5Yo6GmdF5Kj0D0Nyc8LH57aLPXqhGLpbZtd4vrgtDqhWYMY6/YRe7NetcFaQUhClSw4YLt7m2hfIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0a5ISYK; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51749ff0a97so19463971cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 01:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387862; cv=none;
        d=google.com; s=arc-20240605;
        b=GYRRiP5oD3BxRqK4O+Xsru/7pLjO9ywqn80FjtgGyde55kYVfHZmqRV6gipBk4YtrR
         OQLrmtOC2n0MDAG7j46X+wKSiwWQsXfBFim2i99Lx2pgyf6z+govwiJjoWqQKWK6QEgC
         a5XcBvsRLyyRx8GOo4dhyVJP9DKLxnmhtpj1w+ay9pguZQZkqbrITXL/Kjn4CskdxwFR
         b6lvQ05wS5SaMQYg+7Kj6CUsIZRL+by9oIpGRwubmqloqisNSgzfaPRFmGluVkczRTr7
         NIFWUq+CWVasX6siuznht2Yq7v7MqJFShMCRWNa9je2E4gHUW5JrD0qCHfyvDsKtuoyd
         eu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzBskLRV9A992XU5x25VpjtHm9D7sWNRRIF8Dm5gpJo=;
        fh=dnxZLxqmraij2+NXuV7Sp3eATjXoqP3MYro6Gd+5jhU=;
        b=K+/mvNLnZ7CAqWHTVppsy+EW1Tbe7iD/ZZdUbLArjx1THCjNJ3hjE5CMvyaDZFeco6
         zMdAzHYkc6GOnlDM5+kfa/Os40xoPqMmbXRz3UiQs6PAACYDpx8agvtQeadGDSRk6tom
         J9slAoYWzCSw8UIKAjlby3RbTr7AFNbizpjYPdthx9TLukdX6iTLLhQf0cxe4KoCguLD
         ebB9D6ZcBM2yaHBNcb3qjjQgkWMbTiwfAcdrkBa72nLZsAw3y4fZlMx5k4F+mRLPQJ0X
         MjauobK2bpYOh6G+Gay2C2ghVbmPeES6BqpkUgdrXMvftE6nokNUxxwmXoVmd+mPOlnk
         ezBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780387862; x=1780992662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzBskLRV9A992XU5x25VpjtHm9D7sWNRRIF8Dm5gpJo=;
        b=f0a5ISYKtrGSrxYUrm1ZOR5uMnC54IG2Fxjn4ADg4ezdKYlSQf8B3lzm1bg9umayw0
         xc27uot4T5qKG+ZbqSiRMU7/TcfOZejs2RKd5+AkwdBlPuSJ9r1KIJp8clbXrb5U+TVv
         dwtRzu/F+obRhGJozdh5uzpVK4DYUzcpkhG2L7QFegXDN/LV1b6SdUxWuvkVHCZqxuoV
         dzH4BIQKCHAdCFeVC6Bm+pU8NNFQ++A2fI+nKPybmFiP+lHlHmNGpNhbjvBA2tu7dUAv
         ChTwDou9MRRl4D3xRGBmrGVaky7n9M9S157XqK/Ylp9PrSYy3hteXM9TafBieIHmh7sL
         MMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387862; x=1780992662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzBskLRV9A992XU5x25VpjtHm9D7sWNRRIF8Dm5gpJo=;
        b=WNLzlayBwgL2iKlR6gu7kJ9pqbsHr6f5RG7U4f5LMisAl2iQM1gMSkBGf3SZTvYm/4
         gXQJbDtzjhuq6s9LQROoQ9ivfBxSG8borN/sMlAi0p6cnIKRc5JRzJ7rVN5HumsVzawk
         YVY43guBJSM7NjMVlEBXEjQfBxcfegr0ptEU8ThAF5LvHqdWDXE28Y9mBI8r/3oNmpoU
         I52kHarUpsnLeLeyb+wDamcnWKo4vR5wX47vjghSWY/872c/3iLCU4sTxI7GR2dk+NlT
         t1oSeDETPJPFbZEGtyx4JixHdTbXIvXdR5GPnQwC6S9YECgOV18VK96U6Y7bcCvJs6jc
         t+pw==
X-Forwarded-Encrypted: i=1; AFNElJ+xs5hApF0OiesF5nJBIt2XcmTRdT4wemZPcAsqafn08UMYfY4pXPMdGfOEcYyw7QANxKacjQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4s+2N2WBtLToC7vYL9tuhz1CJOFLCMsLwIQRrOQCqy1Y/FCiM
	JkOrMjoPhBtsg3guPAhYhN58A6kZJhIX2BVnqS40FC0ErTFtDTD0sOpz2uhrmU0LRR870mRQQ1v
	8rXSy8kkhHBv43K5mZEK2bB23mROmUmJEFCWQL12u
X-Gm-Gg: Acq92OEdTBYN4GuDkeVnkigIBDzEHL80qIJy5fJ021NwyrFh53jQm7uD87G2ASowWOD
	aKRBrjvicNvDncjTshxEubZHtQN7wUYBdNgpvdpy7lcb3Ljh6ae36TW7/lfdWOKfE/HoZoHiZz+
	3o2yZlnM2C9zv8iWupQPtG0/wugkmmfyA3pAMWECdW92ds1q7a+v9ktHjqiDi5VoiU9V89LLT+w
	s2TdFwBJLnotxMYPhZI9ybQ3yOyEV+aW6L3ncTddvGJPsJvRkjaiLLSnpEuzahzCQkUZJqj8BB+
	5TMYDbloshTs8XlKm2uF0A49m6NZxycVvfEHzKp4eVuUnIwn14eMOeW0Tf343oSZPh3kNLZ7yTP
	Hdo6BCiMdSZFLtEKxYvObMsaXZxbvjd4GAkIpUUo=
X-Received: by 2002:a05:622a:a952:b0:516:e086:89a with SMTP id
 d75a77b69052e-5173a851803mr161842911cf.26.1780387861190; Tue, 02 Jun 2026
 01:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601223122.63c0d23f@pumpkin> <20260601231546.3407019-1-kuniyu@google.com>
 <20260602090034.7a5c243e@pumpkin>
In-Reply-To: <20260602090034.7a5c243e@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 01:10:49 -0700
X-Gm-Features: AVHnY4KP_nX7QZuUeMLjJ5JNn9w6rkz9mTStypuDH-1VO1YDn32yD1IF-mxwy38
Message-ID: <CANn89iJWcG6UH0ZqLnjRaCr0Ky6WeEYhj-pyeyrPf3oJcHU5KQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
To: David Laight <david.laight.linux@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, idosch@nvidia.com, jianhao.xu@seu.edu.cn, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E82362A617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 1:00=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon,  1 Jun 2026 23:14:44 +0000
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> > From: David Laight <david.laight.linux@gmail.com>
> > Date: Mon, 1 Jun 2026 22:31:22 +0100
> > > On Mon, 1 Jun 2026 05:36:37 -0700
> > > Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > > > <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Sun, 31 May 2026 23:39:46 +0800
> > > > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > > >
> > > > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fiel=
ds
> > > > > > flowlabel_consistency and flowlabel_state_ranges with plain loa=
ds,
> > > > > > while writers update them through proc_dou8vec_minmax(). These =
checks
> > > > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain read=
s leave
> > > > > > KCSAN-visible data races and can make the policy checks observe=
 stale or
> > > > > > inconsistent values.
> > > > > >
> > > > > > The race can be reached on a running system by toggling
> > > > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task re=
peatedly
> > > > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > > > state-ranges flow label.
> > > > > >
> > > > > > This issue was first flagged by our static analysis tool while =
scanning
> > > > > > lockless IPv6 sysctl readers, then manually audited on Linux v6=
.18.21.
> > > > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/=
KCSAN by
> > > > > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). =
KCSAN
> > > > > > reported races between proc_dou8vec_minmax() and the two plain-=
load
> > > > > > sites in ipv6_flowlabel_get().
> > > > > >
> > > > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side re=
producer
> > > > > > also hit the inline ip6_make_flowlabel() reader through
> > > > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is alre=
ady
> > > > > > fixed in this tree by commit ded139b59b5d
> > > > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The re=
maining
> > > > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > > > >
> > > > > > Use READ_ONCE() for those remaining sysctl reads so they follow=
 the same
> > > > > > lockless reader contract already used by other IPv6 sysctl read=
ers.
> > > > > >
> > > > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > > > >
> > > > > > Representative QEMU/KCSAN reports from the two target reader pa=
ths:
> > > > > >
> > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_mi=
nmax
> > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > >          tcp_setsockopt+0x72/0xb0
> > > > > >
> > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_mi=
nmax
> > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > >          udpv6_setsockopt+0x21/0x40
> > > > > >
> > > > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > > > ---
> > > > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >A
> > > > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.=
c
> > > > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *=
sk, struct in6_flowlabel_req *freq,
> > > > > >       int err;
> > > > > >
> > > > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consiste=
ncy)) {
> > > > >
> > > > > That can't actually fix anything.
> > > >
> > > > It fixes a KCSAN splat.
> > > >
> > > > If you think you can fix KCSAN instead, please do so.
>
> ipv6.h has:
>         u8 flowlabel_consistency;
>
> KCSAN probably shouldn't care about byte reads.

KCSAN detects more than just load/store tearing. Here is a summary:

Purpose: KCSAN identifies data races, which are a common source of
correctness, stability,
and security bugs in concurrent systems like the Linux kernel.

Mechanism: It is a compiler-instrumentation-based tool. During
compilation, special code is added to monitor memory accesses.
At runtime, KCSAN detects when multiple threads access the same memory
location without proper synchronization,
and at least one of those accesses is a write.

Operation: KCSAN performs its analysis at runtime, reporting data
races that actually occur or nearly occur during code execution.
While powerful and scalable across the entire kernel, this
instrumentation can significantly slow down kernel execution.

Impact: KCSAN has been instrumental in finding and fixing numerous
concurrency bugs.
For example, it has led to the addition of annotations like
READ_ONCE() and WRITE_ONCE()
in kernel code (e.g., in the TCP/IPv6 stack) to properly handle
lockless reads and writes and resolve reported data races.




>
> > >
> > > It is a false positive.
> >
> > It's not.
> >
> >
> > > (Which I think you also said in a different email.
> >
> > I guess you meant this one ?
> > https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@seu.=
edu.cn/
> >
> > This is different because, in addition to Eric's comment, IPv6
> > address is 128-bit and data-race is inevitable without locking
> > unless CPU supports native 128-bit read/write; we already do
> > load/store-tearing of 128bit with u32/u64.
>
> But the code isn't looking at a 128bit value, it is only doing a check
> for zero (and READ_ONCE() doesn't support 128bit values).
> If there is no locking the value can change just before/after the test.
> Even if it were subject to read/write tearing absolutely the worst that
> could happen is a zero being detected when the value changes between
> two non-zero values.
> That isn't relevant here - it is just a boolean.

It is completely relevant. If you disagree, please fix KCSAN.

