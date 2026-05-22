Return-Path: <netdev+bounces-290888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOp9DpKQEGqIZgYAu9opvQ
	(envelope-from <netdev+bounces-290888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BCE5B818D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15D77301910A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AFC407575;
	Fri, 22 May 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mb5avOus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCF3BB9F5
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470022; cv=none; b=GM8CUaKQvpGq9HF0acyi0llQZkj1rPcCiduMqPFRoiz/WPUV4mO0qP0JiIg2DVHYfke4DuJYm4zlvGXik341rCEl6B77JwBuoUEmGB3oBp7BjHnJLq915d5PvNZlC+qOkM2dqgq8W/iU2vJbAXbN2phsxGiz0Umoq2uzz7Lm0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470022; c=relaxed/simple;
	bh=a+CInxeSB1Zqe7+X7tbNilMFXAdB47JkuFSLHzgtQp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Kd7YUuAdSc3qgRtOFrsg+RFI2LBpkPXaAK2Q5Y20FkGL3eVufk3NjX3Gt61/ztrpfcZXXjw0FL7Z6dNSttSVnynw10f29mf+v+EwUjhhYioS8CejtUWFQj6Olj7AkXSTP3Jaq3EE0NFE46yAiKd9m7CRbSu+/Z7q2AI55phus64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mb5avOus; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f0ad52830cso9805417eec.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779470020; x=1780074820; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY4I8lMoFI92sp/KvSm+KBFNyjnf2+5FqBSVyBYIdTY=;
        b=mb5avOusvH++FgQcBBfSDMOsB1NyLQKilnVtcHQxyJBsnXRzm8q4NnE7ilDv/f/pnL
         h7SgTyEQyWIQknSdq+vG2gLE0yQyhn5Hdk4du3LBRrVNfY5p4c095DyH2/28wqcdxVgj
         KABArBH7YfUiM7LF7AAroA/UIdMn5oSDk4+13FWGXmk0UdrpNQzkB6l4idqTrTh8YCIN
         2i592+RByhRugCuxZ2YQuWOjRnKhZMPwKQwZFZm2mhXu2/4XITbQS7bEl9bi5oaNd+HL
         XOIKThbxeedA0VS0iGfhfz80NsrYsQ9xnAvCi0uBKHRCGPvAnsbXzZflULPXAKGgYrGM
         jb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470020; x=1780074820;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY4I8lMoFI92sp/KvSm+KBFNyjnf2+5FqBSVyBYIdTY=;
        b=e+9fBKD1BjdUJklljIgskm4pqmTJZIgmZ2kviPvOd3liFPWXswEYtVaiGtT7s9zsgD
         fejNEn7k3hLatWqDl3PjStZnq0sc+EsiULVcNlS9ctOjBQVR3BzQNP2UWFmUcjj/D59b
         CRN10FQYEsbZjQq04pne9gJwloIfFvRK9S+S58/Kn/qVtlexWIJdOnV/cgNps6PIYsb9
         uwkMe6NXG3QYiEdT2ugJZyvK/11aoLBp5XypvsJiEtTw/vrwed4vMAqt3quIkmVng4ru
         9Jjbq6kZlxK5Mt8Hr56yMfiSZv314dIhxadROmtXmUzNAKhnIqkVNjJ6ZJ78DiHeywxe
         Dkzg==
X-Forwarded-Encrypted: i=1; AFNElJ+EkgHslolK2Gr23Iz1qO9+y0RsI1+gB10qLaU9BzGBbPK15OTiUeBvxgmtVDj9YHVWEQXgcmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP17PfGbXQQLlxE86ziNGLkis5wnvH6yAH6TJ38DQCMZzh/Myw
	5xPaKVgPo7JjD6alxA4Ty+n/jxnCwGB24gTc1U9qxtOvIBD5PxAF6BzAEp1q861jjd8=
X-Gm-Gg: Acq92OGaMwoWMVm5DBUYuNMw2TMTxqA/aiLQ/EWhQbkNqsGA72cckywZK/ldh6wsDwV
	0kqEzx/guWIitro0T37RboHzKJT3gEbB5L9ZS4H1fKJT5UwAn4JafB+8O/ozXBW3mtbGrP2AkF7
	pC87yj3YW4RIQk5VbRgUiLXZ8X57GFMoAM8LJqxhxvB+pMgNYMFKsstCtfEMmpuOgnSpM1mNY4D
	jde62cTc3V57jRsQdb6nwCSH1qg6szEY7+XC/bDZ4pD//r73XC/FoaJXgSUYQ/HkcZVyBFHF6Bb
	NkPPvEeQIAb7QZHoy/Na4OhWli+eylzG9QNYbLCORa8Tfet2RJyiU6lcB8KBPbODlCNEVLXBCM8
	YXNJkhJILaFksxMf1z2NQlLCA5jyTDv50iHZ9JBHmVuH9V28ibh/MKR6W//LUInrIE7mGFjcqn/
	qUhfHX+hRSjsZvNEU=
X-Received: by 2002:a05:7301:168b:b0:2be:833c:149d with SMTP id 5a478bee46e88-304491e11fcmr2091389eec.28.1779470020197;
        Fri, 22 May 2026 10:13:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::69da])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm1872911eec.13.2026.05.22.10.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 10:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 13:13:35 -0400
