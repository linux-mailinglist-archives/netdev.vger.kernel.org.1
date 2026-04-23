Return-Path: <netdev+bounces-280590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F+uJtSU6WkreAIAu9opvQ
	(envelope-from <netdev+bounces-280590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FC44C928
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF12E301C6DE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7173CC9F4;
	Thu, 23 Apr 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3zvnRZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6523CD8BE;
	Thu, 23 Apr 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915649; cv=none; b=OzrhsSebly7qomeeK2ypVT0v0KkNBniHzZuHwqWyay/LBqJsd2J8r/vh515hsKlOyLPyMKE6+MYj1kwLJhQFyCg5j8T0pVO/YvVe/hPclwn1VXelyR/Z8pRLcHrWxMDj0MA5OPK2xg+LjFFwx082zQtxwj6EZfRnLZAKpcG83p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915649; c=relaxed/simple;
	bh=PBP8Do9+jY8Po+AUnnom+GQUGYAYu8/xp/VLJGo+qkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uzMlWImLRqpS+Z59VgA6CoinqxBEg95Dr9Tvya2F1nAPhwwsWBWHhCMyqSFsyp0eY3zYyCR4q4N2inBvNu5aMmzef4nq8E9jP4XPAQ/Jep/DxK31xVl7esyWgvrXwelcftLcM5tsF6rZw1+9BUkAIqzOmNBTIU8rpH+IBA7vBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3zvnRZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076FAC2BCB2;
	Thu, 23 Apr 2026 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776915649;
	bh=PBP8Do9+jY8Po+AUnnom+GQUGYAYu8/xp/VLJGo+qkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3zvnRZ7C54tXWArsyKqN1jHlhMhUMohHrmF3fNpL+N3kX2PbFWqIx0sZbihCmaU3
	 EVlqqKY7b1o9nsy/sKzfPVhIFl0svUF2icLmZs5X0i4xjJVxcF6pZcZBCUQBrTPfKa
	 CsSh6aF2jb6Y+cV4kvljmGF7CAjAPIrwCGW6N+cFraWxh6k+oAFpHhXfu3igSfSNHv
	 pPD8oOJR6pqdXvV1gH0kZ5WlL9Vs0w3BDxXtVEfU3/fe0nwXlQNE920+g3WPe8wYT3
	 PgYTSpZThcxA3w5qnd2tAXyfdPxwAPzleQxCOjBuGESxHMzMcQGXeygSQQMcf+YAjG
	 dAWqCDxZsFCrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF013809A86;
	Thu, 23 Apr 2026 03:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: maintainer-netdev: fix typo in "targeting"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691561079.4145271.10604908503481958282.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 03:40:10 +0000
References: <20260420114554.1026-1-islamarifulshoikat@gmail.com>
In-Reply-To: <20260420114554.1026-1-islamarifulshoikat@gmail.com>
To: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280590-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 178FC44C928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Apr 2026 17:45:53 +0600 you wrote:
> Fix spelling mistake "targgeting" -> "targeting" in
> maintainer-netdev.rst
> 
> No functional change.
> 
> Signed-off-by: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
> 
> [...]

Here is the summary with links:
  - docs: maintainer-netdev: fix typo in "targeting"
    https://git.kernel.org/netdev/net/c/645d044d7e5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



