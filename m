Return-Path: <netdev+bounces-253128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHO4IHGHdWn0FwEAu9opvQ
	(envelope-from <netdev+bounces-253128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 04:01:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E387F8D1
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 04:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74325300CC99
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FE21018A;
	Sun, 25 Jan 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMYtBfjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9E26ACC;
	Sun, 25 Jan 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769310027; cv=none; b=WAzgjWsgFNxx+ZEScgflsB6xP7P7dvoYjDfXyKzGGXCtePTtg8wSAuB0HQbsKA7tDCsLAPpArebV4H+Gm3i2K6g0PwCbqZ0uWVv6bvsKO8lMAS+X0eyse0TBPIQJDxbxdXD+4ZbgV0N639Knb2EHnKBZQ4GXYmY1yGd/53ao2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769310027; c=relaxed/simple;
	bh=YqaW9tz+7OsYDKVkNU3i0UCHGE6HGW7BFSYdk6LW+A8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WZvieczGCT4VF7hz0ueR99H1uZZJ2n57n//aEXSaTa+SWNn3H0RhDhM9rLMxBlFzZz3+CjV3J/U7z623zmYGKgMtXcSFKiTa7VFnGJXdcmZqR3xVANyGlCIPOZ/MMrMGhhxh4hE1zq8nZXRrl4DbgXDsAhmuktoz6gdsGfMQh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMYtBfjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE1C116D0;
	Sun, 25 Jan 2026 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769310026;
	bh=YqaW9tz+7OsYDKVkNU3i0UCHGE6HGW7BFSYdk6LW+A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMYtBfjfiyMgoj02Rkh8MCbwJzDsoMenbmosZc856oAqtb7nNGEtBwqeRY5jJ2bY7
	 t44IWlPLfm8QE1QVfdX8/QyK+zNhn3mrFWsJMTNIg+4QSKgmmIthjKlqPtTpAboyfS
	 Hp3CujO+vrFBJQDhif0rwxDFrN09ZTBu2gD7pn0OGC1mrc/aFkUtdYxZhp8uz9NU5y
	 2nmnfDTOcbKPsjiyDiQcHG2vam7UzFdHgTX2+B4RzRZD06IvbJmXh+H2+zwCWO1/Nz
	 LnI2GlozZYuERSG86K0ElBhjkyxEA5gbBDrSsbTRs8li2AUanq8XBNkF7NrivgGjFw
	 hbfgP+ttBEYlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC0F3809A00;
	Sun, 25 Jan 2026 03:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v13 00/13] bpf: fsession support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176931002209.3419928.12789468285524749357.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 03:00:22 +0000
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253128-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10E387F8D1
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 24 Jan 2026 14:19:55 +0800 you wrote:
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v13,01/13] bpf: add fsession support
    https://git.kernel.org/bpf/bpf-next/c/2d419c44658f
  - [bpf-next,v13,02/13] bpf: use the least significant byte for the nr_args in trampoline
    https://git.kernel.org/bpf/bpf-next/c/f1b56b3cbdb2
  - [bpf-next,v13,03/13] bpf: change prototype of bpf_session_{cookie,is_return}
    https://git.kernel.org/bpf/bpf-next/c/8fe4dc4f6456
  - [bpf-next,v13,04/13] bpf: support fsession for bpf_session_is_return
    https://git.kernel.org/bpf/bpf-next/c/27d89baa6da8
  - [bpf-next,v13,05/13] bpf: support fsession for bpf_session_cookie
    https://git.kernel.org/bpf/bpf-next/c/eeee4239dbb1
  - [bpf-next,v13,06/13] bpf,x86: introduce emit_store_stack_imm64() for trampoline
    https://git.kernel.org/bpf/bpf-next/c/37c7ba1b39c4
  - [bpf-next,v13,07/13] bpf,x86: add fsession support for x86_64
    https://git.kernel.org/bpf/bpf-next/c/98770bd4e6df
  - [bpf-next,v13,08/13] libbpf: add fsession support
    https://git.kernel.org/bpf/bpf-next/c/257c43688b14
  - [bpf-next,v13,09/13] bpftool: add fsession support
    https://git.kernel.org/bpf/bpf-next/c/85fc4be6d811
  - [bpf-next,v13,10/13] selftests/bpf: add testcases for fsession
    https://git.kernel.org/bpf/bpf-next/c/f7afef5617b6
  - [bpf-next,v13,11/13] selftests/bpf: test bpf_get_func_* for fsession
    https://git.kernel.org/bpf/bpf-next/c/a5533a6eaa5b
  - [bpf-next,v13,12/13] selftests/bpf: add testcases for fsession cookie
    https://git.kernel.org/bpf/bpf-next/c/8909b3fb23e2
  - [bpf-next,v13,13/13] selftests/bpf: test fsession mixed with fentry and fexit
    https://git.kernel.org/bpf/bpf-next/c/cb4bfacfb011

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



