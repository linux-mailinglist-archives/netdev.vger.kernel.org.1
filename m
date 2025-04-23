Return-Path: <netdev+bounces-185187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3428A98ED1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890DA461662
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE40263C9E;
	Wed, 23 Apr 2025 14:58:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5835281363;
	Wed, 23 Apr 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420289; cv=none; b=gMO+Z59N17PJQZC79FOUSzqSlmgHrFZ+pQ5x+6RxpETQjA1WRDPanfOVa/TToZ9kIHMZdhLSp4c+E8AcjqlxMUQY1r7TG2fe/5vnhuMBNjrZUNAc9LMBLVGSeWRSZDZtGot6IsezGU6+D87AkgAAU/gTRmfgnzLaAUEaKC7sOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420289; c=relaxed/simple;
	bh=jnfqlRhyk0nxJXxoUORXfipw+CR6jruRhOi93htI5a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWhZAT2PT9QuBGoWD4K0PU4hYbhODA6gebNk+q9tAbwC+1EYWlxw+RFouwLPmNJ3uddwUu9hJvaGtsu6tyRYqzDO56fCxK2rAqyqc8pljwmF4Kgk9k909YMKp4SvAmcnSFbzwJhoj4zY4TC/X06B/o3vicAQTlhtLp9O1R48k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5aecec8f3so397944485a.1;
        Wed, 23 Apr 2025 07:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420284; x=1746025084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlyPTphf+x28unQ9fsmlIwni94vcWgQaX/dq2nBGd2c=;
        b=uo70yKrNm5TbrHdXKvXWi8VnQESgYgOVM1K5HXlAo16VYU45OYFJe9ua/Sa2iwLV6+
         28WHwOkgnXp9EQjg21NVCeYrNWh9xiZZhO8FP6rNkBvDgz2AiYgSDW7ZOASqyY9cmkPf
         BTP2J/NTbYUVFOhKF3l/AT+k+rKw96giRmEFMFlD77ggnkP93jk6zAk9cpr6d4setTiq
         H20Oj+AFMqW0rZ9nT7JYi2aq8cNWgd6iT+3TxEsSKAiX56Z61og1+GyMJq4t92Qi48kQ
         ORC066vv1rMfoyMpKOSsNVUZNreZDGpmij5axRIJoCXb+OmTZSO23aqKXjfrKKupXZKJ
         XQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbZaWCugcFVPmvcT9h4IJu+gAbtzcXOTOhnXfHYnlEYimt1l8LRTOoA1bnt+HPPKaw1fRZiS/+@vger.kernel.org, AJvYcCWJ7+toTLi1se2nADmhVQnjsi5cju3HVfi9U5h0Xb7k4+jPTJ/mbBQEHu/lrYVp9vGdAza01ym70M8=@vger.kernel.org, AJvYcCWmAR8UNFF/kdfTltg92iPVUWvqfqBqenGXPPEBjaHCC8aNDtLcrI7APaW2OoxX2/M9FyKrwpRXP+8+Eo3N@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAjyH46+Wi163XODQ7KI/n1/qHZAh71DulJyRjfovY0HkRSpO
	lqhBny7gCTap7ilY9CVCm1+CaE8pBzmsJEk/a3tOAEDsozjjZ40Kv6E0JYZ3m+c=
X-Gm-Gg: ASbGncu4LKHFcUuoVZBEuLcCiDylHBrBINwVtGYkmlWsn7d5KmMNrheIbn2OGAZXrn8
	aUbCCror/X0gqli0zxpe1iFvDEXsSxT8t3cn+/OVHDWyWAv5EWwL5ACCyQF7EvEI/MkmM6z43rJ
	kU7KweJiZoiStWd0zmspQp2pb2s0iUedrE9zpa0mFIGqPkpRUGr5/GO83AD7L0bR7tzvH0MUe2X
	vajEiijipBkB18jtfaec/Wq14UPTHtjDQZYAmSF+rYEV5qTsq9U4rR58O0V1X+pcY01PPNfvjoo
	2L5f1+jfV6VETp1ehaJXkkcUvWwKuJvnoQeE07Z7Jxed6SRZ27BYo65xAw8j4R7SQsJG6lCvl2e
	VGGAl9E0=
