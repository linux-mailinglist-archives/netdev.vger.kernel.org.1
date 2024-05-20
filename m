Return-Path: <netdev+bounces-97149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA48C9786
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 02:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755E52810CB
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B44367;
	Mon, 20 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSZFLAux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6231366
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716163827; cv=none; b=jueUGlTF9rn75FZPj/tsf1W7bjSlfHFnKnNANS6GbC8bOc7Z4YZ+HTMhgjxzWBjpydFWhgzermKqdLx6Vvv/3/UmBYMqls/zIglYhMpIh2806uWWZCXCKe8VaVBcd0f9F1Q58gPZHOzJtx6uzyWsU6rxJbSvTJdkZi77Qb9dihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716163827; c=relaxed/simple;
	bh=DeH+m5vuArUUdr5ZEV7gOeqoLD0C9d6BFcMA0oBOvkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lonn8rn+pfal6ppb+37+qMVY83SJvZd2ckgThtnKdgsYnTFsIJKLz2qPhLrZmaVFRSos0hmEiiyh4TT0itpOz1dU7iPdo8q9KZqmQh1+YsuaR9iaNZ5gokaVFcRxruLXicE18euhTeEFHOnMUWKDUIYBAD5cgEZj1bQzMf3HpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSZFLAux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0C7C32786;
	Mon, 20 May 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716163827;
	bh=DeH+m5vuArUUdr5ZEV7gOeqoLD0C9d6BFcMA0oBOvkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSZFLAuxezuZeQy+L0VQMwE+mcQMpSn6TnDaKZYtncW6kM8A0QEvgtqA0pPta3XGz
	 qRJ5h6q7tbmOy15ErMa1XAAnPOGnQMXW7vXvV299zJ4N7vX3UqMOCytIroYvbbibzv
	 GAU7vRv7emP8fEAtjlqKGK6asf4+VRuusfBtQrCV5BBrLQb2QpneQrAeWHBgy7AvuK
	 g1VCu3ALldJt8RTNWcfUvUE4EXIoDpRjgrxpK23JrM0k7yHgzPGP8rTXwuubfY4RrC
	 Bg9uKfcRSitVtQpJ3sFyz2FiSteyvnZPUd3UJhDXyFb/YwVNnB2ICGCqRylDfAYeay
	 PDkqRlYjRKB6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B831C54BB7;
	Mon, 20 May 2024 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v3] netlink: tsinfo: add statistics support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171616382710.15756.16321546641057774553.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 00:10:27 +0000
References: <20240508042418.42260-1-rrameshbabu@nvidia.com>
In-Reply-To: <20240508042418.42260-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, cjubran@nvidia.com, cratiu@nvidia.com,
 davem@davemloft.net, edumazet@google.com, gal@nvidia.com,
 jacob.e.keller@intel.com, kuba@kernel.org, mkubecek@suse.cz,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev, wintera@linux.ibm.com

Hello:

This patch was applied to ethtool/ethtool.git (next)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue,  7 May 2024 21:24:12 -0700 you wrote:
> If stats flag is present, report back statistics for tsinfo if the netlink
> response body contains statistics information.
> 
> Link: https://lore.kernel.org/netdev/20240403212931.128541-1-rrameshbabu@nvidia.com/
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v3] netlink: tsinfo: add statistics support
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=edf00bab748b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



