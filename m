Return-Path: <netdev+bounces-87244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3C8A2419
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761541F22D3C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9C12B79;
	Fri, 12 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZh6B6xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7E134B1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890830; cv=none; b=suKsbu9yd7+Jf+rj0yMi0V2sQ21/4netUrWPCNPvYRxPUsw12yeUYLx8KbPyaNEqnP9ZI7COymo/xfgfSSYhghmh9zkNl9+SBsHFD4SyXa5RZoXbneZ2C9NDftiDiX/apERbTp9y+g7ymFtW6lhjFAIBpcQwouxst2sxBIHYwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890830; c=relaxed/simple;
	bh=R62l3KyyiAHnk1Pg++D1XbAcIkMZWOOdq5n5Lj9WDVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUxP8j/c1LcU7HcUe4sEWbfYSf4b/PWOqwi0MEYVv/Ivjqsq/2Kwje44KCtBINPf502H65IEvbQhZuf7qBES3xW+PxDz2PfXnTQxJ+dKZaa6a88ee6AWTDWPYrUswdaFWe8zijIxqJc4Wo5YSDdEa+pIoSLMCWWFhpVv828lbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZh6B6xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAF87C2BD10;
	Fri, 12 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890829;
	bh=R62l3KyyiAHnk1Pg++D1XbAcIkMZWOOdq5n5Lj9WDVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XZh6B6xb9pGY0yUMQEx8bdFQyK2VAft0aTvi2YpyVG7Q/3Sj7ickqBBjQ8uKcz6tF
	 qKwdstWj2a1L0QRL99GMujJuzzvIcK4pvTKshBuwUodWzWqaeIRv4hiSqE4Y25/aV1
	 APB1enbYCvrKfzX3z3r1wcOkuQEwqNVu1XJZeYf5xODqR2Kt8xbTRNiRHsMEnhVFrw
	 U0UpXLk+h16WhYE72Im44ieIEKxvqgQxM0iIriZDWRKAhd6kHZkrsW2AJke3vEMr1Q
	 v5/Vz7zbZ5eogth0nhF+Y3Ui4+6FlMbNSqT6qT0jnM57eFGu+H3sJz335Ll4w6QARk
	 8pmg+U6284W8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6F64C433E9;
	Fri, 12 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4] tcp: add support for SO_PEEK_OFF socket option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289082981.20467.6186572911489073168.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 03:00:29 +0000
References: <20240409152805.913891-1-jmaloy@redhat.com>
In-Reply-To: <20240409152805.913891-1-jmaloy@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, eric.dumazet@gmail.com, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 11:28:05 -0400 you wrote:
> From: Jon Maloy <jmaloy@redhat.com>
> 
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
> 
> In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
> in a similar way it is done for Unix Domain sockets.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] tcp: add support for SO_PEEK_OFF socket option
    https://git.kernel.org/netdev/net-next/c/05ea491641d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



