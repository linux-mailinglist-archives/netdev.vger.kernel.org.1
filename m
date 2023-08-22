Return-Path: <netdev+bounces-29492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC877837C5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E3A1C209CD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934C1108;
	Tue, 22 Aug 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B210E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC40C433C9;
	Tue, 22 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692670222;
	bh=27qc0ICxgRu8hDS3twn1iy0JSpMlFKPXq44t5WlxKn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cKnT/wLmjIeYeLf6NlUnXlr84GT0qer6XD+kFHfnJyU9z8rF8ntVi+xab7QKdyhiA
	 i0aHX3mFrO/Fy9f5ThQTs7CK/x8ugwlGI4e5sRsfugHJ3+1qoWOgpqgMlsdEt7zSxs
	 saqE9RrHCvw+zqpe2KKOgMKlzeN4kWOFr+r65cUc54zMtR0y1fD9PNAy3NyPnV+J+t
	 HTww4zGGoPIk9tTvc0tiJgnirUY+/gXHUptGlkJyA7HdKPWh/5n9yM2Tawj/zGx9pu
	 6ELWRZRpzJD6sFVqb5zNdS4PLh00hR2U37SOe4ZZPALhBoMqlLjDK5VpzDT2X9ikqO
	 owxKjlqDs9yEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D56E4EAF9;
	Tue, 22 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: do not set port down before adding to
 bond
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169267022185.23069.3596480048996475238.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 02:10:21 +0000
References: <20230817082459.1685972-1-liuhangbin@gmail.com>
In-Reply-To: <20230817082459.1685972-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 jiri@nvidia.com, razor@blackwall.org, phil@nwl.cc, shaozhengchao@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 16:24:59 +0800 you wrote:
> Before adding a port to bond, it need to be set down first. In the
> lacpdu test the author set the port down specifically. But commit
> a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> changed the operation order, the kernel will set the port down _after_
> adding to bond. So all the ports will be down at last and the test failed.
> 
> In fact, the veth interfaces are already inactive when added. This
> means there's no need to set them down again before adding to the bond.
> Let's just remove the link down operation.
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: do not set port down before adding to bond
    https://git.kernel.org/netdev/net/c/be809424659c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



