Return-Path: <netdev+bounces-278450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iz5Neo93mn6pgkAu9opvQ
	(envelope-from <netdev+bounces-278450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 314593FA618
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D294301CCFC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAB3E6DC1;
	Tue, 14 Apr 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lhDeNvog"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E13E5ED1;
	Tue, 14 Apr 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172385; cv=none; b=kkXRgZD7pNSPnfRbRsWkO7Hm2tCYzuldfqre3W0HESc8DkcrSGcFiWl6OATJ2ZO9zULRnfuVPG05f19eq3MLB67w26NO+V8kQWUjHipsmHTZDnCSsbzoT72pJXt/lvpdbG9tEqVCb9Krw9SnsJw9DFB/F+KQmppqYaJI2x/9qZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172385; c=relaxed/simple;
	bh=ljtr9WPSUnaAjZD/FtGwji3II/sbFJuzXTsBaHKsQSU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=og6u0pqNO3pm/LfgF0jip1mEHdmoHeD0x3SmwerLr/d5yS1Dk7eUIwS6OMt8mrEK4tr3ePxdOZeb0tMlH/xBmyofrfrvKq7cEF6Rre5cUrfpG3bYlovVPBASaIuXqnjKkyogwNdVVJeRPHvzPhQLKuBDxIA0aijKpqOA5/qVmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lhDeNvog; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 932294E429EC;
	Tue, 14 Apr 2026 13:13:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46E3160410;
	Tue, 14 Apr 2026 13:13:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 569A6104500A2;
	Tue, 14 Apr 2026 15:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776172379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ljtr9WPSUnaAjZD/FtGwji3II/sbFJuzXTsBaHKsQSU=;
	b=lhDeNvog7+cXfwfKejAzO+yVIre7KeKOh4nxhyYR84tw7Qhs4CDNLFYshF/sNo/ddcHeul
	OAXDnRRPYFfdKmNFr6FNXLWBgkwR5bSerHfi1jG3QAuxmeyq9DKVn4ADpvD+k/LktKcxCV
	Qo+C51KQYvBPk2tQWgzerrUX38wX8fl9mns5nowg6aBHUe0QUCDETlFcTsN3Vd+g6AhDW1
	t0+PPdVn0VXoKLO/NdWsu8xr8pa5SfFsPWlNHjagwF2HUg4Jwz/bTTtoEDbu5jNS5UXcqe
	/1a7m2ycQR5Rypiiam1nxF1Kid65dAD8mzMdsDqIpVAnb6rsDVnu+pzT2qXnlw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:12:47 +0200
Message-Id: <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Andrey Ryabinin"
 <ryabinin.a.a@gmail.com>, "Alexander Potapenko" <glider@google.com>,
 "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrey Konovalov" <andreyknvl@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
In-Reply-To: <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-278450-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[40];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 314593FA618
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrey, thanks for the prompt review !

On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>

[...]

>> +#ifdef CONFIG_KASAN_GENERIC
>> +void __asan_load1(void *p);
>> +void __asan_store1(void *p);
>> +void __asan_load2(void *p);
>> +void __asan_store2(void *p);
>> +void __asan_load4(void *p);
>> +void __asan_store4(void *p);
>> +void __asan_load8(void *p);
>> +void __asan_store8(void *p);
>> +void __asan_load16(void *p);
>> +void __asan_store16(void *p);
>> +#endif /* CONFIG_KASAN_GENERIC */
>
> This looks ugly, let's not do this unless it's really required.
>
> You can just use kasan_check_read/write() instead - these are public
> wrappers around the same shadow memory checking functions. And they
> also work with the SW_TAGS mode, in case the BPF would want to use
> that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
> that checks a single byte, but it can be extended in the future if
> required to be used by BPF.)

ACK, I'll try to use those kasan_check_read and kasan_check_write rather
than __asan_{load,store}X.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


