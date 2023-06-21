Return-Path: <netdev+bounces-12857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CA7392AA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EFC1C20F94
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA31C749;
	Wed, 21 Jun 2023 22:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208C1ACB3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:44:53 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC2F1;
	Wed, 21 Jun 2023 15:44:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso6822466b.1;
        Wed, 21 Jun 2023 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687387487; x=1689979487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiBkzKD4+Su3tr2BJS0cAfgeUNS9/ckaM/WXuVXykKo=;
        b=F1JfcXoU9/9711vo3eLY+RYvMAMEO3Ts+8N3YhMIDgaVCi8o1vEPJWen8CRcpu8WvB
         HoQHb1ArlZcFDYpYtH2cnKIOZ/5giuC5nUsei7NwojuR/Jt0tLchQd6T5y3iltwuqSVa
         qHoCtQn1AUK0Y4w6g+zt8lWhbLiYYb00Paz3emh+K8UKGukNfDKKn5mse+Igw5XTlyWV
         IjAD0r6w0VbSqf5z+WUFPWnhrvyW+ou3UHMnXt93bia2RQRRl7zX1DsbHvG6qvBwl+Z+
         tUhaO1Hx03Uffp1MIQsKyPRtsdiLPLGqv6o8h6+4KcsNwBAT1e59TexS3fDhpiyfeyve
         1SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687387487; x=1689979487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiBkzKD4+Su3tr2BJS0cAfgeUNS9/ckaM/WXuVXykKo=;
        b=dZfUtryDLll4SFsgVMoqA6a7r+LAhcxvzHDboIzAEsD5gjxxnrOACyASAPE5J2BEu1
         aMFDXyzrJ4A5ucu/51C/RdIfpWq66cQ2AcHFQD0MkRY1VT+VA0TWlVVUAU5yVTgd79Wz
         e022TXGKDzg0q40jsGFBvATNZIBhVNJlW/0rFAO91wAY9frJQmPt2VP7TRYGLy7CZJbT
         vjXf6I/eLZ8psXi4V7aB6s7ee6yJx4BP2aMsT26c/WpU3+4Midf5QVSYy/rpjMbELsLi
         T/9JvTaQlVDZ88y/msZmX+Td19GzZwsZ64t4PnutWTkBW8FIYbqlyoGFLe89IQRvpQVg
         Wm8A==
X-Gm-Message-State: AC+VfDxuxuR/qPO6a1QHgMCHdxWTOX/FT+0Ek6vF1Rt2XP3+GUtjDTEu
	c1FSmoRTkoMrQW3UWWKj8ntejitx20A=
X-Google-Smtp-Source: ACHHUZ7BTWbvFLqvMl5gWS+eTIM9S4BsHgcYH42Sjv+qw1ovwJO4QmSiVOUGqa9kNSwFPXIsFDujGA==
X-Received: by 2002:a17:907:7e96:b0:989:21e4:6c6d with SMTP id qb22-20020a1709077e9600b0098921e46c6dmr5461822ejc.28.1687387486715;
        Wed, 21 Jun 2023 15:44:46 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7d647000000b005153b12c9f7sm3178825edr.32.2023.06.21.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:44:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 89B4B27C0054;
	Wed, 21 Jun 2023 18:44:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Jun 2023 18:44:44 -0400
X-ME-Sender: <xms:W32TZLhTkVVJgu-VAZ28lcMEL-qbx42uyPRFXXUl5zbQUSLGt37Jug>
    <xme:W32TZIARrgXmNzgbLfYI4GBoebOoZfhdoX6i795frQzgfgVE6mYmGMa_GMRiK3i6a
    FacO2UX2BUOOiUdAQ>
