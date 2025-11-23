Return-Path: <netdev+bounces-241073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EBAC7E9D0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19F24E06BD
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CB21D3F2;
	Sun, 23 Nov 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KypvXMg4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8BEEAB
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941668; cv=none; b=mb49vh30UwEldYxjNcibP9BqBMqosc0cLSXywMdUWw/Szei34CMqz1GStOTDKYnD2iMt7oFd8nPO68T5bRRVG6adup3u7TdAd+b1UPXA3e5iLWVnPoktqaFJt7jx19nUO30MNAUss0fDFAq73fdtzDJPve4UiNumUJ/rt0zZH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941668; c=relaxed/simple;
	bh=rSBNSPYak0EY4KBu7tu6dsmsQVXWZ3nBbhoh7dXBB/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAlR+Z/rc8/ASdrxxgKAXKsnOVBSzQGeoYv/N0+7NTBMS+6qAwJQ1lEdvSUMJBM+nyyPfBXYwGHHKHdt220VfJtPhyWJFQZPxwEQpiE6Ew76nonmBqJyRHz5C/gqP8GXefWIyuNXLrdm3b0IsBKz9PY51ExS1z3m7ZufUdQmxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KypvXMg4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f3UYTGKjFTz3COeQraRZglOdjHhLXkLPCnU87K91kUE=; b=KypvXMg4rTBJl9ZKj7mSOU80hZ
	bqGnQYeCyKWNk/ClSU/KAcV7LuhKTqkRgFP9jvOtACROU8GZ2mxfbXELpViF0b3ZW/8VqRoNL6xAv
	SWj3cfK1nzEiD31UqYsGcov+VjCG7cqW3I6Vz7GHu57Xc30ysaHDV4v7u9PnLvcDmtlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNJny-00Erlx-QL; Mon, 24 Nov 2025 00:47:42 +0100
Date: Mon, 24 Nov 2025 00:47:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dsa: use kernel data types for ethtool
 ops on conduit
Message-ID: <c4fc4b81-fa25-4870-a34f-8c47b284dca9@lunn.ch>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
 <20251122112311.138784-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122112311.138784-3-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 01:23:10PM +0200, Vladimir Oltean wrote:
> Suppress some checkpatch 'CHECK' messages about u8 being preferable over
> uint8_t, etc. No functional change.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

