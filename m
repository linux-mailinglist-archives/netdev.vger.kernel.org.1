Return-Path: <netdev+bounces-100898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603688FC7D1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37E4B28D9C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B24190481;
	Wed,  5 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f71U6wE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9BB190077;
	Wed,  5 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579830; cv=none; b=Z5fOxh2No6K2jSKsOwR7PU4zYXaAMm0rFhBBWnrWqSVm5dCSYoobSiO6cWxdYAekk52dJgIVhdJUxul4n+FBhqUE63tMMI535O/iF3OEh4k9Q9QRqVLC8xtEKe89WbP+K8b7d8lmZ5f0MsE5NqvzlvBJ2LVKeKSMjeXIzyBHHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579830; c=relaxed/simple;
	bh=3ExdHi2EcPAbhVh+fX0Mk2fCc1d7uB5HSpw7KZhqE1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fafhpZ/G9ajoJ895XVIbPr/agPRyQfSHOoRFFJ/q8dpZxE0NzLiWltTs2ixhX0UHJ7Zb7jb2OfkIvgwbaQMefOc/YbqQ6KWMnvYSfLHC4hzGNoCeONDWZhTdM+pzpkChi9EFuiMUM491p5JDLYh82XFjptsRWBQ5mpvpZnJ+WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f71U6wE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA23CC32781;
	Wed,  5 Jun 2024 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579830;
	bh=3ExdHi2EcPAbhVh+fX0Mk2fCc1d7uB5HSpw7KZhqE1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f71U6wE9155145erk8/yM3e1rctd/naNfyyofN2BvO+2b28Kor25wngFsDapBuKpa
	 swnkNIX+d7VV/G3wYjkZHQ9HGYNUBqgXe0qkzcXarB1AiG23r0wZIoKLGVVuJrUtSA
	 Oom0H1hVAqtAb6rUqTiET5A2NsN8Ts3uK9gVJIdpfwI5gNw9B8XRzuKHzrEv1MujVB
	 9piMrbcv5AtGm9W4o2dBjOSE+swUKpf1Ib/HWAXaWJ/T5BwDRQcr5/O74OZAc7fk6K
	 Aic+Nx+2X7nCSPm6E4FMMYR5VDzTAHZRwvtoqRJsOPijbquttH/sa0NgJbH3KxNLVv
	 RxOwXNsqV23dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE508C4332C;
	Wed,  5 Jun 2024 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2 net-next] devlink: Constify struct devlink_dpipe_table_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757982990.5772.13409397728959786812.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:30:29 +0000
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  2 Jun 2024 16:18:51 +0200 you wrote:
> Patch 1 updates devl_dpipe_table_register() and struct
> devlink_dpipe_table to accept "const struct devlink_dpipe_table_ops".
> 
> Then patch 2 updates the only user of this function.
> 
> This is compile tested only.
> 
> [...]

Here is the summary with links:
  - [1/2,net-next] devlink: Constify the 'table_ops' parameter of devl_dpipe_table_register()
    https://git.kernel.org/netdev/net-next/c/82dc29b9737e
  - [2/2,net-next] mlxsw: spectrum_router: Constify struct devlink_dpipe_table_ops
    https://git.kernel.org/netdev/net-next/c/b072aa789918

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



