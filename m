Return-Path: <netdev+bounces-96959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD388C873A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7955DB22AF1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA854730;
	Fri, 17 May 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XL8esFTw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5D548F1;
	Fri, 17 May 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952738; cv=none; b=N4mu+kbqsLaZI/BkbAt4Jbis+EbrdeUQRhesV9vrb5u9mdTOXA3sD6O5Q+p8a/h9VW2kALZ/PKuDu0IMejAhllIBpq/ySB7PymI9zYNHjWrA26zbWVUoClmxMF2o7mjOSrCQ1vrm1H5WXaLZl0tlJgNYiaMQTJIGe/sDfLYKBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952738; c=relaxed/simple;
	bh=fpsqhYHvhZl12Qy0owhHbSQeECjy58Otd3w65QWBfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwpemsTZPXwSwVljWO5wptCfi0YSBjh2AiIfq7U/JZikcJRBgjZNGTX74jMwqyQ9yk2YQaP+x/eB1oVSrpIb0EiT0GB48Ekdh7RCd3rjVcfOfTJPyCguoKpGBxEOW99RQNn8GJukpHRxYlf00XT1y8p448MLlJmn89nhyCHn+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XL8esFTw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/D/ySMwV+zNVaBsJBWC4bMoLgoeskveHWMY1nkIGMI0=; b=XL8esFTwMMCIidtMlYWlw5GYt1
	hZokVFflY2w9Mvr2ZuFNRnfpq3cTXinaocwDgsdq6EUlLP8fQMh+38WO7BBo9W4j9nhzVOE3cwnVh
	rdiUw3E7xku2Kv7lThEIVscdSLFqjbzDU/nIilgiXh4S2NsyKPXALOlqWR4RA8nv4ooo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7xgp-00FZov-Cq; Fri, 17 May 2024 15:32:03 +0200
Date: Fri, 17 May 2024 15:32:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v19 10/13] rtase: Implement ethtool function
Message-ID: <ce89cca4-b49f-4049-8fac-9db349b70296@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517075302.7653-11-justinlai0215@realtek.com>

On Fri, May 17, 2024 at 03:52:59PM +0800, Justin Lai wrote:
> Implement the ethtool function to support users to obtain network card
> information, including obtaining various device settings, Report whether
> physical link is up, Report pause parameters, Set pause parameters,
> Return a set of strings that describe the requested objects, Get number
> of strings that @get_strings will write, Return extended statistics
> about the device.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

