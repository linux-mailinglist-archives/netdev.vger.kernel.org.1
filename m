Return-Path: <netdev+bounces-203759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956DAF70E2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DAB520E47
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CF2E3382;
	Thu,  3 Jul 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAZOlH4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1012E2EFA;
	Thu,  3 Jul 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539787; cv=none; b=o9U7NLTJ1mZEGFvwhnA7mwXVQVOtf/xb+GhB8/r2Vz7ocF8/xiBZeJzYaGpxLCjK5mONDRxJsbb6vH0Geiwhmj4keEfps/hoYT22KrUtIYpdAX5fqOOQDvjD7YJICVeLcLMgsOsFNzihIRERg83ZjtOyJwpUR70AjKYKXwEDCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539787; c=relaxed/simple;
	bh=wY2wfTZ564kxU3kdTgduWjVJsd6vAkmmNurNo83Nc0w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=P+XOWQGo4XvjPLY0vlv5m9/0dKoJnpPq3wZ+VCkdUlLeHCZ0qYGPQ22PxsYvJhaDTFhMRPD2WH3zQHQYvQZOpFMpIByzdiXSUL6gURyg2K19I5wP6f2ag6Cmf2bctb2q5M9Gm4TDUAVZ9c6HHH8L3RNZ+cejahETG0Zi9DZaWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAZOlH4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41727C4CEEB;
	Thu,  3 Jul 2025 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539787;
	bh=wY2wfTZ564kxU3kdTgduWjVJsd6vAkmmNurNo83Nc0w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aAZOlH4nEDKkEb6zqJb1QxtLz4Pa37sjKxvukafYYDepwMAn5C5LFEHUcMSQIfgzC
	 S03OJoeuPoeGcxSHkf7ElsVygB4ibRWdcSRUlSgxrQoNQFf4PwZq3dwRT5qUFwhLpW
	 RIOaKONd1uWCZfQPFOSF+b9aCoTE7MVUP/3f7JJKkNNjeAuGiER20ah/UTHYftqIy7
	 GMH0nGZKUQwR21vqTJbZxQZXXSiqyObDDjkwVAKIVsMjjmqffZjAQdGRAQsf3Q+99w
	 JJkrbq0SIOvudi46oWIIqLC21x67fjPuEhl71lc+LvNfoRVy57s94kL31c9guzN7Rj
	 9T2k5+g9JSu6A==
Date: Thu, 03 Jul 2025 05:49:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
 linux-riscv@lists.infradead.org, Simon Horman <horms@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Vivian Wang <uwu@dram.page>, Yixun Lan <dlan@gentoo.org>, 
 spacemit@lists.linux.dev, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn>
References: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
 <20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn>
Message-Id: <175153978342.612698.13197728053938266111.robh@kernel.org>
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: Add support for
 SpacemiT K1


On Thu, 03 Jul 2025 17:42:02 +0800, Vivian Wang wrote:
> The Ethernet MACs on SpacemiT K1 appears to be a custom design. SpacemiT
> refers to them as "EMAC", so let's just call them "spacemit,k1-emac".
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/spacemit,k1-emac.yaml  | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/net/spacemit,k1-emac.example.dts:36.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/spacemit,k1-emac.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


