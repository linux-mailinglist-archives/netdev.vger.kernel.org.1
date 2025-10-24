Return-Path: <netdev+bounces-232385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EFC05298
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066A51A00D5E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D7305E19;
	Fri, 24 Oct 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fF/h/IEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0B1E1C1A
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295608; cv=none; b=rCAczUsTiuUx6lAiWjb5RNMY6C6IgB9Et3GhkY7Ul1MK6uirKi541rA+GByjuX9FFZObVpAVmdiEkfxCFXoeLpZrQuj+x7hP3gqZXGGOptopIxqq1X9/KPohmPDCWa1JpULbodLyjdB1zyhC6mfG/ji+ea/y+q8OiLmkOeuIHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295608; c=relaxed/simple;
	bh=7NTSYxzKGmhxTqjYGUpBrKwqj3vK5IEOp4i6e4/crwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phaAssyMSjlGaz3/LlF1xYbvEI59UnT1pfjuTUuCN1GzFRL4jzzA9gxxMHaMT/shMIZku2iV91UWk1L1Q2tQre9v/U5lgXTnWNS0ZUnxHZH2AqTzfzo4U3dMNa7pOUCCdMnv5M/hSVryodQHQrtwh9PjsiHzf7dJURdbi8tFJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fF/h/IEp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22E434E41268;
	Fri, 24 Oct 2025 08:46:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E676660703;
	Fri, 24 Oct 2025 08:46:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E84D1102F2418;
	Fri, 24 Oct 2025 10:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761295598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/FJvkjQlV+KcGybdpGHVwySBniEBQVrsx6zHgsH/Pm8=;
	b=fF/h/IEpLmEYbGv8AIc21gmNOHFWK3B8F/+Czaw1MnNl2oiavQ842+VmD66TRUKib0YWKx
	YoPH1Tx0VXwdrqpn4Xw9Y271XqVglfNrno0bzj27T0OcKAkRZPPNc9brloyCFCSSHXNf7p
	5bZm73prx9a9l+nnWrjn7X/QsQA8CwS/FGBKDd4uqbLv7wvJ+rrChrcnQ0L1F8SVcd+MMp
	VAEmU6VLE47rzEaF8Uxzwf6i35m5FZTzjXkD2+1lUJMtttwqg8hbF8mmYL8lG9bhKw6QJC
	qhcsRPXzHsNTi3Z7bAwWUw2+eobj1thoWMOYJuMiN3zrR3watF80WpbuFFTPXQ==
Message-ID: <e9aa0470-2bd2-4825-8333-ad9dbc7f40a0@bootlin.com>
Date: Fri, 24 Oct 2025 10:46:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] net: loopback: Extend netdev features with new
 loopback modes
To: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Breno Leitao <leitao@debian.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>
References: <20251024044849.1098222-1-hkelam@marvell.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251024044849.1098222-1-hkelam@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

+Russell +Oleksij

On 24/10/2025 06:48, Hariprasad Kelam wrote:
> This patch enhances loopback support by exposing new loopback modes
> (e.g., MAC, SERDES) to userspace. These new modes are added extension
> to the existing netdev features.
> 
> This allows users to select the loopback at specific layer.
> 
> Below are new modes added:
> 
> MAC near end loopback
> 
> MAC far end loopback
> 
> SERDES loopback
> 
> Depending on the feedback will submit ethtool changes.

Good to see you're willing to tackle this work. However as Eric says,
I don't think the netdev_features is the right place for this :
 - These 3 loopback modes here may not be enough for some plaforms
 - This eludes all PHY-side and PCS-side loopback modes that we could
   also use.

If we want to expose these loopback modes to userspace, we may actually
need a dedicated ethtool netlink command for loopback configuration and
control. This could then hit netdev ethtool ops or phy_device ethtool
ops depending on the selected loopback point.

If you don't want to deal with the whole complexity of PHY loopback, you
can for now only hook into a newly introduced netdev ethtool ops dedicated
to loopback on the ethnl side, but keep the door open for PHY-side
loopback later on.

Maxime


