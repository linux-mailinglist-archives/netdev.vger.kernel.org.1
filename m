Return-Path: <netdev+bounces-53963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDBD805715
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A23B20F28
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912C65EA9;
	Tue,  5 Dec 2023 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJVcJ0+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286795FF19;
	Tue,  5 Dec 2023 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90A0FC433C9;
	Tue,  5 Dec 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701786023;
	bh=j6sTm6b/Klclmr/o77Mk8GQ3vewqy41L7xq9hXsGFxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJVcJ0+IWFOWe1pz/PVHCsdv++Kr50PwY8bluCaOeYykcQ048c7UYyAFgPD2ky1Ue
	 ws9GQ9rOlmUUvWDLW1+GF51s0H4xcX+v+9eqbxhLXzb/AOKCm3hfImooOTlK/oSwdq
	 s+u5dKrnPyvRWD3FldwHSkV+Jl0Pz6tQmGZbVqzG4e0SGwq0jZB3/9NMJdIm46S/jf
	 4D69x8/Zz7+vlDv8JRp2QOaLMGM6+4noe/57hRbDfE9dHghEhUfU+VrEDYomQAwvZk
	 ocS/NIVDIPE5nq802RrTzYkGvi+alfMK9Nk5QQ3lUVrrG5XIhZJyPB61G+23cRunMQ
	 4XQNqFxiqWGUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7991CC40C5E;
	Tue,  5 Dec 2023 14:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure we trigger metadata kfuncs
 for dst 8080
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178602349.20405.10934749603735242016.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:20:23 +0000
References: <20231204174423.3460052-1-sdf@google.com>
In-Reply-To: <20231204174423.3460052-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  4 Dec 2023 09:44:23 -0800 you wrote:
> xdp_metadata test if flaky sometimes:
> verify_xsk_metadata:FAIL:rx_hash_type unexpected rx_hash_type: actual 8 != expected 0
> 
> Where 8 means XDP_RSS_TYPE_L4_ANY and is exported from veth driver
> only when 'skb->l4_hash' condition is met. This makes me think
> that the program is triggering again for some other packet.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Make sure we trigger metadata kfuncs for dst 8080
    https://git.kernel.org/bpf/bpf-next/c/5ffb260f754b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



