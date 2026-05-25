Return-Path: <netdev+bounces-291269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHz9OtARFGpeJQcAu9opvQ
	(envelope-from <netdev+bounces-291269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:09:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977815C85D0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0029D30158AE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF773E5A1E;
	Mon, 25 May 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fx+Uvlj9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F723E5584;
	Mon, 25 May 2026 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699946; cv=none; b=Brich36AnOFAU34FfoGVdI8aXqJ+meJVfZaX4YHxfQk+Fh5/mKW9iz5IExVNFFv/fi7+9MmuUQplVrDhypl0D1x7pK1DHdrvjnxzu5okfVn5Ti/STZrdn/0/mkbJ7EF4SFa3+f/c1kh+Kt5FzRd40lqtqOPfqpF8IVKwSrIPsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699946; c=relaxed/simple;
	bh=YGBgB8DKElrV4R88Fy3fqbu8+6iow6N9sAidpgWS8Vc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=r+7ZSwAg+s3VvmlbeQ6Kjr4rWyryda7WwHa1Pd+7phYh8PsAFPemaxvxziOgMUM2lGFPGsViPovwLPcjpeS6G0/8g2slQc9J4Xb67tLvZXkv46B1lsf0gFl1/gpnrU6N+ai7ZJ3V1vsYppcZ9SdexKmdlpjTCIkGalsUgdN9kbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fx+Uvlj9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 92C751A36AE;
	Mon, 25 May 2026 09:05:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54B44603DC;
	Mon, 25 May 2026 09:05:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B71FC10812103;
	Mon, 25 May 2026 11:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779699932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EbTl273WowpTVFd0f4oge0/+s8K6R22iN2Gqank6L1c=;
	b=Fx+Uvlj9hDV8t2hT+BbSnAxNsdOpOaJIechqvnvpMOkSitZzXRjbsdPmMEWqyKUFfSsFqJ
	09p3+5rjCc8SD5giFz2CNAPnkmaK402kZ1+6NUodo6410UYt45sJg+eUEcarYV6jiVsG7K
	3r7plioTNGCAIgXGCNJ+2+ZTHyduDJ07uQslX/NevZyhzexSjWxmYTd3uD3CWiJVY0Dx6L
	1Io8kWVF0On9LOxU2++gFB1HzzqUg55GF2+VuffbtA126LB+ZWF26BfdlTvZICqiAoOO3B
	zd+yqqxctwthai14JAAAUMFcgFwq3eBOVqm4oxh90R+vs0N3KX+iOH5nwmbVzw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 11:05:16 +0200
Message-Id: <DIRMYUXFYOVY.1LQV9E3OHGGBK@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
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
To: "Emil Tsalapatis" <emil@etsalapatis.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
 <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
 <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
 <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>
 <DIPDH3PCUDDG.EGYL0SYSG1IO@etsalapatis.com>
In-Reply-To: <DIPDH3PCUDDG.EGYL0SYSG1IO@etsalapatis.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[etsalapatis.com,bootlin.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.506];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 977815C85D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 7:13 PM CEST, Emil Tsalapatis wrote:
> On Fri May 22, 2026 at 10:14 AM EDT, Alexis Lothor=C3=A9 wrote:
>> On Tue Apr 14, 2026 at 4:38 PM CEST, Alexei Starovoitov wrote:
>>> On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
>>> <alexis.lothore@bootlin.com> wrote:
>>>>
>>>> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
>>>> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fo=
undation)
>>>> > <alexis.lothore@bootlin.com> wrote:
>>
>> [...]
>>
>>>> >> +config BPF_JIT_KASAN
>>>> >> +       bool
>>>> >> +       depends on HAVE_EBPF_JIT_KASAN
>>>> >> +       default y if BPF_JIT && KASAN_GENERIC
>>>> >
>>>> > Should this be "depends on KASAN && KASAN_GENERIC"?
>>>>
>>>> Meaning, making it an explicit user-selectable option ?
>>>>
>>>> If so, the current design choice is voluntary and based on the feedbac=
k
>>>> received on the original RFC, where I have been suggested to
>>>> automatically enable the KASAN instrumentation in BPF programs if KASA=
N
>>>> support is enabled in the kernel ([1]). But if a user-selectable toggl=
e
>>>> is eventually a better solution, I'm fine with changing it.
>>>
>>> Let's not add more config knobs.
>>> Even this patch looks redundant.
>>> Inside JIT do instrumentation when KASAN_GENERIC is set.
>>
>> (with quite some delay) I think it would be better to keep this new
>> BPF_JIT_KASAN, because aside from the possibility to use it in
>> bpf_jit_comp.c, it allows to update tests affected by KASAN
>> instrumentation in a nicer way. For example, the test_loader subtests
>> that monitor JITted instructions are confused by KASAN. I can either
>> skip them or make them smarter when KASAN is enabled for BPF, but in
>> both cases, it would be nicer to just adapt the behavior based on a
>> generic CONFIG_BPF_JIT_KASAN, rather than sprinkling some "if
>> jit_enabled AND CONFIG_KASAN_GENERIC AND ARCH_X86" in selftests. That
>> still does not make it a config knob, that just creates an internal
>> Kconfig option that is automatically turned on when KASAN and JIT are
>> enabled at build time.
>
> Having a togglable config knob gives us the option to set up KASAN for
> the kernel but not for BPF, and I don't see why we'd want that. Imo we ar=
e
> already paying the cost of KASAN for the rest of the kernel, there is no
> incentive to not run it for the BPF JIT. Having to eat the complexity cos=
t
> in the selftests seems reasonable if the alternative means a cleaner
> interface for the user (preventing them from choosing an unreasonable
> combination of options).

Again, this does not expose a togglable knob, this is a purely internal
kconfig, automatically enabled if CONFIG_KASAN_GENERIC is set and if the
architecture-specific Kconfig defines HAVE_EBPF_JIT_KASAN (since we want
it for x86 only), and there would be no way to enable KASAN for kernel
only and not for BPF, or the other way around. What I am proposing is
just an internal, architecture-agnostice kconfig to avoid conditioning
some selftests to any architecture.=20

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


