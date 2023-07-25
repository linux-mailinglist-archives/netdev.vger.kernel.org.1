Return-Path: <netdev+bounces-20974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CD762089
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687882819C7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7F2592C;
	Tue, 25 Jul 2023 17:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDED25140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4F6C433C8;
	Tue, 25 Jul 2023 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690307369;
	bh=w7dbONTIy2Co3mAFj/AcsnLbCERRs5c4tblF0g/VRPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qRmvy9rHWcDnpixwhpi8DTuQcPdUyIZr5ZNx9ydG3F5boc73mSyEcLxTRGyRsCrB3
	 vClccnArnxXoaiGAgIdoaS2+TOFRAoqZK63Wk0bXfrXFknhfb+CydSPKk0rOsuu3hH
	 TLEWzXb38mM81F0bbsLAvvpzt0taCiE7A8213w6F+7Ut1V3wYK9UY5byb1RK9gdLLH
	 A8/Iy7F8eWp47Q1Fq/3T9a96ynyIDqiSA2oI0PcsUAwZGhiXzTUnrxDNnd0AH129MP
	 pymfYyEwQoff+K9nqQse31QUqBocLgoqy3MvVJHBF8sdscLUh2TInqE0lKi9416xVB
	 K25mir6FU0ktQ==
Received: (nullmailer pid 3497934 invoked by uid 1000);
	Tue, 25 Jul 2023 17:49:25 -0000
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
Cc: kuba@kernel.org, will@kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, linux-spi@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, lee@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, arnaud.pouliquen@foss.st.com, Oleksii_Moisieiev@epam.com, arnd@kernel.org, hugues.fruchet@foss.st.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, alexandre.torgue@foss.st.com, pabeni@redhat.com, andi.shyti@kernel.org, netdev@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, edumazet@google.com, vkoul@kernel.org, dmaengine@vger.kernel.org, catalin.marinas@arm.com, herbert@gondor.apana.org.au, fabrice.gasnier@foss.st.com, mchehab@kernel.org, linux-iio@vger.kernel.org, richardcochran@gmail.com, davem@davemloft.net, conor+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.
 org, alsa-devel@alsa-project.org, linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, olivier.moysan@foss.st.com
In-Reply-To: <20230725164104.273965-2-gatien.chevallier@foss.st.com>
References: <20230725164104.273965-1-gatien.chevallier@foss.st.com>
 <20230725164104.273965-2-gatien.chevallier@foss.st.com>
Message-Id: <169030736341.3497818.1740404012211043486.robh@kernel.org>
Subject: Re: [IGNORE][PATCH v2 01/11] dt-bindings: Document common device
 controller bindings
Date: Tue, 25 Jul 2023 11:49:25 -0600


On Tue, 25 Jul 2023 18:40:54 +0200, Gatien Chevallier wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Introducing of the common device controller bindings for the controller
> provider and consumer devices. Those bindings are intended to allow
> divided system on chip into muliple domains, that can be used to
> configure hardware permissions.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml: title: 'Generic Domain Controller bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725164104.273965-2-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


