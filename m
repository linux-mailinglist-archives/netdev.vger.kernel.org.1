Return-Path: <netdev+bounces-38735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDD7BC4C2
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 07:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CC22821AF
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435115394;
	Sat,  7 Oct 2023 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="sgCMYs8s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B839D
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 05:06:19 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131ABF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:06:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a1f00b75aaso33120567b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696655176; x=1697259976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJFbEA2LhcSHF5iy6HPEiwc3v3rv9bj6ovpPK8v+1BM=;
        b=sgCMYs8sLVTTAfSSi+liNzMLlPUpyzdD+Z6962FoGJVulniTz5unr9uYMYQe/wrjf5
         EpvlscIIE+oqqfVU3gHwyeqYTDSgCWT18HqPRRi72NtBrbazSTYdx3/0g6BXZnK3P78O
         3FTCTE/Z8+vmKt6FsHzuT/4xSjCGBB3wfnm8fqT/gPLATC1IJQxUmUJBxabKtBkhyzAR
         aWvmgznMzbza2/XKgmSXBnab02YHDyR3heTPeKOyr716XDKQd1EDStp0lCrTHUdv2wlj
         3CKVMVnUVOHhs0sX11wj0gI9I1YzppoBqj4hYdqArTDba7iZ9rUqLDH6N1+ucv/I3EFE
         ewnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696655176; x=1697259976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJFbEA2LhcSHF5iy6HPEiwc3v3rv9bj6ovpPK8v+1BM=;
        b=XQIn3X1mvLPq7RvMifYZ5cYN0QtwCfrNaRpeEaWFq2x2IuFCoDHyTiYHqUCYUakPod
         Re+ZGasHN/KPFf50fl/jrTUprLggHHiacW3M6BwyzYn7DpywzUhUtPFsqelyeORCCQ6+
         COwAX4luskIldqduL/GqRznd/r0wmpb+pZ2mdodCUEwGteeNAnVSA0hICQ5quJ8JzrEb
         7vui2Av3bzcmgVeEHRi+ew32mvaqnt7T75Hdr/Adpw2XDyXP+cksYInZ7oNjQkaoQVot
         r5/lRczRLsBbu8ixj/crYqJpk+RVIXpbWQCcnvYE1GiPVKFr4oKSy7h72FRAxCZwUTXF
         lrzA==
X-Gm-Message-State: AOJu0YzFfWaAS6tZZuV1Bk3bHId1zjG5uaI0NjwRfhJshmFz9keEuLvc
	SNfumvqKuzjA5NNK1qEtbKXn6pwt3JA7CVkMuzPFjA==
X-Google-Smtp-Source: AGHT+IG/173MdRuZwr7/Aa2FuA5ysUdImNnIIsBZ0FTeQu6e2SR+P33Lef8ddV2i/F62oEoQgGL7PdP5ftzHPR9eKEM=
X-Received: by 2002:a81:7242:0:b0:589:e4aa:7b67 with SMTP id
 n63-20020a817242000000b00589e4aa7b67mr10706719ywc.41.1696655175981; Fri, 06
 Oct 2023 22:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com> <20231006094911.3305152-2-fujita.tomonori@gmail.com>
In-Reply-To: <20231006094911.3305152-2-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 7 Oct 2023 01:06:04 -0400
Message-ID: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 5:49=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> +/// Wraps the kernel's `struct phy_device`.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always in a valid state.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::phy_device>);

Can you just add `An instance of a PHY` to the docs for reference?

> +impl Device {
> +    /// Creates a new [`Device`] instance from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For the duration of the lifetime 'a, the pointer must be valid f=
or writing and nobody else
> +    /// may read or write to the `phy_device` object.
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mu=
t Self {
> +        unsafe { &mut *ptr.cast() }
> +    }

The safety comment here still needs something like

    with the exception of fields that are synchronized via the `lock` mutex

> +    /// Gets the id of the PHY.
> +    pub fn phy_id(&mut self) -> u32 {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }
> +
> +    /// Gets the state of the PHY.
> +    pub fn state(&mut self) -> DeviceState {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let state =3D unsafe { (*phydev).state };
> +        match state {
> +            bindings::phy_state::PHY_DOWN =3D> DeviceState::Down,
> +            bindings::phy_state::PHY_READY =3D> DeviceState::Ready,
> +            bindings::phy_state::PHY_HALTED =3D> DeviceState::Halted,
> +            bindings::phy_state::PHY_ERROR =3D> DeviceState::Error,
> +            bindings::phy_state::PHY_UP =3D> DeviceState::Up,
> +            bindings::phy_state::PHY_RUNNING =3D> DeviceState::Running,
> +            bindings::phy_state::PHY_NOLINK =3D> DeviceState::NoLink,
> +            bindings::phy_state::PHY_CABLETEST =3D> DeviceState::CableTe=
st,
> +        }
> +    }

Could you add a comment like `// FIXME:enum-cast` or something? Then
when we have a better solution for enums handling we can revise this.

> +    /// Sets the speed of the PHY.
> +    pub fn set_speed(&mut self, speed: u32) {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).speed =3D speed as i32 };
> +    }

