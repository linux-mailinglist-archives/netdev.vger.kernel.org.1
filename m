Return-Path: <netdev+bounces-281073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIVyEcr862lbTgAAu9opvQ
	(envelope-from <netdev+bounces-281073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:29:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D24640BA
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860623020855
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96410379998;
	Fri, 24 Apr 2026 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U59jFH2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38B33B6C4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777073351; cv=pass; b=Np7Q7eaFrhhXP+JhvRfU5Ip/5vfzZr4WiD5vdO/hF+BRh4xwjOvHjHxHtfK+LdCby8km/nhY31pRg3VOQHYSIy2xN9nLr/Gw2iJ7FLfeIc3tcE8H8FbsdPJaBHj+XpLXlm2xG94hLdRbuTL4wa3RVU9TlBfXAMt0oTCPjH2RBbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777073351; c=relaxed/simple;
	bh=p9A3Nz6MZeWF2besohCOqD2DNsRX/iufJlsqkfWh4sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXPqpCr+IY3xgQbh62wdY71MwtAyHz8KhYuwnWx6p8d9P4HzMiihptt6b36PnMgCxfgRjuLnw2HVNa6p3m0DihaiasBe9La4Vwy7t7HVDv5IifD71jbpdtZMH6fX4Zr/8uVzYY0LDgMmaRpxYHIvn9W9a3ICsrnaihYVEjqKaHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U59jFH2R; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so6240103f8f.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777073348; cv=none;
        d=google.com; s=arc-20240605;
        b=UCpbV1fykLb2TQTjdYGl5STMl2Cx1TE3mvGt28u4YalrJjPBPPac9TGdKXrpgHWKMd
         bewhFLEpNV7SiiXTvh59tvv9OA0QEyRzFD0DIF292JLHzsCYnLKbzXpTJybLi97+EXMC
         rvdxRl5or5mwg9lOuPvLZLbqmggyCQEU/MRp0hsXjulJlS3iRk8B899jI9Xy8It66XQp
         ALr4qw15+q4zhcgvmhBRyU/qmcedo+PNQKJF6F+szGjba2a8sU9ruSx54viTlnYMVNWJ
         YAO/ma//4o1yVQipjV0bMTUuC1JHhNsrru8EtDuCORqqGQjPoFyiIPZUx1kM/P939Nug
         IhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahCy8rxOvixjX2FA5ApDynwuvYGvOS/2mqLtTRZIyI4=;
        fh=/pjr7YFUfO/yuFsOqQnFlLdLVTQfOPYUqUT+RjJCqz4=;
        b=F6q71F9H/DtnfOGtnS1INB3UnFo3Wr/3cTgmtcCoeC/QNdzz5/Mg5JnVDSY82Fw2y+
         97LiHLaoWdO8BlqxUuOnZ1txlvN8sxeHvuSCJHnxgsmcTk5Qdxs420Sje049ASLMMe06
         8sL8q4Pm3Mrv6wV/WCUf9rZuN5klZq4vuZN8/RKvSXQIhc+BajCDZ2h8RFpK72b7qppU
         KDTHqO4130uNhRu3wbWtM1aAa3cJzOy8SUYQKAW8W3tKVyDZ1GFV8zwY7kGINxrvt12F
         vcvEfHbuLh5G7OGf9u92tGnzDGcRV7UvF8hXwo7f2bW8oAUAxUFhkDYVCTkD31VXSWyN
         XslA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777073348; x=1777678148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahCy8rxOvixjX2FA5ApDynwuvYGvOS/2mqLtTRZIyI4=;
        b=U59jFH2RZaWhC2NrhXvjUSGORQGvTktFBeEWaTWEhyUf7xoKBCCzTAHht+GryALqN7
         gyz39yLzB+gXJrCU4BoT4YxkXG1jJ+TtFuNlALH4nKWmw+TVZ7/mQAYv/p1nspfX+B9S
         Wirl+CMjSklBNeOEOAk8+rqBGPIdbisU2uIDvngaIv06XFMN00TTuKAKx1YEl3LnxIYI
         +8TTBlwbyT73q0MdYdOhom4Cdpm1q/gjaDwM/p7RMWy9Vks9DWEUcweRzQ3k7V67Iwp0
         qhF957fFds/CuWAYsIUxanVt7lbhlZfoIw9z1DTapSB6eTkpJRNLOIkcHkF9c/60968u
         CRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777073348; x=1777678148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahCy8rxOvixjX2FA5ApDynwuvYGvOS/2mqLtTRZIyI4=;
        b=OG5wLp5uiSMYznZ7IXSKirrwl03WSpE27WCDNCQolmuBuONKPkV8Dtl4VYTLZB4vTH
         GOkZEfCzKKE42n6bm4n4Ea9KyiHHK4w18kYUzCElC3tRbGoNUVTlARHK6kQeaX5WZdmP
         sIFHZgCYrefuR35fukD4kZhjLwYB39t6JBpY68Ry+HvWXB41Td/dMg4/rYc1YTnFgn+5
         N08tazRT5rgVJLzSZkPRdcIPHxD9PVTAWOy2V6jNu0MESfP2vYDx9frpP+E6fR2cGUiQ
         yInJXME1aRrkBfL9i3KBLj+1k1w0gWAmSKYkPRpdEhcZMA9WOIWn6+FXeBcrmWvn0IVT
         Z3UA==
X-Forwarded-Encrypted: i=1; AFNElJ8VzJxEwlZFSK0HKLTrcAH/6VoceqlwQ7EPsRxyJvmtuHZM47ZScpJTt0IQ66p+0P4npS0r3A0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/TdNwvg55b2C4HqcHAAVQ4eYolRpIuW7vT3OYhsdlklDL1OF
	xuHeStqzC8xp8nwNZPkSYJq5rLFqrqmiNoIsV/hC1OjpuK1l1iMWzvqRi8KAC32JBNjlxvNQDAw
	bNcTjR6mm2oMc7YZ7iebELjSbM33fIMU=
X-Gm-Gg: AeBDietlxTteK4Bm7P0fOfzs01MX1eFP2VYQZrq2m9/iJQ90JCjMRD2CBSzviDQ6Mia
	h5plqlSq3Kky2cYoB/hppbuFn96/pEeiLt7+Nxzj/sixXGIcBuvMUHdnndzTuFUn2h7cpeK2yFR
	SLlDQ0pEVUiXotHIdkMAlwCEZnGgc58VvGm0pEOxGBlRw9sBHBtMYTSjVLc/YgVw9sF5/02PNm6
	rnGkFMS8Wv1x1Hfj7+w5592y9B9jvWPsvMFCkdBphz4H8z4iHLDnSNSh/buB6NAbEgGNa2nnL8e
	kksQyV9hNcDVIxihXAuHiHxWSKTRf+7/p05IKCz+22rvUDHWSi8s9fFG6lvP2UUjqm/wUnOzpir
	xcTohMqddbofn8Mly0YIysXFm7i863aHpYdNR
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43fe3dfbff5mr53034945f8f.31.1777073348360; Fri, 24 Apr 2026
 16:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
In-Reply-To: <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Apr 2026 16:28:56 -0700
X-Gm-Features: AQROBzB_ndIthouIQciueRLu_dMM7bcPcCRP_ecesud5fA9xG1Ica2sIBP2K-bI
Message-ID: <CAADnVQ+ytaX5oq_1TjKC66dnjd1-yh3yjmPrP-kEg5wEvX643g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AF9D24640BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 4:10=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> I wonder if it's feasible to implement KASAN support on the verifier
> side in post-verification fixups. AI slop for illustration:
>
>   ;; Original (1 BPF insn):
>   dst =3D *(u64 *)(src + off)           ; BPF_LDX | BPF_MEM | BPF_DW
>
>   ;; Rewrite (~7 BPF insns):
>   r_tmp1 =3D src                         ; BPF_MOV64_REG
>   r_tmp1 +=3D off                        ; BPF_ALU64 | BPF_ADD | K   (ful=
l address)
>   r_tmp2 =3D r_tmp1                      ; copy
>   r_tmp2 >>=3D 3                         ; KASAN_SHADOW_SCALE_SHIFT
>   r_tmp2 +=3D KASAN_SHADOW_OFFSET        ; shadow address
>   r_tmp3 =3D *(u8 *)(r_tmp2 + 0)         ; BPF_LDX | BPF_B   (load shadow=
 byte)
>   if r_tmp3 !=3D 0 goto +2               ; BPF_JNE | PC+2
>   dst =3D *(u64 *)(src + off)            ; original access (fast path)
>   goto +1                              ; skip slowpath
>   call __asan_report_load8             ; BPF kfunc
>   dst =3D *(u64 *)(src + off)            ; retry the access after report =
(non-fatal)
>
> A sort of inline kasan directly in BPF.
>
> There are plenty of issues with it: instruction limit, exposing asan
> API as kfuncs, etc. On the flip side we get cross-arch support out of
> the box with no or mininal JIT changes.
>
> Honestly I'm not excited about this approach, but curious if anyone
> thought about this, or maybe it was already discussed?

We discussed this.
It won't work because we don't have that many temp registers for once
and second it has to preserve all (both callee and caller saved regs).
This is arch specific.

Second, we do not want other archs. This feature is x86-64 only.
It's being added to find _verifier_ bugs. To do that one arch is enough.

>
> > - not all memory accessing BPF instructions are being instrumented:
> >   - it focuses on STX/LDX instructions
> >   - it discards instructions accessing BPF program stack (already
> >     monitored by page guards)
> >   - it discards possibly faulting instructions, like BPF_PROBE_MEM or
> >     BPF_PROBE_ATOMIC insns
> >
> > The series is marked and sent as RFC:
> > - to allow collecting feedback early and make sure that it goes into th=
e
> >   right direction
> > - because it depends on Xu's work to pass data between the verifier and
> >   JIT compilers. This work is not merged yet, see [2]. I have been
> >   tracking the various revisions he sent on the ML and based my local
> >   branch on his work
> > - because tests brought by this series currently can't run on BPF CI:
> >   they expect kasan multishot to be enabled, otherwise the first test
> >   will make all other kasan-related tests fail.
>
> AFAICT this can be trivially fixed on BPF CI side, we just need to set
> kasan_multi_shot for the VMs running the tests. I will do that, your
> next revision doesn't have to be and RFC.

+1

> > - because some cases like atomic loads/stores are not instrumented yet
> >   (and are still making me scratch my head)
> > - because it will hopefully provide a good basis to discuss the topic a=
t
> >   LSFMMBPF (see [3])
>
> Apparently, KASAN reporting routine takes a lock [1]:
>
>    __asan_load()
>      -> check_region_inline()
>         -> kasan_report()
>            -> start_report()
>              -> raw_spin_lock_irqsave(&report_lock, *flags);
>
> BPF programs can run in NMI context, and so it appears to be possible
> to get an unflagged (because of lockdep_off() in start_report)
> deadlock, if an NMI fires on a CPU already holding report_lock.
> Although I guess you'd need two KASAN bugs to happen
> simultaneously for that to occur?... A rare event, I would hope.
>
> It could be addressed with either in_nmi() check at runtime, or
> forbidding kasan for NMI-runnable BPF program types.

We don't need that. If this bpf KASAN finds a bug, it means that
it found a verifier bug. All things are out of the window.
kasan_report() splat can just as well be the last thing that users will see=
.

