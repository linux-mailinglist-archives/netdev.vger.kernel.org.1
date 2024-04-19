Return-Path: <netdev+bounces-89678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBAB8AB230
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03E7284E1C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382512FF81;
	Fri, 19 Apr 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="35+1MKQq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6A12FF73
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541462; cv=none; b=DyG1N3RHCL4n6tQKJZG3OnQaeGAkwbPtdE49pK6hzRjgLXkAI3hwXtnGq2RIY3i3ax8kBXBEQ6sGfgyQHaqkAvqtP8dv61rmxN5h33+rI4E/YippiXdkcP45Zu4Edcm3tRn8CVXu2MsRw3UHEK9ZCkvV7bHmZAbG0tmD14Hh5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541462; c=relaxed/simple;
	bh=oOyN5ndXEzTFrTs86BkqGTcG1Eemswqeor8cyT2IO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7KMbbaXCZo4f5Ye+3tEonCuQihd4/mlpjnjwp+nOeytk2xvv271lqgjZ5pSBeMdTz5Rw36SW2PEZrJF0Bjqku/d+4TWE4WOGGic5YowvFdULLzjGWAxxNDSop0Kmvf40W1EDtxjWHYWKDM/jiO+ESuoNK+E9fJ2kQUUj4NHmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=35+1MKQq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iN98k+Obvr8DtYRE4/5wp95ZIX//nSrOyTZPUZv1hBs=; b=35+1MKQquJY71fp6sFWptYh3+D
	1ZTedf//UNF+SYfnQ1Oa14yAnSr6OOBWS2LAV0VG4jTxsBbjK6QiVMvkw2r2RoSsXBAREMxlMM6yS
	ZWMAVpSIi0iCg3W/yDzWJuTGwcAJgKuJf5IVJLXgsBzQn05WCASpqf8K4mh/pNQWG6ow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxqPD-00DSnv-Q1; Fri, 19 Apr 2024 17:44:03 +0200
Date: Fri, 19 Apr 2024 17:44:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <6fff92e4-d4e4-4a41-ae5c-5bfb7e72c217@lunn.ch>
References: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>

On Fri, Apr 19, 2024 at 01:17:48PM +0100, Simon Horman wrote:
> Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> busses") mv88e6xxx_default_mdio_bus() has checked that the
> return value of list_first_entry() is non-NULL. This appears to be
> intended to guard against the list chip->mdios being empty.
> However, it is not the correct check as the implementation of
> list_first_entry is not designed to return NULL for empty lists.
> 
> Instead check directly if the list is empty.
> 
> Flagged by Smatch
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Hi Simon

This looks good to me. I would not consider it a fix. As you say, it
has been like this a long time and never bothered anybody, which is
one of the stable rules. It might be possible to have an empty list,
if there are no nodes in DT. But that is something which a novice
would do when writing the DT, and so probably would of reported it.

However, list_first_entry() does document:

* Note, that list is expected to be not empty.

So testing it first is wise.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

