Return-Path: <netdev+bounces-292299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKP+BYzwFmpcxwcAu9opvQ
	(envelope-from <netdev+bounces-292299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A65E4E5B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF145300AC12
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BF405C3E;
	Wed, 27 May 2026 13:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9A40DFB6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887916; cv=none; b=chXKF5M4b7RZMbv8PaBu0enG+IXQIwHtCmOYU+gXs6/Kol69tXOQLTDuEFHSTIXYOsfW6shyeT0Om0mEP8gVfwOapfOeRl469//OAh2mEx/lmjhOZ6ZhxmY8q9VIriTZTWtAfELVan1Y8Fj6lzoKJtORC6l/vrLQkSALIEFZmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887916; c=relaxed/simple;
	bh=tmDU4VguE+cwpfpInPS+PXjfh3XEe4XV+vkqOU8kHK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwxY/yJRzpZ3q5KrkZSQqYrhP/xxamVCUQ9GmQp90kVNZNrzklutHBP0HvRUgo2UFtQ1P8Jwhgq6IrrML14fPVGlDYsKl3pjV0r7TaMkIT4E7TiBaqu9cropqN119Ihm8wLN8xuMk0OUDm/5uRHvGokoId8fAOi3WSbV6Q1rQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95f9d6a3a04so8469478241.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887911; x=1780492711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MuSPc8y576tayBCaWdrNcab8/lH09ziazVq9lwM/2k=;
        b=rVqE/ByVEJesmlqgy+63q2U9abgw5zg6kT4DWmshSALN83S4CCKcv8Ot8TXmEs2SVT
         QuxuS6BzfE7ANlF1C0PLg87pXZP5dgeo31H3FE9nezcPZxkjmjo4cT7+++U2jZCZ83z2
         3Aki4eAHAYW13fJbF98n6cSHWgLkIRLWWBjofN+W7ci3dfodpxbwZjSAdf73aiE6QHRg
         8FP+UaeM3a0aBbL5S5Vl8ylii42Fi+w1BQbx1rMwZ7K03boKeg8oqCcK+Bqer4/51Lrg
         Fif0t9GSo31AUbQoz0qyuaJ9oda4LqqN5cKZVbXgaArprGelrOEcn5aJajdvVd9sqBBO
         7yLw==
X-Forwarded-Encrypted: i=1; AFNElJ8aBSMPYdau63z5cLqKEoPVN+R1Hry2SP0bVqRYw/H/4YqnmKXXLUDyeFFBdwlFhZqjK0xQji0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutnauOBROQZEcjuKZBTDJ3tLJYIgAmhCBu5t4Odn8MDA61E4r
	CVYJ5XPHBlEGHkV2AeDKBpP0xwO69gmxDCE5va0JHi4Rox7fVFBl9SPsJ/ulfU71Ark=
X-Gm-Gg: Acq92OHm1vVfi3+tuHSi9LfcSWe0tFyNyJgbWRuGulUJYtE4deTmNeazsxCk2qVrCG2
	b6lSH3ziSN4zeekaN/9BW9mLknWZ340EHqqTKN5sl+KseRBRm/yoBv1nGl3gHvwlk6F1Fq/QsHW
	oONOJ55O2CsryoYt0490PedlFMj4HPWJaB0+3a6hqz3WbBanepS9ZlRTJ9cMCqyHbeveVm6J8Ip
	eVbL8CBwxFbdFVGBra+OpGFsIon43jW++4KM084XSoAP80/5ndCpiGGPGUdkxyIMBBFgKwkbLKu
	gEDHp5T+SEdJkyi3fQ+CqRAcW1RVqsrVVgqd+/J2rVabxP+a9ZFb6AHtBMok5BELxy8QhHIJLSw
	TgIr2xy4sCpipulv0EsMW/ccbB0hfatX+C8yO3/hIvwFtmC5dygFzoTZzjx0T1ASMVfhke6IlVq
	Qa/58/u+RLT8/uxlpZibhYlGOZUfihduttako15wuGuNx2UPU5GrLvPrfeK6jAN/jheUMHN3TZ0
	UQ=
X-Received: by 2002:a05:6102:e12:b0:660:e00e:720a with SMTP id ada2fe7eead31-67c7ca04ebbmr11681533137.8.1779887911289;
        Wed, 27 May 2026 06:18:31 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-67fc9a0fd00sm17276112137.0.2026.05.27.06.18.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:18:30 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-57746408b3eso7156224e0c.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:18:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zOtHquZpCOuizmYHeO+z2qMli6Wq1UH51TtdtXZ96lviDVSxALUAfrl2KIScZ42FZQ+9Cxas=@vger.kernel.org
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr11675886e0c.3.1779887909452; Wed, 27 May 2026
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:18:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
X-Gm-Features: AVHnY4K9MKooRiuSGEh5fNQ2eTKctG0rOT_zroLTx4bk0lQkHEgucmZG57_gNvg
Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,hansenpartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de,lists.linux-m68k.org,vger.kernel.org,codasip.com,c--e.de,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 810A65E4E5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Technically it is fine (on all current Linux architectures) to store a
> pointer in an unsigned long variable. However this needs explicit
> casting which is an easy source for type mismatches.
>
> By replacing the plain unsigned long .driver_data in struct
> zorro_device_id by an anonymous union, most of the casting can be
> dropped. There is still some implicit casting involved (between a void *
> and a driver specific pointer type), but that's better than the approach
> to store a pointer in an unsigned long variable as this doesn't lose the
> information that the data being pointed to is const.
>
> All users of struct zorro_device_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

