Return-Path: <netdev+bounces-266129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN0rC1wbsGlAfwIAu9opvQ
	(envelope-from <netdev+bounces-266129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC171250230
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A26A31B4B98
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D93CBE6C;
	Tue, 10 Mar 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMuqiL5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3633CBE68
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145809; cv=none; b=HWEjLvJwpeGJLuwQLwrSPw6mBS9QQPUBlYABJI70Kx+XejxoEcgh7KLGCbsptLqowxDw1UvTLTY0qMVGDtGRtM8SAukyaIoWuJ+nDibopErBNtvGLISXB6jnFlgirenqDSNtw5eTcypULnpS87nH4M24scipkEJRdpWn1T9yXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145809; c=relaxed/simple;
	bh=TzlCotxcVT6dvedJ0FiuS4FRNkDSl+AbCRH0nt2v3jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IdICRW10DTauYeEbJRzHtsoTC8DzpWQfrY6S1Z1p+vlAaszUn7HYRrW3XRS51jWZLbYnqEMoHT1fvrGzad9B1VF/p+nzVrYwJYo8zbvlAL7emsKex3WodhQtzTPpR71prC8ZqbEx3qA2/mkeq1jDcx+ujIZPkPa8YxS35tNVYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMuqiL5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D47C19425;
	Tue, 10 Mar 2026 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773145809;
	bh=TzlCotxcVT6dvedJ0FiuS4FRNkDSl+AbCRH0nt2v3jU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMuqiL5KD/vE1T73WmdbrD7Ys72rQc4Gj/7cE98alu6HSeOGlVn/QMZYHFrt3ZXHM
	 TMcZ4f2OE9l6gnGZxp8LUFqKYIUCHVJtZgsDspWwhqIo1NpsRAj2dZsz/OSDf3ki5n
	 cAaDVOx+oF+SclLCMH/HYHssnfVPAgjt8+p5geEAt1hb4YjznDLyHDKHOH3QUzM21U
	 5MCW68OxflZWKyfojLH67hpcKx+VP0U+JakijCwEBRBIqy8NqHnPvWYFRxVhrexNrv
	 CBb2r6BJRJT0/TSafCp4wLTQBFIYS995fb24DFVSycGil1bmoxZ/FmIaQONKcGKTbc
	 YiJ4YfCJh04Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDF53808200;
	Tue, 10 Mar 2026 12:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Move GDM forward port configuration
 in ndo_open/ndo_stop callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177314580605.2263385.3496529123194142050.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 12:30:06 +0000
References: 
 <20260306-airoha-gdm-forward-ndo-open-stop-v1-1-7b7a20dd9ef0@kernel.org>
In-Reply-To: 
 <20260306-airoha-gdm-forward-ndo-open-stop-v1-1-7b7a20dd9ef0@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: DC171250230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266129-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 06 Mar 2026 16:09:47 +0100 you wrote:
> This change allows to set GDM forward port configuration to
> FE_PSE_PORT_DROP stopping the network device. Hw design requires to stop
> packet forwarding putting the interface down.  Moreover, PPE firmware
> requires to use PPE1 for GDM3 or GDM4.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Move GDM forward port configuration in ndo_open/ndo_stop callbacks
    https://git.kernel.org/netdev/net-next/c/46097d011f77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



