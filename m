Return-Path: <netdev+bounces-234862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3345C28126
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F1864E250B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FA72604;
	Sat,  1 Nov 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ug8xbOqG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B853C17;
	Sat,  1 Nov 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762008354; cv=none; b=stJQ4h105CZBbUaJDVhjU5NcornrN9WTUq4qzPS3qEzjjltfuFQsN1Ct9/UJ6g4pIFfQHeZA1PrxOCBfGN3EO7763+CJq1vT3KKifSXzw3JMjPCJoVdK1SmcFgYGENPeCrtU77CAiPXV53hEM9OuMGN5ntV/wJbSej9zCQNFklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762008354; c=relaxed/simple;
	bh=qkO+ykEsys63ujKDbA+VrzujKo/F9hngxF8RHQ/baCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ/+dMVdjW1+KR10ZQsmAiy1PpVpMD0F1B5GgKub7vAiZ6sCRVS5J96KfOTNOrqrQ2r4+shPwfkHKmZ0FP9Rq74Cw60rSvMF0GwLiKMbggY+sMcPdzELbjO1WhBjIBarndP93NRAI4dtrTEhAVPrXRsntyx9RQWU3dd+Mgxn2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ug8xbOqG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SWBl7yQrlooaBva6ieJFMt19fm/jEbTeSTX1khNyF4s=; b=Ug8xbOqGjam8MSRpkCfkBRcHTf
	980ociGHsjLj8wd1AEsxAZpLsbipWcWZfg2KyHAC1PzO+ZUry/Y7c9lxfdTaLs5hWCOnW4dKoRN5A
	eTGV0skhcrJdgcCar2DCme5kA4nUeSRHgxfvz74PrDXwfnzM8H+a75gI7hw//y0FYly8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFCrQ-00CfSc-9z; Sat, 01 Nov 2025 15:45:44 +0100
Date: Sat, 1 Nov 2025 15:45:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add brcm tag driver to b53
Message-ID: <0e455135-718c-4906-b490-f05ab3c0d76b@lunn.ch>
References: <20251101103954.29816-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101103954.29816-1-jonas.gorski@gmail.com>

On Sat, Nov 01, 2025 at 11:39:54AM +0100, Jonas Gorski wrote:
> The b53 entry was missing the brcm tag driver, so add it.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

