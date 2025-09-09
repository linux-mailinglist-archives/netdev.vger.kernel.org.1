Return-Path: <netdev+bounces-221228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59164B4FD96
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE18A540876
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED99345723;
	Tue,  9 Sep 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXVF3yf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B9341ABD;
	Tue,  9 Sep 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425036; cv=none; b=tUQlMlNX68aTVRecr/47rTVksrQTnpuukELzKodtZU8NgHsnFT4KcthaeYfK/uLylTqWhNBsQLjZ2l9Yoo5k7ekhu3NWVo5tYTOOQzWsX/QWYAoncBZEAanZ2mJEC3eDI6KPEk3sDEsahYQJQKG4/jpOIIy8eBxpI3y84udopng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425036; c=relaxed/simple;
	bh=31mOWd8+i/1YkiYaOgcvUkmjuR7GoBD5Ed0MeKEuOFo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uJixg82tKDwnW55ZMmN11jQRif2ydEO8esVava4wEZdScSBonpF3Sv/aOKlABv1dfZzlcMk+Qn1/hLk6Dqg7NG0je3YFyd2ZFrkxoIe7h7kd8d0QAgS/0GmypZ/1dDwm93SeWkdSyUFe8OabmdUmMzSMOXkcbU3eOnA12/XnYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXVF3yf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE4C4CEF4;
	Tue,  9 Sep 2025 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757425035;
	bh=31mOWd8+i/1YkiYaOgcvUkmjuR7GoBD5Ed0MeKEuOFo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=BXVF3yf9YngGzwiQotWaE4Rx6byZFIleDiFn32GZnBJJycd+usgkvBcEjrfraU96O
	 OLTqsYuQ/7Ml956/i1KRFTRDv3ny65maB8g2Qe9iG1w94gWkJpNT2tofdbPoe2tXH7
	 opsMO0H97xnzvR7WoO7CbjNuFHu4L7lYCDl0vQEf4fIFRrRX5pXgXj6qyMEvJi35rf
	 DF9JVkUOLuzzd4k1pKuBWFVkqfOQpB4frNdfuxprHgWoaLw3EH4vIWgZC9Vp9SjlhZ
	 PV/YJisDuvITkYhqnPjVVPk0BAnO3xPs8gzW5kLJnw74J8pKUJwjCAajxeYcZSXdz0
	 HpfFO1hkpa2pg==
Date: Tue, 09 Sep 2025 08:37:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 Russell King <linux@armlinux.org.uk>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, devicetree@vger.kernel.org, 
 Sean Wang <sean.wang@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, linux-mediatek@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
 DENG Qingfang <dqfext@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250909004343.18790-5-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-5-ansuelsmth@gmail.com>
Message-Id: <175742464480.3063209.323009363144312411.robh@kernel.org>
Subject: Re: [net-next PATCH v16 04/10] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Tue, 09 Sep 2025 02:43:35 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/net/airoha,an8855-mdio.yaml

/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: soc@1 (airoha,an8855): mdio: {'compatible': ['airoha,an8855-mdio'], '#address-cells': 1, '#size-cells': 0, 'ethernet-phy@1': {'compatible': ['ethernet-phy-idc0ff.0410', 'ethernet-phy-ieee802.3-c22'], 'reg': [[1]], 'nvmem-cells': [[3], [4], [5], [6]], 'nvmem-cell-names': ['tx_a', 'tx_b', 'tx_c', 'tx_d'], 'phandle': 1}, 'ethernet-phy@2': {'compatible': ['ethernet-phy-idc0ff.0410', 'ethernet-phy-ieee802.3-c22'], 'reg': [[2]], 'nvmem-cells': [[7], [8], [9], [10]], 'nvmem-cell-names': ['tx_a', 'tx_b', 'tx_c', 'tx_d'], 'phandle': 2}} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#"}
	from schema $id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: /example-0/mdio/soc@1/mdio: failed to match any schema with compatible: ['airoha,an8855-mdio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250909004343.18790-5-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


