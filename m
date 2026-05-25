Return-Path: <netdev+bounces-291393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rnN1A42OFGqTOQcAu9opvQ
	(envelope-from <netdev+bounces-291393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 609485CD844
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53B573013711
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2132573F;
	Mon, 25 May 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E5UBQEQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACE2DFF3F
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732106; cv=none; b=hGBs5KOXBRITd27gIsIffIdZt/14wetxx/v4qHvoDMANDeRW1Tn4CBScfFffewG0dCXvyICDN9SMnA4WUNss8LdYtsiLejdOfXuG7GnnCrZ2Ew7IqDzKXCFmMjqkYkVqvYJZgvcgGum5U2khcvRB3f4DA22aOBofPycOSRPmSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732106; c=relaxed/simple;
	bh=uQDtGl1GZehCkeUJvy50GOF0qMnGqzE+lOEJiutJFMI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Bta2tjJ1B3ud/yHlb4BnqC2KRmrlhk9oRPmVfgLt3kYdZXzpw7/Nfz1uK197BybO7tayVUHwihT2EgSefCiAjwGgQ6uoSTAh28xVGI+Hr/rTR06F96mTsDWG5KiAs38j6MkGYjjkp/gEoBl/uuTsnU9hw9CZGCZPsQtOGyeuVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E5UBQEQA; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1329fc4bf77so7608125c88.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779732104; x=1780336904; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzor4pOAcoXrq0r/dQWN3ieh5O1PmvSJQr5rj+ToVL8=;
        b=E5UBQEQAnOUrlMiUQguDe1X4CPzHyqtORL9Him/enfTHhgntKUJq8sb++nZzg5UVH8
         Cs6koqmuY+OjrtnYp5zwe5qPrGNPJX6OHnGK/ovag6PakFRACMjqo8mqAhmXbxJCGE8p
         9cGsPqMxKL5NApvUdNIV1jd92SLxwOpCz/W32Wc4iy6ncJL2JZQTe+D9m7boXFV/GABY
         7+Q0sR28LVPOmFt2TxxPQnUFeWJ1oyhOmKi92Z3joVWWmrXp256ZGgaNsUPixq3gVnmT
         mUxC8KU93bv3Tz2H3/7gM5rt4tTpbkBDbChuqf+bB4R0ZKqJofgD473Z8m5tvID/Las6
         2FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779732104; x=1780336904;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzor4pOAcoXrq0r/dQWN3ieh5O1PmvSJQr5rj+ToVL8=;
        b=EJ11GrhMRYrqQ9+DqayjLAB1z5upjZUCTp46VTLdzmOiUM9V++dcbZnozM85dKplk3
         OPxYByMejJ6OWVYqRPafZxPKD57Q2zTFDUAaXUyNCm1JcynUtCehNG8TWCJoY+h9z2kX
         PuKe+nPI4Q4IEhTJgEn4IpGpgeQKskyFeDyb/i1EK4bPZhNJWhf2CJuza84cbARMnvc0
         1WJTpvqSAVJ7AgROlz9dJGU9x/dxohP32VOfbXs1bMBrnRBRDaucNZM4t7GdtyT+vDRt
         VPRS5q+nYVgpMqdUWQbP3q5Fbent4Jv3JlQDfIymvn3MOrHhsAtZrleOAoidDR526Wwm
         6/8g==
X-Forwarded-Encrypted: i=1; AFNElJ9/ReJhHg3+usUWtwaCURSN9KW0AP+NqHVWRnY6Pfv9weOK9ePAQmdEGCZfN41w2woOQFQXGHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvUMhE2DRE8Z4Nk72mcWo6OqrfHMO8KsDVoN6fvHR1x1QKo4z
	Np9Py1JA2wxikWIt4iF3FKu22C5hpe7CYOyqErY53XSBkHrxekWEqzBaUcsO/MKfMEY=
X-Gm-Gg: Acq92OE0xu04ciLOancD6hjnJmqIfd60tShiKGmUFD5l4BZVUgTrTtGxrmRXHwklkWi
	cd1C4qynLhhyRQp+RYYnIXrOkFwKiYZpIv8hPO7O30YvDNon4HdLyNZzN21RIwLjNmeEvHHUTIk
	gnmXrLOf2twp3vjhynR3WeFSlPJspCCY/1ZALskLJwK5MJRZonfw+HJN4ym0JZEpvDYjQPldoRz
	DkIqCn3/mwftXK7qawTEqrqTQYTRyZK6mTyk4oADww8YCWhqxXPc4UEFFbmUl6X8gj9ewk2jjka
	bKEBWm7FDvsVjhdlMGJgt2twCIQnxPBeiPQyIC+HR/aB+kvvdWNTphe+VfJrEcJZtg6km3d881u
	/fwfoi8baesXeSxGvzWnPvC+htIeJmorpV5H6UpLrw1IFafWivOqxCMGEHyD0pFY5q1glItY+wP
	TGk7w=
X-Received: by 2002:a05:7022:ef01:b0:12c:8f92:c6ba with SMTP id a92af1059eb24-1365fc7b48cmr5378838c88.34.1779732103455;
        Mon, 25 May 2026 11:01:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cc2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e634csm7642048c88.2.2026.05.25.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 11:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:01:33 -0400
Message-Id: <DIRYDGLWJJWI.1PACVYJDRYBJ2@etsalapatis.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
 <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
 <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
 <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>
 <DIPDH3PCUDDG.EGYL0SYSG1IO@etsalapatis.com>
 <DIRMYUXFYOVY.1LQV9E3OHGGBK@bootlin.com>
In-Reply-To: <DIRMYUXFYOVY.1LQV9E3OHGGBK@bootlin.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,etsalapatis.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.247];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 609485CD844
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 5:05 AM EDT, Alexis Lothor=C3=A9 wrote:
> On Fri May 22, 2026 at 7:13 PM CEST, Emil Tsalapatis wrote:
>> On Fri May 22, 2026 at 10:14 AM EDT, Alexis Lothor=C3=A9 wrote:
>>> On Tue Apr 14, 2026 at 4:38 PM CEST, Alexei Starovoitov wrote:
>>>> On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
>>>> <alexis.lothore@bootlin.com> wrote:
>>>>>
>>>>> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
>>>>> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF F=
oundation)
>>>>> > <alexis.lothore@bootlin.com> wrote:
>>>
>>> [...]
>>>
>>>>> >> +config BPF_JIT_KASAN
>>>>> >> +       bool
>>>>> >> +       depends on HAVE_EBPF_JIT_KASAN
>>>>> >> +       default y if BPF_JIT && KASAN_GENERIC
>>>>> >
>>>>> > Should this be "depends on KASAN && KASAN_GENERIC"?
>>>>>
>>>>> Meaning, making it an explicit user-selectable option ?
>>>>>
>>>>> If so, the current design choice is voluntary and based on the feedba=
ck
>>>>> received on the original RFC, where I have been suggested to
>>>>> automatically enable the KASAN instrumentation in BPF programs if KAS=
AN
>>>>> support is enabled in the kernel ([1]). But if a user-selectable togg=
le
>>>>> is eventually a better solution, I'm fine with changing it.
>>>>
>>>> Let's not add more config knobs.
>>>> Even this patch looks redundant.
>>>> Inside JIT do instrumentation when KASAN_GENERIC is set.
>>>
>>> (with quite some delay) I think it would be better to keep this new
>>> BPF_JIT_KASAN, because aside from the possibility to use it in
>>> bpf_jit_comp.c, it allows to update tests affected by KASAN
>>> instrumentation in a nicer way. For example, the test_loader subtests
>>> that monitor JITted instructions are confused by KASAN. I can either
>>> skip them or make them smarter when KASAN is enabled for BPF, but in
>>> both cases, it would be nicer to just adapt the behavior based on a
>>> generic CONFIG_BPF_JIT_KASAN, rather than sprinkling some "if
>>> jit_enabled AND CONFIG_KASAN_GENERIC AND ARCH_X86" in selftests. That
>>> still does not make it a config knob, that just creates an internal
>>> Kconfig option that is automatically turned on when KASAN and JIT are
>>> enabled at build time.
>>
>> Having a togglable config knob gives us the option to set up KASAN for
>> the kernel but not for BPF, and I don't see why we'd want that. Imo we a=
re
>> already paying the cost of KASAN for the rest of the kernel, there is no
>> incentive to not run it for the BPF JIT. Having to eat the complexity co=
st
>> in the selftests seems reasonable if the alternative means a cleaner
>> interface for the user (preventing them from choosing an unreasonable
>> combination of options).
>
> Again, this does not expose a togglable knob, this is a purely internal
> kconfig, automatically enabled if CONFIG_KASAN_GENERIC is set and if the
> architecture-specific Kconfig defines HAVE_EBPF_JIT_KASAN (since we want
> it for x86 only), and there would be no way to enable KASAN for kernel
> only and not for BPF, or the other way around. What I am proposing is
> just an internal, architecture-agnostice kconfig to avoid conditioning
> some selftests to any architecture.=20

Makes sense, in this case this seems reasonable.

>
> Alexis


