Return-Path: <netdev+bounces-15635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE844748E0E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4D01C20BDD
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2B154A5;
	Wed,  5 Jul 2023 19:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628A156C0
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:39:46 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3A71732;
	Wed,  5 Jul 2023 12:39:43 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77acb04309dso353633939f.2;
        Wed, 05 Jul 2023 12:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585983; x=1691177983;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OR44xsl8dcDDRHket6JLRoRPh10jvQanfxZD4Qq5o5A=;
        b=a0CEu5mqjWGo8IGRyJ6e667dY3I/m6XXzpZ51tZxpu8RysCYjJU+tN6Pmka10t+tNL
         oooNFqm83WP8oryCBd8YKBj9BGnVaA9OJp1YeceXV9c20ivZJK6m0jULeeECNW/v4GG9
         x8dCy734zSFeG39mJzXskDlPq5eZtaJ+lGTdENV6NPvjk6UoBywYPERS2lDOF5BJFYp3
         kJ+DjiwGB/OgmAVLJvysrHDOJSw+JkZTes4lHWGKWo/RqD2xbITtUJZHuTLoO01u2VQB
         IzhWhU7AKfZVJpNIPEp9FzfucL57i3weprBCaPDmCMWC9t7laGKYAoKamyGJQhOZlKRp
         nh+Q==
X-Gm-Message-State: ABy/qLbAA2KurpshNzjgaeeDFzqBEK03cTCXm7X3AdjyVDtdNsxFYJrP
	9baxSsRd22kpom7bJP+cPg==
X-Google-Smtp-Source: APBJJlFTsATQZZbeDYi05vWkxMhLO+2kIHQFYrmGtwqcASMsu98qNuBpLmP0dT/ZyPLVLU0YF4GwxA==
X-Received: by 2002:a6b:f208:0:b0:77e:3598:e511 with SMTP id q8-20020a6bf208000000b0077e3598e511mr177308ioh.2.1688585983078;
        Wed, 05 Jul 2023 12:39:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638220a00b0042b1cd4c096sm3797893jas.74.2023.07.05.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:39:42 -0700 (PDT)
Received: (nullmailer pid 1714650 invoked by uid 1000);
	Wed, 05 Jul 2023 19:39:32 -0000
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
Cc: hugues.fruchet@foss.st.com, vkoul@kernel.org, linux-media@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-phy@lists.infradead.org, lee@kernel.org, 
	linux-kernel@vger.kernel.org, arnd@kernel.org, linux-serial@vger.kernel.org, 
	mchehab@kernel.org, edumazet@google.com, arnaud.pouliquen@foss.st.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, jic23@kernel.org, pabeni@redhat.com, 
	linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, 
	olivier.moysan@foss.st.com, fabrice.gasnier@foss.st.com, kuba@kernel.org, 
	andi.shyti@kernel.org, alexandre.torgue@foss.st.com, conor+dt@kernel.org, 
	richardcochran@gmail.com, will@kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-mmc@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	catalin.marinas@arm.com, dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Oleksii_Moisieiev@epam.com, linux-spi@vger.kernel.org, 
	linux-iio@vger.kernel.org, netdev@vger.kernel.org, ulf.hansson@linaro.org, 
	devicetree@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20230705172759.1610753-3-gatien.chevallier@foss.st.com>
References: <20230705172759.1610753-1-gatien.chevallier@foss.st.com>
 <20230705172759.1610753-3-gatien.chevallier@foss.st.com>
Message-Id: <168858597155.1714560.12250834903693245143.robh@kernel.org>
Subject: Re: [PATCH 02/10] dt-bindings: bus: add device tree bindings for
 RIFSC
Date: Wed, 05 Jul 2023 13:39:32 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Wed, 05 Jul 2023 19:27:51 +0200, Gatien Chevallier wrote:
> Document RIFSC (RIF security controller). RIFSC is a firewall controller
> composed of different kinds of hardware resources.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  .../bindings/bus/st,stm32-rifsc.yaml          | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml: title: 'STM32 Resource isolation framework security controller bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230705172759.1610753-3-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


