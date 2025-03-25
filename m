Return-Path: <netdev+bounces-177578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C33A70A80
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742DF1885CD1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D11AE876;
	Tue, 25 Mar 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHWPYwPh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF721A5BB6;
	Tue, 25 Mar 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931032; cv=none; b=gdp3plkO+N/sQ55YW/di/ILsMw5tW+MMsYg3HMSck8SJDekjva4ezca1pCR1Pzk05M6RcOd5dH7nfukWgTj0fKZJaWxb5ko2JJ/7NvUERmqkLBX5GGRg/WK5pP0JlJbfAs6RyybqHl+KHkfyZ+cqbph/wob2nevo8lFqNpO4ScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931032; c=relaxed/simple;
	bh=3pGW6+1AhnEtsM+MwqtYT3MHU/fXSSEMSzL/lvhrgFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HOmgsrlr2+9rrlnUoaIrVaqk0wbAdoPVmFVndMuIk5G9LPJoQ8tamoBbxnJHeXDC+qgtqlxGyDsu+yueD+o4uiKn4gemv/q+q4QhmyGBYkr7cYvBwUqFlVkAYp4VVvsd3JxjM40V+1I6IVWKmhSfwgHG3yWT1X6E7DxfTf1yM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHWPYwPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1654C4CEE4;
	Tue, 25 Mar 2025 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931031;
	bh=3pGW6+1AhnEtsM+MwqtYT3MHU/fXSSEMSzL/lvhrgFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MHWPYwPhDTKevazMxJLwb9d5Ckc9krUFdazfXTzK6cxwbb7dovWYYhesx7OY0qGQO
	 q6mFZYh9lqL228wQhwvFTTCkI9NsMqyp3JBp75ETkG8w45b4M6rPTW6mfCQJC5KrhF
	 IRQNFTAc0BRc7SlT9vSEsVf8umiGl9pWM997tOETrIk7XMQMLCzWQxGL8JrMeoBYFD
	 w/D+t4tGNrXM0BpevuKi2vtaoLwoxWNVEE8XA5p37fbA3FEmqrO+pEiIi00s8C9SYD
	 A/ZCQSYMYZEIqrUuDFUAB+wBa1VNTkM2GKKZQsquuNdA3z5xBsQyn5IOO3wDbX072R
	 Sldg2I4cNH8hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3446D380CFE7;
	Tue, 25 Mar 2025 19:31:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-03-14
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174293106804.697534.666773492380321014.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 19:31:08 +0000
References: <20250314163847.110069-1-luiz.dentz@gmail.com>
In-Reply-To: <20250314163847.110069-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 12:38:47 -0400 you wrote:
> The following changes since commit 2409fa66e29a2c09f26ad320735fbdfbb74420da:
> 
>   Merge tag 'nf-25-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-13 15:07:39 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-03-14
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0aff75e1553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



