Return-Path: <netdev+bounces-223183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511EB582A7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A993B1EC4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D1272E4E;
	Mon, 15 Sep 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLfa2jcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB01E411C;
	Mon, 15 Sep 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955709; cv=none; b=dyAM6HSsWw9NRp4wYvGNOGkQB66pxghnh2LWkmqTvlE1tG8wIFiGQtqTEZlmE1tvBIPH8igVLUA+aOltQVB6m+IjVfvX1Tiq4vwRUch/COKGM1zV0ANAYiqMjoxG85JcETZvjm1OUkwCRaJYdqPiMOiTI+Z+ZW0+f60jI7qYaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955709; c=relaxed/simple;
	bh=ybnq6TfBeUjye9uRRrxgazoqeAR/KqnFTVvxQhsbxpI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=afr8R/W79OuJI2GcmWGbP7lOlxiHK9RB0Z+lfrXzTBtqGcaJly+qGB3XF8X78hfw0Jr/cmSieaQA/rIWEyuAdwPTyMOyQCajK+Az5bZgXenJKjtahnpx4pnPwAFjlHvOpGNT18LgY/tjYeWhZprYfYSEoC/ZyNo84khzAvxWeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLfa2jcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B93C4CEF7;
	Mon, 15 Sep 2025 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757955708;
	bh=ybnq6TfBeUjye9uRRrxgazoqeAR/KqnFTVvxQhsbxpI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JLfa2jcXrnbxpTRuxh1KJ+8gZAamHyThRyVHtBOvj2AncGOmXlLR5S8vUHU3o5/ZO
	 M+FXXmD/qdqaBcUt+v41jYr8U4UsT1fyBTqh66km5cPbSPdaJPhGXuFJpuxg1U6PQ8
	 /drAVcg9f3eTapOvUIpq84g/+r1xBAiggFEkanbUY1gBvNvTOUcvYBkVu+tVCQz13p
	 fJYTxbDO4hnPaSVva9rspIUwRcEps3yX2RIT4gxgwjfttWCaDGr2oGpeH/fWR1cfMP
	 HIKoIvTof8oDlUHZQTxBksbuJdWk8aLox4CyK8Xb4jl5GHkXT2vF3gBMLXmucyBe5b
	 oitwRsrgUOCrg==
Date: Mon, 15 Sep 2025 12:01:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 DENG Qingfang <dqfext@gmail.com>, Lee Jones <lee@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250915104545.1742-4-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-4-ansuelsmth@gmail.com>
Message-Id: <175795551518.2905345.11331954231627495466.robh@kernel.org>
Subject: Re: [net-next PATCH v18 3/8] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Mon, 15 Sep 2025 12:45:39 +0200, Christian Marangi wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250915104545.1742-4-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


