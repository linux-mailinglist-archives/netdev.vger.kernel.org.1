Return-Path: <netdev+bounces-91507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A88B2E85
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F23A1C220DA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675C1869;
	Fri, 26 Apr 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYpx9lgg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944517C2;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096828; cv=none; b=iu/MNvatSoDgjwJxP6Y6BudV5au5IK+xLSoLHjkXwtgUJ55eo91mrcxpo4FhfCV0tv57QbZHr7IAtHeBfj7ajojCgwdS+GfuMC6kf4fsoAAwqLn9NdClI3MuUa0RhY8InRhBQ90juwDepuydRcMkdb0f5q+i0Sv2FLp5fU2KL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096828; c=relaxed/simple;
	bh=DsIPGBLVH9lP/uIBGNBcKjMAl/KaQOIkK8PtsASW7zc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPMFoVwb/tVyDRjHvbcGWYtrwn63vQvM+4+sTo7MLNQEC4kmyJwbbCdFtEjlv+pgxWgAp+Zz9PRZKEubtX25EtqvEXYMmH3LbY3gTk3igGAxl7WIDj9wTAAk5HyLckAcIQrdI/NiGEwS2hBahAxsk6GHn/rlvmMFRsXBbcWqFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYpx9lgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630E2C2BD11;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714096828;
	bh=DsIPGBLVH9lP/uIBGNBcKjMAl/KaQOIkK8PtsASW7zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uYpx9lgglPuNknkAFBHiSoS02w3oAtZU7hLe0h/sSS4VC2dfo2gsSv/qR2dK4q2q5
	 rVN/jOQn0vbhhlrbUbB7UlDc0ZRF1mZq+DiASMdcQn5Z26nHHjLrHPER76AhXfv0SB
	 F5zy/ki6u+pZc+kkKmre2iC1Rxk8oKeAiWRMnJn0ZurU9UGwyO0BKNhSn1SfwxBZso
	 hhAw1DUEZH1876Bu7xxMUI+0YWzIWLAYfkfCqRQ1AqZwZVhZ7sIzSLSDS4Bw9nuIxF
	 9cSFyPfzywVibsGXl2kA3GoLAcyyidhspiT93Lcly883z+IYhZ2jejbU1Ac8iJ+D+I
	 pOmjLnKetNeUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A600C595CE;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: ax88179_178a: Add check for
 usbnet_get_endpoints()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409682830.30663.14820286388117700989.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:00:28 +0000
References: <20240424065634.1870027-1-make_ruc2021@163.com>
In-Reply-To: <20240424065634.1870027-1-make_ruc2021@163.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jtornosm@redhat.com, andrew@lunn.ch, horms@kernel.org,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 14:56:34 +0800 you wrote:
> To avoid the failure of usbnet_get_endpoints(), we should check the
> return value of the usbnet_get_endpoints().
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2] net: usb: ax88179_178a: Add check for usbnet_get_endpoints()
    https://git.kernel.org/netdev/net-next/c/3837639ebfdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



