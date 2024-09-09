Return-Path: <netdev+bounces-126470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2497142B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23623B25776
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2271B3F3A;
	Mon,  9 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfDFa6AI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B81B3F30;
	Mon,  9 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875111; cv=none; b=PlFp64nJY7Dk64gIg1qO6OdhHrFC7eWGBWmX8B0i9k6lgTYhDOPmwoMVhVHTb5UYZaoZ3vbELq4LEp4vihe7mcbDGoc/DjzjCpsXRkKm594H1Tr7SkTnTFYRbqUPGak+OwMiPTyM2MHPcw8quu7RaNHQtrZXyEnQNOk0xL+VSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875111; c=relaxed/simple;
	bh=54pbPtwtXy7p6NyZnaXUwbtA2kzEgPEHVmssnBQsqY0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GHXVibiS6a3SavyuIIa2PiNVheC7K410ofv84uHy+hdO9+ln1/BBHf86mJ+STXOJeLVJxZuWr1QkIOBvObJ7e1OVXtDQ2av1/GS9Q1KI6TiCJ4LWhLOATTx3rX/NXGSuu9GOhpCsvPEYaNfUfLnNnodYiDPSPLA1ZxeR7WVIk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfDFa6AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DA0C4CEC5;
	Mon,  9 Sep 2024 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875111;
	bh=54pbPtwtXy7p6NyZnaXUwbtA2kzEgPEHVmssnBQsqY0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZfDFa6AISd4yyMVsoU9jEz3uUKGOtbSmFfyqm8Pm5sBlGso8zzXhXXFD0aAEOeP/j
	 kroeZitO5SlEsJvrUL/yr80tnmkaWNRRbnPwoKCKR9tj4bsfgwcCioGbs+XwXjkKtB
	 Sgg4btysp1xpT/vmlceZYVBfjvdpxLUk8LfBoirW+O07fJSrHOIp6MVUsNKnqMf91i
	 YB8QBXvg7GK7fFlDkjkShT76ZTOypR6+jC3tDQq8zmt725xO3FHWxlsV5vR0Sl3iG7
	 3pRtUvUgdoE1KOQ5zZeGepglksrd1NYFL7SFEW5LiB1byr5zivwTRvpT+kvcyVYy4+
	 zFBGtZXrVokjQ==
Date: Mon, 09 Sep 2024 04:45:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 netdev@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>
In-Reply-To: <20240909-ep93xx-v12-16-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-16-e86ab2423d4b@maquefel.me>
Message-Id: <172587510035.3289162.6115111158359186923.robh@kernel.org>
Subject: Re: [PATCH v12 16/38] dt-bindings: net: Add Cirrus EP93xx


On Mon, 09 Sep 2024 11:10:41 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC Ethernet Controller.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/cirrus,ep9301-eth.yaml | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.example.dts:25:18: fatal error: dt-bindings/clock/cirrus,ep9301-syscon.h: No such file or directory
   25 |         #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
make[2]: *** [scripts/Makefile.lib:442: Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-16-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