X-ME-Received: <xmr:W32TZLHLNuhXrvwjtl3WM15khKh9mQ5mzlFwp68Lt2cdZUSfzoZqvI2hTYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:W32TZIQsZaRnL1QXmIc0_evFLTrnHgQtfnqtoyB3zjhUPwGC_cq7-g>
    <xmx:W32TZIxQBqM-ok-N1bO5AIGu_0kMGKzswVswEZu8smQYdxwDWzOhUQ>
    <xmx:W32TZO6vBEDwjmoHmjlYS1Xx49YTPfRv9YKtb71MfaF7DyHbDEL8qQ>
    <xmx:XH2TZHo2AEIm1159L5CW5e9MfSoBU_ZQqG4YdtQydgqlC0DrjM21Fw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 18:44:43 -0400 (EDT)
Date: Wed, 21 Jun 2023 15:44:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	aliceryhl@google.com, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/5] rust: core abstractions for network device drivers
Message-ID: <ZJN9WmRCJU8nN9jE@boqun-archlinux>
References: <20230613045326.3938283-1-fujita.tomonori@gmail.com>
 <20230613045326.3938283-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613045326.3938283-2-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 01:53:22PM +0900, FUJITA Tomonori wrote:
> This patch adds very basic abstractions to implement network device
> drivers, corresponds to the kernel's net_device and net_device_ops
> structs with support for register_netdev/unregister_netdev functions.
> 
> allows the const_maybe_uninit_zeroed feature for
> core::mem::MaybeUinit::<T>::zeroed() in const function.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  16 ++
>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/net.rs              |   5 +
>  rust/kernel/net/dev.rs          | 344 ++++++++++++++++++++++++++++++++
>  5 files changed, 370 insertions(+)
>  create mode 100644 rust/kernel/net.rs
>  create mode 100644 rust/kernel/net/dev.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..468bf606f174 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,8 @@
>   */
>  
>  #include <linux/errname.h>
> +#include <linux/etherdevice.h>
> +#include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..70d50767ff4e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -24,10 +24,26 @@
>  #include <linux/errname.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
>  
> +#ifdef CONFIG_NET
> +void *rust_helper_netdev_priv(const struct net_device *dev)
> +{
> +	return netdev_priv(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_netdev_priv);
> +
> +void rust_helper_skb_tx_timestamp(struct sk_buff *skb)
> +{
> +	skb_tx_timestamp(skb);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_skb_tx_timestamp);
> +#endif
> +
>  __noreturn void rust_helper_BUG(void)
>  {
>  	BUG();
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..fc7d048d359d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -13,6 +13,7 @@
>  
>  #![no_std]
>  #![feature(allocator_api)]
> +#![feature(const_maybe_uninit_zeroed)]
>  #![feature(coerce_unsized)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
> @@ -34,6 +35,8 @@
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> +#[cfg(CONFIG_NET)]
> +pub mod net;
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
> new file mode 100644
> index 000000000000..28fe8f398463
> --- /dev/null
> +++ b/rust/kernel/net.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Networking core.
> +
> +pub mod dev;
> diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
> new file mode 100644
> index 000000000000..d072c81f99ce
> --- /dev/null
> +++ b/rust/kernel/net/dev.rs
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Network device.
> +//!
> +//! C headers: [`include/linux/etherdevice.h`](../../../../include/linux/etherdevice.h),
> +//! [`include/linux/ethtool.h`](../../../../include/linux/ethtool.h),
> +//! [`include/linux/netdevice.h`](../../../../include/linux/netdevice.h),
> +//! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
> +//! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_link.h).
> +
> +use crate::{bindings, error::*, prelude::vtable, types::ForeignOwnable};
> +use {core::ffi::c_void, core::marker::PhantomData};
> +
> +/// Corresponds to the kernel's `struct net_device`.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid.
> +pub struct Device(*mut bindings::net_device);
> +
> +impl Device {
> +    /// Creates a new [`Device`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` must be valid.
> +    unsafe fn from_ptr(ptr: *mut bindings::net_device) -> Self {
> +        // INVARIANT: The safety requirements ensure the invariant.
> +        Self(ptr)
> +    }
> +
> +    /// Gets a pointer to network device private data.
> +    fn priv_data_ptr(&self) -> *const c_void {
> +        // SAFETY: The type invariants guarantee that `self.0` is valid.
> +        // During the initialization of `Registration` instance, the kernel allocates
> +        // contiguous memory for `struct net_device` and a pointer to its private data.
> +        // So it's safe to read an address from the returned address from `netdev_priv()`.
> +        unsafe { core::ptr::read(bindings::netdev_priv(self.0) as *const *const c_void) }
> +    }
> +}
> +
> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
> +// from any thread. `struct net_device` stores a pointer to `DriverData::Data`, which is `Sync`
> +// so it's safe to sharing its pointer.
> +unsafe impl Send for Device {}
> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
> +// from any thread. `struct net_device` stores a pointer to `DriverData::Data`, which is `Sync`,
> +// can be used from any thread too.
> +unsafe impl Sync for Device {}
> +
> +/// Trait for device driver specific information.
> +///
> +/// This data structure is passed to a driver with the operations for `struct net_device`
> +/// like `struct net_device_ops`, `struct ethtool_ops`, `struct rtnl_link_ops`, etc.
> +pub trait DriverData {
> +    /// The object are stored in C object, `struct net_device`.
> +    type Data: ForeignOwnable + Send + Sync;
> +}
> +
> +/// Registration structure for a network device driver.
> +///
> +/// This allocates and owns a `struct net_device` object.
> +/// Once the `net_device` object is registered via `register_netdev` function,
> +/// the kernel calls various functions such as `struct net_device_ops` operations with
> +/// the `net_device` object.
> +///
> +/// A driver must implement `struct net_device_ops` so the trait for it is tied.
> +/// Other operations like `struct ethtool_ops` are optional.
> +pub struct Registration<T: DeviceOperations<D>, D: DriverData> {
> +    dev: Device,
> +    is_registered: bool,
> +    _p: PhantomData<(D, T)>,
> +}
> +
> +impl<D: DriverData, T: DeviceOperations<D>> Drop for Registration<T, D> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that `self.dev.0` is valid.
> +        unsafe {
> +            let _ = D::Data::from_foreign(self.dev.priv_data_ptr());
> +            if self.is_registered {
> +                bindings::unregister_netdev(self.dev.0);
> +            }
> +            bindings::free_netdev(self.dev.0);
> +        }
> +    }
> +}
> +
> +impl<D: DriverData, T: DeviceOperations<D>> Registration<T, D> {
> +    /// Creates a new [`Registration`] instance for ethernet device.
> +    ///
> +    /// A device driver can pass private data.
> +    pub fn try_new_ether(tx_queue_size: u32, rx_queue_size: u32, data: D::Data) -> Result<Self> {
> +        // SAFETY: FFI call.
> +        let ptr = from_err_ptr(unsafe {
> +            bindings::alloc_etherdev_mqs(
> +                core::mem::size_of::<*const c_void>() as i32,
> +                tx_queue_size,
> +                rx_queue_size,
> +            )
> +        })?;
> +
> +        // SAFETY: `ptr` is valid and non-null since `alloc_etherdev_mqs()`
> +        // returned a valid pointer which was null-checked.

Hmm.. neither alloc_etherdev_mqs() nor `from_err_ptr` would do the
null-check IIUC, so you may get a `ptr` whose values is null here.

Regards,
Boqun

> +        let dev = unsafe { Device::from_ptr(ptr) };
> +        // SAFETY: It's safe to write an address to the returned pointer
> +        // from `netdev_priv()` because `alloc_etherdev_mqs()` allocates
> +        // contiguous memory for `struct net_device` and a pointer.
> +        unsafe {
> +            let priv_ptr = bindings::netdev_priv(ptr) as *mut *const c_void;
> +            core::ptr::write(priv_ptr, data.into_foreign());
> +        }
> +        Ok(Registration {
> +            dev,
> +            is_registered: false,
> +            _p: PhantomData,
> +        })
> +    }
> +
[...]

