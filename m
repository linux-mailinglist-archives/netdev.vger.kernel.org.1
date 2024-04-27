Return-Path: <netdev+bounces-91901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4238B466E
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BD7285E63
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806824EB3A;
	Sat, 27 Apr 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EsjvKfEs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83A3E47F
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224245; cv=none; b=eqhbmHRzfC8g3rDZfmigncOpq+UGZ2bJFFSCB9Wn/Y10XnCZ5SZz8xa3LjqS2HsaYZXvqgxfkvn3TnT5g5DGKDubRLwllJhzuxqWGv1RX778QhTA3rzJfNwjYo/v8ZgGM97aXbn3Ep1ROYZkZz13eAMtN6fmE3kfiIB6NPZ7U7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224245; c=relaxed/simple;
	bh=kLomDDjExr7V+qAVBKSqHbIuC8ewPqpTzgdWuIGCDbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5RfGVroqQwagosnc9Mi3/XTUhtcMNUmBq08NT8c0MsUd563AM+Wq7CXYuNPYp4ORsJ4EmcNENlbdSxoblq/gEgUQ7ldjWhgF+9DNfi8teCAybZUxbKBv6KNnkfkIysOvwJ0Qc7pbTY1ccETRloUDN5XEwW5xieeTYxLDZCyRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EsjvKfEs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RqKICUK9jjEcG31AfuQoQ5Nux4EZ4sB/6bAIZDwtXXo=; b=EsjvKfEsna+Ibx44P2D/MK01NJ
	rJYnaJQh4QZlyEQOZbeKBBvbP7diDgNWpWOSyLGsqgTZFROVgGukIY6pG4KmE5ERj8FEwBUQ4eYEZ
	gPZbC1XQYBbhFrMJ1hJht9xITUFq1uYI0kPH+WhMQfL7b217Es2Xk9AB7iG0wKXiYNLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0i21-00E8zU-34; Sat, 27 Apr 2024 15:23:57 +0200
Date: Sat, 27 Apr 2024 15:23:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <5176e9a1-4fbc-440a-b369-24bae4311169@lunn.ch>
References: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>

On Sat, Apr 27, 2024 at 09:52:03AM +0100, Simon Horman wrote:
> Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> busses") mv88e6xxx_default_mdio_bus() has checked that the
> return value of list_first_entry() is non-NULL.
> 
> This appears to be intended to guard against the list chip->mdios being
> empty.  However, it is not the correct check as the implementation of
> list_first_entry is not designed to return NULL for empty lists.
> 
> Instead, use list_first_entry() which does return NULL if the list is
> empty.
> 
> Flagged by Smatch.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

For the code itself:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