Since we're taking user input, it probably doesn't hurt to do some
sort of sanity check rather than casting. Maybe warn once then return
the biggest nowrapping value

    let speed_i32 =3D i32::try_from(speed).unwrap_or_else(|_| {
        warn_once!("excessive speed {speed}");
        i32::MAX
    })
    unsafe { (*phydev).speed =3D speed_i32 };

> +    /// Executes software reset the PHY via BMCR_RESET bit.
> +    pub fn genphy_soft_reset(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
> +    }
> +
> +    /// Initializes the PHY.
> +    pub fn init_hw(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // so an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::phy_init_hw(phydev) })
> +    }

Andrew, are there any restrictions about calling phy_init_hw more than
once? Or are there certain things that you are not allowed to do until
you call that function?

If so, maybe a simple typestate would make sense here

> +impl<T: Driver> Adapter<T> {
> +    unsafe extern "C" fn soft_reset_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `phydev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::soft_reset(dev)?;
> +            Ok(0)
> +        })
> +    }

All of these functions need a `# Safety` doc section, you could
probably just say to follow `Device::from_raw`'s rules. And then you
can update the comments to say caller guarantees preconditions

If you care to, these functions are so similar that you could just use
a macro to make your life easier

    macro_rules! make_phydev_callback{
        ($fn_name:ident, $c_fn_name:ident) =3D> {
            /// ....
            /// # Safety
            /// `phydev` must be valid and registered
            unsafe extern "C" fn $fn_name(
                phydev: *mut ::bindings::phy_device
            ) -> $ret_ty {
                from_result(|| {
                    // SAFETY: Preconditions ensure `phydev` is valid and
                    let dev =3D unsafe { Device::from_raw(phydev) };
                    T::$c_fn_name(dev)?;
                    Ok(0)
                }
            }
        }
    }

    make_phydev_callback!(get_features_callback, get_features);
    make_phydev_callback!(suspend_callback, suspend);

> +    unsafe extern "C" fn read_mmd_callback(
> +        phydev: *mut bindings::phy_device,
> +        devnum: i32,
> +        regnum: u16,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `phydev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            let ret =3D T::read_mmd(dev, devnum as u8, regnum)?;
> +            Ok(ret.into())
> +        })
> +    }

Since your're reading a bus, it probably doesn't hurt to do a quick
check when converting

    let devnum_u8 =3D u8::try_from(devnum).(|_| {
        warn_once!("devnum {devnum} exceeds u8 limits");
        code::EINVAL
    })?
    // ...


> +    unsafe extern "C" fn write_mmd_callback(
> +        phydev: *mut bindings::phy_device,
> +        devnum: i32,
> +        regnum: u16,
> +        val: u16,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `phydev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::write_mmd(dev, devnum as u8, regnum, val)?;
> +            Ok(0)
> +        })
> +    }

Same as above with the conversion errors


> +/// Creates the kernel's `phy_driver` instance.
> +///
> +/// This is used by [`module_phy_driver`] macro to create a static array=
 of phy_driver`.
> +pub const fn create_phy_driver<T: Driver>() -> Opaque<bindings::phy_driv=
er> {
> +    Opaque::new(bindings::phy_driver {
> +        name: T::NAME.as_char_ptr() as *mut i8,

`.cast_mut()`, just makes the mutability change more clear

I guess the C side could technically be `const char *name`

> +        // SAFETY: The rest is zeroed out to initialize `struct phy_driv=
er`,
> +        // sets `Option<&F>` to be `None`.
> +        ..unsafe { core::mem::MaybeUninit::<bindings::phy_driver>::zeroe=
d().assume_init() }
> +    })
> +}

Btw I double checked and this should be OK to use, hopefully will be
stable in the near future
https://github.com/rust-lang/rust/pull/116218

> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of `struct phy_driver` and registers it.
> +/// This also corresponds to the kernel's MODULE_DEVICE_TABLE macro, whi=
ch embeds the information
> +/// for module loading into the module binary file.

Could you add information about the relationship between drivers and
device_table?

> +/// # Examples
> +///
> +/// ```ignore
> +///
> +/// use kernel::net::phy::{self, DeviceId, Driver};
> +/// use kernel::prelude::*;
> +///
> +/// kernel::module_phy_driver! {
> +///     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
> +///     device_table: [
> +///         DeviceId::new_with_driver::<PhyAX88772A>(),
> +///         DeviceId::new_with_driver::<PhyAX88772C>(),
> +///         DeviceId::new_with_driver::<PhyAX88796B>()
> +///     ],
> +///     type: RustAsixPhy,
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +/// ```

I can't find the discussion we had about this, but you said you have
the `type` parameter to be consistent with `module!`, correct?

I think that it is more important to be consistent with C's
`MODULE_PHY_DRIVER` where you don't need to specify anything extra,
since the module doesn't do anything else. And I think it is less
confusing for users if they don't wonder why they need to define a
type they never use.

Why not just remove the field and create an internal type based on
`name` for now? We can always make it an optional field later on if it
turns out there is a use case.

- Trevor

