Return-Path: <netdev+bounces-39072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5417BDC7B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266472814CF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424611CAD;
	Mon,  9 Oct 2023 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="StNfl7JW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033DFC06
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:42:26 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD494
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1696855340; x=1697114540;
	bh=N1m4LUydQPPpDCKC3oEdLhtybClqDZZWDHdecorqAXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=StNfl7JWO4A7v7bLsoQffwUbfyKZ4OC67zXWWYnaFSeah6eXwLITNQgqE+rc1nWG3
	 34w0cYGN60al0hOZj04RBVM/6jj5NLaPvHZXEOJVeSh4r2Qb/aUINfc/7sVM0oJf3W
	 X6MYD8XbSRVuh2yzA7gbv8UDfYnnJr6dAamHayuABd5kKUQRSNSHD8/CO+cwotPWXd
	 p3TZ6adAxUCmGjqZeXvKAOCKULiFdwkA1hxvSGRHGbbQEQ7XRRYBmEWDuaLoOseSpe
	 O//vWpWRagEYCEW/o7okuESFkVhAxhSD0TZD+0JVwiATtQgnrsA/MuLAwWFtiCtJ5L
	 4yoDKl4g4IvxQ==
Date: Mon, 09 Oct 2023 12:42:15 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <3dafc9f4-f371-a3d8-1d11-1b452b1c227e@proton.me>
In-Reply-To: <20231009013912.4048593-4-fujita.tomonori@gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-4-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09.10.23 03:39, FUJITA Tomonori wrote:
> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust versionon kernel
> configuration.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

One small nit below, you can decide what to do with that.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

>   drivers/net/phy/Kconfig          |   7 ++
>   drivers/net/phy/Makefile         |   6 +-
>   drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
>   rust/uapi/uapi_helper.h          |   2 +
>   4 files changed, 143 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/phy/ax88796b_rust.rs
>=20
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 421d2b62918f..0317be180ac2 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -107,6 +107,13 @@ config AX88796B_PHY
>   =09  Currently supports the Asix Electronics PHY found in the X-Surf 10=
0
>   =09  AX88796B package.
>=20
> +config AX88796B_RUST_PHY
> +=09bool "Rust version driver for Asix PHYs"
> +=09depends on RUST_PHYLIB_BINDINGS && AX88796B_PHY
> +=09help
> +=09  Uses the Rust version driver for Asix PHYs (ax88796b_rust.ko)
> +=09  instead of the C version.
> +
>   config BROADCOM_PHY
>   =09tristate "Broadcom 54XX PHYs"
>   =09select BCM_NET_PHYLIB
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index c945ed9bd14b..58d7dfb095ab 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -41,7 +41,11 @@ aquantia-objs=09=09=09+=3D aquantia_hwmon.o
>   endif
>   obj-$(CONFIG_AQUANTIA_PHY)=09+=3D aquantia.o
>   obj-$(CONFIG_AT803X_PHY)=09+=3D at803x.o
> -obj-$(CONFIG_AX88796B_PHY)=09+=3D ax88796b.o
> +ifdef CONFIG_AX88796B_RUST_PHY
> +  obj-$(CONFIG_AX88796B_PHY)=09+=3D ax88796b_rust.o
> +else
> +  obj-$(CONFIG_AX88796B_PHY)=09+=3D ax88796b.o
> +endif
>   obj-$(CONFIG_BCM54140_PHY)=09+=3D bcm54140.o
>   obj-$(CONFIG_BCM63XX_PHY)=09+=3D bcm63xx.o
>   obj-$(CONFIG_BCM7XXX_PHY)=09+=3D bcm7xxx.o
> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_=
rust.rs
> new file mode 100644
> index 000000000000..017f817f6f8d
> --- /dev/null
> +++ b/drivers/net/phy/ax88796b_rust.rs
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Rust Asix PHYs driver
> +//!
> +//! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.=
c)
> +use kernel::c_str;
> +use kernel::net::phy::{self, DeviceId, Driver};
> +use kernel::prelude::*;
> +use kernel::uapi;
> +
> +kernel::module_phy_driver! {
> +    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
> +    device_table: [
> +        DeviceId::new_with_driver::<PhyAX88772A>(),
> +        DeviceId::new_with_driver::<PhyAX88772C>(),
> +        DeviceId::new_with_driver::<PhyAX88796B>()
> +    ],
> +    name: "rust_asix_phy",
> +    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
> +    description: "Rust Asix PHYs driver",
> +    license: "GPL",
> +}
> +
> +// Performs a software PHY reset using the standard
> +// BMCR_RESET bit and poll for the reset bit to be cleared.
> +// Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implement=
ation
> +// such as used on the Individual Computers' X-Surf 100 Zorro card.
> +fn asix_soft_reset(dev: &mut phy::Device) -> Result {
> +    dev.write(uapi::MII_BMCR as u16, 0)?;
> +    dev.genphy_soft_reset()
> +}
> +
> +struct PhyAX88772A;
> +
> +#[vtable]
> +impl phy::Driver for PhyAX88772A {
> +    const FLAGS: u32 =3D phy::flags::IS_INTERNAL;
> +    const NAME: &'static CStr =3D c_str!("Asix Electronics AX88772A");
> +    const PHY_DEVICE_ID: phy::DeviceId =3D phy::DeviceId::new_with_exact=
_mask(0x003b1861);
> +
> +    // AX88772A is not working properly with some old switches (NETGEAR =
EN 108TP):
> +    // after autoneg is done and the link status is reported as active, =
the MII_LPA
> +    // register is 0. This issue is not reproducible on AX88772C.
> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> +        dev.genphy_update_link()?;
> +        if !dev.get_link() {
> +            return Ok(0);
> +        }
> +        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to res=
olve
> +        // linkmode so use MII_BMCR as default values.
> +        let ret =3D dev.read(uapi::MII_BMCR as u16)?;
> +
> +        if ret as u32 & uapi::BMCR_SPEED100 !=3D 0 {
> +            dev.set_speed(uapi::SPEED_100);
> +        } else {
> +            dev.set_speed(uapi::SPEED_10);
> +        }

