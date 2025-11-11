Return-Path: <netdev+bounces-237419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F06C4B315
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB8218904B2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98413347BA7;
	Tue, 11 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmmjEy7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70210306B30;
	Tue, 11 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827636; cv=none; b=aoh57N0Co+Hzd9LLWIXL374FSiY6GMPNUwxI4+zfdNw1/hHPH7dxvnqHsdOScCZP4tmyfiHqSgB5tnXfkwSrquQZVBpm6FgP8fp7ok3Ln3xNej0OGS2Q9GAci1y6TUP06F0GMYDfWnUjOvWZalHq+T1jfk+8WIRO8xFy1CdgEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827636; c=relaxed/simple;
	bh=OuI+VnSlq1DV3oVrG2pT1LX+5NsSnni2+vwvOlKzX7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dsTwu0z1PGgeSSleGvfJM4uoM0r46qVq3OEbo3km6dJjn2FTIO9JcSy0+i/1fQcvEQjzzSQLHLVCMn8Yppn48QMbaBBNyWVLP+dNn/uEWeJJc8LOQ6XbQSJMI9v2RKYjzPoEDzoYWriyxLt8S6PTZb9hqPaF2gY7p30hrRgRn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmmjEy7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03F9C113D0;
	Tue, 11 Nov 2025 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827636;
	bh=OuI+VnSlq1DV3oVrG2pT1LX+5NsSnni2+vwvOlKzX7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LmmjEy7FRWjN6IEbFt7mY3uhs7s5GimDKDh0YcM3ls72E+j9k8ef+DeNA8axn9Az9
	 6LezMsqWcfLbKsAMlYHvM4atHKjSGP7EWDSRQfCnYisJaJxaBxtBCHHAmEi2q6jys9
	 Ss4mcI4ol+n5NpITrxDUlP+jVyASN8kLskw64qIafopmRh8DnR8gQwzvUpVtMa8A2X
	 ofNnDZuwesc+YkNYD0aFDVxKzteQCvjSnARw2aCLN+aKc3gYP9JqGJD5P2yJJcuqpX
	 n5O0ZVglN675G2u312ZIv2YgjhQuSb1D0qyb/quLl1GY41CfGEGSqN7B9qugVrfSYv
	 0HI8uOTO28O2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE046380CFD7;
	Tue, 11 Nov 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] isdn: kcapi: add WQ_PERCPU to alloc_workqueue users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282760651.2854334.15711207363793586593.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:20:06 +0000
References: <20251107134452.198378-1-marco.crivellari@suse.com>
In-Reply-To: <20251107134452.198378-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, isdn@linux-pingi.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Nov 2025 14:44:52 +0100 you wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Here is the summary with links:
  - isdn: kcapi: add WQ_PERCPU to alloc_workqueue users
    https://git.kernel.org/netdev/net-next/c/e483a615a609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



