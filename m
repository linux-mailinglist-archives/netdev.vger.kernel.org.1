Return-Path: <netdev+bounces-247232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349FCF6149
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1898030A5666
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DB18EFD1;
	Tue,  6 Jan 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0saJUTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CA4503B;
	Tue,  6 Jan 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659011; cv=none; b=H0miN0llEkY2myuopX+XrvAXcII1ga/I+znFt9p4NDDzzrdInFpCR7VmUWeh80clN1wOvG1rf22T7xQuo8lMkWsbjM33/SPdea0e8oyGNQQQ5zla/NCxR8AsdFQGi2CAsnxFMu+7LklYNA/ytGxEZZdAUTPwSTLTu8udLE8xc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659011; c=relaxed/simple;
	bh=FkQJugMtiM3edkXSgz/p3etKu0tymVFXmj0cd+7bLzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oX7dgicJE3gZuYr+oLQaJfIPP57fU9gV43wHlAQgsSGXwgf0CN5qL+ZNLbadN3Mo+YsqRm+rJMWQALJAB2bwYj1RsfUrIAzLXdidoh4JZZXp+G7rCnqTAu0ciKQT/1ORb3Xuf1ErkgvC979tuk7AnbfFAWC0hsokpF5rOuGKSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0saJUTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABB2C116D0;
	Tue,  6 Jan 2026 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659010;
	bh=FkQJugMtiM3edkXSgz/p3etKu0tymVFXmj0cd+7bLzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B0saJUTmW+9pYK1Ndc8XfM+sywGG2C2AVMUlKGzv+J8+0kfs5M8UF0P9Y8Sp9HcfF
	 wkcqxQCsxblq9fkqDzgIpMQbnixXLok7e5wcGKSuuSxwbxa/r20XdU1DjoGbPUhM4f
	 /kvAHo+t8rzEKmC+r3aDa78qo6JYJbFaci8PRqXTsaMUMkEt3w/b0n2W5whFMZWj41
	 Gj1Q/MlJyYd32s6KbvayO4own/lSrxsERH7iYbt+XYYM5DaIe7oM4F3r25GJmHopUI
	 IxdGi16bZktJ4P6TLKb1vKQYiWntsjEp7lURDTE4hrSFB5RmLNlOQ+JdBNLJLecSn1
	 GvlZ56jyn0xQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2921380A966;
	Tue,  6 Jan 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] vsock: Fix SO_ZEROCOPY on accept()ed vsocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765880886.1339098.1816013427410821419.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:20:08 +0000
References: 
 <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
In-Reply-To: 
 <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 avkrasnov@salutedevices.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Dec 2025 20:43:09 +0100 you wrote:
> vsock has its own handling of setsockopt(SO_ZEROCOPY). Which works just
> fine unless socket comes from a call to accept(). Because
> SOCK_CUSTOM_SOCKOPT flag is missing, attempting to set the option always
> results in errno EOPNOTSUPP.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] vsock: Make accept()ed sockets use custom setsockopt()
    https://git.kernel.org/netdev/net/c/ce5e612dd411
  - [net,v2,2/2] vsock/test: Test setting SO_ZEROCOPY on accept()ed socket
    https://git.kernel.org/netdev/net/c/caa20e9e155b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



