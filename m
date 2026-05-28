Return-Path: <netdev+bounces-292495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PV3HTKSF2oUJggAu9opvQ
	(envelope-from <netdev+bounces-292495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C999D5EB6F8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A7D3000A77
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8E21FF25;
	Thu, 28 May 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk7hOrcC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471121E097
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929403; cv=none; b=onp3n+7j1b09dTZub0e1vrfgVNytquySi5X9+xHC/j7b8M/AEHmMuhVMAur3BkLYI7HRau+uEAdpfJWq5mDB6gXQbnwFfIooi/neDU0zfrOwdxJDICrkroqHwnZ+f7fIR6YBEcHf0DTOe+RQWSmoq32WXCzH5xzJ6b3zQbSwUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929403; c=relaxed/simple;
	bh=pT6uoE6Oqf5GNB5FJdKfwImYyJM8qnQs0dy3TZ/i/Q0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uzj+p6a5keDiz0eUhAGT/rMoe1y7WVIHxD5L53WVqpL7aBMn6v3KmY/b5+7Ue+w7B9uYH2W9FsEeGu47U7bj6HdVUtZ4dIjUQ1gjZpYL/vuKiy7RGb+QydcF9ZCJEzJCWrZo+n1wILMXeF73i9icqz0O0hZfs9zd9fjeqMNZDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk7hOrcC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB811F000E9;
	Thu, 28 May 2026 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929400;
	bh=JilAlvhTQR4Fns/WzNI4hUHEULD/eTtPpCYnVAmlcJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hk7hOrcCgmEYeQuKBm9SXvWYxR2hhEE6D1bPldDVRdNeBWwG9iUmDGpoZs7I4cH2d
	 PTfAi9nPjMp5PBnnbAAEz1e85E+FwwxxsJJ1BnmtGQcMHYPG3GXpaB95GNLyR2pIRo
	 nKGwJLDd70wi4UtXi4FS2vHe2VJPqeC1bOWGiKl5r96ioeAHG85ixcJaZTa0hSaSqw
	 WRJk6RVwvdGQ1GQTvSqCyKFamUKTMp6bcWNcttQbyl/rw5eU6rDs5JR/f7jr06ySH1
	 EyBc+JV/DfqhCyW5RlW4QWi+LvVWK5pEWLGoOCByrRalIt92e6yEFFOSItFnh+DXRu
	 zNVLxhslWOYTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4F380CFDE;
	Thu, 28 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
 page_pool_nl_stats_fill()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992940540.700169.1846951496298474354.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:50:05 +0000
References: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
In-Reply-To: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaodongdong@kylinos.cn
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292495-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: C999D5EB6F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 14:51:56 +0800 you wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> nla_nest_start() can return NULL if the skb runs out of space.
> page_pool_nl_stats_fill() does not check the return value before
> calling nla_nest_end(), which can lead to a NULL pointer dereference.
> Add a NULL check after nla_nest_start() and abort the message if it fails.
> 
> [...]

Here is the summary with links:
  - net: page_pool: check nla_nest_start() return value in page_pool_nl_stats_fill()
    https://git.kernel.org/netdev/net-next/c/36d0d876c45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



