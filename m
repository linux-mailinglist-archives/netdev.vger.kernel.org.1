Return-Path: <netdev+bounces-186756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31BAA0ED9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DF51BA0BF9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C711B0430;
	Tue, 29 Apr 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aN2e1pw/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2441865EE;
	Tue, 29 Apr 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937126; cv=none; b=YhHJ0nbQ1dmz/gCgoZYC3mutaDKm8NiG4AeeoE9FvrHvP1ezS5kwD+VXmgQ/536tFat/lh6JfGloBF0tIfwURewRkon7CBDqC9JgkgwrmF6q9TMhtHxXWNsG3VXrpZTAS2SeGSGASfWbLJGdPUWAJmL2Lp/MGPIpaIJQLVEmm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937126; c=relaxed/simple;
	bh=kD399aqF42LIK1///+RHRZCER/2fVPehDQOnNruBlM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOHCdIW1LrJs9AaQFmJB9wcRivtsKnQnQHt+0+eZdSQNd0nQ801BhDRJeFKMN54mSsYcjSLsz3+zdy/TcBOIkEULhmJJmMqbd/K894bSU1KInId4q5SndwdvKp5Es1X2xAJjyn5f4XYITGW82TSYdb2OqYWDIvFvRcbNnIPMB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aN2e1pw/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LcwEsbGmESO1HdAFXvEV9nKOQ7rLtvuR5RS0uROUIk8=; b=aN2e1pw/1WY6i8+XXTZ5xB58PW
	TfFd3guNAcyQl0sO5IdfaWRjMiV3ZsoCdZ4JxBN+mHT9Jmondc1tod0CA73cLCvBh60lNiNLgzpK/
	tz6RycKkEJ4JF4DAYebkFZlIa1g1zofM6kyOzCXG+K+wjVJMlDuYjq43BqPvjpQAJtcZl3bjC/OGe
	KNcduUkCZ6k+qSI1rJ84WUwm3hFRGs22Jkg3D6k9J8N82RE9Mj1aCfJDhhC/70+Q+1k4qUL8Y0yeW
	d6hWWyuicwb02RyZ/BYf72y6Kh5ZCTuSQYBI8llRDAvPCyJDvQF+cRePDNZcJz7p+uImFcXpNPBrn
	qRl0/csg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u9m03-0005yG-0F;
	Tue, 29 Apr 2025 15:31:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u9lzv-0006DE-0r;
	Tue, 29 Apr 2025 15:31:47 +0100
