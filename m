Return-Path: <netdev+bounces-163149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBBA296BC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C2F3A505C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BD1DC9BA;
	Wed,  5 Feb 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BReColQu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212014B088;
	Wed,  5 Feb 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774187; cv=none; b=ORe1qkgGsbX8qk/ke5S+yky3C0Jr6uSmu3aZO7W4P5an52DbKPIUXUAQzCtYZgaKAMK7gFGpD7LKEvkqryfM2otOEAls6STAfwG1KZASxvkDNgG/Z8qE3IHrshF5KjncXej274V5ZObNzFXDay86N0EFLQiSO/J423X7F0IL0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774187; c=relaxed/simple;
	bh=qqOru803PJBpLRoFdE8E4L+PVvp3s1DzHzqu8RFhS2U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=At8Q7oIp4yAiAjajaCKNyuXacxZdzLKgGMd6wXo4qqU3Xdpf7zo4CvGz7HYD9NMySRAVlNEvtMDxUTJsCkBMtcRUKGhGue2qyWXL7gAYSp/CPbR1mjMzhoGsMmFHRGUQ1iKo5nAMqWVEBAjIQTdmRFTG7tyTjHqEKK6+d7sjKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BReColQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A1BC4CED1;
	Wed,  5 Feb 2025 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738774186;
	bh=qqOru803PJBpLRoFdE8E4L+PVvp3s1DzHzqu8RFhS2U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=BReColQuEWyn4yxIv5AeBS7crCvCtH77t2Lu1COtQJY6hhi81ZT7gr/XuUL4huCOA
	 aQ/tMbxYGPJALf+0XeeMY1GmLkcGNosbFLmBX/ax4wYDcOct4ZHqPbtKLlGrekQkjJ
	 Xa52OwH/bhQVsDepXGMqs849SdSdsIeisitUPLTNpFbHQDwJiSXhfGQ4wpUN0gcdGm
	 3LezgOcdbWDuZiayPN3Gx8IUKu4ysxoU0sSABtr79TxYuijIA4lac1rrGMajJZ7m9l
	 3YPJeDKHuC9chZYzjEPw6oSChcXsWE1tEw0CEyrhahsdMaJFBTprkKKVH7oA36exUP
	 mGryIMZi01LMA==
Date: Wed, 05 Feb 2025 10:49:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Dinh Nguyen <dinguyen@kernel.org>, kernel@pengutronix.de, 
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
In-Reply-To: <20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
 <20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de>
Message-Id: <173877418502.1694868.7734639778320336620.robh@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: dwmac: Convert socfpga dwmac
 to DT schema


On Wed, 05 Feb 2025 16:32:23 +0100, Steffen Trumtrar wrote:
> Changes to the binding while converting:
> - add "snps,dwmac-3.7{0,2,4}a". They are used, but undocumented.
> - altr,f2h_ptp_ref_clk is not a required property but optional.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  .../bindings/net/pcs/altr,gmii-to-sgmii.yaml       |  47 ++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ------------
>  .../devicetree/bindings/net/socfpga-dwmac.yaml     | 102 +++++++++++++++++++++
>  3 files changed, 149 insertions(+), 57 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.example.dtb: phy@100000240: reg: [[1, 576], [8, 1], [512, 64]] is too short
	from schema $id: http://devicetree.org/schemas/pcs/altr,gmii-to-sgmii.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.example.dtb: phy@100000240: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pcs/altr,gmii-to-sgmii.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


