Return-Path: <netdev+bounces-63194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC382B9A6
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2ABB225D0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00E139A;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/3KIfp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7093805;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 401C4C43394;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705027227;
	bh=S8orNQ0y9sofYNNwZuu4YYDCMO/aUbAa6rRqNguxkMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/3KIfp46udw+3KO/OnEfTO0J2p4AmDQPZk3k9nKm2nUOcVv/3ZgklxmW8eDtnnB3
	 kJ3TPDvMAj5ljKSImLa3q9CujLCmWHIzjTbaD7VXcd/jJP5k1AReNe20DTK7CrRBDA
	 2DmjYCiI00jv7XR2EcZLH1tT8gPEp/WLo4qlKuIav1Azfipy9rgPMjIgko+HrKURRR
	 kvYzPD87rL3WYosBfNjR3YX2ljhwuxFAGVGlzaHx8GvF60Cdh9zypZKGB/oAp1z5d/
	 2iDBtACmZEuV8/6+VbysMBsBm4XtcX7ld5pWAiqs/GQUmj/5kQ89G1Ei3ZXvhuHZxA
	 axx1yTh4+FEmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2779DD8C974;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] net: filter: fix spelling mistakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502722715.15005.9426847097531619379.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:40:27 +0000
References: <20240106065545.16855-1-rdunlap@infradead.org>
In-Reply-To: <20240106065545.16855-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, patches@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jan 2024 22:55:45 -0800 you wrote:
> Fix spelling errors as reported by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] net: filter: fix spelling mistakes
    https://git.kernel.org/bpf/bpf-next/c/8f8382623c75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



