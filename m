Return-Path: <netdev+bounces-137890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F29AB04D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36950B22691
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1EB19B3ED;
	Tue, 22 Oct 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA84KYE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921812C478
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605624; cv=none; b=roag/nqX2fxAxVfPiaGE7ByhAkhdHlADvCJ1aBJSdA7Iy4iIHc8s5tJkNlu/2HX+duKQfeLfoV4IDycPPATnKLvSIHPTM/ES7HpLKseRz1D4S2eCdG2Ux1iv3W8PCMPwQYdeZ40uNxHQ4ih2aT3l9K/nvUAit0VNZI7dqinkelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605624; c=relaxed/simple;
	bh=DJ05y4+CL7Xk9Iz7SQ2Q52C3cRHu4GYobG+lBZKNx9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=em+eNNJ/Du0P3GZPEibhN5HPbX7xVWL69TTl3I9LvZKMnWYowazoskU4U0A+yvh1VnD/ifTxrrKkNJhWNJh5i1TRpEaS2UT2uZZ6RKKYrkuOw2+cHolnRLGS9EXRSYZh5DbIOp4utTZ4dm+7CrrPIQ61eb599SrQhWITutg53dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA84KYE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF194C4CEC3;
	Tue, 22 Oct 2024 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605623;
	bh=DJ05y4+CL7Xk9Iz7SQ2Q52C3cRHu4GYobG+lBZKNx9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cA84KYE9514qfbM2q/kOdEZ/K3+RE4H3PfMntoFdrwPuSSFP5yA13qNmxzU/uU+mx
	 KpDawtRbF5m+5wcTxEVkI1ejUyo1OuiQUaTJmAngV050ronDEg7yPNMlC+jkPYXCJx
	 Cb+W8hi3etvC1dMpSO16vXHgWU2ZOem4gMQlZJWcAtXtKgNd1zUFcXUC+H1HG0Yoml
	 DgEoYLIYsH5UCb+zI5Z2mGyddtc5BHsuD5UaSOelvw2LSDlfaI7e2xAhLQhGJ9K3n1
	 sMRaVrfOXX7OY6KFcbiTUAqWv1/EWIEO/lMWBxfAo8HyIMfSH6Bh5l5HpsbLJA3bze
	 VVIft97j/Glnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4B3822D22;
	Tue, 22 Oct 2024 14:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iwl-next] virtchnl: fix m68k build.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172960562974.974582.9623036354367595333.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 14:00:29 +0000
References: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
In-Reply-To: <e45d1c9f17356d431b03b419f60b8b763d2ff768.1729000481.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, wenjun1.wu@intel.com, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 15:56:35 +0200 you wrote:
> The kernel test robot reported a build failure on m68k in the intel
> driver due to the recent shapers-related changes.
> 
> The mentioned arch has funny alignment properties, let's be explicit
> about the binary layout expectation introducing a padding field.
> 
> Fixes: 608a5c05c39b ("virtchnl: support queue rate limit and quanta size configuration")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410131710.71Wt6LKO-lkp@intel.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iwl-next] virtchnl: fix m68k build.
    https://git.kernel.org/netdev/net-next/c/d811ac148f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



