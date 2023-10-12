Return-Path: <netdev+bounces-40198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C87C61B1
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6456728247C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6CB63D;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/2hc4kC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F863C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A017EC433C9;
	Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070624;
	bh=7KfXduPd7hp5hJ9Im+WCKUqxTvsxCJXZAHy9STti0CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/2hc4kC+AXq9BwMLQJ6l+o3quSFdJ/VSELWGEIUZi1QtHh+5mNDBdBoKJMovVDR2
	 JbTEptNA1W/HVQls34WPdxkvEZKN9tHGcBWESK/td4VstIXoh6XGIiLRbgfRl2q+n4
	 7H4hUt638Th6bPB0C8wrED9CHAU6NbqUwpHm2eVeQA71YHDE/ADGYEpYaWJ1DdnZEZ
	 COGSjC5XgYXQ8vWbxpNQC/z44ToSKIjOrj3cPlTZVDxk+cy2a8n32N591bE/dJAzJL
	 aNHQjY0aL51U8h09GZbbBKbV/itSGo6mjnWrkSY+NavZQrTBIahjKWeahSQClfXdts
	 uNEn8bRwQGSgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84D62C595C5;
	Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2023-10-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062453.15864.2496383735128357487.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:24 +0000
References: <20231010200943.82225-1-stefan@datenfreihafen.org>
In-Reply-To: <20231010200943.82225-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 22:09:43 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Just one small fix this time around.
> 
> Dinghao Liu fixed a potential use-after-free in the ca8210 driver probe
> function.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2023-10-10
    https://git.kernel.org/netdev/net/c/8bcfc9ded21c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



