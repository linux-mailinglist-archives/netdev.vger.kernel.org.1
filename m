Return-Path: <netdev+bounces-289374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NeLD1g1DGoKaAUAu9opvQ
	(envelope-from <netdev+bounces-289374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F157BD06
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E4F33029C23
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC37466B63;
	Tue, 19 May 2026 09:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE332388E53
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184315; cv=none; b=NaX2qyTYOjeQ2PzcK4OFlXb1Zqx5LH83L7bJEDARCYyUqgfjHtRiCl6eAKX5xbXT+VOGGkUq6lwD6zOa4S1KXKCJhmQGj/Bdoun9uKT/98aL5AYoTXprgQ1VekZOpbcrVXr0f1t+l68kk7opXGuYapDeiOu5qYI8p71vwJiFM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184315; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfO2e4yeMYCqOZOr8ndx7qo28YtjK/74D+l/Y7NB6B1NUnRIJWpH3wqmpbKKnBxXQEEKBT3C/3RtJptjqPrVxZZGKm3E0r/7ooI/+ZoBR3hKvMVFjvEcKiDqJ6E7Txd4UzFsQrWE1liDz562xIN/8cvcZdJVEmxdhmy+9pGKXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43a6faf8d1eso1229198fac.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184313; x=1779789113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=i1BRUaYrZU5o+1qMJUMU4ujm0QbEYY6earethr0et1NT3+CelA4QG3kRltzbCNUodr
         LWTOEAszGIMqKbd45S0QVjhMbDa3xTQMh1aW8ynVQeKtCx1fEldVu5FhBpSDSWb46dgj
         CNwDRHlKqOzd8OnGOd+IqdAdKvbiq1hL2pBPqrUc474k7VwYZKuNZgXkPSCHtkcnrXjN
         txEj3IdDOTBH5knb9DTGST1NYkdS4jyhj/FvHHSihhxCjZeEWnU7knWDukVHtLigCWfs
         l9Jdfg81aLyQBojY0LtTSZ3QTMogAzvroqffj8nCjde4WqynjtF251DWNMmBSLWYCuJk
         sIUw==
X-Forwarded-Encrypted: i=1; AFNElJ/LCmw8Kfbuh5twXr3DxX2LeMT49UkFY9VVGlQ6GldJSkSloB4JQAbLro9bdHLmLM54H9GOr/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvF0WHtH/c3POhq6wg5QbSqY/HahD9fCjwuPugP3UFc//T3P+
	z1RxEmJVaBMbCVzsouRCbL0e0QYWSD/b/FNJ694OGLgNX3Iz+gPkhCkNeGMtmQXX
X-Gm-Gg: Acq92OFL0WhfRrWOFR4bEPGw81PhHFCvAfVZu7jpK2z9cL2RmyTXVtL0oKCRxBP5/i1
	y13jg4qGk2o7qgEMtzzfcyUY3wy6EirJc8hCmijgpMDq4XG6/GAhsd744NB55uMCxUayCdp/LBs
	K6w6qXEUbO8JlJ74uvrqHkrOCnW9UNdtGHL/YEF9IsceRxkpA2t2GB9lmSDGA97l7dqxePHNvH5
	2MrwWXhmCYZfjUbMJtmwuDDGO0Tn1sqRTJck6zyOWdzoQPPbUu71Vo+2RjGrGgbiOx6NOyMpO7P
	eXXYo/4+8B7QwKY7W86q45v9vj3Nd0FR1UrBvjV846WJjTOINAJxa1I6EHltBBgObdbKASfAkwe
	SkrzfRDwSJn+CRk5rAoXzedIH0u8sQftCX566y/GSw5usS49dV6oPiYIM6/spqQjFpj3YpcEoLz
	PCfB+mbjHoMqM8+6CaJe9Qm4XFUS4jP6EM9/EPZn9LiuQ+DR87p93y92cQIwZ+wK0YRJQTnrZYA
	OU=
X-Received: by 2002:a05:6871:3a21:b0:42c:d98:9540 with SMTP id 586e51a60fabf-43a2d4aeba7mr12302063fac.0.1779184312744;
        Tue, 19 May 2026 02:51:52 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94f49da9sm7027295fac.3.2026.05.19.02.51.51
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:51:52 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47cba53479aso2455637b6e.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:51:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9tZguR0BzGcUwphlQmY70UBz+cfaof/QLC2cm+T7x13Pc7ErRX53uJlU1GW9dZpFMlY+HJ9ao=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,lpc.events:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE1F157BD06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

