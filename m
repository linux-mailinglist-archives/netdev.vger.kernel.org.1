Return-Path: <netdev+bounces-256890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCEtBujjg2lqvQMAu9opvQ
	(envelope-from <netdev+bounces-256890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:27:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F908ED6D8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F3630086DB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76521CAA68;
	Thu,  5 Feb 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoYbVSPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791F1C5D44
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251236; cv=pass; b=lr5YuwWlu3o5YizyWr+M2usj6LaXL/qO+Rn5i7wZXWEFCWNAo7uzJ/L4BJvrkPBSReFP46Czw1pE5LJ9b9wK28eGA0/iYmAw3G5fQQa12zvUk8CwfIafokxTvgqqx1wEHSIVJrwxZ9fuFWFz0Tj1xvsP740Cu8WWRlysqDBO0wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251236; c=relaxed/simple;
	bh=wSGZMNIWhO//TQc/kDi8TEO/Ez1Q5EPS2BI5zT0G1W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK3am5ODXx3UyVhTUH3dNRwZMMSvcE/Q3sRaL2fjx01jxN9gEO3CFbHh1ZWR0AhbSS5ybVwWWqfQhmJDvtb0c9V51mUt5rJ+jA8eekdNNpbWkch5vl4YjNwDHGCClna+5KfTbAQEnXAZ4EXqjIzrNdJG4rTQEhOqKOcDvL20L/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoYbVSPp; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124afd03fd1so767750c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 16:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770251236; cv=none;
        d=google.com; s=arc-20240605;
        b=Ahug3CiQ/LmHQzZGGS0lyYFNj4uMXNTgYvb9S+sujTYEfw6OsPwsno8ArGBVIypu9g
         i8Gc1/G+N2udUGnUkN0gdljSttbsc/Wm0ymrXrKnMh+ylv72k4UOFDY3uPtdd5WE7Far
         CZpui0Vj+vM/JdzobCXOX4oVx/PE/YG15vIqYn5enfwaI/hsWr0nUnCaHVFXnI0kP5Do
         x0k3Gg2j2CWqK2zi0qbGARIRDFaDK9HR1qBxhIpshKwY/VU10Pi1TYylwGv8u2OcohyJ
         nc4+4EU6FvQIXD/yLVMd1o8k0cQ4iTonWpeXcV2lPgX1l+w/UgA3WXDOHJqWCnG0MCfV
         7ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        fh=yXu2DojETfkQU6lhDSRUATibeIGerjPd4jsVfbT7kcQ=;
        b=Q7y3MFD3MDYio7ZTRzZdsfx4AMgUdMkKwpCxg7SKpJT/Z2q1Jjq8mn+yWraBxlTkCb
         FHERajHMb2lZzRthoC4gkEG1WVId8McIaL3yWd1lw5hDZ0PkCdwo6naLPc+Ldi+sa89e
         WAqaoMKmyW+DFcPLDHJIweC8NEwEfnh5ERRgD1ASpDdQvAZplshVFQR83f6R4tqCGvuO
         GI95mRnBTLCuIWtHoFRAkIS2pXr9O71bT5SVTZkGhEespQ0qO2ZHhyd/p14cm4hMYIjr
         2pwrBCBHQAw8CP+wdAVwwjdRcu8MiIBNnkq1p5EuX50rw6scSZ0x5Y8g5rdoZnGDLZqh
         VKEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770251236; x=1770856036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        b=SoYbVSPpkh54Wmx2t4AjncnnH3zf7IpTwpOW2agdvb5Lw+zrnkXE9XSCj7vIKomwvw
         M+kJgMvX3Co25XRUpqUvCcTJi1APO9f6KQugG5pzFTJZDv+0dYbmLvObsook4oUwOaC2
         fY8YsSU5NbRJlivgJGl+QfHV+pF2XbfpVlCFFwk4HT1fbstFndyMLtN3Ellkx8IKZpwm
         YMEKQ+lnA1Wyor/wTGqjgtSFWBlldNG6axLCHtetgoZ1fpk9VEuR1FdziSlVHBaJcoUt
         dWQFQ9DzpoWRXgKH9Ro32J9eNeQQTUC+fPRM0ON8BYbSEacmapWj/g/KgvP6vJbDehkM
         3e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251236; x=1770856036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        b=YONnKCZyMrQwZ6p1V/sogt/Noio8bpDJdqyz+WkUjaRTa/HdZCnEKn9QXn8x+vdbmh
         4ccQja+KorQD5Hmr9P6SHm56CxXaiNfWUSFQKyp0soype/z82LVYU4FZUcLtBlwhveyi
         J8sb7cqViao2WipE4Jc+WsIvCfNHp7rCP7FYrAxm42QaJCpYpAOTlmD6sxiucFRuA8EJ
         cCL/32WUwPH+cpsP5OfgOANYXSV4Xg2WQNn8F0Krmh3daYsIidl/mITfaTAboMuo6+vu
         QB/nNH5OoPuvNGza9UK5MzJza49wyyxBEgexgkTljnpa4uzHRPowHTFZJ8e+5jbLUzbz
         wzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWJqkcz4NaDeSXVBdqg7C4QF4+PvOVYAXKHR7SmcXAys0Aiv7/p8GgKlcX5JcrgQAXSEL4cdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdifycHFxhaOgSEk2W955/QlYY1hHh/9XvOgp7lkt9myOFoRb1
	eHIY20bwMxIMXHMbwecEvlaWHyUm7WASIPXU2m45cF70taxaNTiP/CQOPZmkdnKr+t2fQoRa70H
	xIi0XHA21Wdz56157ft+U8VX4/sK7ZAwWTW4Hvz2l
X-Gm-Gg: AZuq6aKkf6zZ2CQwC5veXcy2MtdOfOzcLIfgUphEB0PuZz/et5rwzlvVd1ylwz3byNf
	h6l7N9Cog8YPcNttLGNy9F2BIYSJae6GNvZzmCrkcu9jiXitYwZtctnhwWZkIteO5lskqWxSTFF
	MExTIIMqABb6jL0ivfFD8gfrSZDXBq304Ea2bjQzC8P0F3DQIUu1OVq8N24rrFJMRGmoA0UoxQL
	yvUlFRSGDFzvLcswm2NkYy0pxSxOBePr1394JiDaA2XEpECZk+6ruuME3LRAqvr2fgkzW65Hb1X
	xf4BlfjeUmkALDqlCuq82rqiJAgt5lnLGUWZISfduiL6Tzo9HSHD1JPf
X-Received: by 2002:a05:7022:127:b0:123:2dd0:10b9 with SMTP id
 a92af1059eb24-126f479db5dmr2185487c88.20.1770251235294; Wed, 04 Feb 2026
 16:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev> <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co> <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
 <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
In-Reply-To: <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 16:27:04 -0800
X-Gm-Features: AZwV_Qg3Ao_jkZiH5CFGA21_xhVBJceX5eso95X0_82kyEb20mWSlCtn132I1Uw
Message-ID: <CAAVpQUAi2WFMz3fZutKgJGjVnMh8LMiw1GM+M9L-Gt-NuHghBg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F908ED6D8
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 3:25=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 2/4/26 20:34, Martin KaFai Lau wrote:
> >> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> >> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> >> right, we can crash at many fentries.
> >>
> >> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> >> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> >> Call Trace:
> >>   dump_stack_lvl+0x5d/0x80
> >>   print_report+0x170/0x4f3
> >>   kasan_report+0xe1/0x180
> >>   bpf_skc_to_unix_sock+0xa4/0xb0
> >>   bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >>   bpf_trampoline_6442564662+0x47/0xab
> >>   unix_shutdown+0x9/0x880
> >>   __sys_shutdown+0xe1/0x160
> >>   __x64_sys_shutdown+0x52/0x90
> >>   do_syscall_64+0x6b/0x3a0
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > This probably is the first case where reading a sk pointer requires a
> > lock. I think it will need to be marked as PTR_UNTRUSTED in the verifie=
r
> > for the unix->peer access, so that it cannot be passed to a helper.
> > There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one=
 now.
>
> What about 'fexit/sk_common_release' that does 'bpf_skc_to_unix_sock(sk)'=
.
> Is this something the verifies is supposed to handle?

sk_common_release() is not called from AF_UNIX and
even other helpers accessing sk->sk_xxx should trigger the
same splat.  Moreover, any read would trigger the splat at
other functions like sk_prot_free().

We could sprinkle notrace over the kernel or have a blocked
list for each helper in the verifier, but then we need to inspect
all bpf helpers.

In the first place, it makes no sense that someone who knows
where a pointer is freed tries to read it after being freed and
complains about UAF :/



>
> $ python -c 'from socket import *; socket(AF_INET, SOCK_DGRAM)'
>
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> Read of size 1 at addr ffff888128312112 by task python/4076
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0x95/0xb0
>  bpf_prog_70a8d38bd5dbf399_release_exit+0x87/0x8b
>  bpf_trampoline_6442556594+0x64/0xd3
>  inet_release+0x104/0x230
>  __sock_release+0xb0/0x270
>  sock_close+0x18/0x20
>  __fput+0x36e/0xac0
>  fput_close_sync+0xe5/0x1a0
>  __x64_sys_close+0x7d/0xd0
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>

