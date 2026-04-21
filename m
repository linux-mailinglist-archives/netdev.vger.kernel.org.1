Return-Path: <netdev+bounces-280036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKUaDcku52mf5AEAu9opvQ
	(envelope-from <netdev+bounces-280036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A2437ECE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF413300E3CE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D5358369;
	Tue, 21 Apr 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKUAHwkD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB228000F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758442; cv=none; b=ev6FgGWGhnBFVBMbI7ID9DCHP8SE0hrQdzTN8yiadAWCOoUiYmTJmf5t5N3FyiFhkAhNOLhJdtroGSiNCsQzzKwZ97s5xRWYTbV9435z2oukpu5IapjWhK5N9TE3IORWFlkY0LFueQwtDH7R7xtXlN+HJLRbyyu34MCbKKhySg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758442; c=relaxed/simple;
	bh=HINEgVN8H/Ve8mji4peqpKfufOLQjxMkaTkznzg5C5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HvV7LaAqYgMY804oKoFassjcir492cFmMzYZbVdSeiQQjrUjohIiZDCxhv+8lih8pHZKDVRoMk5mPjw3hjJuvjUmglhwpzQ6hKuI4G7cwDpXD5rpwSUBh3IgN/jJ9dI488v5Xhfqr3nIjCX8R3Ycgnw1sCzPON7dIED3ZnZIIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKUAHwkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D610C2BCB0;
	Tue, 21 Apr 2026 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776758442;
	bh=HINEgVN8H/Ve8mji4peqpKfufOLQjxMkaTkznzg5C5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IKUAHwkDonAyvrTvV2cp6SR9mvVI7Ek46WkWUSNB+ZcVqUpK58luyQ8Iaf+W5KIai
	 nk7nB49A8UucIrGf3a3JR0nqcNB9ceoB8zA12u99cL3fPMqEckRp8pjJ649OzPuOZo
	 e2gnTJiciF6slWh1TG2Xd2/6cIAYirwIxXo990JIdzXE8A1oDkav9UoY733btgGQuU
	 +3xQ7yVO6lT2lDG3SsZFdLHGo+SSSmDw/xpdkZerPiuIN4BNudDP+LzSBkQ0bHXTy3
	 T3oFSwzXP83XY/lM4BcSWwCOkvH80yrFOKuR3q/rRYEOhPodlIZM1EDblSnRvmvaqV
	 9zURJYjcjZSwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC553930034;
	Tue, 21 Apr 2026 08:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] slip: reject VJ receive packets on instances with
 no
 rstate array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177675840579.2277288.17567730434621085926.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 08:00:05 +0000
References: <20260415204130.258866-2-bestswngs@gmail.com>
In-Reply-To: <20260415204130.258866-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, xmei5@asu.edu
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280036-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[pabeni.redhat.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF5A2437ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 Apr 2026 04:41:31 +0800 you wrote:
> slhc_init() accepts rslots == 0 as a valid configuration, with the
> documented meaning of 'no receive compression'. In that case the
> allocation loop in slhc_init() is skipped, so comp->rstate stays
> NULL and comp->rslot_limit stays 0 (from the kzalloc of struct
> slcompress).
> 
> The receive helpers do not defend against that configuration.
> slhc_uncompress() dereferences comp->rstate[x] when the VJ header
> carries an explicit connection ID, and slhc_remember() later assigns
> cs = &comp->rstate[...] after only comparing the packet's slot number
> to comp->rslot_limit. Because rslot_limit is 0, slot 0 passes the
> range check, and the code dereferences a NULL rstate.
> 
> [...]

Here is the summary with links:
  - [net,v2] slip: reject VJ receive packets on instances with no rstate array
    https://git.kernel.org/netdev/net/c/e76607442d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



