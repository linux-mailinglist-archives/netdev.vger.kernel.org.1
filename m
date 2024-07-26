Return-Path: <netdev+bounces-113251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8793D552
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B83B20D67
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47717BA6;
	Fri, 26 Jul 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol7buWOr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08B1DDD1;
	Fri, 26 Jul 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005367; cv=none; b=VDUyl9JXeGYQdLr9qLf1Dgkw5XzX3F1hn284bMwk9FEm2GBzUhu8RI0967Ku/1M2LBUHPtFv/dkbmEbBPEwXFB8i4CoXvjOBatgBbN0U4WW3DCuA2sg0/yY56elExY3FY7nwBxBIEaaCE7/4tG6DXEJekoC++s/baAAQh6EJCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005367; c=relaxed/simple;
	bh=4GFJZLMrAdY9KWRAf4UVz2WdvnaCeqnj6naoNa1goLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXc4o1E2+ad4eSVxiY73EBt2FBrNc8Ram58d3Jxlb6UJQz5kDUqp7be39E+UbfguImPNix/rjzCXN2wZibTjFvmN/0fix+ltLvNmOZrknJoAJmTnQdMOVEh6O+HurncxA2e50hxP/3ISTLXQFCoOMTwTBrdN44lrHr8vLF9/L2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol7buWOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F3C32782;
	Fri, 26 Jul 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722005367;
	bh=4GFJZLMrAdY9KWRAf4UVz2WdvnaCeqnj6naoNa1goLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ol7buWOrLpU7zsLZL5HED/iQ1+OTqaGj6NcZObwkSHaI04bIKuWADgO1fmz1bUYP0
	 /CvfQ3N3ACd4Jx0BJDHVplLx82PJif45vq1Lq0DSIdp4QpCEJ71U9BvlQTD0WzBDNA
	 kJoegBuDLB5x8JZjvPPdHE8OyF928ijyyq/BOOG4TlDmsquvpJYQRDtclTHgiEI+3H
	 bu6AEQipX5UMJ9ynh7uLlvd3gNZAAYa1ovU4w0+z8K+2Ro1U9QrKsxEztRrBzdG6oM
	 K8rBrqq1SogyAQhv1yRussROm/V7avvWKERS+FEWjv9p2CsiUu5OeQl96/AdM00ewH
	 J/78JZMcVRZNg==
Date: Fri, 26 Jul 2024 07:49:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, lucas.demarchi@intel.com, mcgrof@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <20240726074925.1c7df571@kernel.org>
In-Reply-To: <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
References: <20240724145458.440023-1-jtornosm@redhat.com>
	<20240724161020.442958-1-jtornosm@redhat.com>
	<8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 00:57:05 +0200 Andrew Lunn wrote:
> Maybe a better solution is to first build an initramfs with
> everything, plus the kitchen sink. Boot it, and then look at what has
> been loaded in order to get the rootfs mounted. Then update the
> initramfs with just what is needed? That should be pretty generic,
> with throw out networking ig NFS root is not used, just load JFFS2 and
> a NAND driver if it was used for the rootfs, etc.

Sorry for a dumb question from the audience but how does this work 
for PCI devices? We don't worry about what drivers may be needed
because there's no "fallback / generic" driver?
For MDIO are the ID registers too complicated to expose to user space
and let it match the drivers using modinfo (avoiding the need to boot
a kitchen sink kernel)?

