Return-Path: <netdev+bounces-106634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020779170D9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6BA1F22F5A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32F17C7A6;
	Tue, 25 Jun 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IXcTWLBf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA917A932;
	Tue, 25 Jun 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342327; cv=none; b=LoiytmTUOIMOq2HHjf7Rl4jZcpGuxhZAK/D3J1In8/52fZAPZb41NQTeZlnUAwRtUEZH67MVlS4wWuhAyuu+iVGBPl9msKMlA3doDAlOfxdUKD0TwWsVoJzle9lmhfsoG1aUPW7qBr42Zh2W0UaSVVP5GN92Sl73zfU40iKu5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342327; c=relaxed/simple;
	bh=uEIULLa7C4jAbNteG18uxhCYY34Z2XNs8GG2ucBUTWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIVgDcsw/oaG8ZE5orEdNLkSx3ZYQeGzDDeXwxq/0/gwpbS7c2d+5EnLgwkene0QWwfkqgtJijtC5aXZ1UHT6dqgQ/T027wQ0xLM8OQg7JhU1UCx3Bz7rQBr4V5Zjdj0x0u/HGd3wWADVXcWC7twrG97AX051YNjPnf2tuZRFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IXcTWLBf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/wU8xeN8cCgRtzKcradtGAKFSSpR6dXnlCFc+JkYQ4g=; b=IXcTWLBfw8CQVnTZqjI08EPuFw
	oQHH7lUKnhk1B97/9pezLl1OZZX6RavVKFGOog01XJeVMwp+iqtadJe/FS2xzZsBfDBZLyNvNWR8h
	enEwySad1Y9mZ0OZaqTlgxCqxVslVQLVLWYUuKt0aGLi1tfvRblpoThPl8IYifSFVIRk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMBTg-000yHg-60; Tue, 25 Jun 2024 21:05:16 +0200
Date: Tue, 25 Jun 2024 21:05:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
Message-ID: <eeb1745d-6f80-44ef-8b77-daf2ac3cb109@lunn.ch>
References: <20240625184359.153423-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625184359.153423-1-marex@denx.de>

On Tue, Jun 25, 2024 at 08:42:28PM +0200, Marek Vasut wrote:
> Extract known PHY IDs from Linux kernel realtek PHY driver
> and convert them into supported compatible string list for
> this DT binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

