Return-Path: <netdev+bounces-250291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A987DD27ED7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED101300D826
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2A2D8799;
	Thu, 15 Jan 2026 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK4QyX8i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A71155C82;
	Thu, 15 Jan 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503955; cv=none; b=S4eV9KhNT30HNUC7E/BRvxRKsWZviBc+FU9CfVWf/QUZ6+ZZFL9AjNWlZ4DhDBN7G+wREkZLY+hqWKF4Ko52+94qtbXRlpKP/BUFrDHQdWAaXf0neYEyDUHZ6Q0/GYUclGPgS5P/wRzzlCkCIqngiusRd/zwFvCD3bDKyGKT4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503955; c=relaxed/simple;
	bh=MzywH0w+4lnXYaFWB87iA3nZr8/2XaYU0sS2uZemSPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMMWPIXRiZx/t8PcIC/vRZ5Cwk1GXbWCzgDImM4Q/y+rDrYNvLEAfRTUOZhU1TdG3cfNa5C0VYRjelJgmjXj3YAieS2y659cvU9jVoCUkwcrqk394TYvJTZaheCobbFlV5D/gktc9lmLXAelQmLI3LJhYAOlRf1D8yxZEMolMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK4QyX8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33A3C116D0;
	Thu, 15 Jan 2026 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768503954;
	bh=MzywH0w+4lnXYaFWB87iA3nZr8/2XaYU0sS2uZemSPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mK4QyX8i9ylSLLCLPgvs3rh0jWqyMJona8tud81uLfFe4p8T4t2I9OFwwdF3M3419
	 qsBvryPPwG/tOpmT5BvBEStRKdvXvJUz5nMuFs7ynhu9jKoCPlOwTRCpn96mo81dHM
	 hhCNAg9VE2VW3iImEe7XMU4qFI8eoB8kZ1R/exObAZJQs67gdiRPvYuZxTbCgLJVew
	 oUSVLlHerzcam8ZZCQnwvdLu7ChR70FwiqJ5XcLC8ZS/+AUYeD/vZN0brrs6SPLQMV
	 K1Ph+SVUVX2wMiI1VjrFx6CUItPzuc/YUJdf+oWBKT9CkCvi8Rm+WLj+2+lgI89LC7
	 wFIcPcPLVoXjw==
Date: Thu, 15 Jan 2026 13:05:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <176850395318.1027117.16638961292490952236.robh@kernel.org>
References: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
 <20260114104509.618984-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114104509.618984-2-alexander.sverdlin@siemens.com>


On Wed, 14 Jan 2026 11:45:03 +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add new maxlinear,slew-rate-txc and maxlinear,slew-rate-txd uint32
> properties. The properties are only applicable for ports in R(G)MII mode
> and allow for slew rate reduction in comparison to "normal" default
> configuration with the purpose to reduce radiated emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v5:
> - improved options' descriptions on Rob's suggestions
> v4:
> - separate properties for TXD and TXC pads ("maxlinear," prefix re-appears)
> v3:
> - use [pinctrl] standard "slew-rate" property as suggested by Rob
>   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
> v2:
> - unchanged
> 
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


