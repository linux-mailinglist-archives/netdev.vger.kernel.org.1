Return-Path: <netdev+bounces-138121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499AB9AC0DC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE422841A9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2391547F3;
	Wed, 23 Oct 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhvUc0hV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9D1448DF
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670423; cv=none; b=BbfFLGpg8RBYSA8a6rznKXdkGUC7crQmvEG7DP9MczJJUnOvNHo/I2ATp3vjWVeKIbWzqKKrdMhr8fMOgAzlQY12Q709f4iJq5Su5V09VYHatFcVmzeX+qxifLUu3FwfleEW7wmuyofrAzcOUkCyIhlQrppVk5cptX00kST3r7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670423; c=relaxed/simple;
	bh=QHVbKbqQdB2pS7YTQ48n2yF0+rNCoAHjKCU4pU53pZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=juf9GZrS6yIS46y/H+h6aBEMIQkQZ7e31M6AsPK1h8VYl3pEpRm4PJERpJarwpu838Uo06pPJFNaHA9mimJjaHO+MrJ4EXFXHK+nu1OLrbuvzXhbCDqDUSZ8bjbidlIWjQ5r1YBd9CFnjSdokVbSeIhk83PJtpkkUI9Zs1pqObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhvUc0hV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA73EC4CEC6;
	Wed, 23 Oct 2024 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729670422;
	bh=QHVbKbqQdB2pS7YTQ48n2yF0+rNCoAHjKCU4pU53pZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BhvUc0hVHmKVZBTTqEM8sg0Ns4wGS6uL2PxvF876+5eY4ui3ppiKFx5fcTZ4qd6Jr
	 fymtUswB+PhlDw5z8eoJHjlrW6hrTk+9bQ0T4FP+8elUCqwz1TXCuSDWLoPrv4MroX
	 huf8DfLUBGpcm5Gx3+sQ0GYFo8wtQnJc96QAQ5ChRXKyyo6y+o1gNbhmXtn3j5+JFh
	 tGGm+nnOHXJvYV5Cc/lkKWkgTp5s23DRAwPrDWXsubEKhY9+TVYCkRsCICFYSDM5j6
	 VXe7HZFz1PgSRZtZ+eBHTRerVmdeA1jFaInjzjl+N0p2/dLWV260N6Uk8Q40BgCMf6
	 w12mUaZgCCBYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710963809A8A;
	Wed, 23 Oct 2024 08:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netdevsim: macsec: pad u64 to correct length in
 logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172967042926.1509139.6764323624352044400.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 08:00:29 +0000
References: <20241017131933.136971-1-anezbeda@redhat.com>
In-Reply-To: <20241017131933.136971-1-anezbeda@redhat.com>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 15:19:33 +0200 you wrote:
> Commit 02b34d03a24b ("netdevsim: add dummy macsec offload") pads u64
> number to 8 characters using "%08llx" format specifier.
> 
> Changing format specifier to "%016llx" ensures that no matter the value
> the representation of number in log is always the same length.
> 
> Before this patch, entry in log for value '1' would say:
>     removing SecY with SCI 00000001 at index 2
> After this patch is applied, entry in log will say:
>     removing SecY with SCI 0000000000000001 at index 2
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netdevsim: macsec: pad u64 to correct length in logs
    https://git.kernel.org/netdev/net-next/c/1a629afd590b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



