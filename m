Return-Path: <netdev+bounces-32541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A807983C1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5959D2819AB
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044511C32;
	Fri,  8 Sep 2023 08:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5839187A
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:10:52 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976171BE9
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 01:10:50 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7e87b4a0f2so1646766276.0
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160650; x=1694765450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX8a9RtwGTkNLy+xzOfITbjsoPIkf7czyOLexbXeC30=;
        b=Ta0p6zxQby92DMNhDSTt1AvTBovOoRn8asPZr1gk8V+gWfRAw2lZ8kV6N2h5VheLA9
         JTwBoy+SlBso8p8yiQeZw9m8VIslhXrjcvZ5E2UZym2iFFPZRUZ19C2h6TFQcteH11vf
         tCWseemtS2uDnmZUvC5Xigx02zT3ivXvtqF0lUjngafAifpN9hdj6jNDqYqLTE2gaMBu
         iytiWf5lqdP3in57u48TCk3CgK/d/Em9rG3zXv15NAbtJ7j+4oUTFyWueOaeLjTW0u68
         rBdsg0qwP0Cvh4Mrxlp0yxGPAiscP+VSfYH4+kJmZCpGHS0cI2peLG93YXdqz4+8AHmr
         5rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160650; x=1694765450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX8a9RtwGTkNLy+xzOfITbjsoPIkf7czyOLexbXeC30=;
        b=P+sstHbfxdPaeB1jUzwr9OdcRQMAHI4f6NFWgWGscDfwdAPv5W0sY0/2cY3K23Fnae
         9fyVIMEKRHhOfdt/ee+iXzdiToNMi3jXfLr4ZJr3Kli1vVsLOnJ/pGFDzfTzrlOcOO5d
         T99jQqZfSC5nmQA5LyrZZ5kMHtEUJRs6XBS5EmhtLGIfNrtcUOH2N8K2oe/dgHVfkc+p
         UyEX0gkacZwtEm4dxdN9fKYPKBESGS6z2SSc4IfKYe4zubHbQMCsU0TUWvtOtutk1CNp
         SVO9tKzIU7nZ4ccSLvB+oueV0Ns/1YrvnVuDK752PYtAo/9EeFhDPgh4wxGXo+TtvYRj
         bqLQ==
X-Gm-Message-State: AOJu0YwCbLfB1F+Smz/2FktrGQhzGihOw4Gn5WT9ZzJpSj/JqCPISw9W
	SGWpC+BU0j4qR3eCDVY4B1VKKnJ0imGA497NA98dHQ==
X-Google-Smtp-Source: AGHT+IEIhWm+dbLokHs4WzlKU9nNAycGL1sYfhy4ej/rUnehmE6v6eMqoNyWh18rq8tDXFFLvVdbX78B2EnbokZq5wM=
X-Received: by 2002:a5b:c4d:0:b0:d80:14ed:d294 with SMTP id
 d13-20020a5b0c4d000000b00d8014edd294mr1579706ybr.36.1694160649746; Fri, 08
 Sep 2023 01:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
In-Reply-To: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Sep 2023 10:10:37 +0200
Message-ID: <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openwrt-devel@lists.openwrt.org, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rafal,

On Mon, Sep 4, 2023 at 10:34=E2=80=AFAM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:

> I'm clueless at this point.
> Maybe someone can come up with an idea of actual issue & ideally a
> solution.

Damn this is frustrating.

> 2. Clock (arm,armv7-timer)
>
> While comparing main clock in Broadcom's SDK with upstream one I noticed
> a tiny difference: mask value. I don't know it it makes any sense but
> switching from CLOCKSOURCE_MASK(56) to CLOCKSOURCE_MASK(64) in
> arm_arch_timer.c (to match SDK) increases average uptime (time before a
> hang/lockup happens) from 4 minutes to 36 minutes.

This could be related to how often the system goes to idle.

> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 5678)
> +               arch_cpu_idle();
> +       if (cpu_idle_force_poll =3D=3D 1234)
> +               arch_cpu_idle();

Idle again.

I would have tried to see what arch_cpu_idle() is doing.

arm_pm_idle() or cpu_do_idle()?

What happens if you just put return in arch_cpu_idle()
so it does nothing?

Yours,
Linus Walleij

