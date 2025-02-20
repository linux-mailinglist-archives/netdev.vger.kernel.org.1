Return-Path: <netdev+bounces-168264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6284A3E4A7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998727A73CB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B3263F25;
	Thu, 20 Feb 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU2r/8Tv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0A263897;
	Thu, 20 Feb 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078073; cv=none; b=qVIrxUfkf+1BcwYiS4hguHKgt2DTAgrthHWNnTsv1Q3DRbeb6LdUXkPvrMRiu/xlZig0OZ2A+v11U5QbGqa9a9nEWKjaDXBzxEEJDHJRbE1D89RpQgpj1rl0QaNPaUDkVYnIA7MDhx5by4M/RQZAlrM2jNyDooR4IU80MWo9JXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078073; c=relaxed/simple;
	bh=3eSbTSY6gzid17O8YvJVmqL/qDONChvMx36LySAdg9w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iqRBv9XgyN7QlBQonwPyWM8Aqsl9DSasAcnc9h9TtuaLv/OvdmMi99Dc1ibNxC+O7ap1DcXZ5apz1BKL99jFkp+Mv/ZwH5kW6rVgtCx9+bVEQybgvKcpt5sKDDTU3mq7xqU0/uSL4bfQCMVR7pXksRtvTHPfZcRd62jwcw+cCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU2r/8Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E7BC4CED1;
	Thu, 20 Feb 2025 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740078072;
	bh=3eSbTSY6gzid17O8YvJVmqL/qDONChvMx36LySAdg9w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VU2r/8TvTX1NZqulGBu9moXAsMcewLzpFHhx0lUz9lSfxHvaIu5RKl7UoxkyW0r6v
	 vvFgxr0v3sPzsol4Q16uMZdWHd80wDDTuCg427w1SjWtcu9P0hW7gU1SCcqL4fN4Kl
	 qc0wOfNrbGkDoecAUODHsjql+OzcMbp8djOrSQ2ULglyrUtefF3oGao10PER8DRznr
	 jX7OmAWhSyEcZAkHOxRE97hd8GTV41ZnlPV+CqSyctqFWrlWEJPXshQ6q6XwURbhfO
	 sl8tG0RG/kgC2TmSjvXu0RTvQl63Ff9XlYuwZQ8c37CPBYPDWWEegUfKjdmAgpRzAC
	 m9c8XJpOoeehw==
Date: Thu, 20 Feb 2025 13:01:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
Message-Id: <174007807159.3628302.7511694627571289256.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML


On Thu, 20 Feb 2025 18:29:23 +0100, J. Neuschäfer wrote:
> Add a binding for the "Gianfar" ethernet controller, also known as
> TSEC/eTSEC.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/net/fsl,gianfar.yaml       | 242 +++++++++++++++++++++
>  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
>  2 files changed, 243 insertions(+), 38 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "gianfar" found in schemas matching "$id":
	http://devicetree.org/schemas/net/fsl,gianfar.yaml#
	http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: device_type:0: 'mdio' was expected
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: $nodename:0: 'ethernet@24000' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: Unevaluated properties are not allowed ('device_type', 'interrupts', 'local-mac-address', 'model', 'phy-handle' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: device_type:0: 'mdio' was expected
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: $nodename:0: 'ethernet@24000' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: mdio@520:reg:0:0: 1312 is greater than the maximum of 31
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: mdio@520:reg:0: [1312, 32] is too long
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fsl,gianfar.example.dtb: ethernet@24000: Unevaluated properties are not allowed ('#size-cells', 'cell-index', 'device_type', 'interrupts', 'local-mac-address', 'mdio@520', 'model', 'ranges' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