X-Google-Smtp-Source: AGHT+IGsXgE4cnpqPU+SPp8fFl9Kxl40eBT7/qjgJZoSA8IrqAUo4bACVTD1sY9dv1/pRyXoi8nFUA==
X-Received: by 2002:a05:620a:1790:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c927f594f8mr2723135285a.2.1745420284118;
        Wed, 23 Apr 2025 07:58:04 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dbdbsm688524185a.68.2025.04.23.07.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:58:03 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c54b651310so902884985a.0;
        Wed, 23 Apr 2025 07:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7L5GOAoLnNdpzwNAd+rhMJM+znc5VuHw2IfNDUbsdwNDyKtk5weFJmCyk1ERe3px2DAp8mdoF8vc=@vger.kernel.org, AJvYcCX3efPKSfbUpf4hWr9NrfiVUxOZCNewxx2qjUwajaxji8siOvkKj/13zMZ5rVY+k5H9X47pWaQD@vger.kernel.org, AJvYcCXYvXlEmKLEusF2FZBenHXVXs9R9BMApYP1nTXFE+L5+pCq+GurBi2ip7Io3/TBpEd7cA6AEvR029TWxM/n@vger.kernel.org
X-Received: by 2002:a05:6122:793:b0:526:285a:f4b3 with SMTP id
 71dfb90a1353d-529253b90f7mr17209301e0c.2.1745419814638; Wed, 23 Apr 2025
 07:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597382EFDE3452410A866AEB8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B01823415CB7FCD3BC27B8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com>
 <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com> <aAjthvTuIeUIO4CT@pathway.suse.cz>
In-Reply-To: <aAjthvTuIeUIO4CT@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 16:50:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXuawN0eC0yO40-zrz70TH-3_Y-CFSy6=hHCCMLAPvU5w@mail.gmail.com>
X-Gm-Features: ATxdqUEtXjwX1Xvi6EF4OaIe3skICOJiGJO6vzaZtD0WSg84WGPiul-c6IaIVeg
Message-ID: <CAMuHMdXuawN0eC0yO40-zrz70TH-3_Y-CFSy6=hHCCMLAPvU5w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
To: Petr Mladek <pmladek@suse.com>
Cc: Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>, alyssa@rosenzweig.io, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sven Peter <sven@svenpeter.dev>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Aun-Ali Zaidi <admin@kodeit.net>, 
	Maxime Ripard <mripard@kernel.org>, airlied@redhat.com, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com, joe@perches.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, Kees Cook <kees@kernel.org>, 
	tamird@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	Asahi Linux Mailing List <asahi@lists.linux.dev>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Wed, 23 Apr 2025 at 15:39, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2025-04-22 10:43:59, Geert Uytterhoeven wrote:
