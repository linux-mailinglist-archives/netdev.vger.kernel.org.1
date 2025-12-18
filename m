Return-Path: <netdev+bounces-245312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4CCCB51B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCE0303FE56
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168033D4ED;
	Thu, 18 Dec 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CFhOZ7Ml"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E9332EA1;
	Thu, 18 Dec 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052803; cv=none; b=Myz5+BV4vdUicwZdXFJSTRZWbliCTEd41ZYV04ce+OYhXjwv3aW22NYIRkJv1jVxmVl5y6xdIHunxfrQhX6/gxW2+QGy46W+QmYawZkHNDdndqeJEG9GfEGq9fZyiF82s9OevhJBCX4eQAqJU/Kb40kSO5NB5M31j+QSANFzcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052803; c=relaxed/simple;
	bh=MORH4mmXUqLCRAvrb86ZODqRJHJHSpqjKpxHcUSqBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be6mr9HRdQGF8sHl29YIyvuEAzf0okzNhDxun6OxXa9+wpKDQdnPoz6tsPLYNj5Y/oaTZcm9hB6ejuT49DMzmGLgoSgPaITkX9WqXL+i76e7s49L1RzrIgPw1J/QCa5hKmV0eghGF5srWKPLFCsCmvwiMpTkgQSsrox7G3/DfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CFhOZ7Ml; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=soMAlyiDMfn64pi8vHJfwuCi0d3vCrDnMLv5mh3FYfI=; b=CFhOZ7MlnZGZT5p8exV0eLlMS7
	F9N/Fe/Voe5juLXcjsq/DaFY26cc609Jfh+i4oHEyFmd3IYCI+G4OF8Mr9hMBxjgKA0R1ht8P/aXg
	Ea8ligzTEBQ2Kzyc79pVit2HoXnhsxTPTEWqsSumvysrSJBVdTx5inKrzHckIs+488qg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vWB08-00HK4g-W5; Thu, 18 Dec 2025 11:12:53 +0100
Date: Thu, 18 Dec 2025 11:12:52 +0100
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
Message-ID: <7d6fd4f6-3cc3-4a42-a726-6cbc4d902cc3@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
 <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>

On Thu, Dec 18, 2025 at 09:35:44AM +0800, Jijie Shao wrote:
> 
> on 2025/12/17 21:53, Andrew Lunn wrote:
> > > Some of our boards have only one LED, and we want to indicate both
> > > link and active(TX and RX) status simultaneously.
> > Configuration is generally policy, which is normally done in
> > userspace. I would suggest a udev rule.
> > 
> > 	Andrew
> 
> Yes, the PHY LED framework supports configuration from user space,
> allowing users to configure their preferred policies according to their own requirements.
> I believe this is the original intention of the LED framework.
> 
> However, we cannot require users to actively configure policies,
> nor can we restrict the types of OS versions they use.
> Therefore, I personally think that the driver should still provide a reasonable default policy
> to ensure that the LED behavior meets the needs of most scenarios.

The DT Maintainers are likely to push back if you add this to the DT
binding. You are not really describing the hardware.

In your case, it is the MAC driver which has access to the
configuration you want to use. So please think about how you can add
an API a MAC driver could use. It is not so easy, since the PHY led is
just a Linux LED. It can be used for anything, any trigger can be
assigned to it, like the heartbeat, CPU load, disc activity, etc. You
also need to look at keeping the state synchronised. The netdev
trigger will read the state of the LED when it is bound to the
LED. After that, it assumes it is controlling the LED. Any changes
which go direct to the LED will not be seen by the LED trigger.

	Andrew

