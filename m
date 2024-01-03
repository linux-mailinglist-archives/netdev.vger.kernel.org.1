Return-Path: <netdev+bounces-61240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C23822F68
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D468286B24
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A121A587;
	Wed,  3 Jan 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="RHp4qIku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E61A702
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso7562122e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1704292046; x=1704896846; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxC9+WOvmtgTFNxfsUnHcQ7SgJaLo5O3yKhPltwGLqk=;
        b=RHp4qIkuW/ha+EwN5rris47bHZXhV/w92IWVbhb4/L/nm7S8AmfRiJmWlJ+ezaaIJG
         bEYUH7jjOI4orPPmeZsGIwGP7g1cSS4Bw6klxP0om8l1UrnBWKQxIUFmvY+7/wIr71WB
         V/8xBdRcNNw6b+5xRjmpLb0Hcd2TmnPysCIc3totC7pP1QHu5Z5SiMrB8edVtlFCRI0F
         pWxCnzZvmNPMNgY/Aqvua5ZToUfX/0HhQKrOM6b1V5o4xMomTq32YxY878zszJ7JfFiZ
         4DFw7U1lF18grKGliTwk1iK6HZPGCfo/5wlQ1lWqm+WqghkCDMJHJg/BC80szXDKfucv
         8kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292046; x=1704896846;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxC9+WOvmtgTFNxfsUnHcQ7SgJaLo5O3yKhPltwGLqk=;
        b=lTAZDDXXsDhssqOwlbJmiZVozIPHRudB+VwRT5RSjmm4wN+c82N1XlJurByIxi3nZ0
         eJbh6z3/LabtaZK7GHRJfV1IsspxyetNGVeabOHTNsIq0aljrEpqGDnBIfQDaZaJ6RTV
         VMFnbmRvYM22UI4wO+qGyxbc5ln9pB/GocS570m46YMNOJpuJ0jOmwHGxhQpXJdCd/z6
         Y7sNuKT7NfAAdbJNxqIQkDWBl5LMSTCEOTWYGqKbTwthllnpHCO2HD7JCgUH0+I/DniI
         3QTh7qVeprIVlYsY7MSO0rbB+oaER0sLYcwn2amqVj/TwZWSAWyEi+PkhCa7tBqzuikB
         uMhg==
X-Gm-Message-State: AOJu0YwcOdPWLXFHUVLwT5GiKSRkMY4vZNHlHSMZH5OnYpDOy6lbZwXb
	/lr5wh9NhUwFpeijTvKaI+YfNUnSIYtfp7zHjdgi/MfTcIs=
X-Google-Smtp-Source: AGHT+IEEOd1yjo0FpFXkd1FQ8GaN3ytXrZa7jQigXXn91m2TbYNfog+LaDaSU9nzyXnZofxYAknwmw==
X-Received: by 2002:a19:5e53:0:b0:50b:e724:62a8 with SMTP id z19-20020a195e53000000b0050be72462a8mr8686599lfi.92.1704292045723;
        Wed, 03 Jan 2024 06:27:25 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id y28-20020ac255bc000000b0050e7fe17591sm2497185lfg.137.2024.01.03.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:27:25 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
In-Reply-To: <8f9b8a8f-6741-4676-900a-e5832eb31fba@lunn.ch>
References: <20240103103351.1188835-1-tobias@waldekranz.com>
 <20240103103351.1188835-2-tobias@waldekranz.com>
 <8f9b8a8f-6741-4676-900a-e5832eb31fba@lunn.ch>
Date: Wed, 03 Jan 2024 15:27:24 +0100
Message-ID: <87jzoq7ar7.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, jan 03, 2024 at 15:09, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jan 03, 2024 at 11:33:50AM +0100, Tobias Waldekranz wrote:
>> Parse LEDs from DT and register them with the kernel, for chips that
>> support it. No actual implementations exist yet, they will be added in
>> upcoming commits.
>
> Hi Tobias
>
> There are three of us now working on this. Linus, you and me. We all
> have different implementations.

Oh, sorry about that. I should have done the proper research before
posting :)

> What i don't like about this is that is has code which is going to be
> repeated in all DSA drivers, and even in all MAC drivers. I've already
> posted one patch series which added generic DSA support for LEDs, and
> some basic mv88e6xxx code. It got NACKed by Vladimir. So i'm slowly
> working on making it more generic, so it can be used by any MAC
> driver.
>
> I will try to post it in the next couple of days.

Interesting! I'll keep an eye out for it.

