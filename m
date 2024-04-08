Return-Path: <netdev+bounces-85933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B589CF06
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FE82848F6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D75146D40;
	Mon,  8 Apr 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iFVJfSVv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E140323C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619705; cv=none; b=baqSGnp6YB5mKYThjTa75AifLWzFamc2GHBmxQ5YkYMEvGWEch+N53KqoM63rtEzdw8B6rZS5853tSG5NyJHaqch6/SsOUTYShrfSuswr7QI3yPImSPT5XeTNOQ04+ChUtdw79Vz6pW/6HSD9z21ZlmIcijLI5DF57VsotWepKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619705; c=relaxed/simple;
	bh=sLeBQ1AtQqrT60LNtFjNk/LpYZO/hKzHDpp3oFw5hw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbl//PLZoxurulGkIQS7hD0y+rlzIaE7/gRxqb+IEL3USo0MoEk4YQ9Zu9YY1WA1unvRjQXJciFh7ShbIHmzJHubu9uRmARtmAuJ9YfkZ9jxTdivc3PwvmXjAKRi6+NznKE0iJx6QRh7QZ12TBOoEvqyXXaQkluEACf8Du6Syx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iFVJfSVv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=78rRd0BlLRK41CIkqVJMklR1/Hlrp4Pf1beTxhiffTU=; b=iFVJfSVvWRj4oYdMAOlHLH0t7P
	UeWxCHuAWtfp0VOIlVn9H3IHWlpkRPlMF/ZnQQwQzuQB5ppXJEEsbcr5jV8RKF1BMZuN4HAtCcPOR
	tfP7skw0Jb6ap9813+yMkPNLFnevBfaxiFZLPKWqjkH7f+J/iGXU9WfAStL6LfES8q7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtycF-00CWZX-JX; Tue, 09 Apr 2024 01:41:31 +0200
Date: Tue, 9 Apr 2024 01:41:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: introduce dsa_phylink_to_port()
Message-ID: <a1c7b8e7-2d53-4987-a8ae-8b9073d2a1f5@lunn.ch>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn1z-0065ou-Ts@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rtn1z-0065ou-Ts@rmk-PC.armlinux.org.uk>

On Mon, Apr 08, 2024 at 12:19:19PM +0100, Russell King (Oracle) wrote:
> We convert from a phylink_config struct to a dsa_port struct in many
> places, let's provide a helper for this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

