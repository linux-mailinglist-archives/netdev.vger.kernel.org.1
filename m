Return-Path: <netdev+bounces-177425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD1A7025A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F93D19A7CC9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B0258CFD;
	Tue, 25 Mar 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6yTA+u2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639E502BE;
	Tue, 25 Mar 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909122; cv=none; b=u4JMZxVNZHso35G92OMMCTMtARK5/zLXs8RWqHvfPUsI7UwPQIbEasXIrNO2ZIefVUPE0AaE4CjQaKKnebBNkdXa0KxH5DyH0hIzDxK7Sf8dgiP7se75R2O137anGqka0eh5vu1JKwRAoq60uOdTAAJAPfrs3EXPTWO3eh0kc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909122; c=relaxed/simple;
	bh=riM+PdIFp4F9Ca2yh3yjjOIAa8IAvG/TWOdBiFmYJ9I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=j+wv+tQm292hOmqg72ohiq56sUkzTZLFJFzb6gWxghF1LLzarxkWTn/BjL6U0JaTL6cjwwFBd67peNM1JEcc+CMQ1OTv3z8djZ3ZZ8wYhiu9zKC/b0TOyWdE3/1HvqcXbHDXVQqNEmvsYbPb0R1MR2AdFPw2U8iqB/uBKm8tKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6yTA+u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D2C4CEE4;
	Tue, 25 Mar 2025 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909121;
	bh=riM+PdIFp4F9Ca2yh3yjjOIAa8IAvG/TWOdBiFmYJ9I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=g6yTA+u242qu0hdKl4BvNNw97H3vXjD+RFcgUJ7/oTJrixxqztdDclDi9SN7xlVPn
	 KNdRpdTVoTccoffC8fgy+0i5yEQj+SengpKnB1MpQN7zB8+08NHbcisXimbWppiknD
	 WXGOGKweTmeINMT9M0R1EqXDfIRYsCLfWKgRDWuyYU++G1vez0DENGhNkUgm7NZ8vv
	 UdyuP0Xlf98AOWomB18BziEJHqVBFLL3jJkmZnRfT8N3njdePJfwMsVoSn36/IayoG
	 Uu2RdmNzRcMxYpfRGJapYf+XRXJ+NElXC0KF+Nvor5j7Y+nRLXUTndufa3QRgIUn6M
	 VkgxJtJhZwEgA==
Date: Tue, 25 Mar 2025 08:25:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Fabio Estevam <festevam@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20250325115736.1732721-3-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-3-lukma@denx.de>
Message-Id: <174290912071.1778035.16692989163958141305.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)


On Tue, 25 Mar 2025 12:57:33 +0100, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - imx287, vf610.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../bindings/net/fec,mtip-switch.yaml         | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/fec,mtip-switch.yaml:19:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/fec,mtip-switch.yaml:19:1: found character '\t' that cannot start any token
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/fec,mtip-switch.example.dts'
Documentation/devicetree/bindings/net/fec,mtip-switch.yaml:19:1: found character '\t' that cannot start any token
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/fec,mtip-switch.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250325115736.1732721-3-lukma@denx.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


