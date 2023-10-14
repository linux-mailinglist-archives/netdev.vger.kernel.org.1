Return-Path: <netdev+bounces-40911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AA7C91B4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD391C20A6C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CE637;
	Sat, 14 Oct 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+BmrOS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999E627
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCEB6C433C7;
	Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242224;
	bh=DCubbHDQWZ/ORGSL6xB9+2gjI9W5+B3RP0zSCUmqeq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+BmrOS2JVEET+0uB4/Dc1HaipyUy/G9Nq3R38XLznHlIFovIHqz9GDncJDhIGQ4m
	 O4FHOu4gitKo9Dmn7R0mGFNRuMVgArgM4eh5ScRb/Du9J83ljnyDDURmIJGO9P0GPV
	 ORQJ7QtOOgkgMgvKLnaliU+VBm/JrA27+Qx876QvP9EbnwaQGY3OJbClU/BfOK90OC
	 +rxxvr2dgNe7gvnJ/ve8p4ppYf/fcA6DX0y3EeZbZOH3PVdxmna0qiYWXpHk8acmQB
	 aCDv5HW5YK/eQjlV3OJy7oH+I6OOiHnfgQScpvY0wS02zB7UNGJu3Iiaa7uMPquDiT
	 dnIUgqFRf7Pdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98BD4E1F66B;
	Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: pci: Allocate skbs using GFP_KERNEL during
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724222462.16074.13447154968903624536.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:10:24 +0000
References: <dfa6ed0926e045fe7c14f0894cc0c37fee81bf9d.1697034729.git.petrm@nvidia.com>
In-Reply-To: <dfa6ed0926e045fe7c14f0894cc0c37fee81bf9d.1697034729.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 16:39:12 +0200 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver allocates skbs during initialization and during Rx
> processing. Take advantage of the fact that the former happens in
> process context and allocate the skbs using GFP_KERNEL to decrease the
> probability of allocation failure.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: pci: Allocate skbs using GFP_KERNEL during initialization
    https://git.kernel.org/netdev/net-next/c/958a140d7a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



