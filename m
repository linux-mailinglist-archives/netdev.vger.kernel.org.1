Return-Path: <netdev+bounces-62272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2D8265FF
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 22:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075631F213ED
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBEF10A34;
	Sun,  7 Jan 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQAYL61Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938B11703
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e47d749cbso1255385e9.3
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704661255; x=1705266055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=La6TCQuAPFHv7FIJi8hkWmyeLO1Z9EoQ8/Wc2OJnElc=;
        b=fQAYL61YrgazszztJhvTggdNe1k6N0+XFdZb09Yf7INgw/YD8ImKYE6845QvxHDg5J
         1IoV0V8AMInWJVIg7l/7nGJ4++v5MfED7Pe1kB6ZPeuLoUxG15RS8ZGxz+nzPU6jzHSQ
         VIQYQ/dkC8vUq3tsPNlooJ/lP5r2gzG9ymMD4XnjgZpS30Tk5nz5ka31DYOJxxbfKCFA
         4ML2lh9fvYKp0Qh0BZUr22n89vVqHccRK1Zmts38QVMo3hBX2EXhb9qN0l9hEynfs//o
         u3veMl25wvXJFFWEUXvy55db+C/eIXAdxmsbO8LfAqJ8TMn26bEq8VI3sghrhS25gO7K
         KSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704661255; x=1705266055;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La6TCQuAPFHv7FIJi8hkWmyeLO1Z9EoQ8/Wc2OJnElc=;
        b=mFud3YdjswTGhBDthLgMRXCqlkfiKythUNSweDz3r6SJpAIXOSuLkxkwB387Er5FNn
         zbHr7wqCC2b9OMrxJROrXXAA/vEF4AyN/xem7Vv6qKDpRmmOhP5nJGP46iwnHCGLvy2k
         8uGu1i+E+QqGfJ/LyANb8NbzI6ev+mf+Z3rQXblTAreqBLIPnbFWQvWiffHKEDsOhloC
         9Yx0dRRTgH29xt8ti+/foxtClnPVjdBESBzs4RiTHyc5xVbPQ1LwJmhaa2xTbsqTGMDT
         ht3GPUghf0EHJ5ZH+qrXhFwASAT+LcZeheDWHWjanvP/VjLfusgaD+cVFUGr925p7qRF
         ARCg==
X-Gm-Message-State: AOJu0Yy+f1SxSvioOvYVfqqjuVJWGg7sEQruvo7ex9il0rm9GrceWF13
	UJ3qF6cbe9VaBszFeKZbT7g=
X-Google-Smtp-Source: AGHT+IFiE5/vZ9e9s1tZcgv+HxGQ++xWmIwTHIfE23WqBqPC1dZ+oqUZQP7mKe66gvCaoY7WDCbEjw==
X-Received: by 2002:a1c:4c19:0:b0:40d:93ad:c8b9 with SMTP id z25-20020a1c4c19000000b0040d93adc8b9mr1441867wmf.141.1704661254657;
        Sun, 07 Jan 2024 13:00:54 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0040d8d11bd4esm8736845wmq.36.2024.01.07.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 13:00:54 -0800 (PST)
Message-ID: <659b1106.050a0220.66c7.9f80@mx.google.com>
X-Google-Original-Message-ID: <ZZsO1CWWyFn4L6RV@Ansuel-xps.>
Date: Sun, 7 Jan 2024 21:51:32 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for
 rtl8366rb
References: <20240106184651.3665-1-luizluca@gmail.com>
 <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>

On Sat, Jan 06, 2024 at 04:47:10PM -0300, Luiz Angelo Daros de Luca wrote:
> > The rtl8366rb switch family has 4 LED groups, with one LED from each
> > group for each of its 6 ports. LEDs in this family can be controlled
> > manually using a bitmap or triggered by hardware. It's important to note
> > that hardware triggers are configured at the LED group level, meaning
> > all LEDs in the same group share the same hardware triggers settings.
> >
> > The first part of this series involves dropping most of the existing
> > code, as, except for disabling the LEDs, it was not working as expected.
> > If not disabled, the LEDs will retain their default settings after a
> > switch reset, which may be sufficient for many devices.
> >
> > The second part introduces the LED driver to control the switch LEDs
> > from sysfs or device-tree. This driver still allows the LEDs to retain
> > their default settings, but it will shift to the software-based OS LED
> > triggers if any configuration is changed. Subsequently, the LEDs will
> > operate as normal LEDs until the switch undergoes another reset.
> >
> > Netdev LED trigger supports offloading to hardware triggers.
> > Unfortunately, this isn't possible with the current LED API for this
> > switch family. When the hardware trigger is enabled, it applies to all
> > LEDs in the LED group while the LED API decides to offload based on only
> > the state of a single LED. To avoid inconsistency between LEDs,
> > offloading would need to check if all LEDs in the group share the same
> > compatible settings and atomically enable offload for all LEDs.
> 
> Hi Christian,
> 
> I tried to implement something close to your work with qca8k and LED
> hw control. However, I couldn't find a solution that would work with
> the existing API. The HW led configuration in realtek switches is
> shared with all LEDs in a group. Before activating the hw control, all
> LEDs in the same group must share the same netdev trigger config, use
> the correct device and also use a compatible netdev trigger settings.
> In order to check that, I would need to expose some internal netdev
> trigger info that is only available through sysfs (and I believe sysfs
> is not suitable to be used from the kernel). Even if I got all LEDs
> with the correct settings, I would need to atomicly switch all LEDs to
> use the hw control or, at least, I would need to stop all update jobs
> because if the OS changes a LED brightness, it might be interpreted as
> the OS disabling the hw control:
> 

Saddly we still don't have the concept of LED groups, but from what I
notice 99% of the time switch have limitation of HW control but single
LED can still be controlled separately.

With this limitation you can use the is_supported function and some priv
struct to enforce and reject unsupported configuration.
netdev trigger will then fallback to software in this case. (I assume on
real world scenario to have all the LED in the group to be set to the
common rule set resulting in is_supported never rejecting it)

Also consider this situation, it's the first LED touched that enables HW
control that drive everything. LED configuration are not enabled all at
once. You can totally introduce a priv struct that cache the current
modes and on the other LEDs make sure the requested mode match the cache
one.

And I guess this limitation should be printed and documented in DT.

> /*
> ...
> * Deactivate hardware blink control by setting brightness to LED_OFF via
> * the brightness_set() callback.
> *
> ...
> */
> int (*hw_control_set)(struct led_classdev *led_cdev,
>  unsigned long flags);
> 
> Do you have any idea how to implement it?
> 
> BTW, during my tests with a single LED, ignoring the LED group
> situation, I noticed that the OS was sending a brightness_set(LED_OFF)
> after I changed the trigger to netdev, a moment after hw_control_set
> was called. It doesn't make sense to enable hw control just to disable
> it afterwards. The call came from set_brightness_delayed(). Maybe it
> is because my test device is pretty slow and the previous trigger
> event always gets queued. Touching any settings after that worked as
> expected without the spurious brightness_set(LED_OFF). Did you see
> something like this?
>

Consider that brightness_set is called whatever a trigger is changed,
the logic is in the generic LED handling. Setting OFF and then enabling
hw control should not change a thing. In other driver tho I notice an
extra measure is needed to reset any HW control rule already applied by
default.

-- 
	Ansuel

