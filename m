Return-Path: <netdev+bounces-133350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD495995B8F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07C1B236E3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC72219CA1;
	Tue,  8 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfD7NWBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D5219C9C;
	Tue,  8 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429635; cv=none; b=M70h4DJmaN/wK3rEtimoLFtJVjMD8SFGWnbLKUf9/gAKVtSva1zqin9GXIDlwFQzGgpE3JajAHcXwguNAzYP7sjPZtkS3kykzDxepXeQrlswQCWv/zh3iGwVum3iwUKV28zJcTZII8qE1gnyGSFvUefWT5UgbcBCE2bjLY8gCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429635; c=relaxed/simple;
	bh=s6GlbP8OJ1MJm4pGr4Tvsiz8CQseoJ6ksn1gXjU6EwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rvMXJJ7henthcihVKmp8OYH5RdaOIXQDg6sgQKOOHGw5HG38a34eb6DhqzWXem2U/zqMWyOzUl7tDMhg2HdEsWbTLfsUqdhN5xK5/HDoaQ7PIc90gxrf/ueYDDV7JWeA3rJbpFLW/9jpAb/CXT1xCyl+bTUrhdjVr6cd0hpy1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfD7NWBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017D2C4CECD;
	Tue,  8 Oct 2024 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429635;
	bh=s6GlbP8OJ1MJm4pGr4Tvsiz8CQseoJ6ksn1gXjU6EwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfD7NWBjpH4qjir0vz0l1u1xqrb2gIlUEOyR2BqfBy+fxEU9pqFJ0ihdwIXCCvQdo
	 7CafPJSWYdHVjcPnBGV/zu/EFrB9A34MOW6Ra6lqcViPL91m5Uh02OwlmGFzFYpSzK
	 5Qv7aHR7g3xWcChhFq4mM0ws4kVIrZY12E/PX0L0R186toHLBbNA2CtGAlMLBvyNtI
	 0IP+a1iU8Wd7SDE6EfD/roGjoxoplBKDYe5OU+zRCnP2jJX9VQsX8ozejZ8E4SAlgo
	 DmWvWNlJTw3s0EpRoESmTiFWWnmguAgtIRb9UEpvv/WBu5etFAaIiDUskKFMGCYu0Y
	 JdZ08fDQH+TaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C003A8D14D;
	Tue,  8 Oct 2024 23:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] chelsio/chtls: Remove unused chtls_set_tcb_tflag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842963898.718280.1085931231285223325.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 23:20:38 +0000
References: <20241007004652.150065-1-linux@treblig.org>
In-Reply-To: <20241007004652.150065-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 01:46:52 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> chtls_set_tcb_tflag() has been unused since 2021's commit
> 827d329105bf ("chtls: Remove invalid set_tcb call")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] chelsio/chtls: Remove unused chtls_set_tcb_tflag
    https://git.kernel.org/netdev/net-next/c/35213cfeefa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



