Return-Path: <netdev+bounces-30540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07A787C97
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DEF28170A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4676C361;
	Fri, 25 Aug 2023 00:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55263179
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE8AAC433C9;
	Fri, 25 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692924023;
	bh=AlchTnBHk38EDaleTTR+EWrFZBPTxfju11Gub8nZ/Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1x+LfGPJriUM1J5amgw1W96qVCMqkRJuD8RJNMVYBqr6dDTbtq5NY/gnLkIvRStO
	 E9vMQgN/saFeUpRdiIb2ShkHs+D2ast50msh4AuKDrdwv+RLUUupE8RHbCdravshSh
	 ibdXMTHooDpQo1VfkWfcB8EJ94EgqHQZkr/yUwaZ8j8aA5eEu6cXO9MWSmWYFxGR64
	 Gugl+6LY3FdzjnqMoL555EbEDCzlkAewjBfPOBnc48koaUJJhIKh1h8jtQ5RC13TEz
	 iAA6tJ1gR+YxMrbZkaCd7fas0MVi1tQM9Z3TR8Kf12uhnzS1RpQ692m5sT/AT05hm1
	 icnn/C3Az2g4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3C73E33094;
	Fri, 25 Aug 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/4] make ip vrf exec SELinux-aware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169292402366.28235.12908198050916037207.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 00:40:23 +0000
References: <cover.1692804730.git.aclaudi@redhat.com>
In-Reply-To: <cover.1692804730.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 23 Aug 2023 19:29:58 +0200 you wrote:
> In order to execute a service with VRF, a user should start it using
> "ip vrf exec". For example, using systemd, the user can encapsulate the
> ExecStart command in ip vrf exec as shown below:
> 
> ExecStart=/usr/sbin/ip vrf exec vrf1 /usr/sbin/httpd $OPTIONS -DFOREGROUND
> 
> Assuming SELinux is in permissive mode, starting the service with the
> current ip vrf implementation results in:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/4] ss: make is_selinux_enabled stub work like in SELinux
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c8970828b650
  - [iproute2-next,2/4] ss: make SELinux stub functions conformant to API definitions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=61c6882ce21c
  - [iproute2-next,3/4] lib: add SELinux include and stub functions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e246ebc3b7f1
  - [iproute2-next,4/4] ip vrf: make ipvrf_exec SELinux-aware
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0d0eeaa6cb92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



