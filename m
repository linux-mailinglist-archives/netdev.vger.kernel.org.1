Return-Path: <netdev+bounces-205128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6746AFD836
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EC7584556
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164221D3E6;
	Tue,  8 Jul 2025 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKf8ST5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296021E5705;
	Tue,  8 Jul 2025 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005983; cv=none; b=qBmtszD3C1m3ApOZ+y5bwpTUwT66N//kcEiLvN/Su6vm21ADlJ1T7y65dHDe87eRNhMud02M7vIESfzyvWvimgiQSdscBYEfWjfXVkxyygqEciYMySa6K3luy11ooT4Z66a7YbLj0UqoYDzwYmRjn8wcCUXOTL7ApNCrojkZ7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005983; c=relaxed/simple;
	bh=hrDrvh31fh99izkGRHOTd6XJDuI3JXOTw5ugEGttONM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WAs8kb2C0sFPEdp4YjJU8Xu9vtQ5HydJiZYH6yjpHMzgXMvmx7hvTiGlkVjof+9dfHfuuPVYCnVd33a25kB1PGEhC3zueH8BlT861stC/qIjDTedOEnD65Hg5Fh1JPMHLFOyEpstxPrJseC7kNSSQBejlJQZry4nIGvW+HzqMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKf8ST5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35CAC4CEED;
	Tue,  8 Jul 2025 20:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752005982;
	bh=hrDrvh31fh99izkGRHOTd6XJDuI3JXOTw5ugEGttONM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HKf8ST5bN+gJDPk+B04fx88dqidtxQtsPGuLmCfsJ3TnjwyUs3WZ/soGD7DYUu2Vg
	 QK+X9ugtTAZAf3wNLeY1HrKN+sA3WzCERiA1kSdcMQFJj8BdIzxHC8YSvfUdB+OEGN
	 oni/+Ae6nPciOC/xDF65HJJgOczlYKgF5nKPWzRux6nsY/IRu7TCNgXeUdwXhusXUZ
	 mSo6T45nrZTUP8pUnVlgA3tZNO6j2JNCgD+oK9bTB5Z7+FujNEdDh2R+J4XtZfDQeH
	 D9fVNj1HDZml4zNxw3EFeZnQeggzx0OCCsDa6fCiNbnboiMInCAIM9se6n46SlQdkl
	 6lz/DI4Q8XZVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFEC380DBEE;
	Tue,  8 Jul 2025 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175200600561.1338.1628292736054563749.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 20:20:05 +0000
References: <20250707102435.2381045-1-dhowells@redhat.com>
In-Reply-To: <20250707102435.2381045-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 11:24:32 +0100 you wrote:
> Here are some miscellaneous fixes for rxrpc:
> 
>  (1) Fix a warning about over-large frame size in rxrpc_send_response().
> 
>  (2) Fix assertion failure due to preallocation collision.
> 
> David
> 
> [...]

Here is the summary with links:
  - [net,1/2] rxrpc: Fix over large frame size warning
    https://git.kernel.org/netdev/net/c/31ec70afaaad
  - [net,2/2] rxrpc: Fix bug due to prealloc collision
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



