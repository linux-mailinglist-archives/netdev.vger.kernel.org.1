Return-Path: <netdev+bounces-236142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06DC38D2F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E18A1A2556C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D5524166C;
	Thu,  6 Nov 2025 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOYHJ7m0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B823183A;
	Thu,  6 Nov 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395039; cv=none; b=aDJHRnZqsTQ+LMnD6PG/C0D93aCKnc0BdQc5i6LJ8pOZz6Wkyc3xigKXxWcM+49ehZHl6Du3erP+kl2vVlxG078YQYkVOjNAt3tr8+q3+Fy8JwkulkmfeE1EBAV6J1996VCnnRzZJBC+gBpIsW4qZWHMwul+TAQ0QOKbk111N0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395039; c=relaxed/simple;
	bh=qzkxjRWS+5d3rUJUjF88qvSx3bJPea7q0JXuCZT9+Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VUKwZKmPnvJGo09icsuWDhOUK9+c7ZhsNCP2YB3wlWuFHhS1gL/0MmpHGdYfW1nr7db/yJErvnRroWFKnO+e6jngdM/mDzNqXzRDCTaBrO1PcC4QOZV6Z2MuQ3c9RNoyI5KmefJpq2ABYgfKmpLpnJe/DlulN8izS7/BUECrocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOYHJ7m0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7814CC4CEF5;
	Thu,  6 Nov 2025 02:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395038;
	bh=qzkxjRWS+5d3rUJUjF88qvSx3bJPea7q0JXuCZT9+Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QOYHJ7m0CoEuENWR4Cku81lnXDwjEj39Cq2JiPfxLStPIkitQy/Nhe1deOItEJosB
	 0mEGnpXdsWHr/sCIIkbrDWxrOcbc6I5kHjsOTiTkjvtoFmcxezHw/3IpPTeiGNfhuL
	 MCe0dpUikc8grLb6f1BpO99OHL65yJiwy708no/a+EcE1ZDmosQSZZ0Gwx3ylF6NuH
	 ORI0TQO7uhQI4Bntb9/c2hu4ezLfXiEt4p8gOg3tz14NIf0z3ltL0sI9CSAN0wRwt4
	 HPohxWYKmC3G772A5AffaqBdYn4nHNQ52/C3o8YOaS8U8B5n6A98pyBg/e6Ahvr4hu
	 cNhXS04nscMQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2A380AAF5;
	Thu,  6 Nov 2025 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: wan: framer: pef2256: Switch to
 devm_mfd_add_devices()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239501149.3834029.9389534252741846949.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:10:11 +0000
References: <20251105034716.662-1-vulab@iscas.ac.cn>
In-Reply-To: <20251105034716.662-1-vulab@iscas.ac.cn>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: herve.codina@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 11:47:16 +0800 you wrote:
> The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
> in error paths after successful MFD device registration and in the remove
> function. This leads to resource leaks where MFD child devices are not
> properly unregistered.
> 
> Replace mfd_add_devices with devm_mfd_add_devices to automatically
> manage the device resources.
> 
> [...]

Here is the summary with links:
  - [v3] net: wan: framer: pef2256: Switch to devm_mfd_add_devices()
    https://git.kernel.org/netdev/net/c/4d6ec3a7932c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



