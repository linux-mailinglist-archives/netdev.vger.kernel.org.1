Return-Path: <netdev+bounces-156521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A7AA06C57
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A6B164074
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01713B7AE;
	Thu,  9 Jan 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCV2fwwM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1072AE8C;
	Thu,  9 Jan 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394008; cv=none; b=Dmc8KomAP5lauBTr9ChnYVw9NIS5h4EPLcttU54aRtiyoF3NqERFycJu1U/4I4N5KTswZJPo5weEA9K9rAmplfO0IzAixEjaWkAslir2shBmrjoJVfC6Dilb3F1U7eQJckrDUQ4CCutHKr55n6dlLU4YMHTDdEWkzA5aw0KcVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394008; c=relaxed/simple;
	bh=Odlt3PXU9AZTBZsbiZcERPyInIU1wmU8mY24xb0mfG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8SIaBe4kO1htX8+KwiJAenDfi0Aivppo5cx4aBAZjicq5UP3XmQoMLRGn3nr/+m2uJ6IsfD/BkCvP2S3GU25w0Ek/NGMHJVl7DcJAXURUFlLCXnX5kNOfnlhg+3ZC5WO3Di2XyGpnPikqTdY3W10ldsjQy6fCZxTVk57ThqT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCV2fwwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99678C4CED2;
	Thu,  9 Jan 2025 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736394007;
	bh=Odlt3PXU9AZTBZsbiZcERPyInIU1wmU8mY24xb0mfG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCV2fwwMPIdle8CvxS3y7cizRdWuO0ZToxif5VP9jBnz9Jmp8+fWfy5Cz98DLkcpI
	 0gO978FvoNdnyo97XbeT3AUGbQ0Y4quCNEHE7bsLkJeJvpJ42gwEpT54Pijw2NCYuf
	 faFkqz+omwc6xabuCGNKkmoyPbVHZ1U/kohdQwI1MHGI0Zft29PNbbWORwrH+immtH
	 QpSOvu4YAjpxLGUFp0ruZW679mAyIi0AMYD+U0Vz/G04rEKVCVfPCyN81wXqNUMsql
	 4lrCHyZZ48FDCeaLLXE+qQKSfZejSZMUF4+8mxOZRwqjcrXkUvmA27RDKxxWWAFg52
	 jiACmNngqD1Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E37380A965;
	Thu,  9 Jan 2025 03:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: pse-pd: Fix unusual character in
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173639402926.861924.10694042923792739546.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 03:40:29 +0000
References: <20250107142659.425877-1-kory.maincent@bootlin.com>
In-Reply-To: <20250107142659.425877-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jan 2025 15:26:59 +0100 you wrote:
> The documentation contained an unusual character due to an issue in my
> personal b4 setup. Fix the problem by providing the correct PSE Pinout
> Alternatives table number description.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: pse-pd: Fix unusual character in documentation
    https://git.kernel.org/netdev/net/c/d1bf27c4e176

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



