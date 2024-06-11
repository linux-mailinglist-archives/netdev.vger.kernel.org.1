Return-Path: <netdev+bounces-102573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384F903C3F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D01F22FBE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E517C216;
	Tue, 11 Jun 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF/FWSJt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F21E86F;
	Tue, 11 Jun 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110320; cv=none; b=opsmv9KuxOrM/oS15E9pnOZgCK+79CvOqtngFDnBIt15uRlnT9hAofUddA8W/9KcxD+M5CSyFb3lwufuBW7GqAZ91kgI2uYuzgPeg6XuV6L8+1vdouj7HanQxn4rvyBs9zA7iBRJxmcmC2IumsOd/clkvGI7fWjw7vOk4BL9Vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110320; c=relaxed/simple;
	bh=XHrBjFoYko9UAaT8tZQIEHqbp8GqsjyvWzgXJ7PXR9A=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NbSh2rUwOvmTkAgm2TjwfD398G/hqkTauvhqAcDZ58LuXRt9uJNf3P/jqRLx2ZRFHDPY3oURdtOgdTepcyl5A3GR0zhMIXBbUhHP+GiQaepJ4Vu6VT4HVfbVfMS1cLnqFQSG7PE1Rx3nC/vBdw2POGMylXE4AnHc87d3HxQNZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF/FWSJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF92C2BD10;
	Tue, 11 Jun 2024 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718110320;
	bh=XHrBjFoYko9UAaT8tZQIEHqbp8GqsjyvWzgXJ7PXR9A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sF/FWSJt7xAsi3jeJ/VE2Ukk92VC6RullSODoTuBbUkl1C+s2zfTxNu7Q/dScW71T
	 NJSCBEI4AGTfnyghHf4GbIcJbosHjf2DITOoptwqYu5/1ZRxlXOitjezy8i3XO9r8H
	 MWjFaDsX9lMIYpLneCjK2cigaF+gMv9UPZLWFxz7lcjQkutWCkey81ohHTWtTsO1zQ
	 z72ND1wmpJjbMxMq7PVA1qSlQ7FPGXyvqXVfSQymWowEHgDkpyGNLaYMbINwzQ7FMh
	 SMWkOP9J1F6MwmK9speF2EaONVch8oOWOBTBGmBoh03Q4LHOUzuYk3NgR5qukr1feo
	 8T6F4wZCW0itw==
Date: Tue, 11 Jun 2024 06:51:58 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: hauke@hauke-m.de, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, edumazet@google.com, andrew@lunn.ch, 
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
 netdev@vger.kernel.org, f.fainelli@gmail.com, devicetree@vger.kernel.org, 
 olteanv@gmail.com, martin.blumenstingl@googlemail.com
In-Reply-To: <20240611114027.3136405-2-ms@dev.tdt.de>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
 <20240611114027.3136405-2-ms@dev.tdt.de>
Message-Id: <171811031870.1486987.3222041734647742398.robh@kernel.org>
Subject: Re: [PATCH net-next v4 01/13] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema


On Tue, 11 Jun 2024 13:40:15 +0200, Martin Schiller wrote:
> Convert the lantiq,gswip bindings to YAML format.
> 
> Also add this new file to the MAINTAINERS file.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 195 ++++++++++++++++++
>  .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
>  MAINTAINERS                                   |   1 +
>  3 files changed, 196 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb: switch@e108000: ports:port@6: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb: switch@e108000: ports:port@6: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb: switch@e108000: Unevaluated properties are not allowed ('dsa,member', 'ports' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611114027.3136405-2-ms@dev.tdt.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


