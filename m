Return-Path: <netdev+bounces-251775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAaqLwpbcGm8XgAAu9opvQ
	(envelope-from <netdev+bounces-251775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:50:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094F5135F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 879C74E0E6E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F9352955;
	Wed, 21 Jan 2026 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/TOg/m7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD093330B0C;
	Wed, 21 Jan 2026 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971010; cv=none; b=l9LumB2d7pXsz2G7/3A0Wh/uVo1e3b48D1VQOeMT7T2gKM7r6ZTZZjNtSblVspn7ofmSbg+Da9WOHJc9M5AUtXLSqDePb4HzVH+cygo4cUrnKWI11zmWb19f9k/nfw9eVF/saeEbXIinMIJKN/apxGHC2a0PJdCHj6ZY5R3eoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971010; c=relaxed/simple;
	bh=CmAIT6kTBUuZkscloNW0+zlEBrPGGxsQS6azAehlKZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gH7VnkedEFJkScNsyO9HsZoV2incjTcDB7eG/f+0NqhzIqEeCyEa2z5RUM5+/pBKZ84mnSXzETeH+WSSEStD7R4F2X0OZHllpf+eU0miBN/2LUrFPoK+i1PZ4MTCMcSo3sUqaA4bBzLdnM9kesXRUwPaXbXZ8DXeCpwG3q71rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/TOg/m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA97C116D0;
	Wed, 21 Jan 2026 04:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768971010;
	bh=CmAIT6kTBUuZkscloNW0+zlEBrPGGxsQS6azAehlKZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A/TOg/m7XTZBA2VWYs+VRfQMsNwBJ52vTusNrUCcJ8Z1jWppAo4Kxy72o6fa70Iqb
	 IOHJBJ9E6ssrEqCxBd9KEEpdG0Yhp6yiA24RRln+cEoeBp9oMg5iPrUpUF9obrelFO
	 smkd/r52oUOwg+f9TQZtBbauE4fhj5uIr867Yh5PL6K5neP4/a8BA9Zt8o5DqRpTZN
	 dafvSZOPc9sw7xUFcPxqRgEmrGjBczA58RAx2FBwINSJpIXq0i4vr3i+c6UIUQty2h
	 z3dd7mKGJ5qxIfVTios2VLOTZx8hxkek6JJflUQdSbTAn1T5PdfsL/tSj7zMKGGrqr
	 7OnTAKbMkCNQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B11380820D;
	Wed, 21 Jan 2026 04:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176897100760.729216.7176451901339575079.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 04:50:07 +0000
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260120070555.233486-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-251775-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4094F5135F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Jan 2026 15:05:53 +0800 you wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance, and add the testcase for it.
> 
> Changes since v5:
> * remove unnecessary 'ifdef' and __description in the selftests
> * v5: https://lore.kernel.org/bpf/20260119070246.249499-1-dongml2@chinatelecom.cn/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf, x86: inline bpf_get_current_task() for x86_64
    https://git.kernel.org/bpf/bpf-next/c/eaedea154eb9
  - [bpf-next,v6,2/2] selftests/bpf: test the jited inline of bpf_get_current_task
    https://git.kernel.org/bpf/bpf-next/c/4fca95095cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



