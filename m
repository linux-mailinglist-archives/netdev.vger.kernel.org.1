Return-Path: <netdev+bounces-250553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32383D32BDC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D4C53018439
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD07392C5D;
	Fri, 16 Jan 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF/6dNjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4C392C4D;
	Fri, 16 Jan 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574084; cv=none; b=TMxzs0sAc9ka9p79r+eH8zkE6bF46ryXAgzGEiiszM8a7ArPMSRbC85Y/tLaRTpwVxGA9EpD1H04kKdqHcOO8CsUbxxlz2bxOO6Dnp8HwuniPNPZDCy3tX5G/SKidOwHMq8Z2rGZijIBHun0MmwYEbVhC9KXaNh4oY7cY8f/uO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574084; c=relaxed/simple;
	bh=1D/0RNNJqFw6ZXyghG7W5LLt9mDwWeVErPW7lVNEBBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2MbApum01ULxJL3z/xsoVMPEXBKJVwC0/oc001CN/RBAS2atTMirzz/GZqlzOKcCTCpV8eimrfv+93rO8s41ml1JDn+3ztyyB8MY76dZ1e62fOEZEGQb1w+urwPP/UzoIaZlwx1bj5F2qkjqT7lsKVpupn0Pq6pFKzpLl4bV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF/6dNjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9722EC116C6;
	Fri, 16 Jan 2026 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574083;
	bh=1D/0RNNJqFw6ZXyghG7W5LLt9mDwWeVErPW7lVNEBBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IF/6dNjBvIcyh+1uV/cx21Nx7Jibh/pZF5p6+Sjv8T226OacMKUrUagNmlPHtjpPP
	 +/TXeTxQHUTTPs/6jl3/NPb3fA63veN6/0T0peUW7zPxFTIiqsgxpvB97flJqMIbVT
	 MnciCh+qWjvOr1f+l+hxcmdu3QYRHIYNdViF9VXL/3nFfVcAT1PJKYXXmdtVS2kpaR
	 kLFVP8G564dtVZRCBHrcGmRmO07bj2gWv6FLQvf7oKpqfT2Cb0rPJQSNll0KvUINi7
	 cbT6Rgi1ZJ10AOgF5+oJynG3cu7BbBlFOpqr8CDxr8/3NU9LZ+tGvv6l0JyjiRysEs
	 IA+oIXrtS+TJA==
Date: Fri, 16 Jan 2026 08:34:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: krzk+dt@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	andrew+netdev@lunn.ch, conor+dt@kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <176857407572.1478483.827975735919481934.robh@kernel.org>
References: <20260116130948.79558-1-eichest@gmail.com>
 <20260116130948.79558-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116130948.79558-2-eichest@gmail.com>


On Fri, 16 Jan 2026 14:09:11 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../devicetree/bindings/net/micrel.txt        |  57 --------
>  .../devicetree/bindings/net/micrel.yaml       | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


