Return-Path: <netdev+bounces-170871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D68A4A5A8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB53B7E0C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774791DE2C2;
	Fri, 28 Feb 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8r9Chhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472491A254C;
	Fri, 28 Feb 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780487; cv=none; b=J+ZMb0wV9au1rPEUABCdxmEJnSQXXcHq20T3S+fwOmmnjSfFguEqfyXJJigKPUSun8AjnA5FATuaVuDA1PFyom40QSgQqUc7Z7V1kplzlEzPxS1/0TrFIXeR7xbTUw0VjHyzA6yS5UmdBIVrfPiQFd11KzdaQE7lN9xkLZmgBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780487; c=relaxed/simple;
	bh=z8vdHh5U09vn686dTTiaeqn6j89eZ0MVs/V87u6spGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLCKl+cvjjq9RbShz9pfOXVYVjhSHBmiA989kf2wdjUEeS8N4+99kxGN5/yRruG1M6ZQoFbaPtFO1kfWtYyU5ai+y238Cfli/lzj4gQ0Rq0qcpV6LDj2vrD441jb9V0ST5PTXiC8X5J3laQrfySlSgb56Ix7dF5165JR5k3AQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8r9Chhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F73AC4CED6;
	Fri, 28 Feb 2025 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780486;
	bh=z8vdHh5U09vn686dTTiaeqn6j89eZ0MVs/V87u6spGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8r9Chhc2XYy+O/Zfty0uSGUWvEuLZUQsKbhn+iEJexYxeEgqzsQu1HqNV0V7/qi2
	 k+sp+pcEaIy/dMGb/Og+WZxoeL4cIQQPIDdcXqpgbtDFXtYUPzVJ3Ucq1yL6vcUTu8
	 iMSxlAM3vwZChl1+9bAfTii5ajhVKRhJc2ELqv3CcKw2mjSe4Ko4vZZFiGf/XTnhYW
	 jlCTntMv96rI19KnXmxj29GQCgmIe6YNEJLXRwQc+l4batcktetLeh33tQmrktG6Ah
	 cNq2ZNq8TgK0uNiUXsW3HMY7cxUOAQBgjkTORs/g2PEhQfOfGJTOseCkFERsGlbVew
	 umlNbdVQCzL9w==
Date: Fri, 28 Feb 2025 16:08:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <174078048176.3776808.10087708366850919575.robh@kernel.org>
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
 <20250228-gianfar-yaml-v2-3-6beeefbd4818@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-gianfar-yaml-v2-3-6beeefbd4818@posteo.net>


On Fri, 28 Feb 2025 18:32:52 +0100, J. Neuschäfer wrote:
> Add a binding for the "Gianfar" ethernet controller, also known as
> TSEC/eTSEC.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - change MAC address in example to 00:00:00:00:00:00 instead of a real
>   Motorola MAC address (suggested by Andrew Lunn)
> - add constraints to #address/size-cells, fsl,num_tr/rx_queues
> - remove unnecessary type from dma-coherent
> - add minItems to interrupts
> - remove unnecessary #address/size-cells from queue-group@.*
> - describe interrupts of queue-group@.*
> - remove unnecessary bus in example
> - consistently use "type: boolean" for fsl,magic-packet,
>   instead of "$ref: /schemas/types.yaml#/definitions/flag"
> - fix name of rx-stash-idx property
> - fix type of rx-stash-len/idx properties
> - actually reference fsl,gianfar-mdio schema for mdio@.* subnodes
> - disambiguate compatible = "gianfar" schemas by using a "select:" schema
> ---
>  .../devicetree/bindings/net/fsl,gianfar.yaml       | 248 +++++++++++++++++++++
>  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
>  2 files changed, 249 insertions(+), 38 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