Message-Id: <DIPDH3PCUDDG.EGYL0SYSG1IO@etsalapatis.com>
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
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
 <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
 <CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com>
 <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>
In-Reply-To: <DIP9O3BEWG3C.2BAHKYUIA4H4E@bootlin.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290888-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	DMARC_NA(0.00)[etsalapatis.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.159];
	RCPT_COUNT_TWELVE(0.00)[41];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0BCE5B818D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 10:14 AM EDT, Alexis Lothor=C3=A9 wrote:
> On Tue Apr 14, 2026 at 4:38 PM CEST, Alexei Starovoitov wrote:
>> On Tue, Apr 14, 2026 at 6:24=E2=80=AFAM Alexis Lothor=C3=A9
>> <alexis.lothore@bootlin.com> wrote:
>>>
>>> On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
>>> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fou=
ndation)
>>> > <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
>>> >> +config BPF_JIT_KASAN
>>> >> +       bool
>>> >> +       depends on HAVE_EBPF_JIT_KASAN
>>> >> +       default y if BPF_JIT && KASAN_GENERIC
>>> >
>>> > Should this be "depends on KASAN && KASAN_GENERIC"?
>>>
>>> Meaning, making it an explicit user-selectable option ?
>>>
>>> If so, the current design choice is voluntary and based on the feedback
>>> received on the original RFC, where I have been suggested to
>>> automatically enable the KASAN instrumentation in BPF programs if KASAN
>>> support is enabled in the kernel ([1]). But if a user-selectable toggle
>>> is eventually a better solution, I'm fine with changing it.
>>
>> Let's not add more config knobs.
>> Even this patch looks redundant.
>> Inside JIT do instrumentation when KASAN_GENERIC is set.
>
> (with quite some delay) I think it would be better to keep this new
> BPF_JIT_KASAN, because aside from the possibility to use it in
> bpf_jit_comp.c, it allows to update tests affected by KASAN
> instrumentation in a nicer way. For example, the test_loader subtests
> that monitor JITted instructions are confused by KASAN. I can either
> skip them or make them smarter when KASAN is enabled for BPF, but in
> both cases, it would be nicer to just adapt the behavior based on a
> generic CONFIG_BPF_JIT_KASAN, rather than sprinkling some "if
> jit_enabled AND CONFIG_KASAN_GENERIC AND ARCH_X86" in selftests. That
> still does not make it a config knob, that just creates an internal
> Kconfig option that is automatically turned on when KASAN and JIT are
> enabled at build time.

Having a togglable config knob gives us the option to set up KASAN for
the kernel but not for BPF, and I don't see why we'd want that. Imo we are
already paying the cost of KASAN for the rest of the kernel, there is no
incentive to not run it for the BPF JIT. Having to eat the complexity cost
in the selftests seems reasonable if the alternative means a cleaner
interface for the user (preventing them from choosing an unreasonable
combination of options).

