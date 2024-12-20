Return-Path: <netdev+bounces-153579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF19F8ABB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4C2188B99E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC74A7DA93;
	Fri, 20 Dec 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8fdGa06"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3D2594B5;
	Fri, 20 Dec 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666865; cv=none; b=Gts894D9RWUPtHqRxkUKZKocTRL4VeuTK1EcIFkgpN5sNtIgSjEE00lGAWvdgMMHVP1E2EPfgwqSK2Lgfr5GxOlszVL4HOel4ctGspxMVu1jFn7NQT+XsWEnBr6nR8yUEIgcOp7YCPOQrNeiiiyqwvRdTlJVCsWjP9A65/npJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666865; c=relaxed/simple;
	bh=DcUUVRtgrPJFsbdG0iucOYQrDt+7D6X6mTi7N+SqfwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIzfqDgtcfdJpocDcN/67hwj5dp1yLORYtxyxWaIbXkBdowBxlWGFOvrmVGPJPMl2cdnFufUCN/u1rVn1EyMtPlgyjVw/6Ro4UIUEeMGmHeohQRyaXHjJfGxXHdEQWErVMn53tsI2fFCXIsWiIoUAeZ4j4RJmthch5RkK4tp/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8fdGa06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A579C4CEDD;
	Fri, 20 Dec 2024 03:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666865;
	bh=DcUUVRtgrPJFsbdG0iucOYQrDt+7D6X6mTi7N+SqfwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U8fdGa06Druqg8pNEQSz9yKd7GwjXDuPcb5o6Opv3oS6VgqwlxuDNYxP5IrwVLgfj
	 xK4USAAGTGY/YRO2RGMy6JSx4mq8st2dn2lcIou98kgdnUFnUbCpEXbfy9oGQ/t7mf
	 ZiwTYIp3P+3CWhHqDAJ6dDCb4WKJ9wjbRakWMiaO98WDAm4PjmiVcmT+7ff4uRDi4U
	 J0LM2PB99rbuxE6JCYzDjMMSxddwT63Mx4zESMUAV44e9ZrKCCe5cKKw4miSB5kPsD
	 FDomRHryrMFnfb2bTKgveDwTYk//EJy3ii8nHgmXL2PcOfpYtd23MC3vq6eaBjJWcR
	 PYSdjnp1oPYtg==
Date: Thu, 19 Dec 2024 19:54:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/8] Introduce unified and structured PHY
Message-ID: <20241219195423.0bba4ac8@kernel.org>
In-Reply-To: <20241219132534.725051-1-o.rempel@pengutronix.de>
References: <20241219132534.725051-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 14:25:26 +0100 Oleksij Rempel wrote:
> This patch set introduces a unified and well-structured interface for
> reporting PHY statistics. Instead of relying on arbitrary strings in PHY
> drivers, this interface provides a consistent and structured way to
> expose PHY statistics to userspace via ethtool.
> 
> The initial groundwork for this effort was laid by Jakub Kicinski, who
> contributed patches to plumb PHY statistics to drivers and added support
> for structured statistics in ethtool. Building on Jakub's work, I tested
> the implementation with several PHYs, addressed a few issues, and added
> support for statistics in two specific PHY drivers.
> 
> changes are tracked in separate patches.

At a glance looks like it doesn't pass allmodconfig build:

ld: vmlinux.o: in function `linkstate_prepare_data':
linkstate.c:(.text+0x21192f1): undefined reference to `phy_ethtool_get_link_ext_stats'
ld: vmlinux.o: in function `stats_prepare_data':
stats.c:(.text+0x212a66f): undefined reference to `phy_ethtool_get_phy_stats'

There are also kdoc warnings in patch 2.
-- 
pw-bot: cr

