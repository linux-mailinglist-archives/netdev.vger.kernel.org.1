Return-Path: <netdev+bounces-151294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5D9EDE82
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631BD168299
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65E152196;
	Thu, 12 Dec 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfMt71Ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB8170A1B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977829; cv=none; b=aOWGRTUCnVC5BWCsvN/+g2Mpu74+iYEwMLraU5KPr+0W3kfGRKhfxJoIwK3j5fRLE9/G2L95GqsTK1jZehNHCaxv8wM2QH14zX6xOzxqiZ6u/0rUGjjKt7I4xVK8P0Jkwg4nFgQXaCXhxgwmwaqfafkv15CEXKz74ojs66pEqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977829; c=relaxed/simple;
	bh=ycZqFgnqB8ywwKc3Mk6FBM7KoKKtZ8aYIO0SaiKvwyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2F/rIohLgGYXqIZOgXVdpYFg4beyI2MT9M/2iqmRa3aCRLuCYle+x4d6oDpL7+DFHkM5XuqtaDRujrwFQ0hQ08Oqs7f5TCrLI85E8dd/+TtRZqla8ecPzNCsMXBQf1AxyP4ZQRi2X0nIsbktLAehpQNWRM6N+6qfA9ATuaYPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfMt71Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D61C4CECE;
	Thu, 12 Dec 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977829;
	bh=ycZqFgnqB8ywwKc3Mk6FBM7KoKKtZ8aYIO0SaiKvwyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LfMt71Ds7GSXVFqN7UeCF/omMWzwTif1PrnY05RvNHlnanxrbKSWUPQrS6fIzAXMf
	 LWi306ISmoLnm/cCvcDKqE+4wbDfrffwfVDSxUyemiEMQz5tCZ/KFbPVoOf9fZcaDI
	 VTbL86z0AJjUJ16Yi+9v1UXCCkIXs67VXjRDxnG2tAKwWWEIVKybsNJmlDfrfAxdZo
	 EjwfHRlvCqdRr0zyIhaNIMatzIyjQ9sFjUClrA9Yy0Zs0U9gg3q7jwo6JcG2W7ADls
	 SdkP8ePHaa6nCYFjSxf1i/8eeqLwB2XY7vxC1+i+cua+W0bhqTTzgS1xlK5GB197zl
	 8cm/0sve6s0CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B1380A959;
	Thu, 12 Dec 2024 04:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: Do not allow mixing sample
 and mirror actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784500.1847197.12759000313918649518.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:45 +0000
References: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
In-Reply-To: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com, vmykhaliuk@nvidia.com,
 amcohen@nvidia.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 10:45:37 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The device does not support multiple mirror actions per rule and the
> driver rejects such configuration:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action mirred egress mirror dev swp2 action mirred egress mirror dev swp3
>  Error: mlxsw_spectrum: Multiple mirror actions per rule are not supported.
>  We have an error talking to the kernel
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_flower: Do not allow mixing sample and mirror actions
    https://git.kernel.org/netdev/net-next/c/175dd9079ecb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



