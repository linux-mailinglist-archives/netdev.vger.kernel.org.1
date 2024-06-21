Return-Path: <netdev+bounces-105615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C65912053
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F742866C6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC016E868;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPgnqq6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE616C698;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961631; cv=none; b=LCKj8v2vq/RDQ38Gnxil5DlAOHhfPXCJtBoL0BqkuF5dlDOkqqv2+aNfuIqzsdWyjsalqo3ov/BtH93NNM7gwI76kIIr2rKya9ZxgTM/e1G/Pe9H3oz0buJH86DfUj2vkFPr8S1M6WyfLtfwUhnPjbjEASnZVIJ8DKoD6+dc9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961631; c=relaxed/simple;
	bh=vBQWRT2wP4bg9M6s6w4e8SNp2T0cQMPyhytWfXzHk/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LrItC59RkTW98GCCX551SpMKEma3xLbiWcgIcqwNIUMLLXxFyc5yuhZQSF1Qn76JfzM4pfPR7Cjy6CuB1CcDYXPax7bOEc1CCOvPqVvYDVr3ShffsN62+E9KYw0tkg0ZS2P7XaOHIBwrJcyPQdyk6OC86ZLorf/jRKCMJOFnvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPgnqq6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 842BCC4AF0D;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961631;
	bh=vBQWRT2wP4bg9M6s6w4e8SNp2T0cQMPyhytWfXzHk/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPgnqq6cuj4rY4NguE/TA/z6QEwSpkq3eGqspgFzqF6FAzglrXytAKnb6vU2hD1kH
	 Vz59G23gQcwkLw/dyCaj6BQWXmyE8DpyJ/kXNH5lSZhiy4gCtDRmsaIge+D7oL11Dz
	 iagNFCS5SE0dcXF+QN52aF17rP/BhMTzp4PYAKsKzmBLi1s8DUVpiC2eU31tlD8VW+
	 bXyiti1JNwS8cU91qSysIBZCbSioCTnaI4pibqdI7Cb2SuOh87wcn+okane0fdpaUQ
	 sw2Ifad1zkBW0BldRDYDGHntmrt7fdr+swHf54svDKZefJdjgxjf3ZAzWFGLsRR5LU
	 2EIlvvra4yNRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FA0FCF3B99;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] docs: net: document guidance of implementing the
 SR-IOV NDOs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896163145.20195.12684798696627871748.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:20:31 +0000
References: <20240620002741.1029936-1-kuba@kernel.org>
In-Reply-To: <20240620002741.1029936-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, rdunlap@infradead.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jun 2024 17:27:41 -0700 you wrote:
> New drivers were prevented from adding ndo_set_vf_* callbacks
> over the last few years. This was expected to result in broader
> switchdev adoption, but seems to have had little effect.
> 
> Based on recent netdev meeting there is broad support for allowing
> adding those ops.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: net: document guidance of implementing the SR-IOV NDOs
    https://git.kernel.org/netdev/net-next/c/4558645d139c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



