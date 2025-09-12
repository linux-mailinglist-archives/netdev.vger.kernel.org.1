Return-Path: <netdev+bounces-222723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F9B557C7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29106AA7F02
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86E2C3247;
	Fri, 12 Sep 2025 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1MAZx0Ws"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C42BD036
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709843; cv=none; b=KfoW8A5xndM9NusxJxqYpPAoMeU3XGqOjI9jar+SIFWsZzdd98AdS2cWqpnJYhf1DNAOQ6mgpUfm2v3ygbF1UVkAjQhPVmyQEXt4p61plVkxRElbEzVdqkkcidIGat/FdqMvUTyzF0GeE1zsKxHhdq8rDa16JyXfoj6deOKw7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709843; c=relaxed/simple;
	bh=JdiM2uk0TuixNLUeaLpSJZVM54VOqFrlpqikaKpyu94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8du91VV9xGxd276gGFqbNEwNEV4nH+rTN52O7ydPi7jB5y4K3YPmEKSEuQd3BcB+uljhoGC5QmAANSbkqfCN/CUrNQBd5fbhN+r8BhR/F4YZtDI9sDsU55cr62EMIgFIa4OYzLGJVsQpPHN61W/TMyQsRIfNEf2djwLVJtDidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1MAZx0Ws; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BQ7jK58wun1hIySrtbSR6XCY4tf6n0Anjpd8uCEy0wQ=; b=1MAZx0Ws6owmlDGTG4QakjquFR
	wA/atFB3Il+hbvFnc0zMer2b9EhmHoeXjkmBefwW+MSzXzXfgse10iuuvEBG1Op5pcgOpxMmT5hSE
	/hZttUuerx6yANUioSAIlYBW6xVqj8ZQvI3kG5FwqHIileLVPRnPtrsJki9A+ivZsEsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAcc-008Fs0-VQ; Fri, 12 Sep 2025 22:43:54 +0200
Date: Fri, 12 Sep 2025 22:43:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] of: mdio: warn if deprecated fixed-link
 binding is used
Message-ID: <df587c2a-3d8b-4907-bb5e-b1b3e37d8de6@lunn.ch>
References: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
 <faf94844-96eb-400f-8a3a-b2a0e93b27d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf94844-96eb-400f-8a3a-b2a0e93b27d7@gmail.com>

On Fri, Sep 12, 2025 at 09:06:12PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

