Return-Path: <netdev+bounces-162261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7AEA265A9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207413A361A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62FA20FA9A;
	Mon,  3 Feb 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQlF4jl4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0017BD3
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618210; cv=none; b=gfIFjVtTAqQRD9lXeiAJmXYBfK2L3yd0BsQTYL+ArjdDye4qg8xtKdgp7hgDW3S9avlD+IoWJZy0re9iAyT1t9He4SK8R/oFmkt7Aqmdyv0nyNQSbVr9/qdMXDFTUu8x3uibp859WrfYZu9BME7XnOkslqq37d3DVvfocGWajjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618210; c=relaxed/simple;
	bh=N2y7SXoVYu3dAcM6NTey/Ms1l4YJ0/lzbgW+SUYUSwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RzmNVko0oYqUUFxUX4KhApqA/8wcoOcir9KOT67LgSVEM9arTyTGxtL5zXzzGvtKE8zzjQcz9JHQZ7DE2KkbUKKfol9nIY2SzZp2BTRNOjWMO7xaBcZQB6s3UGXMI6u7fKzZb/MmudsKrOi5eaRflrKvgrNzZ0ezXjDXfBDQcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQlF4jl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB3BC4CEE4;
	Mon,  3 Feb 2025 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618209;
	bh=N2y7SXoVYu3dAcM6NTey/Ms1l4YJ0/lzbgW+SUYUSwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQlF4jl4INk2nskvY5kphsOBoXoEXle1VhLhbnjUz5oX7t9ue2EZKmzL3E8f52hrX
	 mL4ajtsctB5d/oW4IZTOIt207eGkVJ9LDraXAIvjuibGavtS+lx3akUYEEKGK0D2s8
	 xrqjp7HYA9zvVkc8+GfGEzDZxUFN/eGJrw5I5lxVumK1YQsVLS/ic9bydcpWlCTi5c
	 fTwZumqXIaHmwotq764EWyqm4XPDGjaKTQ4yhLt53iiR16KnsLHZbn4AXT2Vn50xwp
	 kL6c285cozlX+573ilKFVVG2oN/xjZ5ek8IrSgsVyIdag2rsEcS2nLrpINgjZ7ErNG
	 41iIHxVDicA8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F59380AA67;
	Mon,  3 Feb 2025 21:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] MAINTAINERS: recognize Kuniyuki Iwashima as a
 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173861823600.3505817.14348157869924501287.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:30:36 +0000
References: <20250202014728.1005003-1-kuba@kernel.org>
In-Reply-To: <20250202014728.1005003-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuniyu@amazon.com, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Feb 2025 17:47:25 -0800 you wrote:
> Kuniyuki Iwashima has been a prolific contributor and trusted reviewer
> for some core portions of the networking stack for a couple of years now.
> Formalize some obvious areas of his expertise and list him as a maintainer.
> 
> Jakub Kicinski (3):
>   MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
>   MAINTAINERS: add a general entry for BSD sockets
>   MAINTAINERS: add entry for UNIX sockets
> 
> [...]

Here is the summary with links:
  - [net,1/3] MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
    https://git.kernel.org/netdev/net/c/4d896b353941
  - [net,2/3] MAINTAINERS: add a general entry for BSD sockets
    https://git.kernel.org/netdev/net/c/ae0585b04ab7
  - [net,3/3] MAINTAINERS: add entry for UNIX sockets
    https://git.kernel.org/netdev/net/c/8a2e22f665a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