Date: Tue, 29 Apr 2025 15:31:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, gary@garyguo.net,
	aliceryhl@google.com, me@kloenk.dev, daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com,
	david.laight.linux@gmail.com, boqun.feng@gmail.com,
	pbonzini@redhat.com, jfalempe@redhat.com, linus.walleij@linaro.org
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Message-ID: <aBDi06bQibCIB4En@shell.armlinux.org.uk>
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <03ccb65b-a5f8-4afc-84f5-e46f1caf96b0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ccb65b-a5f8-4afc-84f5-e46f1caf96b0@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 29, 2025 at 04:16:01PM +0200, Christian Schrefl wrote:
> On 29.04.25 3:17 PM, FUJITA Tomonori wrote:
> > On Mon, 28 Apr 2025 20:16:47 +0200
> > Andreas Hindborg <a.hindborg@kernel.org> wrote:
> > 
> >> Hi Tomonori,
> >>
> >> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> >>
> >>> Add a wrapper for fsleep(), flexible sleep functions in
> >>> include/linux/delay.h which typically deals with hardware delays.
> >>>
> >>> The kernel supports several sleep functions to handle various lengths
> >>> of delay. This adds fsleep(), automatically chooses the best sleep
> >>> method based on a duration.
> >>>
> >>> sleep functions including fsleep() belongs to TIMERS, not
> >>> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> >>> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> >>> side, add rust/kernel/time/delay.rs for this wrapper.
> >>>
> >>> fsleep() can only be used in a nonatomic context. This requirement is
> >>> not checked by these abstractions, but it is intended that klint [1]
> >>> or a similar tool will be used to check it in the future.
> >>
> >> I get an error when building this patch for arm32:
> >>
> >>   + kernel-make -j 96 O=/home/aeh/src/linux-rust/test-build-arm-1.78.0 vmlinux modules
> >>   ld.lld: error: undefined symbol: __aeabi_uldivmod
> >>   >>> referenced by kernel.df165ca450b1fd1-cgu.0
> >>   >>>               rust/kernel.o:(kernel::time::delay::fsleep) in archive vmlinux.a
> >>   >>> did you mean: __aeabi_uidivmod
> >>   >>> defined in: vmlinux.a(arch/arm/lib/lib1funcs.o)
> >>
> >> Looks like a division function of some sort is not defined. Can you
> >> reproduce?
> > 
> > Ah, 64-bit integer division on 32-bit architectures.
> > 
> > I think that the DRM QR driver has the same problem:
> > 
> > https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4rnxxKvx+HvWdBLopZfrQ@mail.gmail.com/
> > 
> > It appears that there is still no consensus on how to resolve it. CC
> > the participants in the above thread.
> 
> From what I remember from the thread is that generally 64 bit divisions
> should be avoided (like the solution for DRM).
> 
> > I think that we can drop this patch and better to focus on Instant and
> > Delta types in this merge window.
> > 
> > With the patch below, this issue could be resolved like the C side,
> > but I'm not sure whether we can reach a consensus quickly.
> 
> I think adding rust bindings for this is fine (and most likely needed),
> for cases where it is required.
> 
> > 
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 48143cdd26b3..c44d45960eb1 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -19,6 +19,7 @@
> >  #include "io.c"
> >  #include "jump_label.c"
> >  #include "kunit.c"
> > +#include "math64.c"
> >  #include "mutex.c"
> >  #include "page.c"
> >  #include "platform.c"
> > diff --git a/rust/helpers/math64.c b/rust/helpers/math64.c
> > new file mode 100644
> > index 000000000000..f94708cf8fcb
> > --- /dev/null
> > +++ b/rust/helpers/math64.c
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/math64.h>
> > +
> > +s64 rust_helper_div64_s64(s64 dividend, s64 divisor)
> > +{
> > +	return div64_s64(dividend, divisor);
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index de07aadd1ff5..d272e0b0b05d 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -60,6 +60,7 @@
> >  #[cfg(CONFIG_KUNIT)]
> >  pub mod kunit;
> >  pub mod list;
> > +pub mod math64;
> >  pub mod miscdevice;
> >  #[cfg(CONFIG_NET)]
> >  pub mod net;
> > diff --git a/rust/kernel/math64.rs b/rust/kernel/math64.rs
> > new file mode 100644
> > index 000000000000..523e47911859
> > --- /dev/null
> > +++ b/rust/kernel/math64.rs
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! 64-bit integer arithmetic helpers.
> > +//!
> > +//! C header: [`include/linux/math64.h`](srctree/include/linux/math64.h)
> > +
> > +/// Divide a signed 64-bit integer by another signed 64-bit integer.
> > +#[inline]
> > +pub fn div64_s64(dividend: i64, divisor: i64) -> i64 {
> > +    // SAFETY: Calling `div64_s64()` is safe as long as `divisor` is non-zero.
> The safety comment is not valid, nowhere is it guaranteed divisor is non-zero.
> 
> There's three solutions I can think of:
> * Mark this function as `unsafe` and give the responsibility of checking
>   this to the caller,
> * return a `Result` with a division by zero error type or
> * change the type of divisor to `NonZeroI64` [0].
> 
> Probably the best way is to use `NonZeroI64` since that way
> it's statically guaranteed.
> 
> In that case it would also make sense to change `NSEC_PER_USEC` to be `NonZeroI64`.
> 
> 
> Link: https://doc.rust-lang.org/nightly/core/num/type.NonZeroI64.html [0]
> > +    unsafe { bindings::div64_s64(dividend, divisor) }
> 
> Is `s64` just a typedef for `int64_t` and if so this true for every
> architecture? (I don't know the C side very well).
> 
> If not there might need to be some kind of conversion to make sure
> they are passed correctly.
> 
> > +}
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index 863385905029..7b5255893929 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -24,6 +24,8 @@
> >  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
> >  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> >  
> > +use crate::math64;
> > +
> >  pub mod delay;
> >  pub mod hrtimer;
> >  
> > @@ -229,13 +231,16 @@ pub const fn as_nanos(self) -> i64 {
> >      /// Return the smallest number of microseconds greater than or equal
> >      /// to the value in the [`Delta`].
> >      #[inline]
> > -    pub const fn as_micros_ceil(self) -> i64 {
> > -        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> > +    pub fn as_micros_ceil(self) -> i64 {
> > +        math64::div64_s64(
> It would make sense to change `NSEC_PER_USEC` to be `NonZeroI64`.
> 
> > +            self.as_nanos().saturating_add(NSEC_PER_USEC - 1),
> > +            NSEC_PER_USEC,
> > +        )
> >      }
> >  
> >      /// Return the number of milliseconds in the [`Delta`].
> >      #[inline]
> > -    pub const fn as_millis(self) -> i64 {
> > -        self.as_nanos() / NSEC_PER_MSEC
> > +    pub fn as_millis(self) -> i64 {
> > +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)

There is no way this should ever be an expensive 64-bit by 64-bit
division. Think about value of the divisor here - there's 1000us
in 1ms, and 1000ns in 1us, so this has the value of 1000000,
which is 20 bits.

So for a 32-bit architecture, trying to do a 64-bit by 64-bit
division is expensive, and 32-bit architectures don't implement
this as a general rule because of this - most times you do not
have a 64-bit divisor, but something much smaller, making a
64-bit by 32-bit division more suitable. That is a lot faster on
32-bit architectures.

So, I think more thought is needed to be put into this by Rust
folk, rather than blindly forcing everything to be 64-bit by
64-bit even when the divisor is 20-bit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

