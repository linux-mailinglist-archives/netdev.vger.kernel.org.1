Return-Path: <netdev+bounces-99754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663038D635F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF81C26ECE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E8158DDC;
	Fri, 31 May 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5eoKD5e/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDD15CD63
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163184; cv=none; b=SeqeRR2FO/RKH8FpSv3ryE/84yZSuIFfI/54YUDe+1uYA2EON5LBHPiYCtufm3xa6+QsMxjKNThucUSfgLqU/BFCnzGMmcKe3Y8LTnaSQDUm3+5ucqIGN8FOKAnFeKtwnfGKA8rUHubmzM40zUtIeNSYcwcIGLK6KrZFeBpEjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163184; c=relaxed/simple;
	bh=+r2cgwhGMM6K1DF1TXC084RnUm3+yBwQLByZuZon6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1JfmX3AQPUGUdgx/oWKGCuK77/7IJX9hxu8jM3aP+kw87wVDchWIbD1CvL+OiKcRLU811Hac41s2NvQvzRKOKT+wcebld/Qi10unUn0V4gMV10Bwj/ezBLkTulfpb5XuiPlPFmnhsb9phlcy3jZQslPAlA7aO1y10itZTYouR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5eoKD5e/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rdkksymfi46lkvUCYihYvILBL9M98BG91F3EtFDa3V0=; b=5eoKD5e//cg5+4cppQMQtrfgzg
	DeHsFtBKjytNrVxv3XUqWOn8JnvUcDOsp46EcjH2YGV9B5zJYpQxf5i8fAt5r7L8U7IKEF0S5cS7g
	5uD8yUL0G07Ql0mKU4xlv0UyAt7gQRpSt1PTdF5qwsyf/JVv3wLPjv4jeqAOdjU+vIEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sD2aC-00GTBU-Jh; Fri, 31 May 2024 15:46:12 +0200
Date: Fri, 31 May 2024 15:46:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: remove obsolete phylink dsa_switch
 operations
Message-ID: <e7845173-b601-47ce-870e-6896d3d5916a@lunn.ch>
References: <E1sCxVx-00EwVY-E2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sCxVx-00EwVY-E2@rmk-PC.armlinux.org.uk>

On Fri, May 31, 2024 at 09:21:29AM +0100, Russell King (Oracle) wrote:
> No driver now uses the DSA switch phylink members, so we can now remove
> the shim functions and method pointers. Arrange to print an error
> message and fail registration if a DSA driver does not provide the
> phylink MAC operations structure.
> 
> Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

