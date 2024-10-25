Return-Path: <netdev+bounces-138927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79759AF72A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40060B212D9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869341DFF7;
	Fri, 25 Oct 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Kug1+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B64C8C;
	Fri, 25 Oct 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729821042; cv=none; b=DBouBFyec/9yPeIR2lpYT00k0UaZu3T6472s7ITwXokGHqPaZWS21XbbZF2thAnY33NOdzotvVz6fgyhpcoTAlKnTYq03AWcCYmm+en4wqnNklq2sL1UfAsOb64Aj6pp/YjE2JZWAYtOIKiJZYqi6nOSJ81ctC/2mMsKMmO5x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729821042; c=relaxed/simple;
	bh=RwJI6eSZUGGBcNo2fLcmRIdAXn7/yZO/iBQPT87j1Yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQNcy1y5UMmZ2u9HKgws1QJxqSpzFVNZe1cvokDiS8N0Z0tG3Rz8tbV//kYck0/7W+aZKqNlWKnrvnde5sVSHXj7lOfMPMFy1vwafjvLvF9Frm9j9YUAtgZjHlOE9+ZQpDONMVwRyvwLY1AkW397rNypFDNXE2QCv+ypiQPrpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Kug1+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A74C4CEC7;
	Fri, 25 Oct 2024 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729821040;
	bh=RwJI6eSZUGGBcNo2fLcmRIdAXn7/yZO/iBQPT87j1Yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s4Kug1+46Ei7tiCmG6SlYm1LbZ1cz8tAmIaj0TdWlgOD9XizdGuMW1fQ14J4ianAS
	 0f1ME+ppWCchlEB5R4CoKrU7h2OUsePmDOw9WzA2ba0p63gOcfJ+8r2VlHnu/oRrqt
	 4t+tAdySHqngGNhB6nNpXFP666eg31HIDUQ78vpaHURO1/P9KdDrBpoNMSrfgsEu2T
	 qZLLWI/xs4Q7D1T4ZP+DKO4KXBHHIueVP5Fa0X0zUZODkEOjJ5ay62oZyfjTRBLUa5
	 jr1kG3f0zpA1hfsf7LbBT50ruvDbXlc5ugRKT4S2Ch5iX/ipK/SX5ZH5X+Cr0/BKrl
	 g11rzI+F5IGGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA4380DBDC;
	Fri, 25 Oct 2024 01:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.12-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172982104752.2439163.457544303766936897.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 01:50:47 +0000
References: <20241024140101.24610-1-pabeni@redhat.com>
In-Reply-To: <20241024140101.24610-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 24 Oct 2024 16:01:01 +0200 you wrote:
> Hi Linus!
> 
> Oddily this includes a fix for posix clock regression; in our previous PR
> we included a change there as a pre-requisite for networking one.
> Such fix proved to be buggy and requires the follow-up included here.
> Thomas suggested we should send it, given we sent the buggy patch.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.12-rc5
    https://git.kernel.org/bpf/bpf/c/d44cd8226449

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



