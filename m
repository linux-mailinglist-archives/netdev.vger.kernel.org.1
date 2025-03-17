Return-Path: <netdev+bounces-175450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B2A65FBE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C167ADAE5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E81EFFB1;
	Mon, 17 Mar 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaIVETHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB461DDC15
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244606; cv=none; b=iYViSKvNO8j1dHRWXr5Gjq0f0KX6m9f9ohQ/He4+QkkP8s6xah8iid4IOZT1Q5zo85E6ehL097S5GNMI546cE9HvWD7z0jjfub1bGYslwkPXQha2oVKBPJx/ggS/OPs3Lg1E/DLQjTlbuHmTsoqXgWL2pl82FEN6GT4etwFA6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244606; c=relaxed/simple;
	bh=6vR4oVn5gwbBNTOnRKfzlimn1crrVznyEE+DAqcADG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h2z2wtq6Q/n5xwexU+MDimYNQ3j5+c0uDSpkbWp42uUGGAX/pwL/sXQ8pXYTqZysND9Ie2+x4oLxC+kBwyh28PzL0cQ7VOnMOKkmfj7nhHOSFjJH2S/tY1aPedaMGRjpITz8uAjNsvZk5HPrGf0ZV8GXYxeqj8czTTyiel49bN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaIVETHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64035C4CEED;
	Mon, 17 Mar 2025 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244605;
	bh=6vR4oVn5gwbBNTOnRKfzlimn1crrVznyEE+DAqcADG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DaIVETHQ1RtrA/GU4pm+dgWddgYrpRmtCxEse5S68/Zz4GELUEb9MZ1AtXJ8OOKrQ
	 qZjjISvNWNCgdedXm3OseisU2eLvK/wyscFc/hf+2OuxPXYalxvECiFHHQ1oONaUVL
	 oQh/xMCmwX51XBT+GDeaRFtITLlcq0wx16+wU6haOxDBn8TVr30563z1TG35HwJMCp
	 ldca8Yp1iuOCM98JHE0CiJi56Udm8rrJMrrfAb+pBRszcNFT1fFhbl6hLyYmQPfiRH
	 c3H+xsY6dQO+QevsPyrYUcG0FA2br+PYTQZxP7n+1XdMlQ4kP8nRJFmUxqW8q5jC5m
	 sijFdpI9cmIEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0CB380DBE5;
	Mon, 17 Mar 2025 20:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: expand on .pcs_config() method
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224464075.3909531.12224613080946411173.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:50:40 +0000
References: <E1trb24-005oVq-Is@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1trb24-005oVq-Is@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 11:10:52 +0000 you wrote:
> Expand on the requirements of the .pcs_config() method documentation,
> specifically mentioning that it should cause minimal disruption to
> an established link, and that it should return a positive non-zero
> value when requiring the .pcs_an_restart() method to be called.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: expand on .pcs_config() method documentation
    https://git.kernel.org/netdev/net-next/c/35b862eac909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



