Return-Path: <netdev+bounces-279013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHBxGl3J4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AE40D749
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB08303A91B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF938C2D1;
	Thu, 16 Apr 2026 11:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572023A9BD
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338870; cv=none; b=TafX8sd5wYjUkUJ0le15LUa1im+/r77u8VTMV7gzmQ62ZrPKKDuCZss0N04CtYk7Ai56b1U9tnRfum58eLZuK2KaVbQrV7ljkSBveTdVaDLTy+IXCjljsDRi+IqLPIih/oYj4q23yQe+nYZzOBbKTLppxVqH0F1SreaofPGY8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338870; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3Xmrae9JCgMtmmhuSkvBQZfdc+m9M4mnlxkZR9ZJlrkv3LQ4aPZ12TMnqgw3ET85pETmNQ3BP02xZsNeggVjFTUQDozcf3Sn2DW7NNwNue2D+AzbjIxok9ntS2+R0nZc3BgztLoW5iOOVFYSMeUU97sq81NVaHuW9kv8Ko+quk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d58c513dbso56511951cf.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338868; x=1776943668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=hcfsUBKwpZA7Kp8VNDFyZGPmkYIPCsOfSAonL5Qpf4Yb34WcVzCriQw0NKgtkrUO5X
         ArM8XzfxJT28D9i1cyaEgTs7ssaRB4DOzPRrct+LNjOb+23C3YYuSava0xRccnMbP+IM
         MlopyA0bVk3klk4amv6x7AxMsYI4ORJOsJIaHMG6PfmRsfWFh/i6mpHjTos+0fhXoRuC
         2OSuFVTPk5O7U8DCRuEBsWQT08aIhHPQF/hsUhi8RfohUVBSA2KfH8F4EaIKenVUFPIB
         7+/UYGaUehYxwkLV20L7zHtO30anFXF+vpHSflia+c9iRGsABh6pyFYabVBr6v2qmab3
         pFFA==
X-Forwarded-Encrypted: i=1; AFNElJ/inxHepdLMZO9el6ogDj+4QYzWH/lVRcgZbxTN/UjYIa43LpwATyUjjvbh8SORnRXT9fsxQ98=@vger.kernel.org
X-Gm-Message-State: AOJu0YytG/pRbg87pviNKifZ1R3oQMCZycKWdDd/fDLy1jZPwqwsaukY
	ednQWDdNXGm8DK4BlsOjVudPr7eP9rLuUU4AGzJj/qvbOyt9CR+fP83FzhFUVrEQ
X-Gm-Gg: AeBDieu/FEQLLXfd7w/2qWLWnKVuWMowOlArsIsaitRUfb/Fd3vK8dWnAaua3NcrZk4
	F29Mfp3jzpvxdd53CAkt1zn3wOszNS+fj9u3KkF9HRHMgEkSIc2WVpnJ8ZNnyXSajuGY4BiKAJZ
	Ay1p4lRTeDp0ZUg76JWIlt5Qm8pM1JEQTcAMxSZ/5nGpegWMmjXsG0HIKn/k8Rrz7gqvojvXIHf
	9kJqqX8ChpM46bLEqMzLMpfvWAmtdle88y5ODnCQop9dtfZKcaPjxhDxY/dl4kqi0DC8waL+Kki
	+RMOS2OTYF427efC1edrVtdc0qS6A+WFDkHF08cYX3hM70y1/tOpmxmQuHOas0eU+UU0jESCIKR
	CeAgT+AQMFyNYevN0RTSpWIC1/A1DFafxS9noHw8qwSi4O2TePy80Q9129jL/ty48gqLHwKVNgq
	0fTfeFoGykyrHxV15aSuDPVSYpoDQwesVeLeyiGDMYZwg+fXz/KeKYZNlLu+BdTZJyOIkch8UFF
	GM=
X-Received: by 2002:a05:622a:d01:b0:50d:9175:34e0 with SMTP id d75a77b69052e-50dd5bab1e4mr360595801cf.40.1776338867894;
        Thu, 16 Apr 2026 04:27:47 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c974c2esm32948476d6.17.2026.04.16.04.27.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:27:47 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506251815a3so65638671cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:27:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9VYHNcKQtqEbUWZOwy3NSjX5pUahmUxeJ5l+LJhBiEXCgbqVy7qrkX72ffQ+vqlZ7b+kDBU98=@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-279013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 098AE40D749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

