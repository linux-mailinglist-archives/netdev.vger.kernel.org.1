Return-Path: <netdev+bounces-286027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAj0HLZm/mk9qQAAu9opvQ
	(envelope-from <netdev+bounces-286027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA94FC6E7
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5512F3051294
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8F3A1A55;
	Fri,  8 May 2026 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXRNQrlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D939E6E9;
	Fri,  8 May 2026 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280062; cv=none; b=qJBhXkLg43XzW76kPPu88xx9FnOXXlMFy+zQ6gXFNleTdf1ocfENe/czdbM1dLDlz3TY3+kAHiYb4KrCilZEN79qIOFA173m4YdVd6OD/ySB9tmJd0SZYRPkbqlGC+9Bzo5VQveaS1Qr6jfDqJVmdawrH8ToPE4nLJyosAVaIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280062; c=relaxed/simple;
	bh=n0jUP/yyNcL/aXHTE92l8/P+v5Q7LRIYqcwzyoB4tvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P01lW2moyjihakR2ZnfYq1uS+ecJsXDEZWiz5ZJjo2xDLD5HoKWJQjOPtP3DEQz99A4Q1NYsR7IsAY/IqBoiXJp2RKvplPsGW/ZWfPpePUGGdZBYnnTakY7T/vAN5OiDEHIFoplhUzJU/OpEn14+jP9ye6qipe4yUUXMonTe3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXRNQrlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE3CC2BCB0;
	Fri,  8 May 2026 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280061;
	bh=n0jUP/yyNcL/aXHTE92l8/P+v5Q7LRIYqcwzyoB4tvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YXRNQrlMky4dgJ0LqgAATYXcXuDqJs1EGOpzxX2gCLvpuNQVwQfTm/GwRixiHmvPK
	 CcPa6wQKd8GqBcYMszRwsMdGUPgH87f+zOb3dwsfYqobTOKrgFYq68OBJcVK0iD2nJ
	 TtbTfOGt+Tqio1TDxPeduWXJYjBjBe6zrUUW542FYJ7yZt05sonHBYdzYKht0UoVgR
	 1AOZJSsSlS4tSyu85hRMsoGcdgSDc9cCm2m8v6c9qbh8SqF5pMItTosZ1Ois5p98eK
	 lwVxtJWKVpSLaWpUR6q9Ytxb07O3sFeV/fB3fPl65PX6f/YCDT64sjXNLpKs7/tMV4
	 csqSTs/yy/7YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD0738119D3;
	Fri,  8 May 2026 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nsh: fix incorrect header length macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828001029.878212.17324064533437896394.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:10 +0000
References: <20260507120434.2962505-1-i.maximets@ovn.org>
In-Reply-To: <20260507120434.2962505-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jbenc@redhat.com, yi.y.yang@intel.com, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: E9BA94FC6E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286027-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 14:04:26 +0200 you wrote:
> NSH header length is a 6-bit field that encodes the total length of
> the header in 4-byte words.  So the maximum length is 0b111111 * 4,
> which is 252 and not 256.  The maximum context length is the same
> number minus the length of the base header (8), so 244.
> 
> These macros are used to validate push_nsh() action in openvswitch.
> Miscalculation here doesn't cause any real issues.  In the worst case
> the oversized context is truncated while building the header, so we'll
> construct and send a broken packet, which is not a big problem, as any
> receiver should validate the fields.  No invalid memory accesses will
> happen during the header push.  But we should fix the macros to reject
> the incorrect actions in the first place.
> 
> [...]

Here is the summary with links:
  - [net] net: nsh: fix incorrect header length macros
    https://git.kernel.org/netdev/net/c/f2ab4fd02777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



