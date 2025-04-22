Return-Path: <netdev+bounces-184610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF3A96604
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D001891EBD
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3791F0987;
	Tue, 22 Apr 2025 10:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194333062;
	Tue, 22 Apr 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317979; cv=none; b=Gf8nH2BYWH8ZARLW40+6YuZ67wI0taJLZdgB0SBJPFnVucXvpI+V4W5AKLQssDOgyZykNmUjKf78BlESWXjve4SpJJCGPjWag19DrBrDWmfESueMfu42VqJLP2S9yFBQHpxnUMLboL5uYkQXu/MXXLqn4OY1lN+hmI9h1EJd8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317979; c=relaxed/simple;
	bh=c74m9nJuaHqBhP0VHLohLK106T0cVKwkPnarj1bL+14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTlD8nuZT05jh2VS84rtDGShihTEAa0bp2FnjmIoe1jV2XES8qmQNHOdM9kT4H/Ci3q+lPgNliDr1wa6/b2+pbimPFW/o0vejUtoQXqobu6QmPHSkbRc5JI2q7R2YPeWLYj4coJ18yVXc2bGmZaEp8zBn8DA1VstQfU4PQpeLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2291894e0c.3;
        Tue, 22 Apr 2025 03:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317975; x=1745922775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vytO4TOm8gf3AQur2lnADNQtT+Rd1ucyY5nITKDwjU=;
        b=Tzoc77CzTP4UPUWaOiHGTTjgOX24WbVYNv4x6omF8n7WmXp9bvVRuQFZEKLqRT0YF9
         HqX4tk/sM1hIdHLSXkvUsH3mX64I9GK16x1yMJAxDY2vc6NVERrSl2NKvh18HpJsiPaq
         W79mWODJFJV0QQXlssenDq62wsgxDLg+nsGpNGLLum/iAISeVYqq1M+pp6JdgfSC8un3
         k3ouL37Eglm5Ti5ZyN4WqMh3GMc8cX0jMktFIxADr10KQYe9WIYAnuDQRzMw1YfI3L9N
         8mQ8WXcAcXpUlh3DfOZ413kwnzigtU7xtxlGzOtls3eItCwBLb1Q0mHaufVXm1r2q700
         F2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOsMsXhZsu5D2cnHz+tg1uKwr9TmOjK0l/ueeHfsElQQ9upvO54gsg7uW3OafBOz9agzWfO1BgEG8J4Job@vger.kernel.org, AJvYcCVV3R6gSu2K6GCcr4IQGpZsYlNmbbXLPwCvno4mFy1lXHGH7tO1/KdMIGrg8H+mHwceF0/C+yxw@vger.kernel.org, AJvYcCXSfjx+atlzaitIhQSY+ravDyri301Z3yN86qG8qiiwJfyNC4HN3HuQ7rtJwANC2FAvbgoOMK7EONo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4QFOMU1f2aQyItNzhOx9jX93Mqr0HttsEGj4gVaXBsRbk+Em
	7PiZMuYjuM6JcP3bJG2wIWNpxicuA3Ge0AGJlEnubZy4Yb+0I3us5QZxOdlS
X-Gm-Gg: ASbGncsQfED4kxvuT1T7efUOw7Ug56Ix+cgUpjx+z+6hXwhRHD+L09n9s3iU8p8zsPs
	Z2CGBbjIiMRHCjrQiHBMvd1lO1CTD2fdw78SW5drPrKpqYmZ0EACsyHz507hJjIlpWgZm64GooO
	UYiN0n6CuN1hA7W+aPK045obICxgwPGhI49oNtxkvr4cs3XlaQIGPWUjFuAmtHkPY30nlTEXsXn
	m5nUXZYcLtZbykjKKlWRegpfj0OCBdYi2brFjxfRQ1yUurW48wueMn2NnBBIFHXdDSUqjHoGWRn
	E9BHMqjdBV2K30MHfkJgxNYCfYgE8978QZHf5b+QvhLLUxqAiIP9ibuJMnqx5IlnV+OS7JJQjRQ
	dw7Q=
X-Google-Smtp-Source: AGHT+IE3JysLBLtZnmXPR/CJPtPBNkRh0Nc6lR8/IZOWBG4GMc7vXB5TMHWNk+pke1BmAlMSyABMBg==
X-Received: by 2002:a05:6122:3c8c:b0:527:bc6b:35bb with SMTP id 71dfb90a1353d-529253d6bb4mr11751584e0c.3.1745317975632;
        Tue, 22 Apr 2025 03:32:55 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c1025esm1884566e0c.13.2025.04.22.03.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:32:55 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso1908865241.3;
        Tue, 22 Apr 2025 03:32:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIGftBiLXJ6OKSxYTlWEden5c5H/2Xt7qIJCAOJr3yzXlYNHFVgT7SLxT0SArYEHL76bxkYkzyJL4=@vger.kernel.org, AJvYcCVDjG85qZl93PBR5twTWPWzqSsaj6KINrLfCEcKYWop3XCDrcc1w1JKBzxcJk672gYgQDAzvYBE@vger.kernel.org, AJvYcCWjkmr1blAAFxnLNQJzO4E4FC4g7q4pw2yr2tASPEXYunQWZex5bWX/kNFo8hXntyTFaCRB+5t1KeD5I6/Y@vger.kernel.org
X-Received: by 2002:a05:6102:3139:b0:4c1:c10d:cf65 with SMTP id
 ada2fe7eead31-4cb80232571mr8147349137.25.1745317975059; Tue, 22 Apr 2025
 03:32:55 -0700 (PDT)
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
 <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com> <aAdsbgx53ZbdvB6p@smile.fi.intel.com>
In-Reply-To: <aAdsbgx53ZbdvB6p@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Apr 2025 12:32:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXuM5wBoAeJXK+rTp5Ok8U87NguVGm+dng5WOWaP3O54w@mail.gmail.com>
X-Gm-Features: ATxdqUFtFyy2GYQo3KtAmKWE1aHynw34_2Dg7VBWf7uTMs4ERXRYeYaDF1kqp6E
Message-ID: <CAMuHMdXuM5wBoAeJXK+rTp5Ok8U87NguVGm+dng5WOWaP3O54w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>, alyssa@rosenzweig.io, 
	Petr Mladek <pmladek@suse.com>, Sven Peter <sven@svenpeter.dev>, 
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

Hi Andy,

On Tue, 22 Apr 2025 at 12:16, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Apr 22, 2025 at 10:43:59AM +0200, Geert Uytterhoeven wrote:
> > On Tue, 22 Apr 2025 at 10:30, Aditya Garg <gargaditya08@live.com> wrote:
> > > On 22-04-2025 01:37 pm, Geert Uytterhoeven wrote:
> > > > On Tue, 8 Apr 2025 at 08:48, Aditya Garg <gargaditya08@live.com> wrote:
>
> ...
>
> > > Originally, it was %p4cr (reverse-endian), but on the request of the
> > > maintainers, it was changed to %p4cn.
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
>
> It will confuse the reader. h/r is not very established pair. If you really
> wont see h/n, better to drop them completely for now then. Because I'm against
> h/r pair.

I am not against h/n in se, but I am against bad/confusing naming.
The big question is: should it print
  (A) the value in network byte order, or
  (B) the reverse of host byte order?

If the answer is (A), I see no real reason to have %p4n, as %p4b prints
the exact same thing.  Moreover, it leaves us without a portable
way to print values in reverse without the caller doing an explicit
__swab32() (which is not compatible with the %p pass-by-pointer
calling convention).

If the answer is (B), "%p4n using network byte order" is bad/confusing
naming.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

