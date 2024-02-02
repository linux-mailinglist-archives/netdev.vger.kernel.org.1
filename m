Return-Path: <netdev+bounces-68583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9C8474B5
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6BE1C260EB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8D1474D4;
	Fri,  2 Feb 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dMzpstna"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B421487CC
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891384; cv=none; b=lLJtbsLaNjk/+iiRcy16D6174mORRsPYjxZkW1+V7KOIk//3+gHfJRzZiADJZmgw1NH+PIvBjNHSUNDXBd9KiyxQc/81Zdd5gnfDqIqWuSBkZrAZTqh3HqvvjSnQYorC0Bbu0vnVGhHOIqlILhIrHVLy0C6LLyr0GTmyGUnOG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891384; c=relaxed/simple;
	bh=McgEpCiFTpylFCpGen6Xfmt1DMBsDcHEmnCVtUO5fVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcT6LMZXQanIt7h9zGsnCYLNjXYfAPiP14wyj552LgclSsNem5r7GBTk1Ud/ccEHpd5/MxjCBWl5dSW4YCZqhuyXu1VluwLLjZpvM4p03IO5HNfP9JIoHzrOf+z7dmJiZxSsBb4nkWkqANxMKByAY9GCWsP3MHKIq8+4Wyh4uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dMzpstna; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2QtvlCQUTzGp99EIP/bc5eVXD45PDHLpjOvv370HWtk=; b=dMzpstnaTu0Q2jAuj/SE7au+YD
	RsfLMRrnb8yOSyed/jIltx6mb+VV+Qt1Wbth6h/p+B1AJ7xM79OVRsaiVKzKbwECSfRM+mdF7kayC
	dc4ojJe6MFWYvJrGjKCg+w+tyhq8Kg2VoiR2+NFZQu59n2cLzTomn9TiYCSTDVkW66Ho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVwQ7-006pDw-K0; Fri, 02 Feb 2024 17:29:39 +0100
Date: Fri, 2 Feb 2024 17:29:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: reindent arguments of
 dsa_user_vlan_for_each()
Message-ID: <b9b90933-d3d2-4231-ba65-2d0e8d556312@lunn.ch>
References: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202162041.2313212-1-vladimir.oltean@nxp.com>

On Fri, Feb 02, 2024 at 06:20:41PM +0200, Vladimir Oltean wrote:
> These got misaligned after commit 6ca80638b90c ("net: dsa: Use conduit
> and user terms").
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

