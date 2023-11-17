Return-Path: <netdev+bounces-48602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A937EEED2
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D072CB20BA0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4915E99;
	Fri, 17 Nov 2023 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaFKD1dK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5470DC4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cf717bacso28575257b3.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700213948; x=1700818748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpT542f+phIKyvAyToXvA4pst7LsQBljei9NjXJWFY4=;
        b=RaFKD1dKmGWQ4gvltIBoLO8I2u3AfoO4/OK2I3pAl0Ig3QKD71PCH0iDvmPvqosr9m
         3Ec9srMthwSdKAQirKmuzM8kHKvVr/2NgvFUcD0rzPA6bMWnd/V0+AzqjZ+xydB2FoJ6
         QU/mm+MZ0rwhBFiOUqSF62Gx+AB2APIAA8xwuNKF8cyG79QEEBV9UkDE5iG4OvSVq9dP
         UnL/I6AVHk3fuoOF0m1Nhbd4/g1l8rJL6CgOXYFW94kI6wLr3daPwIVAeFhGhjQVBjMX
         x/gDPCAbodOcuSlALwHYeQVm2ht9+K0VRj8NfxMJyXKlvKokMmurooFCmVm4oAt8dN7A
         eIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213948; x=1700818748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpT542f+phIKyvAyToXvA4pst7LsQBljei9NjXJWFY4=;
        b=gYEOHf4uUBLTWDH42OoyktCLEMz7/qJo1CD7uB61YJxvCtzEG4c3wi/cyc76mELoNp
         OpxC4RgEcExRcwCQs0I9Y8OT+z4D0i4EzyPG5lN2j8mNmJXN06UCWpxwF4WKiatBec55
         3omAXQubyW6akwsc/z9EDukCzqvzGUxoBXGuz0dPOidXRrBypstnL0oDKhfdKGs/7I5g
         +HNLJc0EfBLrxUYHU+F8JOaXD9TiXF5Ld33MKfz7h3Swcgx32LkJQnUf6DPHcDmL+EJD
         5qLCEnvMqhSA7yP6gHkVxc7+sNRfvYW4wnFNEB6AtD4BR/Nh1DYZD+TbfPMorxU9szqc
         BKSw==
X-Gm-Message-State: AOJu0YwSdBHQyRMebfiblZdNxuxu3dxb3aGeKdX1kNtJQT0aQNdjU74h
	1poBSwq3Y7i+iN3YQLnaq2dFBMudLjHg0hE=
X-Google-Smtp-Source: AGHT+IEYCWqXA585PlgRjcGto1ItBPj05lx45i7zVzrdwWlxdE91oadnFJjcOak+GdItx5loAACpojtArUUFVMo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:182:b0:d9a:ec95:9687 with SMTP
 id t2-20020a056902018200b00d9aec959687mr460275ybh.11.1700213948536; Fri, 17
 Nov 2023 01:39:08 -0800 (PST)
Date: Fri, 17 Nov 2023 09:39:05 +0000
In-Reply-To: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117093906.2514808-1-aliceryhl@google.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
From: Alice Ryhl <aliceryhl@google.com>
To: fujita.tomonori@gmail.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
> 
> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
> 
> This patch enables unstable const_maybe_uninit_zeroed feature for
> kernel crate to enable unsafe code to handle a constant value with
> uninitialized data. With the feature, the abstractions can initialize
> a phy_driver structure with zero easily; instead of initializing all
> the members by hand. It's supposed to be stable in the not so distant
> future.
> 
> Link: https://github.com/rust-lang/rust/pull/116218
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

In this reply, I go through my minor nits:

> +use crate::{
> +    prelude::{vtable, Pin},
> +};

Normally, if you're importing specific prelude items by name instead of
using prelude::*, then you would import them using their non-prelude
path.

> +#[derive(PartialEq)]
> +pub enum DeviceState {

If you add PartialEq and you can add Eq, then also add Eq.

> +/// An adapter for the registration of a PHY driver.
> +struct Adapter<T: Driver> {
> +    _p: PhantomData<T>,
> +}

You don't need this struct. The methods can be top-level functions.

But I know that others have used the same style of defining a useless
struct, so it's fine with me.

> +    /// Defines certain other features this PHY supports.
> +    /// It is a combination of the flags in the [`flags`] module.
> +    const FLAGS: u32 = 0;

You need an empty line between the two lines if you intend for them to
be separate lines in rendered documentation.

> +#[vtable]
> +pub trait Driver {
> +    /// Issues a PHY software reset.
> +    fn soft_reset(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
>      [...]
> +}

I believe that the guidance for what to put in optional vtable-trait
methods was changed in:

https://lore.kernel.org/all/20231026201855.1497680-1-benno.lossin@proton.me/

> +// SAFETY: `Registration` does not expose any of its state across threads.
> +unsafe impl Send for Registration {}

I would change this to "it's okay to call phy_drivers_unregister from a
different thread than the one in which phy_drivers_register was called".

> +// SAFETY: `Registration` does not expose any of its state across threads.
> +unsafe impl Sync for Registration {}

Here, you can say "Registration has no &self methods, so immutable
references to it are useless".

> +    // macro use only
> +    #[doc(hidden)]
> +    pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
> +        bindings::mdio_device_id {
> +            phy_id: self.id,
> +            phy_id_mask: self.mask.as_int(),
> +        }
> +    }

This is fine, but I probably would just expose it for everyone. It's not
like it hurts if non-macro code can call this method, even if it doesn't
have a reason to do so.

Alice

