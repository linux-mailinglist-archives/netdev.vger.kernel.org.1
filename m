Return-Path: <netdev+bounces-125509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87E96D713
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3D01C251A9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955C199938;
	Thu,  5 Sep 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4IMUPIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAD19939E;
	Thu,  5 Sep 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535829; cv=none; b=ZvXRgTRBoDtNIaswAQ9HGYW2x/h+4nmerZyVrL1XPeDDAp5L0B7AM38oXfPqS27VUNqIaShD9mmoEcADs6s/P75e4hYlVBaoNrtoATVoL8AOysio1rwn+AQg2DunzuHsvnZZkrn93L/FjnRhYMyNw0syo1auuQvH1m9PEbqCnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535829; c=relaxed/simple;
	bh=V3aQYb06Y4IyuD1PCa9DkPBcelE1mSeH5yx7iUUfkWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YFshkLosvHOmF92x9V2+wHvw+aFUoHcl1QVUJN8lxSCsR3c4bgYcGz/mthz7WH8UVxcFliI92wf62CGt5950/ys7mhW6Y9KS2XS+xemFKsGHmq7ehb3/2mLmJAvkINNq3pxX1B//WzRapYjeLicZROmR8mFqkkYG8QlJs9tIFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4IMUPIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6409C4CEC3;
	Thu,  5 Sep 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535828;
	bh=V3aQYb06Y4IyuD1PCa9DkPBcelE1mSeH5yx7iUUfkWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4IMUPIMjGwZggRu35FnphIxTvB2ev9pEfeauoo3UT1EP2n3vtQVkeTsitfBXAfwd
	 /is9tikDV9CTB6I6yokHDYVvHPMPzzPM4TVm3dtedfe2bqGX4+gBgo6o8tg4ueEUz0
	 Ts1iqf9HExtmnu2ujGgQ5YIMLA9t9pAFuPOEA6QX/ENj0iuH9CwGxarnTbeV665Ikk
	 VfNt4IxuNYWheYOIyNXbH5rJ07PAlM2Tai45DURGFm6Blno5ahUFtDGx3djnK7h/9u
	 GMGx+0MfLcqqE2wqWo+0ZiGZofRhh051oACvhFuWkl77dle1VuhCtEByoFFahDjeSz
	 MEHQYoYmWKYeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04A3806644;
	Thu,  5 Sep 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ptp: ptp_idt82p33: Convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172553582949.1653140.9180836026100992686.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 11:30:29 +0000
References: <20240904015003.1065872-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904015003.1065872-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Sep 2024 09:50:03 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ptp: ptp_idt82p33: Convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/335cc75ce3d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



