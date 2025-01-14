Return-Path: <netdev+bounces-158302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9944A115C2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB83A5312
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FFC22331C;
	Tue, 14 Jan 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR4jv4Vq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2D222594;
	Tue, 14 Jan 2025 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899079; cv=none; b=fjQ8l7fPogsjglre3x2VRKdH9gfBle1O1zlgUFVuhxbfc80FMlcD/PdguIrujND/1R9HJa94cgT5/3KwIyA89cnZADPIhZMwct6awCqg6PHaLVrSk4a6Z5p6NnK2COhNMprQ0y84r9BurY8LiAnFEynsbeC9GM68RAzu0X6vjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899079; c=relaxed/simple;
	bh=tpzPtlhfSg1oMQzL2Ct27bJY5cpUAeZYKUcwY61RUAs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jqsh214T6v2YZk7REcgdIb5D58B+jMx4MWQcqGPO7aSXHCHOf2jQg/FPexVxbfTe+Sjnv42O+Amm5O9kcj6PlT0PC5KtQpM6ZJl2oIODg5SPrasFh1X66dK+DNne8mJ+RRSWp5kvSGG6jZMfO2ZGjUh4ez90IHhU6hs2w7Y1JvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR4jv4Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EA0C4CEDF;
	Tue, 14 Jan 2025 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899078;
	bh=tpzPtlhfSg1oMQzL2Ct27bJY5cpUAeZYKUcwY61RUAs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YR4jv4VqMwHB30SIKNMX6+CkulB9Ga/HxazCKrQ9IEhW3b/hkvOihD10wmNx5Zwep
	 xgfu+TfRDvQSNWzq+8nyUNAmlBR4NBhplr8wvhekLzglPGcNjTNu9GPdn6wVp4yCMJ
	 cB+8b70SUbUZECxB/C9SOvcS993DDbrPCKVhNekVJsEnDJ23Rywpi2j2yI8IRb8KSi
	 ndbzYFzP7E/ezdJa8n1pRKj9+3TwSEnWczBn2EHciN9COm2PPFSXlCg3fUbT5VkQIs
	 t4uAsa9uobHF8IBR1P+LB6GGxx3R0XxsgDAoDKZjatJ1Nc5cGFNhYhFuvAIUy2jqGB
	 FVzZJOsLOGrOQ==
Date: Tue, 14 Jan 2025 17:57:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, 
 linux-arm-kernel@lists.infradead.org, edumazet@google.com, joel@jms.id.au, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 davem@davemloft.net, kuba@kernel.org, 
 openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, eajames@linux.ibm.com, 
 minyard@acm.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114220147.757075-4-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
Message-Id: <173689907575.1972841.5521973699547085746.robh@kernel.org>
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing


On Tue, 14 Jan 2025 16:01:37 -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250114220147.757075-4-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


