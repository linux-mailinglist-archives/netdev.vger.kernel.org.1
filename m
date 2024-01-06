Return-Path: <netdev+bounces-62187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C74826156
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4071C20D9D
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3BE57C;
	Sat,  6 Jan 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6pxIIgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104FE575
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso6957641fa.3
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704570442; x=1705175242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6NiqlUUgRemmGK0dSNYM3Wpnvvf9r0lgF3FPlIZfFYo=;
        b=h6pxIIgzQtBHrWkO7uZfDdBOH2Di2yeA3T8dtcpuTEunVkDRfi0N1sgVqGnQz8mFSu
         mNzqk9Om9HKVH4egcp69EbDP2OiliGGbAp0DCfBd9UbbSA6zZjYUfyFXnoV8wCU2Jieu
         bDCnlH12Hg9dcWjCNuvvY2LiMjOduSuwgmaltUIjrSGnRe5MIv37U2qE1hIXz4NI9OYv
         96p3C8LZVd7TRAjIXZ5jNoonVwhWIGpfPEMX0yvvFbQJqi3eHeNhbxXvRqvAzbgnJRtt
         kIlbs6bMFG+slmc70oTfhMnJ0iKM0Da4tVUop8sXL62awGCytbDIZ9A/ZIFCn7A95ApK
         zPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704570442; x=1705175242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NiqlUUgRemmGK0dSNYM3Wpnvvf9r0lgF3FPlIZfFYo=;
        b=qDgL76T0+GUSEphu9TFKJXcEaKoiph9f4lGRNuEKwY4wh8aS2ujw0KT3TvI9Rgwdvt
         K6FfQ2HEG3HCIRb5ppR4Vikl/8XxbpqKKGHfUN3CYeuv0kOPAJuccJD/fvBGnHTh3o7k
         UeXCh+3kWb+UA1fCQaYZLvy9MIY9atW+TFD6ugoq6n7hY+HjBb4gWWC2R84fN6ARHjMp
         aEcj2ol/ymxkuM2oFW66udXXF3/SNEW+3QnKok83BcLp7ksR1c6eA6eqeLXM2+FBTKT4
         tcZMmufFf46oo21PFdFkuaRNTs7CYoXIpW7t2qUZVxHr9gxsN5AIqLZI/VaavaWYUJn8
         VZ9Q==
X-Gm-Message-State: AOJu0Yw+meU3MDWpzrHwji1T8AkC+hQDvZ0MxEozW7K99MzXid4mncBz
	+WD8tsSt/TNxJOTQHKZfQqY1iLUvkWvQ841cm44=
X-Google-Smtp-Source: AGHT+IFuVfX/aOLB2chEpmzeM3DYRw+ioE9YJL7Unb+EMQIMbpkjfZZUJtmaCiEDjFPScmzFSKwEY4Nh5Td8VgGYS/U=
X-Received: by 2002:a05:651c:407:b0:2cc:9cf1:aec2 with SMTP id
 7-20020a05651c040700b002cc9cf1aec2mr497226lja.24.1704570441562; Sat, 06 Jan
 2024 11:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com>
In-Reply-To: <20240106184651.3665-1-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 6 Jan 2024 16:47:10 -0300
Message-ID: <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: ansuelsmth@gmail.com
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The rtl8366rb switch family has 4 LED groups, with one LED from each
> group for each of its 6 ports. LEDs in this family can be controlled
> manually using a bitmap or triggered by hardware. It's important to note
> that hardware triggers are configured at the LED group level, meaning
> all LEDs in the same group share the same hardware triggers settings.
>
> The first part of this series involves dropping most of the existing
> code, as, except for disabling the LEDs, it was not working as expected.
> If not disabled, the LEDs will retain their default settings after a
> switch reset, which may be sufficient for many devices.
>
> The second part introduces the LED driver to control the switch LEDs
> from sysfs or device-tree. This driver still allows the LEDs to retain
> their default settings, but it will shift to the software-based OS LED
> triggers if any configuration is changed. Subsequently, the LEDs will
> operate as normal LEDs until the switch undergoes another reset.
>
> Netdev LED trigger supports offloading to hardware triggers.
> Unfortunately, this isn't possible with the current LED API for this
> switch family. When the hardware trigger is enabled, it applies to all
> LEDs in the LED group while the LED API decides to offload based on only
> the state of a single LED. To avoid inconsistency between LEDs,
> offloading would need to check if all LEDs in the group share the same
> compatible settings and atomically enable offload for all LEDs.

Hi Christian,

I tried to implement something close to your work with qca8k and LED
hw control. However, I couldn't find a solution that would work with
the existing API. The HW led configuration in realtek switches is
shared with all LEDs in a group. Before activating the hw control, all
LEDs in the same group must share the same netdev trigger config, use
the correct device and also use a compatible netdev trigger settings.
In order to check that, I would need to expose some internal netdev
trigger info that is only available through sysfs (and I believe sysfs
is not suitable to be used from the kernel). Even if I got all LEDs
with the correct settings, I would need to atomicly switch all LEDs to
use the hw control or, at least, I would need to stop all update jobs
because if the OS changes a LED brightness, it might be interpreted as
the OS disabling the hw control:

/*
...
* Deactivate hardware blink control by setting brightness to LED_OFF via
* the brightness_set() callback.
*
...
*/
int (*hw_control_set)(struct led_classdev *led_cdev,
 unsigned long flags);

Do you have any idea how to implement it?

BTW, during my tests with a single LED, ignoring the LED group
situation, I noticed that the OS was sending a brightness_set(LED_OFF)
after I changed the trigger to netdev, a moment after hw_control_set
was called. It doesn't make sense to enable hw control just to disable
it afterwards. The call came from set_brightness_delayed(). Maybe it
is because my test device is pretty slow and the previous trigger
event always gets queued. Touching any settings after that worked as
expected without the spurious brightness_set(LED_OFF). Did you see
something like this?

Regards,

Luiz

