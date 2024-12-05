Return-Path: <netdev+bounces-149341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CF9E52DF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75CE2853BC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8361D63F2;
	Thu,  5 Dec 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvuOhxsT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FA1946B3;
	Thu,  5 Dec 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395685; cv=none; b=uMvUSOPMCpDWqknmd2jbdDVi8hBzCCqUOhUSlWDMi5iGJWg8Msz/Kcn4MSMsKUGpzmnVK1/tv/tXAMKljp42QVW9G3csPJVZzWA6OT7QkFOSyFL3tAv/+gsHUYqMUFvCrLbi2EZPCtIXsBnhKZ/o7OEBgY29snRrHznDRPm3Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395685; c=relaxed/simple;
	bh=984bOJSofutD/cKYuwpIYV5GdLZGWe2dvJNXvkaebaU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Oie2IYuJaqx5k9IUT8vb/CSdcBYuTNPnSsASG58gokV9t1Wwwk52+QmqVfBX4iK2vB+2qaQw3zvOCAWfG6tkA39n3LvKRutpZ+bzooHMZbPyKSnCSy/qJfsmTSucYTSUEcnjBymkDPXb4z0geZylIVVG/9nVhxrowdc7HWMZ20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvuOhxsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A633C4CED1;
	Thu,  5 Dec 2024 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395684;
	bh=984bOJSofutD/cKYuwpIYV5GdLZGWe2dvJNXvkaebaU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mvuOhxsTG9flwdCTs/hQOE1YYyL8hj/aFKhEG2criZ5g95AMVqfblo2J/OVrkZO9U
	 fNi1Cv+L4PkI84R1dtCKzBGHsnHLKb8KtKUGbDEa9+7BesQiSc/ektc3BwZgj1Yywr
	 tMYJ0O8AZDW06vqFCjKLooOUa9gTYfUUleBS6KXudR9nE+k6U2iIaiillY7F3Nacig
	 D+/VCJaLC5INuQWHg3LZVtCsVYuHriY7RFNvfKg7HtUgfl0wJTXYtvenLhjvbu2n38
	 aWwRzA/o0Af4/RPNxwOhY1+M6LhN3H+xk013yVa5y5TknAq3nEtBdSMrcHv2ko6bym
	 1HCuMi0TT+P9A==
Date: Thu, 05 Dec 2024 04:48:02 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Richard Cochran <richardcochran@gmail.com>, 
 netdev@vger.kernel.org, linux-clk@vger.kernel.org, 
 Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
 <20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de>
Message-Id: <173339568226.2585836.18129717858312736704.robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: net: dwmac: Convert socfpga dwmac
 to DT schema


On Thu, 05 Dec 2024 10:06:01 +0100, Steffen Trumtrar wrote:
> Changes to the binding while converting:
> - add "snps,dwmac-3.7{0,2,4}a". They are used, but undocumented.
> - altr,f2h_ptp_ref_clk is not a required property but optional.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ----------
>  .../devicetree/bindings/net/socfpga-dwmac.yaml     | 119 +++++++++++++++++++++
>  2 files changed, 119 insertions(+), 57 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Documentation/devicetree/bindings/net/socfpga-dwmac.example.dtb: /example-0/phy@100000240: failed to match any schema with compatible: ['altr,gmii-to-sgmii-2.0']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/socfpga-dwmac.example.dtb: ethernet@ff700000: compatible: 'oneOf' conditional failed, one must be fixed:
	['altr,socfpga-stmmac', 'snps,dwmac-3.70a', 'snps,dwmac'] is too long
	'altr,socfpga-stmmac' is not one of ['altr,socfpga-stmmac-a10-s10']
	'snps,dwmac-3.72a' was expected
	'snps,dwmac-3.74a' was expected
	from schema $id: http://devicetree.org/schemas/net/socfpga-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/socfpga-dwmac.example.dtb: ethernet@ff700000: phy-mode:0: 'sgmii' is not of type 'array'
	from schema $id: http://devicetree.org/schemas/net/socfpga-dwmac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


