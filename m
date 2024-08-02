Return-Path: <netdev+bounces-115448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBF946635
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C961F223C4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1613AD16;
	Fri,  2 Aug 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ3LQXb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDA1ABEA4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642033; cv=none; b=IcgROsmQNOJmlcJKr71Kgsd7eTWuPbniVy4AnF8OUDDQjcoZw8QjhhRaUx1GPzvv3k09136urwfolA4TlcAsKL3IHpByLzlD8FERkakcscTmGcFi2UK0Ng8Gpgp7+kKb/X3GMGBpZZZz6HnLHCTcj+1GkMNOwJRbLjq0jTbNh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642033; c=relaxed/simple;
	bh=3uZ9Z3Tu9kyIpAVREuKu/Ou+YnjpX2od1qJZjJL3SQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gw/gdiRoaw8LJdCwwOI9ljiivRdU/8XqwhqfDJ6Qzy+WE/8Cl+LQbyOHQNQlGndIKMZJqnJRpHP+ay46b60ptAdBr1Cu+zhAf6pkHF3N8B4E9FpZ4Z0Md5GCk3sch/ht4VotOdHAlKRyA8px2JOi5ww7uRRpjKDkxIQGR15oymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ3LQXb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A91ECC4AF0D;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722642032;
	bh=3uZ9Z3Tu9kyIpAVREuKu/Ou+YnjpX2od1qJZjJL3SQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJ3LQXb4Uz4gxe3y0ugKdQa25wceTOywDVQyAgJM+fA6yI8/Og92ySbL6dEMXhkgM
	 XIlefjPyOqvjyJUcO9gHmK7xGieUu82tmqT+XMtoUNwWA62HNXljigdohuFSbpACxj
	 uBGOW8VhkZwvMGHmhw+s4Q0MFFA8nfLyUfOcqp0+O0lQDzwKcG8Jg9opfotw6SpO25
	 sy8kbCHMPqtbc0rjkitEot741pujmKphGnv/dE02lRP5M3NfCplfWrF398ijSmQNVK
	 5UA55cUnsf1BZjXEInQhj35KHTZyacWwv5yrcZcJ62pxKOW+kanyU8Kf42EfkGcumz
	 D62PlrRhKCn+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A056C4333D;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: fbnic: select DEVLINK and PAGE_POOL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264203262.30831.15953162052782589137.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:40:32 +0000
References: <20240802-fbnic-select-v2-1-41f82a3e0178@kernel.org>
In-Reply-To: <20240802-fbnic-select-v2-1-41f82a3e0178@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com, lkp@intel.com,
 kernel-team@meta.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Aug 2024 16:43:17 +0100 you wrote:
> Build bot reports undefined references to devlink functions.
> And local testing revealed undefined references to page_pool functions.
> 
> Based on a patch by Jakub Kicinski <kuba@kernel.org>
> 
> Fixes: 1a9d48892ea5 ("eth: fbnic: Allocate core device specific structures and devlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408011219.hiPmwwAs-lkp@intel.com/
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: fbnic: select DEVLINK and PAGE_POOL
    https://git.kernel.org/netdev/net-next/c/9a95b7a89dff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