Maybe refactor to only have one `dev.set_speed` call?

> +
> +        let duplex =3D if ret as u32 & uapi::BMCR_FULLDPLX !=3D 0 {
> +            phy::DuplexMode::Full
> +        } else {
> +            phy::DuplexMode::Half
> +        };
> +        dev.set_duplex(duplex);
> +
> +        dev.genphy_read_lpa()?;
> +
> +        if dev.is_autoneg_enabled() && dev.is_autoneg_completed() {
> +            dev.resolve_aneg_linkmode();
> +        }
> +
> +        Ok(0)
> +    }
> +
> +    fn suspend(dev: &mut phy::Device) -> Result {
> +        dev.genphy_suspend()
> +    }
> +
> +    fn resume(dev: &mut phy::Device) -> Result {
> +        dev.genphy_resume()
> +    }
> +
> +    fn soft_reset(dev: &mut phy::Device) -> Result {
> +        asix_soft_reset(dev)
> +    }
> +
> +    fn link_change_notify(dev: &mut phy::Device) {
> +        // Reset PHY, otherwise MII_LPA will provide outdated informatio=
n.
> +        // This issue is reproducible only with some link partner PHYs.
> +        if dev.state() =3D=3D phy::DeviceState::NoLink {
> +            let _ =3D dev.init_hw();
> +            let _ =3D dev.start_aneg();
> +        }
> +    }
> +}
> +
> +struct PhyAX88772C;
> +
> +#[vtable]
> +impl Driver for PhyAX88772C {
> +    const FLAGS: u32 =3D phy::flags::IS_INTERNAL;
> +    const NAME: &'static CStr =3D c_str!("Asix Electronics AX88772C");
> +    const PHY_DEVICE_ID: phy::DeviceId =3D phy::DeviceId::new_with_exact=
_mask(0x003b1881);
> +
> +    fn suspend(dev: &mut phy::Device) -> Result {
> +        dev.genphy_suspend()
> +    }
> +
> +    fn resume(dev: &mut phy::Device) -> Result {
> +        dev.genphy_resume()
> +    }
> +
> +    fn soft_reset(dev: &mut phy::Device) -> Result {
> +        asix_soft_reset(dev)
> +    }
> +}
> +
> +struct PhyAX88796B;
> +
> +#[vtable]
> +impl Driver for PhyAX88796B {
> +    const NAME: &'static CStr =3D c_str!("Asix Electronics AX88796B");
> +    const PHY_DEVICE_ID: phy::DeviceId =3D phy::DeviceId::new_with_model=
_mask(0x003b1841);
> +
> +    fn soft_reset(dev: &mut phy::Device) -> Result {
> +        asix_soft_reset(dev)
> +    }
> +}
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> index 301f5207f023..08f5e9334c9e 100644
> --- a/rust/uapi/uapi_helper.h
> +++ b/rust/uapi/uapi_helper.h
> @@ -7,3 +7,5 @@
>    */
>=20
>   #include <uapi/asm-generic/ioctl.h>
> +#include <uapi/linux/mii.h>
> +#include <uapi/linux/ethtool.h>
> --
> 2.34.1
>=20
>=20


