Return-Path: <netdev+bounces-104474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0A90CA68
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1075E1C2336C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6F14A4C8;
	Tue, 18 Jun 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btHUdzlO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AC1482FA;
	Tue, 18 Jun 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710363; cv=none; b=gWZBvZatQ0W6DOf6H/e28GYoOKoltsDpWBNgbs+kJvSID8S/v/gJ2pg/xkKYoEM2t92nh5KzrK+dFtAMyPbq64Kfbi0cEHEMOEAegQG/4erYmfvw3u7Y6KQ0PiCKQUwW9Tr8F9DDWcby/N7h4xgyiuxqYxvHvzLHjUhO0KM22LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710363; c=relaxed/simple;
	bh=wpiKeO63IemTjXmi+1WwztXiYOdPdtVXvk0tyn5Fhoc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pGIuyCzMwU6LN2gJI7Bn57jHm9rMHIumZYgZpFIbV8cyTfydDr20wCaMmXiz3673d2+ZQ7bhyPy4npp2GMMjBj0ucWvGpU455RNkFNPb+doOURPYBdQpQHJweFYAeDpa3or8ZLElz0QiUHj+wcRMTIKmwtqcvlUEoLS2KvJHxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btHUdzlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081D7C4AF48;
	Tue, 18 Jun 2024 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718710363;
	bh=wpiKeO63IemTjXmi+1WwztXiYOdPdtVXvk0tyn5Fhoc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=btHUdzlOT+VIyKTe3je22pK3+5vLZQ9K23c0u0il69gOCNjGuR7SvF/1Eje2MfJCp
	 TWZyP45WcdqzYLuIz1RsT+JtydlkyZOia/SCXgY2bX2FMmNFDE8ijJx/Pm70v57ghV
	 kRgSslxat16tz4K5jrY04W+U9ixvCDHydDequFp7qfpc7C/3SDZymFckE5oS28M4vY
	 zfrKO01134c/qC7LCNfFMpD708yMBZLo8MBT5zkmvuDn8fCLbZfHVVjOzzM4rfZbQp
	 NmPh/trp4K+QiUbc9/2ira4SQYWfZFIaD4pivLgTX3pu2Ip65un+covBoOCsh5Szb5
	 tswRK/LL0CfbA==
Date: Tue, 18 Jun 2024 05:32:42 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: lorenzo.bianconi83@gmail.com, robh+dt@kernel.org, upstream@airoha.com, 
 conor+dt@kernel.org, edumazet@google.com, conor@kernel.org, 
 davem@davemloft.net, pabeni@redhat.com, devicetree@vger.kernel.org, 
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, rkannoth@marvell.com, 
 benjamin.larsson@genexis.eu, kuba@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, angelogioacchino.delregno@collabora.com, 
 sgoutham@marvell.com, will@kernel.org, netdev@vger.kernel.org, 
 andrew@lunn.ch, nbd@nbd.name
In-Reply-To: <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
Message-Id: <171871036213.1272776.17317814792121610122.robh@kernel.org>
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller


On Tue, 18 Jun 2024 09:49:02 +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> This patch is based on the following one not applied yet on clk tree:
> dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
> https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428d4c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/
> ---
>  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/airoha,en7581.example.dts:27:18: fatal error: dt-bindings/reset/airoha,en7581-reset.h: No such file or directory
   27 |         #include <dt-bindings/reset/airoha,en7581-reset.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/net/airoha,en7581.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


