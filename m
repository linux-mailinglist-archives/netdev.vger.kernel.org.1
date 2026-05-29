Return-Path: <netdev+bounces-293218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAKeKAvuGWr5zwgAu9opvQ
	(envelope-from <netdev+bounces-293218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D00608012
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CD413025FB2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689F3D16EF;
	Fri, 29 May 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="letJnpMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400D3A7F58;
	Fri, 29 May 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084209; cv=none; b=eTXYoxFwZCvhB3BZ78ATUuwsmf2E14K07LOBVJCorNZNRI5RgutLvbSH6w5GH2j3qpm9Ecilv4vzzNFmBVW+DYI6eOIU7YHwYDyFwjQXN82+kagfsk17rpfP4nUZYIbFui2EiRB8exRzAnXUNXOBKDPbm137iUDqvMJtsr5P/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084209; c=relaxed/simple;
	bh=euke7jXEZD9I6mubBAWhgskCH+f9edm0i3hf3mPSRi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ia3BsMPMNljK6WV0gipE6VC9FsC373DAHtIgPm3Mc08S8cHtZPXoOe5cJGKQEJsqe/K8UyefANc6Y3ctcypMA2X+/X3/4abtSyKtHmXo841iU4qdB+XO42VIRXFW2P+olfaaRXlOAtsURvi8m2LG+MbDBust33nbnQXQSK/rybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=letJnpMO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A51F00893;
	Fri, 29 May 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084207;
	bh=kUcDXk3OwJjoexyvDLeDcJObN4z/B2xXJqSpJXXgG+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=letJnpMOxK3NTwyf+k34eGo1qVmkGY2777tgHWO6YSi/vDCRAQR8sOIzdCLtNHqRC
	 6o0mP4u++wV0/2gTlRLfd0NMURj0so/uoUISqJm3jhQDI0fyUJTTOR+YwJWXfIFOIR
	 +f7r7vfTO3EsNNjxryRLlgUclERzBK6mv1QeC/ms4sEWUq/YPEFboJQFRC//v3jlyE
	 ZyuwVjwS6GDnZ9ivCxLSzWOcOFBuqmdHFZ7MlAuSvC1mg8WWpQDBqLqrjgEAZpPml/
	 PqsbgbMCe0PGKQWHKZE8yrAkFtxwTu5Cr/WzmJLfu2v0qLQgDmZYQgszudS3Lstryq
	 gKWzMZAwgFb0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BB39301A0;
	Fri, 29 May 2026 19:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] bpf: sockmap: fix tail fragment offset in
 bpf_msg_push_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008421113.1939215.5842467464191441713.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 19:50:11 +0000
References: 
 <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
In-Reply-To: 
 <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, xuyq21@lenovo.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293218-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,lzu.edu.cn,lenovo.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lenovo.com:email]
X-Rspamd-Queue-Id: A3D00608012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 11:48:15 +0800 you wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> When bpf_msg_push_data() inserts data in the middle of a scatterlist
> entry, it splits the original entry into a left fragment and a right
> fragment.
> 
> The right fragment offset is page-local, but the code advances it with
> `start`, which is the message-global insertion point. For inserts into a
> non-first SG entry, this over-advances the offset and leaves the split
> layout inconsistent.
> 
> [...]

Here is the summary with links:
  - [net,1/1] bpf: sockmap: fix tail fragment offset in bpf_msg_push_data
    https://git.kernel.org/netdev/net/c/f72eed9b84fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



