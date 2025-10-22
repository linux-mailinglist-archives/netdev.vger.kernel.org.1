Return-Path: <netdev+bounces-231668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A78BFC3E1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1CCD35820C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1C348890;
	Wed, 22 Oct 2025 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jGEhTocW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2634A3CD;
	Wed, 22 Oct 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140532; cv=none; b=bd0uEVE6zCBZdyDvUuqrb1DNg+RjGuu9xIVaWAfylSNBp+FADjSq4NXNJs0Qk7uNQvoMCwGI5hPIOtUnV3DLO/aJRYpzIaDcO3QI2oEkkfEsXgtMuBvJM2jIQ+nyHXVCphEFbeorkBL5ID1VS0RAaJlxaXiPtlYkf28peeTQfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140532; c=relaxed/simple;
	bh=IEl79dUHrwJY7QFFJ7tR0zbEoABfMRRIYbMeefn0LJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJJLNm6nZuHq5hiimbrSKx0oN8OU1flmBORktxGp56TebTfrZTnrstQgHW7WUOo00OmPthsRMbJkeghbixGDLQyosYMo6GOwsULL71CxhqaATqan0lOi9JhgU8jGGy0DLEjFLZ8d8a0tdzhzmsBVrk6TtjaGILG0WLiv5pcAyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jGEhTocW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1an8fnmht/cJNOgYrJWi07C4PsJe8h4fjBzZcExGXmY=; b=jGEhTocWzVhbz1bkUmSJiPWV9D
	XgMkodaWUCB+DipQk/ljACkDYyav47bcG6o1HvHm7cbY2SplxbOnaEGkXshpaL4bAmjgBk+bNzBKx
	xB0AdgPfSFlpYhcNmsC/793QWTwZYes77hbAUN+NqwZW3Ud7xQGDzC513Tc8jT8QVh0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBZ6J-00BlVf-8u; Wed, 22 Oct 2025 15:42:03 +0200
Date: Wed, 22 Oct 2025 15:42:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3506
Message-ID: <09bc04f7-21f1-402d-98db-3a845a7c0099@lunn.ch>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-4-heiko@sntech.de>

On Wed, Oct 22, 2025 at 12:43:56AM +0200, Heiko Stuebner wrote:
> Rockchip RK3506 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
> 
> Add compatible string for the RK3506 variant.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

