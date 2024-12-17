Return-Path: <netdev+bounces-152581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF99F4AD8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC361889024
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745E1F03D5;
	Tue, 17 Dec 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyTTW+S1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3171D5CCC;
	Tue, 17 Dec 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438018; cv=none; b=Jr3cjHaMVSf9/kwUViL+u1/toFy6w3BlUVV41isNlL8fgP8Lziu/eRGhWNomOzLqiK0aZ9H4QbudUrRnXv8nMkG9POydNKZ8q21DYPKDvaocjMKcSAKq2HxTNudFXNT2Ii3TFId0KBjUUF+zojuw078a1NKR+k0bYyV9YonT33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438018; c=relaxed/simple;
	bh=D4LPgZaYc3/puXArw9UXTKyW5VcRNgjEml+MyZgeeUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sr3VjxpCDSOxiPgQ6jfNZeprc3EI0meX0mgqu6AtMaefVhsRXtUN6JI6IZMoZlb0heqo9QsZSmD5a8VkFOFqOUiOgISxMBmeQQo5equOFm7gzbNM2nr3qxjsTbQudBNWOEifqvQMneAbE1m9nGp4I1ppx0Jwb7kte1H+0pQq4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyTTW+S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB31C4CED3;
	Tue, 17 Dec 2024 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734438018;
	bh=D4LPgZaYc3/puXArw9UXTKyW5VcRNgjEml+MyZgeeUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jyTTW+S1gWZRF51XMM+oDJgnxR64AI8OpsMnhIV8jqg/yrJ5q2TmcuKjnTtegWI7p
	 dmG73bG8EPUrm1f8xS86naozAKmpOXpluW39dhM+bHQpMt/LhFry6PcGWTX1xrNBeh
	 302XBuFy/+/qfvpoJSaggObNGtKWu1r4joUYiOOutWjT8VW+NqNVC7NfZMOK4eHPhZ
	 h7FPMk/1RAq5zBunZyTmrapAJV3xnef1m+lDvl+Cm6+dsRzJWuOwU46lQDzTLj8Kux
	 Qvw9tNkycPwQEqU6DL/5eVA+DYVXcIJv7KUjlFxoGmdZbGbP7u8Ep8wlSMnGYgilxn
	 2ww/WeAXC1yKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EDA3806656;
	Tue, 17 Dec 2024 12:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] Fixes on the OPEN Alliance TC6 10BASE-T1x MAC-PHY
 support generic lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173443803525.877155.5096534324212686696.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 12:20:35 +0000
References: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, parthiban.veerasooran@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Dec 2024 18:01:57 +0530 you wrote:
> This patch series contain the below fixes.
> 
> - Infinite loop error when tx credits becomes 0.
> - Race condition between tx skb reference pointers.
> 
> v2:
> - Added mutex lock to protect tx skb reference handling.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
    https://git.kernel.org/netdev/net/c/7d2f320e1274
  - [net,v4,2/2] net: ethernet: oa_tc6: fix tx skb race condition between reference pointers
    https://git.kernel.org/netdev/net/c/e592b5110b3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



