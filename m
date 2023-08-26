Return-Path: <netdev+bounces-30845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C99789339
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8501C210B8
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044F38C;
	Sat, 26 Aug 2023 02:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D8803
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15082C43397;
	Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015228;
	bh=+83NrJaP8VRCNSu0nlD92VZ/zuvvzhx+HG4/7WC5NZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FRhVCZYY/K7t+ZNehGaidu7LzsLDYQI3ItczAI6JrGcoCiuGNrpGh4v1Th/7hgJdr
	 g9Uj+RNku66s76YjBLOVqRZcunv5JIh3NlDTAaEgLpp5AAk+/7yNGVFGBtqXrz5JCU
	 hJGvLE1zfor46dLLtvxUnsjo2bydAu5Zxv2ITo8RgoGGC7Yh5P2WOiVC7Z8IJz2Kx2
	 8L2tBSOeAYZmvHmYW4Kl05+8nnPeMV6GlzZ7Lo14n/S6ML5YCbFVY3XaZhF6Wm8wbL
	 1yuY5709FpmoT+BIpEtEqQNwpzvLbQzhBGETj4jNuAZAx0Xs2Uxi6A9S9ZPcg7FIRO
	 KiuVD+8q0fGXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9931E33086;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] doc/netlink: Add delete operation to ovs_vport
 spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301522795.10076.13626752389204603205.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:00:27 +0000
References: <20230824142221.71339-1-donald.hunter@gmail.com>
In-Reply-To: <20230824142221.71339-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 15:22:21 +0100 you wrote:
> Add del operation to the spec to help with testing.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/specs/ovs_vport.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1] doc/netlink: Add delete operation to ovs_vport spec
    https://git.kernel.org/netdev/net-next/c/52d08fda3516

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



