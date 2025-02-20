Return-Path: <netdev+bounces-167960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC149A3CF78
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C4116AA66
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54A1CD1E0;
	Thu, 20 Feb 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvg56Hcn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBE288D6
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019801; cv=none; b=n8jNCv0haryk9Z1YgxpL6qb+iav2w9cQqJqEubu2MbmrfCyp3jDAbZ3EuHhNiS72cL8pbxEwPmhQOOKUD3qGPtCtlibDR1ddb4rzlDjlMoiH0IdIhKkBu49K3MOGt4q0bRhffdZ8/ijRM8RlpwGdEP8VS+Y63w7B41QRf/2VO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019801; c=relaxed/simple;
	bh=J38p8HNr1Uug+moP7mDB1J14/1ImaYI5iN/P6cWP8pI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPCdncWbMPme47TZBXRFcftA7nViRYOMQ4Ke5T+E1hMePoHgPEtRulDVzWHWGMc7DUJOBgpY6sr4I1MiBnZVFQv7wpuTuM8hIyZtxz+knj2n/zvFYmD6mZGWu6QYqSKk0erBXNQNMwPjz7pBuHQAQm6wTyxUvye2OiZmKKbiiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvg56Hcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26650C4CED1;
	Thu, 20 Feb 2025 02:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740019801;
	bh=J38p8HNr1Uug+moP7mDB1J14/1ImaYI5iN/P6cWP8pI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rvg56Hcnme5gglwT3C45hXhSxdpKUKvYkbI/GjcgdaYjU9tgHoU6JVYKbmCgexo5d
	 Z1nsV7HyiF7RZWmUcy64wWuplUJMZTsH5+dMWmjmX2I8/IE64N/7tN7rh8kPwtzZ1N
	 Mk2N9Z4xmR+NF4CpNtDkMfFu2HBySx6j/JRdG1Gt6Pwkie8NtM4FQGnxwbj1OWwQQ+
	 XZfF0JK74+TLGbOlfGqHNLRMjX7Q5G1Dw7Edu/5HEk9Rmf7/4LUZHc8jQgn7Kt4SMZ
	 09WKYnP0SNbCkJT8kGOnqiE5fHx6C5m57xVhOcYJtpQu0cQl0balOdqRbSnLzWfmHM
	 JZaWnEqcnwCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB130380AAEC;
	Thu, 20 Feb 2025 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: fib_rules: Add port mask support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174001983176.821562.11365987129288232530.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 02:50:31 +0000
References: <20250217134109.311176-1-idosch@nvidia.com>
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com,
 gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 15:41:01 +0200 you wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> field and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on specific bits in the UDP
> source port is not currently possible. Only exact match and range are
> currently supported by FIB rules.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: fib_rules: Add port mask attributes
    https://git.kernel.org/netdev/net-next/c/39f970aead3c
  - [net-next,2/8] net: fib_rules: Add port mask support
    https://git.kernel.org/netdev/net-next/c/da7665947b66
  - [net-next,3/8] ipv4: fib_rules: Add port mask matching
    https://git.kernel.org/netdev/net-next/c/79a4e21584b7
  - [net-next,4/8] ipv6: fib_rules: Add port mask matching
    https://git.kernel.org/netdev/net-next/c/fc1266a06164
  - [net-next,5/8] net: fib_rules: Enable port mask usage
    https://git.kernel.org/netdev/net-next/c/34e406a84928
  - [net-next,6/8] netlink: specs: Add FIB rule port mask attributes
    https://git.kernel.org/netdev/net-next/c/ab35ebfabb53
  - [net-next,7/8] selftests: fib_rule_tests: Add port range match tests
    https://git.kernel.org/netdev/net-next/c/94694aa64100
  - [net-next,8/8] selftests: fib_rule_tests: Add port mask match tests
    https://git.kernel.org/netdev/net-next/c/f5d783c08875

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



