Return-Path: <netdev+bounces-62404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82012826F4C
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CB61C22604
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185374121D;
	Mon,  8 Jan 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzDTWsu7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99141227
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso20718005e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 05:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704719381; x=1705324181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hYieDiSDTISp3tD8ghlJgiTTJonJ4Ccd7Po1e0qTJkM=;
        b=EzDTWsu7wa4lcmXorCrh79fSKOnUmkeuFiv111L7xfn2rocpoHA7eGPnBV0nYMEeiL
         nkI2GzzDcVzVIICLazJVbmtlKKNj/tTOXps0MGoIYBvDngicfwUUw52yfIbuf9VgF+tv
         En937aqlppBq/aA15mc8l4a87HJGtqCAtGKEXHvHI+dTcW62uK4DZvwYEV2pGbNZ4042
         S9A8KGKsV81afR74e9ohGsG1+MySSxGOhWIKPUCXI0WPdOCuqlSyzFQGhSh+/LDXTU4F
         U9mXaqP6U15TY2gqkGKTIVAy688j42tosokQh8+vJ43X1mV06IYDYLcZlXdXjOjq8g3q
         TQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719381; x=1705324181;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYieDiSDTISp3tD8ghlJgiTTJonJ4Ccd7Po1e0qTJkM=;
        b=wmkpG4tQNGDsS+zrrhRLRFAqoBHX6zcil5BSFexgEGzHHpZo6lqQ0qfbKFhjVhXITl
         AmsOW6xhLb8xKtm7vYqyo3yv+Hp4E5wfPG1bTu2/utXhdo8wIh1H+OidHsTLi2ARPU1v
         wKyPSWKjL1+sh93IzoO3oUmS0Nq+2sZeLKBFWFRi79F1AOKNRodsVg9/TOzUyyRFTls/
         OCw99y3a/I3ItyQCMYx5fKj2eG3ewOcTwbEijZIH9ZKtBI4OaO2xfy5/PW906NAPtj/Z
         i+SxN11VabgX4Gk2r7XB0Z0GrKoKiG1ljj2dCUzm6nlWKRGA1MtrGYB9VqKQZ6YVqr4T
         08bQ==
X-Gm-Message-State: AOJu0YzkqLCCv8fLDNcy4vYOSED48et81TRadzVvHD4EF0Iyqs7S3jCX
	TFn53U+RuzuV5OCe94b6xCU=
X-Google-Smtp-Source: AGHT+IHcOb37qn5c9dwh0MMAOkaPocTfvrPRi7K/CJMPSoXVtIvQ0p77zOt1pV0JHMWfVROpcvpm7g==
X-Received: by 2002:a05:600c:6913:b0:40d:8541:a04f with SMTP id fo19-20020a05600c691300b0040d8541a04fmr1887570wmb.156.1704719381022;
        Mon, 08 Jan 2024 05:09:41 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b0040e490cb666sm1886388wmb.12.2024.01.08.05.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:09:40 -0800 (PST)
Message-ID: <659bf414.050a0220.32376.5383@mx.google.com>
X-Google-Original-Message-ID: <ZZvz9uwNxQFCapfH@Ansuel-xps.>
Date: Mon, 8 Jan 2024 14:09:10 +0100
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
 <659b1106.050a0220.66c7.9f80@mx.google.com>
 <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>

On Mon, Jan 08, 2024 at 02:47:22AM -0300, Luiz Angelo Daros de Luca wrote:
> > > Hi Christian,
> > >
> > > I tried to implement something close to your work with qca8k and LED
> > > hw control. However, I couldn't find a solution that would work with
> > > the existing API. The HW led configuration in realtek switches is
> > > shared with all LEDs in a group. Before activating the hw control, all
> > > LEDs in the same group must share the same netdev trigger config, use
> > > the correct device and also use a compatible netdev trigger settings.
> > > In order to check that, I would need to expose some internal netdev
> > > trigger info that is only available through sysfs (and I believe sysfs
> > > is not suitable to be used from the kernel). Even if I got all LEDs
> > > with the correct settings, I would need to atomicly switch all LEDs to
> > > use the hw control or, at least, I would need to stop all update jobs
> > > because if the OS changes a LED brightness, it might be interpreted as
> > > the OS disabling the hw control:
> > >
> >
> > Saddly we still don't have the concept of LED groups, but from what I
> > notice 99% of the time switch have limitation of HW control but single
> > LED can still be controlled separately.
>
> Individually, I can only turn them on/off. That is enough for software
> control but not for hardware control. When you set a LED group to
> blink on link activity, all LEDs will be affected.
>

Assuming we have the same 2005 datasheet, yes the LED situation is
complex for this switch. (If you have something better please link)

