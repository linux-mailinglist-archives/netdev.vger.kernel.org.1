Return-Path: <netdev+bounces-278527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGiLJDRk3mmcDgAAu9opvQ
	(envelope-from <netdev+bounces-278527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEC3FC3CF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD9C301F189
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAFD3EC2FD;
	Tue, 14 Apr 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKYlgg83"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213323EAC68
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182310; cv=pass; b=RlIICpj30b0/V1mLimtj7Qpvk2GPzY6mpqwtPt1p09/FE6EGw14hCzb00yGqUcxi6kc+zO1SxPgcapa/1fpzFbmD+bl4PVuEmm6gI3FiBF1w8OK9g4iFmX4XRAkYnpgMG2O/YX5Jvz0aWHAXAztSTgX4P4Rn28EjpAHtAbyfBHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182310; c=relaxed/simple;
	bh=3mMVtHum7zPwks+XDXBRlehlKpwvf1Ihn9S56ZO2pRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1wR2p9ptR2BnTEeI5hw7snsumdTh3RHRJPEV6oL7r99ZyguM+piHZqBsKs6uphemlTMZINqMnjKS5Wy9XNfyBeiGBuzsYjn7iFI5ays1T8EFvHK7qTDqcQK1VWmCGwYSLPt2I3A8lQkfHnPttc9xEA7qLeJkfXV2U++JG/lfFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKYlgg83; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso5869405f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776182307; cv=none;
        d=google.com; s=arc-20240605;
        b=XJM031HgS60p2MqGGTbFmzgQJOhYYqTo/SmRNvKnH88XF1wSX8zsyYdgeeAf47yl2x
         4RQxCpEo7OvXE7+fgRLb/w3jgBgWfC9um4Cc2wixB7CAW8JqjZzh4a2BMiDduvhVLhAB
         X79gFR6Y4EipUN0CglNpDh3uABQ+sSSMWiwcGHNQoUGCiJg/Zj4OAHKQRbqiHFEUXEtE
         7akYOtBXiEqpEi6uyDckFzMtTGUOcHsJUxJMNbGF9HCPt9K2OYy6WSDL7yuIXTdHk4L/
         SvXd1sZiUJ2sSCxy7a5nP2uB/VVrgFiRw6IijSziS8stXmSt3VtOMk2Qk6NCCzLwlKWw
         H1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mMVtHum7zPwks+XDXBRlehlKpwvf1Ihn9S56ZO2pRY=;
        fh=a+oRTBJdPfoyDSN3rR1KIwssgd6wKDkIRFL1gLcKSpM=;
        b=dxSWMiqflsPCqju6D5qHOfRMBhARZaQyzoccHlhmnmUFBb+V/nc+p4SkVmgxFGUvRJ
         MLveiDtBdYuiXDs288n5UdcRGm6jl293ih5uEYwA8r9DgTb4Qp2cK8cRX5qi91g69exs
         jqw/DVL8kn0viaUDRy34uJWjVbrDj9pW2tGChkjJnlXigLbPZx1IPdqCqLK9hVOHOVO7
         +EkYADn48z2ZEKXgaP8Igy2dfPmqsbgwROyixsiZjdRgI/6weZ2E6j/PwpTkEcRTbEag
         8lUqrZkgmJQvTCt/RfDVMtzBbGeu3wFoWWZqBsmJhjmbA4V62JB1menYslkHWrXtDfFp
         UwIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776182307; x=1776787107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mMVtHum7zPwks+XDXBRlehlKpwvf1Ihn9S56ZO2pRY=;
        b=sKYlgg83+aMafRzo7fK2P1gI8+zFfGagk2TKHjtXRxXJiute1s9fc90WNnijR9DhLO
         skQFVqnxgjQMq/7mawPPILZ2euRcXU+6+1lWgX85v+xuSbV7CYJb6rU1GaEB8ASxaEsE
         /lFYcZJKaVoevV2qNV/vZWh4SW1HHvCxs6cqmQollkcJI2n9j/n/Xsloz09rhcCn1y0p
         KArILiNvk2mxZIYHymyp6DSgf3aRQf9npr3VF3f45h3yUkSnq/es5LT3nMixGBKe3TAk
         UDSjjy/0vkDVUTRYjQgALoHNM2iqF6agxUoQWa6aQ7gkK4PRCyESH1klkoY4JBmZDet3
         0KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182307; x=1776787107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mMVtHum7zPwks+XDXBRlehlKpwvf1Ihn9S56ZO2pRY=;
        b=tMKjfqe5ChVONDYEeQBcRMN8w3bHEMHQ0gvn2Ri+eH8hkQJhNfbH2KVShK/VI5l73g
         KAkUYFpDu8g1XrqqIuYmRgLI8rsrNzMX89fXof1jo0MQAs8MmZs3VwZkKonc16k5bUOk
         mzibDzKp1wAUaq+IoHNA8B+FuR8lBzPbwyF5hLz25H1BbEfjiUHkA4AVJ46o8P2YLlzX
         078EaGr/jAPoypel4F4o0w2LjIhOgPASWvgwqBDJRnZFR15cRtJBB1hSkLrQ1YtqbriR
         dOTjMhovoOG+ZopS/gxU3UiMCXSJmL67bV+GtTFi/8C3PEv93ddMntClEFlvl+UgQSds
         AH9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9X5tMVZuDIRE8dRBpE9aaf2MrWSWJMkwWTgmXl2HJs5GpA3kC+zDHkm03LcMP9HHfFTNRLZ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZQgQVtEzylJ2s16KojqVh0qZ8TRRRn9UPfgXc3j3dDBxKl1+
	gwYEN94r9MBfhbpFThEguOPniFGJbN7WfdubFYXreNnOD1w85nU0IBVTjVrW2O1CQKJHU2P+1WC
	szbpnUFHgQq836t61Z/P/18k4Q2TGcqw=
X-Gm-Gg: AeBDietgDgqkachDUUHwm/79ytI/bt0X/+cqm9yivFtjCamRAKSx0GNL1zwQhSdbn/+
	g/1KY0Njq5nqOO7BwZPiM/HB5YXHFmWB8lhYE1P45KaiqKZPGlcWpkHy6ixfeCuArWUPrdNAYcr
	598FIFT2RKhDeaFsQIK7BiZ+HotQtW5F74am/Z8g0F3On5DSZHhNuJu60FFxi17DhYyMooWFu+I
	wdkRrTB9qnxoNRLDpPOwAQI19k1+AG5ICwxhCrTyFcnlhcD2E7HMzkOF7yHTfJpBlU6+YQlCslv
	Q/JRCedoP0CfaUgaUPMhPRICZysNq1/mKWcGjXFnmO7ja0dClgaYFB+gRaO2DxN7G2JDbTGkJVC
	wffU88pUfdNjJk493Xp9XcLBGIC1O6iYTQ71B
X-Received: by 2002:a05:6000:290b:b0:43e:a703:3665 with SMTP id
 ffacd0b85a97d-43ea7033872mr4250710f8f.25.1776182307210; Tue, 14 Apr 2026
 08:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
In-Reply-To: <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 08:58:15 -0700
X-Gm-Features: AQROBzCLeOrIcZKaiQb6Cd-OuEC8rfDXHtXvBFTPGfyaVO0Jqt2FWke0BxyjjQs
Message-ID: <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278527-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3FBEC3FC3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 8:10=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Apr 14, 2026 at 4:36=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > > ACK, I'll try to use those kasan_check_read and kasan_check_write rat=
her
> > > than __asan_{load,store}X.
> >
> > No. The performance penalty will be too high.
>
> With using __asan_load/storeX(), it will be one function call to get
> to check_region_inline(): __asan_load/storeX->check_region_inline.
>
> With kasan_check_read/write(), right now, it would be two function
> calls: __kasan_check_read->kasan_check_range->check_region_inline.
>
> I doubt an extra function call would make a difference in terms of
> performance: the shadow checking itself is also expensive.
>
> But if the second call is a concern, we can move kasan_check_range()
> and lower-level functions into mm/kasan/generic.h and include it into
> shadow.c, and then it will be just one function call.
>
> To improve performance further, the JIT compiler could emit inlined
> shadow checking instructions, same as the C compiler does with
> KASAN_INLINE=3Dy.
>
> > hw_tags won't work without corresponding JIT work.
>
> You probably meant SW_TAGS here.
>
> HW_TAGS will likely just work without any JIT changes (even the
> kasan_check_byte() thing I mentioned should not be required), assuming
> JIT'ed BPF code just accesses kernel-returned pointers as is.
>
> > I see no point sacrificing performance for aesthetics.
>
> With the change I suggested above, there would be no performance
> difference. And the code stays cleaner.
>
> > __asan_load/storeX is what compilers emit.
>
> For Generic mode. For SW_TAGS, the function names are different.
> Keeping this detail within the KASAN code is cleaner.

I think we're talking past each other.
We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
We're not going to modify arm64 JIT at all.

This is purely KASAN_GENRIC and only on x86-64.
JIT will emit exactly what compilers emit for generic
which is __asan_load/store. This is as stable ABI as it can get
and we don't want to deviate from it.

The goal here is to find bugs in the verifier.
If something got past it, that shouldn't have,
kasan generic on x86-64 is enough.

