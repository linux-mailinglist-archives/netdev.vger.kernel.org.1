Return-Path: <netdev+bounces-248237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2ED05983
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1613016FA0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5FB2F9D83;
	Thu,  8 Jan 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sn58gEEb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725121CC60;
	Thu,  8 Jan 2026 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897359; cv=none; b=TmhDGMFhXUhJUJrzdPVNPzm/DkykMofzrB2FQuVdCba60FeVyzHcaKyH51s9dxOhrKRDbm78wzJZImiI220V37feYd0I/pMezPZA6EondaWKcgi7ClKYCY9OniIBcSkitEVDxkFay7Rj7yzBKJQ+K5f3pevdLWo6Ied01kJp8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897359; c=relaxed/simple;
	bh=SXnapadtA8/ofLMqsUPOPI341w3s8uxWgZUT001gtS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzcUzGbsbFNpZ62MHTMEyQ8vz+O4K0kQ4YJY3gv7GaEoWqdc/SfVfX0oJPLIgXw0XOEvsYOQgMmLorVd5RgRGa3+JH2jRYZqzxBsFFDc0Zf+Hm4VvaZu8kZS3CM9sQPl6J38kMnSkpEiVui8Ai2J71cWwq7xxjoTP5RBUOYgKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sn58gEEb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WPnqWHOoqlWxaJ0+3b9XAdRiUj55tRDFUmW6FBbxGms=; b=sn58gEEbRmUnfrUiXYec1I5QtV
	Q7CCLNSWwOOslu+6xOCBr1h/11aS1ILHIp/tSNbdpqSvX2VZGA1D5TcMOUq079bRluwJrOYZ9Tx5e
	BMe1Y1iQFLKfWCQshVrXmxRUmSia9htfZ9dz4QqRM7xTiJCL40Mqyec3btRYeEdBeHvM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdurD-0020Ek-F8; Thu, 08 Jan 2026 19:35:39 +0100
Date: Thu, 8 Jan 2026 19:35:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	lantao5@huawei.com, jonathan.cameron@huawei.com,
	salil.mehta@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: change of_phy_leds() to
 fwnode_phy_leds()
Message-ID: <1fb20d7d-bb17-4446-aa93-9ad5820bb9e1@lunn.ch>
References: <20260108073405.3036482-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108073405.3036482-1-shaojijie@huawei.com>

On Thu, Jan 08, 2026 at 03:34:05PM +0800, Jijie Shao wrote:
> Change of_phy_leds() to fwnode_phy_leds(), to support
> of node, acpi node, and software node together.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

I would prefer this is part of a patchset adding full support for PHY
leds via ACPI. The binding documentation needs updates to match the
code.

    Andrew

---
pw-bot: cr

