Return-Path: <netdev+bounces-37623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E47B65E1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 099F128161E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90EF11CB0;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA6EEDF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 299D3C433C9;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696326624;
	bh=y7mQxJnkRB98psYX745aFCncUuqe078K1Ap5IaeIaaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qULOOE7mwt9ghVrmiiYqZGaZvfZE/LpSgDfVCjWQnudkxqERiNrydhJmJpWDuU8UL
	 hfwLgNF5hK56g54worL8RvXWEOOolcWEWZQjb8KgtqSuHmSJkY2q718pPcUKOeKjE3
	 jEhTKG7khr6/Fx26axEPzlTIVbGYqTyvKWx7cSkkGdN9xUmyEmtHmCk+ATtMEqUFes
	 zwQIBtvJSdt7SuDyHUAbqpImQbOxOa9MYc6U9EPeNHRiReCnrPSPxxwyvRl6H8miza
	 LU+Dl+NS3qKTJzvXRnO+FQPYCS10/TnJsSM9QcSf8yEaVOVrglEPqS/0o00IY/kGxn
	 zK1dO0OiEyZhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B8ACE632D1;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632662404.31348.9179995662374808172.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 09:50:24 +0000
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 10:03:07 +0200 you wrote:
> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
> is no real point to allocate the 'entries' pointers array with a dedicate
> memory allocation.
> 
> Using a flexible array for struct udp_tunnel_nic->entries avoids the
> overhead of an additional memory allocation.
> 
> [...]

Here is the summary with links:
  - [net-next] udp_tunnel: Use flex array to simplify code
    https://git.kernel.org/netdev/net-next/c/ef35bed6fad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



