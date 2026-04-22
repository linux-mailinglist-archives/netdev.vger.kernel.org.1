Return-Path: <netdev+bounces-280401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENJtMoO86GkHPgIAu9opvQ
	(envelope-from <netdev+bounces-280401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65944445CF0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E732F304D1E4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A013D332A;
	Wed, 22 Apr 2026 12:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD63D3485
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860245; cv=none; b=QQDL11/KTmN+MtJHQFC5yYN/K19w+QWmZ1tfnz68hM9rWW9yaH8bai5VoFb/URDYMksljTsngvEsME34QpPr19a1dUCAzxsluTr/4B0JkBYms/kQB3Ukixe4p28GF7NUgF9pILvvLHOwxq2BYEmD0GxzwanA5X+7FXSlj1ZQiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860245; c=relaxed/simple;
	bh=8liP4h/sSukob9NZJj2ZmMwY7hrnXfLoNL5qGOQZ7wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpBZNwRtpKIJvdgU6CQtqSbyDagaM5g05uAoPAijQi6myi1LkSkA8FFwH/jF0fydGnhnl9SySOPG5+zqJUKarkMB4opq3zXn74BqZ7pOHFDaF81JnkABG+2Xjm5fhiDW7YsFI0nRNx2Ru3xllr4zCposSDw4T+dLWW3KWJxaL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56f3e6bbecdso1723583e0c.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860242; x=1777465042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9Gk7NlGx3Pa+KYEqbz8NqB+qEb7KkfrgOz9kzX/j7o=;
        b=MEyq0gFMbnXdeZ5sszlyl+96+dcItwZsBDVSt6V2toPmVhK5BTiFbd4BxE3z9eDbWb
         XsllQwHjJOl9fzagOQV5vPIzjAF2AgpqxFDzQSSDxB0mDlHHGHrh+6UBtlilfTIwWsAD
         HdfM71qGMwaN2XHS/SizBg9aOVfuogWvP1QMrSMV0wHj6/6beoiU1ICZmfKscL3hkKKp
         YpCRP6D26ibxtNwawT7WneNE6pZuYrKmJ2enIiYdHYKhj7rL8YH48aPrbUnEdTG5F5w9
         vPvqGACBOdFe+iEvnsggsO2J+/Ghv17t1ErQwzOdU7E7zpMW6mH2HY+S71LflZRZK28E
         yjTw==
X-Forwarded-Encrypted: i=1; AFNElJ9yHpzjglmKReQXXJdFv4DzSMaOKaKwdhtupTku4RBeLBLlW/T+g5dD27PtzPaH9FKj/8GjMOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcleE8cZ+7KI/BByOYSR+fETbqSbm4vKQwXsWrOKTeIMtty6J
	AYjz+68JgLTtImMCbWzuHu+tFZL3WVtlrCIXl68egl3xX7hUWOlsx9VUHoR0WegMtic=
X-Gm-Gg: AeBDieu94UcqKgob8cKQxYXrml3vl/dScQoeR/3nomphMeQJ4MsvKFkrDtkKCViBE/G
	ani28AlVeV7Cx03t0cEeGToV1oISCyfhyQ4cc7a4dS38fc0Q7GoUMCe0cg7P163ah3btMuJpZJf
	LRrQ9wyaa0ca3iJGiOChC1Bq5APnk/QlcHpdfWXU1Z2uAXSQ3NjTqLC25QM7bO8eVfZsf3FEPoe
	E35oA0TwQv5KIHd4QftV0VKrJfHFRPhgy3XTowF4Y6OV4ulDTCyjKpdZVcJflWs4khTjfxMenca
	ue5I32ImdM60YIhoySvlHwbKz1WIOefsJjY52rdQeEBfgC+WTRpsmp3kLYfZpT45B9nQdSVd+IL
	xmBuu61kRxmkxBGbXt94QqJ8E7u89gS61AzFpndH+4IHAtupjVt/tZuygXZZnCenNerOUqHrvol
	68BKh7e9m7L/aJ1oO66I6EU8qVZIAimyD2+03Sstg5VWV6ExXjTB0Glhdz0NC9wgzUx2EJHRpxj
	DY=
X-Received: by 2002:a05:6122:4d0f:b0:56f:6d11:b962 with SMTP id 71dfb90a1353d-56fa57fac70mr10407251e0c.2.1776860242409;
        Wed, 22 Apr 2026 05:17:22 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf120sm10100939e0c.3.2026.04.22.05.17.19
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 05:17:20 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5673804da95so1648853e0c.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8NZy2b9Q9JqsjrGFCEIe/38QhhZ2TgfccPWYZj0/R7AaXvkf1BafWwYcjUHUmjRdwmF7LM0fI=@vger.kernel.org
X-Received: by 2002:a05:6122:a5c8:20b0:56d:a755:ec64 with SMTP id
 71dfb90a1353d-56fa5996d1dmr6692406e0c.11.1776860239548; Wed, 22 Apr 2026
 05:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-11-69517c689d1f@lunn.ch>
 <CAMuHMdWz=ucmKxHXmzKj=oTn6yMVxPnkNxtG6X2C3ts_ZCg4Cw@mail.gmail.com> <c6696785-6f1f-4747-996a-d86a60a23d0b@lunn.ch>
In-Reply-To: <c6696785-6f1f-4747-996a-d86a60a23d0b@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 14:17:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwFcgDBSSKWnPvk=PYHrMpLggD1Kai5Lwgzw-B1bjSug@mail.gmail.com>
X-Gm-Features: AQROBzCGeOoH8mPu3oeUJXSUmUlNNIiPpoOzPEq6pycWYICdTP5qPjzGmvFicgo
Message-ID: <CAMuHMdVwFcgDBSSKWnPvk=PYHrMpLggD1Kai5Lwgzw-B1bjSug@mail.gmail.com>
Subject: Re: [PATCH net 11/18] drivers: net: cirrus: cs89x0: Remove this driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-280401-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,lunn.ch:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65944445CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, 22 Apr 2026 at 14:13, Andrew Lunn <andrew@lunn.ch> wrote:
> > > -config CS89x0_PLATFORM
> > > -       tristate "CS89x0 platform driver support"
> > > -       depends on ARM || (COMPILE_TEST && !PPC)
> > > -       select CS89x0
> > > -       help
> > > -         Say Y to compile the cs89x0 platform driver. This makes this driver
> > > -         suitable for use on certain evaluation boards such as the iMX21ADS.
> > > -
> > > -         To compile this driver as a module, choose M here. The module
> > > -         will be called cs89x0.
> >
> > This is the more modern DT-based part...
>
> No dependency on OF?

I guess no one bothered to add it, as it presumably builds fine without.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

