Return-Path: <netdev+bounces-150469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1E9EA51D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9833328148C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B619C556;
	Tue, 10 Dec 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbrzU1TN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C619F40B;
	Tue, 10 Dec 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797815; cv=none; b=KRcTShzj1jURw1KitbogEW3sUyY/Ghv2uc2JoYTHOaMOzzVs1v39D7mDzCB7g7jDbTbCFXRd/JvSE6droToU+D7xMOhtqaKCYDdVr0+bHCOv/zmTUzd+SZ8Gou98XOiYzDR2lJScmpO9RyNiOhBffqftTpbzMlSCnIC6UoScV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797815; c=relaxed/simple;
	bh=iUR6wZ+vF94nOVkdKj70CRyZA/xiCM2WcTecmDPBPw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h/3Uz9QHlKTQl6UuMnIfllz2PH/AJHPvCzJARFYhxf8eyHCP8bFc39oId9r02IdWy+oVHtZXZYferjeCe2ARe79//Ccj5fcN5nXMe3s7JOoYAaMZ6ZgB1o2z79xknqQPz80wkERICwzcWbuuNb2Y7AD4Qnek51+CV4QaoW/78qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbrzU1TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667BFC4CED1;
	Tue, 10 Dec 2024 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733797814;
	bh=iUR6wZ+vF94nOVkdKj70CRyZA/xiCM2WcTecmDPBPw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbrzU1TN9pKGEvh3NVLdTh495QcSSdql8DTCAd96s5Z8LbaQHuMJGSHLRnvcZvkZt
	 x1phO/oAXtgIF3G50LjlfeoMqwg2iOtiBLsKmR2m2zj3RcAFmmuW4Vf9relr548h/Z
	 oC8LNLNsWapakfMzkw/aERrC7ZSXUplYYKEXfa0NzG90R1QP4itypVstc6AqkIrTCG
	 XwLW450UPf8DiuwYZD2x7mDsMKHxqrD0RuVrWdy6CJ1VRFG1DEo+yZHVy8aFqLoXuw
	 rvSQLT7TLcxRQEcixi8VvGcT+u2F5P600orPZK5zCtCEc4cOJzfHPdSGtEWfu/BWY6
	 l9m46lHpMsWew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A48380A95E;
	Tue, 10 Dec 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] octeon_ep: add ndo ops for VFs in PF driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173379783002.318197.15810846013570479306.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 02:30:30 +0000
References: <20241206064135.2331790-1-srasheed@marvell.com>
In-Reply-To: <20241206064135.2331790-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 sedara@marvell.com, vimleshk@marvell.com, thaller@redhat.com,
 wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com, horms@kernel.org,
 einstein.xue@synaxg.com, vburru@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Dec 2024 22:41:34 -0800 you wrote:
> These APIs are needed to support applications that use netlink to get VF
> information from a PF driver.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>   - Removed unused vf_info 'trusted' field
>   - Removed setting of max_tx_rate
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeon_ep: add ndo ops for VFs in PF driver
    https://git.kernel.org/netdev/net-next/c/8a241ef9b9b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



