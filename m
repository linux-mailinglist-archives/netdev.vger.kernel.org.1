Return-Path: <netdev+bounces-44801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0F7D9E66
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A4B1C20FC0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102939848;
	Fri, 27 Oct 2023 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iac10Equ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D588833
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1815C433C9;
	Fri, 27 Oct 2023 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698426024;
	bh=nFnlUgOvDJ6s2zdi2xwHYCo37owk5Wb2BwqFspXJtdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iac10Equ9bGpZs8vjB7cyf1CFPKQuTq4Q62BryzXEUo1+EnB52wisiylj4Zf2nsdT
	 9Gb2jA+MPgqp2JB9Z1XB1thEg8A6xv+Yapox4soaNBiE9RfXdBRGnKrLcKC1iovKQj
	 eYqFsdBIaYOrE6llWaEs+IIbIVsO3P8dDQ/MOWdvdScOHslXgLqOcuqet51/TkMTO2
	 9KuXs/p13vo8stGVLTqcgpMNDMLu5Kg+jJk3XKBAr6yGVqEf8TeTJOD4iZmaE1VTbJ
	 eZ0isGZNT706jVDQEYru0uU0yKNIGumtZ355YBMA70vqE1Bt5sRZwJM2+KoO68tkBh
	 PfaGXHOrmwn7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE761C41620;
	Fri, 27 Oct 2023 17:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] Increase BPF verifier verbosity when in
 verbose mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169842602383.24325.5910223144305620538.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 17:00:23 +0000
References: <20231027085706.25718-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231027085706.25718-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 toke@redhat.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 27 Oct 2023 16:57:04 +0800 you wrote:
> When debugging BPF verifier issue, it is useful get as much information
> out of the verifier as possible to help diagnostic, but right now that
> is not possible because load_bpf_object() does not set the
> kernel_log_level in struct bpf_object_open_opts, which is addressed in
> patch 1.
> 
> Patch 2 further allows increasing the log level in verbose mode, so even
> more information can be retrieved out of the verifier, and most
> importantly, show verifier log even on successful BPF program load.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] libbpf: set kernel_log_level when available
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=73284227f7a0
  - [iproute2-next,v2,2/2] bpf: increase verifier verbosity when in verbose mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=892a33ac1bd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



