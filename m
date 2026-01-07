Return-Path: <netdev+bounces-247733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E132CFDE13
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF07305A2EC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999F31B123;
	Wed,  7 Jan 2026 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dRQBrpQa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDE2E6CDF;
	Wed,  7 Jan 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791397; cv=none; b=nLWs9L1qZwO8Z9GKAhDXvw+qo08VDo9OOaDOM+3H7nYqJjSVaLRuFUjN4AwJ4W7TP8wngTzN0sLOmqdoO15M9A//qDnMYrkwj7XkNpBdtpLu0DVEX3d7LwdUJOY0HLpXThi2xOAcMQRCUR7/4PPfAsVK33rK66klz9UnaDdFuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791397; c=relaxed/simple;
	bh=x/fNEulSRFDJgkxg1u+6OwWgONJb1XcQNk5uCqGNPN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCTZvqyvwxqkQC35ajs6ewoeBRAoGDDt8qf7KVoKXCWOxn9AnjUB8nliH+sAv1eItAH22nqYwgl1Qt2qN4pp4ITHWVIwVGhv3e4glQ0JMCV4t1ac+Uvx+aV75Ah4Q0Uojv9hIV/WTqh6QJ16tPhbNlpr+dgrTo66lQperNLA2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dRQBrpQa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J6Ca6UBs+bAIAtRFT9FF73/v9UNst9Zsyj6ukXXcpkA=; b=dRQBrpQaqrrCbwAadcDw0qQoJI
	F+pcYoNk4xUZ+tD4+9Y4cHhovYRhDxjFZxlwgT3+31px3vxce2lYjCCyfZ92W3v9C0YIL01LeGZi5
	1PHa4IyqnilxyiGbcPp3ZB22+SEYNcNqCC/erGrgYMHxu7Q5SaqHzkVSPCyeWzUlGf6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdTIG-001nn0-5f; Wed, 07 Jan 2026 14:09:44 +0100
Date: Wed, 7 Jan 2026 14:09:44 +0100
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
Message-ID: <970a1e2d-c1b1-4b96-9e8e-71aea6b6dc44@lunn.ch>
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

As i said, DT describes hardware, the fact there is an LED, what bus
it is on, colour etc, is describing hardware. How you blink it is
policy, so i expect the DT Maintainers will push back on putting
policy into DT.

So i think your best way forwards is as Russell suggests, some form of
firmware sets the LED before Linux takes control of it. Or udev.

	Andrew

