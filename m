Return-Path: <netdev+bounces-263323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDOvJW8Qp2nFdAAAu9opvQ
	(envelope-from <netdev+bounces-263323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B681F40EC
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1549A306DF35
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616C3264DC;
	Tue,  3 Mar 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsmX74jt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529ED3264D9;
	Tue,  3 Mar 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556025; cv=none; b=Sw1BR/bBqiguEDdIJC6qFMylD3uHEVcENOZHL+PpvRjp1uyoGF3mH8C5skdDGzRD2Xo4uazOoTaugT3IAQKWzkIscfADAjIqOuYs6k1cXdPrCSsYyib7ElByR3HKuFuIFVw/mi95YMXUXnTg2qbFU/u3A70igAVoMahSxCc7RU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556025; c=relaxed/simple;
	bh=hkQzVbVFAY0Lw+KXpTeChxTqQv9wnktZibMANBna5X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i40SEFP7o4gFtFqcTZUiLReMoq1sBM/8VjP1l0MHnOcETcZAsDL5i5NyajJ/Dlp98HZOFvfsJYrCnROybNcOlBHdBLSlZuxVGi4yTBUz3IoUSoYlqF0iBawClPBQNz8UMDmB7ihYxfeQmHyE1Bx4shaXlQd82UsnnhgwMqZPTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsmX74jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA46C116C6;
	Tue,  3 Mar 2026 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556025;
	bh=hkQzVbVFAY0Lw+KXpTeChxTqQv9wnktZibMANBna5X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsmX74jtlFjI1TECLe2oIukB884C9yoFtki+N9gYhIctupO4b4ns9NxgEbGT34Ozq
	 qIjcvbskuKh/r37YiL8/jvN24wxbZooaryAvv9rxU17JPf1MPwHR9oS4TENPhLkZ/g
	 GXXvTTQDMfq2w5/aRXBJL0kkSX2nimO3QDj9N9GvcvrUtuF4QHCOdSRmlfbRN1Ttuw
	 pPpPRnH8RkjBfreHIozBPbo5+tU+BmpMSzwDuWsuXEjH+zIfjx41vqxGGe3CM9SW/h
	 I0kagDq1uaiLfksDxlz+WQHdZPkuOfmcHlHTlIutlFfdgJW3P9Pk0u5wVJSbhabROZ
	 9e1OnEAL4UsPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0743808200;
	Tue,  3 Mar 2026 16:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog
 runner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255602606.1378092.6497646158888477308.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:40:26 +0000
References: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 40B681F40EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263323-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Feb 2026 09:59:24 +0530 you wrote:
> cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
> XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
> falls into the default case which logs a misleading "invalid XDP
> action" warning instead of tracing the abort via trace_xdp_exception().
> 
> Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
> the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
> devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).
> 
> [...]

Here is the summary with links:
  - [v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
    https://git.kernel.org/bpf/bpf-next/c/39948c2d42b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



