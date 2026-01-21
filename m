Return-Path: <netdev+bounces-251681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMcUBuYpcGmyWwAAu9opvQ
	(envelope-from <netdev+bounces-251681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:20:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE54EFD2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA65A6A0F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893B304BDC;
	Wed, 21 Jan 2026 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJtLt4v5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A76303A3B;
	Wed, 21 Jan 2026 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958411; cv=none; b=HFrZlyIGbl5/KICHfU44HuB3bWT/o1It7x60VzNodvD9kYLkNjUhV3YJ2lJxAabH1wK8DgqL3BnLTm96nQ+OlP7EE2vzjq04EuI9h2Ml+ld92Ir7OCT02NH3YpySRTB8c/mhbc0zWnnS4cOIV9acyS5fz2ZVxtmOdefH6QPkI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958411; c=relaxed/simple;
	bh=CPOZv+Wot5K0LqeAp06D7Wy48VHDfXvvGxnAORF87UM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R1tYDMrgpIoGl5DeDMQwddupnPRf0qKCpfheUz46LA8vsAZatb3uz5qV1KtDvDsIk5Gdz6ooo1g3AEB7/1lxZTKImb5OBE/EiDUokVrJQh/gk72QUUh9n41pnBDcfDd3CToaG7RQFOh6bapP+OIaJBN/zNDCwC5J2mOjWgtsv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJtLt4v5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6AFC16AAE;
	Wed, 21 Jan 2026 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958410;
	bh=CPOZv+Wot5K0LqeAp06D7Wy48VHDfXvvGxnAORF87UM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJtLt4v5SndIj3dhVVsWZ9QpKXI9GN9dY0NoUqSXKkIGoTfwp4Y9Uu83L8Jmmft0j
	 z79JQb6373A7mHDO8IqG4O4dh8kmr3nZ3EVRRF7XAjT7W8uhqfEFXT6XtBuheny6rS
	 iQHltBil8u5uDu66v18p3rUohl6P6rvLq9DGmsGv0xH3P3lOFDvZIjdJN2OjLt5vAN
	 9s05x8dY8owcbNm6K8LwG+mqcKl/zGYDLscRwgtOWciwuHsdPJzfMR9gVjxXPuhshU
	 fVoS++5zMUTlqjEuKvZtSuJCub6CAtZR2ArAGUW796acbqouumRZw2zEfmjC6hnnWU
	 HP/B9Bt5Gq6eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EE74380820D;
	Wed, 21 Jan 2026 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Fix memory access flags in helper
 prototypes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895840810.676405.3513205876401603776.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 01:20:08 +0000
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
In-Reply-To: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dxu@dxuuu.xyz,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 electronlsr@gmail.com, gplhust955@gmail.com, haoran.ni.cs@gmail.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,goodmis.org,efficios.com,davemloft.net,redhat.com,dxuuu.xyz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-251681-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BADE54EFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Jan 2026 16:28:45 +0800 you wrote:
> Hi,
> 
> This series adds missing memory access flags (MEM_RDONLY or MEM_WRITE) to
> several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack the
> correct flag. It also adds a new check in verifier to ensure the flag is
> specified.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Fix memory access flags in helper prototypes
    https://git.kernel.org/bpf/bpf-next/c/802eef5afb18
  - [bpf-next,v3,2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
    https://git.kernel.org/bpf/bpf-next/c/ed4724212f6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



