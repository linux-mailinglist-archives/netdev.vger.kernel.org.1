Return-Path: <netdev+bounces-195924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45150AD2BF6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 04:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4841893759
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 02:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C190125E46E;
	Tue, 10 Jun 2025 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtPCtTdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80119219FC;
	Tue, 10 Jun 2025 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749522659; cv=none; b=EfspWV4l5nlhX4oCCUBk3HV0GoHCXMd6Rjoxx6uuawIZHUaQx0iPAr9njqjgc91kjCOXYVys15MycS2ggv5zMe02Vm7y7gdE5EwKjZVojZ+cEM4CsRNlI/77CvAPdPoj930qkBZgPuXB/1iwAjEDEjoNeQ2mUFfs9r1vzqzF0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749522659; c=relaxed/simple;
	bh=MF9eFED5nRvQBjnkQkaYBoOXrlZbPXE3oEhI6hM3hIM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jCmIBHnDp6LsUcnexYSs8Gze+iEQEHRMchhvj6CqriYmVL+BPYrLEcbPBUMDOVtLz3UdcZ0jkyyWjNeBD9NW1BP1xtOFdLIa+VXwMDp6c+8exXrk5jP2JlImVGwcwiput8Pfa72Fep768FJZwgahEVmk+XUVSyngf860xBoRMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtPCtTdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B1BC4CEEB;
	Tue, 10 Jun 2025 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749522659;
	bh=MF9eFED5nRvQBjnkQkaYBoOXrlZbPXE3oEhI6hM3hIM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QtPCtTdAWiYNrWfnLL1Egie323Tgg630GTtlhtKZVSX9uBqa1Gr88E9RsbxDT91td
	 g8N2E1mXP6KQ3i2S6j5SfrRj0MaXKnbtvuE83BlJUxGGpTiVbnl2rxiJMDCs4KEyTx
	 8GoA9PljkQes7HFBNnlOgpA+P9Osn1lcp/7BumzmdOTDsooqKlOoMYKrU0N+NtBleL
	 XDFNcpnclJnjOq5Ft8al8OYLgep4MJTJBH3B1r74QqveEOOgVHBzBa3R7cBj3KbHtg
	 aOW4kofCS51lkO8XkZR1GLTWMCjnZ4wICUfyW4BwQFGxs5B6ZFfvE6OYVB/idqhdt2
	 m/aI3IhosKoyA==
Date: Mon, 09 Jun 2025 21:30:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, mturquette@baylibre.com, 
 BMC-SW@aspeedtech.com, linux-kernel@vger.kernel.org, kuba@kernel.org, 
 krzk+dt@kernel.org, p.zabel@pengutronix.de, sboyd@kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 davem@davemloft.net, conor+dt@kernel.org, joel@jms.id.au, 
 andrew+netdev@lunn.ch, devicetree@vger.kernel.org, pabeni@redhat.com, 
 andrew@codeconstruct.com.au
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20250610012406.3703769-2-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
 <20250610012406.3703769-2-jacky_chou@aspeedtech.com>
Message-Id: <174952265793.3644019.286629373000016480.robh@kernel.org>
Subject: Re: [net-next v2 1/4] dt-bindings: net: ftgmac100: Add resets
 property


On Tue, 10 Jun 2025 09:24:03 +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and
> RGMII/RMII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/faraday,ftgmac100.example.dts'
Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/faraday,ftgmac100.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250610012406.3703769-2-jacky_chou@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


