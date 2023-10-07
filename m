Return-Path: <netdev+bounces-38833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B47BCA6C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 01:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65CC1C209D9
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C2339B8;
	Sat,  7 Oct 2023 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dPKmRGok"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D233990
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:27:08 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66BBA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 16:27:06 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f82ad1e09so42011337b3.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696721225; x=1697326025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDeJryRDX5w6se3Vsm9C02vaZiH8zU+DjcUxg9FotIs=;
        b=dPKmRGokM1HIUebRGBJSIsD0aiP++xodqweDGO4HJMNZvruz3m61B2cqDBBXn2UQZp
         RsefIEB2Zy2mpAIu97CsZOopHyK/1CeIjpScF6V9Z96aeqnCzxHWGRPrwnQOOTWPMlhY
         ugr3y9h99Lib7VJrPtYIcOwxvAZwkebiE7jRvtN9qwUmjdielDIwT5tGoZ/H9MQt5oo9
         zexg7Ddlb0GcBluOCLzqoV+PMFkqK21hvoGnyjvHd8JHrnVV38NKkGeHU43NqYG0tkEN
         ucWxPbAKvN456Wm06glmjxLQPpx8MnGgFmq9nzHsDxQ8PtIihU5lTY2MgzcBMcnCcuGN
         LO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696721225; x=1697326025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDeJryRDX5w6se3Vsm9C02vaZiH8zU+DjcUxg9FotIs=;
        b=tQMte4JEcU0FyVYgNp2y62FC635JntlEHGdNI3RdHwo2pF79Tk8wS7mztF1QaJfmRk
         Gsk7jzA8IP26u9iy8JD/BD944lK1zEdrT70/93R4eElE5orCJaKUlNsQvPq/soQKjBoa
         6FdN+MRK2QuMQcfZeDebjKtX36+3UoJCer0lwOeN0a0c0NqsA1c9wQ1BM+xG7Gkfcu0+
         OFp6kQ8IbQI1tWe4xvgjJ4L2cWspmlgRUOVDryfJE4lnmilxK1vFe10VVd9znkioBJwq
         ZuRiett0O562lmeXP8mog6c0+zsYU7yfhynnEhrN2oLpL6BXKm3eyTYvhN5ugXRmo9KB
         G/0Q==
X-Gm-Message-State: AOJu0YxZfWC6BQi9yyzPXGzKrq3HHB+AJcvaewM2OgRCq2cw2j++kpL+
	XSNryIQWJFUANDGjw733lwWWr2EC0z4JhfEKKYoqBvhQqCLoYEbCyRK+kA==
X-Google-Smtp-Source: AGHT+IGp+2Qks3GnpSuBNsh0KgVH0cCv0sejSyFBwLmdrpGyUpdcyK0d/iMvQJYDTp23NrTCYe0UldR5diyMpcISx8o=
X-Received: by 2002:a81:4e47:0:b0:59f:52a1:254c with SMTP id
 c68-20020a814e47000000b0059f52a1254cmr13578988ywb.19.1696721225620; Sat, 07
 Oct 2023 16:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-2-fujita.tomonori@gmail.com> <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
In-Reply-To: <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 7 Oct 2023 19:26:54 -0400
Message-ID: <CALNs47saY2AaBjp8XEadDfAw1+Su5+aszu_07RB=9X+rTW+_pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 6:59=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> > Can you just add `An instance of a PHY` to the docs for reference?
>
> You meant something like?
>
> /// An instance of a PHY device.
> /// Wraps the kernel's `struct phy_device`.
> ///
> /// # Invariants
> ///
> /// `self.0` is always in a valid state.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);

Seems good to me. I know that largely we want users to refer to the C
docs, but I think a small hint is good.

Fwiw they can be on the same line, Markdown combines them

