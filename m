Return-Path: <netdev+bounces-291740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOXrC067FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:25:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B15D8A5E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240F23221F73
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4140626D;
	Tue, 26 May 2026 15:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CE40313F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808104; cv=none; b=SSTvqwnWLzkOgC89C9H4YD1OuXxdCReV0HFxr9tv4HFZZmVH+x+Hh/f6ggCjJZsaLEPWcrkvKLIXjG0Sod24i5JbesMWIl5vV/jWNjgPlYYqnJWFlcQGGUzD4L5s3WrdQL0op488XQ2qG2ACWG6NN3SHCeQ400q6WVP8FTGJcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808104; c=relaxed/simple;
	bh=yb+0omux6d1zyLgvLzeZABk2GNuWtKQ1yrpCoQCsmR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhio7TheFkBOqErQPmsWHh4KprD0hGj79C5vhmwWxNzfhxYzq/rZKCp0OFG3yD6WF32MGb1f84yfVFNqViYWwOAt7TgLjAneFM3QqFUp4/GhJErsKVYLLpr35Nu78/2qNAwmsMLnt2m9SqEmqvuMZhIXSbHt/ffUnWDX/0On1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcd3c190f71so1734395766b.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808101; x=1780412901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLTPgXz6PTE+WNmbiors/d1TQS2Sqmrm+U6hNBea8hs=;
        b=Nu+iUc5ZVKhWfu4an8LgwiWFEryICv38HJkmRiiiQ/aMd07Uu7pv0ulFAqZEY9sSll
         bqdxnAa0fehqJwNvy0zOnmxscZezll7fOwHNdPxEAua+3S4eWh0eUzyBd6UGymnNHHYk
         c0QM73KRgXuI8QZW1TOkOMbm9O7xaGgcQnprH1P1hu8sTq47z49A1yj79z0xva5bQOfW
         95FAl65hT1dlOyxn7WzylPT7Ykt1y3AgwGHNrBBxJLCbC3wZVUWhr4V4TP3PV5imomXB
         3aRI031pyC9pe9MzStuc9wrQkAp3CY1iWjCmtjyhojBdAsQJcAgAFu39+5dbos9DLwzm
         U8gA==
X-Forwarded-Encrypted: i=1; AFNElJ9+kSG/1RALa7BjcLOV0L8EEFo96rj3Nw/XXKuxv/qdZhA/ZIF5jMTeuCE/OldWZuf3AfmpNPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGuEXLIGjJmmNUu0GGK0VXMPzbh/hvk7m0DfvzUdJvnBfsE3i
	RbAeUu/Xr9tHGoGbLFT3dWuaIGLaYJMg5JtqfkkbRcde/qF8EfrfYbaw1p0ulZCSKZQ=
X-Gm-Gg: Acq92OHl87iwJhEVY0zKqglzk7DN1+Poau2BK0/aRsKCe8zBZJzcIOqw5UiTdw0nLaT
	zpbsE+FSMiPE2aygGdq8MvuMJl30Hi2gPvfWx7Hmb/4nucO40fBSoUI5TxdOzCX7lnISXdCcZcC
	pzLTUVkTS1uedcx0Nr/MacFTmMBEdH+9qIdpM+rdED99xzOwuRHL+UteRz/vNIk1AxJvkzfcMHr
	om6k6ZTjuT28x0Nls/qy8sIQZsU3mYgWbeZTgXVpf0VuXE+rHVXk4nCQ9hDuxHOeQtEg8gy+gVk
	/Y6Fi05ipzGe3yS33nP9VsfPGl/V7DrW4mn7/qPKEXjq8ylMYVSxVNT7U1TK0HriHF1UH5td7Nr
	saFkLt3b7lPWao8UjeyTdr7VYE0/FO998cgvyS1hjrz4qHRc0YRTjWRAUC+/ZMSgXVkxJS0vYmG
	s/XCo3KGnW03izSEmISZ+RjfjBcGZzHu0fnJr3cBGO49haF+57DlI3sRxJmJ7P
X-Received: by 2002:a17:907:7703:b0:be2:11d7:8b05 with SMTP id a640c23a62f3a-be211d79063mr315275166b.24.1779808101021;
        Tue, 26 May 2026 08:08:21 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d4ff2sm509146566b.46.2026.05.26.08.08.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:08:20 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so5687647a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:08:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9eA5iSgFqRQWah5GF1FNuz3Rj9nkRkcYfXMOL1mcpD7/FJZpMU9GW0sjJG+HHK5fUB80vp3qs=@vger.kernel.org
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-6889ca4520cmr9385916a12.12.1779807721391; Tue, 26 May 2026
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2026 17:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Gm-Features: AVHnY4KG1TJnpMipnk7rqdd9LGhhF-uK_MvXjYFynbh1jLKZ-eyBikYr9yO02y4
Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,hansenpartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de,vger.kernel.org,lists.linux-m68k.org,lists.freedesktop.org,codasip.com,c--e.de];
	TAGGED_FROM(0.00)[bounces-291740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: 891B15D8A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
>
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
>
> Preparing for that change, all zorro_device_ids are converted to use
> named initializers, which is also a nice cleanup that could stand for
> itself, as it improves readability for humans. (That is necessary
> because an anonymous union can be initialized by name, but not using a
> list initializer.)
>
> My motivation for this series is the CHERI hardware extension. With that
> pointers are bigger than longs and thus you cannot store pointers in
> zorro_device_id::driver_data. So this series is also about getting
> support for CHERI into the mainline, but I hope the clean up effects
> mentioned above are justification enough to accept this series.

Thanks for your series!

> The dependencies in this series are as follows:
>
>  - Patch #5 depends on #1, #2

s/5/6/?

>  - Patches #7 and #8 depend on patch #6.
>
> So if the ata maintainers agreed to merge their patch #1 via scsi, and
> Geert agrees to patch #5 and that it's also merged via scsi, patches #1,

s/5/6/?

> #2, #6 and #7 can go in without further coordination.
>
> Patches #3, #4 and #5 are only about using the same initialization style
> for all zorro_device_id and can go in without coordination.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (8):
>   ata: pata_budda: Use named initializer for zorro_device_id
>   scsi: Use named initializer for zorro_device_id
>   net: Use named initializer for zorro_device_id arrays
>   i2c: icy: Use named initializer for zorro_device_id arrays
>   video: fm2fb: Use named initializer for zorro_device_id array
>   zorro: Simplify storing pointers in device id struct
>   scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
>   video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

