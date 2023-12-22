Return-Path: <netdev+bounces-59959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E871781CE49
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F1B22B39
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD928E3C;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj+WcnKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5EB28E0A
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A29C433CA;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703268628;
	bh=0qyKxU5wZdWLWVoecMS0PuCXyFKe3NYaM0SMMq67PbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kj+WcnKdguGPiZz35rpoJK/Z6OylhcQbL6HJhh/l4rTqXkynojKnBwCnipOvIuuf1
	 1ETrt3ZQCO6aL73caIKzcU1rpe8puNwfRnAQAumLBSOv3unRWHlorjV8xnXqkskXxJ
	 mqpU8IFiaISzIoJNqmldoX5RnzPqf8sNxmRKQtMMHD8gYD7c2ds9jag4f1dyVhPskq
	 q+acO0KqRAWXTUvHK/dzt1a7Q2UVsayIbyskP1FuXwcA7kjzdghapZJRO3jYQtHLut
	 hcD3BOSE7VhEwHk0zLqsXeSXhuaUMYxelv2EiNaAPEE0tN3oqhLOG5d983eH+Yu/ZO
	 sygRCOM1TM+yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39AA6DD4EEA;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] configure: drop test for ATM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170326862823.16561.442140407724789522.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 18:10:28 +0000
References: <20231222172919.12610-1-stephen@networkplumber.org>
In-Reply-To: <20231222172919.12610-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 22 Dec 2023 09:29:06 -0800 you wrote:
> The ATM qdisc was removed by:
> commit 8a20feb6388f ("tc: drop support for ATM qdisc")
> but configure check was not removed.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  configure | 23 -----------------------
>  1 file changed, 23 deletions(-)

Here is the summary with links:
  - [iproute] configure: drop test for ATM
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a66a73af6db7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



