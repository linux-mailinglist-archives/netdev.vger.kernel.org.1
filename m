Return-Path: <netdev+bounces-272774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO5qNGrux2mcfAUAu9opvQ
	(envelope-from <netdev+bounces-272774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6534EC7C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB443008D00
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654DD2E1EFC;
	Sat, 28 Mar 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEnnFEK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42707199920
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710376; cv=none; b=Izc7bw9q6L9zjTDOMqVzOQdK+83CCvn4NAz+T0DYH1t6q5IV5mtkVC8s/jrZcNRhMNFx94+7HeE7zRhBYVtXv23sW7Le6in0hkYir7STpZViZZ7YFBW0CsiNxeayROBOb7JF/BW7PI9wd/Xs2DKrhle5xos2LQ0+5a7+aYNMcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710376; c=relaxed/simple;
	bh=L3wtY2yqlTkYjo864f/K2PlE27ul9IfAQh2b7OxhbUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzZr5zjILfq0BvJH5/iJTXL2OMTRKMF36qK590L0PakR9XpEAUozE3YP8PJFec71gBZSoOQ7d1morEDV8Px0lu0ggwHvwtGyx8v0hT6NY4P5nHUd/LFdfcDmOugK5sbc8wrh62OXMyEe77wOpKVap3/24qXSAGPmOaYxinMUbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEnnFEK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5539C2BCB0
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774710375;
	bh=L3wtY2yqlTkYjo864f/K2PlE27ul9IfAQh2b7OxhbUg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=PEnnFEK7C8X0o0Gl3x8yt8Wc2j/M4nfyMFjdppw3eQUT/T0G9BMtBbfnirGy5vvNz
	 xN+hyHpyuE5AWfwb05TB5KNQGyvadV/VS9fwglGE6YhANxE9fRu/m1PePVnKaxm96q
	 dugALz+KnDYehguUjYnS5ubfD18FJ8HFtb1tew7Z87DmtiCNy/giaEKKKVz+AjdDqX
	 KubG5SolmBteTcG46wkyi90zsgQV+dqRyYSC49BhBPevs5RCn0js5aHYPMalMve+o0
	 icEDgHNjPxuwjfwZnvaMVLQ9uFCJ/CnlBVwbdqM+4n9kssf2V1+LqsH4ReT/QcvYcf
	 bSbV5WZB2TQQw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38c01150eb2so23041091fa.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:06:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXESm2elmVKD6awMQbzRbhS2P+bAmp92Vu8gGM5cbyRH9Nnkr0sXjGxvonfKX1dlDwjhm/Ea58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYph82o8UP1yGvXgS4O1ZKTZlRdho5bWTXeVLmwBYrFxxXz5iL
	OtGGtpGLHpOxPSv6d1MB/QMHCQ9mRyN8eDmWwai/PaQVn35QtgRKwFEBeANwXOk5DME/hftkf3s
	s70/jxGReJYcFsTh5S5iOVv7ISQp5YH8=
X-Received: by 2002:a2e:8a89:0:b0:38c:3410:5539 with SMTP id
 38308e7fff4ca-38c7308699cmr17694981fa.6.1774710261477; Sat, 28 Mar 2026
 08:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech> <20260310-a733-clk-v1-3-36b4e9b24457@pigmoral.tech>
In-Reply-To: <20260310-a733-clk-v1-3-36b4e9b24457@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 28 Mar 2026 23:04:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66uDGLjovxUCxnHDiDBm7J1FMo5udtPJJQrfS5=i_KTDQ@mail.gmail.com>
X-Gm-Features: AQROBzBMgnRTbl4s0nhFjx59fmjHuR7ZH_t-KY0pcN2cCbjY2LeZWftamhL0jSs
Message-ID: <CAGb2v66uDGLjovxUCxnHDiDBm7J1FMo5udtPJJQrfS5=i_KTDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] clk: sunxi-ng: a733: Add PRCM CCU
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allwinnertech.com:email,mail.gmail.com:mid,pigmoral.tech:email]
X-Rspamd-Queue-Id: 2ED6534EC7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 4:42=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Add support for the Power Reset Clock Management (PRCM) module found in
> the Allwinner A733 SoC. This clock controller manages the clock control
> and reset functions for device modules within the CPUS domain.
>
> The PRCM module includes the management of three primary buses: r-ahb,
> r-apb0, and r-apb1. It also provides clocking for several key
> peripherals, such as R-UART, R-I2C, R-SPI, and the R-RISCV subsystem.
> Additionally, the reset lines for these modules are integrated.
>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/clk/sunxi-ng/Kconfig             |   5 +
>  drivers/clk/sunxi-ng/Makefile            |   2 +
>  drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c | 276 +++++++++++++++++++++++++=
++++++
>  3 files changed, 283 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 6af2d020e03e..202e793dc754 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -67,6 +67,11 @@ config SUN55I_A523_R_CCU
>         default ARCH_SUNXI
>         depends on ARM64 || COMPILE_TEST
>
> +config SUN60I_A733_R_CCU
> +       tristate "Support for the Allwinner A733 PRCM CCU"
> +       default ARCH_SUNXI
> +       depends on ARM64 || COMPILE_TEST
> +
>  config SUN4I_A10_CCU
>         tristate "Support for the Allwinner A10/A20 CCU"
>         default ARCH_SUNXI
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefil=
e
> index a1c4087d7241..d3702bdb7a23 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU) +=3D sun50i-h616-ccu.o
>  obj-$(CONFIG_SUN55I_A523_CCU)  +=3D sun55i-a523-ccu.o
>  obj-$(CONFIG_SUN55I_A523_MCU_CCU)      +=3D sun55i-a523-mcu-ccu.o
>  obj-$(CONFIG_SUN55I_A523_R_CCU)        +=3D sun55i-a523-r-ccu.o
> +obj-$(CONFIG_SUN60I_A733_R_CCU)        +=3D sun60i-a733-r-ccu.o
>  obj-$(CONFIG_SUN4I_A10_CCU)    +=3D sun4i-a10-ccu.o
>  obj-$(CONFIG_SUN5I_CCU)                +=3D sun5i-ccu.o
>  obj-$(CONFIG_SUN6I_A31_CCU)    +=3D sun6i-a31-ccu.o
> @@ -64,6 +65,7 @@ sun50i-h616-ccu-y             +=3D ccu-sun50i-h616.o
>  sun55i-a523-ccu-y              +=3D ccu-sun55i-a523.o
>  sun55i-a523-mcu-ccu-y          +=3D ccu-sun55i-a523-mcu.o
>  sun55i-a523-r-ccu-y            +=3D ccu-sun55i-a523-r.o
> +sun60i-a733-r-ccu-y            +=3D ccu-sun60i-a733-r.o
>  sun4i-a10-ccu-y                        +=3D ccu-sun4i-a10.o
>  sun5i-ccu-y                    +=3D ccu-sun5i.o
>  sun6i-a31-ccu-y                        +=3D ccu-sun6i-a31.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c b/drivers/clk/sunxi=
-ng/ccu-sun60i-a733-r.c
> new file mode 100644
> index 000000000000..06679be1eaae
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 rengaomin@allwinnertech.com
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
> + * Based on the A523 CCU driver:
> + *   Copyright (C) 2024 Arm Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/sun60i-a733-r-ccu.h>
> +#include <dt-bindings/reset/sun60i-a733-r-ccu.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +
> +static const struct clk_parent_data r_ahb_parents[] =3D {
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "losc" },
> +       { .fw_name =3D "iosc" },
> +       { .fw_name =3D "pll-periph0-200m" },
> +       { .fw_name =3D "pll-periph0-300m" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_ahb_clk, "r-ahb", r_ahb_parents, 0x00=
0,
> +                                0, 5,  /* M */
> +                                24, 3, /* mux */
> +                                0);
> +
> +static const struct clk_parent_data r_apb_parents[] =3D {
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "losc" },
> +       { .fw_name =3D "iosc" },
> +       { .fw_name =3D "pll-periph0-200m" },
> +       { .fw_name =3D "sys-24m" },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb0_clk, "r-apb0", r_apb_parents, 0x=
00c,
> +                                0, 5,  /* M */
> +                                24, 3, /* mux */
> +                                0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb1_clk, "r-apb1", r_apb_parents, 0x=
010,
> +                                0, 5,  /* M */
> +                                24, 3, /* mux */
> +                                0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0", r_apb_p=
arents, 0x100,
> +                                      0, 0,    /* no M */
> +                                      1, 3,    /* P */
> +                                      4, 3,    /* mux */
> +                                      BIT(0),  /* gate */
> +                                      0);

