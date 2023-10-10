Return-Path: <netdev+bounces-39466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01E7BF5E4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5671C20BA9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C154C8C;
	Tue, 10 Oct 2023 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgqpM3HJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AA1FCF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81C8C433C8;
	Tue, 10 Oct 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696926627;
	bh=SXdJHIxqzi/d9veL+aYe51i7O/6le3MLAA2+KuAW7OE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DgqpM3HJyEDvk1XxJrudYCd/5BdP29J7Sc8nH25ctNo+OOvcpU/JI8fdEnzn/qBk1
	 wG5iPI8dshLW6J5IUDIWhKzvky8J7Ka7oyS4RkOuT6jl/ffmrNpB5ww1SPKVnOImXj
	 oysALlKUXW70bTkXE/Sx9wMOR2zZLU1uAAKTVvXpxcVMP8v6lziZLxoZcyu1aAIADI
	 yfkwML0YMEtB/2Csh7Ebw5j1x4ig6JLzBMynFkO1Xwt6SOlzemlSpK5uwvqScM9vcH
	 Uu1xae2SXgoKsJ7CN7kWp5DuTmaVPh3UpGx1+455cxkOuT0TMXftyvwEDBM7w77OcK
	 CfFD6WE/wWKrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1174C595C5;
	Tue, 10 Oct 2023 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] tcp: save flowlabel and use for receiver
 repathing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169692662778.15262.2648750491298448747.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 08:30:27 +0000
References: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
In-Reply-To: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
To: David Morley <morleyd.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, morleyd@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 01:18:39 +0000 you wrote:
> From: David Morley <morleyd@google.com>
> 
> This patch series stores the last received ipv6 flowlabel. This last
> received flowlabel is then used to help decide whether a packet is
> likely an RTO retransmit or the result of a TLP. This new information
> is used to better inform the flowlabel change decision for data
> receivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] tcp: record last received ipv6 flowlabel
    https://git.kernel.org/netdev/net-next/c/95b9a87c6a6b
  - [net-next,v3,2/2] tcp: change data receiver flowlabel after one dup
    https://git.kernel.org/netdev/net-next/c/939463016b7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



