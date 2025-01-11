Return-Path: <netdev+bounces-157476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD0A0A62C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED141889FDF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA61B9831;
	Sat, 11 Jan 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TTB4pao/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47891B87D7
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736631753; cv=none; b=RFiPDma9GxLQKuQ+jk9lV/HDnI5cpZo1qFO9UTnK3hD6dHIT7yWb68yDCIm0cGKBOKohDA8clrYGnVsPxnxIoCRiUZpvmKJMGPG+yRbaXm/wIzhtblFquM6Bz2kcWn7MKAqRP4u64CQkMqKjTpmwb9sf8fVj4GkoAEJOMt/wO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736631753; c=relaxed/simple;
	bh=9CSrlGhMXdhaUTTLSFjRCTwih9Q9RAAbOzjDjA5eWoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLEhs7veAGqAPmvmq+Qt0dBQifVvesYYLcGIFWxASNe6X/9Ock1nYAhPWK5MlwcdtcHkPrmJb0dLCr7KNtdZpfsOrUnuVDhim9RTbXi9IFgH4JsgM7eqNoO0jO7t8izcQMwSlUPXkrTcOeD3BfbzhGlJ5B5LbQimR6m8Pm743h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TTB4pao/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=am4FOzd9Q5Rl/PIL4eLd63hngQjxVsBidINDlQPNEDg=; b=TTB4pao/sTI2a1NiXJAU4wm5qZ
	Fq6Z+ssBqVgj0kyjWVJjUdU0LhG8AbeEXzYEvK8UreisypoyvZPyIGnhyhtfzxosJ1I3KmVhT6bbT
	oc5JIErCsLGIem2gurOl8Tj0KgD+XGFGlqUxLJyCtLC6hLKz7k9TtYsbqQuc3Pk1AF5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWjFR-003dLW-8Z; Sat, 11 Jan 2025 22:42:25 +0100
Date: Sat, 11 Jan 2025 22:42:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: phy: move realtek PHY driver to its
 own subdirectory
Message-ID: <eea82807-8176-4738-b479-e185004f3708@lunn.ch>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <c566551b-c915-4e34-9b33-129a6ddd6e4c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c566551b-c915-4e34-9b33-129a6ddd6e4c@gmail.com>

On Sat, Jan 11, 2025 at 09:50:19PM +0100, Heiner Kallweit wrote:
> In preparation of adding a source file with hwmon support, move the
> Realtek PHY driver to its own subdirectory and rename realtek.c to
> realtek_main.c.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

