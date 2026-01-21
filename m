Return-Path: <netdev+bounces-251733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFOILZU/cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:53:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240E500D4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD74AFF1E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782973563E0;
	Wed, 21 Jan 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtwFYmds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B72356A01
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963814; cv=none; b=ju4AmUKb0a4wRBzR2eECo8HffZ8ougL18h7eqlXvccCbccLmMY/1Bpcxis7cnAY4wSxTE72XpZaI3aMKwPqPCkw+r99BRc6gkkhzCC6V9tjmWEiClkui2blrWFUJ7iiqDJqxdDzXcRRSCmOcWfVMa2aQRoVnHZOq6cI88oprnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963814; c=relaxed/simple;
	bh=fzwzjEOguhqxtPmDFwmJbUnBC5u2GCMsDqLQoCGlGZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/AbbTpfw09m2Nwt/cjKMEru3WQck8ynAK5kT8JuP4UBRiFPR0gm5pU0cYQPA+sS2sBBvwQw4n9SS0+aQg0jCNDsDLlQxN63dS++WISuvftEZz6lZlBcW9wG6OFrrCFjO/9iQ+phgOeYex2+tE05usOzsU+CWTGF7VSVxPXqlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtwFYmds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3388EC16AAE;
	Wed, 21 Jan 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963814;
	bh=fzwzjEOguhqxtPmDFwmJbUnBC5u2GCMsDqLQoCGlGZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RtwFYmdsc4v3RQcgzL8wBVwNfTtXEN/vOI+7iiWbTK5n0GNPReT0W4bqA7CBil+lB
	 3cgUByNNzqx8dWDv9QV3x3LxB9Gsl0AmXhUBKofxKPIcKlZhmnZ2h1e0W1Lx7KOxEd
	 UkKtKzVFiCTKNtxNQ2pqdr8/eEBLZmg01/22JEG18vAvYroOr51TJfUEexDIzzeYdI
	 /BYkVYJoRj4m0SqiA1RAYD8+DWQ9Ax3RVj+ePmXSWLW6mx0jnRu9E2Hf0NOCWDzqkO
	 lqxhDCZBpzJdGqEo2ed9LUaXZPh6LG3Oll4H69ZxVrvmDE+8L8qt3h24R+nf0+KPUP
	 fh/RVqL0S6vEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CC1380820D;
	Wed, 21 Jan 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: Replace open-coded device config
 retrieval with of_device_get_match_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896381134.703462.10725162835746447441.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:50:11 +0000
References: <20260117-macb-v1-1-f092092d8c91@gmail.com>
In-Reply-To: <20260117-macb-v1-1-f092092d8c91@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251733-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6240E500D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Jan 2026 09:46:18 +0800 you wrote:
> Use of_device_get_match_data() to replace the open-coded method for
> obtaining the device config.
> 
> Additionally, adjust the ordering of local variables to ensure
> compatibility with RCS.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: Replace open-coded device config retrieval with of_device_get_match_data()
    https://git.kernel.org/netdev/net-next/c/1be080b78fd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



