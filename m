Return-Path: <netdev+bounces-174416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B3A5E821
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521AE7AB634
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB21F1302;
	Wed, 12 Mar 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAfLgmNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCF4685;
	Wed, 12 Mar 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821280; cv=none; b=fGlRsSwEZGwfLCL4bKsA5mYgXdyEPwqrNkK2G/YP/AwKB/qz0gOzkPjORK5hnV8i0RwKz+XiCQBCzywTYUo4NEUyoCkuYX/LyT3PxUA+BDdqr/ngkgxJJhRAPO8Zaeqy8FAUzHKzDH6UmYrYS9d0GqM15vtPFPlb04sNkMZYJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821280; c=relaxed/simple;
	bh=TKgowIo1WaTZUviCcRMak32azD2cFfVNTUXSGH8c1O0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=syAnCL/iz5wvSZZFV6mtoXpmr7L1Nz/mtTWsRxJkE4C3ckwR3ew7KuOPmppu845lLu73UDBdTyxizsc/56OGhrNvDfl2P2V6h0V/QzZkYEFzEPbyawmGvLMgCU5vjrirhFn2shZfiID8cnrM74qgMIADGZFB5p3xNR12EcfWfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAfLgmNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F59DC4CEDD;
	Wed, 12 Mar 2025 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741821280;
	bh=TKgowIo1WaTZUviCcRMak32azD2cFfVNTUXSGH8c1O0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=eAfLgmNJBIhrzfTbBz15W2qXyisRuA+s0m0sbZ0DR4p5Yn/gYR7lffHji1Pi6aEKz
	 iEYjHrI0Tt4Cjp8pteJK78+OVFmkwbGZq6yWcr6QMo8exhqx3K9GefpIMExXacDNRh
	 KURQmUBu26eABgR5+fE6nmnvffrHsyK4SWEmBdjwmGVFmfDO2zE06KJnS0vqNXK2YH
	 VrGqoDKtTRm4MkgZrY7LhY7SgtxAK9qMGNNgHvHYQJcDqrUXQJjf9Ce2rJDiEEY4+j
	 ZNY/I0f84t/Yi407KIEBS2V77DWKo7zqJ8QXMrTL5tL3NSHZlSvQSL0tFB8WF2pqeO
	 KNWFA5iJpPFMQ==
Message-ID: <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-2-inochiama@gmail.com> <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org> <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Wed, 12 Mar 2025 16:14:37 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-03-11 16:31:29)
> On Tue, Mar 11, 2025 at 12:26:21PM -0700, Stephen Boyd wrote:
> > Quoting Inochi Amaoto (2025-02-26 15:23:18)
> > > diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-cl=
k.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > > new file mode 100644
> > > index 000000000000..d55c5d32e206
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> > > @@ -0,0 +1,40 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo SG2044 Clock Controller
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@gmail.com>
> >=20
> > No description?
> >=20
>=20
> I am not sure the things to be described. Maybe just tell the
> clock required and providing?

Sure and point to the header file with the binding numbers?

> > > +  - |
> > > +    clock-controller@50002000 {
> > > +      compatible =3D "sophgo,sg2044-clk";
> > > +      reg =3D <0x50002000 0x1000>;
> > > +      #clock-cells =3D <1>;
> > > +      clocks =3D <&osc>;
> >=20
> > I think you want the syscon phandle here as another property. Doing that
> > will cause the DT parsing logic to wait for the syscon to be probed
> > before trying to probe this driver. It's also useful so we can see if
> > the clock controller is overlapping withe whatever the syscon node is,
>=20
> It sounds like a good idea. At now, it does not seem like a good idea
> to hidden the device dependency detail. I will add a syscon property
> like "sophgo,pll-syscon" to identify its pll needs a syscon handle.

Cool.

>=20
> > or if that syscon node should just have the #clock-cells property as
> > part of the node instead.
>=20
> This is not match the hardware I think. The pll area is on the middle
> of the syscon and is hard to be separated as a subdevice of the syscon
> or just add  "#clock-cells" to the syscon device. It is better to handle
> them in one device/driver. So let the clock device reference it.

This happens all the time. We don't need a syscon for that unless the
registers for the pll are both inside the syscon and in the register
space 0x50002000. Is that the case? This looks like you want there to be
one node for clks on the system because logically that is clean, when
the reality is that there is a PLL block exposed in the syscon (someone
forgot to put it in the clk controller?) and a non-PLL block for the
other clks.

