Return-Path: <netdev+bounces-174331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BDA5E50D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B09F3AC24C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA991EB1B5;
	Wed, 12 Mar 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7ue0Pwt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE501ADC6C
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810199; cv=none; b=R26xrmoSZ5s5R6M+HNhhdQlBjXxlDLudVrm8P8W1+lhhuT3A/7xLbv3n8P7R2oNbG32gOFCplRdlB5WxJHNmS194aZTtriTyyZfar5yYOXAgHz9VmUQWZoclWMqOJ6oFNciTGn8ic/RD5T8GKqn/iLSkDP6MOXpn3VlgrfpSeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810199; c=relaxed/simple;
	bh=U7PrIfM6UIj2uLQOijM3UfDDkblGfwD3+MrJnX3fOfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XdOkKYOcRetcpdELmYMlhITv8FkAHcj9J71jvDtShXNtB9i+8P6rzyNiSX6NthlRt+pr5fMK2VtqdtFL/NYqKX+yOMPSY6krmwDmB2WwvxUdBPl/jwFdupne2fq8lX5qSjeyNO1LlPA2upg6RG5I72KxqKE94U/f3ze44iiC6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7ue0Pwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB97C4CEDD;
	Wed, 12 Mar 2025 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810199;
	bh=U7PrIfM6UIj2uLQOijM3UfDDkblGfwD3+MrJnX3fOfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k7ue0PwtAkjjZB2ilcmjYAhCXl3YeXcOyeRWgOIAmUSDHsn6zlGgUjIzCvH0MPBou
	 MhhPIbong4+9Km2woRwdZo/yLFw0LDOt2rRiSNAhKcB0mJb8gFhANGO0T8VGwX6yfC
	 PfPwcGVe+5uP+0kiOlu0Ozc1ni2/dDgGiuQXhvZr1La7pJuI7eZJw0rEAjrQWCW8hn
	 4UEnzfPdyAf9jrdbocli3y+jA7aKcuLQ+OUOEd1of9CU2Qhwi90k1kFP0JUeSV/C4I
	 jTlTJiIoLCEbQzNevvsg/dybHV5aHBm7BJT/NNd1p8ZTFswNCVlL0q6ZV6mPowbaPC
	 hRxppZEAXRpGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC3380DBDF;
	Wed, 12 Mar 2025 20:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net 0/2] net_sched: Prevent creation of classes with TC_H_ROOT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181023350.915462.1517696676563740125.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:10:33 +0000
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 mincho@theori.io

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 15:23:53 -0800 you wrote:
> This patchset contains a bug fix and its TDC test case.
> 
> ---
> 
> Cong Wang (2):
>   net_sched: Prevent creation of classes with TC_H_ROOT
>   selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT
> 
> [...]

Here is the summary with links:
  - [net,1/2] net_sched: Prevent creation of classes with TC_H_ROOT
    https://git.kernel.org/netdev/net/c/0c3057a5a04d
  - [net,2/2] selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT
    https://git.kernel.org/netdev/net/c/bb7737de5f59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



