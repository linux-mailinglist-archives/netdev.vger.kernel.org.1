Return-Path: <netdev+bounces-37068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7317B36E2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B05101C209F0
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F551BA7;
	Fri, 29 Sep 2023 15:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748E18631;
	Fri, 29 Sep 2023 15:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4186C433C7;
	Fri, 29 Sep 2023 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696001729;
	bh=n8c5VPqof5cSz/xeEzUcmLspOpPdFu7ZTPAoFiNDi+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dLE9nEAz7xekqFIavm5dEJULK3Af4aiyLsSYoYDepzYMqvw4BVd56r19mCA7b5ove
	 YEWaLF6IxaIZpcLVg07pFTX5C8bu2DWEUlQy2TM3PZMnRVQ1eHzv7tZChTjYGAUpYK
	 5rjIOl+kGt9fV0ruN3IkDiHN78H0wW6m4rxcLIxHP5bueH1MbBWdJXCW8KclvSlw/E
	 NyyDtTE8ZoMz1nJRKZNonHppUVkdK7mv+8Px297LBx1RECgAPUEcg8MHOP+sQ7uVJd
	 hyYm5Soq2Y0bJvcEGJBidVI1rjZAkeY+3gKimZgrdAkVdAKaNqrCsbYjhbO2zPKadh
	 ox3UJzGXhqyQQ==
Received: (nullmailer pid 3601354 invoked by uid 1000);
	Fri, 29 Sep 2023 15:35:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: arnd@kernel.org, linux-phy@lists.infradead.org,
	linux-mmc@vger.kernel.org, dmaengine@vger.kernel.org,
	robh+dt@kernel.org, jic23@kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, olivier.moysan@foss.st.com,
	linux-media@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, edumazet@google.com,
	linux-stm32@st-md-mailman.stormreply.com, ulf.hansson@linaro.org,
	richardcochran@gmail.com, will@kernel.org,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnaud.pouliquen@foss.st.com,
	linux-serial@vger.kernel.org, alexandre.torgue@foss.st.com,
	Frank Rowand <frowand.list@gmail.com>, andi.shyti@kernel.org,
	linux-usb@vger.kernel.org, peng.fan@oss.nxp.com, lee@kernel.org,
	fabrice.gasnier@foss.st.com, conor+dt@kernel.org,
	Oleksii_Moisieiev@epam.com, herbert@gondor.apana.org.au,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	al@web.codeaurora.org, sa-devel@alsa-project.org,
	hugues.fruchet@foss.st.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mchehab@kernel.org, vkoul@kernel.org,
	gregkh@linuxfoundation.org
In-Reply-To: <20230929142852.578394-2-gatien.chevallier@foss.st.com>
References: <20230929142852.578394-1-gatien.chevallier@foss.st.com>
 <20230929142852.578394-2-gatien.chevallier@foss.st.com>
Message-Id: <169600172184.3601218.2121908606358610119.robh@kernel.org>
Subject: Re: [PATCH v5 01/11] dt-bindings: document generic access
 controller
Date: Fri, 29 Sep 2023 10:35:24 -0500


On Fri, 29 Sep 2023 16:28:42 +0200, Gatien Chevallier wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Introducing of the generic access controller bindings for the
> access controller provider and consumer devices. Those bindings are
> intended to allow a better handling of accesses to resources in a
> hardware architecture supporting several compartments.
> 
> This patch is based on [1]. It is integrated in this patchset as it
> provides a use-case for it.
> 
> Diffs with [1]:
> 	- Rename feature-domain* properties to access-control* to narrow
> 	  down the scope of the binding
> 	- YAML errors and typos corrected.
> 	- Example updated
> 	- Some rephrasing in the binding description
> 
> [1]: https://lore.kernel.org/lkml/0c0a82bb-18ae-d057-562b
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> 
> ---
> Changes in V5:
> 	- Diffs with [1]
> 	- Discarded the [IGNORE] tag as the patch is now part of the
> 	  patchset
> 
>  .../access-controllers/access-controller.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/access-controllers/access-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/access-controllers/access-controller.yaml: access-control-provider: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230929142852.578394-2-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


