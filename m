Return-Path: <netdev+bounces-281766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCGzMcSG8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:07:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EA482383
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90A10301F15B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8A3E0C52;
	Tue, 28 Apr 2026 10:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866C346ADE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370609; cv=none; b=Zl9fVWm2zXpKh9c4fCjUtY58KNHQ1s3cxUq7Fx3jqU9Cfep300msDB2DXIvv5uo/ufCc6tAhslIz60WHFpctqI+goPNSUjir9t2fBXAd8udRjS3zFafxllV+2rzk3o71SZN2T8yFxGa/ac3dKFVnUH4vbTf7qt+LK3njRPJDZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370609; c=relaxed/simple;
	bh=nE2kTc46EAtHp+hzkKm/fM0pnbhHAPrXksUwFRqrq6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ0Do9IFZdChMw32jJHXwDpnHHWt3y/44bPk1n6w294Bp5QEjCEy9ZbE+PRcOe6b5iSCRtDK+G6I/sAm0Qd46wm5FjtTNcm9zXKzQU152Dhf7A3XVTl5HPBZS9erUTDtPM/o8X4I96B/7gaplYhRkASmlypzoCFyZ9/BzZ+FVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d93355337so6871341e0c.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777370607; x=1777975407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRyHSlueZ2yIa5nhGJ3DTVlj1ZKdcYhWGe6E+g/f2HU=;
        b=mzCsOwPn64XntBSyJf1GGef0hbKFJWjipJ0RoCYIOAWNjDGo5HQuzM0TgGOgkQvRmy
         5aMCouyQtn9lNWFHnL/eHOwQ2LmYjNH3Yunuzs2r0wgTEU1WyTdN4sO/oi7YxHmKLueE
         wUC0YhRjWIiSu6cHc2y7Cu7k6LuIZDyKVDRu/CDAemjJ2P7ycUUQEZk3h2whuR1bfyO+
         V04Tc9SVXYL7QqILYIxwkJ0JU1kiEjzHEYeyuAAzqo4/MIZLc1AR+JgCIml3rr2dLOi8
         v2YQHc3tp8hnYJPZdzzC1OEiYBGmNR+2e2+0gc7Kb79nMa6k1FAxgvUtJrQIXP/WLsI3
         dFgg==
X-Gm-Message-State: AOJu0YyMLFWYPxQlQhgJm42s72wcRu41yLY2fnCITeyCvYwWX5P0v1GG
	Qw93X0SAHOzN6ABww37fhV4PvJ8cPpEhE5sGMFeS3mgZHW5upCzRQmyiOoSp9CVY0s0=
X-Gm-Gg: AeBDiesAJtloWvwhqaHP2HOdc8LWvMJEhS4zjT9hK9s9W0wQXzUFVbpHawnWVgzgnYP
	UKJxIZpT1RVtht/pD5bDUcvvk6JtSmGPcGFwR+c6TGbQdjWw5kNC12CkypYyu0TvjMvj1jrAdQt
	mgRP475TLe+FZbtdjsHtoD8qMxi6251Mn7JpzPxQnlGjDppLrjzryoWoYq3OYndL8pc5Ufih+TG
	9n9QSK08HdrKwgt3zdswETOTQSNZbH+3D3LJqbcakzreHgOi4sNN1TQdgGwrpu/v5poplZ+WqB+
	EFsVg8Ga7tbcFaBUBzgxXd9WC7h4Y1t8WnPD2ATh4PhhgqzHAiRn1RZX1PWyoKgYw551nzRyJWw
	3a09AceQwZ5z8Fpo2xYCsshPoEGWY13DvpQw7Fo2fCRu+2x7NBbsblbTclsm/4H2+5Vt+rWhEF6
	T4cv+cb8wqAEvbl9fG+lAJD1rw5gASJkteQ3vpDxX3oKsdMVWAAo6rWq8gdyR4UVh4K6JjGxguT
	TgWceboN+64NA==
X-Received: by 2002:a05:6122:1b8d:b0:56c:3a57:aee2 with SMTP id 71dfb90a1353d-573a557eeedmr990428e0c.6.1777370607234;
        Tue, 28 Apr 2026 03:03:27 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573a3ec0da3sm1398154e0c.0.2026.04.28.03.03.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:03:26 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56f8c77ca6aso7620705e0c.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:03:26 -0700 (PDT)
X-Received: by 2002:a05:6102:8029:b0:609:444:eda3 with SMTP id
 ada2fe7eead31-6280aab5390mr872346137.17.1777370606595; Tue, 28 Apr 2026
 03:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428024400.123337-1-ebiggers@kernel.org> <20260428024400.123337-5-ebiggers@kernel.org>
In-Reply-To: <20260428024400.123337-5-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 12:03:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVc4_1hfrX5_qTrNmz8dpe=H37i-N0xy9_M3ZkzUTO3Mg@mail.gmail.com>
X-Gm-Features: AVHnY4IhVtJeI5bzqGCht8kP6KzDoM5sv9OtFI_ZUfpavb2rJ-ZtQSNVRJUngeM
Message-ID: <CAMuHMdVc4_1hfrX5_qTrNmz8dpe=H37i-N0xy9_M3ZkzUTO3Mg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] crypto: fcrypt - Remove support for FCrypt
 block cipher
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 482EA482383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281766-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,openafs.org:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 at 04:49, Eric Biggers <ebiggers@kernel.org> wrote:
> Remove the insecure FCrypt block cipher from the crypto API.  Its only
> user was net/rxrpc/, but now net/rxrpc/ implements it locally.  The
> crypto API implementation is no longer needed.
>
> For some additional context: FCrypt was designed in 1988 and is
> essentially a weakened version of DES.  It has the same 56-bit key size
> as DES, which is easily brute forced.  Moreover, it's cryptographically
> weak and doesn't even provide the intended 56-bit security level.  Its
> author considers it to be a mistake, as well
> (https://lists.openafs.org/pipermail/openafs-devel/2000-December/005320.html).
>
> But fortunately this 1980s-era homebrew block cipher was never adopted
> outside of net/rxrpc/.  So its code can just be kept there.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

>  arch/m68k/configs/amiga_defconfig           |   1 -
>  arch/m68k/configs/apollo_defconfig          |   1 -
>  arch/m68k/configs/atari_defconfig           |   1 -
>  arch/m68k/configs/bvme6000_defconfig        |   1 -
>  arch/m68k/configs/hp300_defconfig           |   1 -
>  arch/m68k/configs/mac_defconfig             |   1 -
>  arch/m68k/configs/multi_defconfig           |   1 -
>  arch/m68k/configs/mvme147_defconfig         |   1 -
>  arch/m68k/configs/mvme16x_defconfig         |   1 -
>  arch/m68k/configs/q40_defconfig             |   1 -
>  arch/m68k/configs/sun3_defconfig            |   1 -
>  arch/m68k/configs/sun3x_defconfig           |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

