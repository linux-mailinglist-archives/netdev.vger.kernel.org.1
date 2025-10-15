Return-Path: <netdev+bounces-229437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF56BDC246
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 877D6351CFD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7D186E40;
	Wed, 15 Oct 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC12v4Lj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA314D29B
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494821; cv=none; b=pxMm1pcU4XAAJvxiUZH8k2M7y41LyTyK4efvbUkuowvSbp6RaZ0owjTmd+gt9MfHk1zCHFCsPhPFUGT5wdyCMp9q4zQrZg7FwIUjdlgN2hs6QgCVMYsRnrzteRJVb9zEnYSS/zVwLCcNYbcMvaG5ahONnWpt441bNQBk3IADo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494821; c=relaxed/simple;
	bh=bjIsdCb5b9X9hU2aGR/qKuvTAl2DPxWn0EyxIprViRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+zK0LhJHUCpg9AcNOE6OCJtwVD/cQxnljb7nLpt/izaL3HJahOGXHQ1rxNXH7Yn+D8qRLHQhUzIMlsbmJbHkGD70L4Yx9J5kh+/uv6VljUIpAOK+nEXIWBE+h80TYyi9CUlESD9kU1dI+hAZJrG8hdS0OcG9nIuyK/4M/GO4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC12v4Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA14BC4CEE7;
	Wed, 15 Oct 2025 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760494820;
	bh=bjIsdCb5b9X9hU2aGR/qKuvTAl2DPxWn0EyxIprViRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QC12v4LjnGyCH5Hi2VUWmDvlW/7zLIO25gmpsa2TNf7fNLV2xQ2cFzagYOOEo21lC
	 GTrw1Ibqzb5UaAwCoGlvqoBnxdhF3WcoQIgQ9xfoyau+tZ6/Iz5ovpZLZDLldDtcUe
	 whi2GwJBCXgxUYM88dJ2q7ZAqOn3EETNWIVTqXiDSnCLpm7IKUG5gyIBIKJ/Jq8pzI
	 1nd8UDsIwUUU5922A8y1j/+8zgPbcdgNhNjSFxglaPGGGvrHftBG5+N1ggkMiRZKz+
	 X6HuGiAxYgEogF5Ia/o18aYZCRniszopFka7CyHKRqO8xDpQGHxx0lIM9mruFWQLJI
	 eSXwN6OdZvpCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D9380CEDD;
	Wed, 15 Oct 2025 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: use macro module_driver to avoid
 boilerplate code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176049480576.189263.2436026311042495949.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 02:20:05 +0000
References: <e5c37417-4984-4b57-8154-264deef61e0d@gmail.com>
In-Reply-To: <e5c37417-4984-4b57-8154-264deef61e0d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 22:50:27 +0200 you wrote:
> Use macro module_driver to avoid boilerplate code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/mdio.h | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] net: mdio: use macro module_driver to avoid boilerplate code
    https://git.kernel.org/netdev/net-next/c/10c4b4f60f5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