> > On Tue, 22 Apr 2025 at 10:30, Aditya Garg <gargaditya08@live.com> wrote:
> > > On 22-04-2025 01:37 pm, Geert Uytterhoeven wrote:
> > > > On Tue, 8 Apr 2025 at 08:48, Aditya Garg <gargaditya08@live.com> wrote:
> > > >> From: Hector Martin <marcan@marcan.st>
> > > >>
> > > >> %p4cc is designed for DRM/V4L2 FourCCs with their specific quirks, but
> > > >> it's useful to be able to print generic 4-character codes formatted as
> > > >> an integer. Extend it to add format specifiers for printing generic
> > > >> 32-bit FourCCs with various endian semantics:
> > > >>
> > > >> %p4ch   Host byte order
> > > >> %p4cn   Network byte order
> > > >> %p4cl   Little-endian
> > > >> %p4cb   Big-endian
> > > >>
> > > >> The endianness determines how bytes are interpreted as a u32, and the
> > > >> FourCC is then always printed MSByte-first (this is the opposite of
> > > >> V4L/DRM FourCCs). This covers most practical cases, e.g. %p4cn would
> > > >> allow printing LSByte-first FourCCs stored in host endian order
> > > >> (other than the hex form being in character order, not the integer
> > > >> value).
> > > >>
> > > >> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >> Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > >> Tested-by: Petr Mladek <pmladek@suse.com>
> > > >> Signed-off-by: Hector Martin <marcan@marcan.st>
> > > >> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> > > >
> > > > Thanks for your patch, which is now commit 1938479b2720ebc0
> > > > ("lib/vsprintf: Add support for generic FourCCs by extending %p4cc")
> > > > in drm-misc-next/
> > > >
> > > >> --- a/Documentation/core-api/printk-formats.rst
> > > >> +++ b/Documentation/core-api/printk-formats.rst
> > > >> @@ -648,6 +648,38 @@ Examples::
> > > >>         %p4cc   Y10  little-endian (0x20303159)
> > > >>         %p4cc   NV12 big-endian (0xb231564e)
> > > >>
> > > >> +Generic FourCC code
> > > >> +-------------------
> > > >> +
> > > >> +::
> > > >> +       %p4c[hnlb]      gP00 (0x67503030)
> > > >> +
> > > >> +Print a generic FourCC code, as both ASCII characters and its numerical
> > > >> +value as hexadecimal.
> > > >> +
> > > >> +The generic FourCC code is always printed in the big-endian format,
> > > >> +the most significant byte first. This is the opposite of V4L/DRM FourCCs.
> > > >> +
> > > >> +The additional ``h``, ``n``, ``l``, and ``b`` specifiers define what
> > > >> +endianness is used to load the stored bytes. The data might be interpreted
> > > >> +using the host byte order, network byte order, little-endian, or big-endian.
> > > >> +
> > > >> +Passed by reference.
> > > >> +
> > > >> +Examples for a little-endian machine, given &(u32)0x67503030::
> > > >> +
> > > >> +       %p4ch   gP00 (0x67503030)
> > > >> +       %p4cn   00Pg (0x30305067)
> > > >> +       %p4cl   gP00 (0x67503030)
> > > >> +       %p4cb   00Pg (0x30305067)
> > > >> +
> > > >> +Examples for a big-endian machine, given &(u32)0x67503030::
> > > >> +
> > > >> +       %p4ch   gP00 (0x67503030)
> > > >> +       %p4cn   00Pg (0x30305067)
> > > >
> > > > This doesn't look right to me, as network byte order is big endian?
> > > > Note that I didn't check the code.
> > >
> > > Originally, it was %p4cr (reverse-endian), but on the request of the maintainers, it was changed to %p4cn.
> >
> > Ah, I found it[1]:
> >
> > | so, it needs more information that this mimics htonl() / ntohl() for
> > networking.
> >
> > IMHO this does not mimic htonl(), as htonl() is a no-op on big-endian.
> > while %p4ch and %p4cl yield different results on big-endian.
> >
> > > So here network means reverse of host, not strictly big-endian.
> >
> > Please don't call it "network byte order" if that does not have the same
> > meaning as in the network subsystem.
> >
> > Personally, I like "%p4r" (reverse) more...
> > (and "%p4ch" might mean human-readable ;-)
> >
> > [1] https://lore.kernel.org/all/Z8B6DwcRbV-8D8GB@smile.fi.intel.com
>
> I have to admit that I was always a bit confused by the meaning of the
> new modifiers. And I did give up at some point and decided to do not
> block the patch when it made sense to others.
>
> But I have to agree with Geert here. The current behavior of %p4ch
> is confusing on big endian system. I would expect that it does not
> revert the ordering.
>
> Well, I still think that people might find all 4 variants useful.
> Andy does not like "r". What about "hR"? It is inspired by
> the existing %pmR.

I am not a fan of complicating the format specifier even more by adding
more characters...  But seeing %pmR, I have to admit it does make sense.

> The problem is that the semantic is not the same. The modifiers affect
> the output ordering of IPv4 addresses while they affect the reading order
> in case of FourCC code.

Note that for IPv4 addresses we have %pI4, which BTW also takes [hnbl]
modifiers.

> Avoid the confusion by replacing the "n" modifier with "hR", aka
> reverse host ordering.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Thanks, LGTM!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

