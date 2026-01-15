Return-Path: <netdev+bounces-250250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34688D25C41
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F000D30057D3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DE27AC5C;
	Thu, 15 Jan 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qac3tG8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433323A9AD
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494816; cv=none; b=PWWVDfnM4RH2rPKyET3SD5oCimjVnmWalL8pAE9SD4DDT20d9sv8HPehXolKTKyhNuuHXWOjaQ13IFki3GE4yQJLXNMxH0h0wsvU/ncv3FjzImhKj7AwR8021BeT1Xf38lRv2C0pcKibuuTku/HcvcvWsAVZohxkKO9EHIJnh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494816; c=relaxed/simple;
	bh=CDmk3YeYR4mOCcp7fEq+OtpzZVr5Athxw+AgHQG+skc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FFiD1UiRrw+lNXXuaEzqmYg1Y2N6EyBAswJMH/0IIse5y2VZ/Iwhc1p9H0STnLXMT6Gywr5c67eHUF14ZYinSQRx1jPQKfPeMQzSmnJAZloQx6kcXJDoz4n4rscm0yVjoGAZmc2axGYS9gfkfAYDRYnkwHiBE8JptHFHbJkh0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qac3tG8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC45BC116D0;
	Thu, 15 Jan 2026 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768494815;
	bh=CDmk3YeYR4mOCcp7fEq+OtpzZVr5Athxw+AgHQG+skc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qac3tG8sp8aalV2KOJFywHvoi1cdaoITKkJjCvz5zGshj8gHUKqk0Hs7n0rZbgEck
	 KllqnJhFv4GXkhnx/PvNfvM9O+3ss+POSOhVj+q4/4+NR3XATVyzs7TwgFNRs4Oau/
	 o2VT85mNZMAa94xARRPgyILItQOO04n0DKSfwY0GvIVa8MvVJd8KGMFmrYdFpr6K3e
	 B+9aL2ESSgrvywDVzndgyxYadBUFyiL+fKrE8lf4CrVz3iOL51/gNTo1lafW2MQGtl
	 pN6g7jmLRdy2sqcaBs3xIpq8I9JkP8JwWyaMknOWmx+1GWIXxdv0hgnrpSk5yFFWmK
	 96vOsQuxQXCYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B90F380A965;
	Thu, 15 Jan 2026 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 2/2] tc: cake: add cake_mq support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176849460809.4062473.12743288518505930560.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 16:30:08 +0000
References: <20260105162902.1432940-2-toke@redhat.com>
In-Reply-To: <20260105162902.1432940-2-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org,
 j.koeppeler@tu-berlin.de

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon,  5 Jan 2026 17:29:02 +0100 you wrote:
> From: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> 
> This adds support for the cake_mq variant of sch_cake to tc.
> 
> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iproute2,2/2] tc: cake: add cake_mq support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=24236c0eb5dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



