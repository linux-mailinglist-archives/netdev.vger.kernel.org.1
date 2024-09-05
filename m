Return-Path: <netdev+bounces-125717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E696E5A7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428282857FB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07F1B12EA;
	Thu,  5 Sep 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd408wKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D801B12D7
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574233; cv=none; b=DqWdATE/RILegQ+CwguWhC/v66blBaKYsk45aCJ0oUIGYKs1BI7N/pYDOgrdCLA/OT7SSICxBNvaJ17J8pqa+3/kJFG328yQanjvPFf3pX3iFiU8nzJ4fQ/kAjZycovevkUEpJKK+FUISj0X3oJ+TQ4DBoP9WTWuYDdhbx4eU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574233; c=relaxed/simple;
	bh=j/Dm3JbtO05LZddrPrC+MY0m2xLnVXAR5CCsBPtm9Pw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTuEntNaPCYezZveo1TOxtBiddOmoFE5jLNe0OlVLoKe5ARLSH/7Sd/FCui3iqjIlyI7r4wBtjLMZuyieEM9j2xiFzSb9Sm7f0oQ5kPwuf4H5RWAtSFeCbkG8BL6d9aTlh9I3xQ88aHordZGQY8XMgQMVaYNET44mFZPiPhUAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd408wKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67786C4CEC4;
	Thu,  5 Sep 2024 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574233;
	bh=j/Dm3JbtO05LZddrPrC+MY0m2xLnVXAR5CCsBPtm9Pw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nd408wKe5gwfy5W5LGjgsyYkNDDXZBPhoz4S10LllyoL+QzE1tO3tVKe4WOdhc4wa
	 KPXfMZTQAk2tdtMJY2bpu0ucLFI+vGgcBwuPlgSXyWqNUqXuP4Tzjos0XBxWWxT6Ls
	 fUXi+UGb/A7sZQkykqyOOk4HhDkfFjdhMUeQGurm3ydUgSY8kUZPrt/DHMcVlW7P4w
	 KViBrdYpl7KcTqWZmI3CDW5g4PCNFDRvc134vuMCOzmC8BBEjPECxCpYddTOK4Phow
	 fU8buCToYoDs+iUs+MLoVuva2WHn9z22t1AapoLtTJVbQUsl+Or8VtjuUxaOm8luH8
	 0NahCAJlNp4GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711543806654;
	Thu,  5 Sep 2024 22:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: fix ptp ocp driver maintainers address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172557423424.1859883.3199145126344454048.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 22:10:34 +0000
References: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, jonathan.lemon@gmail.com, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 13:18:55 +0000 you wrote:
> While checking the latest series for ptp_ocp driver I realised that
> MAINTAINERS file has wrong item about email on linux.dev domain.
> 
> Fixes: 795fd9342c62 ("ptp_ocp: adjust MAINTAINERS and mailmap")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> I'm not sure if it should go to backports queue, so if I'm wrong,
> please, redirect it to net-next tree while applying.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: fix ptp ocp driver maintainers address
    https://git.kernel.org/netdev/net/c/20d664ebd212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



