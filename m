Return-Path: <netdev+bounces-79717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E887AE71
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5971C235AD
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79645A11A;
	Wed, 13 Mar 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfZwQxoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD14D135
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348631; cv=none; b=HHOCvERz8RgKM317ojX5OUec2vss5CCD3wCf10yhyBOUt2znFXS3fXFodtvZ0fhOrPBMZ2ITS5cGzfrrmNdsO2V6BfVy6fojfyZyhIkdf1JHrQocY3ROaKezV3eLlkCBtGz6jZ49h8PGWAnlJkw0H5UcGOEbO40402lO6rkQVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348631; c=relaxed/simple;
	bh=5MnPiZY4zEzZ5N92fPBDUb9GFbANo1ru2bz1BBF6rHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gcKqfXkIZFZkojM5x5aw1XegTZztqP2JhmGZ079GH1jdkaNGUZlXC6RM0THV9uiUdTOiuzLQn2vOD///CQHAQyj7zvMKRw1AbVnxkQjXKxEqDJsUVgnIE2eEAGOHgJHfKsKdQWYNXeKpX/ZiCk8jGIMalGRFMy8m24zq5CvAv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfZwQxoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4554C433C7;
	Wed, 13 Mar 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348630;
	bh=5MnPiZY4zEzZ5N92fPBDUb9GFbANo1ru2bz1BBF6rHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UfZwQxoLm0UdEQZCgkKtKtp8d5UEygCIS9YYM/HDfVGuXN8220tX0+Qz2629b6Dvc
	 D5oasmsgD0UNA5iODjxVskOvLgRcJwYanSlAeNWFa4yL34c7LU4BDc6RcDspMV8G3k
	 R1Pzhj9o0SlZsCudVsWEeH0UeIZy2o7FAs1V2M9xJiJmA8cJXVKMXmMbOOuOFNOrXy
	 73ZPv7XzYvP9IkGXoq1OKYpXQweplsuq77cP+luYntm0GbeEc538bHr+f+oS2RqZGF
	 URQWDUzgr3nazNZ4YWN8n4BtYCGW4M9NIc6CvWXkGDz1d112weSpF4f2LsBr3n6x/A
	 cpfbkNk1M7mXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1F40D9505F;
	Wed, 13 Mar 2024 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/4] constify tc XXX_util structures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171034863065.27997.6320528150972614777.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 16:50:30 +0000
References: <20240312221422.81253-1-stephen@networkplumber.org>
In-Reply-To: <20240312221422.81253-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 12 Mar 2024 15:12:38 -0700 you wrote:
> Constify the pointers to tc util struct. Only place it needs
> to mutable is when discovering and linking in new util structs.
> 
> Stephen Hemminger (4):
>   tc: make qdisc_util arg const
>   tc: make filter_util args const
>   tc: make action_util arg const
>   tc: make exec_util arg const
> 
> [...]

Here is the summary with links:
  - [iproute2,1/4] tc: make qdisc_util arg const
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8576afbb893b
  - [iproute2,2/4] tc: make filter_util args const
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fa740c21b441
  - [iproute2,3/4] tc: make action_util arg const
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=38b0e6c120a8
  - [iproute2,4/4] tc: make exec_util arg const
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9fb634deec9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



