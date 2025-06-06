Return-Path: <netdev+bounces-195470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA5AD053B
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EB07A85EC
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDAD276048;
	Fri,  6 Jun 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="spiAtinw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82562857D2
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224015; cv=none; b=fVjUkeQz84uU009VYcozW6KPl2h1CbUnrt/TL/bjuaJiQzEtewfeYRYeI5rLI8rr6uVi44zaGRPijJMXNT4zHVpV/Un+Pp1OK9esW8SbLnAI9iwTlOJZcbdn5YOkJ4pDRtO/F5XyjmjuCOJ+84KCgb6fytl6BS8VqtNl3lXz9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224015; c=relaxed/simple;
	bh=yrrvEUsGejDb4MgrN4fX6r6vc1+AZFdj+7v8Mr3OA4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVzKGg3XMk31kNF2nupwnhab7BhlNFT+qJkUX9o99TibyvtPCq7KPyO2ycqaj08KQZSaw2EPu6Duy6ARhQX4/Z39I0IajF1BD5DF2Lql3ap5ssdfxaKFVKDhqZgR7+1ct9vDeVuPgsWhtOjQRwrUUb6Gi5tZemVZ2sLgoPL+qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=spiAtinw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M5uCMltrqOLx4yXmLE6fMYrmmFVatfGQQdt8aLZIefQ=; b=spiAtinwq6qit2I1qgbdF618I2
	Ciq8Ut9BkmLTXgqr03Ozx+IJGhBXfN3Qjty7VG0BDWw9moBeUMcjSnlOu1hW4BJ5jhCsOaDt9sKMg
	EZ1Wt1LPwnJPf83XgiKErLoCPDA4Dvs1rN7NUHXFNz1+vjueDDr/LYIWWLo7Rm7nCkpc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNZ4T-00Eufd-Qo; Fri, 06 Jun 2025 17:33:29 +0200
Date: Fri, 6 Jun 2025 17:33:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>

> So I'm a bit out of my element here and not sure how to check that.

No problems.

Please show us the output from ethtool -m, both the pretty printed and
the raw hex.

The relevant code is:

https://elixir.bootlin.com/linux/v6.15/source/drivers/net/phy/sfp.c#L872
https://elixir.bootlin.com/linux/v6.15/source/include/linux/sfp.h#L400

I don't think the pritty printed ethtool output shows it, but we
should be able to decode the raw hex, byte 83, bit 4. A lot depends on
how broken the SFP is. 

Or you can put a printk() in sfp_soft_start_poll().

You might also want to add #define DEBUG at the
very top of sfp.c, so you get debug prints with state changes. And
then pull the cable out/plug it in and see what gets reported.

	Andrew

