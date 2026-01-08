Return-Path: <netdev+bounces-248092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3569D034EB
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3227731E6ED9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E123B4DDCDA;
	Thu,  8 Jan 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ISVsJchs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3E4DDCE4;
	Thu,  8 Jan 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880794; cv=none; b=hUsNbDcv5zqfV1xnTINPvenvYtoCGWaM1iNMf5EmiPbRiJ8+0mAxPk3BoDp8CDVtKrJl1cFFkdKGNrE89On+xDQPJfVbJcAg2TavuspA2HT1QToLw3nSdwRaKimFyxhPM5vHOOWlUAfaAXuipjKQ6/lZ3mlKk3JORfIQkIn9Vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880794; c=relaxed/simple;
	bh=SV1vfA3DDmlDwoSyLgZGwcMpsQkhB0gPTppk6+ZHqvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLfN2DM1bRYjU5a96pVW93nDmmnLp7Xhhodc75szfc5FbxTi3ko+yqm0FNKK4YqOtFrG4fPESn+BIAEFskQyYA7K+zTv21gxFa4c25RFRqa40Y0cqvn252uD3IXix2KLN5bDz9t14YvUgZJIQHNpk1CjnrkdEb1vfpq6redHamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ISVsJchs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=40SDH+D72wcbssB7qIIFgRlJ+4oHszNF24AJeHNECOQ=; b=ISVsJchs8yZlrYctilabY4Vkmo
	aW+fSJ0aFXTzL6P6yxT1fGBew2MHPIE5Hlka0oSZFfGHu3EDsOmR8TgQuzk57HmWtqlI+mWL/RzOs
	rf6oSxCZgRSSVWmeuOKVn581ETPYV0dUAq9lpnZi7ysVuQP+Hg2o/r5/rtvqAoCWghz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdqY5-001xMl-Ms; Thu, 08 Jan 2026 14:59:37 +0100
Date: Thu, 8 Jan 2026 14:59:37 +0100
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
Subject: Re: [PATCH RFC net-next 3/6] net: hibmcge: create a software node
 for phy_led
Message-ID: <b23a63c0-110c-49ab-8189-670717f243a3@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-4-shaojijie@huawei.com>
 <543efb90-da56-4190-afa7-665d32303c8c@lunn.ch>
 <fd6f70bc-b563-4eff-97c3-1b7ad79ca093@huawei.com>
 <eaf25bd7-4211-45ca-a747-5039d69bd57c@lunn.ch>
 <e403251c-c874-46ff-a7e2-442b18bc2c92@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e403251c-c874-46ff-a7e2-442b18bc2c92@huawei.com>

> I did some research, and it seems that our board uses ACPI,
> so it might not be possible to use this method.
> 
> If we rely on ACPI, we would need to ask the BIOS team to add ACPI entries.
> I need to communicate with the customer's BIOS team, which may not be easy.

If you are going the ACPI route, please take a look at:

Documentation/firmware-guide/acpi/dsd/phy.rst

The basic structure of how to list PHYs is defined here.

And you also want to look at:

Documentation/firmware-guide/acpi/dsd/leds.rst

Since you are describing LEDs on a PHY. You will probably need to
extend phy.rst to reference leds.rst.

      Andrew

