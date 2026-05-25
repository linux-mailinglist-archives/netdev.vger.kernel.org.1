Return-Path: <netdev+bounces-291267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMyBFSUPFGpeJQcAu9opvQ
	(envelope-from <netdev+bounces-291267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5635C83B4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBE3E3003BCF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE363E5560;
	Mon, 25 May 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsfSJ9qs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C23E4C95
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699484; cv=none; b=peIi2K4/O4Tjni36Juh+enkEXqUJAn8qRiDYArc9ej/m/bKPFq03ghhO20iIQJiW9IL2F+zSW1zXtm3y7GMv/xgvEikcx6vrhEs7DAJBNvJV2xizWBLByNxG4VQ6To9rLXSh8zivpFiGebi3pJzyWf1L5DyaEpKP3FmrLzUJLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699484; c=relaxed/simple;
	bh=xXz/GYVV9QSNbeC/HxJ0KuDPx2s68Hc+e5zq10KEVeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMM1Rjx0D4SlYAfqWi5W42zxfi39P4zSAMbozWRY7d7J7sRpFG6lKDGyeJMwlGQ5pGaT9ERJ/mWXF9mGLj6GBJgOTcz8penpXAm9/GbUijmTyj3hETSesKcL9Ztg3jT3s5mWAmxmNkbhjKnf+9AmKgOcVoiiLTjyAa39Gf5rYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsfSJ9qs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D79E1F01567
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779699482;
	bh=xXz/GYVV9QSNbeC/HxJ0KuDPx2s68Hc+e5zq10KEVeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PsfSJ9qsfwUwMwGEQi9C5gkghGo00zi/UHVZXT4fQmDaGE2tbo69FkGJUMDmJx5ZP
	 ajPVIPljZ4PYnb9NQO2JuaYOFz0uSSzjinXFbifeiuH7Y5hFnmw/pg0AbsywCXU/SD
	 iPUkHSnbzPHqA1uoorTRRt7DninH/J/mgesmdexSXzDEg3Ao0pEGi/C476ZUYOoNjo
	 DhVby5WWmAzJI1rJokBGqtXYfB6crSo2ze8eCNS3Z8HpmjitJ5phMuXGeqY8YpS/IE
	 4iv+mYl92pOnQMXUwDk8yLuuzxK9SKUDmBR1sZXJrfOae8y4hAMWzbqZLbeDzEDzc2
	 WZ12vmUy0grtA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e5fe62fc87so2616277a34.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ghOILHQztpupDecxbuTxCf0k46i8lQvCpsJZM9LSyVqSgKkTSsy+/d/JPc22VUkPaEREmyFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Z86YOa9UNvMSANxIfn8qAXYo6e8hKVbjK5JUPEf3d51NYa4y
	iuTFnP7LcNX2ivh4gqlmzMPBipH5ezBQHAmSOIMXvtkKgdWmA1PsBjxho3oeITZYMwnXc8nKbV8
	0+sY8TRsquEoo77txV8D2fP4IZRMBogU=
X-Received: by 2002:a05:6830:4985:b0:7d7:fb8c:3c29 with SMTP id
 46e09a7af769-7e5feeb63a7mr8912823a34.14.1779699481274; Mon, 25 May 2026
 01:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520183815.2510387-1-arnd@kernel.org> <20260520183815.2510387-3-arnd@kernel.org>
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:57:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
X-Gm-Features: AVHnY4KW10_QvipgU3JqDhFdOUhRtRqnFXdZTNq6fk963CfrOH70VHOW3qgjj1k
Message-ID: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Christian Lamparter <chunkeey@googlemail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291267-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[40];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F5635C83B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 8:38=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
>
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
>
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
>
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gm=
ail.com/
> Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

