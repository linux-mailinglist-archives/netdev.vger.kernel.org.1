Return-Path: <netdev+bounces-172646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96AA559CD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9822A177ADA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4A2780E3;
	Thu,  6 Mar 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F9fSI0Vf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6291311AC;
	Thu,  6 Mar 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300355; cv=none; b=HRtJSl92psH4lrkOyaOY2EXQd20cJiGn1mvn5SMcLP/zjvmf27S6+lj31ifBAnhrYWhZNyUw+m4j447IPR4nR84gX2WTV/IlQuilOoW1DS9VsVuTBEVV67v8SfBf5j/d/Tq6/xtwEc2pobWMx9Bp9dD8V3EIzQrdMO5z91QLCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300355; c=relaxed/simple;
	bh=GZ1mCN6SzV084+nzUyv6zPnt2uAYktF4CHo/7kdUJuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrjOD0w3lN3hZr47RDvCwF1arXG1mRzyi63cdiyBl5+FxkZ3wzKDymkDkTeJxFv5MXxcAMLTPe4sbIGix6db5Tp+DfpZuVeX4vkAjnapZ/tEqSKu1/7eCrEgSOnrPo6U9OLyBR1BEmPQrVI0yijLObehrMR1AnhOy6djs0TgI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F9fSI0Vf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uZAt4QQnkQmkYEwPgW6Malh+ZLqvK8RMjR+3aU1a5G0=; b=F9fSI0Vf6NAUUXhjds6LGAvzjO
	DyDQAcJ13A+MxduWhG9oAQJCLHWNHGFJfu0xgZUmGLlT0fgV339snNdTINNpZS6NJ1MxgEa8aW6Ld
	W1pfO6EIQBQ+h20ihkw/1PbM0Gbw28tnlcGm10c4WuSuoBemumA7NqLY1Jo1Oo2t7bh4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqJlK-002wFL-K1; Thu, 06 Mar 2025 23:32:18 +0100
Date: Thu, 6 Mar 2025 23:32:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: Require
 rockchip,grf and rockchip,php-grf
Message-ID: <5d69f4a2-511a-4e7e-bafe-5ce6171cb1d5@lunn.ch>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306210950.1686713-2-jonas@kwiboo.se>

On Thu, Mar 06, 2025 at 09:09:45PM +0000, Jonas Karlman wrote:
> All Rockchip GMAC variants require writing to GRF to configure e.g.
> interface mode and MAC rx/tx delay.
> 
> Change binding to require rockchip,grf and rockchip,php-grf to reflect
> that GRF (and PHP-GRF for RK3576/RK3588) control part of GMAC.

It is pretty unusual to change the binding such that something
optional becomes mandatory. I would expect a bit more of a comment
explaining why this does not cause backwards compatibility
issues. Have all the .dtsi files always had these properties?

    Andrew

---
pw-bot: cr

