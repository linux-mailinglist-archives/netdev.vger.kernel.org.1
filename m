Return-Path: <netdev+bounces-174487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABEA5EF91
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F9179906
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D4263F4F;
	Thu, 13 Mar 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKbKxJUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E43263C8E
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858198; cv=none; b=ON5IUGTDiyW6gXvr5fR5JyRMNAEatsWDqMMnLiN7q1D9VHC8yge7gaqfgRiPrrlZUoe180atb5/jFonjqoD0zJdiE92LbxQQRvPeZx/0CONnJXjreriQb0iyEhC/eENIM2rXt67kU2uHZCKUBx63eCcPgvUDquLwjL6TkYxFU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858198; c=relaxed/simple;
	bh=fsNM/FyI+HU7L6GvVZXyZbyO0GdHFwG/DDrNl4IELEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LmORencDCfFVFzR9eJjOh8Yg4CDMcX9DzYpPcl6BZwHhtcNIZyc4DQ97DfPMriu6jqVEwWTUica7Megn6RVkOf75DAkwqZYJQaKSENuU+Tmx3UYRXaE9HAMebMc+0EaVkQW2hffNWyz8odsy9fv171tSNW1IBCiv/mGfvcd6/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKbKxJUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DBC4CEDD;
	Thu, 13 Mar 2025 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741858197;
	bh=fsNM/FyI+HU7L6GvVZXyZbyO0GdHFwG/DDrNl4IELEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKbKxJUiJaAxsez14nlcX4Af4Wl0n3lujE9rxVsWgS/Sc0Nz9NxQG0HKZDcgO+9u0
	 9I+SlfAwPd27YP2m2LHAsQXuT/Pp5TeGhPFXigh5BYP10XI4HcQB13PMLRAar06s1A
	 G+2a4pEyKahmMqlKKNOtxaSIV3T7KIgjNEbPzHiO3dFPy5I37bvk6vqJXGHY9pSMjG
	 09U9UqUwVoOZfN30yWhINcditkejObVXxb11Kcid0PNyFTTbn4wWkixu44hGzFF96h
	 NAb/J6/yakUu2bxMLqlmu189UeoMti8FM1d8BE2/2GgVvk+fIsHgy0tp37V6gBC/l7
	 rbhnSlpGOeLYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C483806651;
	Thu, 13 Mar 2025 09:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] gre: Fix regressions in IPv6 link-local address
 generation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185823225.1435256.11726543934454068982.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 09:30:32 +0000
References: <cover.1741375285.git.gnault@redhat.com>
In-Reply-To: <cover.1741375285.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, antonio@mandelbit.com, idosch@idosch.org,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 7 Mar 2025 20:28:48 +0100 you wrote:
> IPv6 link-local address generation has some special cases for GRE
> devices. This has led to several regressions in the past, and some of
> them are still not fixed. This series fixes the remaining problems,
> like the ipv6.conf.<dev>.addr_gen_mode sysctl being ignored and the
> router discovery process not being started (see details in patch 1).
> 
> To avoid any further regressions, patch 2 adds selftests covering
> IPv4 and IPv6 gre/gretap devices with all combinations of currently
> supported addr_gen_mode values.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] gre: Fix IPv6 link-local address generation.
    https://git.kernel.org/netdev/net/c/183185a18ff9
  - [net,v4,2/2] selftests: Add IPv6 link-local address generation tests for GRE devices.
    https://git.kernel.org/netdev/net/c/6f50175ccad4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



