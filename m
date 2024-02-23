Return-Path: <netdev+bounces-74211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A422386075F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9271F23EE5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4129A2;
	Fri, 23 Feb 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzHw7p+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA96FA7;
	Fri, 23 Feb 2024 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646561; cv=none; b=bv8kzhjLFhz6nY0ppV8Rn19v9Pi/xMcjkgm2RxWfbh3FFakuMWezbLGlENsx6NLIiXs+SfhvVN39HZcrZFd/IJGAM7Jzn+EZLuXJfeQ5SuX7o+/F3zzPTGewHxqGwCaAViKgjrDx7nE7Sjz53VtPOs3Xr/8C6eZ9OvYcy5YsNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646561; c=relaxed/simple;
	bh=lBK3QPbfYF3PC4M6SUzEbuTdix9B67gCJPMJAwRjhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKajRTCZhgjAeZGw51DPKPhmvO0xIVjaiYpTtj8E2Cy1g5anVI6qSCC7KDEspDmerhul9M1kbUEeEN7ffogw2l/5SQ04tRdmfcvdCaOsVHbgX3WMSPUXcL0tiXwm4vVW/cdu7PTt+5X8gYsYctvqkbg9frOma8zJnyCYCWnABvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzHw7p+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779AEC433F1;
	Fri, 23 Feb 2024 00:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646559;
	bh=lBK3QPbfYF3PC4M6SUzEbuTdix9B67gCJPMJAwRjhOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzHw7p+nF8YhocOvnyIANVwHKzQCRI9rx+Emt/0u48qSvKshBRXzqm9/RVXM72shC
	 30uhHhzl3o5cJBMR2fR1UE6RkYsmxqW9/QwxEfTNyAqrkFAi/Vhz2lVXBbjByX9vvF
	 JfFUAeue+9VNcKiL6OMrbOUpuE9rIaBfHWRTwI87diV7Fe5s/RaWPmjh6w77hN0ZwP
	 OUHWhf2zO5xYSw4hGG9JIqdPj/4OivWcux2DkQib5236gn0F7K6SchJ5b5Tc8lezk8
	 F4+PXsnRj+0NOUR8VN7X2dqDqcJOrUoMLnENkGzPwBwHwTrPyqSnNJ1rxtdVrsAFzZ
	 H6aBmCpNXJhhA==
Date: Thu, 22 Feb 2024 16:02:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, rafal@milecki.pl, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: bcmasp: Add support for PHY
 interrupts
Message-ID: <20240222160237.0cc1284f@kernel.org>
In-Reply-To: <20240222160125.5aae2231@kernel.org>
References: <20240222205644.707326-1-justin.chen@broadcom.com>
	<20240222205644.707326-7-justin.chen@broadcom.com>
	<34ee3b60-3560-4e22-be79-b191e7b9e91d@broadcom.com>
	<20240222160125.5aae2231@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:01:25 -0800 Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 13:56:45 -0800 Florian Fainelli wrote:
> > > +		if (intf->internal_phy)
> > > +			dev->phydev->irq = PHY_MAC_INTERRUPT;    
> > 
> > There will be a trivial conflict here due to 
> > 5b76d928f8b779a1b19c5842e7cabee4cbb610c3 ("net: bcmasp: Indicate MAC is 
> > in charge of PHY PM")  
> 
> FWIW the trees have now converged so the series no longer applies.
> Please rebase & resend.

To be clear - after you waited the 24h. No special dispensation :S

