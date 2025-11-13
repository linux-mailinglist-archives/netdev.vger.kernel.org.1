Return-Path: <netdev+bounces-238374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB7C57DAC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A75D4EAE9D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD226FDB2;
	Thu, 13 Nov 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g5JjFuXy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019C270541;
	Thu, 13 Nov 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042919; cv=none; b=sjYni26y6E5L9orB8VcZJSbp+t/4KsCOn+WpK/yWggYUeXuEROBlKZTXl1+UnWaSRvXSm6JRnA+asPrBDAEgRtttn58/zj3Mnj2LcAuE5BUsDVqEQIFgAVHtBzs9j72yMVC1+rgiAf1oqJ3aS9h6F24JNbF4IZqhnEVwiYh4Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042919; c=relaxed/simple;
	bh=LfJ+O64mvFm/AnI7bEwCew+c0IKjy/P35du7pZdhE8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkXYrOXGmoLzYoEu08DoHP2KaqDIyTCYbbg0s0VLIvoOgCqMgL/5cIO3TzupGOtPAHIxjth5dfB9IGR56R5MiYjjc+0RmrD24DQ3zWHxyiJtsrs7xPshAkPafv7zqfcy81OoZ9M16J0No3rVPZCLVH832Sw4c5sIgrhMnmrSZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g5JjFuXy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y7eEIZ3WGH7L9xR0sf+qOnZQs2oCPumR1goo40yV+G8=; b=g5JjFuXyxXrTkqU5pikgtsAhY4
	ZxkzwzUOWP8mYZtZtLhByDg0eR5BkYACTt6BN4pUVcPsBbbU9eljhafcWh6nUa5XQVecgAcOWa1ao
	SojsPSUDGVsstUherlRRhQP9YIFSqr+jbdy2dCrBqoefB6FR4Ab2sI/tOpl8fxdQpbfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXzm-00DsCE-KH; Thu, 13 Nov 2025 15:08:18 +0100
Date: Thu, 13 Nov 2025 15:08:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: dsa: hellcreek: fix missing error handling in
 LED registration
Message-ID: <d66a428d-5d11-4656-92c7-eec351a1cc98@lunn.ch>
References: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>

On Thu, Nov 13, 2025 at 04:57:44PM +0300, Pavel Zhigulin wrote:
> The LED setup routine registered both led_sync_good
> and led_is_gm devices without checking the return
> values of led_classdev_register(). If either registration
> failed, the function continued silently, leaving the
> driver in a partially-initialized state and leaking
> a registered LED classdev.
> 
> Add proper error handling
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Does it say anything about leaking leds?

> Fixes: 7d9ee2e8ff15 ("net: dsa: hellcreek: Add PTP status LEDs")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

