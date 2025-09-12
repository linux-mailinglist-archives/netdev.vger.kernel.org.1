Return-Path: <netdev+bounces-222627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF9EB55162
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A02F7A6AFC
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279A314A94;
	Fri, 12 Sep 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN1uAaP2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA330AABC;
	Fri, 12 Sep 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687035; cv=none; b=Gi8HONfw0x4kPM8THhUz3ceg5tyXNYZ6CwmIxepLTwJ18VMuv+MqFX4oy5Bp8XEAMW9L3e9iA50Az38MYg/6VOnL/7cEXw2qiRx3cx0HuNRI0/7YLRvL4dq53Yzh1rL3XWOKM1ATCtBXXm0FXk1T6Z1fokWQWN0o/Va6TEo9PKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687035; c=relaxed/simple;
	bh=Zzeb1xA15y7Nd5yeEIlwzepKZqZbRO8bXy7c3wtivpk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kEStIXmuUfsl1NOKZCVmON69X3S+f301ONbfqM4IMfBbcCw5Pj2KwQ2JAjDJNTZW+Oprqc20uE5IBMFmGko2d+zvxqwkvkixX2OpTD7bd5nc4YDsR55fY0QSXkVW0HTiZR8a2bKE+Hl+dtXVhh7yu0xDylcEXGTcU+k/uqBWow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN1uAaP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABDFC4CEF1;
	Fri, 12 Sep 2025 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687034;
	bh=Zzeb1xA15y7Nd5yeEIlwzepKZqZbRO8bXy7c3wtivpk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eN1uAaP2ISZdR+wzUrgH6fkCA1Rc+22UTI9Qi8awhRBkN+SC6s2gxcNujr0aMwvfL
	 ZYrSat9StKeVpa+M1dWYj2BuPoiXYf68dBmar+TOQKd+0/sL53ZifrOqSueOW4K8UD
	 aoG+eWvBQ+KQWq542E2ZFDN3PXgRNiDXb3zEf04qc0JTWb1+byDyWUmvtNduYVxsOn
	 GZfxkaxoH+ssE59hv0NhuDOyT0u/e5a44rrsU1swetAGqwK1+BUZ8CvR3Ph5bZQS6S
	 EDzp/Et3NNz2GG5mIUXGaE7aDnKi8TdfqzDks6JCBp+7BtzuzBRlorZdB4ltnebma5
	 pa3wZyCiBmG5w==
Date: Fri, 12 Sep 2025 09:23:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Simon Horman <horms@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250911133929.30874-4-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
 <20250911133929.30874-4-ansuelsmth@gmail.com>
Message-Id: <175768614723.1333721.12484884958652765550.robh@kernel.org>
Subject: Re: [net-next PATCH v17 3/8] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Thu, 11 Sep 2025 15:39:18 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/nvmem/airoha,an8855-efuse.yaml

/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: soc@1 (airoha,an8855): efuse: {'compatible': ['airoha,an8855-efuse'], '#nvmem-cell-cells': 0, 'nvmem-layout': {'compatible': ['fixed-layout'], '#address-cells': 1, '#size-cells': 1, 'shift-sel-port0-tx-a@c': {'reg': [[12, 4]], 'phandle': 3}, 'shift-sel-port0-tx-b@10': {'reg': [[16, 4]], 'phandle': 4}, 'shift-sel-port0-tx-c@14': {'reg': [[20, 4]], 'phandle': 5}, 'shift-sel-port0-tx-d@18': {'reg': [[24, 4]], 'phandle': 6}, 'shift-sel-port1-tx-a@1c': {'reg': [[28, 4]], 'phandle': 7}, 'shift-sel-port1-tx-b@20': {'reg': [[32, 4]], 'phandle': 8}, 'shift-sel-port1-tx-c@24': {'reg': [[36, 4]], 'phandle': 9}, 'shift-sel-port1-tx-d@28': {'reg': [[40, 4]], 'phandle': 10}}} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#"}
	from schema $id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: /example-0/mdio/soc@1/efuse: failed to match any schema with compatible: ['airoha,an8855-efuse']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250911133929.30874-4-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


