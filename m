Return-Path: <netdev+bounces-286034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAs0Ie1o/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:51:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C14FC7C7
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37383046184
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE63A3825;
	Fri,  8 May 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td4VH4mx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF683A256C;
	Fri,  8 May 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280661; cv=none; b=VdRb+0UeroNMXDqpxVNy1plESU1vAeCX6CwyuW0MoFqDzsZZOcyfg3WcawsePjPql7WumveR+IEZE+6XIJEFMJlNg09wYyq6JQY0K8wBVErhbUPCSvV4ht6biSU/y/eovvRSvgs6OzQHoddSlG8tv9zdCogKUerwAW1M57sMuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280661; c=relaxed/simple;
	bh=l9vAPzM8X0DzfK2oHVVmF+NJ4qIFO/fJ9ervAmQxrE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsqpkacT+DK5AbuvP9xn1e03qm7UKd7OGIXK5trAqI4oXbXGXbAoUrr09iHbtQyCEKQZ1Xfkc+JPfRClXiY1sczk2U2EcGPD/ZGV/cMwYG6yg2xBltIwKQVdFtZwoqoaboTVO7Dq3fchj1Ims5eZaehuv5YBU3kgpmNYuRSZOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td4VH4mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E1C2BCB0;
	Fri,  8 May 2026 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280661;
	bh=l9vAPzM8X0DzfK2oHVVmF+NJ4qIFO/fJ9ervAmQxrE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=td4VH4mx+12j0T+l8UIabqh4VnvhI2nSuqME62UGjwME9aKkmqmaH8U+57m30iK9R
	 ktFDMRoPQI4/qIewsfhomyB7iCT/1uvX8+gnLauIOqo1GdHm3KKiqEIVggFI7CULlM
	 17Glq9S8XZMJGkh3DjKAFtXKxUMqalLStL04FG3P+dZlAnNnKZkrhYAq5FLS9uluYi
	 QehwFFacyW2q4Cu5Zy0Was+kjeQWI7+UT4PxgZQk3iUlAafscKCSrJ08INm+9hGUbJ
	 kdJIRwj+X5MGl1RLB9jGvQK+YUVdqmlKXN3hMHPn844TVz/+Gvw/H9hr851IVPkfR2
	 LxbI5AwmnEIyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDA38119D3;
	Fri,  8 May 2026 22:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gve: Use generic power management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828060954.880817.417904741851911675.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:50:09 +0000
References: <20260506165015.641738-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20260506165015.641738-1-vaibhavgupta40@gmail.com>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, nktgrg@google.com, thostet@google.com,
 alok.a.tiwari@oracle.com, jfraker@google.com, maolson@google.com,
 pkaligineedi@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com
X-Rspamd-Queue-Id: 1B3C14FC7C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286034-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:50:06 +0000 you wrote:
> Switch to the generic power management and remove the usage of legacy
> (pci_driver) hooks.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gve: Use generic power management
    https://git.kernel.org/netdev/net-next/c/e3c683c316f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



