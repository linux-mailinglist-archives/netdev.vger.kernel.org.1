Return-Path: <netdev+bounces-239261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF7EC6674E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C4745297BD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1E52D7DD4;
	Mon, 17 Nov 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+zOmGtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215C199252;
	Mon, 17 Nov 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419581; cv=none; b=uxpy5Ac+QRGoLc46MlIMXVYiB3IdL7ckVDoRefhJ/zsc1roudxOUIg5IBmrsAw41sQ6gU8vgieoXCYjKGx/YLezOFjgXXlyW5Uc3hOK1oeFZ/bhlp2fqZ/lwzDbyiMckX8xeSGa23Us1gntkmWR9339/YhxLYg+CSYte0G+yf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419581; c=relaxed/simple;
	bh=M8X10Tcz5LzdsBPhMIGBoWyGzcuB3L0lskpp6XvSMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz+Nf30zMZh+E2A1KluwGuNMYzFnWGupzzsDiEHbSSHNo+I+j4OVkTDP2to2TzoxQ1OyQBr7OR7jP92ro5A+Z0Vdbj25GREnwD//UpiKKqekOmhQ0Q0J/ohwBFBrA5akovT2r4lRea0J2mANMrEZDBZ0QDv6ZiOYxYAvpOhMm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+zOmGtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9136C2BCB1;
	Mon, 17 Nov 2025 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763419581;
	bh=M8X10Tcz5LzdsBPhMIGBoWyGzcuB3L0lskpp6XvSMEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+zOmGtpyYsQ760KHlDFRVgAZNsxpX9bpp6RWXtdDFGrmSEbAgIa2kXVhTSNMJ4tv
	 KWXlm3QwgHQ1Z/vM9vpE8r4aXQlIifgbTvtoUtuG7Pk9B7wU9BsvtoFWTMhWNjgv5o
	 ZmwegQM5LuIvkggM6gCAOdN3Ta41NW1VuvR7U3NvK0kCAKIBZixmtZm+M/gGib1Wo9
	 a04Acj0zCLcfqzw4OhlFKdQILn9rUqGSEgWhsmTtsMSPqyvS0d9gYMU6jOno+ZWz2h
	 zwQ5g1JjbO13T4ffv/h8n+5rCfXPPYH3qeDUp9TGrn0di2b/oZlnpboSFUjdTaVm7l
	 3E05OMS91nztg==
Date: Mon, 17 Nov 2025 16:46:19 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [net-next] dt-bindings: net: cdns,macb: Add pic64gx compatibility
Message-ID: <176341957857.857483.4274673350400117057.robh@kernel.org>
References: <20251117-easter-machine-37851f20aaf3@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-easter-machine-37851f20aaf3@spud>


On Mon, 17 Nov 2025 16:24:33 +0000, Conor Dooley wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> 
> The pic64gx uses an identical integration of the macb IP to mpfs.
> 
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> CC: netdev@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


