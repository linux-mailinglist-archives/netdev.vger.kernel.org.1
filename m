Return-Path: <netdev+bounces-207334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0244B06A9D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D633BB734
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA53188713;
	Wed, 16 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe9VgM+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDF17A31B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626399; cv=none; b=XIVTYuioEp26juc29XPUg0Ksm5phHL5cpcrWlK4ADRCgLwVzQjDwooA8pFJr273bjpE31vYMfzegderksFQjaBzk6W5IJFH5dBwfiduCxpMRU7tPQeSOyzMOY7xjNTwY78VO8SnTNU1xMsuDU48DPwFXdF7o+2SHnTcXLJoG7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626399; c=relaxed/simple;
	bh=62Q3BkAJJMA8FWtNCE15BEBihYGmwhEK+wBSSqraT6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etsB0wgZDq0XTcXeJsswVTN0Gw3OzkmgNXpWi0Oe4gDv5gc6L8XQBTkU9Wg0/LTiJc+At/r/f7RTsis6xMPKU44WLhJJEpCVJLm5sCMP/Knrdu3n6exWnaiZmGOqD1i1GCFH0j+fxqW5xQqUXYT/WmtOOD8e+4J9tPARMim3vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe9VgM+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD54C4CEFA;
	Wed, 16 Jul 2025 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626397;
	bh=62Q3BkAJJMA8FWtNCE15BEBihYGmwhEK+wBSSqraT6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qe9VgM+/xClKWsevbhDZ/PT+xXe6p150tzqrKnVwibPCBemQKBbU0SUXjFxmU/QJa
	 lPJ4X1aN4sZhrhX47GqU31MHfmpAozEZAJ4yO+nD/BmXwFC4wUuRUSFof+emnn4NDl
	 JWTYNP6eIUyM9m36MojRVoHv8Z5Gqh4obZy2fyxSpB6c6d3m0nSohpgfvmdItEmDt2
	 9Zrensqik/Umwub33kbaXpFWh+qDCgjDxt9F+DDgOdDQmoLw4wi97aSFAF3n4GqjRM
	 HM1LMvnMpXQhdV9Q+Es5uF8jml6LVBiaYeE992PCYPNdxt1rd6VgPL6uLV3c8cn195
	 +zPAypADBITTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4A383BA30;
	Wed, 16 Jul 2025 00:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] Fix Rx fatal errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262641799.629458.8420167571030226801.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 00:40:17 +0000
References: <20250714024755.17512-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250714024755.17512-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.kubiak@intel.com, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 10:47:52 +0800 you wrote:
> There are some fatal errors on the Rx NAPI path, which can cause the
> kernel to crash. Fix known issues and potential risks.
> 
> The part of the patches has been mentioned before[1].
> 
> [1]: https://lore.kernel.org/all/C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: libwx: remove duplicate page_pool_put_full_page()
    https://git.kernel.org/netdev/net/c/1b7e585c04cd
  - [net,v2,2/3] net: libwx: fix the using of Rx buffer DMA
    https://git.kernel.org/netdev/net/c/5fd77cc6bd9b
  - [net,v2,3/3] net: libwx: properly reset Rx ring descriptor
    https://git.kernel.org/netdev/net/c/d992ed7e1b68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



