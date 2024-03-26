Return-Path: <netdev+bounces-82271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6B88D04E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0631C34294
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061D13D891;
	Tue, 26 Mar 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1CLn6Ca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716E3C26;
	Tue, 26 Mar 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489831; cv=none; b=ZxvKEZNrm4ddCHgTrArpX0eOmc9mZsUb4IvxUh2FLNj1mzUY9oXfbGsTdPj95gfuyOwh5o5KnWrqHRq3l53K0zZ+9TVKTfhn25mNwtX7R4OcyOceMWjFIi9S4B7VGWxMlD/8Gh2oqkl98+CkhYQN+WqRd/9unVJsAcTZFB4/Crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489831; c=relaxed/simple;
	bh=33uz+WHmIlakl60RCwqm1pC6zC15jtM9DE1ZhrH00OE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jt/oSBFNMkysfKdHgLzFtavgupFvavy6aSBoefdbDlC6MlFW8xU4f3o/J7dYtQaOdymBEQuOHL1+uv6m9CjL914Pe+SiKg87Il9y1V5mHRuvoyTXgqY2ZsMImXxgcKK34Qo5q5L9pza6D/zsJiDwEjje937Un43Xpp8/vV05ZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1CLn6Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE4DC433F1;
	Tue, 26 Mar 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711489830;
	bh=33uz+WHmIlakl60RCwqm1pC6zC15jtM9DE1ZhrH00OE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1CLn6Cahb8+HyWKcLUEtDXg8lokZ9PsBlIYrLF5ROHXGqvej1P4U0Iz6XPgFGu0J
	 ALgtqzjTlWB0q/EueuplFPlrdLxQaJGaQDaK+8U0xHRv0NMig9/lXxN4OkOjZPWusp
	 48jWTiBcLY6fQztCNzNgdq/XNcCjrZ+Gkw9jZB+GNAB9AhTfM4aIvxJuYMvtQ6CLDL
	 A3OSAIMOZU8OBSDulu44fTRSVHrorJKNbdEZYXfxiSgYV7BVCNpCXN4fShHyVejWml
	 W6choOtpnPjMEFM6Zsd5eccGuaXlgZnZeoP7op3C6ZD0hGs25sHyiROuEMgERLS0Cu
	 EIGlJn1ZlSH4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58D8AD2D0EC;
	Tue, 26 Mar 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] BPF: support mark in bpf_fib_lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171148983036.4165.279265169670914517.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 21:50:30 +0000
References: <20240326101742.17421-1-aspsk@isovalent.com>
In-Reply-To: <20240326101742.17421-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
 martin.lau@linux.dev, sdf@google.com, bpf@vger.kernel.org,
 rumen.telbizov@menlosecurity.com, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 26 Mar 2024 10:17:39 +0000 you wrote:
> This patch series adds policy routing support in bpf_fib_lookup.
> This is a useful functionality which was missing for a long time,
> as without it some networking setups can't be implemented in BPF.
> One example can be found here [1].
> 
> A while ago there was an attempt to add this functionality [2] by
> Rumen Telbizov and David Ahern. I've completely refactored the code,
> except that the changes to the struct bpf_fib_lookup were copy-pasted
> from the original patch.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: add support for passing mark with bpf_fib_lookup
    https://git.kernel.org/bpf/bpf-next/c/30ed73eb7d63
  - [v2,bpf-next,2/3] selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
    https://git.kernel.org/bpf/bpf-next/c/656a5bb56ea6
  - [v2,bpf-next,3/3] bpf: add a check for struct bpf_fib_lookup size
    https://git.kernel.org/bpf/bpf-next/c/98103fa6cc3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



