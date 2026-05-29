Return-Path: <netdev+bounces-292986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INtJJDgmGWq9rAgAu9opvQ
	(envelope-from <netdev+bounces-292986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2855FD658
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D623301DA46
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5E3A0E8D;
	Fri, 29 May 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGrftDdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102839EF2E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033028; cv=none; b=Rt3BrZ9SuE96E5fnNA/EuzT7UHCjViDE0mD1421WQLfLYob1M015qA5FWq9GwAxHN3WmI16eS2fJOFOtBPfUxDqg7+Endy+NDYxkKcWqhlShdB9sZxyJpqxoc3O6EB9FOf3ocm5hitXg6N8qr5H8wR8ux3KycZmrd9i/4u/x3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033028; c=relaxed/simple;
	bh=U/u+I7Fjs+lyPrjV5mTGiCw54swil5vB5IqkaePU3UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/IWEnsSoTHVg4yU+MEtsddCI8W38AUkQ38PRoo85yinU+eUfUd6NSum/kDsjmm8ZGtyNCnVVZdWPeCC7ofpRbilX1OEcPpNnaer8E1JeGwRNG48W+naUE1RHsCYxXvwy9PJ2eVu3lXJYWbsNjYp0J0jWsfdfGi/fa8fannHy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGrftDdx; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1363e78746eso9885047c88.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033026; x=1780637826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=gGrftDdxpBqeEcytuF5cMQivW8TLP4X3skIaFHpeJvM0bkgwWiUxNyfbJQ6N0n9Nnv
         23NhooJzbJjpL3HS//soTiF2H1Jz1hokAV61p6wLnyy7muOB5dVjifRy6Q/vJhGGRQsP
         9od7sc2lJz1LE7pvzI4Cv5Ymik3J5VXURow1bXTxx1meU8D/tMLumKW2voUjQIc58P6B
         xcn00iQe+BNYjmW7eNBTCIqwcBptl1MSod/KdGsU92p1KzWHrmEy/1se9JrHn9cO7F+O
         XVzU0QckkcIitEwwHaQdY1TIGeeEBHjW80XpoGehapMt7ZYnXgQACsnmFxuYbTievMKK
         tNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033026; x=1780637826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=iycFdpTzKoDk1VVZbndHHJd0Mrr0GzoBLfdnE3VjuIV9zmwcjKW1aBRGANIeYBg9CH
         ioILlAkK17TZCE6XvqNTqOSA51pq2BSU+qWJE8aGWwwCSiDIs4nb+4VCGGHUCb5wOHpm
         /2WY6XA9IwGO2VEq4PSUV6eW0rxsIhC173DVvvafa6b5/fM6rQ6IHOOnwm9MYJCPtEC4
         2MXfHcFXLn4mWbBj3Or8GHl5zNNXS+Veyv3lV7HuFEDCSgR9udM/5UsBL7r5d6203Y2z
         NpTrgmIOmIdkke9t8Y2zIiISVYh7/9vFgrJpr03DcD0yebjPnL6LeOwVs5ySk+/EtnP+
         5OzA==
X-Forwarded-Encrypted: i=1; AFNElJ/uyPfvysaHEfl1lUl6q/gWl0oiPRjTzuWn+SHMnZo5Z3TMbYQRkTMnqPwVSjidn+ojYXgWPf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3doVA0HMGCTYj0zA/zL7516P3A3nZJ6l0pqz3TZcv9wYN232t
	Q3eIdKfPob3iYLJRAcaoANuhikTCQ8/EjprxhCaHu9s7FnhMy8zfabFB
X-Gm-Gg: Acq92OE+ZdHD6bxR7oExY8NpfImvFlEhA7kqLtrwPfbn1/0NqKdSjjB6BWug2weCzjx
	l3D8iknEK2AVakTvK1fBeJrTNaBUBvyaB4qQDMKn+dW/E44Q2Dq6V2ZactQnMB3tIVrugYG5vgm
	ZL+dusaE2xoq83skHEwUF5cjdS86KDep7He4qo3vu3kxyzi0QCKmI/1qeLBzHsExkUl3FaBeQER
	BVaaCNJ70/ZRHgvrkMOikYpctaOGsSqX7xZlmvs7vCf0XurMHfrDItRetDmmCtmE2ibrgAVzWs2
	MZPQ+niDPM4ssS904hwVgr8NGkK+oiLFlJK29QA05n105SrlknbD+9V/yoFy7fVgqaMXunsNmJY
	FcWyR6rsOu9UgHHUaPVokHMUuVPH89ptor8lbnE7CznTRC+8QkM1ijlnuOQ4kRngWDZ4oIpIJLO
	d9hDpJZgu9SgxJPijul/xk79Gk7GEO/d3AIHfKWfBhTxGJTTmpveGSeKAIpB3votfk7MsRv3Wn3
	UE=
X-Received: by 2002:a05:7022:2223:b0:135:d76a:aedc with SMTP id a92af1059eb24-137aeee5faemr536827c88.33.1780033026219;
        Thu, 28 May 2026 22:37:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e169:a62b:d3ca:e8c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm832719c88.0.2026.05.28.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:37:05 -0700 (PDT)
Date: Thu, 28 May 2026 22:37:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Lamparter <chunkeey@googlemail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <ahklyAUMaOxy3Z9X@google.com>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B2855FD658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:57:44AM +0200, Linus Walleij wrote:
> On Wed, May 20, 2026 at 8:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> > interfaces, but there are still number of ancient sh, arm32 and x86
> > machines that have never been converted.
> >
> > Add an #ifdef block for the parts of the driver that are only used on
> > those legacy machines.
> >
> > The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> > passing an IRQ number instead. In order to keep this working both with
> > and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> > the gpio number if an IRQ is passed.
> >
> > Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> > Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>

OK, if Lee Acks MFD changes I can pick this up.

Thanks.

-- 
Dmitry

