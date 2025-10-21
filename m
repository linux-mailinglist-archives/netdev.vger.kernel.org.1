Return-Path: <netdev+bounces-231393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E2BF8BC9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750FE426CAC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A922327CCF0;
	Tue, 21 Oct 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5nmKkED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FEF266584;
	Tue, 21 Oct 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079119; cv=none; b=L4gNLdG2Imqlu4p5Hul7ughNEzZdhzUng5zOBK5TjlN9lBjghUlbR3+xAnoNFkyK3ycF0GNO2t8ZM3VUfxXJqzn3klH2p5htWuPXfz0zVg/MVcjYvWN+BYyf9XUC8WMuGv5E/9TasF2hEYzl0Jwczeh4alP77GlGmmM4HKfZfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079119; c=relaxed/simple;
	bh=xyumwPl30ONfVpygpOsANWfqQ6zL+CFhHbz/wrjnXZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM4EBVc70AlSc/sgDxR/WlsJHkNa1Mf52n9QirXL8Y79qtDk4GYz2w8c2XUhEVxNiJeOs5TJ7UNvqTfMwZpfEDbrMFxqi8uucbLOKJiMBj5iSMJ7rA7IEEQgARUdSA2pYk8ignNeY2o6bKQGRFKzM7vlhLWM6LH/MQWIgItjlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5nmKkED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C7C4CEF7;
	Tue, 21 Oct 2025 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079119;
	bh=xyumwPl30ONfVpygpOsANWfqQ6zL+CFhHbz/wrjnXZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5nmKkEDRJHFaP+t6tHpF1Fz6BEGKwprNB+kVEm84f5YASXW2LlucA2GhXAe8EgBy
	 GfPr7HyEv+D1+mcpH2BDc2J6IFwp7u0fzwIwYjYYhy9quGSXyhSmBx7ezidoW7NChv
	 P0d6Q9t3W/pPG04I5+P/HaXdifMOu2CUZBRfZg7o/5FZJkiQxprMwU1a9SIr7QfYMd
	 ALQcBvZslt7LcsBs1gffNSGDtFgtuEVVMbtEdNFF8C25ExIpyeuBbGxnZ4tugTeTjT
	 vt1U176/pGk/PBQ5NAf+trUe8RZ4kkg/5pmszl4uWnEBYvAmqizi49SsKfIWf9IMv0
	 H8A+4v2dvRb8Q==
Date: Tue, 21 Oct 2025 15:38:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: pabeni@redhat.com, linux-kernel@vger.kernel.org, kuba@kernel.org,
	krzk+dt@kernel.org, netdev@vger.kernel.org, Frank.Li@nxp.com,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	richardcochran@gmail.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, conor+dt@kernel.org, vladimir.oltean@nxp.com,
	davem@davemloft.net, edumazet@google.com, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: enetc: add compatible
 string for ENETC with pseduo MAC
Message-ID: <176107911426.776450.9549460321528011782.robh@kernel.org>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102020.3218579-3-wei.fang@nxp.com>


On Thu, 16 Oct 2025 18:20:13 +0800, Wei Fang wrote:
> The ENETC with pseudo MAC is used to connect to the CPU port of the NETC
> switch. This ENETC has a different PCI device ID, so add a standard PCI
> device compatible string to it.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,enetc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


