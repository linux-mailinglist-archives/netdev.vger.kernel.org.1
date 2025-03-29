Return-Path: <netdev+bounces-178180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91519A753E2
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0C189A3FF
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3688F9D9;
	Sat, 29 Mar 2025 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxBdoQmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914F801;
	Sat, 29 Mar 2025 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743212223; cv=none; b=LsNr3MW9V1Nd/eU8LoFCuX950dz+iRLB5jnE7HBwlq9nq6kixLAitOVmAvN94xA+Ey7uK+9UkVDqGQPJZRjMLjP3YT3v7T9hicBlQktJwocNql5XwvKdGD6CBjgq4ev7lC880/IzdOoCMMTWg/Exm6jQmCE1CmcUfrFiIepY2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743212223; c=relaxed/simple;
	bh=o5gMyn/mlm4eQI/Dl0X9AbYok0h90x/eTaw9nzXxVOE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jBy9MimD4Shw/othgHQKTGNFeFn0GdaTOAZOWQHlhMPO6HjSuyHH/318YhCn/3T8YPJ6CK4+tkdWKUW/kZ0I2ISbJFQdCsA+uX45539qkHpYgcX3LSv9O5gC/4kuCB6XzmTUrouxVMZL6223eD9uPck8StrDAtheicRJKt15+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxBdoQmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6478C4CEE4;
	Sat, 29 Mar 2025 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743212223;
	bh=o5gMyn/mlm4eQI/Dl0X9AbYok0h90x/eTaw9nzXxVOE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NxBdoQmZGTDH1AlPECrbDPD9Q2HdKGVHCD+APkAyVEB0q3uQbazXzYky6Uk/oQhz/
	 pdOGfSrTaKOgAc4VcVRZfAEeiI1qeZe5rcQqtMxARHt39JOCgb5oXdNc/2+oIqllVj
	 kPhKxEbmrxXvFX44pgNw4bTya/KBOWJsy0KjRBDxKq1Dz1p8lF3wAnWKakTdKgv4h0
	 WsD3vYjVelPUch+0ShOmeqVCeu6YY4m3tH0m3xXswnSorSpmpTv4rSzOOME1zfSw61
	 mcWfEv4Lhqbm3mkPpViVSSVrKEeRZWdoBKOdvvFdV+du49Rm3Q6ucakKlxEwxFgCHs
	 0O//k268HPjvw==
Date: Fri, 28 Mar 2025 20:37:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: davem@davemloft.net, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Fabio Estevam <festevam@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20250328133544.4149716-2-lukma@denx.de>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-2-lukma@denx.de>
Message-Id: <174321222112.2172775.16689010014876150131.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch
 description


On Fri, 28 Mar 2025 14:35:41 +0100, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>   (nxp,imx287-mtip-switch)
> ---
>  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.example.dtb: /example-0/switch@800f0000: failed to match any schema with compatible: ['nxp,imx287-mtip-switch']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.example.dtb: ethernet-phy@0: interrupts: [[13], [2]] is too long
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.example.dtb: ethernet-phy@1: interrupts: [[13], [2]] is too long
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250328133544.4149716-2-lukma@denx.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


