Return-Path: <netdev+bounces-209162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B38B0E81F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8F4960C2B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A11AAA1B;
	Wed, 23 Jul 2025 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQLaoNuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F511A0BFD
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234223; cv=none; b=n/k1C2FhyfydJCpfMBpFH8rRniA8cdiUutSh6BardQFL23cAXnkf6ofA0pivo0VVpTfd1MiCUhlpOgRSzWSWRIFCTMbI9kBZoF05vF4V6aA8CjEG0uzTf6slxr3hgtX4CkgzaodNCqyDlV3ydnbcqvm7xxDq4AX7RNW0jYFLdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234223; c=relaxed/simple;
	bh=l+JVk5KK+elfEzyasGokQqZROgE57v23kDTRp0PSCRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ASIwACEYaB03GD89rlY0Lsrr86Uf8ePK8a2zLaA/GUZeNU37WsVlNKJey2ZibpFEL/THnl0sasB4unDHtp7PZJN0vnUY9S9rWCPFWAf3XBbgKas/BCR2IxM8X5NDsrEWVvfaZhjMWOsLAzqoATW3+3gpYVvzMOs2vD19BbjzVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQLaoNuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADEC4CEF7;
	Wed, 23 Jul 2025 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234223;
	bh=l+JVk5KK+elfEzyasGokQqZROgE57v23kDTRp0PSCRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CQLaoNuCjimVdgezGCOxkepapKMm9Rp2WG8zTxdtBckoBaCgkyk3nwV+j85lFLV3J
	 WyzJjlMLFoqR0J55UwguztV4osPBEgtzfiG9HvMnUD+PZXpkbkEHRP7x7xj9tC1wmj
	 UoFE+3kgNrz0cF+dHo+m194ogX4lLknU21ivKZlEzpKv48tNUvqGzFu2x8FvTxoRbE
	 bFZTQLoDDaT6+qHWEQVK+IENM07tYYI8cOdjNJST1ttc66ajEWsfrvnyqMlDxRIKnh
	 OhZw5X+airvhGej0nHWa/fLcnZFCmn7CTEpXqQ7k1VCvHXrJskQHN4L6bxGgPi7Z01
	 mv8fzQ13s8Jjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3D383BF5D;
	Wed, 23 Jul 2025 01:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Kconfig: add endif/endmenu comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323424149.1016544.7518932556040860157.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:41 +0000
References: <20250721020420.3555128-1-rdunlap@infradead.org>
In-Reply-To: <20250721020420.3555128-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Jul 2025 19:04:20 -0700 you wrote:
> Add comments on endif & endmenu blocks. This can save time
> when searching & trying to understand kconfig menu dependencies.
> 
> The other endif & endmenu statements are already commented like this.
> 
> This makes it similar to drivers/net/Kconfig, which is already
> commented like this.
> 
> [...]

Here is the summary with links:
  - net: Kconfig: add endif/endmenu comments
    https://git.kernel.org/netdev/net-next/c/b2dd6eb0acd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



