Return-Path: <netdev+bounces-162783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2ECA27E38
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CC2166B89
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50D220682;
	Tue,  4 Feb 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPoD25bS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944B21E0BE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707624; cv=none; b=o5D/nafEGcFoQ8Kyz1XTzOdn48YmKEvCiNd1ZKL3MxqTV/ExOXpTTf+WyHfHLCXrS/eB94e57BEuVW29Yw9kDazfrTaJuX+Of0hBZR44G38MwGt60+WzIGVWNJEhZPoJghHIaS+Ri0MTIJ+Z9/kPN+uLRn5y1bHXlmjMVg2l63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707624; c=relaxed/simple;
	bh=uzeKsElD9xMDCduelylW8N6IK5XRKJ5Bb3zvFXuA7Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpSx+Tg4zM9zucK4gKTcignmMRp61tVdA2L+9wBIx0ZSWwGTmpl2YwwOPIpkivN2Cq8IpVQ/y4HFLPKkaCcedvWZZuBxAjMa6vLGXlwLiEjcjY1rU7AfSboMHskHB+CERR9m/Mw1TECrfURORMemtf+JOH57rTk8h8dbmQsEvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPoD25bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B53C4CEE3;
	Tue,  4 Feb 2025 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707623;
	bh=uzeKsElD9xMDCduelylW8N6IK5XRKJ5Bb3zvFXuA7Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPoD25bSUE8CGU3O60us4M3q1e9CubpS3hMXre5n866hS7IpS/qejjJqmDyrM6S4H
	 TQjM4VTUaQYM3pgRPeuMnruSkkUMzkxjG6nKyKJ4ELYxO6cx4ZuMMbkPqcyYWNKu2y
	 +ENDB/WREJIlYZYGEXwCfRSVkw3Qut5quCbd9HhmTVYFNIGo7OZSwTGZ1cR//LjhCM
	 Yn+ij15IC+ioh6Kbw2Hxj2/8WXWZIqH8VNE5e7XjouRVx6cXJ0P6ig+pFMQHB9JQ0P
	 tavv7vBO+Xvw8YlYZii4LGbm6/FcTywGr3/VJVhpERwLZ0+hJ0rHGYBRIzUBJzbmGr
	 l17zTy2ikfVgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715B1380AA7E;
	Tue,  4 Feb 2025 22:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: remove neigh_parms_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870765100.165851.4543574134975596565.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:51 +0000
References: <20250203151152.3163876-1-edumazet@google.com>
In-Reply-To: <20250203151152.3163876-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 15:11:52 +0000 you wrote:
> neigh_parms_destroy() is a simple kfree(), no need for
> a forward declaration.
> 
> neigh_parms_put() can instead call kfree() directly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] neighbour: remove neigh_parms_destroy()
    https://git.kernel.org/netdev/net-next/c/a064068bb6be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



