Return-Path: <netdev+bounces-147805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B39DBF33
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC32B20CF8
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083214F117;
	Fri, 29 Nov 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6mQI4nz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E233C5;
	Fri, 29 Nov 2024 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732858724; cv=none; b=BkQJP3WJUIPezoJ3uQ9aJQ6NHaIKfmaLhVgQGgD3IVhUuSLdcJL+Bms2QceL4b3xNzZ9Z/86iOrg7Qv3pY0r5T7qhco0ZqbxNf8gb/ZkdlXi1YQ6knPAlveFR4xQ803Rpth0ZsjCmWO8i8w97iYaAzKTAoq1xBa7kp31TVXGZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732858724; c=relaxed/simple;
	bh=4uLJ93C/b7Z9jyF9WuaQVk/7LPHrqxw8oKsSkbIYFUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NNo3Xdpcat8G6qy8q8lWICv/zKvu+T6XIDq1IvhV8EPJOS5TMcFJ32nF/CNxK9bBMHKUGnZ1fp18X/WOqfrPOIV57XiBF700rAewcB+LD4Qms03eItyXGsLPQv/DKzaIDr4Aq6JT92naPvCba0/yZL155M0aIX3CQh02fG743WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6mQI4nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8ECC4CECF;
	Fri, 29 Nov 2024 05:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732858723;
	bh=4uLJ93C/b7Z9jyF9WuaQVk/7LPHrqxw8oKsSkbIYFUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6mQI4nzSKvAvYZIoimrUho2uuiDON6HO+j9SYrSXPBwEORh20+H05BuGyP/BPiTe
	 yTE9TYK9Hcxky7RcLQbn3C7NBGo6GCJyT//Qjlu+aKlLZ/C154N9sIC74WYUuuXrir
	 V1pIdm8iyHYBMfk3sBvi3Qcjk27KnNImzZh+EclSDZcuW61PsJSQ9gBvded5odaeK9
	 K4kvMLzMDMjbZFbiKJyQctyHnaqBK8w0dKMhc74dkBNeVNpP+fJPPdCdXZr6/XUT0E
	 W8ferWp55HjQfFfOys+PEn20R6X5obKJRPWd+URrkCoqbZuM/2hXs9DyDsPjYza85a
	 89JTGMdJ0sibQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE52380A944;
	Fri, 29 Nov 2024 05:38:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.13-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173285873675.1939307.8972452324762545532.git-patchwork-notify@kernel.org>
Date: Fri, 29 Nov 2024 05:38:56 +0000
References: <20241128142738.132961-1-pabeni@redhat.com>
In-Reply-To: <20241128142738.132961-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 28 Nov 2024 15:27:38 +0100 you wrote:
> Hi Linus!
> 
> Very calm week, thanks to US holidays.
> 
> The following changes since commit fcc79e1714e8c2b8e216dc3149812edd37884eef:
> 
>   Merge tag 'net-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-11-21 08:28:08 -0800)
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.13-rc1
    https://git.kernel.org/netdev/net/c/65ae975e97d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



