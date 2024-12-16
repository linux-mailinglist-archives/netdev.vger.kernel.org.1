Return-Path: <netdev+bounces-152053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBA9F2896
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDD7A02D7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB52F852;
	Mon, 16 Dec 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW4RpTnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9A847B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318613; cv=none; b=lWY/FZH4dz/NGSDDKPIA2wwHCM5PAYR5VPMz2Aqou/ewNixR/dCBwSnOL68FiVf9hCF6AYnAB1EdAsJ0l8GgP/4zMBvQUe4FriACwvJ4F5MYBtWBqv0DdegIWTA/ityAAkKRYj20MGCwNuUyRYTBlzlLWVuPhF7yx914AypxxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318613; c=relaxed/simple;
	bh=k9JuNsjHVT9dqJ6aMZI7XQkpbfprDrYAezd8vDfsLMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VY9od/jUe4U33xkvPvhPlHgDhonIvvK1mpXR1VSKDGyRaeTYUD3CLy+74yvJaX+eSjV/36a55zWiAeVNcMYSp1p+QR5xrNxnp/YYtn/TnqKLZnLJL6clZ3UL/1KkUewQF/mA3ol1pS9V0jKT22Y13IiTvbIfkNolBSQ+tSwXXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW4RpTnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED1C4CECE;
	Mon, 16 Dec 2024 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734318612;
	bh=k9JuNsjHVT9dqJ6aMZI7XQkpbfprDrYAezd8vDfsLMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YW4RpTnXhtg2X/adwzyE28jZqr5w4A8M/fVZAjbVSg+7dASi6kkeAx3Yfl5vmbtt2
	 Y6sF043y/pek6Q29Od1Mj7qfutde9nCLql3c7AmXy3NKYy0f+URSBaTunf5l3jmEl5
	 YKjgDoqYlob3N9RbYuGjLXJMuW/WRU1A1coPPO3XAAb7I7m8N/KS0TT6zoFfisR0YG
	 ApT43Ssw1KTZ7AkYIFNFy7HwYomnlWO6/wnDrKvwDKfGVCwcYlDrl8jnjyJe93chlp
	 O3psVsIfpsv5JbLlXDg/3632SWbkvr6i91+4/ZDruSA3utiuxXIWcVkx7lUZzNKFqS
	 pnYnRcr9ZxyTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F443806656;
	Mon, 16 Dec 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next v3] ip: link: rmnet: add support for flag handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173431862926.3948460.526594663739240781.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 03:10:29 +0000
References: <20241213125139.733201-1-robert.marko@sartura.hr>
In-Reply-To: <20241213125139.733201-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, iri@resnulli.us,
 andrew@lunn.ch, luka.perkov@sartura.hr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 13 Dec 2024 13:51:00 +0100 you wrote:
> Extend the current rmnet support to allow enabling or disabling
> IFLA_RMNET_FLAGS via ip link as well as printing the current settings.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> * Use parse_on_off() instead of hand-coding
> * Drop on_off() error message printing
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] ip: link: rmnet: add support for flag handling
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1f0f9deb55fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



