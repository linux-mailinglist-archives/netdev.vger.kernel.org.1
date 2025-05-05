Return-Path: <netdev+bounces-187863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46393AA9EC3
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7143B3A648F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51294274FF9;
	Mon,  5 May 2025 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HG05UBWD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8E176FB0;
	Mon,  5 May 2025 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482960; cv=none; b=UDa1hL7bkLNAaahDTWGCOLme0Glc3bNLxbsIp8OiLROfk3AUxoRx07VReIMkG9jAu1iGDzUwnnIuF5ivFpNBtljOAt07755fwG3XoV/GlvTDMmmSuPOKMZBXGyqWjz/TzVtQRoBqKJuLaoPyuP6Xk5Sv30w5HRizq32+LAlHmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482960; c=relaxed/simple;
	bh=zznqT6mCmm+gXSIpm0j9JC6CWIA1LdtE8fnL3S7LF9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPhHIK62Fjf8Edcee5lo6VOHk1Lrvlst2cdMfKOtERlR/BawH73w4bdd9PAIzxSZUKHO8uvSfBEyQJnK7grO6DXC2VKqrCymtb8qpvh60lYHFa2l7x8SioW403Q8LUXrqfWgfK4iZ4tgPaDvBrTX1nWEj5U9AkVyX/QAAGYpKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HG05UBWD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GuSxxzSuHa3qwHDwpNoEIKmX6t685vUDFgKb5+SzDG4=; b=HG05UBWD4JG8yT4awIbWZArWTn
	RSmYIy+d0Cv+HPGUag+ycLu7+M3//H5dtAN0hxGGAYeL1oM+5J9xE46TuzGZBOFJwzIZ580qf4JQ3
	wPvGsfj4O7PMGKFLQRren8S8G1Xj2Hal7x2RoCstjvH0mlLBPH7BG/q2HSyPT7sK1AkY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uC3zq-00BdpY-LU; Tue, 06 May 2025 00:09:10 +0200
Date: Tue, 6 May 2025 00:09:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v7 4/6] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <8233e532-927d-4b8a-86aa-57c88c878790@lunn.ch>
References: <20250504172916.243185-1-michael@fossekall.de>
 <20250504172916.243185-5-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504172916.243185-5-michael@fossekall.de>

On Sun, May 04, 2025 at 07:29:14PM +0200, Michael Klein wrote:
> Group macro definitions by PHY in lexicographic order. Within each PHY
> block, definitions are order by page number and then register number.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

