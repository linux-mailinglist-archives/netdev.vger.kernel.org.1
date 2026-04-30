Return-Path: <netdev+bounces-282680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP2+HRME82nawgEAu9opvQ
	(envelope-from <netdev+bounces-282680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B049E97D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE703037682
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670CC3A16A2;
	Thu, 30 Apr 2026 07:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E99322768
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533752; cv=none; b=OKMaA/qHUEWJP0S7ktc68XsR9D3bHsukYtWtutVLWcJ8G70COSiRBeQC7/lUTPLQkBGZoZOMlcJenoEA3crKjm0EWUZvXJQKSQxoHqo+W+3aCpIjKRBMsLuVM4d6/fHmgjvKSvlJTloYi9LpLhN6XjgCi5voBo8RhBZB31hOwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533752; c=relaxed/simple;
	bh=sC5MVFkAnZyx3mcfwly5Dgffg29w2p4oxdEcKWACiJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVm6x22kIOXjGPblsGoEgo9viATlRPZyEZ6WFsMVnGCfrtpya+28rOjWuJlStelkAlf90GJD4qvjEYfHg9smDJWxYriP0KqVscs7P2DbYm1VE/7aD7DOrNfYvFsCMdacnH9Ri2AZgxWBY6IeqxqgZU9RvA/llO1RVwmfvFXdX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-60579e72ff9so438259137.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533750; x=1778138550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp0BgOGCYFNvjRA6ZumN87R8na6iqe2i6++f2ynASA0=;
        b=otlgiQoSPtWOQ5KSEbxgO7cUuFnaPU41uGNM+jA8W3h10AD6fomZiRf6MAH7nsQEcG
         dVLK36ur9A0PYtV25wlb3muxK5aw7ze54KnQzaq8GDuj9uiI1sDA/Jbz4Qq3FkaZ7FLq
         cHRIv7eeoG4Z67yyJquYlazphc2QNPo+aun1UBeYkJMQH418m1SeSwGDgvad00oiXq4E
         KQxpbNALceZDMEUG3N3eSmbJGQFvIfS/KUs9qoIXa3EIKL9cIa3oHpiVLsgPxXGR+Rw4
         gc6dqLeD6fY39wOpt3C1xiNlEEbX9mHG8LaSaCB8wZlS8G/oYETZt+UX+ED6VIeBfOW6
         osTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Su8sTsYGR7qomApOUC2VrSWI845vWmd9p3p4swawAj61KHDRwx8YBJNhIFt9JZc/CGJgxbCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbEPSVd1RlVOdWKpXsGig9WBwYkLnqxKBdGME6Md7IVexvzrm
	/FOHCMqPAV8Q8fnqKh7VBUTVr+FpEhS24+uKjBW555LI7+PdvjRfkSZx175AVJ0RP7I=
X-Gm-Gg: AeBDiesTUoqfvTZmcWFz2LXPu6ySVihcLuWu4ym6xBbAXvzoqA4jfrin9QUHl9RgYcU
	jo8wBCQZb2+i1KbyNavYE3w/UCMGYAWnjgBhHrs2umW3tBmD2BtBmprctIrqFjXjxvHHfX/El5f
	BjwWPhHectB4l7gHQoUPPqEx984tFenkRWno5rKla/IQxIjwzspE2hF4y+GeHsNEDC8JD9tkoq0
	yL7wSf5vfV6N6GgkE7nc18cnq4KsRsPHBWVUNFzYSi9fjEd0u0rR8gCMAD2+IuJEcLNB3YXVn9n
	ECIMFPL+bQVrC7vv1KgQzlKjyKU0uOLdeuo9Mb7sZkCQ4ZierBpQp4RUJ+9Ie5YMbowi3YVjgxY
	zEhiuG6wbupHusivyQRR0eTCeFU8KKwJMV0tNMMmWJwnTtPzCoxZt76CziQvTyLFQuaW5QGL8ny
	zLnc5zADsWaRHAgNbRgeOH9XrPl1SLfqxIf4VAKOq7lzwamATNEa7+OEaKxlOotIgDHXUPNhw=
X-Received: by 2002:a05:6102:8494:20b0:605:6468:bc86 with SMTP id ada2fe7eead31-62af93e22c6mr237092137.0.1777533749902;
        Thu, 30 Apr 2026 00:22:29 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62984335909sm2531425137.8.2026.04.30.00.22.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:22:29 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so1069835241.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9635QrlPN+RTw/qOM5q8cL6xASpvWPDjEtRAyLwI8g4CS33ek2YgInGnsCsTIUVkt21ZB8EKU=@vger.kernel.org
X-Received: by 2002:a05:6102:5489:b0:607:4fe2:d33f with SMTP id
 ada2fe7eead31-62afe60dacdmr375755137.12.1777533748960; Thu, 30 Apr 2026
 00:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429145624.2948432-1-arnd@kernel.org> <20260429145624.2948432-2-arnd@kernel.org>
In-Reply-To: <20260429145624.2948432-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 09:22:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTafaCe+M5GEi-35=92eTJ++U+TfUShw-aV6uifnkgTw@mail.gmail.com>
X-Gm-Features: AVHnY4KVIcY2rUp9jOsemm_MlRAb0mCVWFgMZJUFzGZGfCliMz66tg3ZVORjG4o
Message-ID: <CAMuHMdUTafaCe+M5GEi-35=92eTJ++U+TfUShw-aV6uifnkgTw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] ne2k: fold drivers/net/Space.c into ne.c
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 220B049E97D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-282680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.612];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, 29 Apr 2026 at 16:58, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> drivers/net/Space.c is the last remnant of the linux-2.4.x driver model
> that required each subsystem and device driver init function to be called
> from init/main.c explicitly, before the introduction of initcall levels.
>
> In linux-7.0, this was only used for a handful of ISA network drivers,
> with the ne2000 driver being the last one.
>
> Fold the code into ne.c directly, with minimal changes to preserve
> the existing command line parsing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  Documentation/arch/m68k/kernel-options.rst    |  24 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

> --- a/Documentation/arch/m68k/kernel-options.rst
> +++ b/Documentation/arch/m68k/kernel-options.rst
> @@ -244,23 +244,7 @@ drive (with "root=").
>  3) General Device Options (Amiga and Atari)
>  ===========================================
>
> -3.1) ether=
> ------------
> -
> -:Syntax: ether=[<irq>[,<base_addr>[,<mem_start>[,<mem_end>]]]],<dev-name>
> -
> -<dev-name> is the name of a net driver, as specified in
> -drivers/net/Space.c in the Linux source. Most prominent are eth0, ...
> -eth3, sl0, ... sl3, ppp0, ..., ppp3, dummy, and lo.
> -
> -The non-ethernet drivers (sl, ppp, dummy, lo) obviously ignore the
> -settings by this options. Also, the existing ethernet drivers for
> -Linux/m68k (ariadne, a2065, hydra) don't use them because Zorro boards
> -are really Plug-'n-Play, so the "ether=" option is useless altogether
> -for Linux/m68k.
> -
> -
> -3.2) hd=
> +3.1) hd=

[...]

> -3.3) max_scsi_luns=
> +3.2) max_scsi_luns=

[...]

> -3.4) st=
> +3.3) st=

[...]

> -3.5) dmasound=
> +3.4) dmasound=

So that's why you should leave numbering to the tooling ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

