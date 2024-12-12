Return-Path: <netdev+bounces-151423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C849EEC2D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE693166718
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05748217F40;
	Thu, 12 Dec 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVYvw50Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212B2153F0
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017415; cv=none; b=qEc1YyJcBRiOm5ll/ufD5X3gUQBy25wDonOJg+gRPzktIZVQhi8AUR3bHCNG755abGcByq0wTZ8SCymqgRgjA8un0IVrkzsJVqDedjkmvHDsWgmyAHCPwPAOLyYJNuWuAbYEA1uSyYSIy89d7oUj+E1/gB/MRb1d70kTGjc9TJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017415; c=relaxed/simple;
	bh=0wHqh50xDEo4XHPzaFvEOHP2FmLSw5mMhZFSXBRDs00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DcVrhPMkv437eKpQ9/n8BjJgrgrQNDBRJa5g4at/TK2iDmfEt3qXWJTf8NZb5+8oglhwviL/IfTnqJr/lCXx6VPZOno8fHxEKkN6x7JyYe873Wzbc9tlTueFugoVCjogIu4e1N9is41aaCsHo6k//xd6e4V/sDdnQYWdO7+Z3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVYvw50Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A4AC4CECE;
	Thu, 12 Dec 2024 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017415;
	bh=0wHqh50xDEo4XHPzaFvEOHP2FmLSw5mMhZFSXBRDs00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZVYvw50Z0bsljhlSCsPnAmJ79eQIS49RKntDsb2TZA6hwyLyFHmTHG1J/x/t4G3+U
	 JF+Pl37mhQqCAGD0jSmKltT4dd2zsZZ/VqUmdKNYlvtP+ge3zsnh6OLWyO0pIl9adq
	 ytRWPTflfnnhF2ObsRKJwmnAKQfPCYXdFDkgls9oWIPaSMX7XUbuQl48hHOjwIDAyk
	 394NXQ5yn5nKMBv1Gd+a7c+catNh0jbRC84Hfs52RtM7M0KR9LJnQyxG7KntOXb6jG
	 h4HIrK0jyrVF+hHfF8Rln3J+ICqLZ4oRcbjWrBdZYeEkiFD7rK52iAXXV7Q6ePXIsm
	 /jKJcMgChAtEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05F380A959;
	Thu, 12 Dec 2024 15:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: microchip: KSZ9896 register regmap alignment
 to 32 bit boundaries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173401743176.2337313.2319288875423878439.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 15:30:31 +0000
References: <20241211092932.26881-1-jesse.vangavere@scioteq.com>
In-Reply-To: <20241211092932.26881-1-jesse.vangavere@scioteq.com>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@rasmusvillemoes.dk, horms@kernel.org, jesse.vangavere@scioteq.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 10:29:32 +0100 you wrote:
> Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap
> alignment to 32 bit boundaries") fixed an issue whereby regmap_reg_range
> did not allow writes as 32 bit words to KSZ9477 PHY registers, this fix
> for KSZ9896 is adapted from there as the same errata is present in
> KSZ9896C as "Module 5: Certain PHY registers must be written as pairs
> instead of singly" the explanation below is likewise taken from this
> commit.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries
    https://git.kernel.org/netdev/net/c/5af53577c64f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



