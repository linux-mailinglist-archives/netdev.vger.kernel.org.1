Return-Path: <netdev+bounces-111973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4550934539
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B9E1C20FFE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260918E3F;
	Thu, 18 Jul 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUuYyFyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AC3C2F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260833; cv=none; b=WFj6yjtyqQigB/K9V+TdyneV9ZROvzVbP0d4yBqsQuh090oGsVHS/Kht1k2UGy5tqhdxnA/vsW6XUAgx8WBpx4Rq2ujjsrvdqFcC4D8Dhho7H+AjUz9VTd9+fAiBw2vc3NzeGAjF6trE1t6hqp3qIDMSCwkSnD8kQ1kCrWM1Y0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260833; c=relaxed/simple;
	bh=W8v7nqBQJ3rQEUXSF+xoUsh3Wzy8MR7lMtTsUYjN61g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6a5h/BsnoM/Epk0ugQNXYb933F9pVqKREktuHAVsNZxli2Nf3eKBVKWG8AIvIKBLDF1Hf51jIJARPotePI6HBGn02nKkrVp2fJpzSQXkGYP17bujVVQzva+w9G+srUzjwIDGn0ndNX6lr52e6MVHxlf/HEm+jXG8zOYyw6odDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUuYyFyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A102FC4AF0B;
	Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721260832;
	bh=W8v7nqBQJ3rQEUXSF+xoUsh3Wzy8MR7lMtTsUYjN61g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jUuYyFyL1qYXCm1DqwGXLSZA4lROqu78vHVfZikNHV5EOAtmwejTJJ0AqxYMmRMuP
	 PWkRr4iiVD6ffvdU2vXJKUyrQtnGWmsiPpUYhe1BtZ9vr1IAeVSSVTf9mAAcNiIFSA
	 /CA1hUc3NRMPp5O79ivVjf/4WslBhBZ8PPzQBxNewjyFdGQv0UX9qekY5KI5NlcMM/
	 QNjulVQFVHkZ0OsLFRxku4XueTaoZls0MOa5QIwA9oDTD7VIAEWP0SA2I/ItxeuAV5
	 YMC78EL/vx059ES/RF5qrcyDyLLFXLrwaYcQKa8wi//njxyaLWUbhkBcxIYKv06gct
	 tC7tqqZObAd4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DE3FC433E9;
	Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: do not print stray prefixes in monitor mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172126083257.7578.12587091201967563672.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 00:00:32 +0000
References: <20240713145641.4145324-1-b.galvani@gmail.com>
In-Reply-To: <20240713145641.4145324-1-b.galvani@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 13 Jul 2024 16:56:41 +0200 you wrote:
> When running "ip monitor", accept_msg() first prints the prefix and
> then calls the object-specific print function, which also does the
> filtering. Therefore, it is possible that the prefix is printed even
> for events that get ignored later. For example:
> 
>   ip link add dummy1 type dummy
>   ip link set dummy1 up
>   ip -ts monitor all dev dummy1 &
>   ip link add dummy2 type dummy
>   ip addr add dev dummy1 192.0.2.1/24
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip: do not print stray prefixes in monitor mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=554ea3649dd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