Use SUNXI_CCU_P_DATA_WITH_MUX_GATE(). Same for the other ones.

> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(r_cpu_timer1, "r-timer1", r_apb_p=
arents, 0x104,
> +                                      0, 0,    /* no M */
> +                                      1, 3,    /* P */
> +                                      4, 3,    /* mux */
> +                                      BIT(0),  /* gate */
> +                                      0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(r_cpu_timer2, "r-timer2", r_apb_p=
arents, 0x108,
> +                                      0, 0,    /* no M */
> +                                      1, 3,    /* P */
> +                                      4, 3,    /* mux */
> +                                      BIT(0),  /* gate */
> +                                      0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(r_cpu_timer3, "r-timer3", r_apb_p=
arents, 0x10c,
> +                                      0, 0,    /* no M */
> +                                      1, 3,    /* P */
> +                                      4, 3,    /* mux */
> +                                      BIT(0),  /* gate */
> +                                      0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_timer_clk, "bus-r-timer", &r_ahb_clk.comm=
on.hw, 0x11c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_twd_clk, "bus-r-twd", &r_apb0_clk.common.=
hw, 0x12c, BIT(0), 0);
> +
> +static const struct clk_parent_data r_pwmctrl_parents[] =3D {
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "losc" },
> +       { .fw_name =3D "iosc" },
> +       { .fw_name =3D "sys-24m" },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwmctrl_clk, "r-pwmctrl", r_pwmctr=
l_parents, 0x130,

r_pwm_clk, "r-pwm", ...

> +                                   24, 2,      /* mux */
> +                                   BIT(31),    /* gate */
> +                                   0);
> +static SUNXI_CCU_GATE_HW(bus_r_pwmctrl_clk, "bus-r-pwmctrl",

bus_r_pwm_clk, "bus-r-pwm".

> +                        &r_apb0_clk.common.hw, 0x13c, BIT(0), 0);
> +
> +static const struct clk_parent_data r_spi_parents[] =3D {
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "pll-periph0-200m" },
> +       { .fw_name =3D "pll-periph0-300m" },
> +       { .fw_name =3D "pll-periph1-300m" },
> +       { .fw_name =3D "sys-24m" },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(r_spi_clk, "r-spi", r_spi_parents, 0x1=
50,
> +                                 0, 5,         /* M */
> +                                 8, 5,         /* N */
> +                                 24, 3,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +static SUNXI_CCU_GATE_HW(bus_r_spi_clk, "bus-r-spi", &r_ahb_clk.common.h=
w, 0x15c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox", &r_ahb_clk.co=
mmon.hw, 0x17c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_uart0_clk, "bus-r-uart0", &r_apb1_clk.com=
mon.hw, 0x18c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_uart1_clk, "bus-r-uart1", &r_apb1_clk.com=
mon.hw, 0x18c, BIT(1), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_i2c0_clk, "bus-r-i2c0", &r_apb1_clk.commo=
n.hw, 0x19c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_i2c1_clk, "bus-r-i2c1", &r_apb1_clk.commo=
n.hw, 0x19c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_i2c2_clk, "bus-r-i2c2", &r_apb1_clk.commo=
n.hw, 0x19c, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_ppu_clk, "bus-r-ppu", &r_apb0_clk.common.=
hw, 0x1ac, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_tzma_clk, "bus-r-tzma", &r_apb0_clk.commo=
n.hw, 0x1b0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_cpu_bist_clk, "bus-r-cpu-bist", &r_apb0_c=
lk.common.hw,
> +                        0x1bc, BIT(0), 0);
> +
> +static const struct clk_parent_data r_ir_rx_parents[] =3D {
> +       { .fw_name =3D "losc" },
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "sys-24m" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(r_ir_rx_clk, "r-ir-rx", r_ir_rx_pa=
rents, 0x1c0,
> +                                     0, 5,     /* M */
> +                                     24, 2,    /* mux */
> +                                     BIT(31),  /* gate */
> +                                     0);
> +static SUNXI_CCU_GATE_HW(bus_r_ir_rx_clk, "bus-r-ir-rx", &r_apb0_clk.com=
mon.hw, 0x1cc, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc", &r_ahb_clk.common.h=
w, 0x20c, BIT(0), 0);
> +
> +static const struct clk_parent_data r_riscv_parents[] =3D {
> +       { .fw_name =3D "hosc" },
> +       { .fw_name =3D "losc" },
> +       { .fw_name =3D "iosc" },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(r_riscv_clk, "r-riscv", r_riscv_pare=
nts, 0x210,
> +                                 24, 2,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +static SUNXI_CCU_GATE_HW(bus_r_riscv_clk, "bus-r-riscv", &r_apb0_clk.com=
mon.hw,
> +                        0x21c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_riscv_cfg_clk, "bus-r-riscv-cfg", &r_apb0=
_clk.common.hw,
> +                        0x21c, BIT(1), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg", &r_apb0_clk.c=
ommon.hw,
> +                        0x22c, BIT(0), CLK_IS_CRITICAL);
> +
> +static struct ccu_common *sun60i_a733_r_ccu_clks[] =3D {
> +       &r_ahb_clk.common,
> +       &r_apb0_clk.common,
> +       &r_apb1_clk.common,
> +       &r_cpu_timer0.common,
> +       &r_cpu_timer1.common,
> +       &r_cpu_timer2.common,
> +       &r_cpu_timer3.common,
> +       &bus_r_timer_clk.common,
> +       &bus_r_twd_clk.common,
> +       &r_pwmctrl_clk.common,
> +       &bus_r_pwmctrl_clk.common,
> +       &r_spi_clk.common,
> +       &bus_r_spi_clk.common,
> +       &bus_r_msgbox_clk.common,
> +       &bus_r_uart0_clk.common,
> +       &bus_r_uart1_clk.common,
> +       &bus_r_i2c0_clk.common,
> +       &bus_r_i2c1_clk.common,
> +       &bus_r_i2c2_clk.common,
> +       &bus_r_ppu_clk.common,
> +       &bus_r_tzma_clk.common,
> +       &bus_r_cpu_bist_clk.common,
> +       &r_ir_rx_clk.common,
> +       &bus_r_ir_rx_clk.common,
> +       &bus_r_rtc_clk.common,
> +       &r_riscv_clk.common,
> +       &bus_r_riscv_clk.common,
> +       &bus_r_riscv_cfg_clk.common,
> +       &bus_r_cpucfg_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun60i_a733_r_hw_clks =3D {
> +       .hws =3D {
> +               [CLK_R_AHB]             =3D &r_ahb_clk.common.hw,
> +               [CLK_R_APB0]            =3D &r_apb0_clk.common.hw,
> +               [CLK_R_APB1]            =3D &r_apb1_clk.common.hw,
> +               [CLK_R_TIMER0]          =3D &r_cpu_timer0.common.hw,
> +               [CLK_R_TIMER1]          =3D &r_cpu_timer1.common.hw,
> +               [CLK_R_TIMER2]          =3D &r_cpu_timer2.common.hw,
> +               [CLK_R_TIMER3]          =3D &r_cpu_timer3.common.hw,
> +               [CLK_BUS_R_TIMER]       =3D &bus_r_timer_clk.common.hw,
> +               [CLK_BUS_R_TWD]         =3D &bus_r_twd_clk.common.hw,
> +               [CLK_R_PWMCTRL]         =3D &r_pwmctrl_clk.common.hw,
> +               [CLK_BUS_R_PWMCTRL]     =3D &bus_r_pwmctrl_clk.common.hw,
> +               [CLK_R_SPI]             =3D &r_spi_clk.common.hw,
> +               [CLK_BUS_R_SPI]         =3D &bus_r_spi_clk.common.hw,
> +               [CLK_BUS_R_MSGBOX]      =3D &bus_r_msgbox_clk.common.hw,
> +               [CLK_BUS_R_UART0]       =3D &bus_r_uart0_clk.common.hw,
> +               [CLK_BUS_R_UART1]       =3D &bus_r_uart1_clk.common.hw,
> +               [CLK_BUS_R_I2C0]        =3D &bus_r_i2c0_clk.common.hw,
> +               [CLK_BUS_R_I2C1]        =3D &bus_r_i2c1_clk.common.hw,
> +               [CLK_BUS_R_I2C2]        =3D &bus_r_i2c2_clk.common.hw,
> +               [CLK_BUS_R_PPU]         =3D &bus_r_ppu_clk.common.hw,
> +               [CLK_BUS_R_TZMA]        =3D &bus_r_tzma_clk.common.hw,
> +               [CLK_BUS_R_CPU_BIST]    =3D &bus_r_cpu_bist_clk.common.hw=
,
> +               [CLK_R_IR_RX]           =3D &r_ir_rx_clk.common.hw,
> +               [CLK_BUS_R_IR_RX]       =3D &bus_r_ir_rx_clk.common.hw,
> +               [CLK_BUS_R_RTC]         =3D &bus_r_rtc_clk.common.hw,
> +               [CLK_R_RISCV]           =3D &r_riscv_clk.common.hw,
> +               [CLK_BUS_R_RISCV]       =3D &bus_r_riscv_clk.common.hw,
> +               [CLK_BUS_R_RISCV_CFG]   =3D &bus_r_riscv_cfg_clk.common.h=
w,
> +               [CLK_BUS_R_CPUCFG]      =3D &bus_r_cpucfg_clk.common.hw,
> +       },
> +       .num =3D CLK_BUS_R_CPUCFG + 1,
> +};
> +
> +static struct ccu_reset_map sun60i_a733_r_ccu_resets[] =3D {
> +       [RST_BUS_R_TIMER]       =3D { 0x11c, BIT(16) },
> +       [RST_BUS_R_PWM]         =3D { 0x13c, BIT(16) },
> +       [RST_BUS_R_SPI]         =3D { 0x15c, BIT(16) },
> +       [RST_BUS_R_MSGBOX]      =3D { 0x17c, BIT(16) },
> +       [RST_BUS_R_UART0]       =3D { 0x18c, BIT(16) },
> +       [RST_BUS_R_UART1]       =3D { 0x18c, BIT(17) },
> +       [RST_BUS_R_I2C0]        =3D { 0x19c, BIT(16) },
> +       [RST_BUS_R_I2C1]        =3D { 0x19c, BIT(17) },
> +       [RST_BUS_R_I2C2]        =3D { 0x19c, BIT(18) },
> +       [RST_BUS_R_IR_RX]       =3D { 0x1cc, BIT(16) },
> +       [RST_BUS_R_RTC]         =3D { 0x20c, BIT(16) },
> +       [RST_BUS_R_RISCV_CFG]   =3D { 0x21c, BIT(16) },
> +       [RST_BUS_R_CPUCFG]      =3D { 0x22c, BIT(16) },
> +};
> +
> +static const struct sunxi_ccu_desc sun60i_a733_r_ccu_desc =3D {
> +       .ccu_clks       =3D sun60i_a733_r_ccu_clks,
> +       .num_ccu_clks   =3D ARRAY_SIZE(sun60i_a733_r_ccu_clks),
> +
> +       .hw_clks        =3D &sun60i_a733_r_hw_clks,
> +
> +       .resets         =3D sun60i_a733_r_ccu_resets,
> +       .num_resets     =3D ARRAY_SIZE(sun60i_a733_r_ccu_resets),
> +};
> +
> +static int sun60i_a733_r_ccu_probe(struct platform_device *pdev)
> +{
> +       void __iomem *reg;
> +
> +       reg =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg))
> +               return PTR_ERR(reg);
> +
> +       return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun60i_a733_r_ccu_d=
esc);
> +}
> +
> +static const struct of_device_id sun60i_a733_r_ccu_ids[] =3D {
> +       { .compatible =3D "allwinner,sun60i-a733-r-ccu" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun60i_a733_r_ccu_ids);
> +
> +static struct platform_driver sun60i_a733_r_ccu_driver =3D {
> +       .probe  =3D sun60i_a733_r_ccu_probe,
> +       .driver =3D {
> +               .name                   =3D "sun60i-a733-r-ccu",
> +               .suppress_bind_attrs    =3D true,
> +               .of_match_table         =3D sun60i_a733_r_ccu_ids,
> +       },
> +};
> +module_platform_driver(sun60i_a733_r_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner A733 PRCM CCU");
> +MODULE_LICENSE("GPL");

The rest look OK.


ChenYu

