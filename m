Return-Path: <netdev+bounces-242146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C8C8CBD4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D74E93F1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362092C11CD;
	Thu, 27 Nov 2025 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpSwY2BC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE32C11FA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213449; cv=none; b=rpods+wQZJN8Gybd9C6RlHdT/cb3NUshc0TS7lsjErqGofsGaH5l8p9j0Pf7utJ2JebS03CVl7G5aiiRhj/hX6JSGdkkJcYZeVIf0KxKyfUk9bINH8Y3UwcSxSqfc8AgFnZ+7mzGP0aM5PXZ7+aBEFlbHY4zWZ4wwAYpdzbrYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213449; c=relaxed/simple;
	bh=qku0raxoJ6bt4WQ+fg8Wpisbq4tXEq0bL6oOn4Mxn6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1fBSRzFhSa3seKsFRyz1ZE6lNMZBZPmCHnia1ELcXpQLWn2ahvHxK6NaZ6tiAp3namx7Alr/V1V8RkSlTvNC9emSLwZHexrp+EKc95DBJV+1Koybfw7RH32s8npnzaU9o6oeWKdzAoF23EtyT9MS2yPeUi9xS8dsym3Bo0BCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpSwY2BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A394C116B1;
	Thu, 27 Nov 2025 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213448;
	bh=qku0raxoJ6bt4WQ+fg8Wpisbq4tXEq0bL6oOn4Mxn6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qpSwY2BCsqtxjie1hw3PXbyPkfnZ9brybkagaoO/Rjp7Icnk2ceaSWT7hLu5Nnt7Q
	 s3iv5/zsiru28ndJahLProfs4Dg7clr1rBUrDtruUyoqbmqupU3ylHOR3n0rFRontR
	 ghc8lWPijb7C+I5z6GYIT+1DegnHe2Q+AAk/a/VeDevV5CSzCRnVQVPTZnzbaqgWkH
	 Wg2o7k+xrNjSfacP+2LQfSz7H11eU+OOCHkNfHVkFFk3OaN43bE5sDerxv5uSQLwYp
	 1d0q69fOpZ828SUC2pLzx4INIqQrNlcrTwZqwWl4c/er6HY1rZDo1/h+pmDx3LdyU7
	 mbwnZHypgGtgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D18380CEF8;
	Thu, 27 Nov 2025 03:16:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dpaa: fman_memac: complete phylink support
 with
 2500base-x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421340999.1916399.2988230228455521319.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:49 +0000
References: <20251122115523.150260-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251122115523.150260-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com, sean.anderson@seco.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 alexander.wilhelm@westermo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:55:23 +0200 you wrote:
> The DPAA phylink conversion in the following commits partially developed
> code for handling the 2500base-x host interface mode (called "2.5G
> SGMII" in LS1043A/LS1046A reference manuals).
> 
> - 0fc83bd79589 ("net: fman: memac: Add serdes support")
> - 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> 
> [...]

Here is the summary with links:
  - [net-next] net: dpaa: fman_memac: complete phylink support with 2500base-x
    https://git.kernel.org/netdev/net-next/c/7241d80e7706

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



