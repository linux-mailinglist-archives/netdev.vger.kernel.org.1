Return-Path: <netdev+bounces-207751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E1B08730
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45193B6556
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271B25A34F;
	Thu, 17 Jul 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMajonpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF224EABC;
	Thu, 17 Jul 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738153; cv=none; b=UWZbjyXbkR4KT0YHpeQ+ABnPLk73uKYqAt5VP6pUrbTWNuhQwPtEe8K4Tml8N27WjzRfkGcWXRjXA8k0OsOpneoF8tnjBuIaO/bfPM8b4LdHYS5zkPl0mbJZIbM3q1zmulJbWeoeSnfLq35Uielkwv19JN7OHGu7XnQ5s623qWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738153; c=relaxed/simple;
	bh=gN/m0/5r5AMCq+79cgsCYOoCKxYj3JUcZO98xYntTqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdHhyx28K6YJXxiRBWBvNBuGqwu99TrZbL2ypew+I8cIM3oTw35borfjYE7lu1CMT4tUiT70e1s9HMqtmhGjIAjoTPcLEYCBmiIisleUQzVFcAUZMOGmzrNRp8K0U72N+Ndadu33QLnGkRRNF+46E7UAxVN4RcjoDakIQ1d9mSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMajonpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68590C4CEE3;
	Thu, 17 Jul 2025 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738153;
	bh=gN/m0/5r5AMCq+79cgsCYOoCKxYj3JUcZO98xYntTqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMajonpaZxgx63F2DnEkcejYhTcgO4pXFfGPU9izLgv7RqIjk20zRn3pMaTeU+ov7
	 E0wlPW1N5P+wAr9Ktr7MxU7ZDRIShfxIaNYn4AefuPhYyU62Jqu1+d9fICRVWEqKCN
	 Cte2InCG+cuFFGfsu/ZJx4MH3UomT006pjyXIla//lIqG+EOXcycxITH/pCaN90HF1
	 6IcLPEwf71gj5ZppD+kYF+NdExyf/ew3RVjOel/PQ2ehuxs+QMAhoDkQIr/0pxDoXs
	 C+faoKDf8SE0vFTZ5Neom5Ob46HuwKKzWeG/xYRspIpJXCIouiv9K6ohTu7656w/bO
	 gj856S93FLuiw==
Date: Thu, 17 Jul 2025 09:42:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, 
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev, Frank.Li@nxp.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Message-ID: <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-3-wei.fang@nxp.com>

On Wed, Jul 16, 2025 at 03:30:59PM +0800, Wei Fang wrote:
> NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
> that contains multiple PCIe functions, such as ENETC and Timer. Timer
> provides PTP time synchronization functionality and ENETC provides the
> NIC functionality.
> 
> For some platforms, such as i.MX95, it has only one timer instance, so
> the binding relationship between Timer and ENETC is fixed. But for some
> platforms, such as i.MX943, it has 3 Timer instances, by setting the
> EaTBCR registers of the IERB module, we can specify any Timer instance
> to be bound to the ENETC instance.
> 
> Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
> specified Timer instance so that ENETC can support PTP synchronization
> through Timer.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> ---
> v2 changes:
> new patch
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index ca70f0050171..ae05f2982653 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -44,6 +44,13 @@ properties:
>      unevaluatedProperties: false
>      description: Optional child node for ENETC instance, otherwise use NETC EMDIO.
>  
> +  nxp,netc-timer:

Heh, you got comments to use existing properties for PTP devices and
consumers. I also said to you to use cell arguments how existing
bindings use it.

You did not respond that you are not going to use existing properties.

So why existing timestamper is not correct? Is this not a timestamper?
If it is, why do we need to repeat the same discussion...

Best regards,
Krzysztof


