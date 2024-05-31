Return-Path: <netdev+bounces-99725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DB8D60BD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5771F23C53
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81569157470;
	Fri, 31 May 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPduiQ7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D878173C;
	Fri, 31 May 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155194; cv=none; b=pfOYhYT5xV3ow+eGJSN0MNiMewdmhSHSYoJAdlpLyyflnbalFpkBOws9BOIiJfgNGqRE/T1IcNTD92LUVHdPKorU7FCGxrT/QB5UyX5cz1NR6mMt/pyry45XxZCK6etLpx38uH68dFr91U0ArGQcfTOWE+LI70bwWlOuqknriZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155194; c=relaxed/simple;
	bh=PDYcD/VuW+SV7ExAXgARgpwsN09SPWDnbp+i4nzDJQk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=q6sZJo2TlZvsmHbBS/56UtlaGiNSR9L+uerjTBvkS0FG2vJzBrh30aR/MBOWjB1FtoD0EllOHM8JVccOSmhuGZ5cLSauIAr7BjxittvLWsEN8m/+d2zqtzPzMbpEJZ+KzIOGFMXyNCCHyvionYDwgY60ZkP6v8xkRiQzTNhEVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPduiQ7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D70C116B1;
	Fri, 31 May 2024 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717155193;
	bh=PDYcD/VuW+SV7ExAXgARgpwsN09SPWDnbp+i4nzDJQk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JPduiQ7Gs3cA09tsRhbFzZJTWLRZtrjCKsLyR8Vc8iEeokYeV4ZdOqRaQ4pCeX8VH
	 crFPAUv5wtCFXOYhkrvH5+O3JT6rRwVOxERkoZqYsxFr7qjVd/AGNVizB20Ah7IpKC
	 8I+yKkI6U1hTFip6Wb6S06HJO9sOBUiOJdHpLy9EnMtGfCHYssb2pIaoES7qFYWMso
	 r4rR7DcEteT2pNVBRZD2JkcwEDzIRbkSjo+VKpGdUNWwyLGTnWOuJuDNkAXhyBNeNT
	 67siHQbO4DZtqT9IrE3aGztiE/mjrbZMgEktxXz13ka/DRjGeylwiN4lyWYIkhHaId
	 2dzA7NblT/Qwg==
Date: Fri, 31 May 2024 06:33:12 -0500
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
Cc: angelogioacchino.delregno@collabora.com, pabeni@redhat.com, 
 devicetree@vger.kernel.org, upstream@airoha.com, conor@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, davem@davemloft.net, will@kernel.org, 
 nbd@nbd.name, lorenzo.bianconi83@gmail.com, catalin.marinas@arm.com, 
 netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
 benjamin.larsson@genexis.eu, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
In-Reply-To: <97946e955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <97946e955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org>
Message-Id: <171715519233.1178488.4895515254191995557.robh@kernel.org>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: airoha: Add EN7581
 ethernet controller


On Fri, 31 May 2024 12:22:18 +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/97946e955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


