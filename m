Return-Path: <netdev+bounces-123716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68696642D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDD11C231B8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9E1B1D7F;
	Fri, 30 Aug 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BWvuF5yB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3A1AF4F8;
	Fri, 30 Aug 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028068; cv=none; b=mkPA2HQAXtzbe6DShvFREhxqGpYuR88BILU1JxEmAXJHTPjNipS2ECbb6IdeklWF9PV0eNK/Xnx/DQdyxAlRyo7Vbpaq3plvD0LHF0qQQrUkAW7xlJdXfHfkjoDWkKGbLOBoJkK5kegLsmAWxI334ozq9aAuRQ5ZC9GTcORhpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028068; c=relaxed/simple;
	bh=lMuPFjipSF7b7/aDSYFHL7JFVCKIe9MJPgiPZ8lExcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlKor5qCdrx+tGFOzUgkvKGbK/py0ExIqess6FrwvyqqwTSdDc8xU/INAKJ1/ZOUlk9Cxr17cMzM18oAs3pmTJWVUEnAUPF8TqmkRjOgf7ZTGjm8Vb4l6aMgHJrsrju+S311mU+xwZJpfH2PNszXf0uFMkvqpmv6o9TlIcOqp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BWvuF5yB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=isACkxKl1VC/LLRXrffN4FhZBqDf6axelFFY8TBD0os=; b=BWvuF5yBoeK/xIXS5MLi+4YLlM
	3UMSgQOoUnsxC3v08nnbtcz/AgX8LBIqjGwd2sWBbzEQAOAH7va7gXzETnh47oejHzJOaH9MP9aR+
	1sTEcAT/+FclY2dP47w2aUGvpWGhJKKaGwA3mceak3uUEZ5lq2CJshzBYSC7+WuYfndc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2b3-0068Ss-QN; Fri, 30 Aug 2024 16:27:29 +0200
Date: Fri, 30 Aug 2024 16:27:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: phy: Fix missing of_node_put() for leds
Message-ID: <6655eddc-d203-4430-a938-f4f710220b9b@lunn.ch>
References: <20240830022025.610844-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830022025.610844-1-ruanjinjie@huawei.com>

On Fri, Aug 30, 2024 at 10:20:25AM +0800, Jinjie Ruan wrote:
> The call of of_get_child_by_name() will cause refcount incremented
> for leds, if it succeeds, it should call of_node_put() to decrease
> it, fix it.
> 
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

To be 100% correct, it should have a CC: stable@vger.kernel.org

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#stable-tree

But it will probably be O.K. with it missing.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

