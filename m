Return-Path: <netdev+bounces-278560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAOEJ4KK3mm2FgAAu9opvQ
	(envelope-from <netdev+bounces-278560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:42:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A323FDBF6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47BA630209E2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7031E84B;
	Tue, 14 Apr 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJlMRDg+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF431DD97;
	Tue, 14 Apr 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192126; cv=none; b=UG8fBCL12zgx6VWBfjuSywLf28OzJnQ0Rkmp68Xntj67DmbHTspP7DWEY+yAL7pkXprG1ox5+88wj+vGZXySJFwzCA0c0XGZmiYiWFY0rVuCeqnJcINtpoT52QndQigOkNVOpyd3XYZJ8VsCUh5jLjGWtqHqRfTazIvOux8Xiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192126; c=relaxed/simple;
	bh=PIr13OXyvqQI13ILw4f4y0L0essgxoSoxIUr/ZMmVb4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=IUC1+kv4Q2lIvuwsawFNpZeFqJdFNS7aPRoZ2JXYI+c0Dfg+i6uUgq/pMjXx8WaDA2z+cBT0zOIS7FYMrxXAO6qoE3cxhStcsbmiXucgnqTbWsuJq9aI8wdsebyssLvyMEjuDNn3InA5gdSxwexz79X9y/88Cx9SZD9HhJyGF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJlMRDg+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D3EB64E425B6;
	Tue, 14 Apr 2026 18:41:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A0AB60410;
	Tue, 14 Apr 2026 18:41:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8DF710451333;
	Tue, 14 Apr 2026 20:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776192115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PIr13OXyvqQI13ILw4f4y0L0essgxoSoxIUr/ZMmVb4=;
	b=LJlMRDg+IR59Wd/DECLqU70wLASm1Z510eZOEYERg65QVMD7HevQcKcFSFn4ExyLIN9Wcu
	eZPRoEPIMbNNyEhW6ixrnG0gP6QRyaA64iP3a4hxRrbhU/QWuTCH4aZ36RE+uK8FYkyljL
	QUiKvI64VGrTMaDSQRwQ6Ot3AorBs1Y5UNJBo0jNrCvmEasqN+jIVXValz6c8fRSFOmKfs
	XAO75NGEjOi4zCGbhKMOvpz1fZ6pOrJyAVLNyiELzgr5CNVU14ocpDTafsWCkxnjHktiJr
	Q77KcdFV9qwJPOElw6PEmuEU5ULPjUTGDVeUrl1tC4ffCCtjAg2sugdc6CutDw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 20:41:42 +0200
Message-Id: <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
 <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
In-Reply-To: <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-278560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6A323FDBF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 14, 2026 at 4:36 PM CEST, Alexei Starovoitov wrote:
> On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> Hi Andrey, thanks for the prompt review !
>>
>> On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
>> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foun=
dation)
>> > <alexis.lothore@bootlin.com> wrote:
>> >>
>>
>> [...]
>>
>> >> +#ifdef CONFIG_KASAN_GENERIC
>> >> +void __asan_load1(void *p);
>> >> +void __asan_store1(void *p);
>> >> +void __asan_load2(void *p);
>> >> +void __asan_store2(void *p);
>> >> +void __asan_load4(void *p);
>> >> +void __asan_store4(void *p);
>> >> +void __asan_load8(void *p);
>> >> +void __asan_store8(void *p);
>> >> +void __asan_load16(void *p);
>> >> +void __asan_store16(void *p);
>> >> +#endif /* CONFIG_KASAN_GENERIC */
>> >
>> > This looks ugly, let's not do this unless it's really required.
>> >
>> > You can just use kasan_check_read/write() instead - these are public
>> > wrappers around the same shadow memory checking functions. And they
>> > also work with the SW_TAGS mode, in case the BPF would want to use
>> > that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
>> > that checks a single byte, but it can be extended in the future if
>> > required to be used by BPF.)
>>
>> ACK, I'll try to use those kasan_check_read and kasan_check_write rather
>> than __asan_{load,store}X.
>
> No. The performance penalty will be too high.

Since we are mentioning it, I did not consider yet any performance
comparision/benchmarking (and I am not really familiar with usual bpf
performance validation practices for new bpf features). Is there any
existing test I should take a look at for this ? Maybe some specific
benches in tools/testing/selftests/bpf/bench ?=20

> hw_tags won't work without corresponding JIT work.
> I see no point sacrificing performance for aesthetics.
> __asan_load/storeX is what compilers emit.
> In that sense JIT is a compiler it should emit exactly the same.




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


