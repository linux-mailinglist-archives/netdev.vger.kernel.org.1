Return-Path: <netdev+bounces-295978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qQpEL+k9I2qplgEAu9opvQ
	(envelope-from <netdev+bounces-295978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDBD64B5A5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oi1CngqI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295978-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E5C0301AB42
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C313D3498;
	Fri,  5 Jun 2026 21:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A03D331A;
	Fri,  5 Jun 2026 21:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694421; cv=none; b=mCVXnXX5MK7s6FNhfGhKteGsK8RQb80ZA24Wg2oDp3hTa2G8pQ2OdUEgfChcaHG2N15upUXjPCbhbadx7yPDb0oKBp2PaMQvdgrCOQAckoppCeK85DHiiaMJnEut3WC6q9poaKPp+EzpLT/i0xPKwIA4vhXbf7Gjf1RYg25VoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694421; c=relaxed/simple;
	bh=Cx+8qomZY5FQwAhNoiy9JrsEd1ll4hy79/vzsGtXG54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fS5O2f846mnWgJ4zP3pRnBgbuPFY2vACMxV/JfHz78Gi7T8kf8xkIOUqg2mqddsXKtTDgW4OtI3iX/lKd00PdBEvvjJSH2WswlcWluZHpu0vh1U/AAaNfZvg7DhUvqTdpRdAEoe2UoWM8rzWUm5K43pVi6L6ILQP7BfUiXsMb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi1CngqI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A51F00893;
	Fri,  5 Jun 2026 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694419;
	bh=D5IJ/BwlkmKjnnqEMKn+22YmB1KatBt00b8eCo4vmOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oi1CngqIPerXOPHZBRFVN6VpPiem2VLPwVRE4v+5P+5eSK48uaHycR+Q0tVloSgbL
	 bxUITYi6v59JFG/cGOEHJ0nw/QmrGF6rrUBoMY6kmjMouYZxFGnwzeZwg23Z0zWeJg
	 M9rvh/Yovva1Je2LSEhNI9wyHSCpqISx8DcaIh0XCus3dsvnghkp4tqGQg6XpkQ7xu
	 23dgpibWq6TFYyHKGQQwuCjEy62KiPatxp9mD7Q/9ek8UjBjh0AB0qYb59N6KzXBPt
	 I/R1q6RGOmVJmAvjeIqmECuLv9jUg7qUwoABVvuQLyAtU+1VjPXXlic9InQVBrCqDB
	 0d0Ze9aDpjtig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568323930BB9;
	Fri,  5 Jun 2026 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] Object relationship tracking refactor
 followup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069441988.3922226.2367638176969669476.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:19 +0000
References: <20260605202056.1780352-1-ameryhung@gmail.com>
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295978-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEDBD64B5A5

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 13:20:51 -0700 you wrote:
> Hi,
> 
> The main patchset refactoring object relationship tracking in the
> verifier has landed and this is a followup that addresses the remaining
> feedback in v6 [0].
> 
> [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
    https://git.kernel.org/bpf/bpf-next/c/a3863aa4f55e
  - [bpf-next,v3,2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
    https://git.kernel.org/bpf/bpf-next/c/73d475dc6c13
  - [bpf-next,v3,3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
    https://git.kernel.org/bpf/bpf-next/c/41025f441fe6
  - [bpf-next,v3,4/5] bpf: Remove WARN_ON_ONCE in check_ids()
    https://git.kernel.org/bpf/bpf-next/c/ac7f6c9da6b6
  - [bpf-next,v3,5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
    https://git.kernel.org/bpf/bpf-next/c/d83d4f63cb8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



