Return-Path: <netdev+bounces-66837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94F8411FD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04DE1C21521
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB611734;
	Mon, 29 Jan 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+RbAjnv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0A63CF
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553027; cv=none; b=FNKRxugrM9f8vSkRFSGwFrRwXa/3Q9sONI1e3+7S7W5nNXIB6/uSUP7R+mN2UGOOBCEBftLW+ZWL/cu3yn3RjHIJTh0P8NTLP+BGRKejGTNlQn9SPyOaQ+ytyC7EAKpHD7mb7uRLGgWHw+vVS0LkORJ4PHiD+MiNsKvk/oBH3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553027; c=relaxed/simple;
	bh=8IkIeWzk78LGqn0Gh0C7ZJSfCz/acUmDLuciS8r4WvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZ3JiEKBMLPcwSF1c46R1CYjd/qxcuyyawYiaVGPD6s7USpLPAM9knPSUMpFDkhi1LT6iVAfAucZUf1x8IvviYIpqTVxvx7Ou+HHhYxvVtjBuawcMwJnQaXrfs2jwo+IsKLrDSForSktxUA3HnG9KsQ31ClF3ZHtEN5atQ0OxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+RbAjnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA56EC433C7;
	Mon, 29 Jan 2024 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553026;
	bh=8IkIeWzk78LGqn0Gh0C7ZJSfCz/acUmDLuciS8r4WvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+RbAjnv8Yll1fHJ/POM5+jlFiNB7m9uFR80CGkvbVZD6cRpaIH3ujQYZe8fUb1Gy
	 9eR3lbR+fgH36q59RAeTnirLQMiY3lIMgLEFkB9m3pXhoq0k90rVMb3jiXjVHjJAvH
	 w2+nWK8MunqQoekJ3Vldy9J4R6mdAZ1RNOmzn0P2yt5Hyd4N+6L95A5+0DUYTD/9Qy
	 RWit4x/72yfSfY/qtpaJtt3l3+Ddlcm9NUsKCAb0h4EWwH1JB2tcExXqRrnAS+Cfyz
	 Q9evyOz/ysMKoYB17z8HJK9LN955m2EyaWKjiYl01QdCHOYrdI7osF5vKNvYz/nt0K
	 C5usQ/gmkPxlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FB90C3274C;
	Mon, 29 Jan 2024 18:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] bpf: fix warning from basename()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170655302658.19054.2092788760353633535.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 18:30:26 +0000
References: <20240127220032.5347-1-stephen@networkplumber.org>
In-Reply-To: <20240127220032.5347-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 27 Jan 2024 14:00:32 -0800 you wrote:
> The function basename() expects a mutable character string,
> which now causes a warning:
> 
> bpf_legacy.c: In function ‘bpf_load_common’:
> bpf_legacy.c:975:38: warning: passing argument 1 of ‘__xpg_basename’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   975 |                          basename(cfg->object), cfg->mode == EBPF_PINNED ?
>       |                                   ~~~^~~~~~~~
> In file included from bpf_legacy.c:21:
> /usr/include/libgen.h:34:36: note: expected ‘char *’ but argument is of type ‘const char *’
>    34 | extern char *__xpg_basename (char *__path) __THROW;
> 
> [...]

Here is the summary with links:
  - [iproute2] bpf: fix warning from basename()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=69e3b2fadcd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



