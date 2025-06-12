Return-Path: <netdev+bounces-197081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C218CAD7756
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E81188CA83
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9A29B77A;
	Thu, 12 Jun 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xo4iP4o3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A21B0416
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743612; cv=none; b=LdUigB/YpXVuWe3wZTJxkqwN+ujc0aVNqm3j9u8Qjj3pWq+04SAugA3Gyn2O03AV36+6w5gk1N08FP8xQmKxTqI5WoH/5Ch78IrudDy5cZjicf7ZD3ZBvbN+xLCxbT0782n6zTSvqynQHWpBUNJsw6wA/HEkIq9ybL746eloPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743612; c=relaxed/simple;
	bh=mZmaRGp4ByGiTBzSidsfdchiNeoob8POYyiRUb/cSL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGP5jZqO29VPKHZLO1gUiKksMc2H0Q7DPXxj551t/Lg3v9zzCoYiLm7xCImPcCbCg/D2FnSk5Bn4PLmXu+RXr/+fKtTHIGb79vmGzU0HTyibz0hczahuSvJ2j2qdwRARo+l2Z0e4/awx3jU7tUOf1RVHKgQCUKGEQlfUwerP/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xo4iP4o3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tmhS5q7Q2QFYu1FyChk3Bwu8/VP2DbtV3PA++BzP3I4=; b=xo4iP4o3N6RVnhnvSvbtonYi7l
	aY9nUo1fpB9Dag+WbMG+hJjUn8SuAFv0RKy1Nokmp66ac7FrWsP8frWtqn+N7oTI0N6Fz7HZbwQLt
	HhbCs0CeOFpE9TE0A6lx0aRU59UVxUnbxFgmrm7CYGRARBJLeGwCe5jzonHK758Mocr0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkF1-00FZHK-9n; Thu, 12 Jun 2025 17:53:23 +0200
Date: Thu, 12 Jun 2025 17:53:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 9/9] net: stmmac: rk: remove obsolete
 .set_*_speed() methods
Message-ID: <32ddc0ac-ca68-4926-b815-51183912c83a@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk3O-004CFx-Ir@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk3O-004CFx-Ir@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:41:22PM +0100, Russell King (Oracle) wrote:
> Now that no SoC implements the .set_*_speed() methods, we can get rid
> of these methods and the now unused code in rk_set_clk_tx_rate().
> Arrange for the function to return an error when the .set_speed()
> method is not implemented.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

