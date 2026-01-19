Return-Path: <netdev+bounces-251161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9FD3AEF0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E814730141C6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9238A9D3;
	Mon, 19 Jan 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O8wDb4mr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261F24A046;
	Mon, 19 Jan 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836161; cv=none; b=i3NDCUwnJf609AExCoK5k8X1hmdBs4LiZ45PtQqWOboJfxeyWoEnIOUI4eyWWpYhbvCAg1L6hSdKVI+PXjY+6RMqdYegcujMpCsWDv/W7wlOvmjzxc5Xu0eUtL+DlWSlcHWy8VybEYzmpwmEeM/u6TbX3QREXDJXkXyQgyQI2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836161; c=relaxed/simple;
	bh=w0rldqWCWMqHkQDvsESVrqHlbwcAYL+6wx7zooIM0dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbqP9SgVwzjsVcdf691ZW2te3Rs63RXy0DheLKRT3/hs9K4s2o9D3lee6wPPgwVOiJSb/hVlCJOXyiWsXQ6ItN+sBgGx+kEWA5EKdVDmv3l9HsfdLhNLaaea/siBFJ+hI5TY0k2XJ9UfuzcvQxYQ4asyzE9TQFqmV3bKa7xjwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O8wDb4mr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t2bBOzwMAYRPjjO4lNowgGiSlgdU4XZZkvdsScnElFg=; b=O8wDb4mrkaMfRoOkguXYrBTU0J
	OesoB9GT+1MQrogutipTMxmJeZBU0K57dc43hHA9LAiPkGpuH13kbBK1T5gKort1JsDxQaJOTclsX
	wL5Ri+OMBYkuFiJJ9o14NQgVIAh7+o2Qk5yuVn1cdTzKZujgjP9nyJMWUycOZxill7VY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhr5C-003WIK-Nn; Mon, 19 Jan 2026 16:22:22 +0100
Date: Mon, 19 Jan 2026 16:22:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v8 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Message-ID: <04df4909-4fdb-4046-917f-2f2e47832c62@lunn.ch>
References: <20260119073342.3132502-1-a0987203069@gmail.com>
 <20260119073342.3132502-3-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119073342.3132502-3-a0987203069@gmail.com>

On Mon, Jan 19, 2026 at 03:33:40PM +0800, Joey Lu wrote:
> Add GMAC nodes for our MA35D1 development boards:
> two RGMII interfaces for SOM board, and one RGMII
> and one RMII interface for IoT board.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 54 +++++++++++++++++++

I'm somewhat confused with your naming here.

A SoM generally needs a carrier board. So the SoM is described as a
.dtsi file, which the carrier board .dts file can then include.

Where are the PHYs? Sometimes the PHYs are on the SoM, sometimes they
are on the carrier board. If they are not actually on the SoM, the
PHYs should not be listed as part of the SoM.

     Andrew

