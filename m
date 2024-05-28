Return-Path: <netdev+bounces-98361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE408D10DB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DC1C20F28
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2B8828;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV92HDZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092639B;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855631; cv=none; b=gsxU5R0AVFo8RrMh6f5F2E8S/ps997e3yr/GUFgFa9ZP/BmZYfZpT+Ey2pBl2IZDCduCGQHys3EowdNkZsFDyPq4Ml7GHJO4Di/IkoJ3t6jH8ASDA9nwATQQxRWdq2JmkeSPhmqpqsG7NI8TuLfCCXqk4RywRAM0rGfU+fG83CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855631; c=relaxed/simple;
	bh=doi/hbM/iQZc6cYxHxTjepRgnwb7/MoOp65GQJqZ5oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b262xT1pHL8RsTUqqyXoxpA7NidDuzhiQU8dKstNOXi3rxW829f3D+tnffUtlpEk8MSFZMn82YSgfEyiGLclflR7nJ6B+I2QcvrCy9yjvhQm7UXH0f2U2RN5QpEJUYdti95TrAdd1vaejl5GWcUEKKlic2GyVX4yCfbLyU5GA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV92HDZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B53C4AF0A;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855630;
	bh=doi/hbM/iQZc6cYxHxTjepRgnwb7/MoOp65GQJqZ5oE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oV92HDZpgEU22gOQ4LXGTy8+TGZ2BCGRBfAMbT2xdazb2ZW8oEfT9Jxz/41Y1Awpl
	 lPm+XyOWk+iCJss6zlBrXTrVr3x1a/e8QdehGVKoIq3phZykBnLL/TO7eGkWqhJ6wM
	 N37icoXlYfCNOETaZ4B7Rhopqm7wv0ndw9SV4tsoa4DK4UfoDTiJzW2ZkrbE5spIhm
	 JIg9MqrN2b8vXVsg28DKxYTuSXqehCowr4V4BOYew3KEVMTCMVVcvMRp/IpUz1AOJi
	 9XeZcb+J0zyckcV7DRyJ0QDPlicnuIAgWsAT0DGb/zh/ZQj3JIv2KCop/IJoiAq/PY
	 uyIedm5EheDKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C98CED40192;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: netdev: Fix typo in Signed-off-by tag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685563082.6024.3912376131942135596.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:20:30 +0000
References: <20240527103618.265801-2-thorsten.blum@toblux.com>
In-Reply-To: <20240527103618.265801-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 May 2024 12:36:19 +0200 you wrote:
> s/of/off/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/process/maintainer-netdev.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] docs: netdev: Fix typo in Signed-off-by tag
    https://git.kernel.org/netdev/net/c/c519cf9b7434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



