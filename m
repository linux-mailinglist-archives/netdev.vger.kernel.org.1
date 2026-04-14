Return-Path: <netdev+bounces-278578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JpEIDen3mlIHAAAu9opvQ
	(envelope-from <netdev+bounces-278578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F83FE6BA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAB3302AE2B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF772347515;
	Tue, 14 Apr 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tp0oFwTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D42345CAA;
	Tue, 14 Apr 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199474; cv=none; b=ayDAx+TeySqL4xuq7THVVppCSRTLWIxZ+P1SRrTDUjDc2JrCJfk6uF2r2jGfxA4OJ7sxA+SAqo44LJPrsNy3TZ/O94htwCZEXVr3JuSw3sAABVFUL6UZXE3j4NwcEqtr+4dPyQ/eH68E9X+3+smEX8PsU+2m5EsXme5hWaQR7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199474; c=relaxed/simple;
	bh=L8bWJr7FXUdlTXBxL69DdsJ20JowQnELYHkBWQ0j71o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=ZmWG5uszWwbTG1lnUg84uX4Yyr6i3SRSfCm0DY7HTbbb+xRkzOXfHhK2lR32+a4IYrui09SFtr/Z53ZGkYJeRX3qn2kLM/ZB+SVPOkCaoiqbf/a26b8XML4fev8wzAAbAeL7C0UbtMdP74D8cLQTdDHIkAiL/Ubk25KgeAUU+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tp0oFwTf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 36C6FC5AAB7;
	Tue, 14 Apr 2026 20:45:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCCED60410;
	Tue, 14 Apr 2026 20:44:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D13710450F98;
	Tue, 14 Apr 2026 22:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776199466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L8bWJr7FXUdlTXBxL69DdsJ20JowQnELYHkBWQ0j71o=;
	b=tp0oFwTf5VHzsnEQcoI6YFXubpXr48s6UWlXK4aDR8EDMSSF+/OjNf6hUwJE2BAbHAdgPz
	v2f4A8tTxVtK7dqJZfFAdjP+hWDl0Fam9eGGy91tNDrdqr1jGCVU5mlUKQsx7dKkw5Fj/o
	8xB9Inm9XOYYzG+OqKhmNW03MF+ALRZMBSynxDWIF5QBxopuN97KxRbIxhOyfKSB9o6wkS
	91454gD3J6J7wN/TaEOT0JgO64Dp+ztksnjtLIOwoMGIkVJ9RQPJZYo6iGmJA9iAtEHlyl
	YSu689PmkWekOvBlF+bpB2iuXK1nNSBHe1tFVeClAIGo4vy+Vjuo6lCfP898kw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 22:44:13 +0200
Message-Id: <DHT65O6DS001.14GNQMXFJZHTN@bootlin.com>
Cc: "Andrey Konovalov" <andreyknvl@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "X86 ML" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Dmitry Vyukov"
 <dvyukov@google.com>, "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, <ebpf@linuxfoundation.org>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>, "bpf"
 <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "kasan-dev"
 <kasan-dev@googlegroups.com>, "linux-mm" <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
 <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
 <CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+DiJ0XKSpyYfg@mail.gmail.com>
In-Reply-To: <CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+DiJ0XKSpyYfg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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
	TAGGED_FROM(0.00)[bounces-278578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[41];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D57F83FE6BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 14, 2026 at 9:16 PM CEST, Alexei Starovoitov wrote:
> On Tue, Apr 14, 2026 at 11:41=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> On Tue Apr 14, 2026 at 4:36 PM CEST, Alexei Starovoitov wrote:
>> > On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
>> > <alexis.lothore@bootlin.com> wrote:
>> >>
>> >> Hi Andrey, thanks for the prompt review !

[...]

>> > No. The performance penalty will be too high.
>>
>> Since we are mentioning it, I did not consider yet any performance
>> comparision/benchmarking (and I am not really familiar with usual bpf
>> performance validation practices for new bpf features). Is there any
>> existing test I should take a look at for this ? Maybe some specific
>> benches in tools/testing/selftests/bpf/bench ?
>
> So far everything in bpf/bench/ measures bpf infra like
> maps, kprobes, tracepoints, etc.
> We don't have benchmarks for bpf programs.
> So we don't know how well JITs are generating code
> and how much inlining done by the verifier, JITs actually helps.
>
> Puranjay is working on creating a SPECint like set of benchmarks.
>
> For this kasan work we should make the best decisions from
> performance point of view, like not wasting unnecessary call
> and not saving unnecessary registers. btw in the other patch
> I think you can skip saving of r10 and r11.

Noted, I'll do some checks and tests without those two.

> But we cannot quantify yet that avoiding extra call gives us N%.
>
> You can micro-benchmark, of course, but gotta be careful
> interpreting the results. It might be too easy to get into
> thinking that JIT must inline __asan_load() for the sake of performance.

Ok, interesting, thanks for those details

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


