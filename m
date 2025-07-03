Return-Path: <netdev+bounces-203833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B8AF7664
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448177A8794
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEC2E7641;
	Thu,  3 Jul 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGhDUrqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C623C512;
	Thu,  3 Jul 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551191; cv=none; b=SCLZGN1CNko1UW0E3yQ0NcUyQwMBVaFvBDbW3zKAovMSRNJd4zf7PJtyD/LwBNz4nx/iN9NYL+leV+t6aaD5oxduVEuQnY9YFp7mIVc/a3lkkbjxABP6Y1Pk2a4H1Jrmeap5QB3CW1Kfq+ObPv/gbANqhEs0JoAj5TyHJ3wAnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551191; c=relaxed/simple;
	bh=edtgpnX53JCZZy1iES92p0EiTMae8N4vIOkkyGwRFr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQhvtnvD2+AP8FjxNFe2sXGgTwp+sGOZKlu/GTf8jA3gj1LYs4gNpeXtLrlG74ScFbJqrqu51MV+5RjiH0kXtUO+X7EnOLr+UwfAO8Tb/6bD23si+Kn08yRMsuj+dp5IfpycCyJEcJgzksG/Yq5k7UmfxwSZSbzYVuD/gIg/nMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGhDUrqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3DC4CEE3;
	Thu,  3 Jul 2025 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751551191;
	bh=edtgpnX53JCZZy1iES92p0EiTMae8N4vIOkkyGwRFr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uGhDUrqnpmrhR/fqztSaP6QC+8KglYz7xjKBrgA5DJDDHfodTX5qLJuI3gtCX0SfZ
	 EUJ6rUyolfX+yKN0nwWgFh0X9aT9QEnSZkszIli5JLovHd2n3Ht4tKp65iyF3HN1/J
	 kVI1rH2+zdGRwNF/+jDc+1skKTHEoOZx6dnN4fGGDksXnNpfo5qmLuhhy7h/Qknm2/
	 n2y2gzvlpljWccv6l2Zb6J40n7idc1oTLd0c2dhDLweLok5EAkgVDfaAaamyl0qQv9
	 v3dTHWnJvpGZuqPO0NRam4eI33v7oHg2UNfW8x9eY+qcruXiKSMR1aRleQbQL2Hjaa
	 xlguuJ1+19K0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF48383B274;
	Thu,  3 Jul 2025 14:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] Another ip-sysctl docs cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175155121526.1491725.12686388638876887833.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 14:00:15 +0000
References: <20250701031300.19088-1-bagasdotme@gmail.com>
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 abdelrahmanfekry375@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 10:12:55 +0700 you wrote:
> Inspired by Abdelrahman's cleanup [1]. This time, mostly formatting
> conversion to bullet lists.
> 
> [1]: https://lore.kernel.org/linux-doc/20250624150923.40590-1-abdelrahmanfekry375@gmail.com/
> 
> Bagas Sanjaya (5):
>   net: ip-sysctl: Format Private VLAN proxy arp aliases as bullet list
>   net: ip-sysctl: Format possible value range of ioam6_id{,_wide} as
>     bullet list
>   net: ip-sysctl: Format pf_{enable,expose} boolean lists as bullet
>     lists
>   net: ip-sysctl: Format SCTP-related memory parameters description as
>     bullet list
>   net: ip-sysctl: Add link to SCTP IPv4 scoping draft
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: ip-sysctl: Format Private VLAN proxy arp aliases as bullet list
    https://git.kernel.org/netdev/net-next/c/501aeb1ef463
  - [net-next,2/5] net: ip-sysctl: Format possible value range of ioam6_id{,_wide} as bullet list
    https://git.kernel.org/netdev/net-next/c/2040058db302
  - [net-next,3/5] net: ip-sysctl: Format pf_{enable,expose} boolean lists as bullet lists
    https://git.kernel.org/netdev/net-next/c/98bc1d41f2c5
  - [net-next,4/5] net: ip-sysctl: Format SCTP-related memory parameters description as bullet list
    https://git.kernel.org/netdev/net-next/c/82b056600059
  - [net-next,5/5] net: ip-sysctl: Add link to SCTP IPv4 scoping draft
    https://git.kernel.org/netdev/net-next/c/2f1fa26eef65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



