Return-Path: <netdev+bounces-174002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01A0A5CF4E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3923B1149
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29192641C6;
	Tue, 11 Mar 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA73liGv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3B2AF06;
	Tue, 11 Mar 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721183; cv=none; b=RkUtl5QjLiwzFiZfY4sDN3+1uYyf/LKMv34kMj5yZ/xyHv8HA5ulaYn/l2phv/8Z6yCe3CpoUCm0JUPtxzptWn5SIlGz6R0xA36xwZPDVz4VHViAXe7Vo11gWR/XasNub0p757IJzFFkylBtiL17bXMmJ5JYmejyJtnTjpV/17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721183; c=relaxed/simple;
	bh=80AWITxWIZJU6gqD+4apHrqb5GXAVQYcG+OTuZyM75A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ldgab717R1lagAUstVHzIH3D06RaiK1gPMesGI2izlWbiu1Zreqiy4IbHhQJYxVjGnCgkdF2aKZ5MoUg619ZUYB/W/72KOtGBMRFyLk15PnJx/XLLjAEKd0/hzVCufJRKOmFe2Bu0x3IIZje9jWD7NyfSwFFq2sXRyn8BEr6wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA73liGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA72C4CEE9;
	Tue, 11 Mar 2025 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721183;
	bh=80AWITxWIZJU6gqD+4apHrqb5GXAVQYcG+OTuZyM75A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WA73liGvJPc47JKk+lXD4Xe4YN/06HGtcYOGXKibhgRyvEwG7gYIuRRzLCLVOGi2l
	 UgBq77Rax1i0wRhHrb4AhgWviooCQN+DXBrQCWrlVuxby8I24cR8dxIJag5iNXvl2z
	 QThn58g+HwSmvc57SrlcQ0aERsJPzwhJfTrALwwqRXgPgEnXP0geujHieunYbeY916
	 3YESJSjUHw2kByzdamjANBQzKhmDyYdybJMfXAgVwoVtbjGC7ZQwYy1Gye+kFzd7j+
	 TB5USuk96P1frEH7+PwacDQaPFPn3AZP40whu5GoYhQ2PsgJVOzcAzmW3bPXSn9nJ6
	 PbyvRl/OetMiQ==
Message-ID: <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250226232320.93791-2-inochiama@gmail.com>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-2-inochiama@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Tue, 11 Mar 2025 12:26:21 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-02-26 15:23:18)
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.ya=
ml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> new file mode 100644
> index 000000000000..d55c5d32e206
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2044 Clock Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>

No description?

> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2044-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@50002000 {
> +      compatible =3D "sophgo,sg2044-clk";
> +      reg =3D <0x50002000 0x1000>;
> +      #clock-cells =3D <1>;
> +      clocks =3D <&osc>;

I think you want the syscon phandle here as another property. Doing that
will cause the DT parsing logic to wait for the syscon to be probed
before trying to probe this driver. It's also useful so we can see if
the clock controller is overlapping withe whatever the syscon node is,
or if that syscon node should just have the #clock-cells property as
part of the node instead.

