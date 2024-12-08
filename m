Return-Path: <netdev+bounces-149946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41E9E8308
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FFA165D39
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA0EEBD;
	Sun,  8 Dec 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/IhdKaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D77EC5;
	Sun,  8 Dec 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622451; cv=none; b=XxuZtmAkV+OnUsgQUdHWJEXOGRsZroOuqp170qD4KASEdfMj5gESYZqiUg/pGVyAIw6p8DK80/jakrBbS9UtGVsPu+YahLioDfqgvCNwa0hWSLga0+NoUxFAbjLIorzCpqjdZyVn8C/ELNTXBEZvy8NStA4vb5MBx2oK/GzTfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622451; c=relaxed/simple;
	bh=psQ5GMnf4rJXcmuiIZaepV21KhxnioKMXbB542RhZKo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=spTFmxjkC+FbCNLuH5kU3AUNiJkve+4ED9ONvJxY9tF/T8a91y/HHgu9XQfYQCR1arVxmWl7MxArsFGomBSZMLWohcmB74dNNMRKtGXmiAObeAxLxvsz7ZB7icHSZiJR/JsIhlptu/42W2BZH1Qg1qsE6Y6Zi8a+60v6nxuR/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/IhdKaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B4EC4CECD;
	Sun,  8 Dec 2024 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622451;
	bh=psQ5GMnf4rJXcmuiIZaepV21KhxnioKMXbB542RhZKo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=i/IhdKaF6S9PFRirdpX+D/yTb+4EgZcgi/tjM+A/WMU+nMZlWULmy/LoU7I41kfdk
	 6QqZwXBSJtXVne+mE7xB4nrxgSdfTMOlgljYW53DXY5qGPMThsBoaT/++CpkUbQJiY
	 A9y3h3E85ExIvL6nmtfnz8jcZDhCc9lj7vbrmc2T7JfYGgTEjW3kDRh0k2sSpk7h55
	 0I19zbKqX53lWBAuWNhEClVRl6qIQ1DFPtkAgU3zvNOZ7eJ0OzmdFeq7bJ+BYLXQKQ
	 SiqcPmwTkgBzbqTXAplzOs3qxc998RgSuz6vja4681SVGV1akMaMOsPLMEKZcDlly4
	 Rm2l3dAHRIH1Q==
Date: Sat, 07 Dec 2024 19:47:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
 linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 upstream@airoha.com, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, Vladimir Oltean <olteanv@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241208002105.18074-5-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-5-ansuelsmth@gmail.com>
Message-Id: <173362244923.3602058.6036855102171988535.robh@kernel.org>
Subject: Re: [net-next PATCH v10 4/9] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Sun, 08 Dec 2024 01:20:39 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855-mfd.yaml       | 185 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 186 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.example.dtb: mdio: mfd@1:reg: [[1], [2]] is too long
	from schema $id: http://devicetree.org/schemas/net/mdio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241208002105.18074-5-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


