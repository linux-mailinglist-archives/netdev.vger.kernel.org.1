Return-Path: <netdev+bounces-195889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01FAD293F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5826216FF06
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10F19F137;
	Mon,  9 Jun 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViFYqRKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2E8F40;
	Mon,  9 Jun 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507329; cv=none; b=PGSe1coACVhOQfk2BCJLiQm7nOZvIrrump1nSZpdaZ5QHyxic37teMeC/pG9HdLsyc1DGWiLrWhS0Ucf4EpqLE5FdQ9ATO8tJ9n/kdQfTrwiM+2uvxqYkl3BbHhxWpZ0hTKe/Vs+aCnIXuxlYHoykYaxx9etMLhNRUGwDe+eDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507329; c=relaxed/simple;
	bh=tdY7TyGTZciMTHoVs1nvnp6Q2CPWWnRP9rTcNFBGtKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh2WIAYWKTHaDp0QNBxJvjrvW/100LbpMbg46cnrUVh3+jiHRqMTqjc/Q/Xgl5hyyDntTJzFYdBYLeOQdvVwLRD3Umnz8oW0DusB0SdWXdKs9kwFxgKdUlScbL0Z+Cs9REMyTni2+n70sUd41KNw+UaRWFUWmT1F/XIliSPQnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViFYqRKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97853C4CEEB;
	Mon,  9 Jun 2025 22:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749507328;
	bh=tdY7TyGTZciMTHoVs1nvnp6Q2CPWWnRP9rTcNFBGtKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViFYqRKQ+8RHKDEt42aecvXrqhliLmgkaI/8JfVZPaVUeShtWjjuknJDCcSPz6zRu
	 CetijwvqM6R1L49jdg502EEahptkdkenRMgWHoUYC58p4/MnYKOLYKxCQWAP3RBvQf
	 8rwfyYymeeH9CerMuanuzhO2pCh0mErgs1n5w6lpCbzxT5i/4P4mn6W6rnvdRDYDKo
	 JqghL8I1mq/4gcWoMddVfxyiD28eyT0GfDQy7sUL86vhehveyN6vX27yfSAylaXTfv
	 Cq9MCIZNZWvc4A9ljdNXVWAWvnvEsFEkTRrZi8tpTV02irtcpEPkVPjASwaZKA7UO2
	 0nVjitEQcw/bw==
Date: Mon, 9 Jun 2025 17:15:27 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH v4] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250609221527.GA3045671-robh@kernel.org>
References: <20250609163725.6075-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609163725.6075-1-matthew.gerlach@altera.com>

On Mon, Jun 09, 2025 at 09:37:25AM -0700, Matthew Gerlach wrote:
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v4:
>  - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
>  - Updated compatible in select properties and main properties.
>  - Fixed clocks so stmmaceth clock is required.
>  - Added binding for altr,gmii-to-sgmii.
>  - Update MAINTAINERS.
> 
> v3:
>  - Add missing supported phy-modes.
> 
> v2:
>  - Add compatible to required.
>  - Add descriptions for clocks.
>  - Add clock-names.
>  - Clean up items: in altr,sysmgr-syscon.
>  - Change "additionalProperties: true" to "unevaluatedProperties: false".
>  - Add properties needed for "unevaluatedProperties: false".
>  - Fix indentation in examples.
>  - Drop gmac0: label in examples.
>  - Exclude support for Arria10 that is not validating.
> ---
>  .../bindings/net/altr,gmii-to-sgmii.yaml      |  49 ++++++
>  .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
>  MAINTAINERS                                   |   7 +-
>  4 files changed, 217 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml

altr,gmii-to-sgmii-2.0.yaml

>  create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
> new file mode 100644
> index 000000000000..c0f61af3bde4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright (C) 2025 Altera Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera GMII to SGMII Converter
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@altera.com>
> +
> +description:
> +  This binding describes the Altera GMII to SGMII converter.
> +
> +properties:
> +  comptatible:

typo

> +    const: altr,gmii-to-sgmii-2.0
> +

