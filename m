Return-Path: <netdev+bounces-165365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8200A31BEB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6329D3A7BFF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42017C210;
	Wed, 12 Feb 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xsXzw+XF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80298F77
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326992; cv=none; b=Gn+sRLgr5t+Q3wMZ2x19ANjSOocLm7UvO7o2bd7/ZMrXt8EXp7basdR5pqCW4gSKQjiw3R2iCuT3QcbtfgfJ2ECCTFi0O74kZaZsRpkibZyoPRg9RC9ybbUqgVIfPk21FwTMtGpARfifW5Vc26bTd2PeIDMD4DpCPRpl80Uvj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326992; c=relaxed/simple;
	bh=4HAmLj010nY2gPNo8DgOEGZXB8pYA1Q1V9JzQDH2jIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm+Ei7pWKhYeVlsurdpjrRdtYg1+ju3aJo8IAIxCedKc4oKu0YqtL7O26MmLGv/DqRAfPysugKVVIx0YyjXQT0JY7QFwBd9YE5F+pCghgBkcIeQKBYSaOlXsyMIHvryP5kzU2g/C6mcHS60GfTdWkY5edJEY/SQdJSJdTtl+R0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xsXzw+XF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9VMrZtmQsSWBjQcEt+8F4A6rzKygAELxJyMT3593igo=; b=xsXzw+XFutPd6cqPQWdwUooo6E
	i+du6in62/l/X8RgnHJBF3sMTx7TxaMLWNVAEmz3CypSjRqt6vpA0MJlq9wWFHm5JUK7FczkkEOwM
	QicwmJZhzn6BE+YbVKnnl30Vw4lg75RtgkOqtWvtVotMsWFWDScuBL0pPSDiMqsJ55bQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti2Oz-00DFaW-Jx; Wed, 12 Feb 2025 03:23:01 +0100
Date: Wed, 12 Feb 2025 03:23:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v6 6/7] net: selftests: Export
 net_test_phy_loopback_*
Message-ID: <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-7-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-7-gerhard@engleder-embedded.com>

On Sun, Feb 09, 2025 at 08:08:26PM +0100, Gerhard Engleder wrote:
> net_selftests() provides a generic set of selftests for netdevs with
> PHY. Those selftests rely on an existing link to inherit the speed for
> the loopback mode.
> 
> net_selftests() is not designed to extend existing selftests of drivers,
> but with net_test_phy_loopback_* it contains useful test infrastructure.

It might not of originally been designed for that, but i think it can
be used as an extension. I've done the same for statistics, which uses
the same API.

For get_sset_count() you call net_selftest_get_count() and then add on
the number of driver specific tests. For ethtool_get_strings() first
call net_selftest_get_strings() and then append the driver tests
afterwards. For self_test, first call net_selftest() and then do the
driver specific tests.

I also think you can extend these tests to cover different speeds.
There are plenty of ethtool_test_flags bit free, so you can use one of
them to indicate the reserved value in ethtool_test contains a speed.
Everybody then gains from your work.

	Andrew

