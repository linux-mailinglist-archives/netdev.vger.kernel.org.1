Return-Path: <netdev+bounces-281271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKRdHIMl72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:59:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82F46F7A8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43A7307E570
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583BF377556;
	Mon, 27 Apr 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6fWitaV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B103A7F58
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280082; cv=none; b=klixqKlASdgBTSB9XqbQ0/9Bj9zNx8CxocaQbMfv3ZjKDqEyBCoH3FtsgySEOHjjIuR+revWsyZNfz2JbM3N2Bby1S32Hea2VgihyFCRwX5pnyfRXUVYCJIvTqoj7DA3pepQ53SQZCWMiRqPCWPoXY/6TX5ZAhRIjuK2MAmeiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280082; c=relaxed/simple;
	bh=dgk/faZOLQpUEXsQ40iSJFeDRRavJjkiC5juXZ4aZ6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=NDxM7xcw0LIn0QXszPLdA6t0QN5GxcV9PS9+4txkt+cqM8gzTj34jEfYDMQnIIpmgCealQDzLUHM2CI8jfMGGAuvvxzP+L9w0UdtO5q6LTIMbFDMZb79DIBELCuByO/NfUntiUj20uVamrqf3M/E8nY1+LagnX5YgD/le40pkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6fWitaV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 393004E42B30;
	Mon, 27 Apr 2026 08:54:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00C60600D1;
	Mon, 27 Apr 2026 08:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E6B410722270;
	Mon, 27 Apr 2026 10:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777280074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TXqEElTwN2Tki8IktRXTfIVL9D01k/xyxgMf0ctrAd4=;
	b=S6fWitaVDU/VTZT6yPZJGXT7mUzoaUUbLCjgB4vRC3fCgw3YaEa8rUxESSeQ4XM7sjxdld
	w2wJkszlpI/+wJv4VqWfh21mPO0o4KNiRTj9oqzk+O10QqDUfqSImMWvLhCIOcLEjFMtyG
	sUY57bQmm2xTj8ZjKaHYGBs4eCyHXGr/RuUPsVyddOb3ET/DEUbe3cIOjRYxQgYqhcHujv
	mmeRT0Ooj0pRPIPSI9VdRSjRGsZnUXRi8k6doRZ/9vcuXQtb+ezrvE5e+kTwdL2pM/S1MO
	LmYK6n6Izjxt4mzCaSxAD8ryLg7XzSE0B+bbHBjSDcwj2rcfoRc1SPkXzxFAtQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 10:54:24 +0200
Message-Id: <DI3T7A3A3LWQ.1WBAS2CWS2343@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
Cc: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "X86 ML" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <ebpf@linuxfoundation.org>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>, "bpf"
 <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "kasan-dev"
 <kasan-dev@googlegroups.com>, "linux-mm" <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
 <CAADnVQ+ytaX5oq_1TjKC66dnjd1-yh3yjmPrP-kEg5wEvX643g@mail.gmail.com>
In-Reply-To: <CAADnVQ+ytaX5oq_1TjKC66dnjd1-yh3yjmPrP-kEg5wEvX643g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BB82F46F7A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,bootlin.com:dkim,bootlin.com:mid,linux.dev:email]

On Sat Apr 25, 2026 at 1:28 AM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 24, 2026 at 4:10=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
>>
>> I wonder if it's feasible to implement KASAN support on the verifier
>> side in post-verification fixups. AI slop for illustration:
>>
>>   ;; Original (1 BPF insn):
>>   dst =3D *(u64 *)(src + off)           ; BPF_LDX | BPF_MEM | BPF_DW
>>
>>   ;; Rewrite (~7 BPF insns):
>>   r_tmp1 =3D src                         ; BPF_MOV64_REG
>>   r_tmp1 +=3D off                        ; BPF_ALU64 | BPF_ADD | K   (fu=
ll address)
>>   r_tmp2 =3D r_tmp1                      ; copy
>>   r_tmp2 >>=3D 3                         ; KASAN_SHADOW_SCALE_SHIFT
>>   r_tmp2 +=3D KASAN_SHADOW_OFFSET        ; shadow address
>>   r_tmp3 =3D *(u8 *)(r_tmp2 + 0)         ; BPF_LDX | BPF_B   (load shado=
w byte)
>>   if r_tmp3 !=3D 0 goto +2               ; BPF_JNE | PC+2
>>   dst =3D *(u64 *)(src + off)            ; original access (fast path)
>>   goto +1                              ; skip slowpath
>>   call __asan_report_load8             ; BPF kfunc
>>   dst =3D *(u64 *)(src + off)            ; retry the access after report=
 (non-fatal)
>>
>> A sort of inline kasan directly in BPF.
>>
>> There are plenty of issues with it: instruction limit, exposing asan
>> API as kfuncs, etc. On the flip side we get cross-arch support out of
>> the box with no or mininal JIT changes.
>>
>> Honestly I'm not excited about this approach, but curious if anyone
>> thought about this, or maybe it was already discussed?
>
> We discussed this.
> It won't work because we don't have that many temp registers for once
> and second it has to preserve all (both callee and caller saved regs).
> This is arch specific.

This "fast path" was indeed part of my initial proposal. For the record:

https://lore.kernel.org/bpf/DG7UG112AVBC.JKYISDTAM30T@bootlin.com/

in the "Basic instrumentation" block.


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


