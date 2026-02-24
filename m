Return-Path: <netdev+bounces-260286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGcPOmn6nGmXMQQAu9opvQ
	(envelope-from <netdev+bounces-260286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:10:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED531806A3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97A9C30330CD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9870E22756A;
	Tue, 24 Feb 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR1ZIj6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762651F92E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895399; cv=none; b=E3BsH0jICZoTIysMwkICq8HEdbTIW0OPpR2w4BeQPDXWrErm+rSlql7kKgiTtlFAX60LIkko2plIn/+4yhSeuCIr/V/1QpZv1aRN3xBbZ5kGHaQ7PbiyUOwXAi9YXvUuCrfu1ZiL8Y5TCxiBZyKAOA0FV3RQd0nKNfiwFaF0tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895399; c=relaxed/simple;
	bh=P1yZUWogBAVyIhILqThFzmzQEgO7fmqjIioehmeVzfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kipDbKeuL+qK+EdpeDIBBzJEIheWl9aWSM1ueXw55tdn8lwA/miJ4knYyfIVu1hJrszVNBEVVH/wiQYwZHb9yRNfv95QLko0t66/5bQq1ci1i6NWx8+XKcGLyG5k91nucYdMCb6PGajlOQ2N+4W3sfYvLdOhTMwTK0/30OADpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR1ZIj6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0422AC116C6;
	Tue, 24 Feb 2026 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771895399;
	bh=P1yZUWogBAVyIhILqThFzmzQEgO7fmqjIioehmeVzfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JR1ZIj6wA8WuMigwrhQow9AmnBvzeN6F4RGFuO5fqGPoqFnmgkYYf2dJYdXok48LU
	 dWrCcGKCdaAxzakt3gAsUEI+S5DaWQlrSKqsWG7SEhW+Fcuxfbv1AYAHHbMamty52/
	 gUnrMQM3DonbZWg/EVEHO5jHikWuOEB0Q9cAjiq4+hhJH4o0dJszqkPZcEuRiRISYh
	 cSfhaPdWOs83ERUDtmGmXSi853A36Sd7198OxmAEbZ2lZU2uJgnoh5U8keLnF0cGbu
	 Zn3iQ6fQe9IU801ykbs1ODrzUSVq3an9TtLcR/TrXnmJ3iXTBVnxuV/A22ntFIG072
	 Xuj/QW7kmeijw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBE33808200;
	Tue, 24 Feb 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: include all of framer under pef2256
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189540505.3260648.10416778090618627700.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:10:05 +0000
References: <20260221011858.3403605-1-kuba@kernel.org>
In-Reply-To: <20260221011858.3403605-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 herve.codina@bootlin.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260286-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ED531806A3
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 17:18:58 -0800 you wrote:
> The "framer" infrastructure only has one driver - pef2256
> and is not covered by any MAINTAINERS entry of its own.
> This leads to author not being CCed on patches.
> Let's include all of framer/ under the pef2256 entry.
> We can split it in the very unlikely event of another
> driver appearing.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: include all of framer under pef2256
    https://git.kernel.org/netdev/net/c/41e09ec73d74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



