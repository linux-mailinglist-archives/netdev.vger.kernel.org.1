Return-Path: <netdev+bounces-18797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40212758ADC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8D2818B6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9C15D1;
	Wed, 19 Jul 2023 01:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8EECA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A18E5C433C9;
	Wed, 19 Jul 2023 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689730220;
	bh=YrrmVDLFzf3q5dwLmu3MAmKlODGJLhUyKUhXK8hPOx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MZHgHRWD6H900hG1vK66GnB0lKBVic8+DGsEcrcUx8yaH7vaaUlG7qPYG8yh6peo4
	 dvHb1ydxp6/wkUwaf9+nOVW5zdZFVFg8dGclM3aC09SWLlaUx7J1VoIdIgT9YVLQYn
	 sg3ZHWYfeoxAsT0/5RIBGvmX+QPwypD2UezHJKKUNFHPWL9Ym3enaxXvsEq/g9FIEY
	 7waC9Ry5/5uuj2uEvaMFAnS9kawsZ+h07NNXoZhzZkqvQc1dYCpl/UExEj9ajJUTXv
	 YcWMg72aZWCA7qMpVbnya4uyS96hgQvPSqBXmuM3X8EnsFl5nwe1U6jc18Kgf4lNqV
	 OQCz15r+Bkyaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84FBAC64458;
	Wed, 19 Jul 2023 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: Add entry for old intel email
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973022054.4553.8064290695233635886.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:30:20 +0000
References: <20230717173306.38407-1-john.fastabend@gmail.com>
In-Reply-To: <20230717173306.38407-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 10:33:06 -0700 you wrote:
> Fix old email to avoid bouncing email from net/drivers and older
> netdev work. Anyways my @intel email hasn't been active for years.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] mailmap: Add entry for old intel email
    https://git.kernel.org/netdev/net/c/195e903b342a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



