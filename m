Return-Path: <netdev+bounces-248106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B10D03DBC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 962FA302B914
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E0342507;
	Thu,  8 Jan 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MDY9Ne0g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904332D641C;
	Thu,  8 Jan 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882736; cv=none; b=g1M9J84yz666I+IpuJtapJ1za3vk7LcFeP05t6OYYWo6FDv30Okf1rAgGKDjH89dRQXjW35SMRu6mEXnrgTZQGFLxP3GuCZOdWiuMkJUkRloc9sVwtFzxC2HW9PUoTmRW5bYUTQLQXayEfAOrC9GIVNSzYZxsx7WuGIkKm+kK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882736; c=relaxed/simple;
	bh=75sU1pnzkYdOyK+Xa922WehXLcn+nA8/e8ViucVg6bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIfrE8rogSlhrmjqQZeEIghJMcgM0a7tPK69vjdncELmwMtVjy7M4mDIrTgB0805yQpYalN8uvfs0Ha0lSwIUCk1rBTLAVAKDS4CCJ+hYQi3WXVx4r96plBCE4TQRZCnvurlOMU3nVQACy4fzS5SoDPwotyAsUtq4hLI7dXGE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MDY9Ne0g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Re7M6LdtvhdNqEYL+EBdoJ128eL4bJjgUYnGGAfRk9I=; b=MDY9Ne0gm8qsafCUwSHfeCT6mn
	BG628dCjMo3ScozAmmZg6U0JDPLREFDMSE3J+ODlcSF44BFx+7i3If85AhiKuBJOqieycF+89YCrP
	8UJ9y78kl4sAySZxSZu4tKP29g8EBGHqYCeCcUQMVVZRu3TvyB8a4iG53LGIt9C8ZKLE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdr3P-001xdV-TC; Thu, 08 Jan 2026 15:31:59 +0100
Date: Thu, 8 Jan 2026 15:31:59 +0100
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
Message-ID: <b2cc74c0-d63f-418b-9c28-f7a143f61bd3@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
 <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>
 <970a1e2d-c1b1-4b96-9e8e-71aea6b6dc44@lunn.ch>
 <178a0dc6-438b-4f6f-9cf3-0fb36f7953b3@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178a0dc6-438b-4f6f-9cf3-0fb36f7953b3@huawei.com>

> However, there is no way to handle the issue with another patch;
> I cannot directly modify the ACPI table (a risky operation).

It should not be risky. ACPI tables have as many bugs as any other
software. You have to assume they are buggy and will get updated
during their lifetime, so you have processes in place to allow them to
be safely upgraded.

   Andrew

