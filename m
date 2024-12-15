Return-Path: <netdev+bounces-152027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5C9F2652
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5697A0285
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1371B6D1A;
	Sun, 15 Dec 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/zVJUJM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923CD53C
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298811; cv=none; b=fpkuR/TAFrdngHkaZ121NrH+h1c9ZG7YqUFX0Mi1dyYpwXdi1slZ+KHpJwNAfo6fEfO7NcsiZkocfbEKP+ALcKQlT5seTqNU183WzvG7KqTrL33n/sw8UcJuarJdTyg0MvALx0/r2bqESsvgPwFKmYsIaTfqnpjfR3/dm+Vc18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298811; c=relaxed/simple;
	bh=iirNtsMNgoY8YYV/O/LZyOZ+zjK87+URv/BlWmcYs2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tcgGLAOHM0cX/Ae4Hx87SAgb/ZcMhDS5yvZ1uOF7wjx8u1gW833ltVTRgbG8k9r46nhc4LhfGxJorXMpAxUe9rXWvIIBUPpi+JXzSfF0SKh/8KDS+jj0IhToA8HQPO5ovoaNobcQMPeDpcdNMIKKXSYeKuxntVOS8jm1I3andq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/zVJUJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566B6C4CECE;
	Sun, 15 Dec 2024 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734298811;
	bh=iirNtsMNgoY8YYV/O/LZyOZ+zjK87+URv/BlWmcYs2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I/zVJUJMhsIkAVxb0vh508WngmkzVNGH/l87NX7y7fepNfi+YGUwR0gV+jPJ526tg
	 BdRy+oPGJcyEixG2wwybvKrIRKt9JFcj4ThuFrn/fyj1UCiWnMRdpt0tkWS0k85hKi
	 w1Emh7NBdOFDv1erDSsoEfw3qjYeJ/ZSo3niN3faMhxVKemw0mrX9FdFB2bpsF+AaW
	 mW7UEGQf2dMS44qxdoITNTZt+AHYDAJ/DixEqgNXVs0gVmSkom8CYWlDF8ZWlOxhR8
	 ge8aX8qZzqhWwcT1+fJWen7dN7Jf2K6Q1URbUk5PhZiExSxKFbTrQwJTcmYrmztCwZ
	 /LdAy77GXoUeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C313806656;
	Sun, 15 Dec 2024 21:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools/net/ynl: fix sub-message key lookup for
 nested attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429882826.3586815.16226361270573280275.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:40:28 +0000
References: <20241213130711.40267-1-donald.hunter@gmail.com>
In-Reply-To: <20241213130711.40267-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 13:07:11 +0000 you wrote:
> Use the correct attribute space for sub-message key lookup in nested
> attributes when adding attributes. This fixes rt_link where the "kind"
> key and "data" sub-message are nested attributes in "linkinfo".
> 
> For example:
> 
> ./tools/net/ynl/cli.py \
>     --create \
>     --spec Documentation/netlink/specs/rt_link.yaml \
>     --do newlink \
>     --json '{"link": 99,
>              "linkinfo": { "kind": "vlan", "data": {"id": 4 } }
>              }'
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools/net/ynl: fix sub-message key lookup for nested attributes
    https://git.kernel.org/netdev/net/c/663ad7481f06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



