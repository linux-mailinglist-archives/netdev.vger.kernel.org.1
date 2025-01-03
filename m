Return-Path: <netdev+bounces-154861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5235A00241
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A623A3AB8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618315442A;
	Fri,  3 Jan 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh3Z2GvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278C1537C6
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867213; cv=none; b=NPnWD5ofPcvMsm05ccpK7A3t2uNp5d+cgK+KVyI31FQNGDK6oiHBEj0SK+8vEj9UljTA58On1xYN8qwD+U5LLqvHeunVnVu0a6decG0wIKUQWRAAtbZ+n7Gi+eeJmd+6no/F8fYeF42lSFsp+wY1RPkeUH9OL43dQNA3aY42608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867213; c=relaxed/simple;
	bh=+TvdmU/gks4Say3rIYj2340gZPuUyeZzGLKtBoTVI6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EOcJORE5J4uc9lLho/gFWiSdPBpeGV62Y17CPN4v8GhnNJcW+vz5lTP65GiW4BXD+4OsT5z9tfoTJtPjJQX6F8xDlBiU8jPRqIvuLDnHnR9Lsl74inFUIfPYjdXlMXPmRDkL15ezs21AJ4bOvCx+TLWQR0Qk4IqL0YAaEFG5lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh3Z2GvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F98AC4CEDD;
	Fri,  3 Jan 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735867213;
	bh=+TvdmU/gks4Say3rIYj2340gZPuUyeZzGLKtBoTVI6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sh3Z2GvGEUZ7/kZJU9e3Pg9s6aPCuEKwe4gv3DMBqXit3mdYt5g/8Fqksdc47RoZF
	 dJeEBQz9ugrde5YRJ60iXB6NVxXvIeYxMeNIvadlwPaaBheQCacA69VK1GC5pLdbXS
	 dCOrrYvNg3VoPeIG2bBJt+t0+H60rVj8HqDI/ZgXcMZovW0ftmW+6a2wGz2gonXaBj
	 q9jazFVMgOZDt4cU9CQiH51YuCgMMAft/4/xxbPZJe+AfbtEmtSlMrpF+Frtd3CJRZ
	 5rbR3C4N6Kr98i7vrEEwY/Uhj0M5vgZGpftDUrOLDqs91Nie2xcE4mLzRkTnPpU+Vr
	 gZ8TfuhtnnpSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04F380A964;
	Fri,  3 Jan 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] devlink: Improve the port attributes description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173586723335.2076853.356467777979246977.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 01:20:33 +0000
References: <20241224183706.26571-1-parav@nvidia.com>
In-Reply-To: <20241224183706.26571-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sridhar.samudrala@intel.com, shayd@nvidia.com, mbloch@nvidia.com,
 jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Dec 2024 20:37:06 +0200 you wrote:
> Current PF number description is vague, sometimes interpreted as
> some PF index. VF number in the PCI specification starts at 1; however
> in kernel, it starts at 0 for representor model.
> 
> Improve the description of devlink port attributes PF, VF and SF
> numbers with these details.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] devlink: Improve the port attributes description
    https://git.kernel.org/netdev/net-next/c/bb70b0d48d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



