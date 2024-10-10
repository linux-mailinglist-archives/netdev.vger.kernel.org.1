Return-Path: <netdev+bounces-134018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB539997ABE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFCA1F22A0D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536C199FA2;
	Thu, 10 Oct 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwiOhEQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61759199E8B
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528636; cv=none; b=mBTWrvIyK6N1ksMcc/+IvhtCrOxg0RJ3rbclqzDwsqz6rZpYBCFtqduzAfeEO+jJXKvqSUmsodx7S2CGJ3fpq7r2lBKUpPoABKKIP+BtW3AON1/42/rJQjPL3iOU5lZs/55zWR/Ja6wxI3q2ZBYQidzGeQ1Ay0mJAdaGrdCHuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528636; c=relaxed/simple;
	bh=2oY2B36dX4uX9QbTFr2Rusv3JNAwK/swd5/LwvucokE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0ePBhXVXP1ZNTsvcEPdOgMjf80klOSwb2f1xLrj7e3XjH29ziORJRT2lxJ97GYH6U8Fok5xT2RdgZtBOkJ3pG+HNIOcG/kJrizp19o3eIwXPDUUGfxR7PsBDB9Q90bDO7jy9ZkJHFElqbOe9zOYizczy1J1Hq81cMIeo9hJd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwiOhEQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32600C4AF09;
	Thu, 10 Oct 2024 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528636;
	bh=2oY2B36dX4uX9QbTFr2Rusv3JNAwK/swd5/LwvucokE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PwiOhEQm+hQYl7s9k22oWq/F40zrMBXhyqdeDd5XW/718QPhlti6emSB/dHJSNjVy
	 6jYO4a1bvhzgD2G19cn4CMnqBhmi3cCZcqgTmjrUCJg7l2hlXjlw3gyibZPWCCFA+P
	 38mPHy/MIIzZEl01CVYd7QhpByWJQnW2vgI5+gncZo7wPYbpNowzP2YVrGQtM8PT7K
	 KcgwRrX0hkX4CW0szuhhS8+VL+dwzrC5JNneZ4oCaAuA4wdg23j40UEXmiz9EaLU8/
	 8DxX5qAWypMKaLU3OL4dInZ2o9EjPsjraBSRp6PHNLlFl31Gt+wiT9yazSaJ31khq6
	 a0dMnz+9cSeDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A3806644;
	Thu, 10 Oct 2024 02:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: Remove redundant unlikely()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852864023.1545809.7403321640423392208.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:40 +0000
References: <20241008085454.8087-1-tklauser@distanz.ch>
In-Reply-To: <20241008085454.8087-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 10:54:54 +0200 you wrote:
> IS_ERR_OR_NULL() already implies unlikely().
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  net/ipv6/ip6_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] ipv6: Remove redundant unlikely()
    https://git.kernel.org/netdev/net-next/c/3a1beabe1159

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