> > With this limitation you can use the is_supported function and some priv
> > struct to enforce and reject unsupported configuration.
> > netdev trigger will then fallback to software in this case. (I assume on
> > real world scenario to have all the LED in the group to be set to the
> > common rule set resulting in is_supported never rejecting it)
> 
> Maybe I wasn't clear enough about what the HW provides me. I have 4
> 16-bit registers:
> 
> REG1: a single blink rate used by all LEDs in all groups
> REG2: configures the trigger for each group, 4-bit each, with one
> special 4-bit value being "fixed", equivalent to "none" in Linux LED
> trigger
> REG3: bitmap to manually control LEDs in group 0 and 1 only when their
> group trigger is configured as fixed.
> REG3: bitmap to manually control LEDs in group 2 and 3 only when their
> group trigger is configured as fixed.
> 
> And that's it.
> 
> I can keep track of the netdev trigger form calls to "is_supported
> function". I can also check if all LEDs are still using the netdev
> trigger. However, I cannot detect if the user changed the device to
> something else not related to the corresponding port as the netdev
> trigger will not check the compatibility if the device does not match.
> I would still need to expose at least some of the netdev trigger
> internal data.
> 

We can make some assumption and use refcount tho. For very exotic
configuration it will always fallback to software (and make hw control
impossible) but for more generic one we can benefit of it.

- We can only enable HW control on the LED group.

This means that for the group we need to make sure that:
1. We have the correct device set to each LED
2. We have an acceptable mode requesterd.

With these 2 prereq, we can correctly enable HW control for the LED
group.

HW control is enable only IF the device netdev currently set match what
hw_control_get_device returns. With this, we can assume for HW control
request the correct netdev is always set.

We also use refcount to check how many LED are actually ""enabled"".
With this count we can understand if we can enable HW control for the
LED group or return false from is_supported.

And with HW control enabled, we would reject all kind of invalid
settings and print a warning to alert the user of the limitation and
maybe how to remove it.

> > Also consider this situation, it's the first LED touched that enables HW
> > control that drive everything. LED configuration are not enabled all at
> > once. You can totally introduce a priv struct that cache the current
> > modes and on the other LEDs make sure the requested mode match the cache
> > one.
> 
> Considering that I can externally check that all LEDs have a netdev
> trigger settings compatible with the HW control, once the last LED is
> configured, I could return true for the hw_control_is_supported. When
> hw_control_set is called, I could configure the hardware accordingly,
> which would affect all LEDs in that group. However, the OS will still
> use the software control for the other LEDs in that same group. That
> way, once a netdev event turns off one LED, that message is the same
> clue the LED driver receives to disable the hardware control. It will
> undo the hardware change I just made. I could use
> led_brightness_set(OFF) on those other LEDs during hw_control_set to
> disable their software controlled triggers (actually changing the
> trigger to "none"), but it might be a race condition of who stops the
> other. And even then, the other LEDs will keep an inconsistent
> configuration state, with "none" as their trigger.
> 
> I need:
> 1) expose the required info or allow an external caller to test a LED
> configuration for compatibility (avoiding recursion).
> 2) something from hw_control_set() that stops the software triggers in
> other LEDs without destroying their configuration.
> 3) something that could enable hw_control on those other LEDs
> 

I think it would be problematic for other LED to do changes. I need to
check how LED multicolor work... In a sense they are LED group so maybe
in LED core we have a way to group LED and share some info with the
others.

> > And I guess this limitation should be printed and documented in DT.
> >
> > > /*
> > > ...
> > > * Deactivate hardware blink control by setting brightness to LED_OFF via
> > > * the brightness_set() callback.
> > > *
> > > ...
> > > */
> > > int (*hw_control_set)(struct led_classdev *led_cdev,
> > >  unsigned long flags);
> > >
> > > Do you have any idea how to implement it?
> > >
> > > BTW, during my tests with a single LED, ignoring the LED group
> > > situation, I noticed that the OS was sending a brightness_set(LED_OFF)
> > > after I changed the trigger to netdev, a moment after hw_control_set
> > > was called. It doesn't make sense to enable hw control just to disable
> > > it afterwards. The call came from set_brightness_delayed(). Maybe it
> > > is because my test device is pretty slow and the previous trigger
> > > event always gets queued. Touching any settings after that worked as
> > > expected without the spurious brightness_set(LED_OFF). Did you see
> > > something like this?
> > >
> >
> > Consider that brightness_set is called whatever a trigger is changed,
> > the logic is in the generic LED handling. Setting OFF and then enabling
> > hw control should not change a thing. In other driver tho I notice an
> > extra measure is needed to reset any HW control rule already applied by
> > default.
> 
> It would be OK to call brightness_set(LED_OFF) if that is guaranteed
> to happen before hw_control_set(). The problem is that the
> brightness_set(LED_OFF) happens *after* hw_control_set() was called.
> It looks like a race condition.
> 

Totally require some further investigation, it seems strange tho that
the your system is that slow.

-- 
	Ansuel

