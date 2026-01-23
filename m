Return-Path: <netdev+bounces-252616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLMrBZzfcmntqwAAu9opvQ
	(envelope-from <netdev+bounces-252616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB66FBD6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E57300D970
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FEF352920;
	Fri, 23 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeV2DyJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B22DC35C;
	Fri, 23 Jan 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136020; cv=none; b=g5Du4NfyfFjcmkX9oJttQccj95miIf0687IsGIgRpcQBX49psin5pM3LlJof20ZvuNqj8gbhEEKXUoK2XUMHA40nBEhuykBA5t0S/EEIB6Fkpn4/HiWttxW5Ye4QjjAMstVG7S7LBG8Y5O9qYjzUJpeWQ851Tw7wk2/4+G3hq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136020; c=relaxed/simple;
	bh=LPMrmE7FOUiCQzRZyCnm2hOa1OspDPEUnN64lGQR2VY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kINBeO5oWlT3WWrWaLK7Rhikky1DknbcS5DF8wWXwcchW/G3q5BtVtL/Q2BeO9QUSk8b5mpoioPKqWKYwDAK+0QkUMAume0kh/wA5s117lPOLxAchVDhPL/iIAI/rnnWngXO2P+L3VBd5PoTK2HK8jPeyK/UUkDTOpVrFfS0zhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeV2DyJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5058CC116C6;
	Fri, 23 Jan 2026 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769136018;
	bh=LPMrmE7FOUiCQzRZyCnm2hOa1OspDPEUnN64lGQR2VY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IeV2DyJSUWg+rYK3kxa/wadjs00KXDDYY2u2BUNQz/u2dZ68zDIDY0KaTh15uOwOK
	 ebQtGqeiqmEzsAV1XWE5u3TgjEDQ/8p85YKEjXPIP3tEqj7oIK/DRjFcJxgqRxh1tr
	 uh11Ey/82CxGlLQRPEuHffZRr7tmwNvDdsowtO3mEGy5pBw4JnT2s7lmg0/CMpvmZH
	 2yv0R2B+UF02XDx82eSIv4fzvd35PMjwef6t0q/Rce+Kl7XNNTFeAErVPi5vSy7/xW
	 TXmrFA8k3mX/snsk1HL+nlEAG5bJEzdSIjiHjhd3P3zlkQJUIA9Wrk4v0t6ZkYkxLW
	 JEwLyJSpbemzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CD83808200;
	Fri, 23 Jan 2026 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: Add kernel selftest for RFC
 4884
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176913601461.2368645.10878797221558228157.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 02:40:14 +0000
References: <20260121114644.2863640-1-danieller@nvidia.com>
In-Reply-To: <20260121114644.2863640-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, mlxsw@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252616-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80DB66FBD6
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 13:46:44 +0200 you wrote:
> RFC 4884 extended certain ICMP messages with a length attribute that
> encodes the length of the "original datagram" field. This is needed so
> that new information could be appended to these messages without
> applications thinking that it is part of the "original datagram" field.
> 
> In version 5.9, the kernel was extended with two new socket options
> (SOL_IP/IP_RECVERR_4884 and SOL_IPV6/IPV6_RECVERR_RFC4884) that allow
> user space to retrieve this length which is basically the offset to the
> ICMP Extension Structure at the end of the ICMP message. This is
> required by user space applications that need to parse the information
> contained in the ICMP Extension Structure. For example, the RFC 5837
> extension for tracepath.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: Add kernel selftest for RFC 4884
    https://git.kernel.org/netdev/net-next/c/d07d7c3dd944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



