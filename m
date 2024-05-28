Return-Path: <netdev+bounces-98357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1928D10C3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F115C1C21946
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C727F645;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOyaBFqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E238364;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855028; cv=none; b=kUAi9OUflkSlXdOX3XvCnE0E2zG0ViFGX7raQzyHsz+UbiXzVPZ8cEH1FjkCsE9z0TspwDm/LZDkqEtfKAhni142KilD54UU3oO/2MQdikHw0qfE2ZArOQd5elJy5dEJL2BF55lFrNdInfjcHE7yIrLfDlT5Kd5n2I3Qo2pq3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855028; c=relaxed/simple;
	bh=O3cV/uZ7xVsQdZtKNy1BfIKT5MdgMzkJksLWxGkG/8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QEGPVBEAqwGlWNxc+wKnJwCt3Wtthpr4XWBKI82BwtyfINokSkFZX1iQchHkRxn9NjMlBHhDaPVNp/ya+bRCQWARk8LMwbV/aL3+R0+El1GSQFBs5CmR2MlU187HrFW5Ij2hoIj4CGBCPbPHRQXDLJcmezPl2CEJLdzR/mr72CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOyaBFqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E5EC4AF0B;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855028;
	bh=O3cV/uZ7xVsQdZtKNy1BfIKT5MdgMzkJksLWxGkG/8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sOyaBFqtW+ihedqwMjPgp6JLJyPMfzRSpM9z4jwhNSDX//vN/N1cOJNQvK/s8bU2Y
	 YFDvipIqpnCxWZZIFBEeELtldIOyrpYlueDS/Ricf1yaSw62PNkmTg+39HRS+ibA73
	 S6Zf128i4JsOlO45EJX2DoLnbKzDkoX0OtJpTRSkst5nft8MQz65PL0qVYllEM/zVi
	 Qe8HClt08Hw3hxVK8eL7uERckhyNmRL5oyGMi0rXagfD7xVh1VFm4OQcanCk8xOSlf
	 WElMUkbo2pDBCLRryPi/oUl05adnnMlRvP1CY/xWqr9GSVMXjlAP9KDBewIXyo4CN9
	 xCA75q5q98zUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B81FD40192;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mISDN: remove unused struct 'bf_ctx'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685502824.31992.3352926230597985160.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:10:28 +0000
References: <20240523155922.67329-1-linux@treblig.org>
In-Reply-To: <20240523155922.67329-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 16:59:22 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'bf_ctx' appears unused since the original
> commit 960366cf8dbb ("Add mISDN DSP").
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - mISDN: remove unused struct 'bf_ctx'
    https://git.kernel.org/netdev/net-next/c/5233a55a5254

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



