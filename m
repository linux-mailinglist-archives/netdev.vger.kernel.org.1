Return-Path: <netdev+bounces-21514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1E763C45
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A210281F5A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256E379A5;
	Wed, 26 Jul 2023 16:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0037991
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCF7AC433CA;
	Wed, 26 Jul 2023 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690388421;
	bh=f8GfAKNcdP2tfJYZJtYrSIe0quoagXslNNwcsVpDmSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sXA/FQ4uSIwOENRhvci7BAR1k98ZsQa8BmS8hcofdhOpfDHydfmr8XTEHV1TVR07p
	 ZhP9Dq8qEiCiNVeqdM7+oPRiw9Ixhr2nTjxxhWinMSweoFV5D7t8MwggbVGXwbNJ7X
	 QAKApxELt0Ve7NeV6F8tLq2s+grmiMzhPonnt2icWNJr7RTTcDkvmrcwsIdwKfMPCW
	 22FW5rz9auqcpTzCEoq4ukNaHoWQywrT26WhkjrAfRT6zkZ/JHZ1KomCkJWwkPm4uM
	 MT1EGY14XzG5LijShqQf5gvxVUsnGXLGeFLM2zRdgdb4yUJIGnspP2g/ffJKnLsJeR
	 UvF1qSL5CFEgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0244C691D7;
	Wed, 26 Jul 2023 16:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2,v2] bridge: link: allow filtering on bridge name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169038842178.17276.11071716717126322071.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 16:20:21 +0000
References: <20230726072507.4104996-1-nico.escande@gmail.com>
In-Reply-To: <20230726072507.4104996-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 26 Jul 2023 09:25:07 +0200 you wrote:
> When using 'brige link show' we can either dump all links enslaved to any bridge
> (called without arg ) or display a single link (called with dev arg).
> However there is no way to dummp all links of a single bridge.
> 
> To do so, this adds new optional 'master XXX' arg to 'bridge link show' command.
> usage: bridge link show master br0
> 
> [...]

Here is the summary with links:
  - [iproute2,v2] bridge: link: allow filtering on bridge name
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=13a5d8fcb41b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



