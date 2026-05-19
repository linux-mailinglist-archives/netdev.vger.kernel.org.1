Return-Path: <netdev+bounces-289438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QORpK21SDGqmfAUAu9opvQ
	(envelope-from <netdev+bounces-289438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2457E4F8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B985301E5A4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C14ADD92;
	Tue, 19 May 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnGuhiUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC93F1AC9;
	Tue, 19 May 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192000; cv=none; b=m9PH+BH1ogD4kg9+GI9zLM91F7asd8O5syZCGkG+OtWFJOooKIfU26TiUjkJ5Zm0J79AWQrs2cUC9rWk6qUMgWljnMqRgpfetFQKGv24NPKU8DsyigsFRyCMXbEvsJCaaoGnstnh/xqeUHJh8PDScdKx7B+iCEjZyA7sxTvZSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192000; c=relaxed/simple;
	bh=BQYO2E0fCS6BfmWFZ53yCqwLNUJKTRPaHcDO54bhAEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZW9WMurWSIVnyBAQt7yY6j5cvdxrKePhB1WWp4uee0b+bhT6CWYPh8BptnMoRBVV+n4U/c5ZPOI9zCreCkplUlKSV4uzg8nQEB/QLbf6AZbEmUnlIHqc1Im5Zr5COcD+jsJJidSqTPLT/OYxfk0bxKzZmmIu3eId+QlZ2bTvWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnGuhiUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11CEC2BCB8;
	Tue, 19 May 2026 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779191999;
	bh=BQYO2E0fCS6BfmWFZ53yCqwLNUJKTRPaHcDO54bhAEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QnGuhiUy27lcqwgLo6qLrKYYEr6uXxZihSBxno90wr94A+08dTjKEIief6gVIezX+
	 bUVwNfqJyPgmrGyoH4nGrjuEkBiDw8UF9li9WJ9xnGLPqkGRmoKqEbCzriCOspux4j
	 yO7z4Gpt9toK07e3vAKEHXJkdr01+Lltx/hytLS5BM/MKwCjHh4vHvpinnpwV1HB48
	 YxEp1gCfIwA1j80G0PuxIC/r2D+ZRWnHeSuP0Vi0GIAFkpZ0I5yTbT2EbvvvtJZN2s
	 faIQx12RvxQpg9OPr0lc9ovXxMzLuFosTIPs0rZ2OhyWB9mfSJJ2ElIcR6HagJUckD
	 O9Q8D9IushXeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A753930E0C;
	Tue, 19 May 2026 12:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] selftests: ovpn: reduce remaining ping flood
 counts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177919201064.2269262.14959859828316127571.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 12:00:10 +0000
References: <20260514231544.795993-2-antonio@openvpn.net>
In-Reply-To: <20260514231544.795993-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, ralf@mandelbit.com, linux-kselftest@vger.kernel.org,
 horms@kernel.org, shuah@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289438-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mandelbit.com:email]
X-Rspamd-Queue-Id: E6D2457E4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Fri, 15 May 2026 01:15:40 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Commit 201ba706318d ("selftests: ovpn: reduce ping count in test.sh")
> lowered the baseline traffic flood ping count to avoid flakes on slower
> CI instances, however some instances were left out.
> 
> Apply the same limit to the remaining ovpn selftest flood pings that
> still request 500 packets.
> 
> [...]

Here is the summary with links:
  - [net,1/5] selftests: ovpn: reduce remaining ping flood counts
    https://git.kernel.org/netdev/net/c/7f1144977846
  - [net,2/5] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
    https://git.kernel.org/netdev/net/c/775d8d7ad02a
  - [net,3/5] ovpn: respect peer refcount in CMD_NEW_PEER error path
    https://git.kernel.org/netdev/net/c/1fef6614673f
  - [net,4/5] ovpn: fix race between deleting interface and adding new peer
    https://git.kernel.org/netdev/net/c/982422b11e6f
  - [net,5/5] ovpn: disable BHs when updating device stats
    https://git.kernel.org/netdev/net/c/0c0dddc07d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



