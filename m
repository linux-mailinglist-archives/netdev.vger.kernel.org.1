Return-Path: <netdev+bounces-174489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC28A5EFBC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335616810E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE7263F4F;
	Thu, 13 Mar 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIHLWzd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD210263C8A;
	Thu, 13 Mar 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858798; cv=none; b=WtTRaAXrhSJ6g7jQnK/VnXA0fMyP0fABe1dUHTcmrCI0uoSiDcEa/XXWM1vS2qdqEQa3qnR8a0o5V+LeRIHoMWQdEqwxFMNoWB5F+fEhFq0GiVLks1GBkwphutQA2CyXZxH9VF8RC6+Rr4tSNLvEcRhVRBkofOco8DpVmAhUIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858798; c=relaxed/simple;
	bh=wOKA0ViPd1tRb4DDfB58xCk3Khk/1XVLmcQRSsHoceM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOFmgNGulPoag1fOw+PDhkEWV7rdY47ylc7s5qNl02V6zD+HHLmkCQXQWp4Hwa6ymnYgYb2ZetbOcbLgAI6Zmg0YSo6fgeuH0R3Wsu/BUKqDi8H/8bHZJ8A5ymoT2EB5fX5yMLJ4l+yjn1scluu0FtZiLSAeNMKJfnafnDR5s3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIHLWzd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36619C4CEDD;
	Thu, 13 Mar 2025 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741858798;
	bh=wOKA0ViPd1tRb4DDfB58xCk3Khk/1XVLmcQRSsHoceM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vIHLWzd/R/J2uFk9hPFqVqeD7IMvVYZc0Gx+lpB2/5ttR+1NkSdd/03kPKb0u/IKm
	 2giDmaQe1RLpizc3gafQpL4fzL+28X6tsjosM1+K+X6ZWSF2BXjyrxK8kcTGKf4k8i
	 Q2TdZAEbi4q2UujQYysybo5KOnjy3yA76umDwxw7jWTJx5DhCToG/KrKKtmDxnQ8e+
	 3gfBZraMAn3xhnF+EKc/dlC6VEygOevCcsTCxG9YfenKwRyKHToqrYP4PK2AX6FpZo
	 rWq932bPoH3Gb9T7pzTheqLjG+BtjzoapMy/DYNATTylgUaIy2sZeAX+xcnSvxUUnT
	 wUV+pnzZyFBzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0053806651;
	Thu, 13 Mar 2025 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: remove misbehaving actions length check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185883275.1437903.4351335237770431725.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 09:40:32 +0000
References: <20250308004609.2881861-1-i.maximets@ovn.org>
In-Reply-To: <20250308004609.2881861-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, pshelar@ovn.org, echaudro@redhat.com,
 aconole@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  8 Mar 2025 01:45:59 +0100 you wrote:
> The actions length check is unreliable and produces different results
> depending on the initial length of the provided netlink attribute and
> the composition of the actual actions inside of it.  For example, a
> user can add 4088 empty clone() actions without triggering -EMSGSIZE,
> on attempt to add 4089 such actions the operation will fail with the
> -EMSGSIZE verdict.  However, if another 16 KB of other actions will
> be *appended* to the previous 4089 clone() actions, the check passes
> and the flow is successfully installed into the openvswitch datapath.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: remove misbehaving actions length check
    https://git.kernel.org/netdev/net/c/a1e64addf3ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



