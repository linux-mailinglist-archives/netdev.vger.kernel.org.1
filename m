Return-Path: <netdev+bounces-60327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FA81EA08
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CB92831E1
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D165A47;
	Tue, 26 Dec 2023 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYveqINY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431814C6F
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3F36C433C9;
	Tue, 26 Dec 2023 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703623223;
	bh=5Bn1EFr1JpgDavuxfajSJrpSn3bbzKKoMhEMsw4X2bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MYveqINYYVHmdOumPGyAnrZB7XpVHxx5OC40/Rw0pjf1DeWdprp9xYHY0prxG+SLQ
	 ad+7vG9GTk6U8wQsXsQskUIOmJtXmEpXw0eejcJJgBbdqyjQAuBiwiuAxlpaFo/0HN
	 VGt3AQRUS2VjbYFjl2qvHLUHQqOirFXgILRjlw/8c67DCpHb06PlO6jo/GdNQy7pAN
	 VXRLSahHrTIa0gKxnXLu/Mw9FABlEC7/v6Bqr7KZrYc9rkZhFkG+nLBx6XBbuYwvMz
	 SvaKY3xM2hx9mfloiD5H/Jxur0SuE63RtdFo+9abJAkaMHS1XoS2G/vhpnjaIrPq/D
	 DHWxm1h/xjncg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C3E6E333D7;
	Tue, 26 Dec 2023 20:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: remove SOCK_DEBUG leftovers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170362322356.20350.10362308010333625690.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 20:40:23 +0000
References: <20231219143820.9379-1-dkirjanov@suse.de>
In-Reply-To: <20231219143820.9379-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, dkirjanov@suse.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 17:38:19 +0300 you wrote:
> SOCK_DEBUG comes from the old days. Let's
> move logging to standard net core ratelimited logging functions
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> changes in v2:
>  - remove SOCK_DEBUG macro altogether
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: remove SOCK_DEBUG leftovers
    https://git.kernel.org/netdev/net-next/c/8e5443d2b866
  - [net-next,v2,2/2] net: remove SOCK_DEBUG macro
    https://git.kernel.org/netdev/net-next/c/b1dffcf0da22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



