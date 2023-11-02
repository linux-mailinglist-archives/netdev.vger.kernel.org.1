Return-Path: <netdev+bounces-45647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340C7DEC33
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8338B2109B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D61FB5;
	Thu,  2 Nov 2023 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7RurJsj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6541FB2
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8C24C433C9;
	Thu,  2 Nov 2023 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698902424;
	bh=LY/GZQwDSN2O7EGkqjUQxOvRzQRX+mJpb0XdMYxLARc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W7RurJsju4Sqh4z0KjeHZm5ETt2xc1gj2PO/+Xr1/EcQyS9JOaVa5JFTyaFK7BBkk
	 nBB9pMpSIhWa26CFAJNzBi9eFvxaFPLkekK6tqxUOj7FalpwOyc+tKH5V7ZqHj/ICv
	 le12DU0/qq8pJ5B8BFugSjXzA4QejsD3nyhXsKilHTftF+ZlqdfEHde8tYyulbiNZg
	 aJEiVXNijJXTDTd0re2WZ/LTN03qopD74dS9k4QnAQzN8JUQlMhHvgpbWo/2A0TbQa
	 lri0dYUQVofbiiOY4FXwS6Kyctnd9aj/lWi8EYL/ogkWOdbc0d/55qk0CABAfSXD1b
	 EW0JGLo1CGJIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2EA8EAB08B;
	Thu,  2 Nov 2023 05:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: don't touch the output file if
 content is the same
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890242466.25325.7974890746522887259.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:20:24 +0000
References: <20231027223408.1865704-1-kuba@kernel.org>
In-Reply-To: <20231027223408.1865704-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 15:34:08 -0700 you wrote:
> I often regenerate all YNL files in the tree to make sure they
> are in sync with the codegen and specs. Generator rewrites
> the files unconditionally, so since make looks at file modification
> time to decide what to rebuild - my next build takes longer.
> 
> We already generate the code to a tempfile most of the time,
> only overwrite the target when we have to.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: don't touch the output file if content is the same
    https://git.kernel.org/netdev/net/c/2b7ac0c87d98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



