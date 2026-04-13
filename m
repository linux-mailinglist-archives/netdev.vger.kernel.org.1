Return-Path: <netdev+bounces-278214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB/eEhps3WlNeAkAu9opvQ
	(envelope-from <netdev+bounces-278214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:20:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5E3F3C1A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D28F302BB84
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA539150D;
	Mon, 13 Apr 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03i7k/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF3346AE8
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118806; cv=pass; b=P6O3AnNGxNdMIAGn0D+TkXnD88Yk3L0FOfhIXsRFmYxZqAMvDJJrgtjJ6luhirR5D4LCkHh4O/kjd0tGuyO9bZoPejRk0It6qYC7wB9yHJNXt93liHsiLGlXYBLWwp1oTNQASqxLCD4DuAor7jB2QpN0HdSkRsl36CSqw9aR6jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118806; c=relaxed/simple;
	bh=kNKohDEFFmW+7dpbriwJO4wAUSXkwkDI/vzNUTsWEFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW6ZSJDL8OzHHOu9QLZkKBXEzfwc88R20KuNconJikeJvH9kV2DpfQvqcCwlVcCSAJCbUCc5bn7M0SVr9RxwfbcDrjznBuaX0QHwLW/HHIiLQW/mxly4xDk6sPkN8FtJ0BA19YZiP1bC+FpiulZHe3npjE5y8TA7rvQziy++cT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g03i7k/S; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso4667578f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118804; cv=none;
        d=google.com; s=arc-20240605;
        b=LJhPTjaSf34J19ltRaxibNLT5ODf6nT3e885g+QzVgElkj7aHCWCBy4ov2UG6P1/dx
         qfL/34OnX4td9AURxG3XQjNt2zI/Z9CwLlufWLBxOXYFtUB3ujLVvEAp0d+zTLrek1B4
         3/KiS1pOMM/Qwmu9hTOXiiCRw6nN0yDE0CcyQ8TK/ife2gw29rYGFwVELrUMybSxSLMJ
         GilvYuMgWJts4v/XQpVi3Vld7hz+2Cx7C+whzbeN2rEUUiCNVzsTn5pnOwSaLBrrFlAm
         RKipEqy3LXaCw0HSZyWWLx0O+iUMmqaQ1RwFsD9d7f1xMUPdOjCc/2Rrmf38wVviXJeI
         YZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        fh=psIAELbjS72gvDTkTTrRHVm4TcDsvwW8Fi7Wsn0HSQo=;
        b=HCAW12tSNaYbw/uribLPFni932BA/Gj1ncVpNeQ2Sp96/fXLNh2+GIo7hVH0IKC2Is
         IdlGmdXkhvNideW1pOv+3HZkSSu8HUtZHs47Yoh9Z4J/OW6ItNJLMmqETsUhWMVKbl6u
         +NU49WeXCP2fQQZbndvjiCxczObIjjUrI5ucYPGLedMe9wQkU/CHd9HwpjsUDVzPSfAT
         4qrpSBxM2M+gke1z18FSA8ItvJsP0jTwXDHZOLVPtt6Hn38GIx2TT55LIndvLzj40o87
         rJ6Z+iiELNdGPjCJAN5DIjUuNDXsRvLpneI9krXxDTES2eNjlMgWIxlhVfmvxB9WCYsN
         6rHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118804; x=1776723604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        b=g03i7k/SVwApX7g+StbK7o5DoNWnSQdUBXeflYN78e6cgXdTC1NMSDWX0fA1qNCgiG
         Fe+uEf0ppHM637+NeBB428R0bZiTnKxXceJti+Q+7RyRt0Yk3c2rO+TQH6QrafXV/fx8
         T2xBrwTX6hNdLNXENBcrmwqLNJFlho65WvBrLaE0ZBNbqcmaacyp3Q01yS0vGlGDlt/G
         KLOVD+Ft9DkpsRy4Br5WuFXv9p+fhdFIF4pRdzyuAE7uLLALM6g0X987SkSH0vDOVR01
         4ySURLElGvE3aXojgG+lo1r81r7/D4Jt8twXDlc6FOKHMyqVEs4PxjtLu3a+XhnzkHYG
         xrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118804; x=1776723604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00dCXJraG3Nz3xP1Zulfjafowes4Ec60LER8Tb820vo=;
        b=JVhFMFiGlzmAv/mQczobtq9k4hZ4vOjPGnpBEA/SjUTG7tK2yI2Q5c3dfSgJEjOhK4
         h/g9UaYzJS8LOCVM9rKrHtrjxnnCZtAAktj943B9OmhyxIUb1xKxyDerlLbVa15oijcf
         jZEuLM5XClPUw6Z1eJLPLtv/lcCS7MiQ/eWCk6E/Is8AY5OhZ/P8GlEoghRNFbHt6rpI
         rb9RFVUUt8vUI+sslalpmC600F7wiBc/thJEkUHeIpouweCaxsI3LAm9Jsi1XH9e1Pj3
         +3+YR1Mw7ZIfsymbCsxEonX0RpWStYTr3I01q6fm8+YplhtcyLU0uHpSbNDzGdOrgqd7
         OMLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qJzc9wykGsOPZXD+Ey+D7/XI0OCvfmOmnNZYf4hm2ayrwTP4157dfdpWlt+7IuoIJxT56Yhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxmv6JwD5HCLV9vbGyTa1orfK6rQZxRWWKyu4NvJxB5JQ+WlZK
	rcakAsRyn9c56w3Oq3KA+wF2/x2j+4Nayn3IxA98okqt5b6T/IseMszafMs3wNAUZUijCuwIxDn
	0ntU3q512KqojNQuxjZqCLmEbHVw1d9Q=
X-Gm-Gg: AeBDieshQZq7xpT6KErzwJcSkK55ggJ684EHzIVIF4Pmb+8t4/YV4yVbLHaZc9SuoQu
	fydEu4ElYZRuQR7/kipNZ71KF+yoZM8guzHbheC04fwstuugcC85nGvdQZ6pLclA1y7PD8TQF8n
	YxMUEnJO8g5o/9JRBetgBTEOE3905/P1rfV3VeBN2lJzTUO8m+A4vbmG15hapmErZSfTvWFsCQ0
	JmETxWBdYEgqznQm4RaXetLtU605bu+2ThRjuhBRozvwPaT/Q4Pq+yqu5BvqlTQ3xCk0tquRj/K
	GiP94qgcrOl0il77oQDKKXoIyKGbdjtnJvH+LdH6
X-Received: by 2002:a05:6000:2c0a:b0:43d:576e:63 with SMTP id
 ffacd0b85a97d-43d642d363bmr22139849f8f.39.1776118803430; Mon, 13 Apr 2026
 15:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-1-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:19:52 +0200
X-Gm-Features: AQROBzDwNCNsQCHGNuFB9CZ_Z628O1o6wbow_4AViz1wzqVpQC382sCN6eDZsJc
Message-ID: <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278214-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,bootlin.com,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreyknvl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6A5E3F3C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> In order to prepare KASAN helpers to be called from the eBPF subsystem
> (to add KASAN instrumentation at runtime when JITing eBPF programs),
> expose the __asan_{load,store}X functions in linux/kasan.h
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
>  include/linux/kasan.h | 13 +++++++++++++
>  mm/kasan/kasan.h      | 10 ----------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 338a1921a50a..6f580d4a39e4 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -710,4 +710,17 @@ void kasan_non_canonical_hook(unsigned long addr);
>  static inline void kasan_non_canonical_hook(unsigned long addr) { }
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> +void __asan_load2(void *p);
> +void __asan_store2(void *p);
> +void __asan_load4(void *p);
> +void __asan_store4(void *p);
> +void __asan_load8(void *p);
> +void __asan_store8(void *p);
> +void __asan_load16(void *p);
> +void __asan_store16(void *p);
> +#endif /* CONFIG_KASAN_GENERIC */

This looks ugly, let's not do this unless it's really required.

You can just use kasan_check_read/write() instead - these are public
wrappers around the same shadow memory checking functions. And they
also work with the SW_TAGS mode, in case the BPF would want to use
that mode at some point. (For HW_TAGS, we only have kasan_check_byte()
that checks a single byte, but it can be extended in the future if
required to be used by BPF.)



> +
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fc9169a54766..3bfce8eb3135 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -594,16 +594,6 @@ void __asan_handle_no_return(void);
>  void __asan_alloca_poison(void *, ssize_t size);
>  void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
>
> -void __asan_load1(void *);
> -void __asan_store1(void *);
> -void __asan_load2(void *);
> -void __asan_store2(void *);
> -void __asan_load4(void *);
> -void __asan_store4(void *);
> -void __asan_load8(void *);
> -void __asan_store8(void *);
> -void __asan_load16(void *);
> -void __asan_store16(void *);
>  void __asan_loadN(void *, ssize_t size);
>  void __asan_storeN(void *, ssize_t size);
>
>
> --
> 2.53.0
>

