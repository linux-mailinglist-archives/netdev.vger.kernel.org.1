Return-Path: <netdev+bounces-293961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBlhJ+M9HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C656627292
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18AAD3013A48
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99DD35677A;
	Tue,  2 Jun 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS2nuIrO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E633D4E5;
	Tue,  2 Jun 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366816; cv=none; b=mZMgyjDl3Y3AS4GAeOyWb94yBNEkv/hOoTcH5RKNQgUaIYh6p1jDm2G9qMUnAhhHIuLjg0SJ9yz4WJ0281zBbhZsjDvVgztkmCrbROLlm3RYhHLh/gWQd/JwdZylWdWnwF8C4RtF1aoB+rMXvzAlO34RE8Ks+Escw3hZygnyyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366816; c=relaxed/simple;
	bh=t5X+DRQWZC74WnCtGkg2zLQEyNu02H93v8vGBqwVsTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKEjn0BcU/vYHjPXbEYF8o4N6Le2Zw5JGPHKRPJVrSxIgwsHmPQw0oNN+YMzsoz4WAO0kEpH/c73XS9FVAXuK71xjyZCwDmfFwOD9DuSpIe8r/hD5Lo2IS3jaWZAR2EjC3SLB01zjnRajPqW2uGpcBAZvwpv6a3Y5uPm5xoKTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS2nuIrO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6647F1F00893;
	Tue,  2 Jun 2026 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366815;
	bh=bddfpdY48ZCl/6RBk7ol7UbnoFxHmpEvxDO054qNro8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OS2nuIrOSNWumlFBKV6fC9GitOUUW3Fi7uZZXN9wgHhk06LGn+eF0G8qubKXiRZiv
	 drrmgYJ1DE1ul/zQvbZ4vDisHewl0g+iC38hJJuSW+KmPf1qNR93cRBmz+ZagLQW3Y
	 ptea8RB5W7ZZZeOudR7gfNGO3rRzTOmVDodqVOxjVUWPE9R5tJ8Jkrtnt/0FNqQ5pP
	 BcQ0WO7Y5uCry5aUOXOXvuwv17kRHTTyE3YgYB47T6Jyk+/UFppLqlUgCaX1peIW4C
	 ugacpdCMxwMHnHf68O7rt/nXwtK2v0Pjaf40Np40LwwlEerZHYV9bB6/gICtFq73IU
	 RgssFdfrJw55w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BBB38119F9;
	Tue,  2 Jun 2026 02:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] mv88e6xxx: SERDES on mv88e6321
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036681764.209208.7159742822426422600.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:20:17 +0000
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
In-Reply-To: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293961-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C656627292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 23:03:07 +0200 you wrote:
> This patch series add code support to be able to use SERDES feature of
> mv88e6321 version of Marvel mv88e6xxx series. mv88e6321 has 2 ports to
> support high speed SERDES but the support is lacking in the driver.
> 
> mv88e6321 version has a similar architecture to mv88e6352 version making it
> possible to reuse its pcs functions. That's why the patch series consist of
> 2 parts:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] mv88e6xxx: Add mv88e6352_serdes_get_lane
    https://git.kernel.org/netdev/net-next/c/1a79978dd271
  - [net-next,v3,2/3] mv88e6xxx: Refactor 6352's serdes functions
    https://git.kernel.org/netdev/net-next/c/348a46c93e53
  - [net-next,v3,3/3] mv88e6xxx: Add SERDES Support for mv88e6321
    https://git.kernel.org/netdev/net-next/c/f456c9b936b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



