Return-Path: <netdev+bounces-211512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B084B19DFF
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F57178368
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B15242D6B;
	Mon,  4 Aug 2025 08:52:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244F23BD13;
	Mon,  4 Aug 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297533; cv=none; b=GOoKZs2rTXzpeA/Be53NoO3IzXYAcYfHJojXnFWqscszSivyQyE0iUpruC3uebbK9Y9wagZaL1kJZBLlA61YxDyIP530Rdnm4aAnuM31d44TzPZBl0zbbuvltdSKTuuRrLSnVUYaDbJDxBrsz4ivMNiAR4p3thGYw8u/BESwT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297533; c=relaxed/simple;
	bh=4IU7flpgXJZ3fJEZAMijk8bAbla+8cir3PEIuaUq/rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O66FMvn9BdPCOFRINv1f7bgd7xT/Gb6dMX+cFdrnHUl4RhKv1plbhhOu3i2+JUz7hlFcJmguBrYP2tzYE3dra2Fy7qwD5oavN689ykqU/VCYBwvWzUqQgCmoCpoz7aMnHXKOD82kbADb0o52LW+Hpw0yKgTHGCR6/vInkhfty/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-539425e3719so1766915e0c.0;
        Mon, 04 Aug 2025 01:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297530; x=1754902330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5QpB/JqeqeUdWePuoOvkxy8agxOZ5xx1VKurmtRXZE=;
        b=NZwl7MTh5tNwIsPN8ulLwRuBY72qiV8eKi8GWMzzV4zkPQJF4bEkwvXxtCVHcEs/Nf
         KyftiIXswGmVhVVsPR267vJdIoh0VkfwEHNVL45OdjATmjtVWjTa9qIq7wzsvQ00CXHX
         F97ZPvk/WL/3m7OobYORPHOE4R5HMrdgH/lwUSOC10+BQtAMkXdibtn5YlWz5z8xYCaO
         f3/WD110MEj9aNSjjMkG5KdYcXUjQ55DD0kzPDPe8KTOucTj+jlHKOGNKeXOg0oxwjHz
         bbr37iTXRVNVXMpkfKJYb3IommdojYrIEr2KprStlVw7QVrOG03vhJnibkr5ki6l3GSM
         jsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9AO45lFWNp8yz2h5SLA6w8dlzhO3GuL+q6ko6U0Nz9SBUk56jN6ik8k8bRL4Vqc8qhR4GADQ2UtTjoqA=@vger.kernel.org, AJvYcCVhXCoEkUx1+EKTQ72daXdUhY1Ya+LNXal7fbvn0jxhEOdLRkJV6WsVc0DUY1uZ3O7XvfEilasE@vger.kernel.org
X-Gm-Message-State: AOJu0YybzniOJ/TQCOxYnhyGQMandLBsvftZSGu5tvTUzqn9U4T+Ie9d
	TIrF3fDrL2a3DlN+EAE0bpLTLqApDdjjCQtZ+d7AdKkk4CJ8OV2+Jo4XnO59y5dU
X-Gm-Gg: ASbGncsbgThSoDTAnAHaenVKioBxD3UtaYXJ48kqd/Dyx0l5Kb4eTm022rdQN5NzacF
	3ycqk24jYDppkYGCMIYn1ptVjLoxHoF+ZBLgXP3Az5cwn/T+r5lj2SHvM8Z0pmCAsQPrEoFYiKW
	Fha1fl1l5mivRt4n/0F6j55YEGtxzhHuicsY5HzQlGHq5qxTdxWYFA5Qc+3wBdxQwfAq5pjBVjE
	xV7jUta5oPhCT+/+7fSp7t2bjpebbVUv5R94kGOMayLIYpv/f3bq6YLFTH6Q7yai2zM3pejdpbd
	h2vXDU2slRssJ0Wt5lvHGBDbJWJWbFLTzOQCKja0MTJmjhG+30VBjz1K9yQW70KMWUZ9Lh4TW05
	H5JPjqnKTiDerQavW1QfZffCyZpffaFBqPvxfAJlk+8quFobFrs/tNRvuQo4e
X-Google-Smtp-Source: AGHT+IEG94e1NdA1ncJxzW5X3RjeTScjkmDOBRj+mxMcIF3HR8ivv0I8yaujkvqIHvFlNJ+XYIuCcg==
X-Received: by 2002:a05:6122:62ca:b0:538:e454:ea8e with SMTP id 71dfb90a1353d-53938905a99mr7460158e0c.7.1754297530249;
        Mon, 04 Aug 2025 01:52:10 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936cbf2dcsm2633683e0c.23.2025.08.04.01.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:52:09 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so2966370241.0;
        Mon, 04 Aug 2025 01:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEzdjb0Pd5v/Y5YwMWyJXRzZkY6bjh37nhpNQE1+zLnKuB6nS3YAq1DQW7GuN+8MqrB3b6Oxax@vger.kernel.org, AJvYcCVhzNeh+aMP4uicfYvJOUGk9EVfwdhie1CSPExq4sIVwe+420JR6jRZiPso9KWrSchFRdiCm3B8+DWlO1U=@vger.kernel.org
X-Received: by 2002:a05:6102:4689:b0:4df:e510:242e with SMTP id
 ada2fe7eead31-4fc0ff376b2mr4798820137.5.1754297529508; Mon, 04 Aug 2025
 01:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804083339.3200226-1-arnd@kernel.org>
In-Reply-To: <20250804083339.3200226-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Aug 2025 10:51:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfsx-sNRWRPGPLj=wp-b2jnB8pTBdd7AVqDq4ZZisS+w@mail.gmail.com>
X-Gm-Features: Ac12FXy411-kQa3rWYorV5SoSgcF9GIrfasroFLsMIq3x61Sc0JlLNlmvUtf7PE
Message-ID: <CAMuHMdVfsx-sNRWRPGPLj=wp-b2jnB8pTBdd7AVqDq4ZZisS+w@mail.gmail.com>
Subject: Re: [PATCH] dpll: add back CONFIG_NET dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Jakub Kicinski <kuba@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 4 Aug 2025 at 10:33, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Making the two bus specific front-ends the primary Kconfig symbol
> results in a build failure when CONFIG_NET is disabled as this now
> ignores the dependency:
>
> WARNING: unmet direct dependencies detected for ZL3073X
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - ZL3073X_I2C [=y] && I2C [=y]
>
> Make all of them depend on NET.
>
> Fixes: a4f0866e3dbb ("dpll: Make ZL3073X invisible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

I already sent a similar patch two days ago:
https://lore.kernel.org/all/20250802155302.3673457-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

