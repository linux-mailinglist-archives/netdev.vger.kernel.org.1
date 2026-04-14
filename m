Return-Path: <netdev+bounces-278481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM+jI+dQ3mlIqQkAu9opvQ
	(envelope-from <netdev+bounces-278481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4933FB5AC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 859FF300DF5D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5348264617;
	Tue, 14 Apr 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUlTTsC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3373E5EE2
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177379; cv=pass; b=aCj3PbrsJGMfI+kPBvsbyqnxbpKjHxDydb9gIvv5M6IrHF5yeunoetzEhvUR0+ff3suNQApXkq0urgms1nGtvuGWiODj3SdqmObte+QWS98NncYu2XQYp8MakxYIK92HfL/GgWKCFZmENaSmM46mDL6pFMt2vWaJEge/48PRQJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177379; c=relaxed/simple;
	bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqnYYBYlyMNySY92pFf1JJ2T9HRVjVjL5bp3ZIcRgrwPaCevgcPzRuv76NHDxhcKTBmxyyiSl9FzhmLhr3P/wDdTnF29OrtLsidKLpMGqtcyEJ/JjCLuCQuvENSTavCfsA5tgnJI3o1mI24X3YgXFnP7nvkWoeRX/zJCD+XZ9Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUlTTsC3; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0046078so56503185e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177377; cv=none;
        d=google.com; s=arc-20240605;
        b=JrFYWDhNE2IXXI5AC8W9tlbfZdbE2+slMrVXOY53IdiaLLmKfilI7XSA6W1isvr/6Z
         h+5FiZAi0Gl7gwbG7PpAle5J9DRTbTryl5M9GOmMuLx4fsQVo5I/pC0y7mbPlkwER5w6
         odBtU0m5bc4IAWu1E+LsvJWQ53VjQH0N8hf1kHuZufzgGUwTaNgys4cMhAlHHzMepEzS
         n5wpXIxBIpumXkdJotu0US0YGR4u2UEaf+HqSuj6gcyIeg6crLpu/eXKRBj71tvIf2t8
         QPJprtOqOdsA7prSpMksb5kYsO92SjnDMfp+I/Akq/7qyK75naSKNLPUoRgJTXTBvVmJ
         8K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        fh=ZpTgs066N03T6bE06c0HnnNPXO4BQju4jKXb1gvsvzA=;
        b=P4MXwsjuMV5/PO0Ew/hnbHf9nbuFv9wBg74KF5Y90LnqrJvD80JlAi7ZuYk8z036R7
         2p4p2jwmPT6iiWiSVyNV4RMniWfcSv1QUyGkqF0zAB4WQjJMdPKOPuN1KHdaang2ESpr
         CiI2RgPmcvaGRlWT3c0ZmQxqyyDOuuX675HoiamDJI/h0I5m/WfrWt1n0crktKeIkLm4
         AEaASdwUVlbMizZTLimvkG2JARknhvEED+0sCm546JbQ1U8x0BnkZM32ZX6abl+v8iLu
         AjaaqFHIU7JV6fAIyDFnJY0jIFIwUTXKz+jF3jPvJFHfxRF6jqflGOJZ/AReO8evenhl
         qn+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177377; x=1776782177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        b=PUlTTsC3aVAA+ZyekIkeHjny6kIG/LHQHmycQcAXH+odg5/6txPL3MKJH3GJyCQkHB
         0VHbMgZt+XaHaCWA8ttAcZZRvO9ODJnXuOO+uOmKq04OuxGu3oOF05P46AdjIMAgq75p
         1g2iSwJfqj1jIgnuoynfpGVWG9myXYm/pK7dBPifH9KZ0tNoF/wBaemcMV1l1xlz8J3/
         ZWuFPRlIE6qzOnT4UWRA/IGRTHcr8Y3+4IdOq2AILgI1Oof/ygFLMrlBqux+n4oEboCa
         Je1BfpUWrlRD9q+IG7jTww/eAr705R3WQH9YwLOz0cBjR8AkMQxl/K7pKJ6lWajvDIts
         hEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177377; x=1776782177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnsEV6VHaHqEew+Xa56Ltrfs2MD3YtoIUeXjaty5EkY=;
        b=TswxW4zCiandvEgZRtzma62+wrlBJZTLxwUaxeGfXyf6MSs2HHaeTaWKWbSKVMixxG
         8hYG8nO1N9qQd1WvMuo/GHIoaBuUokCUdh6PIM3g3rIr6iivLnGhzfLBzkjJzqXKna+N
         d3gt/vwEEt16ocyotUvUAVz23PqqzOLZ/B808nDd83sTSITw1Oerhmg9Jk0FRbCuTZFt
         LbUGQZRDHUfmvFprSKt74pmIrUloZolkoJ/9KtYKYPxuUxKzYwy7Ktulws44oqKK7Mv5
         Hbs2NuN72goXbMDhMkJEyK6BDhNhbN00Ik5d8E2ycB/9xbJ1lVJzI5CFrQ39+nvNkqkJ
         g5Ug==
X-Forwarded-Encrypted: i=1; AFNElJ9Li6GDJHHGkK4QbwYs5R+AJ/qsxyQTdTgYtoaTf0YH0w9xxURLp0Ylwb4XsIqQDVVvNBO83qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7Hr3MQh1Rse1EWrH2qJ2edUzxKFYUg7MzqfYFVnWWp7+4T7R
	I+ko5GBO3NjFRqEVToWeUylK7Ni/4GCZsQsn7ipEw/OuYofRF3LRIQp3lWrLi9uPjV7OYaz5+Wf
	JpdjT9ynLb4eHvOAvJ3aA1BX6iRR1xec=
X-Gm-Gg: AeBDies24w+PE0Nj7e5BuoiwOQSdbABDn+lNpxFnhKFLQhf5cnt5s/HE+bTFo8IOlfR
	Mbm9NiDKmWSkRcBAEi4y9xcBPcEWgvhSUP5g2BnLBcPzq7mfuH4GrGKWA/C0eIkbMszgTZpb4cz
	OX2D5BPsljKK9SP/PusnG2pDmi9rA2+zZbaRl+OvULYskY7w43/llDg49pz6Z9GUFIeRIxel7Gt
	El32LNRlbpajDFg/84K/QrrG42EbJGzeF152Ow03UUyyYQ2kMqldsxJHLqpFMBGbTR1jDVVWSgn
	SlzYbv1VRieD2ImTkbqRGiLb0+M5p7O+TIDGrE9uuVXXh83r8FkX3wgtneFHYMKZB7ZhD6EFNhK
	nprjQ2P0lGLnJplEzqITWicrp+A==
X-Received: by 2002:a05:6000:1a86:b0:43d:6e0:9458 with SMTP id
 ffacd0b85a97d-43d642c08b5mr27685966f8f.39.1776177376758; Tue, 14 Apr 2026
 07:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com> <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
In-Reply-To: <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:36:05 -0700
X-Gm-Features: AQROBzD11iC8gAKSEnmD0t_Id88yG4ZENQr7azgzst5W9dho6pOaDHcgJ_Mytlo
Message-ID: <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 1C4933FB5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Andrey, thanks for the prompt review !
>
> On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Found=
ation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
>
> [...]
>
> >> +#ifdef CONFIG_KASAN_GENERIC
> >> +void __asan_load1(void *p);
> >> +void __asan_store1(void *p);
> >> +void __asan_load2(void *p);
> >> +void __asan_store2(void *p);
> >> +void __asan_load4(void *p);
> >> +void __asan_store4(void *p);
> >> +void __asan_load8(void *p);
> >> +void __asan_store8(void *p);
> >> +void __asan_load16(void *p);
> >> +void __asan_store16(void *p);
> >> +#endif /* CONFIG_KASAN_GENERIC */
> >
> > This looks ugly, let's not do this unless it's really required.
> >
> > You can just use kasan_check_read/write() instead - these are public
> > wrappers around the same shadow memory checking functions. And they
> > also work with the SW_TAGS mode, in case the BPF would want to use
> > that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
> > that checks a single byte, but it can be extended in the future if
> > required to be used by BPF.)
>
> ACK, I'll try to use those kasan_check_read and kasan_check_write rather
> than __asan_{load,store}X.

No. The performance penalty will be too high.
hw_tags won't work without corresponding JIT work.
I see no point sacrificing performance for aesthetics.
__asan_load/storeX is what compilers emit.
In that sense JIT is a compiler it should emit exactly the same.

