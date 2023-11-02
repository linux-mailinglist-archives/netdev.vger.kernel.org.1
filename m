Return-Path: <netdev+bounces-45658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D137DEC83
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B145D281B41
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B516AB0;
	Thu,  2 Nov 2023 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea/Zol2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771735240
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8EE5C43395;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904287;
	bh=ecZB7l35L6wule2Au5YzP6nuUXpzn/mRCATx+gVEK+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ea/Zol2rYjOUbJc4jjCC/OogKjouWMgfZ0cDxHL4KEj5otp+/+qh1ujDbm3eFQcQb
	 bR5/mVRzg48119+n/3sDjHG1Q2uzR3646CIqToa9/SUNNo8UjpCY7rjBibJ6h6cwJ4
	 YlOv+CE+b10eH24MDjwg6dh46Dg2aYX4n9utsR/2gi/h8j75DVQAZDeIvVaeeVkfEs
	 b5ETgJMf+4AK6RHPfZPG72MtG3NM/j7/mJj/phQF1Lzsa0iDj3fWAQ+PhoW43fSvWf
	 sOxj1Fc3YwALAPvS2yeVOXCK3qw0bJ6MLGrqQWAUnML1v8bb9JsAsILt7uYeuMxXrp
	 5wWI1ByWu/eMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A9E9C4316B;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xscale: Drop unused PHY number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890428762.30377.1176833173380054873.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:51:27 +0000
References: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
In-Reply-To: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hharte@magicandroidapps.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Oct 2023 22:48:35 +0200 you wrote:
> For some cargoculted reason on incomplete cleanup, we have a
> PHY number which refers to nothing and gives confusing messages
> about PHY 0 on all ports.
> 
> Print the name of the actual PHY device instead.
> 
> Reported-by: Howard Harte <hharte@magicandroidapps.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: xscale: Drop unused PHY number
    https://git.kernel.org/netdev/net/c/d280783c3ad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



