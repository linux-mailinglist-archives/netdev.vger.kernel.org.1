Return-Path: <netdev+bounces-143956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF639C4D6F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AD6B21714
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F91A072A;
	Tue, 12 Nov 2024 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX3RQ1hS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4C4C91
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382823; cv=none; b=LOBqgOAPI6ZkyhsEZY9eSodskvMEl3SQaVo5XQBYLdXLPsYaDKBpzMxq2CAjXVnHpoIdB6vQ9ar+UHBkj6rULlx/AtPyT4ac0KmgkW16qTUWgnnBfXaPh0AKaB5/lEvXTvHGJYMqwAOdauuIuvgieJPT/FHKuNWc2SW3xFSuI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382823; c=relaxed/simple;
	bh=wreQqtup/TwmXd62eyYqU+k8CcLEo5tJ39+JGKusVwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fPO9vgPnC/m5qO0iSHZRkzyL5IbqtcKMVw17Bf6gt5OaF+RY+abrkA5CkrC6gi5ggaCxKRyKaekLHsKc6ssDzgFIZJWBpMQG/gVcl/G3HduuW+qoHOpEAgkmK9L+vjztPhA414gjiZlaqi6LkPjpoVziEYdekcZSmjTYSnnB/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX3RQ1hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E09C4CECD;
	Tue, 12 Nov 2024 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382822;
	bh=wreQqtup/TwmXd62eyYqU+k8CcLEo5tJ39+JGKusVwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KX3RQ1hSdopEdPL3A/ZPZoPEg8BK6ClzHfFSkNg0DF7JKD9/ia553kYcxGg+CWCOb
	 a+P2NIwo1Zm5eHhoiX1+xmVdZI7io0iZP4Oo327t6vmH/+C9GuNHikLfKBXiK73vW3
	 BqjOV738OXkRO/vs4LAr0ah7SVeiVAamuyVhsnK6CjQepVgdQ7xdM23ImINbLUCYQR
	 61PJ4AmFYSmTI3+s2FB2med1xKJ8cxyIs3fKhpb31p3bABNO+yt3hBdToJhy/CENpq
	 DfA6cNxBBJpQmkefa1xm1uPYGxMK3wqFMdjYlF5tNaTdEnDnwTE4Y5dfIHHAwRfF59
	 6KZdZiU1bfAKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16C3809A80;
	Tue, 12 Nov 2024 03:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] mlx5 esw qos refactor and SHAMPO cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138283275.71105.7062967652158477670.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:40:32 +0000
References: <20241107194357.683732-1-tariqt@nvidia.com>
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Nov 2024 21:43:45 +0200 you wrote:
> Hi,
> 
> This patchset for the mlx5 core and Eth drivers consists of 3 parts.
> 
> First patch by Patrisious improves the E-switch mode change operation.
> 
> The following 6 patches by Carolina introduce further refactoring for
> the QoS handling, to set the foundation for future extensions.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net/mlx5: E-switch, refactor eswitch mode change
    https://git.kernel.org/netdev/net-next/c/ab85ebf43723
  - [net-next,02/12] net/mlx5: Simplify QoS normalization by removing error handling
    https://git.kernel.org/netdev/net-next/c/5a731857656e
  - [net-next,03/12] net/mlx5: Generalize max_rate and min_rate setting for nodes
    https://git.kernel.org/netdev/net-next/c/ac778fefed34
  - [net-next,04/12] net/mlx5: Refactor scheduling element configuration bitmasks
    https://git.kernel.org/netdev/net-next/c/cc4bb15ffa84
  - [net-next,05/12] net/mlx5: Generalize scheduling element operations
    https://git.kernel.org/netdev/net-next/c/663bc605d0db
  - [net-next,06/12] net/mlx5: Integrate esw_qos_vport_enable logic into rate operations
    https://git.kernel.org/netdev/net-next/c/d67bfd10e668
  - [net-next,07/12] net/mlx5: Make vport QoS enablement more flexible for future extensions
    https://git.kernel.org/netdev/net-next/c/be034baba83e
  - [net-next,08/12] net/mlx5e: SHAMPO, Simplify UMR allocation for headers
    https://git.kernel.org/netdev/net-next/c/8a0ee54027b1
  - [net-next,09/12] net/mlx5e: SHAMPO, Fix page_index calculation inconsistency
    https://git.kernel.org/netdev/net-next/c/1a4b58857704
  - [net-next,10/12] net/mlx5e: SHAMPO, Change frag page setup order during allocation
    https://git.kernel.org/netdev/net-next/c/4f56868b7132
  - [net-next,11/12] net/mlx5e: SHAMPO, Drop info array
    https://git.kernel.org/netdev/net-next/c/945ca432bfd0
  - [net-next,12/12] net/mlx5e: SHAMPO, Rework header allocation loop
    https://git.kernel.org/netdev/net-next/c/ab4219db89da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



