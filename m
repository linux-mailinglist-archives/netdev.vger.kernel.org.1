Return-Path: <netdev+bounces-289221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCLUGnytC2omLAUAu9opvQ
	(envelope-from <netdev+bounces-289221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:23:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57B575829
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2A0F307762D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5047255F2D;
	Tue, 19 May 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoFTnNYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F224169D;
	Tue, 19 May 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150013; cv=none; b=SOuyUDZAmGIZ/dAglnQXG6n70BB1bvs1K+8JZRljZ5RsfW0IDo0YWbae2CcwDERzMxIVFcCoiOD0oP9HmSo2yCgy+AbD7Jeqcso4vcZiKC9yVQJpj6X23ojRb5t8Ng3p4RvMp3dUuiVd5e0SoOnCF8HWcJ49jAMC6r2ziJDpWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150013; c=relaxed/simple;
	bh=e1X3335OEltheAgI/21colG6gIZuJw1E2jAo+sIgwsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MQA2oF0SX3FPFflr6t4UNF/E+M8+TE1IpBmJhRQxyjtHhmtGgf/6uzDrdXCmv9045Asx8GzAOxiQmRauWHTmZilydU96XWrSBtee6wjdVrmmCkQbqVO4Zsmm8jJYHViq3SKV4AVS+Z34/QLQ6CGnkPrVP+7CkpiT2m2XamctFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoFTnNYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C6AC2BCB7;
	Tue, 19 May 2026 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150013;
	bh=e1X3335OEltheAgI/21colG6gIZuJw1E2jAo+sIgwsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EoFTnNYb+MHn/3pDrGV0PpaqBpQpuKVbjJC8vXbH1sfm/nBI2FU2XnMbLHHNcGx9t
	 fudX2VmRHZeMpcfji6g9P0d8mtnSQLZ6d3vu47S+wANWsjxCuJlz+KTF2epAc8utFA
	 swVvdZWvvVEwDk+xZmCwUYrswzLR1pUx1ZDkc7GLFAI52omXlpZO3EUVvZIaik73MW
	 K+Tr2fO5L6Ryzbkx333NQB3vx9+3owkLIgrJvfR7xFzBXyfRpTLGqewdJo0WuZ+6Yx
	 HYgR5EOlTo8U1uZgiWUJm4WC32Rsezsy/DIPuyDjDZ+mqteAqTC+cUxYPTllt/i34M
	 P2wo24kMsO+Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A013930CBF;
	Tue, 19 May 2026 00:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] include: Remove unused ks8851_mll.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915002463.2025486.6484167332702839166.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 00:20:24 +0000
References: <20260515184531.1515418-1-costa.shul@redhat.com>
In-Reply-To: <20260515184531.1515418-1-costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: marex@denx.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289221-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF57B575829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 21:45:25 +0300 you wrote:
> The last user was removed in commit 72628da6d634 ("net: ks8851:
> Remove ks8851_mll.c") which consolidated the driver into a
> common implementation. No file includes this header.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v1] include: Remove unused ks8851_mll.h
    https://git.kernel.org/netdev/net-next/c/086abf9da661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



