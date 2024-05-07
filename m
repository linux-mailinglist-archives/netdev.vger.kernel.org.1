Return-Path: <netdev+bounces-93925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F054D8BD98E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A87C282DD5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D33FB1D;
	Tue,  7 May 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjJP6V7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B46A4;
	Tue,  7 May 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715050228; cv=none; b=P6co3RPoGmZnJiOTVqBLn8a29T6GuxYkmm/6wXAh1OOL37mwS1cdeKRfX9gTkwU0jc+H2yPYfFsks+2vxmA82syVrTq8ZYzVnWLXY1S4cjq5fNFJ5rbCBRorEDVvZ+tkQqs31vMfszCDnkO5BIg31UCmrwMExQY2eHONZDO2/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715050228; c=relaxed/simple;
	bh=KBBezeqB0U+xBPgpqduI3HFO+ZA2L3INddeFJ/hemnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QsObg5DY+wcSwe35iIx1SkIW8DlYFgrX8WZY6P81pZTii/HFUSUQwWr+h8xdc4eL+HlRcPZE/s3i5w2ZClYpllZGjtiE8T8v2BxXu97/Un2UyL64GQtZYrOxuOVKusVvn8/+3g8i5cDj7KzxdqIE9zOVvW0XFf/Mext9urG3mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjJP6V7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD7AAC4AF65;
	Tue,  7 May 2024 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715050227;
	bh=KBBezeqB0U+xBPgpqduI3HFO+ZA2L3INddeFJ/hemnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LjJP6V7MOrjbednIfdHRRS35bsRIgfvl8gvwYkdVNKHzXe9Em0SN1H6KxKK2VRQw7
	 kU2Uqf3tybVnv/3FGuAzmncfh8LXhNHstmR5hcyccYBg22Yjlvw+w6JbAGG59NB74Q
	 kU9ha3lc039xdbdR9tcqlUibXhb6RW2+ASQwUrTExkDYYAPdyPbSq0smP3fAaeUpYW
	 4w0KKU14iRsMK7Ds2pA9rw9d/M6BWXZbat4yOtJLx3wRp23lz5JyvHtBL5wS42UahU
	 DFqoeftK2RWFjGQ0tM8r1iSGTcYZBC2Tck3hwJq7VzhAOx7faO/fRZ0ha6qcR1yycm
	 3NVBw97Z8hp+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5D4DC43334;
	Tue,  7 May 2024 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [PATCH v2 net-next] mptcp: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171505022780.7000.12296419388151521927.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:50:27 +0000
References: <20240502154740.249839-1-fourcolor4c@gmail.com>
In-Reply-To: <20240502154740.249839-1-fourcolor4c@gmail.com>
To: Shi-Sheng Yang <fourcolor4c@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 23:47:40 +0800 you wrote:
> This patch fixes the spelling mistakes in comments.
> The changes were generated using codespell and reviewed manually.
> 
> eariler -> earlier
> greceful -> graceful
> 
> Signed-off-by: Shi-Sheng Yang <fourcolor4c@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] mptcp: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/46a5d3abedbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



