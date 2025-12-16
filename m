Return-Path: <netdev+bounces-244900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBCCC13ED
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7788E300FF8B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A333C1A5;
	Tue, 16 Dec 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BE279pyT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4D337BA2;
	Tue, 16 Dec 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869001; cv=none; b=hJ77OJYyVFY5zt7+jX7dGP8yx3QgDuF2WoxhL0NFaiyytZXGUzDSdPOByXiz+iydnJXBIPd2ffHKE4zHoJmxlidNrlhQi26p2bo8hVdx+TcRPijRsqyflPdsiPACvyDZ109Wjo5P8QUEXZGXA4JFblIVGEC9NQvR8xEwWxgAFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869001; c=relaxed/simple;
	bh=zewWPHqj3qLtIuQ5bRx7ZkvBavCkRbzjEFAA7Em2KUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCEAiI29HcagAjjK4KNsE+RbTC/P1c6Y+gk/ve2EPrLiJOQtfZ0w8Af/VE43ktBWbimi4YTCh0+jILp47puxQ2B6tIEdTSWhPQ9c3JOL2r8UCzHnMJQFHIdzF7kX3YhANZhmpO88OPqHeqpBtOt7B6BeS0Aaa8t+rv6Ya7lrbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BE279pyT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gg+NXefIJE+op95YZoQ8Qgxx2DSSa+JKHFHsw/Ma6jc=; b=BE279pyTafuRsdO44U2LuACanD
	Vusz6kVffkmS+vm9KrvYFLDKInjSCqngCJUnHRZghrMawKolGVmSXI4+ZFFfJQYVYMa3c5sS8znaZ
	dgvE0HpaiXK8d9j7z7Aof4OripBVYkHpPIXBPrFgb1T5C31y5hQ9NRUCzkfHFFpk+4+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVPBZ-00H5Nv-Sv; Tue, 16 Dec 2025 08:09:29 +0100
Date: Tue, 16 Dec 2025 08:09:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
Message-ID: <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215125705.1567527-3-shaojijie@huawei.com>

On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
> The node of led need add new property: rules,
> and rules can be set as:
> BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)

Please could you expand this description. It is not clear to my why it
is needed. OF systems have not needed it so far. What is special about
your hardware?

Also, it looks like you are expanding the DT binding, so you need to
update the binding .yaml file.

	Andrew