> >> +impl Device {
> >> +    /// Creates a new [`Device`] instance from a raw pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// For the duration of the lifetime 'a, the pointer must be vali=
d for writing and nobody else
> >> +    /// may read or write to the `phy_device` object.
> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a=
 mut Self {
> >> +        unsafe { &mut *ptr.cast() }
> >> +    }
> >
> > The safety comment here still needs something like
>
> You meant the following?
>
> /// For the duration of the lifetime 'a, the pointer must be valid for wr=
iting and nobody else
> /// may read or write to the `phy_device` object with the exception of fi=
elds that are
> /// synchronized via the `lock` mutex.
>
> What this means? We use Device only when an exclusive access is
> gurannteed by device->lock. As discussed before, resume/suspend are
> called without device->lock locked but still drivers assume an
> exclusive access.

This was in follow up to one of the notes on the RFC patches, I'll
reply more to Andrew's comment about this

>
> >> +    /// Sets the speed of the PHY.
> >> +    pub fn set_speed(&mut self, speed: u32) {
> >> +        let phydev =3D self.0.get();
> >> +        // SAFETY: `phydev` is pointing to a valid object by the type=
 invariant of `Self`.
> >> +        unsafe { (*phydev).speed =3D speed as i32 };
> >> +    }
> >
> > Since we're taking user input, it probably doesn't hurt to do some
> > sort of sanity check rather than casting. Maybe warn once then return
> > the biggest nowrapping value
> >
> >     let speed_i32 =3D i32::try_from(speed).unwrap_or_else(|_| {
> >         warn_once!("excessive speed {speed}");
> >         i32::MAX
> >     })
> >     unsafe { (*phydev).speed =3D speed_i32 };
>
> warn_once() is available? I was thinking about adding it after the PHY
> patchset.
>
> I'll change set_speed to return Result.

Nevermind, I guess we don't have `warn_once`. Andrew mentioned
something about potentially lossy conversions, I'll follow up there.

> >> +    /// Executes software reset the PHY via BMCR_RESET bit.
> >> +    pub fn genphy_soft_reset(&mut self) -> Result {
> >> +        let phydev =3D self.0.get();
> >> +        // SAFETY: `phydev` is pointing to a valid object by the type=
 invariant of `Self`.
> >> +        // So an FFI call with a valid pointer.
> >> +        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
> >> +    }
> >> +
> >> +    /// Initializes the PHY.
> >> +    pub fn init_hw(&mut self) -> Result {
> >> +        let phydev =3D self.0.get();
> >> +        // SAFETY: `phydev` is pointing to a valid object by the type=
 invariant of `Self`.
> >> +        // so an FFI call with a valid pointer.
> >> +        to_result(unsafe { bindings::phy_init_hw(phydev) })
> >> +    }
> >
> > Andrew, are there any restrictions about calling phy_init_hw more than
> > once? Or are there certain things that you are not allowed to do until
> > you call that function?
>
> From quick look, you can call it multiple times.

Thanks, no worries in that case


> > If so, maybe a simple typestate would make sense here
> >
> >> +impl<T: Driver> Adapter<T> {
> >> +    unsafe extern "C" fn soft_reset_callback(
> >> +        phydev: *mut bindings::phy_device,
> >> +    ) -> core::ffi::c_int {
> >> +        from_result(|| {
> >> +            // SAFETY: The C API guarantees that `phydev` is valid wh=
ile this function is running.
> >> +            let dev =3D unsafe { Device::from_raw(phydev) };
> >> +            T::soft_reset(dev)?;
> >> +            Ok(0)
> >> +        })
> >> +    }
> >
> > All of these functions need a `# Safety` doc section, you could
> > probably just say to follow `Device::from_raw`'s rules. And then you
> > can update the comments to say caller guarantees preconditions
> >
> > If you care to, these functions are so similar that you could just use
> > a macro to make your life easier
> >
> >     macro_rules! make_phydev_callback{
> >         ($fn_name:ident, $c_fn_name:ident) =3D> {
> >             /// ....
> >             /// # Safety
> >             /// `phydev` must be valid and registered
> >             unsafe extern "C" fn $fn_name(
> >                 phydev: *mut ::bindings::phy_device
> >             ) -> $ret_ty {
> >                 from_result(|| {
> >                     // SAFETY: Preconditions ensure `phydev` is valid a=
nd
> >                     let dev =3D unsafe { Device::from_raw(phydev) };
> >                     T::$c_fn_name(dev)?;
> >                     Ok(0)
> >                 }
> >             }
> >         }
> >     }
> >
> >     make_phydev_callback!(get_features_callback, get_features);
> >     make_phydev_callback!(suspend_callback, suspend);
>
> Looks nice. I use the following macro.

Miguel mentioned on Zulip that we try to avoid macros (I did not know
this), so I guess it's fine if redundant.

https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/.6=
0bool.3A.3Athen.60.20helper/near/395398830

> >> +/// Declares a kernel module for PHYs drivers.
> >> +///
> >> +/// This creates a static array of `struct phy_driver` and registers =
it.
> >> +/// This also corresponds to the kernel's MODULE_DEVICE_TABLE macro, =
which embeds the information
> >> +/// for module loading into the module binary file.
> >
> > Could you add information about the relationship between drivers and
> > device_table?
>
> device_table needs to have PHY Ids that one of the drivers can handle.
>
> ?

I think something like "Every driver needs an entry in device_table"
is fine, just make it less easy to miss

Thanks for the followup, all of these were very minor

