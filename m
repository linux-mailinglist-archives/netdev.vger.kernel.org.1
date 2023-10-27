Return-Path: <netdev+bounces-44902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA17DA3BE
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A6B28257D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD138BAC;
	Fri, 27 Oct 2023 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7aOa3RD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E115AC8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FD4CC433CA;
	Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447025;
	bh=SaEHQTvwrm30QTaovhZx0pkN+QEGtMnHTZgEkKClPu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7aOa3RDfx+lEQGl8nmGXJhS6HRmKGfNPDZRkNkd2lxxztG9xvsIC5w2rHtU422Lp
	 qRVy3P2R4TyInEHK3zuNfbAaMTy4pC1Ud/g2stWixd6F7nIumxFE+hY/BprkQVGnNr
	 sNt0FMK8i/vxUwtpLWQSDDtYDJSz0NepFuN2Cnt4s4sMcRLY5ch0iVqNmnEftIvzC1
	 HOLFmtjtd3jrNrszrg/VJ3nAHPndli9uE669p0Jrb7LT9DEZIh0EoB4d+DVzi8C6qO
	 pBcUw1UWnSf74ppYHu1xcAvGHgYZeAsohg5J6P7+n6j8uBSdJGPcQqonImm8lUrO8S
	 6dEVZZdQKMh9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C89C04E32;
	Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vxlan: Cleanup IFLA_VXLAN_PORT_RANGE entry in
 vxlan_get_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844702527.17753.11595842744731325153.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:50:25 +0000
References: <20231027184410.236671-1-bpoirier@nvidia.com>
In-Reply-To: <20231027184410.236671-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 gavinl@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 14:44:10 -0400 you wrote:
> This patch is basically a followup to commit 4e4b1798cc90 ("vxlan: Add
> missing entries to vxlan_get_size()"). All of the attributes in
> vxlan_get_size() appear in the same order that they are filled in
> vxlan_fill_info() except for IFLA_VXLAN_PORT_RANGE. For consistency, move
> that entry to match its order and add a comment, like for all other
> entries.
> 
> [...]

Here is the summary with links:
  - [net-next] vxlan: Cleanup IFLA_VXLAN_PORT_RANGE entry in vxlan_get_size()
    https://git.kernel.org/netdev/net-next/c/6d90b64256f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



