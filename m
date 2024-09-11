Return-Path: <netdev+bounces-127421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33993975532
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F90FB24684
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8B190671;
	Wed, 11 Sep 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="arxUc70O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD48F6C;
	Wed, 11 Sep 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064690; cv=none; b=JwWtsYbMlWYCW314nUXgfQBmmAnufg4Dd/EdwNXkTBpvkhu8kmnUGnGOz/aAqFzrDlSTQEz5t1xtJ1Hsl64+W1d5X5iYVFIQtUSzi68D78Cr6PlS8Y4oinqG0tdc2zpOHRvP5F+CoFW0kL64QuND0eN+oq6qYt/N5i0QpwVdCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064690; c=relaxed/simple;
	bh=p4YYglowW1PWzFYnKaD59+YQf2ALmSZK55WlphILxuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgErAsG6mUo6rSIaNsYfObtHsETqOQPWM5Zff0yBll2oeLnPf3yrSpTfK362wuCn81bmykQU/mGwoNvTFQw7pyBo4KNFg5W4vpQIfV2gXh0xjBjESg9E+j+Dwhbjzd0PDWXVBD/Mx8QdP6ovNnQzJTwnMHpIuDDggEqhBFkoAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=arxUc70O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AYUWC6BDsbub2sgONbsud/+IkDk2BPuscfSFDxksZLs=; b=arxUc70OS6BylUyTtBKJGQlYN5
	uiWof1OnNZWVZ03Wt9dFmZRcKCvCFUF/g/Ozyf2IWPdVgcdoFeeOacK+Cs0UG97Ft+1W5uA24NpOg
	8Bo9vj9BbnFTy7IK9idGyg43Bks5K1ji6Ds3Tbkq5ZGmTorNEV7sZF0xotIwBQJ/0sgI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soOGp-007DSx-N6; Wed, 11 Sep 2024 16:24:35 +0200
Date: Wed, 11 Sep 2024 16:24:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Message-ID: <46d8c9b0-ce3b-436d-ab87-1568d78142ab@lunn.ch>
References: <20240911135828.378317-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911135828.378317-1-usama.anjum@collabora.com>

On Wed, Sep 11, 2024 at 06:58:27PM +0500, Muhammad Usama Anjum wrote:
> The err variable isn't being used anywhere other than getting
> initialized to 0 and then it is being checked in if condition. The
> condition can never be true. Remove the err and deadcode.
> 
> Move the rx_dropped counter above when skb isn't found.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

