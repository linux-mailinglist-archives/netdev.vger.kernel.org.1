Return-Path: <netdev+bounces-224364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679CB84256
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 199FF4E0537
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E952D9EFF;
	Thu, 18 Sep 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3+FK3JA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1822C11E9;
	Thu, 18 Sep 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191980; cv=none; b=AIAT2WdccaWcXBAWwGwpHAseVTfEBVg+5aGFT5q9ts8Zge4NNsDi7yh20I/ziQ5/aXr9BIEmPI5gd73bZSim2Yh8ZPraRSmEB7Fgt6G62KnG3knY4kGtANDYykc71AGlUIhWYVgktzyihj2XWGr7yoHvGzhuvV1+XdqY2Gi53AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191980; c=relaxed/simple;
	bh=fgVQ+j91Fez+nkL73mza5lRSVa/JXo8LJ4pD2kGgnIo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WHGH7vcJE2HydCclPvkqCHjniP9g41xoI0ye0v6ki1ajSSbcOa2IL7NoCOP/XyFmFJnfqy9JrT7weMrDUdYA/SZL6l6NCqFJr7a8My42AfMSiBmy27HsZ8yAixbgP94YZIMO/hZH/cBfLbFN44M5+/Xub2xmAziUXyVBJiiT3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3+FK3JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69582C4CEEB;
	Thu, 18 Sep 2025 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191979;
	bh=fgVQ+j91Fez+nkL73mza5lRSVa/JXo8LJ4pD2kGgnIo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=j3+FK3JAwgdtXmAmA/n8u92H71M5nmXhj88js81lHZ0PXcz6dejE4g+PoS1D2NCaN
	 eQnTteMfrViMm+HcaWZrAEgPLB2ij3iBbzpI0Y1V5RKXEUhzETS+SxXn7XLZXIXmki
	 PvAil22+9Tolh89AXqSomKl9WjJuKKeJ7AQsqfjJV+V5Vqq5+9Nlnl8HvmH+h5+3Ae
	 frBfUxrXUWKG7IthYpVWfT/AT4I1+wsRXPrnMtBTa3g3wHhofsApylkI9b02aZSkgj
	 71CUivatKdvvr1C6gvAtstsxtB8hy8r94dET5moVfTum20xjdekXQmHOUCmNZTRIie
	 FePqtINQC/CZg==
Date: Thu, 18 Sep 2025 05:39:38 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: ningyu@eswincomputing.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
 pabeni@redhat.com, rmk+kernel@armlinux.org.uk, anthony.l.nguyen@intel.com, 
 yong.liang.choong@linux.intel.com, linux-stm32@st-md-mailman.stormreply.com, 
 boon.khai.ng@altera.com, netdev@vger.kernel.org, krzk+dt@kernel.org, 
 andrew+netdev@lunn.ch, vladimir.oltean@nxp.com, inochiama@gmail.com, 
 jszhang@kernel.org, linux-arm-kernel@lists.infradead.org, 
 alexandre.torgue@foss.st.com, jan.petrous@oss.nxp.com, 
 mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org, 
 linmin@eswincomputing.com, 0x1207@gmail.com, lizhi2@eswincomputing.com, 
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, conor+dt@kernel.org, 
 pinkesh.vaghela@einfochips.com
To: weishangjuan@eswincomputing.com
In-Reply-To: <20250918085903.3228-1-weishangjuan@eswincomputing.com>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918085903.3228-1-weishangjuan@eswincomputing.com>
Message-Id: <175819197799.813528.5926397518793037522.robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC


On Thu, 18 Sep 2025 16:59:03 +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting clock
> configuration, delay adjustment and speed adaptive functions.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/net/eswin,eic7700-eth.yaml       | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml:127:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250918085903.3228-1-weishangjuan@eswincomputing.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


