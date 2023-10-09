Return-Path: <netdev+bounces-39079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845607BDCF3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3794A2814F3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4F1803A;
	Mon,  9 Oct 2023 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKLPnSSx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166211C8F;
	Mon,  9 Oct 2023 12:59:33 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A628F;
	Mon,  9 Oct 2023 05:59:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a24b03e22eso54701307b3.0;
        Mon, 09 Oct 2023 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696856371; x=1697461171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bl99KSZcP/27MEvX7HscmzAqUVMI6/bOdAU0krO6ho=;
        b=KKLPnSSxOuBZM8K55VUBX3HK0zzaNvctPUsEVdosC9tbdNQ/URauRM/3Ky0JcMgh4+
         pPnefERvZYE/RLWJlKEFOk4TWOFjL7QIAvsAdV4UZN3qhkGLrd61ekg0ajZZGlLCR6os
         rVN9SnQc9VTZKqusJiw6yk/0jBaud5Btn982XdusbjFujJ1PYMa8YcZ2bLsRmbvEs5JR
         17r6FS+h6n5yjWI1liAdRP8CQK+kPcsHbi+4v3LqAtNZGNipL78ZDeXsYzMrgDFETZq8
         9xqEYkUucXZjoSKqIjDyBoG8ICVA9NOK3HaCrI9KwG/k1cOfRC8vbgno5vdb55dr8h13
         U96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856371; x=1697461171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bl99KSZcP/27MEvX7HscmzAqUVMI6/bOdAU0krO6ho=;
        b=wX6Xo0IlbdUxNMiDpSiR/rg38foQ9LIotRUshR0jujWvRpHvcAmtsb2sqDdm/qHMcK
         w23sIo8m+lEmvfkYjF5/Oe5paM3JrkBhcmT5ivyAZAedphUA33bQpBCmXN1TEAskSP01
         8Sm87rLFHFrT85x+2JkLQp2giXLW3PX3xMX14MhGk2Fi24L55/f1R/IeQzuRBCVneHdw
         LljxFf3eMrY1U5L1Idvo2whBGe/8ziZte5nu95smoqtJ8jFUbVcWigmz2RIhmK0E2rh2
         QfSDYR9N9MSLKUOg7rp5QxfEQm1BRMHJ/L1Q9IIoLZi1V463Cw1lCYUen78/9iDJHHBM
         IW5Q==
X-Gm-Message-State: AOJu0YzLrRwnF2d3WNnvrJHNb+cqCeS8uoO1RfJl+UvrVFBrSLHitE8V
	bkey3p3uBa7Jiab51xcQtDFHD/wItJQ8+66SGjgBJIy71Bxs8OqU
X-Google-Smtp-Source: AGHT+IEKCUPwPknGInIBeXg1s/cpwSP57kZF+tlo6eDk8DDZeA7HDjdHtUwt+Ah2ho3c0lme0Mj4/X/aSD3+XM9gprM=
X-Received: by 2002:a81:7309:0:b0:59b:2458:f608 with SMTP id
 o9-20020a817309000000b0059b2458f608mr16316028ywc.30.1696856370794; Mon, 09
 Oct 2023 05:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-2-fujita.tomonori@gmail.com>
In-Reply-To: <20231009013912.4048593-2-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 14:59:19 +0200
Message-ID: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	greg@kroah.com, tmgross@umich.edu, Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Tomonori,

A few nits I noticed. Please note that this is not really a full
review, and that I recommend that other people like Wedson should take
a look again and OK these abstractions before this is merged.

On Mon, Oct 9, 2023 at 3:41=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +config RUST_PHYLIB_BINDINGS

This should be called ABSTRACTIONS. Please see:

    https://docs.kernel.org/rust/general-information.html#abstractions-vs-b=
indings

Also, could this symbol go elsewhere?

> +        bool "PHYLIB bindings support"

Ditto.

> +          a wrapper around the C phlib core.

Typo.

> +               --rustified-enum phy_state\

As I said elsewhere, we should avoid `--rustified-enum` due tot he
risk of UB unless we are explicit on the assumptions we are placing on
the C side.

> +#![feature(const_maybe_uninit_zeroed)]

The patch message should justify this addition and warn about it.

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> new file mode 100644
> index 000000000000..f31983bf0460
> --- /dev/null
> +++ b/rust/kernel/net/phy.rs
> @@ -0,0 +1,733 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>

Newline missing.

> +    /// Full-duplex mode

Please use the style of the rest of the Rust comments.

> +/// An instance of a PHY device.
> +/// Wraps the kernel's `struct phy_device`.

That should be separated.

> +    /// For the duration of the lifetime 'a, the pointer must be valid f=
or writing and nobody else

Missing Markdown around the lifetime.

> +        // FIXME: enum-cast

Please explain what needs to be fixed.

> +    /// Executes software reset the PHY via BMCR_RESET bit.

Markdown missing (multiple instances).

> +    /// Reads Link partner ability.

Why is "link" capitalized here?

> +/// Creates the kernel's `phy_driver` instance.
> +///
> +/// This is used by [`module_phy_driver`] macro to create a static array=
 of phy_driver`.

Broken formatting? Does `rustdoc` complain about it?

> +/// The `drivers` points to an array of `struct phy_driver`, which is
> +/// registered to the kernel via `phy_drivers_register`.

Perhaps "The `drivers` field"?

> +            // SAFETY: The type invariants guarantee that self.drivers i=
s valid.

Markdown.

> +/// Represents the kernel's `struct mdio_device_id`.
> +pub struct DeviceId {
> +    /// Corresponds to `phy_id` in `struct mdio_device_id`.
> +    pub id: u32,
> +    mask: DeviceMask,
> +}

It would be nice to explain why the field is `pub`.

> +    /// Get a mask as u32.

Markdown.

This patch could be split a bit too, but that is up to the maintainers.

> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of `struct phy_driver` and registers it.

"kernel's" or similar

> +/// This also corresponds to the kernel's MODULE_DEVICE_TABLE macro, whi=
ch embeds the information

Markdown.

> +/// for module loading into the module binary file. Every driver needs a=
n entry in device_table.

Markdown.

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
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +/// ```

Please add an example above with the expansion of the macro so that it
is easy to understand at a glance, see e.g. what Benno did in
`pin-init` (`rust/init*`).

Also, perhaps splitting the patches into a few would help.

Cheers,
Miguel

