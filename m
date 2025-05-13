Return-Path: <netdev+bounces-190275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C739AB5FA3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BC3AB66C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BA1FAC50;
	Tue, 13 May 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3lGQlm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9C157A55;
	Tue, 13 May 2025 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176592; cv=none; b=P8fK3ICfrQUMIM+VqkN7COD59KRxFvdmSTC9CDWue74/BvnWmBLuL5wtsOZK8jZZUVXyiNRRJGjNlcveDjtjlrbsyUAe1kWWbHgPI0pDk18ZUGG7tAbHcK47kyauWyqtmCJ9+wMOdE+kwPcGHIkxD9kdbRD+vHtrW61ou7lOJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176592; c=relaxed/simple;
	bh=2b5sWhBlD59bEzSlsX6RDsHKs2/EwTFMcRedAGr7dws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jv6cTi+HZ98Y7NinwhjV3zayTJ82Nolm5xNiYYSdG0tIVYWrpy6lqHEK/+uQ4fhGZa/MZdtgT7kWY+z/Gq3KrpuAFIcePYE3btdNh7PwQLHXb7H0DxNjZSmzkiRkZSoLtYHz6/kDpYwOBHQ2DxWmwqrjzuKO9LvXiNP8uKtnS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3lGQlm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8385EC4CEE4;
	Tue, 13 May 2025 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747176591;
	bh=2b5sWhBlD59bEzSlsX6RDsHKs2/EwTFMcRedAGr7dws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3lGQlm7XuLzug6FQD12Ge6xK+MEOJpYHyy0t0h34ppGm11vwnuV+5MjCz83Zg281
	 +HYiXZ79N1RfqvJL4PpQ0tZPeLQ3wEvOUwZiSVuCMfn9k0XQ8bGVZ6FyhCT8ipuf7u
	 RKFsTQseMrdApBul0VtE5kpjj/jxFVV9lfNvnDEoZ5RFHG9k2Hf5OWUTHXKFz4BTQQ
	 snVB7+1QO5W3x2N2JjAmM+l7G0P6kulJK//USORQXywMRf6S3iN6DHhgvu3nmFXB1i
	 Y3RCSEr5KNeAqBMP7hnvmqktdbtlFYfiWolB2qChWIE1mi63d3bd7R2uP0ikZXZyXN
	 LcWbAnOvYXHUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B75380DBE8;
	Tue, 13 May 2025 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: networking: timestamping: improve stacked PHC
 sentence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717662903.1815639.442567872632505480.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:50:29 +0000
References: <20250512131751.320283-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250512131751.320283-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com,
 linux-arm-kernel@lists.infradead.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 16:17:51 +0300 you wrote:
> The first paragraph makes no grammatical sense. I suppose a portion of
> the intended sentece is missing: "[The challenge with ] stacked PHCs
> (...) is that they uncover bugs".
> 
> Rephrase, and at the same time simplify the structure of the sentence a
> little bit, it is not easy to follow.
> 
> [...]

Here is the summary with links:
  - [net] docs: networking: timestamping: improve stacked PHC sentence
    https://git.kernel.org/netdev/net/c/d5c17e36549c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



