Return-Path: <netdev+bounces-205144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E94AFD96E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D54A8410
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026042459D4;
	Tue,  8 Jul 2025 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXLgx+Nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55062459C6;
	Tue,  8 Jul 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009340; cv=none; b=VVRvNSWUCp3OKkw7w+K/zw4kpiJWi/vJG39WQC1NWevhABtIO54LIoewntB5vbKyoMb3gPiuyC2nVK20GavClQdhbm8A51DDp115dm4dUTNERXtb8j7FQJxbJmlk+F+x7d16ovT/TIMJCqsq988EikG1018Nj6QESYMhQJHW3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009340; c=relaxed/simple;
	bh=EsNrzNjV1ejegXwRqHZoNtXa4eBCU0UHv2etOg/t2Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evyU04f1mVZLSf09j3VxH05WAqFXm8N9xu5pcLdD2+pBChlIn88MKlW3WlgFZ3/LaTytrin0EcCYwSazNhOgF1h3avgDHpz+iIkDbrgqTEAdMsmCl/lpyupiw4IvcYTmfYXhNhFFnhVXN4L8Mv+UxCnr6fn79oEf9PEoqjLBVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXLgx+Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168CC4CEED;
	Tue,  8 Jul 2025 21:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009340;
	bh=EsNrzNjV1ejegXwRqHZoNtXa4eBCU0UHv2etOg/t2Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXLgx+Nc/Il0M8mnaWaTErBAJYW6UH/b3ChhI1LjEWZ1ml5fkzHdaCaYOl99XYH/f
	 g1fyCkze9zHQfvieSG51xhB6PFC2OrGkDq77mm8FzJaQOQGL28nTAU6Im5pWJPQfNr
	 xgqKcDlEBibsvEy1PMprvnPeFxlxa+i/MW9vQ5YjpWVQINxY8D89YrmlgshJrTMUJP
	 Qn3QU3pn1T8APdplhYULYG5GDoEyHqAAUw8EvUfsB631uCVtnUbOzHcQD4jAKlGI+k
	 uK0BTZzRanm6MTE1WDXUn9iqYvh9qBBbOzzGpGcMDpVWAee9dsresSCF62LDyVSqpa
	 kjbm7xmjPgNnQ==
Date: Tue, 8 Jul 2025 16:15:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: linux@armlinux.org.uk, corbet@lwn.net, linux-doc@vger.kernel.org,
	krzk+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com, hkallweit1@gmail.com,
	pabeni@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew@lunn.ch
Subject: Re: [PATCH net-next v7 2/4] dt-bindings: ethernet-phy: add MII-Lite
 phy interface type
Message-ID: <175200933841.1032309.15245293992929519207.robh@kernel.org>
References: <20250708090140.61355-1-kamilh@axis.com>
 <20250708090140.61355-3-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708090140.61355-3-kamilh@axis.com>


On Tue, 08 Jul 2025 11:01:38 +0200, Kamil Horák - 2N wrote:
> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
> 
> Add new interface type "mii-lite" to phy-connection-type enum.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


