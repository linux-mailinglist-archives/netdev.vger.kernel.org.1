Return-Path: <netdev+bounces-118905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B37953776
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E23CB20B90
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796E1AD9E8;
	Thu, 15 Aug 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoX/suEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C71AD3F7;
	Thu, 15 Aug 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736498; cv=none; b=KjGI5tF38vYDbRMA/ErMCcmFjsSovUtowePlI1wCOgiAZcVjaVxX7Z5JVB2Gokr5irfoYY6DUDFpqn0URhMf/TcVlqJEFn+oCyDBVrU6sF8Vz5LpFh/1SqWZm62zyROZ7Zp8varKH/iULl1NgsdqHIHxPcaflO4DGxk4qh86pZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736498; c=relaxed/simple;
	bh=IYrPvjIPCrdK+O+khvX9GO/S0HHhbYIZlD2G7HwxwsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJAZAM6aBN9+UAWMGEh7P606aEfGoM6MYfOKzUxevTwQMHi8Xu75ZR1PXgvm/ILZveJshoNL7tnWjHSFWPnGy4K9faFfsgkjlWIPtx4WQIPCFo5AknOZsvIA7ckrOyPHI83MgfkbcZK3bsIl3AzG3u6/4IPomZCATTM0+hG8pOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoX/suEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9565DC4AF09;
	Thu, 15 Aug 2024 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736497;
	bh=IYrPvjIPCrdK+O+khvX9GO/S0HHhbYIZlD2G7HwxwsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoX/suEqbFCc9eipy4uawl816ieuugHDnZOH1Dy0CJALZwXYXjqlDAARjT4/Ck1BW
	 ipbp9vep6vC08m/Deegkfa/yeLqN2kXtlLPnA8TIioC1DqNE0TSFpQfSDg5kXS49Dt
	 RNc3TiiPTzk8PvxlfkmhuMkS256BvDL/xoiU05eWQX+sEq21GxZdKnLoiTvPEMslWY
	 l9MdQe8mN4uzyklODWBBQq4BRVlgjLYqimm6dX7IXAkSki/SM+xRfVykwkktln0iwQ
	 Im3xvPG5lEFMYUqOZdNel1W+iJI6ttaC623yUMbei6WMTtUSPqvCyhvuCYC4T1gsFm
	 +IAguXMYrhsew==
Date: Thu, 15 Aug 2024 09:41:36 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: soc: fsl: cpm_qe: convert network.txt
 to yaml
Message-ID: <172373649432.1956601.11486565362846539757.robh@kernel.org>
References: <20240812165041.3815525-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812165041.3815525-1-Frank.Li@nxp.com>


On Mon, 12 Aug 2024 12:50:35 -0400, Frank Li wrote:
> Convert binding doc newwork.txt to yaml format.
> 
> HDLC part:
> - Convert to "fsl,ucc-hdlc.yaml".
> - Add missed reg and interrupt property.
> - Update example to pass build.
> 
> ethernet part:
> - Convert to net/fsl,cpm-enet.yaml
> - Add 0x in example, which should be hex value
> - Add ref to ethernet-controller.yaml
> 
> mdio part:
> - Convert to net/fsl,cpm-mdio.yaml
> - Add 0x in example, which should be hex value
> - Add ref to mdio.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> This one is quite old. The detail informaiton is limited.
> ---
>  .../devicetree/bindings/net/fsl,cpm-enet.yaml |  59 ++++++++
>  .../devicetree/bindings/net/fsl,cpm-mdio.yaml |  55 +++++++
>  .../bindings/soc/fsl/cpm_qe/fsl,ucc-hdlc.yaml | 140 ++++++++++++++++++
>  .../bindings/soc/fsl/cpm_qe/network.txt       | 130 ----------------
>  4 files changed, 254 insertions(+), 130 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-enet.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-mdio.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,ucc-hdlc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
> 

Applied, thanks!


