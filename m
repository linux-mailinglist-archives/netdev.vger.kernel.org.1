Return-Path: <netdev+bounces-64034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBF830C01
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8C11F24707
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D236C225DE;
	Wed, 17 Jan 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3wrGeyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DC22EE0;
	Wed, 17 Jan 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512918; cv=none; b=IF3FKi+nmdxw178KaLaMuHixoOT8miYVPWnPULZ2o1LJJLtPrAOmrLgVXX0ne4RUvP384J4j7NoX33Vg9WYM7IKhtd28dfScnNhEcBC7Zwp+RgTkXgcj/CrOhcsL0EBwFnQZFPRwRIPAsbKOj+H6CJyUGVbvkF8PL18UB8uYvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512918; c=relaxed/simple;
	bh=oIWaEsBOlnYHV6T9/6T59q/lnvj4NY3Q1KQGCYH6eYM=;
	h=Received:DKIM-Signature:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Message-Id:Subject; b=QLF47m0PQ4GLTwJR2J+BAc1dL2C4NZT6m4NJxdGzEh3SdEX8XAIGVKveabG1ElUZvhjuQKUq/tAjY5iUlPzmfkYDdB/KyZWT2F/PoEVBMTMvUVMobEBfFVENw6J4NsOfsMzm8RZjYaZxe+ntUrtWeJC20tDPjyCCQqoPeZFAeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3wrGeyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A33C433F1;
	Wed, 17 Jan 2024 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512918;
	bh=oIWaEsBOlnYHV6T9/6T59q/lnvj4NY3Q1KQGCYH6eYM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=t3wrGeyYRRSq+Y3cDmSao3YDe/9WSlonS30jRL+IuZsHyTgbn3ZsShXLdXqhabmIw
	 /XWvp0VT6gM+Bv1zKwwf2wi9Z4e3DyaOKSYdbul3rpWyZJ+4XGFyBMldwgOAEUzo/Y
	 z7en4KjdO7JIlipgWCOcYsF7Xl0QZBjffAhbLblXSOyWMuG8bieHYPoPC4z//YkfrL
	 zxAR0z4ELZD6UxZnXiA1gsOWJjPsUGxNRFS+EX1XalkFYd+WqNd9ez75hy1Lf1Z/ea
	 qAfFdF2Ev9JSlHuwqTPATWlZ3a8p54yrgexRMIb06ELYWGlaoasRQ+b2H68k5Iszn7
	 JOqIrju7sXu+A==
Date: Wed, 17 Jan 2024 11:35:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: conor+dt@kernel.org, danishanwar@ti.com, rogerq@kernel.org, 
 devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
 robh+dt@kernel.org, netdev@vger.kernel.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, pabeni@redhat.com, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
 edumazet@google.com
In-Reply-To: <20240117161602.153233-2-diogo.ivo@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
 <20240117161602.153233-2-diogo.ivo@siemens.com>
Message-Id: <170551291581.2805121.8074468578390457247.robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: net: Add support for AM65x SR1.0
 in ICSSG


On Wed, 17 Jan 2024 16:14:55 +0000, Diogo Ivo wrote:
> Silicon Revision 1.0 of the AM65x came with a slightly different ICSSG
> support: Only 2 PRUs per slice are available and instead 2 additional
> DMA channels are used for management purposes. We have no restrictions
> on specified PRUs, but the DMA channels need to be adjusted.
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
> Changes in v2:
>  - Removed explicit reference to SR2.0
>  - Moved sr1 to the SoC name
>  - Expand dma-names list and adjust min/maxItems depending on SR1.0/2.0
> 
>  .../bindings/net/ti,icssg-prueth.yaml         | 29 ++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml:137:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/ti,icssg-prueth.example.dts'
Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml:137:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/ti,icssg-prueth.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml:137:1: found duplicate key "allOf" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240117161602.153233-2-diogo.ivo@siemens.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


