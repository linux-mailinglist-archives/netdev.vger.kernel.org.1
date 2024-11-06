Return-Path: <netdev+bounces-142463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC609BF44C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47EDB2122D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17413206E87;
	Wed,  6 Nov 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlRbTOHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1A206957
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914224; cv=none; b=CJtaNhuq4OCIzuh+TPoMkOPZSZEWOYWjKDEZn4cYIYOmCWClbdbHMWsPUHx0oGO1zobDO905JqvCyTIuR2yDZaoVU4EZrwQEa0aOp8vz96QUsEf4Nzg9ahggCaH2TGt53oJY1THzPJHJfV1+o9NiKNoVrymbZZdAATKqJ10xmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914224; c=relaxed/simple;
	bh=6PO2Ca1A/vzU4wQCwF7I2kgXYYW7dV0ReS9gXG9j7RE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JNptA1ThQp1o176v+7CzntoFxAYTLESJgwdAD9q8pJHrNfLIDhJwfwtW/gOvneInoLZZ5RPset4yUvebIeTse4PLBeL4YuRE9iK8cVeKqsGIkrAnDDbsxy8pWctzUyqsEsond7tln85jK8n/y4aKR/HdF7PaPTH+kUuj8Wu07ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlRbTOHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA84C4CEC6;
	Wed,  6 Nov 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730914224;
	bh=6PO2Ca1A/vzU4wQCwF7I2kgXYYW7dV0ReS9gXG9j7RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XlRbTOHWwehry9SszKOH1ux+2L19eCrYdLzSyXBVekRUHzjfIO5jkjGmcCaHfMcU5
	 ZoI9qhP+YvlBfbyN3BGFbphE6GkUkRqUksvtgIuraPYdewab8HcnQBqxvbIQPOw7sr
	 YqEtAhyVYea6FJH1RCRZCnCA6wEWjyeXqonk1Xi/3Uvxc7WTB5PlDb7ShtdxwDQp50
	 2BdYWaBb2gHKUTowdFZrVBhwQvTidj9a6SlUbr3y/FQFxJoMVufx/7RkKCudgLPYoa
	 g7igNv1pQGxk1e87mT1hW1zHkPnjFuLFjLCIt2GE+Kh8lF4MxyE9Uw3y3Pu3mFzURm
	 QHgs/9+mgjuaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF4DD3809A80;
	Wed,  6 Nov 2024 17:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] bridge: add ip/iplink_bridge files to
 MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173091423354.1355897.85598411385203122.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 17:30:33 +0000
References: <20241031085143.878433-1-razor@blackwall.org>
In-Reply-To: <20241031085143.878433-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, roopa@nvidia.com,
 dsahern@gmail.com, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 31 Oct 2024 10:51:43 +0200 you wrote:
> Add F line for the ip/iplink_bridge* files to bridge's MAINTAINERS
> entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [iproute2-next] bridge: add ip/iplink_bridge files to MAINTAINERS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5da7e66992cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



