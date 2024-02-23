Return-Path: <netdev+bounces-74374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE938610EA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9721C20EA8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C0D7BB13;
	Fri, 23 Feb 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3WM6lkP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E007C090
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689628; cv=none; b=amK24pU0Uq5EBGqhdJz58OQJJv2K2IzEIrFvtG36rUB2YCmHD6ndOPoD+KNfJHnS3Nmd8E0ogPue2+Hd1ekQvt6ztl5pGyIlSGBo638x1yDNGuHrTpFDgcf+U6aORBUVL6+9AhQ8wLTFYJsRf4iqBByISVqBz2rIgu2ttAEsEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689628; c=relaxed/simple;
	bh=bbtTovXG4oQ9PBcFkLUC35X99SvwO6d0mNCrA4wdlLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dvTixIyB1j+bfrop24uK13f5I3Pk8PG7H25K+ILBugRtQ9nwpchBKRbgqagX+fdZcTDVyHTs/uEYUBh+117YAAqeSmZVL0XZqI4htFIfjtbuoMSKeaiMcNEOx0ob5S5hcx3HpizgkEFpaFXyED2ahKsaPoHxg3E1ybA3zknIu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3WM6lkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03F0CC43390;
	Fri, 23 Feb 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689628;
	bh=bbtTovXG4oQ9PBcFkLUC35X99SvwO6d0mNCrA4wdlLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j3WM6lkPknd1f1B37jO/aVzK90ilksTY9tQzQfGJV2LU+JO1xr0JS4Ecz2LrYLooL
	 aJlXMzWDXd+GYFai6AkKXWo+ORs6RCZPHL80q04jIHhsiZYJNHfO2LBVS6J7nstHeH
	 FLvmUVk1fHlD63Q+lToVWlFQ6bw1tOx5PMQycqMYHRBL7Zdg4d8IEYHdhVbTWKqSY7
	 UOpAIoMEwBLy6GxgHsK2auMtNOqWHOIm5K4kQ/lAHB8yxfasrGrIJnG1Z/HuWHHzzy
	 QiVm7+mB4lntfkVn1XpG8vEiUxnMpLRfmoHyePRW0anz0RfPdQPY0xjVyvvVk8w6oG
	 4gWf98Z6zNH2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF5AD84BBB;
	Fri, 23 Feb 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net] ps3/gelic: Fix SKB allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170868962791.18733.3008951946846672824.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 12:00:27 +0000
References: <52f5f716-adec-48bf-aa68-76078190c56f@infradead.org>
In-Reply-To: <52f5f716-adec-48bf-aa68-76078190c56f@infradead.org>
To: Geoff Levand <geoff@infradead.org>
Cc: sombat3960@gmail.com, christophe.leroy@csgroup.eu, pabeni@redhat.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 21 Feb 2024 11:27:29 +0900 you wrote:
> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
> 6.8-rc1 had a copy-and-paste error where the pointer that holds the
> allocated SKB (struct gelic_descr.skb)  was set to NULL after the SKB was
> allocated. This resulted in a kernel panic when the SKB pointer was
> accessed.
> 
> This fix moves the initialization of the gelic_descr to before the SKB
> is allocated.
> 
> [...]

Here is the summary with links:
  - [v6,net] ps3/gelic: Fix SKB allocation
    https://git.kernel.org/netdev/net/c/b0b1210bc150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



