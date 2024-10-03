Return-Path: <netdev+bounces-131417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1198E7B1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69081F22333
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CB4C83;
	Thu,  3 Oct 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnLjT6RQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373F7E9;
	Thu,  3 Oct 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914832; cv=none; b=OAGaqCDqtCA9Sn7ohASj7TgpGh7cCQIScnv+lqpGa3sEdCcnVKkpAUeSK04SHSGpUvmSRBQeKEVKL9dxHt5wZ4XduHyLMVQyHOjygulH5nzS+exhVbIrUVKdtyDxjV1CFNyd43x2ttDjEChHzETyj8mQSN4yHbx7iFg8FO5q7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914832; c=relaxed/simple;
	bh=7DwgjjVFFcBp0lNlSZViftUTrfw18V7xc2GA8oHpbRE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m7RuL1R+x57+gRdH+phJgZjM9BLMUEJY/tgYK36l8lCBF4ldMRRw1dHq+o0kq9TFoXcVFlc8ziB5ID4rwP8rsDQhZWer+gT337uYU4O1k558bsYW6gMa/DIwqyT7hvEFo31lTqULB58Fn40H2mgu5gnR5ELoCIf4CH9J6xSUNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnLjT6RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39EFC4CEC2;
	Thu,  3 Oct 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727914832;
	bh=7DwgjjVFFcBp0lNlSZViftUTrfw18V7xc2GA8oHpbRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnLjT6RQGMVEJ/g7qe5FNRrdO4u/XXGk8FjgCQqTECQSKOz3xlVcH1XN+CJqH9hKA
	 pmFU4nQ1DHntKTPJZ73FMd0WwgXSmcszjuKDCZaAnXtKbihoesPSQIL7L2jj/NShnw
	 jYEFlCXjOzNOjWh9f6pVb22loglKt34i+fDSdmCyQYPqoyL5H2YExXE6P3DaBU9Wd9
	 vQ/JqR+LY/T5aBY5AsTB8QLp2o5M9wwd3Q1by9ZcAu1PFYJJvaXsXy90UyjZxq27SJ
	 EvT4HJ9A/Hmt3cI+u5aIPR9lrv0pvja0qb/jWS/CSnw/S8RW+UHqW5GT0LKPHf1+tb
	 PgZ+j/UvlGcew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7164C380DBD1;
	Thu,  3 Oct 2024 00:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-09-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791483514.1382939.113708952485182951.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:20:35 +0000
References: <20240927145730.2452175-1-luiz.dentz@gmail.com>
In-Reply-To: <20240927145730.2452175-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 10:57:30 -0400 you wrote:
> The following changes since commit d505d3593b52b6c43507f119572409087416ba28:
> 
>   net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable() (2024-09-27 12:39:02 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-09-27
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-09-27
    https://git.kernel.org/netdev/net/c/e5e3f369b123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



